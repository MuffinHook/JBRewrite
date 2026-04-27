local TestEnum = require(script.Parent.TestEnum)
local TestSession = require(script.Parent.TestSession)
local LifecycleHooks = require(script.Parent.LifecycleHooks)
local testRunnerModule = {
	environment = {}
}
local function wrapExpectContextWithPublicApi(expectationContext)
	local wrappedContext = {
		extend = function(...)
			expectationContext:extend(...)
		end
	}
	return setmetatable(wrappedContext, {
		__call = function(self, ...)
			return expectationContext:startExpectationChain(...)
		end
	})
end
function testRunnerModule.runPlan(plan)
	local testSession = TestSession.new(plan)
	local hooksManager = LifecycleHooks.new()
	testSession.hasFocusNodes = #plan:findNodes(function(node)
		return node.modifier == TestEnum.NodeModifier.Focus
	end) > 0
	testRunnerModule.runPlanNode(testSession, plan, hooksManager)
	return testSession:finalize()
end
function testRunnerModule.runPlanNode(testRunner, planNode, lifecycleHooks)
	local function runCallback(callback, errorPrefix)
		_G.__TESTEZ_RUNNING_TEST__ = true
		local instance = getfenv(callback)
		local testPassed = true
		local errorTrace = nil
		local errorPrefixBase = errorPrefix or ""
		for key, environmentValue in pairs(testRunnerModule.environment) do
			instance[key] = environmentValue
		end
		function instance.fail(failMessage)
			if failMessage == nil then
				failMessage = "fail() was called."
			end
			testPassed = false
			errorTrace = errorPrefixBase .. debug.traceback(tostring(failMessage), 2)
		end
		instance.expect = wrapExpectContextWithPublicApi(planNode:getExpectationContext())
		local nodeContext = planNode:getContext()
		local callSucceeded, callError = xpcall(function()
			callback(nodeContext)
		end, function(errorMsg)
			return errorPrefixBase .. debug.traceback(tostring(errorMsg), 2)
		end)
		if not callSucceeded then
			testPassed = false
			errorTrace = callError
		end
		_G.__TESTEZ_RUNNING_TEST__ = nil
		return testPassed, errorTrace
	end
	local function runNode(testNode)
		for i, hook in ipairs(lifecycleHooks:getBeforeEachHooks()) do
			local nodeSucceeded, nodeError = runCallback(hook, "beforeEach hook: ")
			if not nodeSucceeded then
				return false, nodeError
			end
		end
		local testSucceeded, testError = runCallback(testNode.callback)
		for i, hook in ipairs(lifecycleHooks:getAfterEachHooks()) do
			local afterEachSucceeded, afterEachError = runCallback(hook, "afterEach hook: ")
			if not afterEachSucceeded and testSucceeded then
				return false, afterEachError
			elseif not afterEachSucceeded then
				return false, testError .. "\nWhile cleaning up the failed test another error was found:\n" .. afterEachError
			end
		end
		if testSucceeded then
			return true, nil
		else
			return false, testError
		end
	end
	lifecycleHooks:pushHooksFrom(planNode)
	local hasBeforeAllError = false
	for i, hook in ipairs(lifecycleHooks:getBeforeAllHooks()) do
		local beforeAllSucceeded, beforeAllError = runCallback(hook, "beforeAll hook: ")
		if not beforeAllSucceeded then
			testRunner:addDummyError("beforeAll", beforeAllError)
			hasBeforeAllError = true
		end
	end
	if not hasBeforeAllError then
		for i, child in ipairs(planNode.children) do
			if child.type == TestEnum.NodeType.It then
				testRunner:pushNode(child)
				if testRunner:shouldSkip() then
					testRunner:setSkipped()
				else
					local testNodeSucceeded, testNodeError = runNode(child)
					if testNodeSucceeded then
						testRunner:setSuccess()
					else
						testRunner:setError(testNodeError)
					end
				end
				testRunner:popNode()
			elseif child.type == TestEnum.NodeType.Describe then
				testRunner:pushNode(child)
				testRunnerModule.runPlanNode(testRunner, child, lifecycleHooks)
				if child.loadError then
					testRunner:setError("Error during planning: " .. child.loadError)
				else
					testRunner:setStatusFromChildren()
				end
				testRunner:popNode()
			end
		end
	end
	for i, hook in ipairs(lifecycleHooks:getAfterAllHooks()) do
		local afterAllSucceeded, afterAllError = runCallback(hook, "afterAll hook: ")
		if not afterAllSucceeded then
			testRunner:addDummyError("afterAll", afterAllError)
		end
	end
	lifecycleHooks:popHooks()
end
return testRunnerModule
