-- Reviewed by Claude
-- variables reassigned
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
			local internalData = Component:extend("MyComponent")
			local fn = createSpy(function()
				return true
			end)
			internalData.validateProps = fn.value
			function internalData.render(self)
				return nil
			end
			v1.mountVirtualNode(createElement(internalData), nil, "Test")
			expect(fn.callCount).to.equal(1)
		end)
	end)
	it("should be invoked when props change", function()
		GlobalConfig.scoped({
			propValidation = true
		}, function()
			local internalData = Component:extend("MyComponent")
			local fn = createSpy(function()
				return true
			end)
			internalData.validateProps = fn.value
			function internalData.render(self)
				return nil
			end
			local currentState = v1.mountVirtualNode(createElement(internalData, {
				a = 1
			}), nil, "Test")
			expect(fn.callCount).to.equal(1)
			fn:assertCalledWithDeepEqual({
				a = 1
			})
			v1.updateVirtualNode(currentState, (createElement(internalData, {
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
			local internalData = Component:extend("MyComponent")
			local fn = nil
			local fn2 = createSpy(function()
				return true
			end)
			internalData.validateProps = fn2.value
			function internalData.init(self)
				fn = function(param12)
					self:setState(param12)
				end
			end
			function internalData.render(self)
				return nil
			end
			v1.mountVirtualNode(createElement(internalData, {
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
			local internalData = Component:extend("MyComponent")
			internalData.validateProps = 1
			function internalData.render(self)
				return nil
			end
			local fn = createElement(internalData)
			expect(function()
				v1.mountVirtualNode(fn, nil, "Test")
			end).to.throw()
		end)
	end)
	it("should throw if validateProps returns false", function()
		GlobalConfig.scoped({
			propValidation = true
		}, function()
			local internalData = Component:extend("MyComponent")
			function internalData.validateProps()
				return false
			end
			function internalData.render(self)
				return nil
			end
			local fn = createElement(internalData)
			expect(function()
				v1.mountVirtualNode(fn, nil, "Test")
			end).to.throw()
		end)
	end)
	it("should include the component name in the error message", function()
		GlobalConfig.scoped({
			propValidation = true
		}, function()
			local internalData = Component:extend("MyComponent")
			function internalData.validateProps()
				return false
			end
			function internalData.render(self)
				return nil
			end
			local fn = createElement(internalData)
			local fn2, currentState = pcall(function()
				v1.mountVirtualNode(fn, nil, "Test")
			end)
			expect(fn2).to.equal(false)
			expect((currentState:find("MyComponent"))).to.be.ok()
		end)
	end)
	it("should be invoked after defaultProps are applied", function()
		GlobalConfig.scoped({
			propValidation = true
		}, function()
			local internalData = Component:extend("MyComponent")
			local fn = createSpy(function()
				return true
			end)
			internalData.validateProps = fn.value
			function internalData.render(self)
				return nil
			end
			internalData.defaultProps = {
				b = 2
			}
			local currentState = v1.mountVirtualNode(createElement(internalData, {
				a = 1
			}), nil, "Test")
			expect(fn.callCount).to.equal(1)
			fn:assertCalledWithDeepEqual({
				a = 1,
				b = 2
			})
			v1.updateVirtualNode(currentState, (createElement(internalData, {
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
			local internalData = Component:extend("MyComponent")
			local fn = createSpy(function()
				return true
			end)
			internalData.validateProps = fn.value
			function internalData.render(self)
				return nil
			end
			local currentState = v1.mountVirtualNode(createElement(internalData, {
				a = 1
			}), nil, "Test")
			expect(fn.callCount).to.equal(0)
			v1.updateVirtualNode(currentState, (createElement(internalData, {
				a = 2
			})))
			expect(fn.callCount).to.equal(0)
		end)
	end)
end
