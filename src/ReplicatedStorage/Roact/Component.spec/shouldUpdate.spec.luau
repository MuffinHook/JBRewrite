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
	it("should be invoked when props update", function()
		local v12 = Component:extend("MyComponent")
		local v2 = nil
		local v3 = nil
		local fn = createSpy(function(p1)
			v2 = p1.props
			v3 = p1.state
			return true
		end)
		v12.shouldUpdate = fn.value
		function v12.render(p1)
			return nil
		end
		local t = {
			a = 5
		}
		local fn2 = v1.mountVirtualNode(createElement(v12, t), nil, "Test")
		expect(fn.callCount).to.equal(0)
		local t2 = {
			a = 6,
			b = 2
		}
		v1.updateVirtualNode(fn2, (createElement(v12, t2)))
		expect(fn.callCount).to.equal(1)
		local v8 = fn:captureValues("self", "newProps", "newState")
		expect(Type.of(v8.self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(v8.newProps, t2)
		assertDeepEqual(v2, t)
		expect(v8.newState).to.equal(v3)
		assertDeepEqual(v3, {})
	end)
	it("should be invoked when state is updated", function()
		local v12 = Component:extend("MyComponent")
		local t = {
			a = 1
		}
		local v2 = nil
		local v3 = nil
		function v12.init(p1)
			v2 = function(...)
				return p1:setState(...)
			end
			p1:setState(t)
			v3 = p1.state
		end
		local fn = nil
		local v5 = nil
		local fn2 = createSpy(function(p1)
			fn = p1.props
			v5 = p1.state
			return true
		end)
		v12.shouldUpdate = fn2.value
		function v12.render(p1)
			return nil
		end
		v1.mountVirtualNode(createElement(v12), nil, "Test")
		expect(fn2.callCount).to.equal(0)
		local t2 = {
			a = 2,
			b = 3
		}
		v2(t2)
		expect(fn2.callCount).to.equal(1)
		local v8 = fn2:captureValues("self", "newProps", "newState")
		expect(Type.of(v8.self)).to.equal(Type.StatefulComponentInstance)
		expect(v8.newProps).to.equal(fn)
		assertDeepEqual(fn, {})
		assertDeepEqual(v5, t)
		expect(v5).to.equal(v3)
		assertDeepEqual(v8.newState, t2)
	end)
	it("should not abort an update when returning true", function()
		local v12 = Component:extend("MyComponent")
		function v12.shouldUpdate(p1)
			return true
		end
		local v2 = createSpy()
		v12.render = v2.value
		local fn = v1.mountVirtualNode(createElement(v12), nil, "Test")
		expect(v2.callCount).to.equal(1)
		v1.updateVirtualNode(fn, (createElement(v12)))
		expect(v2.callCount).to.equal(2)
	end)
	it("should abort an update when retuning false", function()
		local v12 = Component:extend("MyComponent")
		function v12.shouldUpdate(p1)
			return false
		end
		local v2 = createSpy()
		v12.render = v2.value
		local fn = v1.mountVirtualNode(createElement(v12), nil, "Test")
		expect(v2.callCount).to.equal(1)
		v1.updateVirtualNode(fn, (createElement(v12)))
		expect(v2.callCount).to.equal(1)
	end)
end
