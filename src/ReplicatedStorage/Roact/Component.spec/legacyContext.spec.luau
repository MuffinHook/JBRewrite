-- Reviewed by Claude
-- variables reassigned
return function()
	local assertDeepEqual = require(script.Parent.Parent.assertDeepEqual)
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local Component = require(script.Parent.Parent.Component)
	local v1 = createReconciler(NoopRenderer)
	it("should be provided as a mutable self._context in Component:init", function()
		local internalData = Component:extend("Provider")
		function internalData.init(self)
			self._context.foo = "bar"
		end
		function internalData.render(self)  end
		assertDeepEqual(v1.mountVirtualNode(createElement(internalData), nil, "Provider").legacyContext, {
			foo = "bar"
		})
	end)
	it("should be inherited from parent stateful nodes", function()
		local internalData = Component:extend("Consumer")
		local v2 = nil
		function internalData.init(self)
			v2 = self._context
		end
		function internalData.render(self)  end
		local newState = Component:extend("Parent")
		function newState.render(self)
			return createElement(internalData)
		end
		local t = {
			hello = "world",
			value = 6
		}
		local nextState = v1.mountVirtualNode(createElement(newState), nil, "Parent", nil, t)
		expect(v2).never.to.equal(t)
		expect(v2).never.to.equal(nextState.legacyContext)
		assertDeepEqual(nextState.legacyContext, t)
		assertDeepEqual(v2, t)
	end)
	it("should be inherited from parent function nodes", function()
		local internalData = Component:extend("Consumer")
		local v2 = nil
		function internalData.init(self)
			v2 = self._context
		end
		function internalData.render(self)  end
		local t = {
			hello = "world",
			value = 6
		}
		local fn = v1.mountVirtualNode(createElement(function()
			return createElement(internalData)
		end), nil, "Parent", nil, t)
		expect(v2).never.to.equal(t)
		expect(v2).never.to.equal(fn.legacyContext)
		assertDeepEqual(fn.legacyContext, t)
		assertDeepEqual(v2, t)
	end)
	it("should contain values put into the tree by parent nodes", function()
		local internalData = Component:extend("Consumer")
		local v2 = nil
		function internalData.init(self)
			v2 = self._context
		end
		function internalData.render(self)  end
		local newState = Component:extend("Provider")
		function newState.init(self)
			self._context.frob = "ulator"
		end
		function newState.render(self)
			return createElement(internalData)
		end
		local t = {
			dont = "try it"
		}
		local nextState = v1.mountVirtualNode(createElement(newState), nil, "Consumer", nil, t)
		local tbl2 = {
			dont = "try it",
			frob = "ulator"
		}
		expect(nextState.legacyContext).never.to.equal(t)
		expect(v2).never.to.equal(t)
		expect(v2).never.to.equal(nextState.legacyContext)
		assertDeepEqual(t, {
			dont = "try it"
		})
		assertDeepEqual(nextState.legacyContext, tbl2)
		assertDeepEqual(v2, tbl2)
	end)
	it("should transfer context to children that are replaced", function()
		local internalData = Component:extend("ConsumerA")
		local v2 = nil
		function internalData.init(self)
			self._context.A = "hello"
			v2 = self._context
		end
		function internalData.render(self)  end
		local newState = Component:extend("ConsumerB")
		local fn = nil
		function newState.init(self)
			self._context.B = "hello"
			fn = self._context
		end
		function newState.render(self)  end
		local nextState = Component:extend("Provider")
		function nextState.init(self)
			self._context.frob = "ulator"
		end
		function nextState.render(self)
			if self.props.useConsumerB then
				return createElement(newState)
			else
				return createElement(internalData)
			end
		end
		local mergedState = v1.mountVirtualNode(createElement(nextState), nil, "Consumer")
		assertDeepEqual(v2, {
			frob = "ulator",
			A = "hello"
		})
		v1.updateVirtualNode(mergedState, (createElement(nextState, {
			useConsumerB = true
		})))
		assertDeepEqual(fn, {
			frob = "ulator",
			B = "hello"
		})
	end)
end
