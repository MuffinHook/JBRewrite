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
	it("should throw on mount if not overridden", function()
		local v12 = createElement((Component:extend("MyComponent")))
		local v2, v3 = pcall(function()
			v1.mountVirtualNode(v12, nil, "Test")
		end)
		expect(v2).to.equal(false)
		expect(v3:match("MyComponent")).to.be.ok()
		expect(v3:match("render")).to.be.ok()
	end)
	it("should be invoked when a component is mounted", function()
		local v12 = Component:extend("Foo")
		local v2 = nil
		local v3 = nil
		local fn = createSpy(function(p1)
			v2 = p1.props
			v3 = p1.state
		end)
		v12.render = fn.value
		v1.mountVirtualNode(createElement(v12), nil, "Foo Test")
		expect(fn.callCount).to.equal(1)
		expect(Type.of(fn:captureValues("self").self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(v2, {})
		assertDeepEqual(v3, {})
	end)
	it("should be invoked when a component is updated via props", function()
		local v12 = Component:extend("Foo")
		local v2 = nil
		local v3 = nil
		local fn = createSpy(function(p1)
			v2 = p1.props
			v3 = p1.state
		end)
		v12.render = fn.value
		local t = {
			a = 2
		}
		local v6 = v1.mountVirtualNode(createElement(v12, t), nil, "Foo Test")
		expect(fn.callCount).to.equal(1)
		local v8 = v2
		local v9 = v3
		expect(Type.of(fn:captureValues("self").self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(v8, t)
		assertDeepEqual(v9, {})
		local t2 = {
			a = 3
		}
		v1.updateVirtualNode(v6, (createElement(v12, t2)))
		expect(fn.callCount).to.equal(2)
		local v122 = v2
		expect(Type.of(fn:captureValues("self").self)).to.equal(Type.StatefulComponentInstance)
		expect(v122).never.to.equal(v8)
		assertDeepEqual(v122, t2)
		expect(v3).to.equal(v9)
	end)
	it("should be invoked when a component is updated via state", function()
		local v12 = Component:extend("Foo")
		local v2 = nil
		function v12.init(p1)
			v2 = function(...)
				return p1:setState(...)
			end
		end
		local v3 = nil
		local fn = nil
		local fn2 = createSpy(function(p1)
			v3 = p1.props
			fn = p1.state
		end)
		v12.render = fn2.value
		v1.mountVirtualNode(createElement(v12), nil, "Foo Test")
		expect(fn2.callCount).to.equal(1)
		expect(Type.of(fn2:captureValues("self").self)).to.equal(Type.StatefulComponentInstance)
		v2({})
		expect(fn2.callCount).to.equal(2)
		expect(Type.of(fn2:captureValues("self").self)).to.equal(Type.StatefulComponentInstance)
		expect(v3).to.equal(v3)
		expect(fn).never.to.equal(fn)
	end)
	itSKIP("Test defaultProps on initial render", function()  end)
	itSKIP("Test defaultProps on prop update", function()  end)
	itSKIP("Test defaultProps on state update", function()  end)
end
