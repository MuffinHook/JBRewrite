-- Reviewed by Claude
return function()
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local createSpy = require(script.Parent.Parent.createSpy)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local Type = require(script.Parent.Parent.Type)
	local Component = require(script.Parent.Parent.Component)
	local v1 = createReconciler(NoopRenderer)
	it("should be invoked when unmounted", function()
		local v12 = Component:extend("MyComponent")
		local v2 = createSpy()
		v12.willUnmount = v2.value
		function v12.render(p1)
			return nil
		end
		v1.unmountVirtualNode((v1.mountVirtualNode(createElement(v12), nil, "Test")))
		expect(v2.callCount).to.equal(1)
		expect(Type.of(v2:captureValues("self").self)).to.equal(Type.StatefulComponentInstance)
	end)
end
