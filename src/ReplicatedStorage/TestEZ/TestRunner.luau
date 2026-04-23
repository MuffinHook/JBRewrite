local TestEnum = require(script.Parent.TestEnum)
local TestSession = require(script.Parent.TestSession)
local LifecycleHooks = require(script.Parent.LifecycleHooks)
local t = {
	environment = {}
}
local function wrapExpectContextWithPublicApi(p1) --[[ Line: 19 ]]
	local t = {
		extend = function(...) --[[ Name: extend | Line: 21 | Upvalues: p1 (copy) ]]
			p1:extend(...)
		end
	}
	return setmetatable(t, {
		__call = function(p12, ...) --[[ Name: __call | Line: 25 | Upvalues: p1 (copy) ]]
			return p1:startExpectationChain(...)
		end
	})
end
function t.runPlan(p1) --[[ Line: 35 | Upvalues: TestSession (copy), LifecycleHooks (copy), TestEnum (copy), t (copy) ]]
	local v1 = TestSession.new(p1)
	local v2 = LifecycleHooks.new()
	v1.hasFocusNodes = #p1:findNodes(function(p1) --[[ Line: 39 | Upvalues: TestEnum (ref) ]]
		return p1.modifier == TestEnum.NodeModifier.Focus
	end) > 0
	t.runPlanNode(v1, p1, v2)
	return v1:finalize()
end
function t.runPlanNode(p1, p2, p3) --[[ Line: 54 | Upvalues: t (copy), wrapExpectContextWithPublicApi (copy), TestEnum (copy) ]]
	local function runCallback(p12, p2) --[[ Line: 55 | Upvalues: t (ref), wrapExpectContextWithPublicApi (ref), p1 (copy) ]]
		_G.__TESTEZ_RUNNING_TEST__ = true
		local v1 = getfenv(p12)
		local v2 = true
		local v3 = nil
		local v4 = p2 or ""
		for k, v in pairs(t.environment) do
			v1[k] = v
		end
		function v1.fail(p1) --[[ Line: 71 | Upvalues: v2 (ref), v3 (ref), v4 (ref) ]]
			if p1 == nil then
				p1 = "fail() was called."
			end
			v2 = false
			v3 = v4 .. debug.traceback(tostring(p1), 2)
		end
		v1.expect = wrapExpectContextWithPublicApi(p1:getExpectationContext())
		local v5 = p1:getContext()
		local v6, v7 = xpcall(function() --[[ Line: 85 | Upvalues: p12 (copy), v5 (copy) ]]
			p12(v5)
		end, function(p1) --[[ Line: 88 | Upvalues: v4 (ref) ]]
			return v4 .. debug.traceback(tostring(p1), 2)
		end)
		if not v6 then
			v2 = false
			v3 = v7
		end
		_G.__TESTEZ_RUNNING_TEST__ = nil
		return v2, v3
	end
	local function runNode(p1) --[[ Line: 105 | Upvalues: p3 (copy), runCallback (copy) ]]
		for i, v in ipairs(p3:getBeforeEachHooks()) do
			local v1, v2 = runCallback(v, "beforeEach hook: ")
			if not v1 then
				return false, v2
			end
		end
		local v3, v4 = runCallback(p1.callback)
		for i, v in ipairs(p3:getAfterEachHooks()) do
			local v5, v6 = runCallback(v, "afterEach hook: ")
			if not v5 and v3 then
				return false, v6
			elseif not v5 then
				return false, v4 .. "\nWhile cleaning up the failed test another error was found:\n" .. v6
			end
		end
		if v3 then
			return true, nil
		else
			return false, v4
		end
	end
	p3:pushHooksFrom(p2)
	local v1 = false
	for i, v in ipairs(p3:getBeforeAllHooks()) do
		local v2, v3 = runCallback(v, "beforeAll hook: ")
		if not v2 then
			p1:addDummyError("beforeAll", v3)
			v1 = true
		end
	end
	if not v1 then
		for i, v in ipairs(p2.children) do
			if v.type == TestEnum.NodeType.It then
				p1:pushNode(v)
				if p1:shouldSkip() then
					p1:setSkipped()
				else
					local v4, v5 = runNode(v)
					if v4 then
						p1:setSuccess()
					else
						p1:setError(v5)
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