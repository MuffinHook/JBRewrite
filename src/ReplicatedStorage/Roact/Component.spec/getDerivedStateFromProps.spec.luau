-- Reviewed by Claude
return function()
	local assertDeepEqual = require(script.Parent.Parent.assertDeepEqual)
	local createSpy = require(script.Parent.Parent.createSpy)
	local createElement = require(script.Parent.Parent.createElement)
	local createFragment = require(script.Parent.Parent.createFragment)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local Component = require(script.Parent.Parent.Component)
	local v1 = createReconciler(NoopRenderer)
	it("should be invoked on initial mount", function()
		local v12 = createSpy()
		local v2 = Component:extend("WithDerivedState")
		v2.getDerivedStateFromProps = v12.value
		function v2.render(p1)
			return nil
		end
		v1.mountVirtualNode(createElement(v2, {
			someProp = 1
		}), nil, "WithDerivedState")
		expect(v12.callCount).to.equal(1)
		local v4 = v12:captureValues("props", "state")
		assertDeepEqual(v4.props, {
			someProp = 1
		})
		assertDeepEqual(v4.state, {})
	end)
	it("should be invoked when updated via props", function()
		local v12 = createSpy()
		local v2 = Component:extend("WithDerivedState")
		v2.getDerivedStateFromProps = v12.value
		function v2.render(p1)
			return nil
		end
		v1.updateVirtualNode(v1.mountVirtualNode(createElement(v2, {
			someProp = 1
		}), nil, "WithDerivedState"), createElement(v2, {
			someProp = 2
		}))
		expect(v12.callCount).to.equal(2)
		local v4 = v12:captureValues("props", "state")
		assertDeepEqual(v4.props, {
			someProp = 2
		})
		assertDeepEqual(v4.state, {})
	end)
	it("should be invoked when updated via state", function()
		local v12 = createSpy()
		local v2 = Component:extend("WithDerivedState")
		v2.getDerivedStateFromProps = v12.value
		function v2.init(p1)
			p1:setState({
				someState = 1
			})
		end
		function v2.render(p1)
			return nil
		end
		local v3 = createElement(v2)
		v1.updateVirtualNode(v1.mountVirtualNode(v3, nil, "WithDerivedState"), v3, {
			someState = 2
		})
		expect(v12.callCount).to.equal(4)
		local v5 = v12:captureValues("props", "state")
		assertDeepEqual(v5.props, {})
		assertDeepEqual(v5.state, {
			someState = 2
		})
	end)
	it("should be invoked when updating via state in init (which skips reconciliation)", function()
		local v12 = createSpy()
		local v2 = Component:extend("WithDerivedState")
		v2.getDerivedStateFromProps = v12.value
		function v2.init(p1)
			p1:setState({
				stateFromInit = 1
			})
		end
		function v2.render(p1)
			return nil
		end
		v1.mountVirtualNode(createElement(v2, {
			someProp = 1
		}), nil, "WithDerivedState")
		expect(v12.callCount).to.equal(3)
		local v4 = v12:captureValues("props", "state")
		assertDeepEqual(v4.props, {
			someProp = 1
		})
		assertDeepEqual(v4.state, {
			stateFromInit = 1
		})
	end)
	it("should receive defaultProps", function()
		local v12 = createSpy()
		local v2 = Component:extend("WithDerivedState")
		v2.defaultProps = {
			someDefaultProp = "foo"
		}
		v2.getDerivedStateFromProps = v12.value
		function v2.render(p1)
			return nil
		end
		local v4 = v1.mountVirtualNode(createElement(v2, {
			someProp = 1
		}), nil, "WithDerivedState")
		expect(v12.callCount).to.equal(1)
		assertDeepEqual(v12:captureValues("props", "state").props, {
			someDefaultProp = "foo",
			someProp = 1
		})
		v1.updateVirtualNode(v4, (createElement(v2, {
			someProp = 2
		})))
		expect(v12.callCount).to.equal(2)
		assertDeepEqual(v12:captureValues("props", "state").props, {
			someDefaultProp = "foo",
			someProp = 2
		})
	end)
	it("should derive state for all setState updates, even when deferred", function()
		local v12 = Component:extend("Child")
		local v2 = createSpy(function()
			return {}
		end)
		local v3 = createSpy()
		function v12.render(p1)
			return nil
		end
		function v12.didMount(p1)
			p1.props.callback()
		end
		local v4 = Component:extend("Parent")
		v4.getDerivedStateFromProps = v3.value
		function v4.render(p1)
			local function f1()
				p1:setState(v2.value)
			end
			return createFragment({
				ChildA = createElement(v12, {
					callback = f1
				}),
				ChildB = createElement(v12, {
					callback = f1
				})
			})
		end
		v1.mountVirtualNode(createElement(v4), nil, "Test")
		expect(v2.callCount).to.equal(2)
		expect(v3.callCount).to.equal(3)
	end)
	it("should have derived state after assigning to state in init", function()
		local v12 = nil
		local v2 = createSpy(function()
			return {
				derived = true
			}
		end)
		local v3 = Component:extend("WithDerivedState")
		v3.getDerivedStateFromProps = v2.value
		function v3.init(p1)
			p1.state = {
				init = true
			}
			v12 = function()
				return p1.state
			end
		end
		function v3.render(p1)
			return nil
		end
		v1.mountVirtualNode(createElement(v3), nil, "WithDerivedState")
		expect(v2.callCount).to.equal(2)
		assertDeepEqual(v12(), {
			init = true,
			derived = true
		})
	end)
end
