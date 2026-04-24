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
	local key = createReconciler(NoopRenderer)
	it("should be invoked with props when mounted", function()
		local internalData = Component:extend("MyComponent")
		local state2 = createSpy()
		internalData.init = state2.value
		function internalData.render(self)
			return nil
		end
		local tbl = {
			a = 5
		}
		key.mountVirtualNode(createElement(internalData, tbl), nil, "Some Component Key")
		expect(state2.callCount).to.equal(1)
		local currentState = state2:captureValues("self", "props")
		expect(Type.of(currentState.self)).to.equal(Type.StatefulComponentInstance)
		local nextState = expect
		nextState((typeof(currentState.props))).to.equal("table")
		assertDeepEqual(currentState.props, tbl)
	end)
end
