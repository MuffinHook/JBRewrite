-- Reviewed by Claude
-- variables reassigned
return function()
	local createElement = require(script.Parent.createElement)
	local NoopRenderer = require(script.Parent.NoopRenderer)
	local createReconciler = require(script.Parent.createReconciler)
	local PureComponent = require(script.Parent.PureComponent)
	local v1 = createReconciler(NoopRenderer)
	it("should be extendable", function()
 expect((PureComponent:extend("MyComponent"))).to.be.ok()
	end)
	it("should skip updates for shallow-equal props", function()
 local internalData = 0
 local v2 = nil
 local newState = PureComponent:extend("PureChild")
 function newState.willUpdate(self)
 internalData = internalData + 1
 end
 function newState.render(self)
 return nil
 end
 local currentState = PureComponent:extend("PureContainer")
 function currentState.init(self)
 self.state = {
 value = 0
 }
 end
 function currentState.didMount(self)
 v2 = function(param12)
 self:setState({
 value = param12
 })
 end
 end
 function currentState.render(self)
 return createElement(newState, {
 value = self.state.value
 })
 end
 local tempState = v1.mountVirtualTree(createElement(currentState), nil, "PureComponent Tree")
 expect(internalData).to.equal(0)
 v2(1)
 expect(internalData).to.equal(1)
 v2(1)
 expect(internalData).to.equal(1)
 v2(2)
 expect(internalData).to.equal(2)
 v2(1)
 expect(internalData).to.equal(3)
 v1.unmountVirtualTree(tempState)
	end)
end
