local TestEnum = require(script.Parent.TestEnum)
local Expectation = require(script.Parent.Expectation)
local function newEnvironment(plan, extraEnvironment)
	local environment = {}
	if extraEnvironment then
		if type(extraEnvironment) ~= "table" then
			error(("Bad argument #2 to newEnvironment. Expected table, got %s"):format((typeof(extraEnvironment))), 2)
		end
		for k, v in pairs(extraEnvironment) do
			environment[k] = v
		end
	end
	local function addChild(name, callback, nodeType, nodeModifier)
		local newNode = plan:addChild(name, nodeType, nodeModifier)
		newNode.callback = callback
		if nodeType == TestEnum.NodeType.Describe then
			newNode:expand()
		end
		return newNode
	end
	function environment.describeFOCUS(phrase, callback)
		addChild(phrase, callback, TestEnum.NodeType.Describe, TestEnum.NodeModifier.Focus)
	end
	function environment.describeSKIP(phrase, callback)
		addChild(phrase, callback, TestEnum.NodeType.Describe, TestEnum.NodeModifier.Skip)
	end
	function environment.describe(phrase, callback, p3)
		addChild(phrase, callback, TestEnum.NodeType.Describe, TestEnum.NodeModifier.None)
	end
	function environment.itFOCUS(phrase, callback)
		addChild(phrase, callback, TestEnum.NodeType.It, TestEnum.NodeModifier.Focus)
	end
	function environment.itSKIP(phrase, callback)
		addChild(phrase, callback, TestEnum.NodeType.It, TestEnum.NodeModifier.Skip)
	end
	function environment.itFIXME(phrase, callback)
		warn("FIXME: broken test", addChild(phrase, callback, TestEnum.NodeType.It, TestEnum.NodeModifier.Skip):getFullName())
	end
	function environment.it(phrase, callback, p3)
		addChild(phrase, callback, TestEnum.NodeType.It, TestEnum.NodeModifier.None)
	end
	local hookCounter = 0
	for hookType, hookName in pairs({
		[TestEnum.NodeType.BeforeAll] = "beforeAll",
		[TestEnum.NodeType.AfterAll] = "afterAll",
		[TestEnum.NodeType.BeforeEach] = "beforeEach",
		[TestEnum.NodeType.AfterEach] = "afterEach"
	}) do
		environment[hookName] = function(callback)
			addChild(hookName .. "_" .. tostring(hookCounter), callback, hookType, TestEnum.NodeModifier.None)
			hookCounter = hookCounter + 1
		end
	end
	function environment.FIXME(message)
		warn("FIXME: broken test", plan:getFullName(), message or "")
		plan.modifier = TestEnum.NodeModifier.Skip
	end
	function environment.FOCUS()
		plan.modifier = TestEnum.NodeModifier.Focus
	end
	function environment.SKIP()
		plan.modifier = TestEnum.NodeModifier.Skip
	end
	function environment.HACK_NO_XPCALL()
		warn("HACK_NO_XPCALL is deprecated. It is now safe to yield in an xpcall, so this is no longer necessary. It can be safely deleted.")
	end
	environment.fit = environment.itFOCUS
	environment.xit = environment.itSKIP
	environment.fdescribe = environment.describeFOCUS
	environment.xdescribe = environment.describeSKIP
	local expectMetatable = {
		extend = function(...)
			error("Cannot call \"expect.extend\" from within a \"describe\" node.")
		end
	}
	environment.expect = setmetatable(expectMetatable, {
		__call = function(self, ...)
			return Expectation.new(...)
		end
	})
	return environment
end
local TestNode = {}
TestNode.__index = TestNode
function TestNode.new(plan, phrase, nodeType, nodeModifier)
	local nodeInstance = {
		plan = plan,
		phrase = phrase,
		type = nodeType,
		modifier = nodeModifier or TestEnum.NodeModifier.None,
		children = {},
		callback = nil,
		parent = nil
	}
	nodeInstance.environment = newEnvironment(nodeInstance, plan.extraEnvironment)
	return setmetatable(nodeInstance, TestNode)
end
local function getModifier(fullName, testNamePattern, nodeModifier)
	if testNamePattern and (nodeModifier == nil or nodeModifier == TestEnum.NodeModifier.None) then
		if fullName:match(testNamePattern) then
			return TestEnum.NodeModifier.Focus
		else
			return TestEnum.NodeModifier.Skip
		end
	else
		return nodeModifier
	end
end
function TestNode.addChild(parentNode, phrase, nodeType, nodeModifier)
	if nodeType == TestEnum.NodeType.It then
		for k, v in pairs(parentNode.children) do
			if v.phrase == phrase then
				error("Duplicate it block found: " .. v:getFullName())
			end
		end
	end
	local childNode = TestNode.new(parentNode.plan, phrase, nodeType, (getModifier(parentNode:getFullName() .. " " .. phrase, parentNode.plan.testNamePattern, nodeModifier)))
	childNode.parent = parentNode
	table.insert(parentNode.children, childNode)
	return childNode
end
function TestNode.getFullName(node)
	if node.parent then
		local parentFullName = node.parent:getFullName()
		if parentFullName then
			return parentFullName .. " " .. node.phrase
		else
			return node.phrase
		end
	else
		return node.phrase
	end
end
function TestNode.expand(node)
	local callbackEnv = getfenv(node.callback)
	local newEnv = setmetatable({}, {
		__index = callbackEnv
	})
	for k, v in pairs(node.environment) do
		newEnv[k] = v
	end
	newEnv.script = callbackEnv.script
	setfenv(node.callback, newEnv)
	local success, errorMessage = xpcall(node.callback, function(errorValue)
		return debug.traceback(tostring(errorValue), 2)
	end)
	if not success then
		node.loadError = errorMessage
	end
end
local TestPlan = {}
TestPlan.__index = TestPlan
function TestPlan.new(testNamePattern, extraEnvironment)
	return setmetatable({
		children = {},
		testNamePattern = testNamePattern,
		extraEnvironment = extraEnvironment
	}, TestPlan)
end
function TestPlan.addChild(rootNode, phrase, nodeType, nodeModifier)
	local childNode = TestNode.new(rootNode, phrase, nodeType, (getModifier(phrase, rootNode.testNamePattern, nodeModifier)))
	table.insert(rootNode.children, childNode)
	return childNode
end
function TestPlan.addRoot(rootNode, pathArray, callback)
	local currentNode = rootNode
	for i = #pathArray, 1, -1 do
		local childNode = nil
		for i2, v in ipairs(currentNode.children) do
			if v.phrase == pathArray[i] then
				childNode = v
				break
			end
		end
		if childNode == nil then
			childNode = currentNode:addChild(pathArray[i], TestEnum.NodeType.Describe)
		end
		currentNode = childNode
	end
	currentNode.callback = callback
	currentNode:expand()
end
function TestPlan.visitAllNodes(plan, callback, node, depth)
	local currentDepth = depth or 0
	for i, v in ipairs((node or plan).children) do
		callback(v, currentDepth)
		plan:visitAllNodes(callback, v, currentDepth + 1)
	end
end
function TestPlan.visualize(plan)
	local lines = {}
	plan:visitAllNodes(function(node, depth)
		table.insert(lines, (" "):rep(3 * depth) .. node.phrase)
	end)
	return table.concat(lines, "\n")
end
function TestPlan.findNodes(plan, predicate)
	local results = {}
	plan:visitAllNodes(function(node)
		if predicate(node) then
			table.insert(results, node)
		end
	end)
	return results
end
return TestPlan
