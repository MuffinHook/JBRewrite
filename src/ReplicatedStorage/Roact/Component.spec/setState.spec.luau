-- Reviewed by Claude
-- variables reassigned
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
			local internalData = 0
			local v2 = 0
			local fn = nil
			local currentState = Component:extend("InitComponent")
			function currentState.init(self)
				self:setState({
					a = 1
				})
			end
			function currentState.willUpdate(self)
				v2 = v2 + 1
			end
			function currentState.render(self)
				internalData = internalData + 1
				fn = self.state
				return nil
			end
			v1.mountVirtualTree((createElement(currentState)))
			expect(internalData).to.equal(1)
			expect(v2).to.equal(0)
			expect(fn.a).to.equal(1)
		end)
		it("should throw when called in render", function()
			local internalData = Component:extend("TestComponent")
			function internalData.render(self)
				self:setState({
					a = 1
				})
			end
			local fn, currentState = pcall(v1.mountVirtualTree, (createElement(internalData)))
			expect(fn).to.equal(false)
			expect(currentState:match("render")).to.be.ok()
			expect(currentState:match("TestComponent")).to.be.ok()
		end)
		it("should throw when called in shouldUpdate", function()
			local internalData = Component:extend("TestComponent")
			function internalData.render(self)
				return nil
			end
			function internalData.shouldUpdate(self)
				self:setState({
					a = 1
				})
			end
			local v2 = createElement(internalData)
			local fn = createElement(internalData)
			local nextState, tempState = pcall(v1.updateVirtualTree, v1.mountVirtualTree(v2), fn)
			expect(nextState).to.equal(false)
			expect(tempState:match("shouldUpdate")).to.be.ok()
			expect(tempState:match("TestComponent")).to.be.ok()
		end)
		it("should throw when called in willUpdate", function()
			local internalData = Component:extend("TestComponent")
			function internalData.render(self)
				return nil
			end
			function internalData.willUpdate(self)
				self:setState({
					a = 1
				})
			end
			local v2 = createElement(internalData)
			local fn = createElement(internalData)
			local nextState, tempState = pcall(v1.updateVirtualTree, v1.mountVirtualTree(v2), fn)
			expect(nextState).to.equal(false)
			expect(tempState:match("willUpdate")).to.be.ok()
			expect(tempState:match("TestComponent")).to.be.ok()
		end)
		it("should not throw when called in willUnmount", function()
			local internalData = Component:extend("TestComponent")
			function internalData.render(self)
				return nil
			end
			function internalData.willUnmount(self)
				self:setState({
					a = 1
				})
			end
			local currentState, _ = pcall(v1.unmountVirtualTree, (v1.mountVirtualTree((createElement(internalData)))))
			expect(currentState).to.equal(true)
		end)
		it("should remove values from state when the value is None", function()
			local internalData = Component:extend("TestComponent")
			local v2 = nil
			local fn = nil
			function internalData.init(self)
				v2 = function(param12)
					self:setState(param12)
				end
				fn = function()
					return self.state
				end
				self:setState({
					value = 0
				})
			end
			function internalData.render(self)
				return nil
			end
			local nextState = v1.mountVirtualNode(createElement(internalData), nil, "Test")
			expect(fn().value).to.equal(0)
			v2({
				value = None
			})
			expect(fn().value).to.equal(nil)
			v1.unmountVirtualNode(nextState)
		end)
		it("should invoke functions to compute a partial state", function()
			local internalData = Component:extend("TestComponent")
			local v2 = nil
			local fn = nil
			local currentState = nil
			function internalData.init(self)
				v2 = function(param12)
					self:setState(param12)
				end
				fn = function()
					return self.state
				end
				currentState = function()
					return self.props
				end
				self:setState({
					value = 0
				})
			end
			function internalData.render(self)
				return nil
			end
			local tempState = v1.mountVirtualNode(createElement(internalData), nil, "Test")
			expect(fn().value).to.equal(0)
			v2(function(self, callback)
				expect(self).to.equal(fn())
				expect(callback).to.equal(currentState())
				return {
					value = self.value + 1
				}
			end)
			expect(fn().value).to.equal(1)
			v1.unmountVirtualNode(tempState)
		end)
		it("should cancel rendering if the function returns nil", function()
			local internalData = Component:extend("TestComponent")
			local v2 = nil
			local fn = 0
			function internalData.init(self)
				v2 = function(param12)
					self:setState(param12)
				end
				self:setState({
					value = 0
				})
			end
			function internalData.render(self)
				fn = fn + 1
				return nil
			end
			local nextState = v1.mountVirtualNode(createElement(internalData), nil, "Test")
			expect(fn).to.equal(1)
			v2(function(self, callback)
				return nil
			end)
			expect(fn).to.equal(1)
			v1.unmountVirtualNode(nextState)
		end)
	end)
	describe("setState suspension", function()
		it("should defer setState triggered while reconciling", function()
			local internalData = Component:extend("Child")
			local v2 = nil
			function internalData.render(self)
				return nil
			end
			function internalData.didMount(self)
				self.props.callback()
			end
			local fn = Component:extend("Parent")
			function fn.init(self)
				v2 = function()
					return self.state
				end
			end
			function fn.render(self)
				return createElement(internalData, {
					callback = function()
						self:setState({
							foo = "bar"
						})
					end
				})
			end
			expect((v1.mountVirtualNode(createElement(fn), nil, "Test"))).to.be.ok()
			expect(v2().foo).to.equal("bar")
		end)
		it("should defer setState triggered while reconciling during an update", function()
			local internalData = Component:extend("Child")
			local v2 = nil
			function internalData.render(self)
				return nil
			end
			function internalData.didUpdate(self)
				self.props.callback()
			end
			local fn = Component:extend("Parent")
			function fn.init(self)
				v2 = function()
					return self.state
				end
			end
			function fn.render(self)
				return createElement(internalData, {
					callback = function()
						if not self.state.foo then
							self:setState({
								foo = "bar"
							})
						end
					end
				})
			end
			local nextState = v1.mountVirtualNode(createElement(fn), nil, "Test")
			expect(nextState).to.be.ok()
			expect(v2().foo).to.equal(nil)
			local tempState = v1.updateVirtualNode(nextState, createElement(fn))
			expect(tempState).to.be.ok()
			expect(v2().foo).to.equal("bar")
			v1.unmountVirtualNode(tempState)
		end)
		it("should combine pending state changes properly", function()
			local internalData = Component:extend("Child")
			local v2 = nil
			function internalData.render(self)
				return nil
			end
			function internalData.didMount(self)
				self.props.callback("foo", 1)
				self.props.callback("bar", 3)
			end
			local fn = Component:extend("Parent")
			function fn.init(self)
				v2 = function()
					return self.state
				end
			end
			function fn.render(self)
				return createElement(internalData, {
					callback = function(param12, callback)
						self:setState({
							[param12] = callback
						})
					end
				})
			end
			local nextState = v1.mountVirtualNode(createElement(fn), nil, "Test")
			expect(nextState).to.be.ok()
			expect(v2().foo).to.equal(1)
			expect(v2().bar).to.equal(3)
			v1.unmountVirtualNode(nextState)
		end)
		it("should abort properly when functional setState returns nil while deferred", function()
			local internalData = Component:extend("Child")
			function internalData.render(self)
				return nil
			end
			function internalData.didMount(self)
				self.props.callback()
			end
			local v2 = Component:extend("Parent")
			local fn = createSpy(function(self)
				return createElement(internalData, {
					callback = function()
						self:setState(function()
							return nil
						end)
					end
				})
			end)
			v2.render = fn.value
			local nextState = v1.mountVirtualNode(createElement(v2), nil, "Test")
			expect(nextState).to.be.ok()
			expect(fn.callCount).to.equal(1)
			v1.unmountVirtualNode(nextState)
		end)
		it("should still apply pending state if a subsequent state update was aborted", function()
			local internalData = Component:extend("Child")
			local v2 = nil
			function internalData.render(self)
				return nil
			end
			function internalData.didMount(self)
				self.props.callback(function()
					return {
						foo = 1
					}
				end)
				self.props.callback(function()
					return nil
				end)
			end
			local fn = Component:extend("Parent")
			function fn.init(self)
				v2 = function()
					return self.state
				end
			end
			function fn.render(self)
				return createElement(internalData, {
					callback = function(param12)
						self:setState(param12)
					end
				})
			end
			local nextState = v1.mountVirtualNode(createElement(fn), nil, "Test")
			expect(nextState).to.be.ok()
			expect(v2().foo).to.equal(1)
			v1.unmountVirtualNode(nextState)
		end)
		it("should not re-process new state when pending state is present after update", function()
			local internalData = nil
			local v2 = nil
			local fn = Component:extend("MyComponent")
			function fn.init(self)
				self:setState({
					hasUpdatedOnce = false,
					counter = 0
				})
				internalData = function(param12)
					self:setState(param12)
				end
				v2 = function()
					return self.state
				end
			end
			function fn.render(self)
				return nil
			end
			function fn.didUpdate(self)
				if self.state.hasUpdatedOnce == false then
					self:setState({
						hasUpdatedOnce = true
					})
				end
			end
			v1.mountVirtualNode(createElement(fn), nil, "Test")
			expect(v2().hasUpdatedOnce).to.equal(false)
			expect(v2().counter).to.equal(0)
			internalData(function(self)
				return {
					counter = self.counter + 1
				}
			end)
			expect(v2().hasUpdatedOnce).to.equal(true)
			expect(v2().counter).to.equal(1)
		end)
		it("should throw when an infinite update is triggered", function()
			local internalData = Component:extend("InfiniteUpdater")
			function internalData.render(self)
				return nil
			end
			function internalData.didMount(self)
				self:setState({})
			end
			function internalData.didUpdate(self)
				self:setState({})
			end
			local fn, currentState = pcall(v1.mountVirtualNode, createElement(internalData), nil, "Test")
			expect(fn).to.equal(false)
			expect(currentState:find("InfiniteUpdater")).to.be.ok()
			expect(currentState:find("reached the setState update recursion limit")).to.be.ok()
		end)
		itSKIP("should process single updates with both new and pending state", function()  end)
		it("should call trigger update after didMount when setting state in didMount", function()
			local internalData = Component:extend("MyComponent")
			function internalData.init(self)
				self:setState({
					status = "initial mount"
				})
				self.isMounted = false
			end
			function internalData.render(self)
				return nil
			end
			function internalData.didMount(self)
				self:setState({
					status = "mounted"
				})
				self.isMounted = true
			end
			function internalData.didUpdate(self, callback, p3)
				expect(p3.status).to.equal("initial mount")
				expect(self.state.status).to.equal("mounted")
				expect(self.isMounted).to.equal(true)
			end
			expect((v1.mountVirtualNode(createElement(internalData), nil, "Test"))).to.be.ok()
		end)
	end)
end
