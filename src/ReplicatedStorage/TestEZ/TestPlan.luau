local TestEnum = require(script.Parent.TestEnum)
local Expectation = require(script.Parent.Expectation)
local function newEnvironment(p1, p2) --[[ Line: 11 | Upvalues: TestEnum (copy), Expectation (copy) ]]
	local t = {}
	if p2 then
		if type(p2) ~= "table" then
			error(("Bad argument #2 to newEnvironment. Expected table, got %s"):format((typeof(p2))), 2)
		end
		for k, v in pairs(p2) do
			t[k] = v
		end
	end
	local function addChild(p12, p2, p3, p4) --[[ Line: 25 | Upvalues: p1 (copy), TestEnum (ref) ]]
		local v1 = p1:addChild(p12, p3, p4)
		v1.callback = p2
		if p3 == TestEnum.NodeType.Describe then
			v1:expand()
		end
		return v1
	end
	function t.describeFOCUS(p1, p2) --[[ Line: 34 | Upvalues: addChild (copy), TestEnum (ref) ]]
		addChild(p1, p2, TestEnum.NodeType.Describe, TestEnum.NodeModifier.Focus)
	end
	function t.describeSKIP(p1, p2) --[[ Line: 38 | Upvalues: addChild (copy), TestEnum (ref) ]]
		addChild(p1, p2, TestEnum.NodeType.Describe, TestEnum.NodeModifier.Skip)
	end
	function t.describe(p1, p2, p3) --[[ Line: 42 | Upvalues: addChild (copy), TestEnum (ref) ]]
		addChild(p1, p2, TestEnum.NodeType.Describe, TestEnum.NodeModifier.None)
	end
	function t.itFOCUS(p1, p2) --[[ Line: 46 | Upvalues: addChild (copy), TestEnum (ref) ]]
		addChild(p1, p2, TestEnum.NodeType.It, TestEnum.NodeModifier.Focus)
	end
	function t.itSKIP(p1, p2) --[[ Line: 50 | Upvalues: addChild (copy), TestEnum (ref) ]]
		addChild(p1, p2, TestEnum.NodeType.It, TestEnum.NodeModifier.Skip)
	end
	function t.itFIXME(p1, p2) --[[ Line: 54 | Upvalues: addChild (copy), TestEnum (ref) ]]
		warn("FIXME: broken test", addChild(p1, p2, TestEnum.NodeType.It, TestEnum.NodeModifier.Skip):getFullName())
	end
	function t.it(p1, p2, p3) --[[ Line: 59 | Upvalues: addChild (copy), TestEnum (ref) ]]
		addChild(p1, p2, TestEnum.NodeType.It, TestEnum.NodeModifier.None)
	end
	local v1 = 0
	for k, v in pairs({
		[TestEnum.NodeType.BeforeAll] = "beforeAll",
		[TestEnum.NodeType.AfterAll] = "afterAll",
		[TestEnum.NodeType.BeforeEach] = "beforeEach",
		[TestEnum.NodeType.AfterEach] = "afterEach"
	}) do
		t[v] = function(p1) --[[ Line: 74 | Upvalues: addChild (copy), v (copy), v1 (ref), k (copy), TestEnum (ref) ]]
			addChild(v .. "_" .. tostring(v1), p1, k, TestEnum.NodeModifier.None)
			v1 = v1 + 1
		end
	end
	function t.FIXME(p12) --[[ Line: 80 | Upvalues: p1 (copy), TestEnum (ref) ]]
		warn("FIXME: broken test", p1:getFullName(), p12 or "")
		p1.modifier = TestEnum.NodeModifier.Skip
	end
	function t.FOCUS() --[[ Line: 86 | Upvalues: p1 (copy), TestEnum (ref) ]]
		p1.modifier = TestEnum.NodeModifier.Focus
	end
	function t.SKIP() --[[ Line: 90 | Upvalues: p1 (copy), TestEnum (ref) ]]
		p1.modifier = TestEnum.NodeModifier.Skip
	end
	function t.HACK_NO_XPCALL() --[[ Line: 98 ]]
		warn("HACK_NO_XPCALL is deprecated. It is now safe to yield in an xpcall, so this is no longer necessary. It can be safely deleted.")
	end
	t.fit = t.itFOCUS
	t.xit = t.itSKIP
	t.fdescribe = t.describeFOCUS
	t.xdescribe = t.describeSKIP
	local t2 = {
		extend = function(...) --[[ Name: extend | Line: 109 ]]
			error("Cannot call \"expect.extend\" from within a \"describe\" node.")
		end
	}
	t.expect = setmetatable(t2, {
		__call = function(p1, ...) --[[ Name: __call | Line: 113 | Upvalues: Expectation (ref) ]]
			return Expectation.new(...)
		end
	})
	return t
end
local t = {}
t.__index = t
function t.new(p1, p2, p3, p4) --[[ Line: 129 | Upvalues: TestEnum (copy), newEnvironment (copy), t (copy) ]]
	local t2 = {
		plan = p1,
		phrase = p2,
		type = p3,
		modifier = p4 or TestEnum.NodeModifier.None,
		children = {},
		callback = nil,
		parent = nil
	}
	t2.environment = newEnvironment(t2, p1.extraEnvironment)
	return setmetatable(t2, t)
end
local function getModifier(p1, p2, p3) --[[ Line: 146 | Upvalues: TestEnum (copy) ]]
	if p2 and (p3 == nil or p3 == TestEnum.NodeModifier.None) then
		if p1:match(p2) then
			return TestEnum.NodeModifier.Focus
		else
			return TestEnum.NodeModifier.Skip
		end
	else
		return p3
	end
end
function t.addChild(p1, p2, p3, p4) --[[ Line: 157 | Upvalues: TestEnum (copy), getModifier (copy), t (copy) ]]
	if p3 == TestEnum.NodeType.It then
		for k, v in pairs(p1.children) do
			if v.phrase == p2 then
				error("Duplicate it block found: " .. v:getFullName())
			end
		end
	end
	local v2 = t.new(p1.plan, p2, p3, (getModifier(p1:getFullName() .. " " .. p2, p1.plan.testNamePattern, p4)))
	v2.parent = p1
	table.insert(p1.children, v2)
	return v2
end
function t.getFullName(p1) --[[ Line: 177 ]]
	if p1.parent then
		local v1 = p1.parent:getFullName()
		if v1 then
			return v1 .. " " .. p1.phrase
		else
			return p1.phrase
		end
	else
		return p1.phrase
	end
end
function t.expand(p1) --[[ Line: 191 ]]
	local v1 = getfenv(p1.callback)
	local v2 = setmetatable({}, {
		__index = v1
	})
	for k, v in pairs(p1.environment) do
		v2[k] = v
	end
	v2.script = v1.script
	setfenv(p1.callback, v2)
	local v3, v4 = xpcall(p1.callback, function(p1) --[[ Line: 202 ]]
		return debug.traceback(tostring(p1), 2)
	end)
	if not v3 then
		p1.loadError = v4
	end
end
local t2 = {}
t2.__index = t2
function t2.new(p1, p2) --[[ Line: 217 | Upvalues: t2 (copy) ]]
	return setmetatable({
		children = {},
		testNamePattern = p1,
		extraEnvironment = p2
	}, t2)
end
function t2.addChild(p1, p2, p3, p4) --[[ Line: 230 | Upvalues: getModifier (copy), t (copy) ]]
	local v2 = t.new(p1, p2, p3, (getModifier(p2, p1.testNamePattern, p4)))
	table.insert(p1.children, v2)
	return v2
end
function t2.addRoot(p1, p2, p3) --[[ Line: 241 | Upvalues: TestEnum (copy) ]]
	local v1 = p1
	for i = #p2, 1, -1 do
		local v2 = nil
		for i2, v in ipairs(v1.children) do
			if v.phrase == p2[i] then
				v2 = v
				break
			end
		end
		if v2 == nil then
			v2 = v1:addChild(p2[i], TestEnum.NodeType.Describe)
		end
		v1 = v2
	end
	v1.callback = p3
	v1:expand()
end
function t2.visitAllNodes(p1, p2, p3, p4) --[[ Line: 267 ]]
	local v1 = p4 or 0
	for i, v in ipairs((p3 or p1).children) do
		p2(v, v1)
		p1:visitAllNodes(p2, v, v1 + 1)
	end
end
function t2.visualize(p1) --[[ Line: 282 ]]
	local t = {}
	p1:visitAllNodes(function(p1, p2) --[[ Line: 284 | Upvalues: t (copy) ]]
		table.insert(t, (" "):rep(3 * p2) .. p1.phrase)
	end)
	return table.concat(t, "\n")
end
function t2.findNodes(p1, p2) --[[ Line: 294 ]]
	local t = {}
	p1:visitAllNodes(function(p1) --[[ Line: 296 | Upvalues: p2 (copy), t (copy) ]]
		if p2(p1) then
			table.insert(t, p1)
		end
	end)
	return t
end
return t2