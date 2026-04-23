return function() --[[ Line: 1 ]]
	local assign = require(script.Parent.assign)
	local createElement = require(script.Parent.createElement)
	local createFragment = require(script.Parent.createFragment)
	local createSpy = require(script.Parent.createSpy)
	local NoopRenderer = require(script.Parent.NoopRenderer)
	local Type = require(script.Parent.Type)
	local ElementKind = require(script.Parent.ElementKind)
	local createReconciler = require(script.Parent.createReconciler)
	local v1 = createReconciler(NoopRenderer)
	describe("tree operations", function() --[[ Line: 14 | Upvalues: v1 (copy), createElement (copy) ]]
		it("should mount and unmount", function() --[[ Line: 15 | Upvalues: v1 (ref), createElement (ref) ]]
			local v12 = v1.mountVirtualTree(createElement("StringValue"))
			expect(v12).to.be.ok()
			v1.unmountVirtualTree(v12)
		end)
		it("should mount, update, and unmount", function() --[[ Line: 23 | Upvalues: v1 (ref), createElement (ref) ]]
			local v12 = v1.mountVirtualTree(createElement("StringValue"))
			expect(v12).to.be.ok()
			v1.updateVirtualTree(v12, createElement("StringValue"))
			v1.unmountVirtualTree(v12)
		end)
	end)
	describe("booleans", function() --[[ Line: 34 | Upvalues: v1 (copy), createElement (copy) ]]
		it("should mount booleans as nil", function() --[[ Line: 35 | Upvalues: v1 (ref) ]]
			expect((v1.mountVirtualNode(false, nil, "test"))).to.equal(nil)
		end)
		it("should unmount nodes if they are updated to a boolean value", function() --[[ Line: 40 | Upvalues: v1 (ref), createElement (ref) ]]
			local v12 = v1.mountVirtualNode(createElement("StringValue"), nil, "test")
			expect(v12).to.be.ok()
			expect((v1.updateVirtualNode(v12, true))).to.equal(nil)
		end)
	end)
	describe("invalid elements", function() --[[ Line: 51 | Upvalues: v1 (copy), createElement (copy) ]]
		it("should throw errors when attempting to mount invalid elements", function() --[[ Line: 52 | Upvalues: v1 (ref), createElement (ref) ]]
			local function f1() --[[ Line: 54 ]]
				return "Hello"
			end
			local function f2() --[[ Line: 57 ]]
				return 1
			end
			local function f3() --[[ Line: 60 ]]
				return function() --[[ Line: 61 ]] end
			end
			local function f4() --[[ Line: 63 ]]
				return {}
			end
			expect(function() --[[ Line: 70 | Upvalues: v1 (ref), createElement (ref), f1 (copy) ]]
				v1.mountVirtualNode(createElement(f1), nil, "Some Key")
			end).to.throw()
			expect(function() --[[ Line: 74 | Upvalues: v1 (ref), createElement (ref), f2 (copy) ]]
				v1.mountVirtualNode(createElement(f2), nil, "Some Key")
			end).to.throw()
			expect(function() --[[ Line: 78 | Upvalues: v1 (ref), createElement (ref), f3 (copy) ]]
				v1.mountVirtualNode(createElement(f3), nil, "Some Key")
			end).to.throw()
			expect(function() --[[ Line: 82 | Upvalues: v1 (ref), createElement (ref), f4 (copy) ]]
				v1.mountVirtualNode(createElement(f4), nil, "Some Key")
			end).to.throw()
		end)
	end)
	describe("Host components", function() --[[ Line: 88 | Upvalues: createSpy (copy), NoopRenderer (copy), assign (copy), createReconciler (copy), createElement (copy), Type (copy) ]]
		it("should invoke the renderer to mount host nodes", function() --[[ Line: 89 | Upvalues: createSpy (ref), NoopRenderer (ref), assign (ref), createReconciler (ref), createElement (ref), Type (ref) ]]
			local v1 = createSpy(NoopRenderer.mountHostNode)
			local v2 = createReconciler((assign({}, NoopRenderer, {
				mountHostNode = v1.value
			})))
			local v4 = v2.mountVirtualNode(createElement("StringValue"), nil, "Some Key")
			expect(Type.of(v4)).to.equal(Type.VirtualNode)
			expect(v1.callCount).to.equal(1)
			local v5 = v1:captureValues("reconciler", "node")
			expect(v5.reconciler).to.equal(v2)
			expect(v5.node).to.equal(v4)
		end)
		it("should invoke the renderer to update host nodes", function() --[[ Line: 113 | Upvalues: createSpy (ref), NoopRenderer (ref), assign (ref), createReconciler (ref), createElement (ref), Type (ref) ]]
			local v1 = createSpy(NoopRenderer.updateHostNode)
			local v2 = createReconciler((assign({}, NoopRenderer, {
				mountHostNode = NoopRenderer.mountHostNode,
				updateHostNode = v1.value
			})))
			local v4 = v2.mountVirtualNode(createElement("StringValue"), nil, "Key")
			expect(Type.of(v4)).to.equal(Type.VirtualNode)
			local v5 = createElement("StringValue")
			expect((v2.updateVirtualNode(v4, v5))).to.equal(v4)
			expect(v1.callCount).to.equal(1)
			local v7 = v1:captureValues("reconciler", "node", "newElement")
			expect(v7.reconciler).to.equal(v2)
			expect(v7.node).to.equal(v4)
			expect(v7.newElement).to.equal(v5)
		end)
		it("should invoke the renderer to unmount host nodes", function() --[[ Line: 144 | Upvalues: createSpy (ref), NoopRenderer (ref), assign (ref), createReconciler (ref), createElement (ref), Type (ref) ]]
			local v1 = createSpy(NoopRenderer.unmountHostNode)
			local v2 = createReconciler((assign({}, NoopRenderer, {
				mountHostNode = NoopRenderer.mountHostNode,
				unmountHostNode = v1.value
			})))
			local v4 = v2.mountVirtualNode(createElement("StringValue"), nil, "Key")
			expect(Type.of(v4)).to.equal(Type.VirtualNode)
			v2.unmountVirtualNode(v4)
			expect(v1.callCount).to.equal(1)
			local v5 = v1:captureValues("reconciler", "node")
			expect(v5.reconciler).to.equal(v2)
			expect(v5.node).to.equal(v4)
		end)
	end)
	describe("Function components", function() --[[ Line: 172 | Upvalues: createSpy (copy), createElement (copy), v1 (copy), Type (copy), createFragment (copy) ]]
		it("should mount and unmount function components", function() --[[ Line: 173 | Upvalues: createSpy (ref), createElement (ref), v1 (ref), Type (ref) ]]
			local v12 = createSpy(function(p1) --[[ Line: 174 ]]
				return nil
			end)
			local v3 = v1.mountVirtualNode(createElement(v12.value, {
				someValue = 5
			}), nil, "A Key")
			expect(Type.of(v3)).to.equal(Type.VirtualNode)
			expect(v12.callCount).to.equal(1)
			local v4 = v12:captureValues("props")
			expect(v4.props).to.be.a("table")
			expect(v4.props.someValue).to.equal(5)
			v1.unmountVirtualNode(v3)
			expect(v12.callCount).to.equal(1)
		end)
		it("should mount single children of function components", function() --[[ Line: 199 | Upvalues: createSpy (ref), createElement (ref), v1 (ref), Type (ref) ]]
			local v12 = createSpy(function(p1) --[[ Line: 200 ]]
				return nil
			end)
			local v2 = createSpy(function(p1) --[[ Line: 204 | Upvalues: createElement (ref), v12 (copy) ]]
				return createElement(v12.value, {
					value = p1.value + 1
				})
			end)
			local v4 = v1.mountVirtualNode(createElement(v2.value, {
				value = 13
			}), nil, "A Key")
			expect(Type.of(v4)).to.equal(Type.VirtualNode)
			expect(v2.callCount).to.equal(1)
			expect(v12.callCount).to.equal(1)
			local v5 = v2:captureValues("props")
			local v6 = v12:captureValues("props")
			expect(v5.props).to.be.a("table")
			expect(v5.props.value).to.equal(13)
			expect(v6.props).to.be.a("table")
			expect(v6.props.value).to.equal(14)
			v1.unmountVirtualNode(v4)
			expect(v2.callCount).to.equal(1)
			expect(v12.callCount).to.equal(1)
		end)
		it("should mount fragments returned by function components", function() --[[ Line: 237 | Upvalues: createSpy (ref), createFragment (ref), createElement (ref), v1 (ref), Type (ref) ]]
			local v12 = createSpy(function(p1) --[[ Line: 238 ]]
				return nil
			end)
			local v2 = createSpy(function(p1) --[[ Line: 242 ]]
				return nil
			end)
			local v3 = createSpy(function(p1) --[[ Line: 246 | Upvalues: createFragment (ref), createElement (ref), v12 (copy), v2 (copy) ]]
				return createFragment({
					A = createElement(v12.value, {
						value = p1.value + 1
					}),
					B = createElement(v2.value, {
						value = p1.value + 5
					})
				})
			end)
			local v5 = v1.mountVirtualNode(createElement(v3.value, {
				value = 17
			}), nil, "A Key")
			expect(Type.of(v5)).to.equal(Type.VirtualNode)
			expect(v3.callCount).to.equal(1)
			expect(v12.callCount).to.equal(1)
			expect(v2.callCount).to.equal(1)
			local v6 = v3:captureValues("props")
			local v7 = v12:captureValues("props")
			local v8 = v2:captureValues("props")
			expect(v6.props).to.be.a("table")
			expect(v6.props.value).to.equal(17)
			expect(v7.props).to.be.a("table")
			expect(v7.props.value).to.equal(18)
			expect(v8.props).to.be.a("table")
			expect(v8.props.value).to.equal(22)
			v1.unmountVirtualNode(v5)
			expect(v3.callCount).to.equal(1)
			expect(v12.callCount).to.equal(1)
			expect(v2.callCount).to.equal(1)
		end)
	end)
	describe("Fragments", function() --[[ Line: 291 | Upvalues: createFragment (copy), v1 (copy), ElementKind (copy), createSpy (copy), createElement (copy) ]]
		it("should mount fragments", function() --[[ Line: 292 | Upvalues: createFragment (ref), v1 (ref), ElementKind (ref) ]]
			local v2 = v1.mountVirtualNode(createFragment({}), nil, "test")
			expect(v2).to.be.ok()
			expect(ElementKind.of(v2.currentElement)).to.equal(ElementKind.Fragment)
		end)
		it("should mount an empty fragment", function() --[[ Line: 300 | Upvalues: createFragment (ref), v1 (ref) ]]
			local v2 = v1.mountVirtualNode(createFragment({}), nil, "test")
			expect(v2).to.be.ok()
			expect((next(v2.children))).to.never.be.ok()
		end)
		it("should mount all fragment\'s children", function() --[[ Line: 310 | Upvalues: createSpy (ref), createElement (ref), createFragment (ref), v1 (ref) ]]
			local v12 = createSpy(function(p1) --[[ Line: 311 ]]
				return nil
			end)
			local t = {}
			for i = 1, 5 do
				t["key" .. tostring(i)] = createElement(v12.value, {})
			end
			expect((v1.mountVirtualNode(createFragment(t), nil, "test"))).to.be.ok()
			expect(v12.callCount).to.equal(5)
		end)
	end)
end