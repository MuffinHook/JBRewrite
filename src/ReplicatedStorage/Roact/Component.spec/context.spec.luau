-- Reviewed by Claude
-- variables reassigned
return function()
	local assertDeepEqual = require(script.Parent.Parent.assertDeepEqual)
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local oneChild = require(script.Parent.Parent.oneChild)
	local Component = require(script.Parent.Parent.Component)
	local v1 = createReconciler(NoopRenderer)
	it("should be provided as an internal api on Component", function()
		local internalData = Component:extend("Provider")
		function internalData.init(self)
			self:__addContext("foo", "bar")
		end
		function internalData.render(self)  end
		assertDeepEqual(v1.mountVirtualNode(createElement(internalData), nil, "Provider").context, {
			foo = "bar"
		})
	end)
	it("should be inherited from parent stateful nodes", function()
		local internalData = Component:extend("Consumer")
		local v2 = nil
		function internalData.init(self)
			v2 = {
				hello = self:__getContext("hello"),
				value = self:__getContext("value")
			}
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
		local nextState = v1.mountVirtualNode(createElement(newState), nil, "Parent", t)
		expect(v2).never.to.equal(t)
		expect(v2).never.to.equal(nextState.context)
		assertDeepEqual(nextState.context, t)
		assertDeepEqual(v2, t)
	end)
	it("should be inherited from parent function nodes", function()
		local internalData = Component:extend("Consumer")
		local v2 = nil
		function internalData.init(self)
			v2 = {
				hello = self:__getContext("hello"),
				value = self:__getContext("value")
			}
		end
		function internalData.render(self)  end
		local t = {
			hello = "world",
			value = 6
		}
		local fn = v1.mountVirtualNode(createElement(function()
			return createElement(internalData)
		end), nil, "Parent", t)
		expect(v2).never.to.equal(t)
		expect(v2).never.to.equal(fn.context)
		assertDeepEqual(fn.context, t)
		assertDeepEqual(v2, t)
	end)
	it("should not copy the context table if it doesn\'t need to", function()
		local internalData = Component:extend("Parent")
		function internalData.init(self)
			self:__addContext("parent", "I\'m here!")
		end
		function internalData.render(self)
			return createElement(function()  end)
		end
		local newState = v1.mountVirtualNode(createElement(internalData), nil, "Parent")
		assertDeepEqual(newState.context, {
			parent = "I\'m here!"
		})
		local fn = oneChild(newState.children)
		expect(newState.context).to.equal(fn.context)
	end)
	it("should not allow context to move up the tree", function()
		local internalData = Component:extend("ChildProvider")
		function internalData.init(self)
			self:__addContext("child", "I\'m here too!")
		end
		function internalData.render(self)  end
		local v2 = Component:extend("ParentProvider")
		function v2.init(self)
			self:__addContext("parent", "I\'m here!")
		end
		function v2.render(self)
			return createElement(internalData)
		end
		local fn = v1.mountVirtualNode(createElement(v2), nil, "Parent")
		local nextState = oneChild(fn.children)
		assertDeepEqual(fn.context, {
			parent = "I\'m here!"
		})
		assertDeepEqual(nextState.context, {
			parent = "I\'m here!",
			child = "I\'m here too!"
		})
	end)
	it("should contain values put into the tree by parent nodes", function()
		local internalData = Component:extend("Consumer")
		local v2 = nil
		function internalData.init(self)
			v2 = {
				dont = self:__getContext("dont"),
				frob = self:__getContext("frob")
			}
		end
		function internalData.render(self)  end
		local newState = Component:extend("Provider")
		function newState.init(self)
			self:__addContext("frob", "ulator")
		end
		function newState.render(self)
			return createElement(internalData)
		end
		local t = {
			dont = "try it"
		}
		local nextState = v1.mountVirtualNode(createElement(newState), nil, "Consumer", t)
		local tbl2 = {
			dont = "try it",
			frob = "ulator"
		}
		expect(nextState.context).never.to.equal(t)
		expect(v2).never.to.equal(t)
		expect(v2).never.to.equal(nextState.context)
		assertDeepEqual(t, {
			dont = "try it"
		})
		assertDeepEqual(nextState.context, tbl2)
		assertDeepEqual(v2, tbl2)
	end)
	it("should transfer context to children that are replaced", function()
		local internalData = Component:extend("ConsumerA")
		local function captureAllContext(self)
			return {
				A = self:__getContext("A"),
				B = self:__getContext("B"),
				frob = self:__getContext("frob")
			}
		end
		local v2 = nil
		function internalData.init(self)
			self:__addContext("A", "hello")
			v2 = captureAllContext(self)
		end
		function internalData.render(self)  end
		local newState = Component:extend("ConsumerB")
		local fn = nil
		function newState.init(self)
			self:__addContext("B", "hello")
			fn = captureAllContext(self)
		end
		function newState.render(self)  end
		local nextState = Component:extend("Provider")
		function nextState.init(self)
			self:__addContext("frob", "ulator")
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
