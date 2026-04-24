-- Reviewed by Claude
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
 local v12 = 0
 local v2 = nil
 local v3 = PureComponent:extend("PureChild")
 function v3.willUpdate(p1)
 v12 = v12 + 1
 end
 function v3.render(p1)
 return nil
 end
 local v4 = PureComponent:extend("PureContainer")
 function v4.init(p1)
 p1.state = {
 value = 0
 }
 end
 function v4.didMount(p1)
 v2 = function(p12)
 p1:setState({
 value = p12
 })
 end
 end
 function v4.render(p1)
 return createElement(v3, {
 value = p1.state.value
 })
 end
 local v6 = v1.mountVirtualTree(createElement(v4), nil, "PureComponent Tree")
 expect(v12).to.equal(0)
 v2(1)
 expect(v12).to.equal(1)
 v2(1)
 expect(v12).to.equal(1)
 v2(2)
 expect(v12).to.equal(2)
 v2(1)
 expect(v12).to.equal(3)
 v1.unmountVirtualTree(v6)
	end)
end