return function() --[[ Line: 1 ]]
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local createSpy = require(script.Parent.Parent.createSpy)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local Type = require(script.Parent.Parent.Type)
	local Component = require(script.Parent.Parent.Component)
	local v1 = createReconciler(NoopRenderer)
	it("should be invoked when mounted", function() --[[ Line: 12 | Upvalues: Component (copy), createSpy (copy), createElement (copy), v1 (copy), Type (copy) ]]
		local v12 = Component:extend("MyComponent")
		local v2 = createSpy()
		v12.didMount = v2.value
		function v12.render(p1) --[[ Line: 19 ]]
			return nil
		end
		v1.mountVirtualNode(createElement(v12), nil, "Test")
		expect(v2.callCount).to.equal(1)
		expect(Type.of(v2:captureValues("self").self)).to.equal(Type.StatefulComponentInstance)
	end)
end