-- Reviewed by Claude
return function()
	local assign = require(script.Parent.assign)
	local createElement = require(script.Parent.createElement)
	local createRef = require(script.Parent.createRef)
	local forwardRef = require(script.Parent.forwardRef)
	local createReconciler = require(script.Parent.createReconciler)
	local Component = require(script.Parent.Component)
	local GlobalConfig = require(script.Parent.GlobalConfig)
	local Ref = require(script.Parent.PropMarkers.Ref)
	local v1 = createReconciler((require(script.Parent.RobloxRenderer)))
	it("should update refs when switching between children", function()
 local function FunctionComponent(p1)
 local forwardedRef = p1.forwardedRef
 local v1, fn2
 if p1.setRefOnDiv then
 v1 = forwardedRef
 fn2 = nil
 else
 v1 = nil
 fn2 = forwardedRef
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
 [Ref] = fn2
 }, {
 Child = createElement("TextLabel", {
 Text = "Second"
 })
 })
 })
 end
 local fn = forwardRef(function(p1, p2)
 return createElement(FunctionComponent, assign({}, p1, {
 forwardedRef = p2
 }))
 end)
 local fn2 = createRef()
 local v4 = v1.mountVirtualTree(createElement(fn, {
 [Ref] = fn2,
 setRefOnDiv = true
 }), nil, "switch refs")
 expect(fn2.current.ClassName).to.equal("Frame")
 v1.unmountVirtualTree(v4)
 local v6 = v1.mountVirtualTree(createElement(fn, {
 [Ref] = fn2,
 setRefOnDiv = false
 }), nil, "switch refs")
 expect(fn2.current.ClassName).to.equal("ScrollingFrame")
 v1.unmountVirtualTree(v6)
	end)
	it("should support rendering nil", function()
 local fn = forwardRef(function(p1, p2)
 return nil
 end)
 local fn2 = createRef()
 local v4 = v1.mountVirtualTree(createElement(fn, {
 [Ref] = fn2
 }), nil, "nil ref")
 expect(fn2.current).to.equal(nil)
 v1.unmountVirtualTree(v4)
	end)
	it("should support rendering nil for multiple children", function()
 local fn = forwardRef(function(p1, p2)
 return nil
 end)
 local fn2 = createRef()
 local v4 = v1.mountVirtualTree(createElement("Frame", nil, {
 NoRef1 = createElement("Frame"),
 WithRef = createElement(fn, {
 [Ref] = fn2
 }),
 NoRef2 = createElement("Frame")
 }), nil, "multiple children nil ref")
 expect(fn2.current).to.equal(nil)
 v1.unmountVirtualTree(v4)
	end)
	itSKIP("should support defaultProps", function()
 local function FunctionComponent(p1)
 return createElement("Frame", {
 [Ref] = p1.forwardedRef
 }, {
 OptionalChild = p1.optional,
 RequiredChild = p1.required
 })
 end
 local fn = forwardRef(function(p1, p2)
 return createElement(FunctionComponent, assign({}, p1, {
 forwardedRef = p2
 }))
 end)
 fn.defaultProps = {
 optional = createElement("TextLabel")
 }
 local fn2 = createRef()
 local v4 = v1.mountVirtualTree(createElement(fn, {
 [Ref] = fn2,
 optional = createElement("Frame"),
 required = createElement("ScrollingFrame")
 }), nil, "with optional")
 expect(fn2.current:FindFirstChild("OptionalChild").ClassName).to.equal("Frame")
 expect(fn2.current:FindFirstChild("RequiredChild").ClassName).to.equal("ScrollingFrame")
 v1.unmountVirtualTree(v4)
 local v6 = v1.mountVirtualTree(createElement(fn, {
 [Ref] = fn2,
 required = createElement("ScrollingFrame")
 }), nil, "with default")
 expect(fn2.current:FindFirstChild("OptionalChild").ClassName).to.equal("TextLabel")
 expect(fn2.current:FindFirstChild("RequiredChild").ClassName).to.equal("ScrollingFrame")
 v1.unmountVirtualTree(v6)
	end)
	it("should error if not provided a callback when type checking is enabled", function()
 GlobalConfig.scoped({
 typeChecks = true
 }, function()
 expect(function()
 forwardRef(nil)
 end).to.throw()
 end)
 GlobalConfig.scoped({
 typeChecks = true
 }, function()
 expect(function()
 forwardRef("foo")
 end).to.throw()
 end)
	end)
	it("should work without a ref to be forwarded", function()
 local function Child()
 return nil
 end
 local function Wrapper(p1)
 return createElement(Child, assign({}, p1, {
 [Ref] = p1.forwardedRef
 }))
 end
 v1.unmountVirtualTree((v1.mountVirtualTree(createElement(forwardRef(function(p1, p2)
 return createElement(Wrapper, assign({}, p1, {
 forwardedRef = p2
 }))
 end), {
 value = 123
 }), nil, "nil ref")))
	end)
	it("should forward a ref for a single child", function()
 local fn = nil
 local function Child(p1)
 fn = p1.value
 return createElement("Frame", {
 [Ref] = p1[Ref]
 })
 end
 local function Wrapper(p1)
 return createElement(Child, assign({}, p1, {
 [Ref] = p1.forwardedRef
 }))
 end
 local fn2 = forwardRef(function(p1, p2)
 return createElement(Wrapper, assign({}, p1, {
 forwardedRef = p2
 }))
 end)
 local fn3 = createRef()
 local v5 = v1.mountVirtualTree(createElement(fn2, {
 [Ref] = fn3,
 value = 123
 }), nil, "single child ref")
 expect(fn).to.equal(123)
 expect(fn3.current.ClassName).to.equal("Frame")
 v1.unmountVirtualTree(v5)
	end)
	it("should forward a ref for multiple children", function()
 local function Child(p1)
 return createElement("Frame", {
 [Ref] = p1[Ref]
 })
 end
 local function Wrapper(p1)
 return createElement(Child, assign({}, p1, {
 [Ref] = p1.forwardedRef
 }))
 end
 local fn = forwardRef(function(p1, p2)
 return createElement(Wrapper, assign({}, p1, {
 forwardedRef = p2
 }))
 end)
 local fn2 = createRef()
 local v4 = v1.mountVirtualTree(createElement("Frame", nil, {
 NoRef1 = createElement("Frame"),
 WithRef = createElement(fn, {
 [Ref] = fn2
 }),
 NoRef2 = createElement("Frame")
 }), nil, "multi child ref")
 expect(fn2.current.ClassName).to.equal("Frame")
 v1.unmountVirtualTree(v4)
	end)
	it("should maintain child instance and ref through updates", function()
 local fn = nil
 local function Child(p1)
 fn = p1.value
 return createElement("Frame", {
 [Ref] = p1[Ref]
 })
 end
 local function Wrapper(p1)
 return createElement(Child, assign({}, p1, {
 [Ref] = p1.forwardedRef
 }))
 end
 local fn2 = forwardRef(function(p1, p2)
 return createElement(Wrapper, assign({}, p1, {
 forwardedRef = p2
 }))
 end)
 local fn3 = 0
 local v4 = nil
 local function f5(p1)
 fn3 = fn3 + 1
 v4 = p1
 end
 local v7 = v1.mountVirtualTree(createElement(fn2, {
 [Ref] = f5,
 value = 123
 }), nil, "maintains instance")
 expect(fn).to.equal(123)
 expect(v4.ClassName).to.equal("Frame")
 expect(fn3).to.equal(1)
 local v9 = v1.updateVirtualTree(v7, (createElement(fn2, {
 [Ref] = f5,
 value = 456
 })))
 expect(fn).to.equal(456)
 expect(fn3).to.equal(1)
 v1.unmountVirtualTree(v9)
	end)
	it("should not re-run the render callback on a deep setState", function()
 local fn = nil
 local tbl = {}
 local fn2 = Component:extend("Inner")
 function fn2.render(p1)
 table.insert(tbl, "Inner")
 fn = p1
 return createElement("Frame", {
 [Ref] = p1.props.forwardedRef
 })
 end
 local function Middle(p1)
 table.insert(tbl, "Middle")
 return createElement(fn2, p1)
 end
 local fn3 = forwardRef(function(p1, p2)
 table.insert(tbl, "Forward")
 return createElement(Middle, assign({}, p1, {
 forwardedRef = p2
 }))
 end)
 local function App()
 table.insert(tbl, "App")
 return createElement(fn3)
 end
 local v4 = v1.mountVirtualTree(createElement(App), nil, "deep setState")
 expect(#tbl).to.equal(4)
 expect(tbl[1]).to.equal("App")
 expect(tbl[2]).to.equal("Forward")
 expect(tbl[3]).to.equal("Middle")
 expect(tbl[4]).to.equal("Inner")
 tbl = {}
 fn:setState({})
 expect(#tbl).to.equal(1)
 expect(tbl[1]).to.equal("Inner")
 v1.unmountVirtualTree(v4)
	end)
	it("should not include the ref in the forwarded props", function()
 local fn = nil
 local function CaptureProps(p1)
 fn = p1
 return createElement("Frame", {
 [Ref] = p1.forwardedRef
 })
 end
 local fn2 = forwardRef(function(p1, p2)
 return createElement(CaptureProps, assign({}, p1, {
 forwardedRef = p2
 }))
 end)
 local fn3 = createRef()
 local v5 = v1.mountVirtualTree(createElement(fn2, {
 [Ref] = fn3
 }), nil, "no ref in props")
 expect(fn).to.be.ok()
 expect(fn.forwardedRef).to.equal(fn3)
 expect(fn[Ref]).to.equal(nil)
 v1.unmountVirtualTree(v5)
	end)
end