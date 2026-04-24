-- Reviewed by Claude
-- variables reassigned
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
 local internalData = createContext("Test")
 local fn = createSpy(function()
 return nil
 end)
 v1.unmountVirtualTree((v1.mountVirtualTree(createElement(internalData.Provider, {
 value = "Test"
 }, {
 Listener = createElement(fn.value)
 }), nil, "Provide Tree")))
 expect(fn.callCount).to.equal(1)
 end)
	end)
	describe("Consumer", function()
 it("should expect a render function", function()
 local internalData = createElement(createContext("Test").Consumer)
 expect(function()
 v1.mountVirtualTree(internalData, nil, "Provide Tree")
 end).to.throw()
 end)
 it("should return the default value if there is no Provider", function()
 local internalData = createSpy()
 v1.unmountVirtualTree((v1.mountVirtualTree(createElement(createContext("Test").Consumer, {
 render = internalData.value
 }), nil, "Provide Tree")))
 internalData:assertCalledWith("Test")
 end)
 it("should pass the value to the render function", function()
 local internalData = createSpy()
 local fn = createContext("Test")
 local function Listener()
 return createElement(fn.Consumer, {
 render = internalData.value
 })
 end
 v1.unmountVirtualTree((v1.mountVirtualTree(createElement(fn.Provider, {
 value = "NewTest"
 }, {
 Listener = createElement(Listener)
 }), nil, "Provide Tree")))
 internalData:assertCalledWith("NewTest")
 end)
 it("should update when the value updates", function()
 local internalData = createSpy()
 local fn = createContext("Test")
 local function Listener()
 return createElement(fn.Consumer, {
 render = internalData.value
 })
 end
 local currentState = v1.mountVirtualTree(createElement(fn.Provider, {
 value = "NewTest"
 }, {
 Listener = createElement(Listener)
 }), nil, "Provide Tree")
 expect(internalData.callCount).to.equal(1)
 internalData:assertCalledWith("NewTest")
 v1.updateVirtualTree(currentState, createElement(fn.Provider, {
 value = "ThirdTest"
 }, {
 Listener = createElement(Listener)
 }))
 expect(internalData.callCount).to.equal(2)
 internalData:assertCalledWith("ThirdTest")
 v1.unmountVirtualTree(currentState)
 end)
 it("should update when the value updates through an update blocking component", function()
 local internalData = createSpy()
 local fn = createContext("Test")
 local newState = Component:extend("UpdateBlocker")
 function newState.render(self)
 return createFragment(self.props[Children])
 end
 function newState.shouldUpdate(self)
 return false
 end
 local function Listener()
 return createElement(fn.Consumer, {
 render = internalData.value
 })
 end
 local nextState = v1.mountVirtualTree(createElement(fn.Provider, {
 value = "NewTest"
 }, {
 Blocker = createElement(newState, nil, {
 Listener = createElement(Listener)
 })
 }), nil, "Provide Tree")
 expect(internalData.callCount).to.equal(1)
 internalData:assertCalledWith("NewTest")
 v1.updateVirtualTree(nextState, createElement(fn.Provider, {
 value = "ThirdTest"
 }, {
 Blocker = createElement(newState, nil, {
 Listener = createElement(Listener)
 })
 }))
 expect(internalData.callCount).to.equal(2)
 internalData:assertCalledWith("ThirdTest")
 v1.unmountVirtualTree(nextState)
 end)
 it("should behave correctly when the default value is nil", function()
 local internalData = createContext(nil)
 local fn = createSpy()
 local function Listener()
 return createElement(internalData.Consumer, {
 render = fn.value
 })
 end
 local newState = v1.mountVirtualTree(createElement(Listener), nil, "Provide Tree")
 expect(fn.callCount).to.equal(1)
 fn:assertCalledWith(nil)
 v1.unmountVirtualTree((v1.updateVirtualTree(newState, createElement(Listener))))
 expect(fn.callCount).to.equal(2)
 fn:assertCalledWith(nil)
 end)
	end)
	describe("Update order", function()
 it("should update context at the same time as props", function()
 local internalData = false
 local fn = false
 local newState = 0
 local currentState = createContext("default")
 local function Listener(self)
 return createElement(currentState.Consumer, {
 render = function(param12)
 newState = newState + 1
 if param12 == "context_1" then
 expect(self.someProp).to.equal("prop_1")
 internalData = true
 elseif param12 == "context_2" then
 expect(self.someProp).to.equal("prop_2")
 fn = true
 else
 error("Unexpected context value")
 end
 end
 })
 end
 local nextState = createElement(currentState.Provider, {
 value = "context_1"
 }, {
 Child = createElement(Listener, {
 someProp = "prop_1"
 })
 })
 local tempState = createElement(currentState.Provider, {
 value = "context_2"
 }, {
 Child = createElement(Listener, {
 someProp = "prop_2"
 })
 })
 v1.updateVirtualTree(v1.mountVirtualTree(nextState, nil, "UpdateObservationIsFun"), tempState)
 expect(newState).to.equal(2)
 expect(internalData).to.equal(true)
 expect(fn).to.equal(true)
 end)
	end)
	it("does not throw if willUnmount is called twice on a context consumer", function()
 local v1 = createContext({})
 local derivedState = Component:extend("LowestComponent")
 function derivedState.init(self) end
 function derivedState.render(self)
 return createElement("Frame")
 end
 function derivedState.didMount(self)
 self.props.onDidMountCallback()
 end
 local newState = Component:extend("FirstComponent")
 function newState.init(self) end
 function newState.render(self)
 return createElement(v1.Consumer, {
 render = function()
 return createElement("TextLabel")
 end
 })
 end
 local currentState = Component:extend("ChildComponent")
 function currentState.init(self)
 self:setState({
 firstTime = true
 })
 end
 local nextState = nil
 function currentState.render(self)
 if self.state.firstTime then
 return createElement(newState)
 else
 return createElement(derivedState, {
 onDidMountCallback = self.props.onDidMountCallback
 })
 end
 end
 function currentState.didMount(self)
 nextState = function()
 self:setState({
 firstTime = false
 })
 end
 end
 local tempState = Component:extend("ParentComponent")
 local mergedState = 0
 function tempState.init(self)
 self:setState({
 count = 1
 })
 function self.onDidMountCallback()
 mergedState = mergedState + 1
 if self.state.count < 5 then
 self:setState({
 count = self.state.count + 1
 })
 end
 end
 end
 function tempState.render(self)
 return createElement("Frame", {}, {
 Provider = createElement(v1.Provider, {
 value = {}
 }, {
 ChildComponent = createElement(currentState, {
 count = self.state.count,
 onDidMountCallback = self.onDidMountCallback
 })
 })
 })
 end
 local ScreenGui = Instance.new("ScreenGui")
 ScreenGui.Parent = ReplicatedStorage
 fn.mountVirtualNode(createElement(tempState), ScreenGui, "Some Key")
 expect(function()
 nextState()
 end).never.to.throw()
	end)
end
