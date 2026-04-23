return function() --[[ Line: 1 ]]
	local assertDeepEqual = require(script.Parent.Parent.assertDeepEqual)
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local createSpy = require(script.Parent.Parent.createSpy)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local Type = require(script.Parent.Parent.Type)
	local Component = require(script.Parent.Parent.Component)
	local v1 = createReconciler(NoopRenderer)
	it("should throw on mount if not overridden", function() --[[ Line: 13 | Upvalues: Component (copy), createElement (copy), v1 (copy) ]]
		local v12 = createElement((Component:extend("MyComponent")))
		local v2, v3 = pcall(function() --[[ Line: 20 | Upvalues: v1 (ref), v12 (copy) ]]
			v1.mountVirtualNode(v12, nil, "Test")
		end)
		expect(v2).to.equal(false)
		expect(v3:match("MyComponent")).to.be.ok()
		expect(v3:match("render")).to.be.ok()
	end)
	it("should be invoked when a component is mounted", function() --[[ Line: 29 | Upvalues: Component (copy), createSpy (copy), createElement (copy), v1 (copy), Type (copy), assertDeepEqual (copy) ]]
		local v12 = Component:extend("Foo")
		local v2 = nil
		local v3 = nil
		local v4 = createSpy(function(p1) --[[ Line: 34 | Upvalues: v2 (ref), v3 (ref) ]]
			v2 = p1.props
			v3 = p1.state
		end)
		v12.render = v4.value
		v1.mountVirtualNode(createElement(v12), nil, "Foo Test")
		expect(v4.callCount).to.equal(1)
		expect(Type.of(v4:captureValues("self").self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(v2, {})
		assertDeepEqual(v3, {})
	end)
	it("should be invoked when a component is updated via props", function() --[[ Line: 55 | Upvalues: Component (copy), createSpy (copy), createElement (copy), v1 (copy), Type (copy), assertDeepEqual (copy) ]]
		local v12 = Component:extend("Foo")
		local v2 = nil
		local v3 = nil
		local v4 = createSpy(function(p1) --[[ Line: 60 | Upvalues: v2 (ref), v3 (ref) ]]
			v2 = p1.props
			v3 = p1.state
		end)
		v12.render = v4.value
		local t = {
			a = 2
		}
		local v6 = v1.mountVirtualNode(createElement(v12, t), nil, "Foo Test")
		expect(v4.callCount).to.equal(1)
		local v8 = v2
		local v9 = v3
		expect(Type.of(v4:captureValues("self").self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(v8, t)
		assertDeepEqual(v9, {})
		local t2 = {
			a = 3
		}
		v1.updateVirtualNode(v6, (createElement(v12, t2)))
		expect(v4.callCount).to.equal(2)
		local v122 = v2
		expect(Type.of(v4:captureValues("self").self)).to.equal(Type.StatefulComponentInstance)
		expect(v122).never.to.equal(v8)
		assertDeepEqual(v122, t2)
		expect(v3).to.equal(v9)
	end)
	it("should be invoked when a component is updated via state", function() --[[ Line: 104 | Upvalues: Component (copy), createSpy (copy), createElement (copy), v1 (copy), Type (copy) ]]
		local v12 = Component:extend("Foo")
		local v2 = nil
		function v12.init(p1) --[[ Line: 108 | Upvalues: v2 (ref) ]]
			v2 = function(...) --[[ Line: 109 | Upvalues: p1 (copy) ]]
				return p1:setState(...)
			end
		end
		local v3 = nil
		local v4 = nil
		local v5 = createSpy(function(p1) --[[ Line: 116 | Upvalues: v3 (ref), v4 (ref) ]]
			v3 = p1.props
			v4 = p1.state
		end)
		v12.render = v5.value
		v1.mountVirtualNode(createElement(v12), nil, "Foo Test")
		expect(v5.callCount).to.equal(1)
		expect(Type.of(v5:captureValues("self").self)).to.equal(Type.StatefulComponentInstance)
		v2({})
		expect(v5.callCount).to.equal(2)
		expect(Type.of(v5:captureValues("self").self)).to.equal(Type.StatefulComponentInstance)
		expect(v3).to.equal(v3)
		expect(v4).never.to.equal(v4)
	end)
	itSKIP("Test defaultProps on initial render", function() --[[ Line: 147 ]] end)
	itSKIP("Test defaultProps on prop update", function() --[[ Line: 148 ]] end)
	itSKIP("Test defaultProps on state update", function() --[[ Line: 149 ]] end)
end