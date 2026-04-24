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
		v12.didUpdate = v2.value
		function v12.render(p1)
			return nil
		end
		local t = {
			a = 5
		}
		local v4 = v1.mountVirtualNode(createElement(v12, t), nil, "Test")
		expect(v2.callCount).to.equal(0)
		v1.updateVirtualNode(v4, (createElement(v12, {
			a = 6,
			b = 2
		})))
		expect(v2.callCount).to.equal(1)
		local v6 = v2:captureValues("self", "oldProps", "oldState")
		expect(Type.of(v6.self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(v6.oldProps, t)
		assertDeepEqual(v6.oldState, {})
	end)
	it("should be invoked when updated via setState", function()
		local v12 = Component:extend("MyComponent")
		local v2 = createSpy()
		v12.didUpdate = v2.value
		local t = {
			a = 4
		}
		local v3 = nil
		function v12.init(p1)
			v3 = function(...)
				return p1:setState(...)
			end
			p1:setState(t)
		end
		function v12.render(p1)  end
		v1.mountVirtualNode(createElement(v12), nil, "Test")
		expect(v2.callCount).to.equal(0)
		v3({
			a = 5
		})
		expect(v2.callCount).to.equal(1)
		local v5 = v2:captureValues("self", "oldProps", "oldState")
		expect(Type.of(v5.self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(v5.oldProps, {})
		assertDeepEqual(v5.oldState, t)
	end)
end
