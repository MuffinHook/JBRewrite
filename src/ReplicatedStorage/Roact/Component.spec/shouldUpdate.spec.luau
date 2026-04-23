return function() --[[ Line: 1 ]]
	local assertDeepEqual = require(script.Parent.Parent.assertDeepEqual)
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local createSpy = require(script.Parent.Parent.createSpy)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local Type = require(script.Parent.Parent.Type)
	local Component = require(script.Parent.Parent.Component)
	local v1 = createReconciler(NoopRenderer)
	it("should be invoked when props update", function() --[[ Line: 13 | Upvalues: Component (copy), createSpy (copy), createElement (copy), v1 (copy), Type (copy), assertDeepEqual (copy) ]]
		local v12 = Component:extend("MyComponent")
		local v2 = nil
		local v3 = nil
		local v4 = createSpy(function(p1) --[[ Line: 18 | Upvalues: v2 (ref), v3 (ref) ]]
			v2 = p1.props
			v3 = p1.state
			return true
		end)
		v12.shouldUpdate = v4.value
		function v12.render(p1) --[[ Line: 27 ]]
			return nil
		end
		local t = {
			a = 5
		}
		local v6 = v1.mountVirtualNode(createElement(v12, t), nil, "Test")
		expect(v4.callCount).to.equal(0)
		local t2 = {
			a = 6,
			b = 2
		}
		v1.updateVirtualNode(v6, (createElement(v12, t2)))
		expect(v4.callCount).to.equal(1)
		local v8 = v4:captureValues("self", "newProps", "newState")
		expect(Type.of(v8.self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(v8.newProps, t2)
		assertDeepEqual(v2, t)
		expect(v8.newState).to.equal(v3)
		assertDeepEqual(v3, {})
	end)
	it("should be invoked when state is updated", function() --[[ Line: 63 | Upvalues: Component (copy), createSpy (copy), createElement (copy), v1 (copy), Type (copy), assertDeepEqual (copy) ]]
		local v12 = Component:extend("MyComponent")
		local t = {
			a = 1
		}
		local v2 = nil
		local v3 = nil
		function v12.init(p1) --[[ Line: 72 | Upvalues: v2 (ref), t (copy), v3 (ref) ]]
			v2 = function(...) --[[ Line: 73 | Upvalues: p1 (copy) ]]
				return p1:setState(...)
			end
			p1:setState(t)
			v3 = p1.state
		end
		local v4 = nil
		local v5 = nil
		local v6 = createSpy(function(p1) --[[ Line: 84 | Upvalues: v4 (ref), v5 (ref) ]]
			v4 = p1.props
			v5 = p1.state
			return true
		end)
		v12.shouldUpdate = v6.value
		function v12.render(p1) --[[ Line: 93 ]]
			return nil
		end
		v1.mountVirtualNode(createElement(v12), nil, "Test")
		expect(v6.callCount).to.equal(0)
		local t2 = {
			a = 2,
			b = 3
		}
		v2(t2)
		expect(v6.callCount).to.equal(1)
		local v8 = v6:captureValues("self", "newProps", "newState")
		expect(Type.of(v8.self)).to.equal(Type.StatefulComponentInstance)
		expect(v8.newProps).to.equal(v4)
		assertDeepEqual(v4, {})
		assertDeepEqual(v5, t)
		expect(v5).to.equal(v3)
		assertDeepEqual(v8.newState, t2)
	end)
	it("should not abort an update when returning true", function() --[[ Line: 126 | Upvalues: Component (copy), createSpy (copy), createElement (copy), v1 (copy) ]]
		local v12 = Component:extend("MyComponent")
		function v12.shouldUpdate(p1) --[[ Line: 129 ]]
			return true
		end
		local v2 = createSpy()
		v12.render = v2.value
		local v4 = v1.mountVirtualNode(createElement(v12), nil, "Test")
		expect(v2.callCount).to.equal(1)
		v1.updateVirtualNode(v4, (createElement(v12)))
		expect(v2.callCount).to.equal(2)
	end)
	it("should abort an update when retuning false", function() --[[ Line: 151 | Upvalues: Component (copy), createSpy (copy), createElement (copy), v1 (copy) ]]
		local v12 = Component:extend("MyComponent")
		function v12.shouldUpdate(p1) --[[ Line: 154 ]]
			return false
		end
		local v2 = createSpy()
		v12.render = v2.value
		local v4 = v1.mountVirtualNode(createElement(v12), nil, "Test")
		expect(v2.callCount).to.equal(1)
		v1.updateVirtualNode(v4, (createElement(v12)))
		expect(v2.callCount).to.equal(1)
	end)
end