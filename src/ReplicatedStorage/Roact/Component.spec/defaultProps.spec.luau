-- Reviewed by Claude
-- variables reassigned
return function()
	local assertDeepEqual = require(script.Parent.Parent.assertDeepEqual)
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local None = require(script.Parent.Parent.None)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local Component = require(script.Parent.Parent.Component)
	local v1 = createReconciler(NoopRenderer)
	it("should fill in when mounting before init", function()
		local t = {
			a = 3,
			b = 2
		}
		local internalData = Component:extend("Foo")
		internalData.defaultProps = t
		local v2 = nil
		function internalData.init(self)
			v2 = self.props
		end
		function internalData.render(self)  end
		local tbl2 = {
			b = 4,
			c = 6
		}
		v1.mountVirtualNode(createElement(internalData, tbl2), nil, "Some Foo")
		assertDeepEqual(v2, {
			a = t.a,
			b = tbl2.b,
			c = tbl2.c
		})
	end)
	it("should fill in when updating via props", function()
		local t = {
			a = 3,
			b = 2
		}
		local internalData = Component:extend("Foo")
		internalData.defaultProps = t
		local v2 = nil
		function internalData.render(self)
			v2 = self.props
		end
		local currentState = v1.mountVirtualNode(createElement(internalData, {
			b = 4,
			c = 6
		}), nil, "Some Foo")
		local tbl2 = {
			c = 5
		}
		v1.updateVirtualNode(currentState, (createElement(internalData, tbl2)))
		assertDeepEqual(v2, {
			a = t.a,
			b = t.b,
			c = tbl2.c
		})
	end)
	it("should respect None to override a default prop with nil", function()
		local t = {
			a = 3,
			b = 2
		}
		local internalData = Component:extend("Foo")
		internalData.defaultProps = t
		local v2 = nil
		function internalData.render(self)
			v2 = self.props
		end
		local tbl2 = {
			b = None,
			c = 4
		}
		v1.mountVirtualNode(createElement(internalData, tbl2), nil, "Some Foo")
		assertDeepEqual(v2, {
			a = t.a,
			b = nil,
			c = tbl2.c
		})
	end)
end
