-- Reviewed by Claude
-- variables reassigned
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
		local internalData = createElement((Component:extend("MyComponent")))
		local v2, newState = pcall(function()
			v1.mountVirtualNode(internalData, nil, "Test")
		end)
		expect(v2).to.equal(false)
		expect(newState:match("MyComponent")).to.be.ok()
		expect(newState:match("render")).to.be.ok()
	end)
	it("should be invoked when a component is mounted", function()
		local internalData = Component:extend("Foo")
		local v2 = nil
		local newState = nil
		local fn = createSpy(function(self)
			v2 = self.props
			newState = self.state
		end)
		internalData.render = fn.value
		v1.mountVirtualNode(createElement(internalData), nil, "Foo Test")
		expect(fn.callCount).to.equal(1)
		expect(Type.of(fn:captureValues("self").self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(v2, {})
		assertDeepEqual(newState, {})
	end)
	it("should be invoked when a component is updated via props", function()
		local internalData = Component:extend("Foo")
		local v2 = nil
		local newState = nil
		local fn = createSpy(function(self)
			v2 = self.props
			newState = self.state
		end)
		internalData.render = fn.value
		local t = {
			a = 2
		}
		local tempState = v1.mountVirtualNode(createElement(internalData, t), nil, "Foo Test")
		expect(fn.callCount).to.equal(1)
		local updatedState = v2
		local finalState = newState
		expect(Type.of(fn:captureValues("self").self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(updatedState, t)
		assertDeepEqual(finalState, {})
		local tbl2 = {
			a = 3
		}
		v1.updateVirtualNode(tempState, (createElement(internalData, tbl2)))
		expect(fn.callCount).to.equal(2)
		local v122 = v2
		expect(Type.of(fn:captureValues("self").self)).to.equal(Type.StatefulComponentInstance)
		expect(v122).never.to.equal(updatedState)
		assertDeepEqual(v122, tbl2)
		expect(newState).to.equal(finalState)
	end)
	it("should be invoked when a component is updated via state", function()
		local internalData = Component:extend("Foo")
		local v2 = nil
		function internalData.init(self)
			v2 = function(...)
				return self:setState(...)
			end
		end
		local newState = nil
		local fn = nil
		local fn2 = createSpy(function(self)
			newState = self.props
			fn = self.state
		end)
		internalData.render = fn2.value
		v1.mountVirtualNode(createElement(internalData), nil, "Foo Test")
		expect(fn2.callCount).to.equal(1)
		expect(Type.of(fn2:captureValues("self").self)).to.equal(Type.StatefulComponentInstance)
		v2({})
		expect(fn2.callCount).to.equal(2)
		expect(Type.of(fn2:captureValues("self").self)).to.equal(Type.StatefulComponentInstance)
		expect(newState).to.equal(newState)
		expect(fn).never.to.equal(fn)
	end)
	itSKIP("Test defaultProps on initial render", function()  end)
	itSKIP("Test defaultProps on prop update", function()  end)
	itSKIP("Test defaultProps on state update", function()  end)
end
