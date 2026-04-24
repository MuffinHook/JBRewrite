-- Reviewed by Claude
return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Component = require(script.Parent.Component)
	local NoopRenderer = require(script.Parent.NoopRenderer)
	local Children = require(script.Parent.PropMarkers.Children)
	local createContext = require(script.Parent.createContext)
	local createElement = require(script.Parent.createElement)
	local createFragment = require(script.Parent.createFragment)
	local createReconciler = require(script.Parent.createReconciler)
	local createSpy = require(script.Parent.createSpy)
	local v1 = createReconciler(NoopRenderer)
	local fn = createReconciler((require(script.Parent.RobloxRenderer)))
	it("should return a table", function()
 local v1 = createContext("Test")
 expect(v1).to.be.ok()
 expect((type(v1))).to.equal("table")
	end)
	it("should contain a Provider and a Consumer", function()
 local v1 = createContext("Test")
 expect(v1.Provider).to.be.ok()
 expect(v1.Consumer).to.be.ok()
	end)
	describe("Provider", function()
 it("should render its children", function()
 local v12 = createContext("Test")
 local fn = createSpy(function()
 return nil
 end)
 v1.unmountVirtualTree((v1.mountVirtualTree(createElement(v12.Provider, {
 value = "Test"
 }, {
 Listener = createElement(fn.value)
 }), nil, "Provide Tree")))
 expect(fn.callCount).to.equal(1)
 end)
	end)
	describe("Consumer", function()
 it("should expect a render function", function()
 local v12 = createElement(createContext("Test").Consumer)
 expect(function()
 v1.mountVirtualTree(v12, nil, "Provide Tree")
 end).to.throw()
 end)
 it("should return the default value if there is no Provider", function()
 local v12 = createSpy()
 v1.unmountVirtualTree((v1.mountVirtualTree(createElement(createContext("Test").Consumer, {
 render = v12.value
 }), nil, "Provide Tree")))
 v12:assertCalledWith("Test")
 end)
 it("should pass the value to the render function", function()
 local v12 = createSpy()
 local fn = createContext("Test")
 local function Listener()
 return createElement(fn.Consumer, {
 render = v12.value
 })
 end
 v1.unmountVirtualTree((v1.mountVirtualTree(createElement(fn.Provider, {
 value = "NewTest"
 }, {
 Listener = createElement(Listener)
 }), nil, "Provide Tree")))
 v12:assertCalledWith("NewTest")
 end)
 it("should update when the value updates", function()
 local v12 = createSpy()
 local fn = createContext("Test")
 local function Listener()
 return createElement(fn.Consumer, {
 render = v12.value
 })
 end
 local v4 = v1.mountVirtualTree(createElement(fn.Provider, {
 value = "NewTest"
 }, {
 Listener = createElement(Listener)
 }), nil, "Provide Tree")
 expect(v12.callCount).to.equal(1)
 v12:assertCalledWith("NewTest")
 v1.updateVirtualTree(v4, createElement(fn.Provider, {
 value = "ThirdTest"
 }, {
 Listener = createElement(Listener)
 }))
 expect(v12.callCount).to.equal(2)
 v12:assertCalledWith("ThirdTest")
 v1.unmountVirtualTree(v4)
 end)
 it("should update when the value updates through an update blocking component", function()
 local v12 = createSpy()
 local fn = createContext("Test")
 local v3 = Component:extend("UpdateBlocker")
 function v3.render(p1)
 return createFragment(p1.props[Children])
 end
 function v3.shouldUpdate(p1)
 return false
 end
 local function Listener()
 return createElement(fn.Consumer, {
 render = v12.value
 })
 end
 local v5 = v1.mountVirtualTree(createElement(fn.Provider, {
 value = "NewTest"
 }, {
 Blocker = createElement(v3, nil, {
 Listener = createElement(Listener)
 })
 }), nil, "Provide Tree")
 expect(v12.callCount).to.equal(1)
 v12:assertCalledWith("NewTest")
 v1.updateVirtualTree(v5, createElement(fn.Provider, {
 value = "ThirdTest"
 }, {
 Blocker = createElement(v3, nil, {
 Listener = createElement(Listener)
 })
 }))
 expect(v12.callCount).to.equal(2)
 v12:assertCalledWith("ThirdTest")
 v1.unmountVirtualTree(v5)
 end)
 it("should behave correctly when the default value is nil", function()
 local v12 = createContext(nil)
 local fn = createSpy()
 local function Listener()
 return createElement(v12.Consumer, {
 render = fn.value
 })
 end
 local v3 = v1.mountVirtualTree(createElement(Listener), nil, "Provide Tree")
 expect(fn.callCount).to.equal(1)
 fn:assertCalledWith(nil)
 v1.unmountVirtualTree((v1.updateVirtualTree(v3, createElement(Listener))))
 expect(fn.callCount).to.equal(2)
 fn:assertCalledWith(nil)
 end)
	end)
	describe("Update order", function()
 it("should update context at the same time as props", function()
 local v12 = false
 local fn = false
 local v3 = 0
 local v4 = createContext("default")
 local function Listener(p1)
 return createElement(v4.Consumer, {
 render = function(p12)
 v3 = v3 + 1
 if p12 == "context_1" then
 expect(p1.someProp).to.equal("prop_1")
 v12 = true
 elseif p12 == "context_2" then
 expect(p1.someProp).to.equal("prop_2")
 fn = true
 else
 error("Unexpected context value")
 end
 end
 })
 end
 local v5 = createElement(v4.Provider, {
 value = "context_1"
 }, {
 Child = createElement(Listener, {
 someProp = "prop_1"
 })
 })
 local v6 = createElement(v4.Provider, {
 value = "context_2"
 }, {
 Child = createElement(Listener, {
 someProp = "prop_2"
 })
 })
 v1.updateVirtualTree(v1.mountVirtualTree(v5, nil, "UpdateObservationIsFun"), v6)
 expect(v3).to.equal(2)
 expect(v12).to.equal(true)
 expect(fn).to.equal(true)
 end)
	end)
	it("does not throw if willUnmount is called twice on a context consumer", function()
 local v1 = createContext({})
 local v22 = Component:extend("LowestComponent")
 function v22.init(p1) end
 function v22.render(p1)
 return createElement("Frame")
 end
 function v22.didMount(p1)
 p1.props.onDidMountCallback()
 end
 local v3 = Component:extend("FirstComponent")
 function v3.init(p1) end
 function v3.render(p1)
 return createElement(v1.Consumer, {
 render = function()
 return createElement("TextLabel")
 end
 })
 end
 local v4 = Component:extend("ChildComponent")
 function v4.init(p1)
 p1:setState({
 firstTime = true
 })
 end
 local v5 = nil
 function v4.render(p1)
 if p1.state.firstTime then
 return createElement(v3)
 else
 return createElement(v22, {
 onDidMountCallback = p1.props.onDidMountCallback
 })
 end
 end
 function v4.didMount(p1)
 v5 = function()
 p1:setState({
 firstTime = false
 })
 end
 end
 local v6 = Component:extend("ParentComponent")
 local v7 = 0
 function v6.init(p1)
 p1:setState({
 count = 1
 })
 function p1.onDidMountCallback()
 v7 = v7 + 1
 if p1.state.count < 5 then
 p1:setState({
 count = p1.state.count + 1
 })
 end
 end
 end
 function v6.render(p1)
 return createElement("Frame", {}, {
 Provider = createElement(v1.Provider, {
 value = {}
 }, {
 ChildComponent = createElement(v4, {
 count = p1.state.count,
 onDidMountCallback = p1.onDidMountCallback
 })
 })
 })
 end
 local ScreenGui = Instance.new("ScreenGui")
 ScreenGui.Parent = ReplicatedStorage
 fn.mountVirtualNode(createElement(v6), ScreenGui, "Some Key")
 expect(function()
 v5()
 end).never.to.throw()
	end)
end