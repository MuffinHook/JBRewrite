return function() --[[ Line: 1 ]]
	local createElement = require(script.Parent.Parent.createElement)
	local createReconciler = require(script.Parent.Parent.createReconciler)
	local createSpy = require(script.Parent.Parent.createSpy)
	local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
	local GlobalConfig = require(script.Parent.Parent.GlobalConfig)
	local Component = require(script.Parent.Parent.Component)
	local v1 = createReconciler(NoopRenderer)
	it("should be invoked when mounted", function() --[[ Line: 12 | Upvalues: GlobalConfig (copy), Component (copy), createSpy (copy), createElement (copy), v1 (copy) ]]
		GlobalConfig.scoped({
			propValidation = true
		}, function() --[[ Line: 17 | Upvalues: Component (ref), createSpy (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("MyComponent")
			local v2 = createSpy(function() --[[ Line: 20 ]]
				return true
			end)
			v12.validateProps = v2.value
			function v12.render(p1) --[[ Line: 26 ]]
				return nil
			end
			v1.mountVirtualNode(createElement(v12), nil, "Test")
			expect(v2.callCount).to.equal(1)
		end)
	end)
	it("should be invoked when props change", function() --[[ Line: 39 | Upvalues: GlobalConfig (copy), Component (copy), createSpy (copy), createElement (copy), v1 (copy) ]]
		GlobalConfig.scoped({
			propValidation = true
		}, function() --[[ Line: 44 | Upvalues: Component (ref), createSpy (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("MyComponent")
			local v2 = createSpy(function() --[[ Line: 47 ]]
				return true
			end)
			v12.validateProps = v2.value
			function v12.render(p1) --[[ Line: 53 ]]
				return nil
			end
			local v4 = v1.mountVirtualNode(createElement(v12, {
				a = 1
			}), nil, "Test")
			expect(v2.callCount).to.equal(1)
			v2:assertCalledWithDeepEqual({
				a = 1
			})
			v1.updateVirtualNode(v4, (createElement(v12, {
				a = 2
			})))
			expect(v2.callCount).to.equal(2)
			v2:assertCalledWithDeepEqual({
				a = 2
			})
		end)
	end)
	it("should not be invoked when state changes", function() --[[ Line: 76 | Upvalues: GlobalConfig (copy), Component (copy), createSpy (copy), createElement (copy), v1 (copy) ]]
		GlobalConfig.scoped({
			propValidation = true
		}, function() --[[ Line: 81 | Upvalues: Component (ref), createSpy (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("MyComponent")
			local v2 = nil
			local v3 = createSpy(function() --[[ Line: 85 ]]
				return true
			end)
			v12.validateProps = v3.value
			function v12.init(p1) --[[ Line: 91 | Upvalues: v2 (ref) ]]
				v2 = function(p12) --[[ Line: 92 | Upvalues: p1 (copy) ]]
					p1:setState(p12)
				end
			end
			function v12.render(p1) --[[ Line: 97 ]]
				return nil
			end
			v1.mountVirtualNode(createElement(v12, {
				a = 1
			}), nil, "Test")
			expect(v3.callCount).to.equal(1)
			v3:assertCalledWithDeepEqual({
				a = 1
			})
			v2({
				b = 1
			})
			expect(v3.callCount).to.equal(1)
		end)
	end)
	it("should throw if validateProps is not a function", function() --[[ Line: 119 | Upvalues: GlobalConfig (copy), Component (copy), createElement (copy), v1 (copy) ]]
		GlobalConfig.scoped({
			propValidation = true
		}, function() --[[ Line: 124 | Upvalues: Component (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("MyComponent")
			v12.validateProps = 1
			function v12.render(p1) --[[ Line: 128 ]]
				return nil
			end
			local v2 = createElement(v12)
			expect(function() --[[ Line: 136 | Upvalues: v1 (ref), v2 (copy) ]]
				v1.mountVirtualNode(v2, nil, "Test")
			end).to.throw()
		end)
	end)
	it("should throw if validateProps returns false", function() --[[ Line: 142 | Upvalues: GlobalConfig (copy), Component (copy), createElement (copy), v1 (copy) ]]
		GlobalConfig.scoped({
			propValidation = true
		}, function() --[[ Line: 147 | Upvalues: Component (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("MyComponent")
			function v12.validateProps() --[[ Line: 149 ]]
				return false
			end
			function v12.render(p1) --[[ Line: 153 ]]
				return nil
			end
			local v2 = createElement(v12)
			expect(function() --[[ Line: 161 | Upvalues: v1 (ref), v2 (copy) ]]
				v1.mountVirtualNode(v2, nil, "Test")
			end).to.throw()
		end)
	end)
	it("should include the component name in the error message", function() --[[ Line: 167 | Upvalues: GlobalConfig (copy), Component (copy), createElement (copy), v1 (copy) ]]
		GlobalConfig.scoped({
			propValidation = true
		}, function() --[[ Line: 172 | Upvalues: Component (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("MyComponent")
			function v12.validateProps() --[[ Line: 174 ]]
				return false
			end
			function v12.render(p1) --[[ Line: 178 ]]
				return nil
			end
			local v2 = createElement(v12)
			local v3, v4 = pcall(function() --[[ Line: 186 | Upvalues: v1 (ref), v2 (copy) ]]
				v1.mountVirtualNode(v2, nil, "Test")
			end)
			expect(v3).to.equal(false)
			expect((v4:find("MyComponent"))).to.be.ok()
		end)
	end)
	it("should be invoked after defaultProps are applied", function() --[[ Line: 196 | Upvalues: GlobalConfig (copy), Component (copy), createSpy (copy), createElement (copy), v1 (copy) ]]
		GlobalConfig.scoped({
			propValidation = true
		}, function() --[[ Line: 201 | Upvalues: Component (ref), createSpy (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("MyComponent")
			local v2 = createSpy(function() --[[ Line: 204 ]]
				return true
			end)
			v12.validateProps = v2.value
			function v12.render(p1) --[[ Line: 210 ]]
				return nil
			end
			v12.defaultProps = {
				b = 2
			}
			local v4 = v1.mountVirtualNode(createElement(v12, {
				a = 1
			}), nil, "Test")
			expect(v2.callCount).to.equal(1)
			v2:assertCalledWithDeepEqual({
				a = 1,
				b = 2
			})
			v1.updateVirtualNode(v4, (createElement(v12, {
				a = 2
			})))
			expect(v2.callCount).to.equal(2)
			v2:assertCalledWithDeepEqual({
				a = 2,
				b = 2
			})
		end)
	end)
	it("should not be invoked if the flag is off", function() --[[ Line: 239 | Upvalues: GlobalConfig (copy), Component (copy), createSpy (copy), createElement (copy), v1 (copy) ]]
		GlobalConfig.scoped({
			propValidation = false
		}, function() --[[ Line: 244 | Upvalues: Component (ref), createSpy (ref), createElement (ref), v1 (ref) ]]
			local v12 = Component:extend("MyComponent")
			local v2 = createSpy(function() --[[ Line: 247 ]]
				return true
			end)
			v12.validateProps = v2.value
			function v12.render(p1) --[[ Line: 253 ]]
				return nil
			end
			local v4 = v1.mountVirtualNode(createElement(v12, {
				a = 1
			}), nil, "Test")
			expect(v2.callCount).to.equal(0)
			v1.updateVirtualNode(v4, (createElement(v12, {
				a = 2
			})))
			expect(v2.callCount).to.equal(0)
		end)
	end)
end