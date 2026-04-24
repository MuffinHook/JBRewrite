-- Reviewed by Claude
-- variables reassigned
return function()
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local GlobalConfig = require(script.Parent.Parent.GlobalConfig)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local Component = require(script.Parent.Parent.Component)
	local key = createReconciler(NoopRenderer)
	it("should return stack traces in initial renders", function()
		local internalData = Component:extend("TestComponent")
		local var2 = nil
		function internalData.init(self)
			var2 = self:getElementTraceback()
		end
		function internalData.render(self)
			return nil
		end
		GlobalConfig.scoped({
			elementTracing = true
		}, function()
			key.mountVirtualNode(createElement(internalData), nil, "Some key")
		end)
		expect(var2).to.be.a("string")
	end)
	itSKIP("it should return an updated stack trace after an update", function()  end)
	it("should return nil when elementTracing is off", function()
		local internalData = nil
		local var2 = Component:extend("TestComponent")
		function var2.init(self)
			internalData = self:getElementTraceback()
		end
		function var2.render(self)
			return nil
		end
		GlobalConfig.scoped({
			elementTracing = false
		}, function()
			key.mountVirtualNode(createElement(var2), nil, "Some key")
		end)
		expect(internalData).to.equal(nil)
	end)
end
