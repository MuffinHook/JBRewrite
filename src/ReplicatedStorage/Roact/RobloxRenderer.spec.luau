return function() --[[ Line: 1 ]]
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
	local v1 = require(script.Parent.PropMarkers.Event)
	local RobloxRenderer = require(script.Parent.RobloxRenderer)
	local v2 = createReconciler(RobloxRenderer)
	describe("mountHostNode", function() --[[ Line: 22 | Upvalues: createElement (copy), v2 (copy), RobloxRenderer (copy), Binding (copy), createRef (copy), Ref (copy), createSpy (copy), GlobalConfig (copy) ]]
		it("should create instances with correct props", function() --[[ Line: 23 | Upvalues: createElement (ref), v2 (ref), RobloxRenderer (ref) ]]
			local v1 = Instance.new("Folder")
			RobloxRenderer.mountHostNode(v2, (v2.createVirtualNode(createElement("StringValue", {
				Value = "Hello!"
			}), v1, "Some Key")))
			expect(#v1:GetChildren()).to.equal(1)
			local v4 = v1:GetChildren()[1]
			expect(v4.ClassName).to.equal("StringValue")
			expect(v4.Value).to.equal("Hello!")
			expect(v4.Name).to.equal("Some Key")
		end)
		it("should create children with correct names and props", function() --[[ Line: 45 | Upvalues: createElement (ref), v2 (ref), RobloxRenderer (ref) ]]
			local v1 = Instance.new("Folder")
			RobloxRenderer.mountHostNode(v2, (v2.createVirtualNode(createElement("StringValue", {
				Value = "Hey there!"
			}, {
				ChildA = createElement("IntValue", {
					Value = 173
				}),
				ChildB = createElement("Folder")
			}), v1, "Some Key")))
			expect(#v1:GetChildren()).to.equal(1)
			local v4 = v1:GetChildren()[1]
			expect(v4.ClassName).to.equal("StringValue")
			expect(v4.Value).to.equal("Hey there!")
			expect(v4.Name).to.equal("Some Key")
			expect(#v4:GetChildren()).to.equal(2)
			local ChildA = v4.ChildA
			local ChildB = v4.ChildB
			expect(ChildA).to.be.ok()
			expect(ChildB).to.be.ok()
			expect(ChildA.ClassName).to.equal("IntValue")
			expect(ChildA.Value).to.equal(173)
			expect(ChildB.ClassName).to.equal("Folder")
		end)
		it("should attach Bindings to Roblox properties", function() --[[ Line: 87 | Upvalues: Binding (ref), createElement (ref), v2 (ref), RobloxRenderer (ref) ]]
			local v1 = Instance.new("Folder")
			local v22, v3 = Binding.create(10)
			local v5 = v2.createVirtualNode(createElement("IntValue", {
				Value = v22
			}), v1, "Some Key")
			RobloxRenderer.mountHostNode(v2, v5)
			expect(#v1:GetChildren()).to.equal(1)
			local v6 = v1:GetChildren()[1]
			expect(v6.ClassName).to.equal("IntValue")
			expect(v6.Value).to.equal(10)
			v3(20)
			expect(v6.Value).to.equal(20)
			RobloxRenderer.unmountHostNode(v2, v5)
		end)
		it("should connect Binding refs", function() --[[ Line: 114 | Upvalues: createRef (ref), createElement (ref), Ref (ref), v2 (ref), RobloxRenderer (ref) ]]
			local v1 = Instance.new("Folder")
			local v22 = createRef()
			local v4 = v2.createVirtualNode(createElement("Frame", {
				[Ref] = v22
			}), v1, "Some Key")
			RobloxRenderer.mountHostNode(v2, v4)
			expect(#v1:GetChildren()).to.equal(1)
			local v5 = v1:GetChildren()[1]
			expect(v22.current).to.be.ok()
			expect(v22.current).to.equal(v5)
			RobloxRenderer.unmountHostNode(v2, v4)
		end)
		it("should call function refs", function() --[[ Line: 137 | Upvalues: createSpy (ref), createElement (ref), Ref (ref), v2 (ref), RobloxRenderer (ref) ]]
			local v1 = Instance.new("Folder")
			local v22 = createSpy()
			local v4 = v2.createVirtualNode(createElement("Frame", {
				[Ref] = v22.value
			}), v1, "Some Key")
			RobloxRenderer.mountHostNode(v2, v4)
			expect(#v1:GetChildren()).to.equal(1)
			local v5 = v1:GetChildren()[1]
			expect(v22.callCount).to.equal(1)
			v22:assertCalledWith(v5)
			RobloxRenderer.unmountHostNode(v2, v4)
		end)
		it("should throw if setting invalid instance properties", function() --[[ Line: 160 | Upvalues: GlobalConfig (ref), createElement (ref), v2 (ref), RobloxRenderer (ref) ]]
			GlobalConfig.scoped({
				elementTracing = true
			}, function() --[[ Line: 165 | Upvalues: createElement (ref), v2 (ref), RobloxRenderer (ref) ]]
				local v1 = Instance.new("Folder")
				local v4, v5 = pcall(RobloxRenderer.mountHostNode, v2, (v2.createVirtualNode(createElement("Frame", {
					Frob = 6
				}), v1, "Some Key")))
				assert(not v4, "Expected call to fail")
				expect(v5:find("Frob")).to.be.ok()
				expect(v5:find("Frame")).to.be.ok()
				expect(v5:find("RobloxRenderer%.spec")).to.be.ok()
			end)
		end)
	end)
	describe("updateHostNode", function() --[[ Line: 185 | Upvalues: createElement (copy), v2 (copy), RobloxRenderer (copy), Binding (copy), createRef (copy), Ref (copy), createSpy (copy), GlobalConfig (copy) ]]
		it("should update node props and children", function() --[[ Line: 186 | Upvalues: createElement (ref), v2 (ref), RobloxRenderer (ref) ]]
			local v1 = Instance.new("Folder")
			local v22 = Instance.new("StringValue").Value
			local v4 = v2.createVirtualNode(createElement("StringValue", {
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
			}), v1, "updateHostNodeTest")
			RobloxRenderer.mountHostNode(v2, v4)
			RobloxRenderer.updateHostNode(v2, v4, (createElement("StringValue", {
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
			local updateHostNodeTest = v1.updateHostNodeTest
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
		it("should update Bindings", function() --[[ Line: 260 | Upvalues: Binding (ref), createElement (ref), v2 (ref), RobloxRenderer (ref) ]]
			local v1 = Instance.new("Folder")
			local v22, v3 = Binding.create(10)
			local v5 = v2.createVirtualNode(createElement("IntValue", {
				Value = v22
			}), v1, "Some Key")
			RobloxRenderer.mountHostNode(v2, v5)
			local v6 = v1:GetChildren()[1]
			expect(v6.Value).to.equal(10)
			local v7, v8 = Binding.create(99)
			RobloxRenderer.updateHostNode(v2, v5, (createElement("IntValue", {
				Value = v7
			})))
			expect(v6.Value).to.equal(99)
			v3(123)
			expect(v6.Value).to.equal(99)
			v8(123)
			expect(v6.Value).to.equal(123)
			RobloxRenderer.unmountHostNode(v2, v5)
		end)
		it("should update Binding refs", function() --[[ Line: 297 | Upvalues: createRef (ref), createElement (ref), Ref (ref), v2 (ref), RobloxRenderer (ref) ]]
			local v1 = Instance.new("Folder")
			local v22 = createRef()
			local v3 = createRef()
			local v5 = v2.createVirtualNode(createElement("Frame", {
				[Ref] = v22
			}), v1, "Some Key")
			RobloxRenderer.mountHostNode(v2, v5)
			expect(#v1:GetChildren()).to.equal(1)
			local v6 = v1:GetChildren()[1]
			expect(v22.current).to.equal(v6)
			expect(v3.current).never.to.be.ok()
			RobloxRenderer.updateHostNode(v2, v5, (createElement("Frame", {
				[Ref] = v3
			})))
			expect(v22.current).never.to.be.ok()
			expect(v3.current).to.equal(v6)
			RobloxRenderer.unmountHostNode(v2, v5)
		end)
		it("should call old function refs with nil and new function refs with a valid rbx", function() --[[ Line: 331 | Upvalues: createSpy (ref), createElement (ref), Ref (ref), v2 (ref), RobloxRenderer (ref) ]]
			local v1 = Instance.new("Folder")
			local v22 = createSpy()
			local v3 = createSpy()
			local v5 = v2.createVirtualNode(createElement("Frame", {
				[Ref] = v22.value
			}), v1, "Some Key")
			RobloxRenderer.mountHostNode(v2, v5)
			expect(#v1:GetChildren()).to.equal(1)
			local v6 = v1:GetChildren()[1]
			expect(v22.callCount).to.equal(1)
			v22:assertCalledWith(v6)
			expect(v3.callCount).to.equal(0)
			RobloxRenderer.updateHostNode(v2, v5, (createElement("Frame", {
				[Ref] = v3.value
			})))
			expect(v22.callCount).to.equal(2)
			v22:assertCalledWith(nil)
			expect(v3.callCount).to.equal(1)
			v3:assertCalledWith(v6)
			RobloxRenderer.unmountHostNode(v2, v5)
		end)
		it("should not call function refs again if they didn\'t change", function() --[[ Line: 368 | Upvalues: createSpy (ref), createElement (ref), Ref (ref), v2 (ref), RobloxRenderer (ref) ]]
			local v1 = Instance.new("Folder")
			local v22 = createSpy()
			local v4 = v2.createVirtualNode(createElement("Frame", {
				Size = UDim2.new(1, 0, 1, 0),
				[Ref] = v22.value
			}), v1, "Some Key")
			RobloxRenderer.mountHostNode(v2, v4)
			expect(#v1:GetChildren()).to.equal(1)
			local v5 = v1:GetChildren()[1]
			expect(v22.callCount).to.equal(1)
			v22:assertCalledWith(v5)
			RobloxRenderer.updateHostNode(v2, v4, (createElement("Frame", {
				Size = UDim2.new(0.5, 0, 0.5, 0),
				[Ref] = v22.value
			})))
			expect(v22.callCount).to.equal(1)
		end)
		it("should throw if setting invalid instance properties", function() --[[ Line: 401 | Upvalues: GlobalConfig (ref), createElement (ref), v2 (ref), RobloxRenderer (ref) ]]
			GlobalConfig.scoped({
				elementTracing = true
			}, function() --[[ Line: 406 | Upvalues: createElement (ref), v2 (ref), RobloxRenderer (ref) ]]
				local v1 = Instance.new("Folder")
				local v22 = createElement("Frame")
				local v3 = createElement("Frame", {
					Frob = 6
				})
				local v4 = v2.createVirtualNode(v22, v1, "Some Key")
				RobloxRenderer.mountHostNode(v2, v4)
				local v5, v6 = pcall(RobloxRenderer.updateHostNode, v2, v4, v3)
				assert(not v5, "Expected call to fail")
				expect(v6:find("Frob")).to.be.ok()
				expect(v6:find("Frame")).to.be.ok()
				expect(v6:find("RobloxRenderer%.spec")).to.be.ok()
			end)
		end)
		it("should delete instances when reconciling to nil children", function() --[[ Line: 427 | Upvalues: createElement (ref), v2 (ref), RobloxRenderer (ref) ]]
			local v1 = Instance.new("Folder")
			local v3 = v2.createVirtualNode(createElement("Frame", {
				Size = UDim2.new(1, 0, 1, 0)
			}, {
				child = createElement("Frame")
			}), v1, "Some Key")
			RobloxRenderer.mountHostNode(v2, v3)
			expect(#v1:GetChildren()).to.equal(1)
			local v4 = v1:GetChildren()[1]
			expect(#v4:GetChildren()).to.equal(1)
			RobloxRenderer.updateHostNode(v2, v3, (createElement("Frame", {
				Size = UDim2.new(0.5, 0, 0.5, 0)
			})))
			expect(#v4:GetChildren()).to.equal(0)
		end)
	end)
	describe("unmountHostNode", function() --[[ Line: 455 | Upvalues: createElement (copy), v2 (copy), RobloxRenderer (copy), Binding (copy), createRef (copy), Ref (copy), createSpy (copy) ]]
		it("should delete instances from the inside-out", function() --[[ Line: 456 | Upvalues: createElement (ref), v2 (ref), RobloxRenderer (ref) ]]
			local v1 = Instance.new("Folder")
			local v3 = v2.mountVirtualNode(createElement("Folder", nil, {
				Child = createElement("Folder", nil, {
					Grandchild = createElement("Folder")
				})
			}), v1, "Root")
			expect(#v1:GetChildren()).to.equal(1)
			local v4 = v1:GetChildren()[1]
			expect(#v4:GetChildren()).to.equal(1)
			local v5 = v4:GetChildren()[1]
			expect(#v5:GetChildren()).to.equal(1)
			local v6 = v5:GetChildren()[1]
			RobloxRenderer.unmountHostNode(v2, v3)
			expect(v6.Parent).to.equal(nil)
			expect(v5.Parent).to.equal(nil)
			expect(v4.Parent).to.equal(nil)
		end)
		it("should unsubscribe from any Bindings", function() --[[ Line: 484 | Upvalues: Binding (ref), createElement (ref), v2 (ref), RobloxRenderer (ref) ]]
			local v1 = Instance.new("Folder")
			local v22, v3 = Binding.create(10)
			local v5 = v2.createVirtualNode(createElement("IntValue", {
				Value = v22
			}), v1, "Some Key")
			RobloxRenderer.mountHostNode(v2, v5)
			local v6 = v1:GetChildren()[1]
			expect(v6.Value).to.equal(10)
			RobloxRenderer.unmountHostNode(v2, v5)
			v3(56)
			expect(v6.Value).to.equal(10)
		end)
		it("should clear Binding refs", function() --[[ Line: 507 | Upvalues: createRef (ref), createElement (ref), Ref (ref), v2 (ref), RobloxRenderer (ref) ]]
			local v1 = Instance.new("Folder")
			local v22 = createRef()
			local v4 = v2.createVirtualNode(createElement("Frame", {
				[Ref] = v22
			}), v1, "Some Key")
			RobloxRenderer.mountHostNode(v2, v4)
			expect(v22.current).to.be.ok()
			RobloxRenderer.unmountHostNode(v2, v4)
			expect(v22.current).never.to.be.ok()
		end)
		it("should call function refs with nil", function() --[[ Line: 527 | Upvalues: createSpy (ref), createElement (ref), Ref (ref), v2 (ref), RobloxRenderer (ref) ]]
			local v1 = Instance.new("Folder")
			local v22 = createSpy()
			local v4 = v2.createVirtualNode(createElement("Frame", {
				[Ref] = v22.value
			}), v1, "Some Key")
			RobloxRenderer.mountHostNode(v2, v4)
			expect(v22.callCount).to.equal(1)
			RobloxRenderer.unmountHostNode(v2, v4)
			expect(v22.callCount).to.equal(2)
			v22:assertCalledWith(nil)
		end)
	end)
	describe("Portals", function() --[[ Line: 549 | Upvalues: createElement (copy), Portal (copy), v2 (copy) ]]
		it("should create and destroy instances as children of `target`", function() --[[ Line: 550 | Upvalues: createElement (ref), Portal (ref), v2 (ref) ]]
			local v1 = Instance.new("Folder")
			local function FunctionComponent(p1) --[[ Line: 553 | Upvalues: createElement (ref) ]]
				return createElement("IntValue", {
					Value = p1.value
				})
			end
			local v3 = v2.mountVirtualNode(createElement(Portal, {
				target = v1
			}, {
				folderOne = createElement("Folder"),
				folderTwo = createElement("Folder"),
				intValueOne = createElement(FunctionComponent, {
					value = 42
				})
			}), nil, "Some Key")
			expect(#v1:GetChildren()).to.equal(3)
			expect(v1:FindFirstChild("folderOne")).to.be.ok()
			expect(v1:FindFirstChild("folderTwo")).to.be.ok()
			expect(v1:FindFirstChild("intValueOne")).to.be.ok()
			expect(v1:FindFirstChild("intValueOne").Value).to.equal(42)
			v2.unmountVirtualNode(v3)
			expect(#v1:GetChildren()).to.equal(0)
		end)
		it("should pass prop updates through to children", function() --[[ Line: 584 | Upvalues: createElement (ref), Portal (ref), v2 (ref) ]]
			local v1 = Instance.new("Folder")
			local v22 = createElement(Portal, {
				target = v1
			}, {
				ChildValue = createElement("IntValue", {
					Value = 1
				})
			})
			local v3 = createElement(Portal, {
				target = v1
			}, {
				ChildValue = createElement("IntValue", {
					Value = 2
				})
			})
			local v4 = v2.mountVirtualNode(v22, nil, "A Host Key")
			expect(#v1:GetChildren()).to.equal(1)
			local ChildValue = v1.ChildValue
			expect(ChildValue.Value).to.equal(1)
			local v5 = v2.updateVirtualNode(v4, v3)
			expect(#v1:GetChildren()).to.equal(1)
			local ChildValue_2 = v1.ChildValue
			expect(ChildValue).to.equal(ChildValue_2)
			expect(ChildValue_2.Value).to.equal(2)
			v2.unmountVirtualNode(v5)
			expect(#v1:GetChildren()).to.equal(0)
		end)
		it("should throw if `target` is nil", function() --[[ Line: 625 | Upvalues: createElement (ref), Portal (ref), v2 (ref) ]]
			local v1 = createElement(Portal)
			expect(function() --[[ Line: 631 | Upvalues: v2 (ref), v1 (copy) ]]
				v2.mountVirtualNode(v1, nil, "Keys for Everyone")
			end).to.throw()
		end)
		it("should throw if `target` is not a Roblox instance", function() --[[ Line: 636 | Upvalues: createElement (ref), Portal (ref), v2 (ref) ]]
			local v1 = createElement(Portal, {
				target = {}
			})
			expect(function() --[[ Line: 643 | Upvalues: v2 (ref), v1 (copy) ]]
				v2.mountVirtualNode(v1, nil, "Unleash the keys!")
			end).to.throw()
		end)
		it("should recreate instances if `target` changes in an update", function() --[[ Line: 648 | Upvalues: createElement (ref), Portal (ref), v2 (ref) ]]
			local v1 = Instance.new("Folder")
			local v22 = Instance.new("Folder")
			local v3 = createElement(Portal, {
				target = v1
			}, {
				ChildValue = createElement("IntValue", {
					Value = 1
				})
			})
			local v4 = createElement(Portal, {
				target = v22
			}, {
				ChildValue = createElement("IntValue", {
					Value = 2
				})
			})
			local v5 = v2.mountVirtualNode(v3, nil, "Some Key")
			expect(#v1:GetChildren()).to.equal(1)
			expect(#v22:GetChildren()).to.equal(0)
			expect(v1.ChildValue.Value).to.equal(1)
			local v6 = v2.updateVirtualNode(v5, v4)
			expect(#v1:GetChildren()).to.equal(0)
			expect(#v22:GetChildren()).to.equal(1)
			expect(v22.ChildValue.Value).to.equal(2)
			v2.unmountVirtualNode(v6)
			expect(#v1:GetChildren()).to.equal(0)
			expect(#v22:GetChildren()).to.equal(0)
		end)
	end)
	describe("Fragments", function() --[[ Line: 693 | Upvalues: createFragment (copy), createElement (copy), v2 (copy) ]]
		it("should parent the fragment\'s elements into the fragment\'s parent", function() --[[ Line: 694 | Upvalues: createFragment (ref), createElement (ref), v2 (ref) ]]
			local v1 = Instance.new("Folder")
			local v3 = v2.mountVirtualNode(createFragment({
				key = createElement("IntValue", {
					Value = 1
				}),
				key2 = createElement("IntValue", {
					Value = 2
				})
			}), v1, "test")
			expect(v1:FindFirstChild("key")).to.be.ok()
			expect(v1.key.ClassName).to.equal("IntValue")
			expect(v1.key.Value).to.equal(1)
			expect(v1:FindFirstChild("key2")).to.be.ok()
			expect(v1.key2.ClassName).to.equal("IntValue")
			expect(v1.key2.Value).to.equal(2)
			v2.unmountVirtualNode(v3)
			expect(#v1:GetChildren()).to.equal(0)
		end)
		it("should allow sibling fragment to have common keys", function() --[[ Line: 721 | Upvalues: createElement (ref), createFragment (ref), v2 (ref) ]]
			local v1 = Instance.new("Folder")
			local function parent(p1) --[[ Line: 725 | Upvalues: createElement (ref), createFragment (ref) ]]
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
			local v22 = v2.mountVirtualNode(createElement(parent), v1, "Test")
			local v3 = v1.Test:GetChildren()
			expect(#v3).to.equal(4)
			local t = {}
			for k, v in pairs(v3) do
				expect(v.ClassName).to.equal("StringValue")
				t[v.Value] = 1 + (t[v.Value] or 0)
			end
			expect(t.A).to.equal(1)
			expect(t.B).to.equal(1)
			expect(t.C).to.equal(1)
			expect(t.D).to.equal(1)
			v2.unmountVirtualNode(v22)
			expect(#v1:GetChildren()).to.equal(0)
		end)
		it("should render nested fragments", function() --[[ Line: 769 | Upvalues: createFragment (ref), createElement (ref), v2 (ref) ]]
			local v1 = Instance.new("Folder")
			local v3 = v2.mountVirtualNode(createFragment({
				key = createFragment({
					TheValue = createElement("IntValue", {
						Value = 1
					}),
					TheOtherValue = createElement("IntValue", {
						Value = 2
					})
				})
			}), v1, "Test")
			expect(v1:FindFirstChild("TheValue")).to.be.ok()
			expect(v1.TheValue.ClassName).to.equal("IntValue")
			expect(v1.TheValue.Value).to.equal(1)
			expect(v1:FindFirstChild("TheOtherValue")).to.be.ok()
			expect(v1.TheOtherValue.ClassName).to.equal("IntValue")
			expect(v1.TheOtherValue.Value).to.equal(2)
			v2.unmountVirtualNode(v3)
			expect(#v1:GetChildren()).to.equal(0)
		end)
		it("should not add any instances if the fragment is empty", function() --[[ Line: 798 | Upvalues: v2 (ref), createFragment (ref) ]]
			local v1 = Instance.new("Folder")
			local v22 = v2.mountVirtualNode(createFragment({}), v1, "test")
			expect(#v1:GetChildren()).to.equal(0)
			v2.unmountVirtualNode(v22)
			expect(#v1:GetChildren()).to.equal(0)
		end)
	end)
	describe("Context", function() --[[ Line: 811 | Upvalues: Component (copy), createElement (copy), v2 (copy), assertDeepEqual (copy), Children (copy), Portal (copy) ]]
		it("should pass context values through Roblox host nodes", function() --[[ Line: 812 | Upvalues: Component (ref), createElement (ref), v2 (ref), assertDeepEqual (ref) ]]
			local v1 = Component:extend("Consumer")
			local v22 = nil
			function v1.init(p1) --[[ Line: 816 | Upvalues: v22 (ref) ]]
				v22 = {
					hello = p1:__getContext("hello")
				}
			end
			function v1.render(p1) --[[ Line: 822 ]] end
			local t = {
				hello = "world"
			}
			local v4 = v2.mountVirtualNode(createElement("Folder", nil, {
				Consumer = createElement(v1)
			}), nil, "Context Test", t)
			expect(v22).never.to.equal(t)
			assertDeepEqual(v22, t)
			v2.unmountVirtualNode(v4)
		end)
		it("should pass context values through portal nodes", function() --[[ Line: 840 | Upvalues: Component (ref), createElement (ref), Children (ref), Portal (ref), v2 (ref), assertDeepEqual (ref) ]]
			local v1 = Instance.new("Folder")
			local v22 = Component:extend("Provider")
			function v22.init(p1) --[[ Line: 845 ]]
				p1:__addContext("foo", "bar")
			end
			function v22.render(p1) --[[ Line: 849 | Upvalues: createElement (ref), Children (ref) ]]
				return createElement("Folder", nil, p1.props[Children])
			end
			local v3 = Component:extend("Consumer")
			local v4 = nil
			function v3.init(p1) --[[ Line: 856 | Upvalues: v4 (ref) ]]
				v4 = {
					foo = p1:__getContext("foo")
				}
			end
			function v3.render(p1) --[[ Line: 862 ]]
				return nil
			end
			v2.mountVirtualNode(createElement(v22, nil, {
				Portal = createElement(Portal, {
					target = v1
				}, {
					Consumer = createElement(v3)
				})
			}), nil, "Some Key")
			assertDeepEqual(v4, {
				foo = "bar"
			})
		end)
	end)
	describe("Legacy context", function() --[[ Line: 883 | Upvalues: Component (copy), createElement (copy), v2 (copy), assertDeepEqual (copy), Children (copy), Portal (copy) ]]
		it("should pass context values through Roblox host nodes", function() --[[ Line: 884 | Upvalues: Component (ref), createElement (ref), v2 (ref), assertDeepEqual (ref) ]]
			local v1 = Component:extend("Consumer")
			local v22 = nil
			function v1.init(p1) --[[ Line: 888 | Upvalues: v22 (ref) ]]
				v22 = p1._context
			end
			function v1.render(p1) --[[ Line: 892 ]] end
			local t = {
				hello = "world"
			}
			local v4 = v2.mountVirtualNode(createElement("Folder", nil, {
				Consumer = createElement(v1)
			}), nil, "Context Test", nil, t)
			expect(v22).never.to.equal(t)
			assertDeepEqual(v22, t)
			v2.unmountVirtualNode(v4)
		end)
		it("should pass context values through portal nodes", function() --[[ Line: 910 | Upvalues: Component (ref), createElement (ref), Children (ref), Portal (ref), v2 (ref), assertDeepEqual (ref) ]]
			local v1 = Instance.new("Folder")
			local v22 = Component:extend("Provider")
			function v22.init(p1) --[[ Line: 915 ]]
				p1._context.foo = "bar"
			end
			function v22.render(p1) --[[ Line: 919 | Upvalues: createElement (ref), Children (ref) ]]
				return createElement("Folder", nil, p1.props[Children])
			end
			local v3 = Component:extend("Consumer")
			local v4 = nil
			function v3.init(p1) --[[ Line: 926 | Upvalues: v4 (ref) ]]
				v4 = p1._context
			end
			function v3.render(p1) --[[ Line: 930 ]]
				return nil
			end
			v2.mountVirtualNode(createElement(v22, nil, {
				Portal = createElement(Portal, {
					target = v1
				}, {
					Consumer = createElement(v3)
				})
			}), nil, "Some Key")
			assertDeepEqual(v4, {
				foo = "bar"
			})
		end)
	end)
	describe("Integration Tests", function() --[[ Line: 951 | Upvalues: ReplicatedStorage (copy), Component (copy), createElement (copy), v1 (copy), v2 (copy) ]]
		local v12 = nil
		beforeEach(function() --[[ Line: 953 | Upvalues: v12 (ref), ReplicatedStorage (ref) ]]
			v12 = Instance.new("Folder")
			v12.Parent = ReplicatedStorage
		end)
		afterEach(function() --[[ Line: 958 | Upvalues: v12 (ref) ]]
			v12:Destroy()
			v12 = nil
		end)
		it("should not allow re-entrancy in updateChildren", function() --[[ Line: 963 | Upvalues: Component (ref), createElement (ref), v1 (ref), v12 (ref), v2 (ref) ]]
			local v13 = Component:extend("ChildComponent")
			function v13.init(p1) --[[ Line: 966 ]]
				p1:setState({
					firstTime = true
				})
			end
			local v22 = nil
			function v13.render(p1) --[[ Line: 974 | Upvalues: createElement (ref) ]]
				if p1.state.firstTime then
					return createElement("Frame")
				else
					return createElement("TextLabel")
				end
			end
			function v13.didMount(p1) --[[ Line: 982 | Upvalues: v22 (ref) ]]
				v22 = coroutine.create(function() --[[ Line: 983 | Upvalues: p1 (copy) ]]
					p1:setState({
						firstTime = false
					})
				end)
			end
			local v3 = Component:extend("ParentComponent")
			function v3.init(p1) --[[ Line: 992 ]]
				p1:setState({
					count = 1
				})
				function p1.childAdded() --[[ Line: 997 | Upvalues: p1 (copy) ]]
					p1:setState({
						count = p1.state.count + 1
					})
				end
			end
			function v3.render(p1) --[[ Line: 1004 | Upvalues: createElement (ref), v1 (ref), v13 (copy) ]]
				return createElement("Frame", {
					[v1.ChildAdded] = p1.childAdded
				}, {
					ChildComponent = createElement(v13, {
						count = p1.state.count
					})
				})
			end
			local ScreenGui = Instance.new("ScreenGui")
			ScreenGui.Parent = v12
			local v5 = v2.mountVirtualNode(createElement(v3), ScreenGui, "Some Key")
			coroutine.resume(v22)
			expect(#ScreenGui:GetChildren()).to.equal(1)
			expect(#ScreenGui:GetChildren()[1]:GetChildren()).to.equal(1)
			v2.unmountVirtualNode(v5)
		end)
		it("should not allow re-entrancy in updateChildren even with callbacks", function() --[[ Line: 1033 | Upvalues: Component (ref), createElement (ref), v12 (ref), v2 (ref) ]]
			local v1 = Component:extend("LowestComponent")
			function v1.render(p1) --[[ Line: 1036 | Upvalues: createElement (ref) ]]
				return createElement("Frame")
			end
			function v1.didMount(p1) --[[ Line: 1040 ]]
				p1.props.onDidMountCallback()
			end
			local v22 = Component:extend("ChildComponent")
			function v22.init(p1) --[[ Line: 1046 ]]
				p1:setState({
					firstTime = true
				})
			end
			local v3 = nil
			function v22.render(p1) --[[ Line: 1054 | Upvalues: createElement (ref), v1 (copy) ]]
				if p1.state.firstTime then
					return createElement("Frame")
				else
					return createElement(v1, {
						onDidMountCallback = p1.props.onDidMountCallback
					})
				end
			end
			function v22.didMount(p1) --[[ Line: 1064 | Upvalues: v3 (ref) ]]
				v3 = coroutine.create(function() --[[ Line: 1065 | Upvalues: p1 (copy) ]]
					p1:setState({
						firstTime = false
					})
				end)
			end
			local v4 = Component:extend("ParentComponent")
			local v5 = 0
			function v4.init(p1) --[[ Line: 1076 | Upvalues: v5 (ref) ]]
				p1:setState({
					count = 1
				})
				function p1.onDidMountCallback() --[[ Line: 1081 | Upvalues: v5 (ref), p1 (copy) ]]
					v5 = v5 + 1
					if p1.state.count < 5 then
						p1:setState({
							count = p1.state.count + 1
						})
					end
				end
			end
			function v4.render(p1) --[[ Line: 1091 | Upvalues: createElement (ref), v22 (copy) ]]
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
		it("should never call unmount twice in the case of update children re-rentrancy", function() --[[ Line: 1123 | Upvalues: Component (ref), createElement (ref), v12 (ref), v2 (ref) ]]
			local tbl = {}
			local function addUnmount(p1) --[[ Line: 1126 | Upvalues: tbl (copy) ]]
				tbl[p1] = tbl[p1] + 1
			end
			local function addInit(p1) --[[ Line: 1130 | Upvalues: tbl (copy) ]]
				tbl[p1] = 0
			end
			local v1 = Component:extend("LowestComponent")
			function v1.init(p1) --[[ Line: 1135 | Upvalues: tbl (copy) ]]
				tbl[tostring(p1)] = 0
			end
			function v1.render(p1) --[[ Line: 1139 | Upvalues: createElement (ref) ]]
				return createElement("Frame")
			end
			function v1.didMount(p1) --[[ Line: 1143 ]]
				p1.props.onDidMountCallback()
			end
			function v1.willUnmount(p1) --[[ Line: 1147 | Upvalues: tbl (copy) ]]
				local v1 = tostring(p1)
				tbl[v1] = tbl[v1] + 1
			end
			local v22 = Component:extend("FirstComponent")
			function v22.init(p1) --[[ Line: 1152 | Upvalues: tbl (copy) ]]
				tbl[tostring(p1)] = 0
			end
			function v22.render(p1) --[[ Line: 1156 | Upvalues: createElement (ref) ]]
				return createElement("TextLabel")
			end
			function v22.willUnmount(p1) --[[ Line: 1160 | Upvalues: tbl (copy) ]]
				local v1 = tostring(p1)
				tbl[v1] = tbl[v1] + 1
			end
			local v3 = Component:extend("ChildComponent")
			function v3.init(p1) --[[ Line: 1166 | Upvalues: tbl (copy) ]]
				tbl[tostring(p1)] = 0
				p1:setState({
					firstTime = true
				})
			end
			local v4 = nil
			function v3.render(p1) --[[ Line: 1176 | Upvalues: createElement (ref), v22 (copy), v1 (copy) ]]
				if p1.state.firstTime then
					return createElement(v22)
				else
					return createElement(v1, {
						onDidMountCallback = p1.props.onDidMountCallback
					})
				end
			end
			function v3.didMount(p1) --[[ Line: 1186 | Upvalues: v4 (ref) ]]
				v4 = coroutine.create(function() --[[ Line: 1187 | Upvalues: p1 (copy) ]]
					p1:setState({
						firstTime = false
					})
				end)
			end
			function v3.willUnmount(p1) --[[ Line: 1194 | Upvalues: tbl (copy) ]]
				local v1 = tostring(p1)
				tbl[v1] = tbl[v1] + 1
			end
			local v5 = Component:extend("ParentComponent")
			local v6 = 0
			function v5.init(p1) --[[ Line: 1202 | Upvalues: v6 (ref) ]]
				p1:setState({
					count = 1
				})
				function p1.onDidMountCallback() --[[ Line: 1207 | Upvalues: v6 (ref), p1 (copy) ]]
					v6 = v6 + 1
					if p1.state.count < 5 then
						p1:setState({
							count = p1.state.count + 1
						})
					end
				end
			end
			function v5.render(p1) --[[ Line: 1217 | Upvalues: createElement (ref), v3 (copy) ]]
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
		it("should never unmount a node unnecesarily in the case of re-rentry", function() --[[ Line: 1253 | Upvalues: Component (ref), createElement (ref), v12 (ref), v2 (ref) ]]
			local v1 = Component:extend("LowestComponent")
			function v1.render(p1) --[[ Line: 1255 | Upvalues: createElement (ref) ]]
				return createElement("Frame")
			end
			function v1.didUpdate(p1, p2, p3) --[[ Line: 1259 ]]
				if p2.firstTime and not p1.props.firstTime then
					p1.props.onChangedCallback()
				end
			end
			local v22 = Component:extend("ChildComponent")
			function v22.init(p1) --[[ Line: 1267 ]]
				p1:setState({
					firstTime = true
				})
			end
			local v3 = nil
			function v22.render(p1) --[[ Line: 1275 | Upvalues: createElement (ref), v1 (copy) ]]
				return createElement(v1, {
					firstTime = p1.state.firstTime,
					onChangedCallback = p1.props.onChangedCallback
				})
			end
			function v22.didMount(p1) --[[ Line: 1282 | Upvalues: v3 (ref) ]]
				v3 = coroutine.create(function() --[[ Line: 1283 | Upvalues: p1 (copy) ]]
					p1:setState({
						firstTime = false
					})
				end)
			end
			local v4 = Component:extend("ParentComponent")
			local v5 = 0
			function v4.init(p1) --[[ Line: 1294 | Upvalues: v5 (ref) ]]
				p1:setState({
					count = 1
				})
				function p1.onChangedCallback() --[[ Line: 1299 | Upvalues: v5 (ref), p1 (copy) ]]
					v5 = v5 + 1
					if p1.state.count < 5 then
						p1:setState({
							count = p1.state.count + 1
						})
					end
				end
			end
			function v4.render(p1) --[[ Line: 1309 | Upvalues: createElement (ref), v22 (copy) ]]
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