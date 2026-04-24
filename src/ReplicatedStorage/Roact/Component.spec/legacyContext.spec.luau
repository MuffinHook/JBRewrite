-- Reviewed by Claude
return function()
	local assertDeepEqual = require(script.Parent.Parent.assertDeepEqual)
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local Component = require(script.Parent.Parent.Component)
	local v1 = createReconciler(NoopRenderer)
	it("should be provided as a mutable self._context in Component:init", function()
		local v12 = Component:extend("Provider")
		function v12.init(p1)
			p1._context.foo = "bar"
		end
		function v12.render(p1)  end
		assertDeepEqual(v1.mountVirtualNode(createElement(v12), nil, "Provider").legacyContext, {
			foo = "bar"
		})
	end)
	it("should be inherited from parent stateful nodes", function()
		local v12 = Component:extend("Consumer")
		local v2 = nil
		function v12.init(p1)
			v2 = p1._context
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
		local v5 = v1.mountVirtualNode(createElement(v3), nil, "Parent", nil, t)
		expect(v2).never.to.equal(t)
		expect(v2).never.to.equal(v5.legacyContext)
		assertDeepEqual(v5.legacyContext, t)
		assertDeepEqual(v2, t)
	end)
	it("should be inherited from parent function nodes", function()
		local v12 = Component:extend("Consumer")
		local v2 = nil
		function v12.init(p1)
			v2 = p1._context
		end
		function v12.render(p1)  end
		local t = {
			hello = "world",
			value = 6
		}
		local v4 = v1.mountVirtualNode(createElement(function()
			return createElement(v12)
		end), nil, "Parent", nil, t)
		expect(v2).never.to.equal(t)
		expect(v2).never.to.equal(v4.legacyContext)
		assertDeepEqual(v4.legacyContext, t)
		assertDeepEqual(v2, t)
	end)
	it("should contain values put into the tree by parent nodes", function()
		local v12 = Component:extend("Consumer")
		local v2 = nil
		function v12.init(p1)
			v2 = p1._context
		end
		function v12.render(p1)  end
		local v3 = Component:extend("Provider")
		function v3.init(p1)
			p1._context.frob = "ulator"
		end
		function v3.render(p1)
			return createElement(v12)
		end
		local t = {
			dont = "try it"
		}
		local v5 = v1.mountVirtualNode(createElement(v3), nil, "Consumer", nil, t)
		local t2 = {
			dont = "try it",
			frob = "ulator"
		}
		expect(v5.legacyContext).never.to.equal(t)
		expect(v2).never.to.equal(t)
		expect(v2).never.to.equal(v5.legacyContext)
		assertDeepEqual(t, {
			dont = "try it"
		})
		assertDeepEqual(v5.legacyContext, t2)
		assertDeepEqual(v2, t2)
	end)
	it("should transfer context to children that are replaced", function()
		local v12 = Component:extend("ConsumerA")
		local v2 = nil
		function v12.init(p1)
			p1._context.A = "hello"
			v2 = p1._context
		end
		function v12.render(p1)  end
		local v3 = Component:extend("ConsumerB")
		local v4 = nil
		function v3.init(p1)
			p1._context.B = "hello"
			v4 = p1._context
		end
		function v3.render(p1)  end
		local v5 = Component:extend("Provider")
		function v5.init(p1)
			p1._context.frob = "ulator"
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
