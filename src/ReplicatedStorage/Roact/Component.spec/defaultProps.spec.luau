-- Reviewed by Claude
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
		local v12 = Component:extend("Foo")
		v12.defaultProps = t
		local v2 = nil
		function v12.init(p1)
			v2 = p1.props
		end
		function v12.render(p1)  end
		local t2 = {
			b = 4,
			c = 6
		}
		v1.mountVirtualNode(createElement(v12, t2), nil, "Some Foo")
		assertDeepEqual(v2, {
			a = t.a,
			b = t2.b,
			c = t2.c
		})
	end)
	it("should fill in when updating via props", function()
		local t = {
			a = 3,
			b = 2
		}
		local v12 = Component:extend("Foo")
		v12.defaultProps = t
		local v2 = nil
		function v12.render(p1)
			v2 = p1.props
		end
		local v4 = v1.mountVirtualNode(createElement(v12, {
			b = 4,
			c = 6
		}), nil, "Some Foo")
		local t2 = {
			c = 5
		}
		v1.updateVirtualNode(v4, (createElement(v12, t2)))
		assertDeepEqual(v2, {
			a = t.a,
			b = t.b,
			c = t2.c
		})
	end)
	it("should respect None to override a default prop with nil", function()
		local t = {
			a = 3,
			b = 2
		}
		local v12 = Component:extend("Foo")
		v12.defaultProps = t
		local v2 = nil
		function v12.render(p1)
			v2 = p1.props
		end
		local t2 = {
			b = None,
			c = 4
		}
		v1.mountVirtualNode(createElement(v12, t2), nil, "Some Foo")
		assertDeepEqual(v2, {
			a = t.a,
			b = nil,
			c = t2.c
		})
	end)
end
