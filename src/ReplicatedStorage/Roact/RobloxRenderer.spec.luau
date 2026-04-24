-- Reviewed by Claude
return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local assertDeepEqual = require(script.Parent.assertDeepEqual)
	local Binding = require(script.Parent.Binding)
	local Children = require(script.Parent.PropMarkers.Children)
	local Component = require(script.Parent.Component)
	local createElement = require(script.Parent.createElement)
	local createFragment = require(script.Parent.createFragment)
	local createReconciler = require(script.Parent.createReconciler)
	local createRef = require(script.Parent.createRef)
	local createSpy = require(script.Parent.createSpy)
	local GlobalConfig = require(script.Parent.GlobalConfig)
	local Portal = require(script.Parent.Portal)
	local Ref = require(script.Parent.PropMarkers.Ref)
	local Event = require(script.Parent.PropMarkers.Event)
	local RobloxRenderer = require(script.Parent.RobloxRenderer)
	local reconciler = createReconciler(RobloxRenderer)
	describe("mountHostNode", function()
	it("should create instances with correct props", function()
	local parentFolder = Instance.new("Folder")
	RobloxRenderer.mountHostNode(reconciler, (reconciler.createVirtualNode(createElement("StringValue", {
	Value = "Hello!"
	}), parentFolder, "Some Key")))
	expect(#parentFolder:GetChildren()).to.equal(1)
	local createdInstance = parentFolder:GetChildren()[1]
 expect(createdInstance.ClassName).to.equal("StringValue")
 expect(createdInstance.Value).to.equal("Hello!")
 expect(createdInstance.Name).to.equal("Some Key")
 end)
 it("should create children with correct names and props", function()
 local parentFolder = Instance.new("Folder")
 RobloxRenderer.mountHostNode(reconciler, (reconciler.createVirtualNode(createElement("StringValue", {
 Value = "Hey there!"
 }, {
 ChildA = createElement("IntValue", {
 Value = 173
 }),
 ChildB = createElement("Folder")
 }), parentFolder, "Some Key")))
 expect(#parentFolder:GetChildren()).to.equal(1)
 local createdInstance = parentFolder:GetChildren()[1]
 expect(createdInstance.ClassName).to.equal("StringValue")
 expect(createdInstance.Value).to.equal("Hey there!")
 expect(createdInstance.Name).to.equal("Some Key")
 expect(#createdInstance:GetChildren()).to.equal(2)
 local ChildA = createdInstance.ChildA
 local ChildB = createdInstance.ChildB
 expect(ChildA).to.be.ok()
 expect(ChildB).to.be.ok()
 expect(ChildA.ClassName).to.equal("IntValue")
 expect(ChildA.Value).to.equal(173)
 expect(ChildB.ClassName).to.equal("Folder")
 end)
 it("should attach Bindings to Roblox properties", function()
 local parentFolder = Instance.new("Folder")
 local binding, updateBinding = Binding.create(10)
 local virtualNode = reconciler.createVirtualNode(createElement("IntValue", {
 Value = binding
 }), parentFolder, "Some Key")
 RobloxRenderer.mountHostNode(reconciler, virtualNode)
 expect(#parentFolder:GetChildren()).to.equal(1)
 local createdInstance = parentFolder:GetChildren()[1]
 expect(createdInstance.ClassName).to.equal("IntValue")
 expect(createdInstance.Value).to.equal(10)
 updateBinding(20)
 expect(createdInstance.Value).to.equal(20)
 RobloxRenderer.unmountHostNode(reconciler, virtualNode)
 end)
 it("should connect Binding refs", function()
 local parentFolder = Instance.new("Folder")
 local frameRef = createRef()
 local virtualNode = reconciler.createVirtualNode(createElement("Frame", {
 [Ref] = frameRef
 }), parentFolder, "Some Key")
 RobloxRenderer.mountHostNode(reconciler, virtualNode)
 expect(#parentFolder:GetChildren()).to.equal(1)
 local createdFrame = parentFolder:GetChildren()[1]
 expect(frameRef.current).to.be.ok()
 expect(frameRef.current).to.equal(createdFrame)
 RobloxRenderer.unmountHostNode(reconciler, virtualNode)
 end)
 it("should call function refs", function()
 local parentFolder = Instance.new("Folder")
 local refSpy = createSpy()
 local virtualNode = reconciler.createVirtualNode(createElement("Frame", {
 [Ref] = refSpy.value
 }), parentFolder, "Some Key")
 RobloxRenderer.mountHostNode(reconciler, virtualNode)
 expect(#parentFolder:GetChildren()).to.equal(1)
 local createdFrame = parentFolder:GetChildren()[1]
 expect(refSpy.callCount).to.equal(1)
 refSpy:assertCalledWith(createdFrame)
 RobloxRenderer.unmountHostNode(reconciler, virtualNode)
 end)
 it("should throw if setting invalid instance properties", function()
 GlobalConfig.scoped({
 elementTracing = true
 }, function()
 local parentFolder = Instance.new("Folder")
 local success, errorMsg = pcall(RobloxRenderer.mountHostNode, reconciler, (reconciler.createVirtualNode(createElement("Frame", {
 Frob = 6
 }), parentFolder, "Some Key")))
 assert(not success, "Expected call to fail")
 expect(errorMsg:find("Frob")).to.be.ok()
 expect(errorMsg:find("Frame")).to.be.ok()
 expect(errorMsg:find("RobloxRenderer%.spec")).to.be.ok()
 end)
 end)
	end)
	describe("updateHostNode", function()
	it("should update node props and children", function()
	local parentFolder = Instance.new("Folder")
	local defaultStringValue = Instance.new("StringValue").Value
	local virtualNode = reconciler.createVirtualNode(createElement("StringValue", {
 Value = "foo"
 }, {
 ChildA = createElement("IntValue", {
 Value = 1
 }),
 ChildB = createElement("BoolValue", {
 Value = true
 }),
 ChildC = createElement("StringValue", {
 Value = "test"
 }),
 ChildD = createElement("StringValue", {
 Value = "test"
 })
 }), parentFolder, "updateHostNodeTest")
 RobloxRenderer.mountHostNode(reconciler, virtualNode)
 RobloxRenderer.updateHostNode(reconciler, virtualNode, (createElement("StringValue", {
 Value = "bar"
 }, {
 ChildA = createElement("StringValue", {
 Value = "test"
 }),
 ChildB = createElement("BoolValue", {
 Value = false
 }),
 ChildC = createElement("StringValue", {}),
 ChildE = createElement("Folder", {})
 })))
 local updateHostNodeTest = parentFolder.updateHostNodeTest
 expect(updateHostNodeTest.ClassName).to.equal("StringValue")
 expect(updateHostNodeTest.Value).to.equal("bar")
 expect(#updateHostNodeTest:GetChildren()).to.equal(4)
 local ChildA = updateHostNodeTest.ChildA
 expect(ChildA.ClassName).to.equal("StringValue")
 expect(ChildA.Value).to.equal("test")
 local ChildB = updateHostNodeTest.ChildB
 expect(ChildB.ClassName).to.equal("BoolValue")
 expect(ChildB.Value).to.equal(false)
 local ChildC = updateHostNodeTest.ChildC
 expect(ChildC.ClassName).to.equal("StringValue")
 expect(ChildC.Value).to.equal(v22)
 expect(updateHostNodeTest.ChildE.ClassName).to.equal("Folder")
 end)
 it("should update Bindings", function()
 local parentFolder = Instance.new("Folder")
 local binding1, updateBinding1 = Binding.create(10)
 local virtualNode = reconciler.createVirtualNode(createElement("IntValue", {
 Value = binding1
 }), parentFolder, "Some Key")
 RobloxRenderer.mountHostNode(reconciler, virtualNode)
 local createdInstance = parentFolder:GetChildren()[1]
 expect(createdInstance.Value).to.equal(10)
 local binding2, updateBinding2 = Binding.create(99)
 RobloxRenderer.updateHostNode(reconciler, virtualNode, (createElement("IntValue", {
 Value = binding2
 })))
 expect(createdInstance.Value).to.equal(99)
 updateBinding1(123)
 expect(createdInstance.Value).to.equal(99)
 updateBinding2(123)
 expect(createdInstance.Value).to.equal(123)
 RobloxRenderer.unmountHostNode(reconciler, virtualNode)
 end)
 it("should update Binding refs", function()
 local parentFolder = Instance.new("Folder")
 local ref1 = createRef()
 local ref2 = createRef()
 local virtualNode = reconciler.createVirtualNode(createElement("Frame", {
 [Ref] = ref1
 }), parentFolder, "Some Key")
 RobloxRenderer.mountHostNode(reconciler, virtualNode)
 expect(#parentFolder:GetChildren()).to.equal(1)
 local createdFrame = parentFolder:GetChildren()[1]
 expect(ref1.current).to.equal(createdFrame)
 expect(ref2.current).never.to.be.ok()
 RobloxRenderer.updateHostNode(reconciler, virtualNode, (createElement("Frame", {
 [Ref] = ref2
 })))
 expect(ref1.current).never.to.be.ok()
 expect(ref2.current).to.equal(createdFrame)
 RobloxRenderer.unmountHostNode(reconciler, virtualNode)
 end)
 it("should call old function refs with nil and new function refs with a valid rbx", function()
 local parentFolder = Instance.new("Folder")
 local oldRefSpy = createSpy()
 local newRefSpy = createSpy()
 local virtualNode = reconciler.createVirtualNode(createElement("Frame", {
 [Ref] = oldRefSpy.value
 }), parentFolder, "Some Key")
 RobloxRenderer.mountHostNode(reconciler, virtualNode)
 expect(#parentFolder:GetChildren()).to.equal(1)
 local createdFrame = parentFolder:GetChildren()[1]
 expect(oldRefSpy.callCount).to.equal(1)
 oldRefSpy:assertCalledWith(createdFrame)
 expect(newRefSpy.callCount).to.equal(0)
 RobloxRenderer.updateHostNode(reconciler, virtualNode, (createElement("Frame", {
 [Ref] = newRefSpy.value
 })))
 expect(oldRefSpy.callCount).to.equal(2)
 oldRefSpy:assertCalledWith(nil)
 expect(newRefSpy.callCount).to.equal(1)
 newRefSpy:assertCalledWith(createdFrame)
 RobloxRenderer.unmountHostNode(reconciler, virtualNode)
 end)
 it("should not call function refs again if they didn\'t change", function()
 local parentFolder = Instance.new("Folder")
 local refSpy = createSpy()
 local virtualNode = reconciler.createVirtualNode(createElement("Frame", {
 Size = UDim2.new(1, 0, 1, 0),
 [Ref] = refSpy.value
 }), parentFolder, "Some Key")
 RobloxRenderer.mountHostNode(reconciler, virtualNode)
 expect(#parentFolder:GetChildren()).to.equal(1)
 local createdFrame = parentFolder:GetChildren()[1]
 expect(refSpy.callCount).to.equal(1)
 refSpy:assertCalledWith(createdFrame)
 RobloxRenderer.updateHostNode(reconciler, virtualNode, (createElement("Frame", {
 Size = UDim2.new(0.5, 0, 0.5, 0),
 [Ref] = refSpy.value
 })))
 expect(refSpy.callCount).to.equal(1)
 end)
 it("should throw if setting invalid instance properties", function()
 GlobalConfig.scoped({
 elementTracing = true
 }, function()
 local parentFolder = Instance.new("Folder")
 local validElement = createElement("Frame")
 local invalidElement = createElement("Frame", {
 Frob = 6
 })
 local virtualNode = reconciler.createVirtualNode(validElement, parentFolder, "Some Key")
 RobloxRenderer.mountHostNode(reconciler, virtualNode)
 local success, errorMsg = pcall(RobloxRenderer.updateHostNode, reconciler, virtualNode, invalidElement)
 assert(not success, "Expected call to fail")
 expect(errorMsg:find("Frob")).to.be.ok()
 expect(errorMsg:find("Frame")).to.be.ok()
 expect(errorMsg:find("RobloxRenderer%.spec")).to.be.ok()
 end)
 end)
 it("should delete instances when reconciling to nil children", function()
 local parentFolder = Instance.new("Folder")
 local virtualNode = reconciler.createVirtualNode(createElement("Frame", {
 Size = UDim2.new(1, 0, 1, 0)
 }, {
 child = createElement("Frame")
 }), parentFolder, "Some Key")
 RobloxRenderer.mountHostNode(reconciler, virtualNode)
 expect(#parentFolder:GetChildren()).to.equal(1)
 local createdFrame = parentFolder:GetChildren()[1]
 expect(#createdFrame:GetChildren()).to.equal(1)
 RobloxRenderer.updateHostNode(reconciler, virtualNode, (createElement("Frame", {
 Size = UDim2.new(0.5, 0, 0.5, 0)
 })))
 expect(#createdFrame:GetChildren()).to.equal(0)
 end)
	end)
	describe("unmountHostNode", function()
	it("should delete instances from the inside-out", function()
	local parentFolder = Instance.new("Folder")
	local virtualNode = reconciler.mountVirtualNode(createElement("Folder", nil, {
	Child = createElement("Folder", nil, {
	Grandchild = createElement("Folder")
	})
	}), parentFolder, "Root")
	expect(#parentFolder:GetChildren()).to.equal(1)
	local rootFolder = parentFolder:GetChildren()[1]
	expect(#rootFolder:GetChildren()).to.equal(1)
	local childFolder = rootFolder:GetChildren()[1]
	expect(#childFolder:GetChildren()).to.equal(1)
	local grandchildFolder = childFolder:GetChildren()[1]
	RobloxRenderer.unmountHostNode(reconciler, virtualNode)
	expect(grandchildFolder.Parent).to.equal(nil)
	expect(childFolder.Parent).to.equal(nil)
	expect(rootFolder.Parent).to.equal(nil)
 end)
 it("should unsubscribe from any Bindings", function()
 local parentFolder = Instance.new("Folder")
 local binding, updateBinding = Binding.create(10)
 local virtualNode = reconciler.createVirtualNode(createElement("IntValue", {
 Value = binding
 }), parentFolder, "Some Key")
 RobloxRenderer.mountHostNode(reconciler, virtualNode)
 local createdInstance = parentFolder:GetChildren()[1]
 expect(createdInstance.Value).to.equal(10)
 RobloxRenderer.unmountHostNode(reconciler, virtualNode)
 updateBinding(56)
 expect(createdInstance.Value).to.equal(10)
 end)
 it("should clear Binding refs", function()
 local parentFolder = Instance.new("Folder")
 local frameRef = createRef()
 local virtualNode = reconciler.createVirtualNode(createElement("Frame", {
 [Ref] = frameRef
 }), parentFolder, "Some Key")
 RobloxRenderer.mountHostNode(reconciler, virtualNode)
 expect(frameRef.current).to.be.ok()
 RobloxRenderer.unmountHostNode(reconciler, virtualNode)
 expect(frameRef.current).never.to.be.ok()
 end)
 it("should call function refs with nil", function()
 local parentFolder = Instance.new("Folder")
 local refSpy = createSpy()
 local virtualNode = reconciler.createVirtualNode(createElement("Frame", {
 [Ref] = refSpy.value
 }), parentFolder, "Some Key")
 RobloxRenderer.mountHostNode(reconciler, virtualNode)
 expect(refSpy.callCount).to.equal(1)
 RobloxRenderer.unmountHostNode(reconciler, virtualNode)
 expect(refSpy.callCount).to.equal(2)
 refSpy:assertCalledWith(nil)
 end)
	end)
	describe("Portals", function()
	it("should create and destroy instances as children of `target`", function()
	local targetFolder = Instance.new("Folder")
	local function FunctionComponent(props)
	return createElement("IntValue", {
	Value = props.value
	})
	end
	local virtualNode = reconciler.mountVirtualNode(createElement(Portal, {
	target = targetFolder
	}, {
	folderOne = createElement("Folder"),
	folderTwo = createElement("Folder"),
	intValueOne = createElement(FunctionComponent, {
	value = 42
	})
	}), nil, "Some Key")
	expect(#targetFolder:GetChildren()).to.equal(3)
	expect(targetFolder:FindFirstChild("folderOne")).to.be.ok()
	expect(targetFolder:FindFirstChild("folderTwo")).to.be.ok()
	expect(targetFolder:FindFirstChild("intValueOne")).to.be.ok()
	expect(targetFolder:FindFirstChild("intValueOne").Value).to.equal(42)
	reconciler.unmountVirtualNode(virtualNode)
	expect(#targetFolder:GetChildren()).to.equal(0)
 end)
 it("should pass prop updates through to children", function()
 local targetFolder = Instance.new("Folder")
 local portalElement1 = createElement(Portal, {
 target = targetFolder
 }, {
 ChildValue = createElement("IntValue", {
 Value = 1
 })
 })
 local portalElement2 = createElement(Portal, {
 target = targetFolder
 }, {
 ChildValue = createElement("IntValue", {
 Value = 2
 })
 })
 local virtualNode = reconciler.mountVirtualNode(portalElement1, nil, "A Host Key")
 expect(#targetFolder:GetChildren()).to.equal(1)
 local ChildValue = targetFolder.ChildValue
 expect(ChildValue.Value).to.equal(1)
 local updatedVirtualNode = reconciler.updateVirtualNode(virtualNode, portalElement2)
 expect(#targetFolder:GetChildren()).to.equal(1)
 local ChildValue_2 = targetFolder.ChildValue
 expect(ChildValue).to.equal(ChildValue_2)
 expect(ChildValue_2.Value).to.equal(2)
 reconciler.unmountVirtualNode(updatedVirtualNode)
 expect(#targetFolder:GetChildren()).to.equal(0)
 end)
 it("should throw if `target` is nil", function()
 local portalElement = createElement(Portal)
 expect(function()
 reconciler.mountVirtualNode(portalElement, nil, "Keys for Everyone")
 end).to.throw()
 end)
 it("should throw if `target` is not a Roblox instance", function()
 local portalElement = createElement(Portal, {
 target = {}
 })
 expect(function()
 reconciler.mountVirtualNode(portalElement, nil, "Unleash the keys!")
 end).to.throw()
 end)
 it("should recreate instances if `target` changes in an update", function()
 local targetFolder1 = Instance.new("Folder")
 local targetFolder2 = Instance.new("Folder")
 local portalElement1 = createElement(Portal, {
 target = targetFolder1
 }, {
 ChildValue = createElement("IntValue", {
 Value = 1
 })
 })
 local portalElement2 = createElement(Portal, {
 target = targetFolder2
 }, {
 ChildValue = createElement("IntValue", {
 Value = 2
 })
 })
 local virtualNode = reconciler.mountVirtualNode(portalElement1, nil, "Some Key")
 expect(#targetFolder1:GetChildren()).to.equal(1)
 expect(#targetFolder2:GetChildren()).to.equal(0)
 expect(targetFolder1.ChildValue.Value).to.equal(1)
 local updatedVirtualNode = reconciler.updateVirtualNode(virtualNode, portalElement2)
 expect(#targetFolder1:GetChildren()).to.equal(0)
 expect(#targetFolder2:GetChildren()).to.equal(1)
 expect(targetFolder2.ChildValue.Value).to.equal(2)
 reconciler.unmountVirtualNode(updatedVirtualNode)
 expect(#targetFolder1:GetChildren()).to.equal(0)
 expect(#targetFolder2:GetChildren()).to.equal(0)
 end)
	end)
	describe("Fragments", function()
	it("should parent the fragment\'s elements into the fragment\'s parent", function()
	local parentFolder = Instance.new("Folder")
	local virtualNode = reconciler.mountVirtualNode(createFragment({
	key = createElement("IntValue", {
	Value = 1
	}),
	key2 = createElement("IntValue", {
	Value = 2
	})
	}), parentFolder, "test")
	expect(parentFolder:FindFirstChild("key")).to.be.ok()
	expect(parentFolder.key.ClassName).to.equal("IntValue")
	expect(parentFolder.key.Value).to.equal(1)
	expect(parentFolder:FindFirstChild("key2")).to.be.ok()
	expect(parentFolder.key2.ClassName).to.equal("IntValue")
	expect(parentFolder.key2.Value).to.equal(2)
	reconciler.unmountVirtualNode(virtualNode)
	expect(#parentFolder:GetChildren()).to.equal(0)
 end)
 it("should allow sibling fragment to have common keys", function()
 local parentFolder = Instance.new("Folder")
 local function parent(props)
 return createElement("IntValue", {}, {
 fragmentA = createFragment({
 key = createElement("StringValue", {
 Value = "A"
 }),
 key2 = createElement("StringValue", {
 Value = "B"
 })
 }),
 fragmentB = createFragment({
 key = createElement("StringValue", {
 Value = "C"
 }),
 key2 = createElement("StringValue", {
 Value = "D"
 })
 })
 })
 end
 local virtualNode = reconciler.mountVirtualNode(createElement(parent), parentFolder, "Test")
 local childrenList = parentFolder.Test:GetChildren()
 expect(#childrenList).to.equal(4)
 local valueCounts = {}
 for k, v in pairs(childrenList) do
 expect(v.ClassName).to.equal("StringValue")
 valueCounts[v.Value] = 1 + (valueCounts[v.Value] or 0)
 end
 expect(valueCounts.A).to.equal(1)
 expect(valueCounts.B).to.equal(1)
 expect(valueCounts.C).to.equal(1)
 expect(valueCounts.D).to.equal(1)
 reconciler.unmountVirtualNode(virtualNode)
 expect(#parentFolder:GetChildren()).to.equal(0)
 end)
 it("should render nested fragments", function()
 local parentFolder = Instance.new("Folder")
 local virtualNode = reconciler.mountVirtualNode(createFragment({
 key = createFragment({
 TheValue = createElement("IntValue", {
 Value = 1
 }),
 TheOtherValue = createElement("IntValue", {
 Value = 2
 })
 })
 }), parentFolder, "Test")
 expect(parentFolder:FindFirstChild("TheValue")).to.be.ok()
 expect(parentFolder.TheValue.ClassName).to.equal("IntValue")
 expect(parentFolder.TheValue.Value).to.equal(1)
 expect(parentFolder:FindFirstChild("TheOtherValue")).to.be.ok()
 expect(parentFolder.TheOtherValue.ClassName).to.equal("IntValue")
 expect(parentFolder.TheOtherValue.Value).to.equal(2)
 reconciler.unmountVirtualNode(virtualNode)
 expect(#parentFolder:GetChildren()).to.equal(0)
 end)
 it("should not add any instances if the fragment is empty", function()
 local parentFolder = Instance.new("Folder")
 local virtualNode = reconciler.mountVirtualNode(createFragment({}), parentFolder, "test")
 expect(#parentFolder:GetChildren()).to.equal(0)
 reconciler.unmountVirtualNode(virtualNode)
 expect(#parentFolder:GetChildren()).to.equal(0)
 end)
	end)
	describe("Context", function()
	it("should pass context values through Roblox host nodes", function()
	local ConsumerComponent = Component:extend("Consumer")
	local capturedContext = nil
	function ConsumerComponent.init(self)
	capturedContext = {
	hello = self:__getContext("hello")
	}
	end
	function ConsumerComponent.render(self) end
	local expectedContext = {
	hello = "world"
	}
	local virtualNode = reconciler.mountVirtualNode(createElement("Folder", nil, {
	Consumer = createElement(ConsumerComponent)
	}), nil, "Context Test", expectedContext)
	expect(capturedContext).never.to.equal(expectedContext)
	assertDeepEqual(capturedContext, expectedContext)
	reconciler.unmountVirtualNode(virtualNode)
 end)
 it("should pass context values through portal nodes", function()
 local targetFolder = Instance.new("Folder")
 local ProviderComponent = Component:extend("Provider")
 function ProviderComponent.init(self)
 self:__addContext("foo", "bar")
 end
 function ProviderComponent.render(self)
 return createElement("Folder", nil, self.props[Children])
 end
 local ConsumerComponent = Component:extend("Consumer")
 local capturedContext = nil
 function ConsumerComponent.init(self)
 capturedContext = {
 foo = self:__getContext("foo")
 }
 end
 function ConsumerComponent.render(self)
 return nil
 end
 reconciler.mountVirtualNode(createElement(ProviderComponent, nil, {
 Portal = createElement(Portal, {
 target = targetFolder
 }, {
 Consumer = createElement(ConsumerComponent)
 })
 }), nil, "Some Key")
 assertDeepEqual(capturedContext, {
 foo = "bar"
 })
 end)
	end)
	describe("Legacy context", function()
	it("should pass context values through Roblox host nodes", function()
	local ConsumerComponent = Component:extend("Consumer")
	local capturedContext = nil
	function ConsumerComponent.init(self)
	capturedContext = self._context
	end
	function ConsumerComponent.render(self) end
	local expectedContext = {
	hello = "world"
	}
	local virtualNode = reconciler.mountVirtualNode(createElement("Folder", nil, {
	Consumer = createElement(ConsumerComponent)
	}), nil, "Context Test", nil, expectedContext)
	expect(capturedContext).never.to.equal(expectedContext)
	assertDeepEqual(capturedContext, expectedContext)
	reconciler.unmountVirtualNode(virtualNode)
 end)
 it("should pass context values through portal nodes", function()
 local targetFolder = Instance.new("Folder")
 local ProviderComponent = Component:extend("Provider")
 function ProviderComponent.init(self)
 self._context.foo = "bar"
 end
 function ProviderComponent.render(self)
 return createElement("Folder", nil, self.props[Children])
 end
 local ConsumerComponent = Component:extend("Consumer")
 local capturedContext = nil
 function ConsumerComponent.init(self)
 capturedContext = self._context
 end
 function ConsumerComponent.render(self)
 return nil
 end
 reconciler.mountVirtualNode(createElement(ProviderComponent, nil, {
 Portal = createElement(Portal, {
 target = targetFolder
 }, {
 Consumer = createElement(ConsumerComponent)
 })
 }), nil, "Some Key")
 assertDeepEqual(capturedContext, {
 foo = "bar"
 })
 end)
	end)
	describe("Integration Tests", function()
	local testFolder = nil
	beforeEach(function()
	testFolder = Instance.new("Folder")
	testFolder.Parent = ReplicatedStorage
	end)
	afterEach(function()
	testFolder:Destroy()
	testFolder = nil
 end)
 it("should not allow re-entrancy in updateChildren", function()
 local ChildComponent = Component:extend("ChildComponent")
 function ChildComponent.init(self)
 self:setState({
 firstTime = true
 })
 end
 local stateChangeCoroutine = nil
 function ChildComponent.render(self)
 if self.state.firstTime then
 return createElement("Frame")
 else
 return createElement("TextLabel")
 end
 end
 function ChildComponent.didMount(self)
 stateChangeCoroutine = coroutine.create(function()
 self:setState({
 firstTime = false
 })
 end)
 end
 local ParentComponent = Component:extend("ParentComponent")
 function ParentComponent.init(self)
 self:setState({
 count = 1
 })
 function self.childAdded()
 self:setState({
 count = self.state.count + 1
 })
 end
 end
 function ParentComponent.render(self)
 return createElement("Frame", {
 [Event.ChildAdded] = self.childAdded
 }, {
 ChildComponent = createElement(ChildComponent, {
 count = self.state.count
 })
 })
 end
 local ScreenGui = Instance.new("ScreenGui")
 ScreenGui.Parent = testFolder
 local virtualNode = reconciler.mountVirtualNode(createElement(ParentComponent), ScreenGui, "Some Key")
 coroutine.resume(stateChangeCoroutine)
 expect(#ScreenGui:GetChildren()).to.equal(1)
 expect(#ScreenGui:GetChildren()[1]:GetChildren()).to.equal(1)
 v2.unmountVirtualNode(v5)
 end)
 it("should not allow re-entrancy in updateChildren even with callbacks", function()
 local v1 = Component:extend("LowestComponent")
 function v1.render(p1)
 return createElement("Frame")
 end
 function v1.didMount(p1)
 p1.props.onDidMountCallback()
 end
 local v22 = Component:extend("ChildComponent")
 function v22.init(p1)
 p1:setState({
 firstTime = true
 })
 end
 local v3 = nil
 function v22.render(p1)
 if p1.state.firstTime then
 return createElement("Frame")
 else
 return createElement(v1, {
 onDidMountCallback = p1.props.onDidMountCallback
 })
 end
 end
 function v22.didMount(p1)
 v3 = coroutine.create(function()
 p1:setState({
 firstTime = false
 })
 end)
 end
 local v4 = Component:extend("ParentComponent")
 local v5 = 0
 function v4.init(p1)
 p1:setState({
 count = 1
 })
 function p1.onDidMountCallback()
 v5 = v5 + 1
 if p1.state.count < 5 then
 p1:setState({
 count = p1.state.count + 1
 })
 end
 end
 end
 function v4.render(p1)
 return createElement("Frame", {}, {
 ChildComponent = createElement(v22, {
 count = p1.state.count,
 onDidMountCallback = p1.onDidMountCallback
 })
 })
 end
 local ScreenGui = Instance.new("ScreenGui")
 ScreenGui.Parent = v12
 local v7 = v2.mountVirtualNode(createElement(v4), ScreenGui, "Some Key")
 coroutine.resume(v3)
 expect(#ScreenGui:GetChildren()).to.equal(1)
 expect(#ScreenGui:GetChildren()[1]:GetChildren()).to.equal(1)
 expect(v5 <= 2).to.equal(true)
 v2.unmountVirtualNode(v7)
 end)
 it("should never call unmount twice in the case of update children re-rentrancy", function()
 local tbl = {}
 local function addUnmount(p1)
 tbl[p1] = tbl[p1] + 1
 end
 local function addInit(p1)
 tbl[p1] = 0
 end
 local v1 = Component:extend("LowestComponent")
 function v1.init(p1)
 tbl[tostring(p1)] = 0
 end
 function v1.render(p1)
 return createElement("Frame")
 end
 function v1.didMount(p1)
 p1.props.onDidMountCallback()
 end
 function v1.willUnmount(p1)
 local v1 = tostring(p1)
 tbl[v1] = tbl[v1] + 1
 end
 local v22 = Component:extend("FirstComponent")
 function v22.init(p1)
 tbl[tostring(p1)] = 0
 end
 function v22.render(p1)
 return createElement("TextLabel")
 end
 function v22.willUnmount(p1)
 local v1 = tostring(p1)
 tbl[v1] = tbl[v1] + 1
 end
 local v3 = Component:extend("ChildComponent")
 function v3.init(p1)
 tbl[tostring(p1)] = 0
 p1:setState({
 firstTime = true
 })
 end
 local v4 = nil
 function v3.render(p1)
 if p1.state.firstTime then
 return createElement(v22)
 else
 return createElement(v1, {
 onDidMountCallback = p1.props.onDidMountCallback
 })
 end
 end
 function v3.didMount(p1)
 v4 = coroutine.create(function()
 p1:setState({
 firstTime = false
 })
 end)
 end
 function v3.willUnmount(p1)
 local v1 = tostring(p1)
 tbl[v1] = tbl[v1] + 1
 end
 local v5 = Component:extend("ParentComponent")
 local v6 = 0
 function v5.init(p1)
 p1:setState({
 count = 1
 })
 function p1.onDidMountCallback()
 v6 = v6 + 1
 if p1.state.count < 5 then
 p1:setState({
 count = p1.state.count + 1
 })
 end
 end
 end
 function v5.render(p1)
 return createElement("Frame", {}, {
 ChildComponent = createElement(v3, {
 count = p1.state.count,
 onDidMountCallback = p1.onDidMountCallback
 })
 })
 end
 local ScreenGui = Instance.new("ScreenGui")
 ScreenGui.Parent = v12
 local v8 = v2.mountVirtualNode(createElement(v5), ScreenGui, "Some Key")
 coroutine.resume(v4)
 expect(#ScreenGui:GetChildren()).to.equal(1)
 expect(#ScreenGui:GetChildren()[1]:GetChildren()).to.equal(1)
 expect(v6 <= 2).to.equal(true)
 v2.unmountVirtualNode(v8)
 for k, v in pairs(tbl) do
 expect(v).to.equal(1)
 end
 end)
 it("should never unmount a node unnecesarily in the case of re-rentry", function()
 local v1 = Component:extend("LowestComponent")
 function v1.render(p1)
 return createElement("Frame")
 end
 function v1.didUpdate(p1, p2, p3)
 if p2.firstTime and not p1.props.firstTime then
 p1.props.onChangedCallback()
 end
 end
 local v22 = Component:extend("ChildComponent")
 function v22.init(p1)
 p1:setState({
 firstTime = true
 })
 end
 local v3 = nil
 function v22.render(p1)
 return createElement(v1, {
 firstTime = p1.state.firstTime,
 onChangedCallback = p1.props.onChangedCallback
 })
 end
 function v22.didMount(p1)
 v3 = coroutine.create(function()
 p1:setState({
 firstTime = false
 })
 end)
 end
 local v4 = Component:extend("ParentComponent")
 local v5 = 0
 function v4.init(p1)
 p1:setState({
 count = 1
 })
 function p1.onChangedCallback()
 v5 = v5 + 1
 if p1.state.count < 5 then
 p1:setState({
 count = p1.state.count + 1
 })
 end
 end
 end
 function v4.render(p1)
 return createElement("Frame", {}, {
 ChildComponent = createElement(v22, {
 count = p1.state.count,
 onChangedCallback = p1.onChangedCallback
 })
 })
 end
 local ScreenGui = Instance.new("ScreenGui")
 ScreenGui.Parent = v12
 local v7 = v2.mountVirtualNode(createElement(v4), ScreenGui, "Some Key")
 coroutine.resume(v3)
 expect(#ScreenGui:GetChildren()).to.equal(1)
 expect(#ScreenGui:GetChildren()[1]:GetChildren()).to.equal(1)
 expect(v5).to.equal(1)
 v2.unmountVirtualNode(v7)
 end)
	end)
end