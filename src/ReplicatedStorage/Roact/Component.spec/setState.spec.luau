-- Reviewed by Claude
return function()
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local createSpy = require(script.Parent.Parent.createSpy)
	local None = require(script.Parent.Parent.None)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local Component = require(script.Parent.Parent.Component)
	local v1 = createReconciler(NoopRenderer)
	describe("setState", function()
		it("should not trigger an extra update when called in init", function()
			local v12 = 0
			local v2 = 0
			local fn = nil
			local v4 = Component:extend("InitComponent")
			function v4.init(p1)
				p1:setState({
					a = 1
				})
			end
			function v4.willUpdate(p1)
				v2 = v2 + 1
			end
			function v4.render(p1)
				v12 = v12 + 1
				fn = p1.state
				return nil
			end
			v1.mountVirtualTree((createElement(v4)))
			expect(v12).to.equal(1)
			expect(v2).to.equal(0)
			expect(fn.a).to.equal(1)
		end)
		it("should throw when called in render", function()
			local v12 = Component:extend("TestComponent")
			function v12.render(p1)
				p1:setState({
					a = 1
				})
			end
			local fn, v4 = pcall(v1.mountVirtualTree, (createElement(v12)))
			expect(fn).to.equal(false)
			expect(v4:match("render")).to.be.ok()
			expect(v4:match("TestComponent")).to.be.ok()
		end)
		it("should throw when called in shouldUpdate", function()
			local v12 = Component:extend("TestComponent")
			function v12.render(p1)
				return nil
			end
			function v12.shouldUpdate(p1)
				p1:setState({
					a = 1
				})
			end
			local v2 = createElement(v12)
			local fn = createElement(v12)
			local v5, v6 = pcall(v1.updateVirtualTree, v1.mountVirtualTree(v2), fn)
			expect(v5).to.equal(false)
			expect(v6:match("shouldUpdate")).to.be.ok()
			expect(v6:match("TestComponent")).to.be.ok()
		end)
		it("should throw when called in willUpdate", function()
			local v12 = Component:extend("TestComponent")
			function v12.render(p1)
				return nil
			end
			function v12.willUpdate(p1)
				p1:setState({
					a = 1
				})
			end
			local v2 = createElement(v12)
			local fn = createElement(v12)
			local v5, v6 = pcall(v1.updateVirtualTree, v1.mountVirtualTree(v2), fn)
			expect(v5).to.equal(false)
			expect(v6:match("willUpdate")).to.be.ok()
			expect(v6:match("TestComponent")).to.be.ok()
		end)
		it("should not throw when called in willUnmount", function()
			local v12 = Component:extend("TestComponent")
			function v12.render(p1)
				return nil
			end
			function v12.willUnmount(p1)
				p1:setState({
					a = 1
				})
			end
			local v4, _ = pcall(v1.unmountVirtualTree, (v1.mountVirtualTree((createElement(v12)))))
			expect(v4).to.equal(true)
		end)
		it("should remove values from state when the value is None", function()
			local v12 = Component:extend("TestComponent")
			local v2 = nil
			local fn = nil
			function v12.init(p1)
				v2 = function(p12)
					p1:setState(p12)
				end
				fn = function()
					return p1.state
				end
				p1:setState({
					value = 0
				})
			end
			function v12.render(p1)
				return nil
			end
			local v5 = v1.mountVirtualNode(createElement(v12), nil, "Test")
			expect(fn().value).to.equal(0)
			v2({
				value = None
			})
			expect(fn().value).to.equal(nil)
			v1.unmountVirtualNode(v5)
		end)
		it("should invoke functions to compute a partial state", function()
			local v12 = Component:extend("TestComponent")
			local v2 = nil
			local fn = nil
			local v4 = nil
			function v12.init(p1)
				v2 = function(p12)
					p1:setState(p12)
				end
				fn = function()
					return p1.state
				end
				v4 = function()
					return p1.props
				end
				p1:setState({
					value = 0
				})
			end
			function v12.render(p1)
				return nil
			end
			local v6 = v1.mountVirtualNode(createElement(v12), nil, "Test")
			expect(fn().value).to.equal(0)
			v2(function(p1, p2)
				expect(p1).to.equal(fn())
				expect(p2).to.equal(v4())
				return {
					value = p1.value + 1
				}
			end)
			expect(fn().value).to.equal(1)
			v1.unmountVirtualNode(v6)
		end)
		it("should cancel rendering if the function returns nil", function()
			local v12 = Component:extend("TestComponent")
			local v2 = nil
			local fn = 0
			function v12.init(p1)
				v2 = function(p12)
					p1:setState(p12)
				end
				p1:setState({
					value = 0
				})
			end
			function v12.render(p1)
				fn = fn + 1
				return nil
			end
			local v5 = v1.mountVirtualNode(createElement(v12), nil, "Test")
			expect(fn).to.equal(1)
			v2(function(p1, p2)
				return nil
			end)
			expect(fn).to.equal(1)
			v1.unmountVirtualNode(v5)
		end)
	end)
	describe("setState suspension", function()
		it("should defer setState triggered while reconciling", function()
			local v12 = Component:extend("Child")
			local v2 = nil
			function v12.render(p1)
				return nil
			end
			function v12.didMount(p1)
				p1.props.callback()
			end
			local fn = Component:extend("Parent")
			function fn.init(p1)
				v2 = function()
					return p1.state
				end
			end
			function fn.render(p1)
				return createElement(v12, {
					callback = function()
						p1:setState({
							foo = "bar"
						})
					end
				})
			end
			expect((v1.mountVirtualNode(createElement(fn), nil, "Test"))).to.be.ok()
			expect(v2().foo).to.equal("bar")
		end)
		it("should defer setState triggered while reconciling during an update", function()
			local v12 = Component:extend("Child")
			local v2 = nil
			function v12.render(p1)
				return nil
			end
			function v12.didUpdate(p1)
				p1.props.callback()
			end
			local fn = Component:extend("Parent")
			function fn.init(p1)
				v2 = function()
					return p1.state
				end
			end
			function fn.render(p1)
				return createElement(v12, {
					callback = function()
						if not p1.state.foo then
							p1:setState({
								foo = "bar"
							})
						end
					end
				})
			end
			local v5 = v1.mountVirtualNode(createElement(fn), nil, "Test")
			expect(v5).to.be.ok()
			expect(v2().foo).to.equal(nil)
			local v6 = v1.updateVirtualNode(v5, createElement(fn))
			expect(v6).to.be.ok()
			expect(v2().foo).to.equal("bar")
			v1.unmountVirtualNode(v6)
		end)
		it("should combine pending state changes properly", function()
			local v12 = Component:extend("Child")
			local v2 = nil
			function v12.render(p1)
				return nil
			end
			function v12.didMount(p1)
				p1.props.callback("foo", 1)
				p1.props.callback("bar", 3)
			end
			local fn = Component:extend("Parent")
			function fn.init(p1)
				v2 = function()
					return p1.state
				end
			end
			function fn.render(p1)
				return createElement(v12, {
					callback = function(p12, p2)
						p1:setState({
							[p12] = p2
						})
					end
				})
			end
			local v5 = v1.mountVirtualNode(createElement(fn), nil, "Test")
			expect(v5).to.be.ok()
			expect(v2().foo).to.equal(1)
			expect(v2().bar).to.equal(3)
			v1.unmountVirtualNode(v5)
		end)
		it("should abort properly when functional setState returns nil while deferred", function()
			local v12 = Component:extend("Child")
			function v12.render(p1)
				return nil
			end
			function v12.didMount(p1)
				p1.props.callback()
			end
			local v2 = Component:extend("Parent")
			local fn = createSpy(function(p1)
				return createElement(v12, {
					callback = function()
						p1:setState(function()
							return nil
						end)
					end
				})
			end)
			v2.render = fn.value
			local v5 = v1.mountVirtualNode(createElement(v2), nil, "Test")
			expect(v5).to.be.ok()
			expect(fn.callCount).to.equal(1)
			v1.unmountVirtualNode(v5)
		end)
		it("should still apply pending state if a subsequent state update was aborted", function()
			local v12 = Component:extend("Child")
			local v2 = nil
			function v12.render(p1)
				return nil
			end
			function v12.didMount(p1)
				p1.props.callback(function()
					return {
						foo = 1
					}
				end)
				p1.props.callback(function()
					return nil
				end)
			end
			local fn = Component:extend("Parent")
			function fn.init(p1)
				v2 = function()
					return p1.state
				end
			end
			function fn.render(p1)
				return createElement(v12, {
					callback = function(p12)
						p1:setState(p12)
					end
				})
			end
			local v5 = v1.mountVirtualNode(createElement(fn), nil, "Test")
			expect(v5).to.be.ok()
			expect(v2().foo).to.equal(1)
			v1.unmountVirtualNode(v5)
		end)
		it("should not re-process new state when pending state is present after update", function()
			local v12 = nil
			local v2 = nil
			local fn = Component:extend("MyComponent")
			function fn.init(p1)
				p1:setState({
					hasUpdatedOnce = false,
					counter = 0
				})
				v12 = function(p12)
					p1:setState(p12)
				end
				v2 = function()
					return p1.state
				end
			end
			function fn.render(p1)
				return nil
			end
			function fn.didUpdate(p1)
				if p1.state.hasUpdatedOnce == false then
					p1:setState({
						hasUpdatedOnce = true
					})
				end
			end
			v1.mountVirtualNode(createElement(fn), nil, "Test")
			expect(v2().hasUpdatedOnce).to.equal(false)
			expect(v2().counter).to.equal(0)
			v12(function(p1)
				return {
					counter = p1.counter + 1
				}
			end)
			expect(v2().hasUpdatedOnce).to.equal(true)
			expect(v2().counter).to.equal(1)
		end)
		it("should throw when an infinite update is triggered", function()
			local v12 = Component:extend("InfiniteUpdater")
			function v12.render(p1)
				return nil
			end
			function v12.didMount(p1)
				p1:setState({})
			end
			function v12.didUpdate(p1)
				p1:setState({})
			end
			local fn, v4 = pcall(v1.mountVirtualNode, createElement(v12), nil, "Test")
			expect(fn).to.equal(false)
			expect(v4:find("InfiniteUpdater")).to.be.ok()
			expect(v4:find("reached the setState update recursion limit")).to.be.ok()
		end)
		itSKIP("should process single updates with both new and pending state", function()  end)
		it("should call trigger update after didMount when setting state in didMount", function()
			local v12 = Component:extend("MyComponent")
			function v12.init(p1)
				p1:setState({
					status = "initial mount"
				})
				p1.isMounted = false
			end
			function v12.render(p1)
				return nil
			end
			function v12.didMount(p1)
				p1:setState({
					status = "mounted"
				})
				p1.isMounted = true
			end
			function v12.didUpdate(p1, p2, p3)
				expect(p3.status).to.equal("initial mount")
				expect(p1.state.status).to.equal("mounted")
				expect(p1.isMounted).to.equal(true)
			end
			expect((v1.mountVirtualNode(createElement(v12), nil, "Test"))).to.be.ok()
		end)
	end)
end
