-- Reviewed by Claude
-- variables reassigned
return function()
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local createSpy = require(script.Parent.Parent.createSpy)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local Type = require(script.Parent.Parent.Type)
	local Component = require(script.Parent.Parent.Component)
	local var1 = createReconciler(NoopRenderer)
	it("should be invoked when mounted", function()
		local internalData = Component:extend("MyComponent")
		local state2 = createSpy()
		internalData.didMount = state2.value
		function internalData.render(self)
			return nil
		end
		var1.mountVirtualNode(createElement(internalData), nil, "Test")
		expect(state2.callCount).to.equal(1)
		expect(Type.of(state2:captureValues("self").self)).to.equal(Type.StatefulComponentInstance)
	end)
end
