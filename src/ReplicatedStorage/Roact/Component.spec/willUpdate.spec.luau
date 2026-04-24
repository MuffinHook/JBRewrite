-- Reviewed by Claude
return function()
	local assertDeepEqual = require(script.Parent.Parent.assertDeepEqual)
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local createSpy = require(script.Parent.Parent.createSpy)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local Type = require(script.Parent.Parent.Type)
	local Component = require(script.Parent.Parent.Component)
	local v1 = createReconciler(NoopRenderer)
	it("should be invoked when updated via updateVirtualNode", function()
		local v12 = Component:extend("MyComponent")
		local v2 = createSpy()
		v12.willUpdate = v2.value
		function v12.render(p1)
			return nil
		end
		local v4 = v1.mountVirtualNode(createElement(v12, {
			a = 5
		}), nil, "Test")
		local t = {
			a = 6,
			b = 2
		}
		v1.updateVirtualNode(v4, (createElement(v12, t)))
		expect(v2.callCount).to.equal(1)
		local v6 = v2:captureValues("self", "newProps", "newState")
		expect(Type.of(v6.self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(v6.newProps, t)
		assertDeepEqual(v6.newState, {})
	end)
	it("it should be invoked when updated via setState", function()
		local v12 = Component:extend("MyComponent")
		local v2 = nil
		local v3 = createSpy()
		v12.willUpdate = v3.value
		function v12.init(p1)
			v2 = function(p12)
				p1:setState(p12)
			end
			p1:setState({
				foo = 1
			})
		end
		function v12.render(p1)
			return nil
		end
		v1.mountVirtualNode(createElement(v12), nil, "Test")
		expect(v3.callCount).to.equal(0)
		v2({
			foo = 2
		})
		expect(v3.callCount).to.equal(1)
		local v5 = v3:captureValues("self", "newProps", "newState")
		expect(Type.of(v5.self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(v5.newProps, {})
		assertDeepEqual(v5.newState, {
			foo = 2
		})
	end)
end
