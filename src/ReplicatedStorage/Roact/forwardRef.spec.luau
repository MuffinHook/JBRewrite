return function() --[[ Line: 4 ]]
	local assign = require(script.Parent.assign)
	local createElement = require(script.Parent.createElement)
	local createRef = require(script.Parent.createRef)
	local forwardRef = require(script.Parent.forwardRef)
	local createReconciler = require(script.Parent.createReconciler)
	local Component = require(script.Parent.Component)
	local GlobalConfig = require(script.Parent.GlobalConfig)
	local Ref = require(script.Parent.PropMarkers.Ref)
	local v1 = createReconciler((require(script.Parent.RobloxRenderer)))
	it("should update refs when switching between children", function() --[[ Line: 18 | Upvalues: createElement (copy), Ref (copy), forwardRef (copy), assign (copy), createRef (copy), v1 (copy) ]]
		local function FunctionComponent(p1) --[[ Line: 19 | Upvalues: createElement (ref), Ref (ref) ]]
			local forwardedRef = p1.forwardedRef
			local v1, v2
			if p1.setRefOnDiv then
				v1 = forwardedRef
				v2 = nil
			else
				v1 = nil
				v2 = forwardedRef
			end
			return createElement("Frame", nil, {
				First = createElement("Frame", {
					[Ref] = v1
				}, {
					Child = createElement("TextLabel", {
						Text = "First"
					})
				}),
				Second = createElement("ScrollingFrame", {
					[Ref] = v2
				}, {
					Child = createElement("TextLabel", {
						Text = "Second"
					})
				})
			})
		end
		local v12 = forwardRef(function(p1, p2) --[[ Line: 48 | Upvalues: createElement (ref), FunctionComponent (copy), assign (ref) ]]
			return createElement(FunctionComponent, assign({}, p1, {
				forwardedRef = p2
			}))
		end)
		local v2 = createRef()
		local v4 = v1.mountVirtualTree(createElement(v12, {
			[Ref] = v2,
			setRefOnDiv = true
		}), nil, "switch refs")
		expect(v2.current.ClassName).to.equal("Frame")
		v1.unmountVirtualTree(v4)
		local v6 = v1.mountVirtualTree(createElement(v12, {
			[Ref] = v2,
			setRefOnDiv = false
		}), nil, "switch refs")
		expect(v2.current.ClassName).to.equal("ScrollingFrame")
		v1.unmountVirtualTree(v6)
	end)
	it("should support rendering nil", function() --[[ Line: 71 | Upvalues: forwardRef (copy), createRef (copy), createElement (copy), Ref (copy), v1 (copy) ]]
		local v12 = forwardRef(function(p1, p2) --[[ Line: 72 ]]
			return nil
		end)
		local v2 = createRef()
		local v4 = v1.mountVirtualTree(createElement(v12, {
			[Ref] = v2
		}), nil, "nil ref")
		expect(v2.current).to.equal(nil)
		v1.unmountVirtualTree(v4)
	end)
	it("should support rendering nil for multiple children", function() --[[ Line: 84 | Upvalues: forwardRef (copy), createRef (copy), createElement (copy), Ref (copy), v1 (copy) ]]
		local v12 = forwardRef(function(p1, p2) --[[ Line: 85 ]]
			return nil
		end)
		local v2 = createRef()
		local v4 = v1.mountVirtualTree(createElement("Frame", nil, {
			NoRef1 = createElement("Frame"),
			WithRef = createElement(v12, {
				[Ref] = v2
			}),
			NoRef2 = createElement("Frame")
		}), nil, "multiple children nil ref")
		expect(v2.current).to.equal(nil)
		v1.unmountVirtualTree(v4)
	end)
	itSKIP("should support defaultProps", function() --[[ Line: 103 | Upvalues: createElement (copy), Ref (copy), forwardRef (copy), assign (copy), createRef (copy), v1 (copy) ]]
		local function FunctionComponent(p1) --[[ Line: 104 | Upvalues: createElement (ref), Ref (ref) ]]
			return createElement("Frame", {
				[Ref] = p1.forwardedRef
			}, {
				OptionalChild = p1.optional,
				RequiredChild = p1.required
			})
		end
		local v12 = forwardRef(function(p1, p2) --[[ Line: 116 | Upvalues: createElement (ref), FunctionComponent (copy), assign (ref) ]]
			return createElement(FunctionComponent, assign({}, p1, {
				forwardedRef = p2
			}))
		end)
		v12.defaultProps = {
			optional = createElement("TextLabel")
		}
		local v2 = createRef()
		local v4 = v1.mountVirtualTree(createElement(v12, {
			[Ref] = v2,
			optional = createElement("Frame"),
			required = createElement("ScrollingFrame")
		}), nil, "with optional")
		expect(v2.current:FindFirstChild("OptionalChild").ClassName).to.equal("Frame")
		expect(v2.current:FindFirstChild("RequiredChild").ClassName).to.equal("ScrollingFrame")
		v1.unmountVirtualTree(v4)
		local v6 = v1.mountVirtualTree(createElement(v12, {
			[Ref] = v2,
			required = createElement("ScrollingFrame")
		}), nil, "with default")
		expect(v2.current:FindFirstChild("OptionalChild").ClassName).to.equal("TextLabel")
		expect(v2.current:FindFirstChild("RequiredChild").ClassName).to.equal("ScrollingFrame")
		v1.unmountVirtualTree(v6)
	end)
	it("should error if not provided a callback when type checking is enabled", function() --[[ Line: 153 | Upvalues: GlobalConfig (copy), forwardRef (copy) ]]
		GlobalConfig.scoped({
			typeChecks = true
		}, function() --[[ Line: 156 | Upvalues: forwardRef (ref) ]]
			expect(function() --[[ Line: 157 | Upvalues: forwardRef (ref) ]]
				forwardRef(nil)
			end).to.throw()
		end)
		GlobalConfig.scoped({
			typeChecks = true
		}, function() --[[ Line: 164 | Upvalues: forwardRef (ref) ]]
			expect(function() --[[ Line: 165 | Upvalues: forwardRef (ref) ]]
				forwardRef("foo")
			end).to.throw()
		end)
	end)
	it("should work without a ref to be forwarded", function() --[[ Line: 171 | Upvalues: createElement (copy), assign (copy), Ref (copy), forwardRef (copy), v1 (copy) ]]
		local function Child() --[[ Line: 172 ]]
			return nil
		end
		local function Wrapper(p1) --[[ Line: 176 | Upvalues: createElement (ref), Child (copy), assign (ref), Ref (ref) ]]
			return createElement(Child, assign({}, p1, {
				[Ref] = p1.forwardedRef
			}))
		end
		v1.unmountVirtualTree((v1.mountVirtualTree(createElement(forwardRef(function(p1, p2) --[[ Line: 180 | Upvalues: createElement (ref), Wrapper (copy), assign (ref) ]]
			return createElement(Wrapper, assign({}, p1, {
				forwardedRef = p2
			}))
		end), {
			value = 123
		}), nil, "nil ref")))
	end)
	it("should forward a ref for a single child", function() --[[ Line: 189 | Upvalues: createElement (copy), Ref (copy), assign (copy), forwardRef (copy), createRef (copy), v1 (copy) ]]
		local v12 = nil
		local function Child(p1) --[[ Line: 191 | Upvalues: v12 (ref), createElement (ref), Ref (ref) ]]
			v12 = p1.value
			return createElement("Frame", {
				[Ref] = p1[Ref]
			})
		end
		local function Wrapper(p1) --[[ Line: 198 | Upvalues: createElement (ref), Child (copy), assign (ref), Ref (ref) ]]
			return createElement(Child, assign({}, p1, {
				[Ref] = p1.forwardedRef
			}))
		end
		local v2 = forwardRef(function(p1, p2) --[[ Line: 202 | Upvalues: createElement (ref), Wrapper (copy), assign (ref) ]]
			return createElement(Wrapper, assign({}, p1, {
				forwardedRef = p2
			}))
		end)
		local v3 = createRef()
		local v5 = v1.mountVirtualTree(createElement(v2, {
			[Ref] = v3,
			value = 123
		}), nil, "single child ref")
		expect(v12).to.equal(123)
		expect(v3.current.ClassName).to.equal("Frame")
		v1.unmountVirtualTree(v5)
	end)
	it("should forward a ref for multiple children", function() --[[ Line: 215 | Upvalues: createElement (copy), Ref (copy), assign (copy), forwardRef (copy), createRef (copy), v1 (copy) ]]
		local function Child(p1) --[[ Line: 216 | Upvalues: createElement (ref), Ref (ref) ]]
			return createElement("Frame", {
				[Ref] = p1[Ref]
			})
		end
		local function Wrapper(p1) --[[ Line: 222 | Upvalues: createElement (ref), Child (copy), assign (ref), Ref (ref) ]]
			return createElement(Child, assign({}, p1, {
				[Ref] = p1.forwardedRef
			}))
		end
		local v12 = forwardRef(function(p1, p2) --[[ Line: 226 | Upvalues: createElement (ref), Wrapper (copy), assign (ref) ]]
			return createElement(Wrapper, assign({}, p1, {
				forwardedRef = p2
			}))
		end)
		local v2 = createRef()
		local v4 = v1.mountVirtualTree(createElement("Frame", nil, {
			NoRef1 = createElement("Frame"),
			WithRef = createElement(v12, {
				[Ref] = v2
			}),
			NoRef2 = createElement("Frame")
		}), nil, "multi child ref")
		expect(v2.current.ClassName).to.equal("Frame")
		v1.unmountVirtualTree(v4)
	end)
	it("should maintain child instance and ref through updates", function() --[[ Line: 242 | Upvalues: createElement (copy), Ref (copy), assign (copy), forwardRef (copy), v1 (copy) ]]
		local v12 = nil
		local function Child(p1) --[[ Line: 244 | Upvalues: v12 (ref), createElement (ref), Ref (ref) ]]
			v12 = p1.value
			return createElement("Frame", {
				[Ref] = p1[Ref]
			})
		end
		local function Wrapper(p1) --[[ Line: 251 | Upvalues: createElement (ref), Child (copy), assign (ref), Ref (ref) ]]
			return createElement(Child, assign({}, p1, {
				[Ref] = p1.forwardedRef
			}))
		end
		local v2 = forwardRef(function(p1, p2) --[[ Line: 255 | Upvalues: createElement (ref), Wrapper (copy), assign (ref) ]]
			return createElement(Wrapper, assign({}, p1, {
				forwardedRef = p2
			}))
		end)
		local v3 = 0
		local v4 = nil
		local function f5(p1) --[[ Line: 262 | Upvalues: v3 (ref), v4 (ref) ]]
			v3 = v3 + 1
			v4 = p1
		end
		local v7 = v1.mountVirtualTree(createElement(v2, {
			[Ref] = f5,
			value = 123
		}), nil, "maintains instance")
		expect(v12).to.equal(123)
		expect(v4.ClassName).to.equal("Frame")
		expect(v3).to.equal(1)
		local v9 = v1.updateVirtualTree(v7, (createElement(v2, {
			[Ref] = f5,
			value = 456
		})))
		expect(v12).to.equal(456)
		expect(v3).to.equal(1)
		v1.unmountVirtualTree(v9)
	end)
	it("should not re-run the render callback on a deep setState", function() --[[ Line: 282 | Upvalues: Component (copy), createElement (copy), Ref (copy), forwardRef (copy), assign (copy), v1 (copy) ]]
		local v12 = nil
		local t = {}
		local v2 = Component:extend("Inner")
		function v2.render(p1) --[[ Line: 287 | Upvalues: t (ref), v12 (ref), createElement (ref), Ref (ref) ]]
			table.insert(t, "Inner")
			v12 = p1
			return createElement("Frame", {
				[Ref] = p1.props.forwardedRef
			})
		end
		local function Middle(p1) --[[ Line: 293 | Upvalues: t (ref), createElement (ref), v2 (copy) ]]
			table.insert(t, "Middle")
			return createElement(v2, p1)
		end
		local v3 = forwardRef(function(p1, p2) --[[ Line: 298 | Upvalues: t (ref), createElement (ref), Middle (copy), assign (ref) ]]
			table.insert(t, "Forward")
			return createElement(Middle, assign({}, p1, {
				forwardedRef = p2
			}))
		end)
		local function App() --[[ Line: 303 | Upvalues: t (ref), createElement (ref), v3 (copy) ]]
			table.insert(t, "App")
			return createElement(v3)
		end
		local v4 = v1.mountVirtualTree(createElement(App), nil, "deep setState")
		expect(#t).to.equal(4)
		expect(t[1]).to.equal("App")
		expect(t[2]).to.equal("Forward")
		expect(t[3]).to.equal("Middle")
		expect(t[4]).to.equal("Inner")
		t = {}
		v12:setState({})
		expect(#t).to.equal(1)
		expect(t[1]).to.equal("Inner")
		v1.unmountVirtualTree(v4)
	end)
	it("should not include the ref in the forwarded props", function() --[[ Line: 322 | Upvalues: createElement (copy), Ref (copy), forwardRef (copy), assign (copy), createRef (copy), v1 (copy) ]]
		local v12 = nil
		local function CaptureProps(p1) --[[ Line: 324 | Upvalues: v12 (ref), createElement (ref), Ref (ref) ]]
			v12 = p1
			return createElement("Frame", {
				[Ref] = p1.forwardedRef
			})
		end
		local v2 = forwardRef(function(p1, p2) --[[ Line: 329 | Upvalues: createElement (ref), CaptureProps (copy), assign (ref) ]]
			return createElement(CaptureProps, assign({}, p1, {
				forwardedRef = p2
			}))
		end)
		local v3 = createRef()
		local v5 = v1.mountVirtualTree(createElement(v2, {
			[Ref] = v3
		}), nil, "no ref in props")
		expect(v12).to.be.ok()
		expect(v12.forwardedRef).to.equal(v3)
		expect(v12[Ref]).to.equal(nil)
		v1.unmountVirtualTree(v5)
	end)
end