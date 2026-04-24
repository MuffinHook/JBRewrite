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
	it("should be invoked when updated via updateVirtualNode", function()
		local internalData = Component:extend("MyComponent")
		local v2 = createSpy()
		internalData.willUpdate = v2.value
		function internalData.render(self)
			return nil
		end
		local currentState = v1.mountVirtualNode(createElement(internalData, {
			a = 5
		}), nil, "Test")
		local t = {
			a = 6,
			b = 2
		}
		v1.updateVirtualNode(currentState, (createElement(internalData, t)))
		expect(v2.callCount).to.equal(1)
		local tempState = v2:captureValues("self", "newProps", "newState")
		expect(Type.of(tempState.self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(tempState.newProps, t)
		assertDeepEqual(tempState.newState, {})
	end)
	it("it should be invoked when updated via setState", function()
		local internalData = Component:extend("MyComponent")
		local v2 = nil
		local newState = createSpy()
		internalData.willUpdate = newState.value
		function internalData.init(self)
			v2 = function(param12)
				self:setState(param12)
			end
			self:setState({
				foo = 1
			})
		end
		function internalData.render(self)
			return nil
		end
		v1.mountVirtualNode(createElement(internalData), nil, "Test")
		expect(newState.callCount).to.equal(0)
		v2({
			foo = 2
		})
		expect(newState.callCount).to.equal(1)
		local nextState = newState:captureValues("self", "newProps", "newState")
		expect(Type.of(nextState.self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(nextState.newProps, {})
		assertDeepEqual(nextState.newState, {
			foo = 2
		})
	end)
end
