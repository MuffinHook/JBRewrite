return function() --[[ Line: 1 ]]
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local GlobalConfig = require(script.Parent.Parent.GlobalConfig)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local Component = require(script.Parent.Parent.Component)
	local v1 = createReconciler(NoopRenderer)
	it("should return stack traces in initial renders", function() --[[ Line: 11 | Upvalues: Component (copy), GlobalConfig (copy), createElement (copy), v1 (copy) ]]
		local v12 = Component:extend("TestComponent")
		local v2 = nil
		function v12.init(p1) --[[ Line: 15 | Upvalues: v2 (ref) ]]
			v2 = p1:getElementTraceback()
		end
		function v12.render(p1) --[[ Line: 19 ]]
			return nil
		end
		GlobalConfig.scoped({
			elementTracing = true
		}, function() --[[ Line: 27 | Upvalues: createElement (ref), v12 (copy), v1 (ref) ]]
			v1.mountVirtualNode(createElement(v12), nil, "Some key")
		end)
		expect(v2).to.be.a("string")
	end)
	itSKIP("it should return an updated stack trace after an update", function() --[[ Line: 38 ]] end)
	it("should return nil when elementTracing is off", function() --[[ Line: 40 | Upvalues: Component (copy), GlobalConfig (copy), createElement (copy), v1 (copy) ]]
		local v12 = nil
		local v2 = Component:extend("TestComponent")
		function v2.init(p1) --[[ Line: 49 | Upvalues: v12 (ref) ]]
			v12 = p1:getElementTraceback()
		end
		function v2.render(p1) --[[ Line: 53 ]]
			return nil
		end
		GlobalConfig.scoped({
			elementTracing = false
		}, function() --[[ Line: 57 | Upvalues: createElement (ref), v2 (copy), v1 (ref) ]]
			v1.mountVirtualNode(createElement(v2), nil, "Some key")
		end)
		expect(v12).to.equal(nil)
	end)
end