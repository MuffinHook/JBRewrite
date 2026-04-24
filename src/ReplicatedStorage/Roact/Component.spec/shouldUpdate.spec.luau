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
	it("should be invoked when props update", function()
		local internalData = Component:extend("MyComponent")
		local v2 = nil
		local newState = nil
		local fn = createSpy(function(self)
			v2 = self.props
			newState = self.state
			return true
		end)
		internalData.shouldUpdate = fn.value
		function internalData.render(self)
			return nil
		end
		local t = {
			a = 5
		}
		local fn2 = v1.mountVirtualNode(createElement(internalData, t), nil, "Test")
		expect(fn.callCount).to.equal(0)
		local tbl2 = {
			a = 6,
			b = 2
		}
		v1.updateVirtualNode(fn2, (createElement(internalData, tbl2)))
		expect(fn.callCount).to.equal(1)
		local updatedState = fn:captureValues("self", "newProps", "newState")
		expect(Type.of(updatedState.self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(updatedState.newProps, tbl2)
		assertDeepEqual(v2, t)
		expect(updatedState.newState).to.equal(newState)
		assertDeepEqual(newState, {})
	end)
	it("should be invoked when state is updated", function()
		local internalData = Component:extend("MyComponent")
		local t = {
			a = 1
		}
		local v2 = nil
		local newState = nil
		function internalData.init(self)
			v2 = function(...)
				return self:setState(...)
			end
			self:setState(t)
			newState = self.state
		end
		local fn = nil
		local nextState = nil
		local fn2 = createSpy(function(self)
			fn = self.props
			nextState = self.state
			return true
		end)
		internalData.shouldUpdate = fn2.value
		function internalData.render(self)
			return nil
		end
		v1.mountVirtualNode(createElement(internalData), nil, "Test")
		expect(fn2.callCount).to.equal(0)
		local tbl2 = {
			a = 2,
			b = 3
		}
		v2(tbl2)
		expect(fn2.callCount).to.equal(1)
		local updatedState = fn2:captureValues("self", "newProps", "newState")
		expect(Type.of(updatedState.self)).to.equal(Type.StatefulComponentInstance)
		expect(updatedState.newProps).to.equal(fn)
		assertDeepEqual(fn, {})
		assertDeepEqual(nextState, t)
		expect(nextState).to.equal(newState)
		assertDeepEqual(updatedState.newState, tbl2)
	end)
	it("should not abort an update when returning true", function()
		local internalData = Component:extend("MyComponent")
		function internalData.shouldUpdate(self)
			return true
		end
		local v2 = createSpy()
		internalData.render = v2.value
		local fn = v1.mountVirtualNode(createElement(internalData), nil, "Test")
		expect(v2.callCount).to.equal(1)
		v1.updateVirtualNode(fn, (createElement(internalData)))
		expect(v2.callCount).to.equal(2)
	end)
	it("should abort an update when retuning false", function()
		local internalData = Component:extend("MyComponent")
		function internalData.shouldUpdate(self)
			return false
		end
		local v2 = createSpy()
		internalData.render = v2.value
		local fn = v1.mountVirtualNode(createElement(internalData), nil, "Test")
		expect(v2.callCount).to.equal(1)
		v1.updateVirtualNode(fn, (createElement(internalData)))
		expect(v2.callCount).to.equal(1)
	end)
end
