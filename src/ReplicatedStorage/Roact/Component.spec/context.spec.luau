-- Reviewed by Claude
return function()
	local assertDeepEqual = require(script.Parent.Parent.assertDeepEqual)
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local oneChild = require(script.Parent.Parent.oneChild)
	local Component = require(script.Parent.Parent.Component)
	local v1 = createReconciler(NoopRenderer)
	it("should be provided as an internal api on Component", function()
		local v12 = Component:extend("Provider")
		function v12.init(p1)
			p1:__addContext("foo", "bar")
		end
		function v12.render(p1)  end
		assertDeepEqual(v1.mountVirtualNode(createElement(v12), nil, "Provider").context, {
			foo = "bar"
		})
	end)
	it("should be inherited from parent stateful nodes", function()
		local v12 = Component:extend("Consumer")
		local v2 = nil
		function v12.init(p1)
			v2 = {
				hello = p1:__getContext("hello"),
				value = p1:__getContext("value")
			}
		end
		function v12.render(p1)  end
		local v3 = Component:extend("Parent")
		function v3.render(p1)
			return createElement(v12)
		end
		local t = {
			hello = "world",
			value = 6
		}
		local v5 = v1.mountVirtualNode(createElement(v3), nil, "Parent", t)
		expect(v2).never.to.equal(t)
		expect(v2).never.to.equal(v5.context)
		assertDeepEqual(v5.context, t)
		assertDeepEqual(v2, t)
	end)
	it("should be inherited from parent function nodes", function()
		local v12 = Component:extend("Consumer")
		local v2 = nil
		function v12.init(p1)
			v2 = {
				hello = p1:__getContext("hello"),
				value = p1:__getContext("value")
			}
		end
		function v12.render(p1)  end
		local t = {
			hello = "world",
			value = 6
		}
		local v4 = v1.mountVirtualNode(createElement(function()
			return createElement(v12)
		end), nil, "Parent", t)
		expect(v2).never.to.equal(t)
		expect(v2).never.to.equal(v4.context)
		assertDeepEqual(v4.context, t)
		assertDeepEqual(v2, t)
	end)
	it("should not copy the context table if it doesn\'t need to", function()
		local v12 = Component:extend("Parent")
		function v12.init(p1)
			p1:__addContext("parent", "I\'m here!")
		end
		function v12.render(p1)
			return createElement(function()  end)
		end
		local v3 = v1.mountVirtualNode(createElement(v12), nil, "Parent")
		assertDeepEqual(v3.context, {
			parent = "I\'m here!"
		})
		local v4 = oneChild(v3.children)
		expect(v3.context).to.equal(v4.context)
	end)
	it("should not allow context to move up the tree", function()
		local v12 = Component:extend("ChildProvider")
		function v12.init(p1)
			p1:__addContext("child", "I\'m here too!")
		end
		function v12.render(p1)  end
		local v2 = Component:extend("ParentProvider")
		function v2.init(p1)
			p1:__addContext("parent", "I\'m here!")
		end
		function v2.render(p1)
			return createElement(v12)
		end
		local v4 = v1.mountVirtualNode(createElement(v2), nil, "Parent")
		local v5 = oneChild(v4.children)
		assertDeepEqual(v4.context, {
			parent = "I\'m here!"
		})
		assertDeepEqual(v5.context, {
			parent = "I\'m here!",
			child = "I\'m here too!"
		})
	end)
	it("should contain values put into the tree by parent nodes", function()
		local v12 = Component:extend("Consumer")
		local v2 = nil
		function v12.init(p1)
			v2 = {
				dont = p1:__getContext("dont"),
				frob = p1:__getContext("frob")
			}
		end
		function v12.render(p1)  end
		local v3 = Component:extend("Provider")
		function v3.init(p1)
			p1:__addContext("frob", "ulator")
		end
		function v3.render(p1)
			return createElement(v12)
		end
		local t = {
			dont = "try it"
		}
		local v5 = v1.mountVirtualNode(createElement(v3), nil, "Consumer", t)
		local t2 = {
			dont = "try it",
			frob = "ulator"
		}
		expect(v5.context).never.to.equal(t)
		expect(v2).never.to.equal(t)
		expect(v2).never.to.equal(v5.context)
		assertDeepEqual(t, {
			dont = "try it"
		})
		assertDeepEqual(v5.context, t2)
		assertDeepEqual(v2, t2)
	end)
	it("should transfer context to children that are replaced", function()
		local v12 = Component:extend("ConsumerA")
		local function captureAllContext(p1)
			return {
				A = p1:__getContext("A"),
				B = p1:__getContext("B"),
				frob = p1:__getContext("frob")
			}
		end
		local v2 = nil
		function v12.init(p1)
			p1:__addContext("A", "hello")
			v2 = captureAllContext(p1)
		end
		function v12.render(p1)  end
		local v3 = Component:extend("ConsumerB")
		local v4 = nil
		function v3.init(p1)
			p1:__addContext("B", "hello")
			v4 = captureAllContext(p1)
		end
		function v3.render(p1)  end
		local v5 = Component:extend("Provider")
		function v5.init(p1)
			p1:__addContext("frob", "ulator")
		end
		function v5.render(p1)
			if p1.props.useConsumerB then
				return createElement(v3)
			else
				return createElement(v12)
			end
		end
		local v7 = v1.mountVirtualNode(createElement(v5), nil, "Consumer")
		assertDeepEqual(v2, {
			frob = "ulator",
			A = "hello"
		})
		v1.updateVirtualNode(v7, (createElement(v5, {
			useConsumerB = true
		})))
		assertDeepEqual(v4, {
			frob = "ulator",
			B = "hello"
		})
	end)
end
