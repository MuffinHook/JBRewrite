-- Reviewed by Claude
-- variables reassigned
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
	local instance = TestSession.new(p1)
	local instance2 = LifecycleHooks.new()
	instance.hasFocusNodes = #p1:findNodes(function(p1)
		return p1.modifier == TestEnum.NodeModifier.Focus
	end) > 0
	t.runPlanNode(instance, p1, instance2)
	return instance:finalize()
end
function t.runPlanNode(p1, p2, p3)
	local function runCallback(p12, p2)
		_G.__TESTEZ_RUNNING_TEST__ = true
		local instance = getfenv(p12)
		local instance2 = true
		local var3 = nil
		local var4 = p2 or ""
		for k, v in pairs(t.environment) do
			instance[k] = v
		end
		function instance.fail(p1)
			if p1 == nil then
				p1 = "fail() was called."
			end
			instance2 = false
			var3 = var4 .. debug.traceback(tostring(p1), 2)
		end
		instance.expect = wrapExpectContextWithPublicApi(p1:getExpectationContext())
		local var5 = p1:getContext()
		local v6, v7 = xpcall(function()
			p12(var5)
		end, function(p1)
			return var4 .. debug.traceback(tostring(p1), 2)
		end)
		if not v6 then
			instance2 = false
			var3 = v7
		end
		_G.__TESTEZ_RUNNING_TEST__ = nil
		return instance2, var3
	end
	local function runNode(p1)
		for i, v in ipairs(p3:getBeforeEachHooks()) do
			local instance, instance2 = runCallback(v, "beforeEach hook: ")
			if not instance then
				return false, instance2
			end
		end
		local var3, var4 = runCallback(p1.callback)
		for i, v in ipairs(p3:getAfterEachHooks()) do
			local var5, v6 = runCallback(v, "afterEach hook: ")
			if not var5 and var3 then
				return false, v6
			elseif not var5 then
				return false, var4 .. "\nWhile cleaning up the failed test another error was found:\n" .. v6
			end
		end
		if var3 then
			return true, nil
		else
			return false, var4
		end
	end
	p3:pushHooksFrom(p2)
	local instance = false
	for i, v in ipairs(p3:getBeforeAllHooks()) do
		local instance2, var3 = runCallback(v, "beforeAll hook: ")
		if not instance2 then
			p1:addDummyError("beforeAll", var3)
			instance = true
		end
	end
	if not instance then
		for i, v in ipairs(p2.children) do
			if v.type == TestEnum.NodeType.It then
				p1:pushNode(v)
				if p1:shouldSkip() then
					p1:setSkipped()
				else
					local var4, var5 = runNode(v)
					if var4 then
						p1:setSuccess()
					else
						p1:setError(var5)
					end
				end
				p1:popNode()
			elseif v.type == TestEnum.NodeType.Describe then
				p1:pushNode(v)
				t.runPlanNode(p1, v, p3)
				if v.loadError then
					p1:setError("Error during planning: " .. v.loadError)
				else
					p1:setStatusFromChildren()
				end
				p1:popNode()
			end
		end
	end
	for i, v in ipairs(p3:getAfterAllHooks()) do
		local v6, v7 = runCallback(v, "afterAll hook: ")
		if not v6 then
			p1:addDummyError("afterAll", v7)
		end
	end
	p3:popHooks()
end
return t
