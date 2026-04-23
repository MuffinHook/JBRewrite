return function() --[[ Line: 1 ]]
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local createSpy = require(script.Parent.Parent.createSpy)
	local None = require(script.Parent.Parent.None)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local Component = require(script.Parent.Parent.Component)
	local v1 = createReconciler(NoopRenderer)
	describe("setState", function() --[[ Line: 12 | Upvalues: Component (copy), createElement (copy), v1 (copy), None (copy) ]]
		it("should not trigger an extra update when called in init", function() --[[ Line: 13 | Upvalues: Component (ref), createElement (ref), v1 (ref) ]]
			local v12 = 0
			local v2 = 0
			local v3 = nil
			local v4 = Component:extend("InitComponent")
			function v4.init(p1) --[[ Line: 20 ]]
				p1:setState({
					a = 1
				})
			end
			function v4.willUpdate(p1) --[[ Line: 26 | Upvalues: v2 (ref) ]]
				v2 = v2 + 1
			end
			function v4.render(p1) --[[ Line: 30 | Upvalues: v12 (ref), v3 (ref) ]]
				v12 = v12 + 1
				v3 = p1.state
				return nil
			end
			v1.mountVirtualTree((createElement(v4)))
			expect(v12).to.equal(1)
			expect(v2).to.equal(0)
			expect(v3.a).to.equal(1)
		end)
		it("should throw when called in render", function() --[[ Line: 45 | Upvalues: Component (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("TestComponent")
			function v12.render(p1) --[[ Line: 48 ]]
				p1:setState({
					a = 1
				})
			end
			local v3, v4 = pcall(v1.mountVirtualTree, (createElement(v12)))
			expect(v3).to.equal(false)
			expect(v4:match("render")).to.be.ok()
			expect(v4:match("TestComponent")).to.be.ok()
		end)
		it("should throw when called in shouldUpdate", function() --[[ Line: 63 | Upvalues: Component (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("TestComponent")
			function v12.render(p1) --[[ Line: 66 ]]
				return nil
			end
			function v12.shouldUpdate(p1) --[[ Line: 70 ]]
				p1:setState({
					a = 1
				})
			end
			local v2 = createElement(v12)
			local v3 = createElement(v12)
			local v5, v6 = pcall(v1.updateVirtualTree, v1.mountVirtualTree(v2), v3)
			expect(v5).to.equal(false)
			expect(v6:match("shouldUpdate")).to.be.ok()
			expect(v6:match("TestComponent")).to.be.ok()
		end)
		it("should throw when called in willUpdate", function() --[[ Line: 88 | Upvalues: Component (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("TestComponent")
			function v12.render(p1) --[[ Line: 91 ]]
				return nil
			end
			function v12.willUpdate(p1) --[[ Line: 95 ]]
				p1:setState({
					a = 1
				})
			end
			local v2 = createElement(v12)
			local v3 = createElement(v12)
			local v5, v6 = pcall(v1.updateVirtualTree, v1.mountVirtualTree(v2), v3)
			expect(v5).to.equal(false)
			expect(v6:match("willUpdate")).to.be.ok()
			expect(v6:match("TestComponent")).to.be.ok()
		end)
		it("should not throw when called in willUnmount", function() --[[ Line: 112 | Upvalues: Component (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("TestComponent")
			function v12.render(p1) --[[ Line: 115 ]]
				return nil
			end
			function v12.willUnmount(p1) --[[ Line: 119 ]]
				p1:setState({
					a = 1
				})
			end
			local v4, _ = pcall(v1.unmountVirtualTree, (v1.mountVirtualTree((createElement(v12)))))
			expect(v4).to.equal(true)
		end)
		it("should remove values from state when the value is None", function() --[[ Line: 133 | Upvalues: Component (ref), createElement (ref), v1 (ref), None (ref) ]]
			local v12 = Component:extend("TestComponent")
			local v2 = nil
			local v3 = nil
			function v12.init(p1) --[[ Line: 137 | Upvalues: v2 (ref), v3 (ref) ]]
				v2 = function(p12) --[[ Line: 138 | Upvalues: p1 (copy) ]]
					p1:setState(p12)
				end
				v3 = function() --[[ Line: 142 | Upvalues: p1 (copy) ]]
					return p1.state
				end
				p1:setState({
					value = 0
				})
			end
			function v12.render(p1) --[[ Line: 151 ]]
				return nil
			end
			local v5 = v1.mountVirtualNode(createElement(v12), nil, "Test")
			expect(v3().value).to.equal(0)
			v2({
				value = None
			})
			expect(v3().value).to.equal(nil)
			v1.unmountVirtualNode(v5)
		end)
		it("should invoke functions to compute a partial state", function() --[[ Line: 169 | Upvalues: Component (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("TestComponent")
			local v2 = nil
			local v3 = nil
			local v4 = nil
			function v12.init(p1) --[[ Line: 173 | Upvalues: v2 (ref), v3 (ref), v4 (ref) ]]
				v2 = function(p12) --[[ Line: 174 | Upvalues: p1 (copy) ]]
					p1:setState(p12)
				end
				v3 = function() --[[ Line: 178 | Upvalues: p1 (copy) ]]
					return p1.state
				end
				v4 = function() --[[ Line: 182 | Upvalues: p1 (copy) ]]
					return p1.props
				end
				p1:setState({
					value = 0
				})
			end
			function v12.render(p1) --[[ Line: 191 ]]
				return nil
			end
			local v6 = v1.mountVirtualNode(createElement(v12), nil, "Test")
			expect(v3().value).to.equal(0)
			v2(function(p1, p2) --[[ Line: 200 | Upvalues: v3 (ref), v4 (ref) ]]
				expect(p1).to.equal(v3())
				expect(p2).to.equal(v4())
				return {
					value = p1.value + 1
				}
			end)
			expect(v3().value).to.equal(1)
			v1.unmountVirtualNode(v6)
		end)
		it("should cancel rendering if the function returns nil", function() --[[ Line: 214 | Upvalues: Component (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("TestComponent")
			local v2 = nil
			local v3 = 0
			function v12.init(p1) --[[ Line: 219 | Upvalues: v2 (ref) ]]
				v2 = function(p12) --[[ Line: 220 | Upvalues: p1 (copy) ]]
					p1:setState(p12)
				end
				p1:setState({
					value = 0
				})
			end
			function v12.render(p1) --[[ Line: 229 | Upvalues: v3 (ref) ]]
				v3 = v3 + 1
				return nil
			end
			local v5 = v1.mountVirtualNode(createElement(v12), nil, "Test")
			expect(v3).to.equal(1)
			v2(function(p1, p2) --[[ Line: 238 ]]
				return nil
			end)
			expect(v3).to.equal(1)
			v1.unmountVirtualNode(v5)
		end)
	end)
	describe("setState suspension", function() --[[ Line: 248 | Upvalues: Component (copy), createElement (copy), v1 (copy), createSpy (copy) ]]
		it("should defer setState triggered while reconciling", function() --[[ Line: 249 | Upvalues: Component (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("Child")
			local v2 = nil
			function v12.render(p1) --[[ Line: 253 ]]
				return nil
			end
			function v12.didMount(p1) --[[ Line: 257 ]]
				p1.props.callback()
			end
			local v3 = Component:extend("Parent")
			function v3.init(p1) --[[ Line: 263 | Upvalues: v2 (ref) ]]
				v2 = function() --[[ Line: 264 | Upvalues: p1 (copy) ]]
					return p1.state
				end
			end
			function v3.render(p1) --[[ Line: 269 | Upvalues: createElement (ref), v12 (copy) ]]
				return createElement(v12, {
					callback = function() --[[ Name: callback | Line: 271 | Upvalues: p1 (copy) ]]
						p1:setState({
							foo = "bar"
						})
					end
				})
			end
			expect((v1.mountVirtualNode(createElement(v3), nil, "Test"))).to.be.ok()
			expect(v2().foo).to.equal("bar")
		end)
		it("should defer setState triggered while reconciling during an update", function() --[[ Line: 289 | Upvalues: Component (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("Child")
			local v2 = nil
			function v12.render(p1) --[[ Line: 293 ]]
				return nil
			end
			function v12.didUpdate(p1) --[[ Line: 297 ]]
				p1.props.callback()
			end
			local v3 = Component:extend("Parent")
			function v3.init(p1) --[[ Line: 303 | Upvalues: v2 (ref) ]]
				v2 = function() --[[ Line: 304 | Upvalues: p1 (copy) ]]
					return p1.state
				end
			end
			function v3.render(p1) --[[ Line: 309 | Upvalues: createElement (ref), v12 (copy) ]]
				return createElement(v12, {
					callback = function() --[[ Name: callback | Line: 311 | Upvalues: p1 (copy) ]]
						if not p1.state.foo then
							p1:setState({
								foo = "bar"
							})
						end
					end
				})
			end
			local v5 = v1.mountVirtualNode(createElement(v3), nil, "Test")
			expect(v5).to.be.ok()
			expect(v2().foo).to.equal(nil)
			local v6 = v1.updateVirtualNode(v5, createElement(v3))
			expect(v6).to.be.ok()
			expect(v2().foo).to.equal("bar")
			v1.unmountVirtualNode(v6)
		end)
		it("should combine pending state changes properly", function() --[[ Line: 339 | Upvalues: Component (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("Child")
			local v2 = nil
			function v12.render(p1) --[[ Line: 343 ]]
				return nil
			end
			function v12.didMount(p1) --[[ Line: 347 ]]
				p1.props.callback("foo", 1)
				p1.props.callback("bar", 3)
			end
			local v3 = Component:extend("Parent")
			function v3.init(p1) --[[ Line: 354 | Upvalues: v2 (ref) ]]
				v2 = function() --[[ Line: 355 | Upvalues: p1 (copy) ]]
					return p1.state
				end
			end
			function v3.render(p1) --[[ Line: 360 | Upvalues: createElement (ref), v12 (copy) ]]
				return createElement(v12, {
					callback = function(p12, p2) --[[ Name: callback | Line: 362 | Upvalues: p1 (copy) ]]
						p1:setState({
							[p12] = p2
						})
					end
				})
			end
			local v5 = v1.mountVirtualNode(createElement(v3), nil, "Test")
			expect(v5).to.be.ok()
			expect(v2().foo).to.equal(1)
			expect(v2().bar).to.equal(3)
			v1.unmountVirtualNode(v5)
		end)
		it("should abort properly when functional setState returns nil while deferred", function() --[[ Line: 383 | Upvalues: Component (ref), createSpy (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("Child")
			function v12.render(p1) --[[ Line: 386 ]]
				return nil
			end
			function v12.didMount(p1) --[[ Line: 390 ]]
				p1.props.callback()
			end
			local v2 = Component:extend("Parent")
			local v3 = createSpy(function(p1) --[[ Line: 396 | Upvalues: createElement (ref), v12 (copy) ]]
				return createElement(v12, {
					callback = function() --[[ Name: callback | Line: 398 | Upvalues: p1 (copy) ]]
						p1:setState(function() --[[ Line: 399 ]]
							return nil
						end)
					end
				})
			end)
			v2.render = v3.value
			local v5 = v1.mountVirtualNode(createElement(v2), nil, "Test")
			expect(v5).to.be.ok()
			expect(v3.callCount).to.equal(1)
			v1.unmountVirtualNode(v5)
		end)
		it("should still apply pending state if a subsequent state update was aborted", function() --[[ Line: 421 | Upvalues: Component (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("Child")
			local v2 = nil
			function v12.render(p1) --[[ Line: 425 ]]
				return nil
			end
			function v12.didMount(p1) --[[ Line: 429 ]]
				p1.props.callback(function() --[[ Line: 430 ]]
					return {
						foo = 1
					}
				end)
				p1.props.callback(function() --[[ Line: 435 ]]
					return nil
				end)
			end
			local v3 = Component:extend("Parent")
			function v3.init(p1) --[[ Line: 442 | Upvalues: v2 (ref) ]]
				v2 = function() --[[ Line: 443 | Upvalues: p1 (copy) ]]
					return p1.state
				end
			end
			function v3.render(p1) --[[ Line: 448 | Upvalues: createElement (ref), v12 (copy) ]]
				return createElement(v12, {
					callback = function(p12) --[[ Name: callback | Line: 450 | Upvalues: p1 (copy) ]]
						p1:setState(p12)
					end
				})
			end
			local v5 = v1.mountVirtualNode(createElement(v3), nil, "Test")
			expect(v5).to.be.ok()
			expect(v2().foo).to.equal(1)
			v1.unmountVirtualNode(v5)
		end)
		it("should not re-process new state when pending state is present after update", function() --[[ Line: 468 | Upvalues: Component (ref), createElement (ref), v1 (ref) ]]
			local v12 = nil
			local v2 = nil
			local v3 = Component:extend("MyComponent")
			function v3.init(p1) --[[ Line: 474 | Upvalues: v12 (ref), v2 (ref) ]]
				p1:setState({
					hasUpdatedOnce = false,
					counter = 0
				})
				v12 = function(p12) --[[ Line: 480 | Upvalues: p1 (copy) ]]
					p1:setState(p12)
				end
				v2 = function() --[[ Line: 484 | Upvalues: p1 (copy) ]]
					return p1.state
				end
			end
			function v3.render(p1) --[[ Line: 489 ]]
				return nil
			end
			function v3.didUpdate(p1) --[[ Line: 493 ]]
				if p1.state.hasUpdatedOnce == false then
					p1:setState({
						hasUpdatedOnce = true
					})
				end
			end
			v1.mountVirtualNode(createElement(v3), nil, "Test")
			expect(v2().hasUpdatedOnce).to.equal(false)
			expect(v2().counter).to.equal(0)
			v12(function(p1) --[[ Line: 510 ]]
				return {
					counter = p1.counter + 1
				}
			end)
			expect(v2().hasUpdatedOnce).to.equal(true)
			expect(v2().counter).to.equal(1)
		end)
		it("should throw when an infinite update is triggered", function() --[[ Line: 520 | Upvalues: Component (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("InfiniteUpdater")
			function v12.render(p1) --[[ Line: 523 ]]
				return nil
			end
			function v12.didMount(p1) --[[ Line: 527 ]]
				p1:setState({})
			end
			function v12.didUpdate(p1) --[[ Line: 531 ]]
				p1:setState({})
			end
			local v3, v4 = pcall(v1.mountVirtualNode, createElement(v12), nil, "Test")
			expect(v3).to.equal(false)
			expect(v4:find("InfiniteUpdater")).to.be.ok()
			expect(v4:find("reached the setState update recursion limit")).to.be.ok()
		end)
		itSKIP("should process single updates with both new and pending state", function() --[[ Line: 546 ]] end)
		it("should call trigger update after didMount when setting state in didMount", function() --[[ Line: 553 | Upvalues: Component (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("MyComponent")
			function v12.init(p1) --[[ Line: 564 ]]
				p1:setState({
					status = "initial mount"
				})
				p1.isMounted = false
			end
			function v12.render(p1) --[[ Line: 572 ]]
				return nil
			end
			function v12.didMount(p1) --[[ Line: 576 ]]
				p1:setState({
					status = "mounted"
				})
				p1.isMounted = true
			end
			function v12.didUpdate(p1, p2, p3) --[[ Line: 584 ]]
				expect(p3.status).to.equal("initial mount")
				expect(p1.state.status).to.equal("mounted")
				expect(p1.isMounted).to.equal(true)
			end
			expect((v1.mountVirtualNode(createElement(v12), nil, "Test"))).to.be.ok()
		end)
	end)
end