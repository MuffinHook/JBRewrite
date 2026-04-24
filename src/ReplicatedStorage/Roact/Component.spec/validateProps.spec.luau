-- Reviewed by Claude
return function()
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local createSpy = require(script.Parent.Parent.createSpy)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local GlobalConfig = require(script.Parent.Parent.GlobalConfig)
	local Component = require(script.Parent.Parent.Component)
	local v1 = createReconciler(NoopRenderer)
	it("should be invoked when mounted", function()
		GlobalConfig.scoped({
			propValidation = true
		}, function()
			local v12 = Component:extend("MyComponent")
			local fn = createSpy(function()
				return true
			end)
			v12.validateProps = fn.value
			function v12.render(p1)
				return nil
			end
			v1.mountVirtualNode(createElement(v12), nil, "Test")
			expect(fn.callCount).to.equal(1)
		end)
	end)
	it("should be invoked when props change", function()
		GlobalConfig.scoped({
			propValidation = true
		}, function()
			local v12 = Component:extend("MyComponent")
			local fn = createSpy(function()
				return true
			end)
			v12.validateProps = fn.value
			function v12.render(p1)
				return nil
			end
			local v4 = v1.mountVirtualNode(createElement(v12, {
				a = 1
			}), nil, "Test")
			expect(fn.callCount).to.equal(1)
			fn:assertCalledWithDeepEqual({
				a = 1
			})
			v1.updateVirtualNode(v4, (createElement(v12, {
				a = 2
			})))
			expect(fn.callCount).to.equal(2)
			fn:assertCalledWithDeepEqual({
				a = 2
			})
		end)
	end)
	it("should not be invoked when state changes", function()
		GlobalConfig.scoped({
			propValidation = true
		}, function()
			local v12 = Component:extend("MyComponent")
			local fn = nil
			local fn2 = createSpy(function()
				return true
			end)
			v12.validateProps = fn2.value
			function v12.init(p1)
				fn = function(p12)
					p1:setState(p12)
				end
			end
			function v12.render(p1)
				return nil
			end
			v1.mountVirtualNode(createElement(v12, {
				a = 1
			}), nil, "Test")
			expect(fn2.callCount).to.equal(1)
			fn2:assertCalledWithDeepEqual({
				a = 1
			})
			fn({
				b = 1
			})
			expect(fn2.callCount).to.equal(1)
		end)
	end)
	it("should throw if validateProps is not a function", function()
		GlobalConfig.scoped({
			propValidation = true
		}, function()
			local v12 = Component:extend("MyComponent")
			v12.validateProps = 1
			function v12.render(p1)
				return nil
			end
			local fn = createElement(v12)
			expect(function()
				v1.mountVirtualNode(fn, nil, "Test")
			end).to.throw()
		end)
	end)
	it("should throw if validateProps returns false", function()
		GlobalConfig.scoped({
			propValidation = true
		}, function()
			local v12 = Component:extend("MyComponent")
			function v12.validateProps()
				return false
			end
			function v12.render(p1)
				return nil
			end
			local fn = createElement(v12)
			expect(function()
				v1.mountVirtualNode(fn, nil, "Test")
			end).to.throw()
		end)
	end)
	it("should include the component name in the error message", function()
		GlobalConfig.scoped({
			propValidation = true
		}, function()
			local v12 = Component:extend("MyComponent")
			function v12.validateProps()
				return false
			end
			function v12.render(p1)
				return nil
			end
			local fn = createElement(v12)
			local fn2, v4 = pcall(function()
				v1.mountVirtualNode(fn, nil, "Test")
			end)
			expect(fn2).to.equal(false)
			expect((v4:find("MyComponent"))).to.be.ok()
		end)
	end)
	it("should be invoked after defaultProps are applied", function()
		GlobalConfig.scoped({
			propValidation = true
		}, function()
			local v12 = Component:extend("MyComponent")
			local fn = createSpy(function()
				return true
			end)
			v12.validateProps = fn.value
			function v12.render(p1)
				return nil
			end
			v12.defaultProps = {
				b = 2
			}
			local v4 = v1.mountVirtualNode(createElement(v12, {
				a = 1
			}), nil, "Test")
			expect(fn.callCount).to.equal(1)
			fn:assertCalledWithDeepEqual({
				a = 1,
				b = 2
			})
			v1.updateVirtualNode(v4, (createElement(v12, {
				a = 2
			})))
			expect(fn.callCount).to.equal(2)
			fn:assertCalledWithDeepEqual({
				a = 2,
				b = 2
			})
		end)
	end)
	it("should not be invoked if the flag is off", function()
		GlobalConfig.scoped({
			propValidation = false
		}, function()
			local v12 = Component:extend("MyComponent")
			local fn = createSpy(function()
				return true
			end)
			v12.validateProps = fn.value
			function v12.render(p1)
				return nil
			end
			local v4 = v1.mountVirtualNode(createElement(v12, {
				a = 1
			}), nil, "Test")
			expect(fn.callCount).to.equal(0)
			v1.updateVirtualNode(v4, (createElement(v12, {
				a = 2
			})))
			expect(fn.callCount).to.equal(0)
		end)
	end)
end
