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
	local state1 = createReconciler(NoopRenderer)
	it("should be invoked when updated via updateVirtualNode", function()
		local internalData = Component:extend("MyComponent")
		local state2 = createSpy()
		internalData.didUpdate = state2.value
		function internalData.render(self)
			return nil
		end
		local tbl = {
			a = 5
		}
		local currentState = state1.mountVirtualNode(createElement(internalData, tbl), nil, "Test")
		expect(state2.callCount).to.equal(0)
		state1.updateVirtualNode(currentState, (createElement(internalData, {
			a = 6,
			b = 2
		})))
		expect(state2.callCount).to.equal(1)
		local tempState = state2:captureValues("self", "oldProps", "oldState")
		expect(Type.of(tempState.self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(tempState.oldProps, tbl)
		assertDeepEqual(tempState.oldState, {})
	end)
	it("should be invoked when updated via setState", function()
		local internalData = Component:extend("MyComponent")
		local state2 = createSpy()
		internalData.didUpdate = state2.value
		local tbl = {
			a = 4
		}
		local newState = nil
		function internalData.init(self)
			newState = function(...)
				return self:setState(...)
			end
			self:setState(tbl)
		end
		function internalData.render(self)  end
		state1.mountVirtualNode(createElement(internalData), nil, "Test")
		expect(state2.callCount).to.equal(0)
		newState({
			a = 5
		})
		expect(state2.callCount).to.equal(1)
		local nextState = state2:captureValues("self", "oldProps", "oldState")
		expect(Type.of(nextState.self)).to.equal(Type.StatefulComponentInstance)
		assertDeepEqual(nextState.oldProps, {})
		assertDeepEqual(nextState.oldState, tbl)
	end)
end
