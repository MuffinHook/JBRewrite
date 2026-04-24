-- Reviewed by Claude
-- variables reassigned
return function()
	local assertDeepEqual = require(script.Parent.Parent.assertDeepEqual)
	local createSpy = require(script.Parent.Parent.createSpy)
	local createElement = require(script.Parent.Parent.createElement)
	local createFragment = require(script.Parent.Parent.createFragment)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local Component = require(script.Parent.Parent.Component)
	local state1 = createReconciler(NoopRenderer)
	it("should be invoked on initial mount", function()
		local internalData = createSpy()
		local fn = Component:extend("WithDerivedState")
		fn.getDerivedStateFromProps = internalData.value
		function fn.render(self)
			return nil
		end
		state1.mountVirtualNode(createElement(fn, {
			someProp = 1
		}), nil, "WithDerivedState")
		expect(internalData.callCount).to.equal(1)
		local currentState = internalData:captureValues("props", "state")
		assertDeepEqual(currentState.props, {
			someProp = 1
		})
		assertDeepEqual(currentState.state, {})
	end)
	it("should be invoked when updated via props", function()
		local internalData = createSpy()
		local fn = Component:extend("WithDerivedState")
		fn.getDerivedStateFromProps = internalData.value
		function fn.render(self)
			return nil
		end
		state1.updateVirtualNode(state1.mountVirtualNode(createElement(fn, {
			someProp = 1
		}), nil, "WithDerivedState"), createElement(fn, {
			someProp = 2
		}))
		expect(internalData.callCount).to.equal(2)
		local currentState = internalData:captureValues("props", "state")
		assertDeepEqual(currentState.props, {
			someProp = 2
		})
		assertDeepEqual(currentState.state, {})
	end)
	it("should be invoked when updated via state", function()
		local internalData = createSpy()
		local fn = Component:extend("WithDerivedState")
		fn.getDerivedStateFromProps = internalData.value
		function fn.init(self)
			self:setState({
				someState = 1
			})
		end
		function fn.render(self)
			return nil
		end
		local newState = createElement(fn)
		state1.updateVirtualNode(state1.mountVirtualNode(newState, nil, "WithDerivedState"), newState, {
			someState = 2
		})
		expect(internalData.callCount).to.equal(4)
		local nextState = internalData:captureValues("props", "state")
		assertDeepEqual(nextState.props, {})
		assertDeepEqual(nextState.state, {
			someState = 2
		})
	end)
	it("should be invoked when updating via state in init (which skips reconciliation)", function()
		local internalData = createSpy()
		local fn = Component:extend("WithDerivedState")
		fn.getDerivedStateFromProps = internalData.value
		function fn.init(self)
			self:setState({
				stateFromInit = 1
			})
		end
		function fn.render(self)
			return nil
		end
		state1.mountVirtualNode(createElement(fn, {
			someProp = 1
		}), nil, "WithDerivedState")
		expect(internalData.callCount).to.equal(3)
		local currentState = internalData:captureValues("props", "state")
		assertDeepEqual(currentState.props, {
			someProp = 1
		})
		assertDeepEqual(currentState.state, {
			stateFromInit = 1
		})
	end)
	it("should receive defaultProps", function()
		local internalData = createSpy()
		local fn = Component:extend("WithDerivedState")
		fn.defaultProps = {
			someDefaultProp = "foo"
		}
		fn.getDerivedStateFromProps = internalData.value
		function fn.render(self)
			return nil
		end
		local currentState = state1.mountVirtualNode(createElement(fn, {
			someProp = 1
		}), nil, "WithDerivedState")
		expect(internalData.callCount).to.equal(1)
		assertDeepEqual(internalData:captureValues("props", "state").props, {
			someDefaultProp = "foo",
			someProp = 1
		})
		state1.updateVirtualNode(currentState, (createElement(fn, {
			someProp = 2
		})))
		expect(internalData.callCount).to.equal(2)
		assertDeepEqual(internalData:captureValues("props", "state").props, {
			someDefaultProp = "foo",
			someProp = 2
		})
	end)
	it("should derive state for all setState updates, even when deferred", function()
		local internalData = Component:extend("Child")
		local fn = createSpy(function()
			return {}
		end)
		local newState = createSpy()
		function internalData.render(self)
			return nil
		end
		function internalData.didMount(self)
			self.props.callback()
		end
		local currentState = Component:extend("Parent")
		currentState.getDerivedStateFromProps = newState.value
		function currentState.render(self)
			local function f1()
				self:setState(fn.value)
			end
			return createFragment({
				ChildA = createElement(internalData, {
					callback = f1
				}),
				ChildB = createElement(internalData, {
					callback = f1
				})
			})
		end
		state1.mountVirtualNode(createElement(currentState), nil, "Test")
		expect(fn.callCount).to.equal(2)
		expect(newState.callCount).to.equal(3)
	end)
	it("should have derived state after assigning to state in init", function()
		local internalData = nil
		local fn = createSpy(function()
			return {
				derived = true
			}
		end)
		local newState = Component:extend("WithDerivedState")
		newState.getDerivedStateFromProps = fn.value
		function newState.init(self)
			self.state = {
				init = true
			}
			internalData = function()
				return self.state
			end
		end
		function newState.render(self)
			return nil
		end
		state1.mountVirtualNode(createElement(newState), nil, "WithDerivedState")
		expect(fn.callCount).to.equal(2)
		assertDeepEqual(internalData(), {
			init = true,
			derived = true
		})
	end)
end
