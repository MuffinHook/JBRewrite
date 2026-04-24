-- Reviewed by Claude
return function()
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local GlobalConfig = require(script.Parent.Parent.GlobalConfig)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local Component = require(script.Parent.Parent.Component)
	local v1 = createReconciler(NoopRenderer)
	it("should return stack traces in initial renders", function()
		local v12 = Component:extend("TestComponent")
		local v2 = nil
		function v12.init(p1)
			v2 = p1:getElementTraceback()
		end
		function v12.render(p1)
			return nil
		end
		GlobalConfig.scoped({
			elementTracing = true
		}, function()
			v1.mountVirtualNode(createElement(v12), nil, "Some key")
		end)
		expect(v2).to.be.a("string")
	end)
	itSKIP("it should return an updated stack trace after an update", function()  end)
	it("should return nil when elementTracing is off", function()
		local v12 = nil
		local v2 = Component:extend("TestComponent")
		function v2.init(p1)
			v12 = p1:getElementTraceback()
		end
		function v2.render(p1)
			return nil
		end
		GlobalConfig.scoped({
			elementTracing = false
		}, function()
			v1.mountVirtualNode(createElement(v2), nil, "Some key")
		end)
		expect(v12).to.equal(nil)
	end)
end
