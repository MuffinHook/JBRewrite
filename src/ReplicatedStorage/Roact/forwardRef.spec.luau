-- Reviewed by Claude
-- variables reassigned
return function()
	local assign = require(script.Parent.assign)
	local createElement = require(script.Parent.createElement)
	local createRef = require(script.Parent.createRef)
	local forwardRef = require(script.Parent.forwardRef)
	local createReconciler = require(script.Parent.createReconciler)
	local Component = require(script.Parent.Component)
	local GlobalConfig = require(script.Parent.GlobalConfig)
	local Ref = require(script.Parent.PropMarkers.Ref)
	local module1 = createReconciler((require(script.Parent.RobloxRenderer)))
	it("should update refs when switching between children", function()
 local function FunctionComponent(self)
 local forwardedRef = self.forwardedRef
 local module1, fn2
 if self.setRefOnDiv then
 module1 = forwardedRef
 fn2 = nil
 else
 module1 = nil
 fn2 = forwardedRef
 end
 return createElement("Frame", nil, {
 First = createElement("Frame", {
 [Ref] = module1
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
 local fn = forwardRef(function(self, callback)
 return createElement(FunctionComponent, assign({}, self, {
 forwardedRef = callback
 }))
 end)
 local fn2 = createRef()
 local currentState = module1.mountVirtualTree(createElement(fn, {
 [Ref] = fn2,
 setRefOnDiv = true
 }), nil, "switch refs")
 expect(fn2.current.ClassName).to.equal("Frame")
 module1.unmountVirtualTree(currentState)
 local tempState = module1.mountVirtualTree(createElement(fn, {
 [Ref] = fn2,
 setRefOnDiv = false
 }), nil, "switch refs")
 expect(fn2.current.ClassName).to.equal("ScrollingFrame")
 module1.unmountVirtualTree(tempState)
	end)
	it("should support rendering nil", function()
 local fn = forwardRef(function(self, callback)
 return nil
 end)
 local fn2 = createRef()
 local currentState = module1.mountVirtualTree(createElement(fn, {
 [Ref] = fn2
 }), nil, "nil ref")
 expect(fn2.current).to.equal(nil)
 module1.unmountVirtualTree(currentState)
	end)
	it("should support rendering nil for multiple children", function()
 local fn = forwardRef(function(self, callback)
 return nil
 end)
 local fn2 = createRef()
 local currentState = module1.mountVirtualTree(createElement("Frame", nil, {
 NoRef1 = createElement("Frame"),
 WithRef = createElement(fn, {
 [Ref] = fn2
 }),
 NoRef2 = createElement("Frame")
 }), nil, "multiple children nil ref")
 expect(fn2.current).to.equal(nil)
 module1.unmountVirtualTree(currentState)
	end)
	itSKIP("should support defaultProps", function()
 local function FunctionComponent(self)
 return createElement("Frame", {
 [Ref] = self.forwardedRef
 }, {
 OptionalChild = self.optional,
 RequiredChild = self.required
 })
 end
 local fn = forwardRef(function(self, callback)
 return createElement(FunctionComponent, assign({}, self, {
 forwardedRef = callback
 }))
 end)
 fn.defaultProps = {
 optional = createElement("TextLabel")
 }
 local fn2 = createRef()
 local currentState = module1.mountVirtualTree(createElement(fn, {
 [Ref] = fn2,
 optional = createElement("Frame"),
 required = createElement("ScrollingFrame")
 }), nil, "with optional")
 expect(fn2.current:FindFirstChild("OptionalChild").ClassName).to.equal("Frame")
 expect(fn2.current:FindFirstChild("RequiredChild").ClassName).to.equal("ScrollingFrame")
 module1.unmountVirtualTree(currentState)
 local tempState = module1.mountVirtualTree(createElement(fn, {
 [Ref] = fn2,
 required = createElement("ScrollingFrame")
 }), nil, "with default")
 expect(fn2.current:FindFirstChild("OptionalChild").ClassName).to.equal("TextLabel")
 expect(fn2.current:FindFirstChild("RequiredChild").ClassName).to.equal("ScrollingFrame")
 module1.unmountVirtualTree(tempState)
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
 local function Wrapper(self)
 return createElement(Child, assign({}, self, {
 [Ref] = self.forwardedRef
 }))
 end
 module1.unmountVirtualTree((module1.mountVirtualTree(createElement(forwardRef(function(self, callback)
 return createElement(Wrapper, assign({}, self, {
 forwardedRef = callback
 }))
 end), {
 value = 123
 }), nil, "nil ref")))
	end)
	it("should forward a ref for a single child", function()
 local fn = nil
 local function Child(self)
 fn = self.value
 return createElement("Frame", {
 [Ref] = self[Ref]
 })
 end
 local function Wrapper(self)
 return createElement(Child, assign({}, self, {
 [Ref] = self.forwardedRef
 }))
 end
 local fn2 = forwardRef(function(self, callback)
 return createElement(Wrapper, assign({}, self, {
 forwardedRef = callback
 }))
 end)
 local fn3 = createRef()
 local nextState = module1.mountVirtualTree(createElement(fn2, {
 [Ref] = fn3,
 value = 123
 }), nil, "single child ref")
 expect(fn).to.equal(123)
 expect(fn3.current.ClassName).to.equal("Frame")
 module1.unmountVirtualTree(nextState)
	end)
	it("should forward a ref for multiple children", function()
 local function Child(self)
 return createElement("Frame", {
 [Ref] = self[Ref]
 })
 end
 local function Wrapper(self)
 return createElement(Child, assign({}, self, {
 [Ref] = self.forwardedRef
 }))
 end
 local fn = forwardRef(function(self, callback)
 return createElement(Wrapper, assign({}, self, {
 forwardedRef = callback
 }))
 end)
 local fn2 = createRef()
 local currentState = module1.mountVirtualTree(createElement("Frame", nil, {
 NoRef1 = createElement("Frame"),
 WithRef = createElement(fn, {
 [Ref] = fn2
 }),
 NoRef2 = createElement("Frame")
 }), nil, "multi child ref")
 expect(fn2.current.ClassName).to.equal("Frame")
 module1.unmountVirtualTree(currentState)
	end)
	it("should maintain child instance and ref through updates", function()
 local fn = nil
 local function Child(self)
 fn = self.value
 return createElement("Frame", {
 [Ref] = self[Ref]
 })
 end
 local function Wrapper(self)
 return createElement(Child, assign({}, self, {
 [Ref] = self.forwardedRef
 }))
 end
 local fn2 = forwardRef(function(self, callback)
 return createElement(Wrapper, assign({}, self, {
 forwardedRef = callback
 }))
 end)
 local fn3 = 0
 local currentState = nil
 local function f5(self)
 fn3 = fn3 + 1
 currentState = self
 end
 local mergedState = module1.mountVirtualTree(createElement(fn2, {
 [Ref] = f5,
 value = 123
 }), nil, "maintains instance")
 expect(fn).to.equal(123)
 expect(currentState.ClassName).to.equal("Frame")
 expect(fn3).to.equal(1)
 local finalState = module1.updateVirtualTree(mergedState, (createElement(fn2, {
 [Ref] = f5,
 value = 456
 })))
 expect(fn).to.equal(456)
 expect(fn3).to.equal(1)
 module1.unmountVirtualTree(finalState)
	end)
	it("should not re-run the render callback on a deep setState", function()
 local fn = nil
 local tableObj = {}
 local fn2 = Component:extend("Inner")
 function fn2.render(self)
 table.insert(tableObj, "Inner")
 fn = self
 return createElement("Frame", {
 [Ref] = self.props.forwardedRef
 })
 end
 local function Middle(self)
 table.insert(tableObj, "Middle")
 return createElement(fn2, self)
 end
 local fn3 = forwardRef(function(self, callback)
 table.insert(tableObj, "Forward")
 return createElement(Middle, assign({}, self, {
 forwardedRef = callback
 }))
 end)
 local function App()
 table.insert(tableObj, "App")
 return createElement(fn3)
 end
 local currentState = module1.mountVirtualTree(createElement(App), nil, "deep setState")
 expect(#tableObj).to.equal(4)
 expect(tableObj[1]).to.equal("App")
 expect(tableObj[2]).to.equal("Forward")
 expect(tableObj[3]).to.equal("Middle")
 expect(tableObj[4]).to.equal("Inner")
 tableObj = {}
 fn:setState({})
 expect(#tableObj).to.equal(1)
 expect(tableObj[1]).to.equal("Inner")
 module1.unmountVirtualTree(currentState)
	end)
	it("should not include the ref in the forwarded props", function()
 local fn = nil
 local function CaptureProps(self)
 fn = self
 return createElement("Frame", {
 [Ref] = self.forwardedRef
 })
 end
 local fn2 = forwardRef(function(self, callback)
 return createElement(CaptureProps, assign({}, self, {
 forwardedRef = callback
 }))
 end)
 local fn3 = createRef()
 local nextState = module1.mountVirtualTree(createElement(fn2, {
 [Ref] = fn3
 }), nil, "no ref in props")
 expect(fn).to.be.ok()
 expect(fn.forwardedRef).to.equal(fn3)
 expect(fn[Ref]).to.equal(nil)
 module1.unmountVirtualTree(nextState)
	end)
end
