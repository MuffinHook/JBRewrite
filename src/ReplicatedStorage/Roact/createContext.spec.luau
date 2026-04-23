return function() --[[ Line: 1 ]]
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
	local v2 = createReconciler((require(script.Parent.RobloxRenderer)))
	it("should return a table", function() --[[ Line: 18 | Upvalues: createContext (copy) ]]
		local v1 = createContext("Test")
		expect(v1).to.be.ok()
		expect((type(v1))).to.equal("table")
	end)
	it("should contain a Provider and a Consumer", function() --[[ Line: 24 | Upvalues: createContext (copy) ]]
		local v1 = createContext("Test")
		expect(v1.Provider).to.be.ok()
		expect(v1.Consumer).to.be.ok()
	end)
	describe("Provider", function() --[[ Line: 30 | Upvalues: createContext (copy), createSpy (copy), createElement (copy), v1 (copy) ]]
		it("should render its children", function() --[[ Line: 31 | Upvalues: createContext (ref), createSpy (ref), createElement (ref), v1 (ref) ]]
			local v12 = createContext("Test")
			local v2 = createSpy(function() --[[ Line: 34 ]]
				return nil
			end)
			v1.unmountVirtualTree((v1.mountVirtualTree(createElement(v12.Provider, {
				value = "Test"
			}, {
				Listener = createElement(v2.value)
			}), nil, "Provide Tree")))
			expect(v2.callCount).to.equal(1)
		end)
	end)
	describe("Consumer", function() --[[ Line: 51 | Upvalues: createContext (copy), createElement (copy), v1 (copy), createSpy (copy), Component (copy), createFragment (copy), Children (copy) ]]
		it("should expect a render function", function() --[[ Line: 52 | Upvalues: createContext (ref), createElement (ref), v1 (ref) ]]
			local v12 = createElement(createContext("Test").Consumer)
			expect(function() --[[ Line: 56 | Upvalues: v1 (ref), v12 (copy) ]]
				v1.mountVirtualTree(v12, nil, "Provide Tree")
			end).to.throw()
		end)
		it("should return the default value if there is no Provider", function() --[[ Line: 61 | Upvalues: createSpy (ref), createContext (ref), createElement (ref), v1 (ref) ]]
			local v12 = createSpy()
			v1.unmountVirtualTree((v1.mountVirtualTree(createElement(createContext("Test").Consumer, {
				render = v12.value
			}), nil, "Provide Tree")))
			v12:assertCalledWith("Test")
		end)
		it("should pass the value to the render function", function() --[[ Line: 75 | Upvalues: createSpy (ref), createContext (ref), createElement (ref), v1 (ref) ]]
			local v12 = createSpy()
			local v2 = createContext("Test")
			local function Listener() --[[ Line: 79 | Upvalues: createElement (ref), v2 (copy), v12 (copy) ]]
				return createElement(v2.Consumer, {
					render = v12.value
				})
			end
			v1.unmountVirtualTree((v1.mountVirtualTree(createElement(v2.Provider, {
				value = "NewTest"
			}, {
				Listener = createElement(Listener)
			}), nil, "Provide Tree")))
			v12:assertCalledWith("NewTest")
		end)
		it("should update when the value updates", function() --[[ Line: 97 | Upvalues: createSpy (ref), createContext (ref), createElement (ref), v1 (ref) ]]
			local v12 = createSpy()
			local v2 = createContext("Test")
			local function Listener() --[[ Line: 101 | Upvalues: createElement (ref), v2 (copy), v12 (copy) ]]
				return createElement(v2.Consumer, {
					render = v12.value
				})
			end
			local v4 = v1.mountVirtualTree(createElement(v2.Provider, {
				value = "NewTest"
			}, {
				Listener = createElement(Listener)
			}), nil, "Provide Tree")
			expect(v12.callCount).to.equal(1)
			v12:assertCalledWith("NewTest")
			v1.updateVirtualTree(v4, createElement(v2.Provider, {
				value = "ThirdTest"
			}, {
				Listener = createElement(Listener)
			}))
			expect(v12.callCount).to.equal(2)
			v12:assertCalledWith("ThirdTest")
			v1.unmountVirtualTree(v4)
		end)
		it("should update when the value updates through an update blocking component", function() --[[ Line: 138 | Upvalues: createSpy (ref), createContext (ref), Component (ref), createFragment (ref), Children (ref), createElement (ref), v1 (ref) ]]
			local v12 = createSpy()
			local v2 = createContext("Test")
			local v3 = Component:extend("UpdateBlocker")
			function v3.render(p1) --[[ Line: 144 | Upvalues: createFragment (ref), Children (ref) ]]
				return createFragment(p1.props[Children])
			end
			function v3.shouldUpdate(p1) --[[ Line: 148 ]]
				return false
			end
			local function Listener() --[[ Line: 152 | Upvalues: createElement (ref), v2 (copy), v12 (copy) ]]
				return createElement(v2.Consumer, {
					render = v12.value
				})
			end
			local v5 = v1.mountVirtualTree(createElement(v2.Provider, {
				value = "NewTest"
			}, {
				Blocker = createElement(v3, nil, {
					Listener = createElement(Listener)
				})
			}), nil, "Provide Tree")
			expect(v12.callCount).to.equal(1)
			v12:assertCalledWith("NewTest")
			v1.updateVirtualTree(v5, createElement(v2.Provider, {
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
		it("should behave correctly when the default value is nil", function() --[[ Line: 188 | Upvalues: createContext (ref), createSpy (ref), createElement (ref), v1 (ref) ]]
			local v12 = createContext(nil)
			local v2 = createSpy()
			local function Listener() --[[ Line: 192 | Upvalues: createElement (ref), v12 (copy), v2 (copy) ]]
				return createElement(v12.Consumer, {
					render = v2.value
				})
			end
			local v3 = v1.mountVirtualTree(createElement(Listener), nil, "Provide Tree")
			expect(v2.callCount).to.equal(1)
			v2:assertCalledWith(nil)
			v1.unmountVirtualTree((v1.updateVirtualTree(v3, createElement(Listener))))
			expect(v2.callCount).to.equal(2)
			v2:assertCalledWith(nil)
		end)
	end)
	describe("Update order", function() --[[ Line: 210 | Upvalues: createContext (copy), createElement (copy), v1 (copy) ]]
		it("should update context at the same time as props", function() --[[ Line: 264 | Upvalues: createContext (ref), createElement (ref), v1 (ref) ]]
			local v12 = false
			local v2 = false
			local v3 = 0
			local v4 = createContext("default")
			local function Listener(p1) --[[ Line: 273 | Upvalues: createElement (ref), v4 (copy), v3 (ref), v12 (ref), v2 (ref) ]]
				return createElement(v4.Consumer, {
					render = function(p12) --[[ Name: render | Line: 275 | Upvalues: v3 (ref), p1 (copy), v12 (ref), v2 (ref) ]]
						v3 = v3 + 1
						if p12 == "context_1" then
							expect(p1.someProp).to.equal("prop_1")
							v12 = true
						elseif p12 == "context_2" then
							expect(p1.someProp).to.equal("prop_2")
							v2 = true
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
			expect(v2).to.equal(true)
		end)
	end)
	it("does not throw if willUnmount is called twice on a context consumer", function() --[[ Line: 317 | Upvalues: createContext (copy), Component (copy), createElement (copy), ReplicatedStorage (copy), v2 (copy) ]]
		local v1 = createContext({})
		local v22 = Component:extend("LowestComponent")
		function v22.init(p1) --[[ Line: 321 ]] end
		function v22.render(p1) --[[ Line: 323 | Upvalues: createElement (ref) ]]
			return createElement("Frame")
		end
		function v22.didMount(p1) --[[ Line: 327 ]]
			p1.props.onDidMountCallback()
		end
		local v3 = Component:extend("FirstComponent")
		function v3.init(p1) --[[ Line: 332 ]] end
		function v3.render(p1) --[[ Line: 334 | Upvalues: createElement (ref), v1 (copy) ]]
			return createElement(v1.Consumer, {
				render = function() --[[ Name: render | Line: 336 | Upvalues: createElement (ref) ]]
					return createElement("TextLabel")
				end
			})
		end
		local v4 = Component:extend("ChildComponent")
		function v4.init(p1) --[[ Line: 344 ]]
			p1:setState({
				firstTime = true
			})
		end
		local v5 = nil
		function v4.render(p1) --[[ Line: 350 | Upvalues: createElement (ref), v3 (copy), v22 (copy) ]]
			if p1.state.firstTime then
				return createElement(v3)
			else
				return createElement(v22, {
					onDidMountCallback = p1.props.onDidMountCallback
				})
			end
		end
		function v4.didMount(p1) --[[ Line: 360 | Upvalues: v5 (ref) ]]
			v5 = function() --[[ Line: 361 | Upvalues: p1 (copy) ]]
				p1:setState({
					firstTime = false
				})
			end
		end
		local v6 = Component:extend("ParentComponent")
		local v7 = 0
		function v6.init(p1) --[[ Line: 370 | Upvalues: v7 (ref) ]]
			p1:setState({
				count = 1
			})
			function p1.onDidMountCallback() --[[ Line: 373 | Upvalues: v7 (ref), p1 (copy) ]]
				v7 = v7 + 1
				if p1.state.count < 5 then
					p1:setState({
						count = p1.state.count + 1
					})
				end
			end
		end
		function v6.render(p1) --[[ Line: 381 | Upvalues: createElement (ref), v1 (copy), v4 (copy) ]]
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
		v2.mountVirtualNode(createElement(v6), ScreenGui, "Some Key")
		expect(function() --[[ Line: 400 | Upvalues: v5 (ref) ]]
			v5()
		end).never.to.throw()
	end)
end