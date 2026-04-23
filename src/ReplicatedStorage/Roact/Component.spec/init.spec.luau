return function() --[[ Line: 1 ]]
	local assertDeepEqual = require(script.Parent.Parent.assertDeepEqual)
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local createSpy = require(script.Parent.Parent.createSpy)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local Type = require(script.Parent.Parent.Type)
	local Component = require(script.Parent.Parent.Component)
	local v1 = createReconciler(NoopRenderer)
	it("should be invoked with props when mounted", function() --[[ Line: 13 | Upvalues: Component (copy), createSpy (copy), createElement (copy), v1 (copy), Type (copy), assertDeepEqual (copy) ]]
		local v12 = Component:extend("MyComponent")
		local v2 = createSpy()
		v12.init = v2.value
		function v12.render(p1) --[[ Line: 20 ]]
			return nil
		end
		local t = {
			a = 5
		}
		v1.mountVirtualNode(createElement(v12, t), nil, "Some Component Key")
		expect(v2.callCount).to.equal(1)
		local v4 = v2:captureValues("self", "props")
		expect(Type.of(v4.self)).to.equal(Type.StatefulComponentInstance)
		local v5 = expect
		v5((typeof(v4.props))).to.equal("table")
		assertDeepEqual(v4.props, t)
	end)
end