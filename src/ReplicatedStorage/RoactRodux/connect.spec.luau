-- Reviewed by Claude
return function()
	local connect = require(script.Parent.connect)
	local StoreProvider = require(script.Parent.StoreProvider)
	local Roact = require(script.Parent.Parent.Roact)
	local Rodux = require(script.Parent.Parent.Rodux)
	local function noop()
 return nil
	end
	local function NoopComponent()
 return nil
	end
	local function countReducer(p1, p2)
 local v1 = p1 or 0
 if p2.type == "increment" then
 return v1 + 1
 else
 return v1
 end
	end
	local v1 = Rodux.combineReducers({
 count = countReducer
	})
	describe("Argument validation", function()
 it("should accept no arguments", function()
 connect()
 end)
 it("should accept one function", function()
 connect(noop)
 end)
 it("should accept two functions", function()
 connect(noop, noop)
 end)
 it("should accept only the second function", function()
 connect(nil, function() end)
 end)
 it("should accept one table of action creators", function()
 connect(nil, {
 foo = function() end
 })
 end)
 it("should throw if not passed a component", function()
 local function f1(p1)
 return {}
 end
 expect(function()
 connect(f1)(nil)
 end).to.throw()
 end)
	end)
	it("should throw if not mounted under a StoreProvider", function()
 local v1 = connect()(NoopComponent)
 expect(function()
 Roact.mount(Roact.createElement(v1))
 end).to.throw()
	end)
	it("should accept a higher-order function mapStateToProps", function()
 local v12 = connect(function()
 return function(p1)
 return {
 count = p1.count
 }
 end
 end)(NoopComponent)
 Roact.unmount((Roact.mount((Roact.createElement(StoreProvider, {
 store = Rodux.Store.new(v1)
 }, {
 someComponent = Roact.createElement(v12)
 })))))
	end)
	it("should not accept a higher-order mapStateToProps that returns a non-table value", function()
 local v12 = connect(function()
 return function(p1)
 return "nope"
 end
 end)(NoopComponent)
 local v3 = Roact.createElement(StoreProvider, {
 store = Rodux.Store.new(v1)
 }, {
 someComponent = Roact.createElement(v12)
 })
 expect(function()
 Roact.mount(v3)
 end).to.throw()
	end)
	it("should not accept a mapStateToProps that returns a non-table value", function()
 local v12 = connect(function()
 return "nah"
 end)(NoopComponent)
 local v3 = Roact.createElement(StoreProvider, {
 store = Rodux.Store.new(v1)
 }, {
 someComponent = Roact.createElement(v12)
 })
 expect(function()
 Roact.mount(v3)
 end).to.throw()
	end)
	it("should abort renders when mapStateToProps returns the same data", function()
 local function mapStateToProps(p1)
 return {
 count = p1.count
 }
 end
 local v12 = 0
 local function SomeComponent(p1)
 v12 = v12 + 1
 end
 local v2 = connect(mapStateToProps)(SomeComponent)
 local v3 = Rodux.Store.new(v1)
 local v5 = Roact.mount((Roact.createElement(StoreProvider, {
 store = v3
 }, {
 someComponent = Roact.createElement(v2)
 })))
 expect(v12).to.equal(1)
 v3:dispatch({
 type = "an unknown action"
 })
 v3:flush()
 expect(v12).to.equal(1)
 v3:dispatch({
 type = "increment"
 })
 v3:flush()
 expect(v12).to.equal(2)
 Roact.unmount(v5)
	end)
	it("should only call mapDispatchToProps once and never re-render if no mapStateToProps was passed", function()
 local v12 = 0
 local function f2(p1)
 v12 = v12 + 1
 return {
 increment = function()
 return p1({
 type = "increment"
 })
 end
 }
 end
 local v3 = 0
 local function SomeComponent(p1)
 v3 = v3 + 1
 end
 local v4 = connect(nil, f2)(SomeComponent)
 local v5 = Rodux.Store.new(v1)
 local v7 = Roact.mount((Roact.createElement(StoreProvider, {
 store = v5
 }, {
 someComponent = Roact.createElement(v4)
 })))
 expect(v12).to.equal(1)
 expect(v3).to.equal(1)
 v5:dispatch({
 type = "an unknown action"
 })
 v5:flush()
 expect(v12).to.equal(1)
 expect(v3).to.equal(1)
 v5:dispatch({
 type = "increment"
 })
 v5:flush()
 expect(v12).to.equal(1)
 expect(v3).to.equal(1)
 Roact.unmount(v7)
	end)
	it("should dispatch the action using a table of action creators", function()
 local t = {
 increment = function()
 return {
 type = "increment"
 }
 end
 }
 local function SomeComponent(p1)
 p1.increment()
 end
 local v12 = connect(nil, t)(SomeComponent)
 local v2 = Rodux.Store.new(v1)
 local v4 = Roact.mount((Roact.createElement(StoreProvider, {
 store = v2
 }, {
 someComponent = Roact.createElement(v12)
 })))
 v2.changed:connect(function(p1)
 expect(p1.count).to.equal(1)
 end)
 Roact.unmount(v4)
	end)
	it("should return result values from the dispatch passed to mapDispatchToProps", function()
 local function reducer()
 return 0
 end
 local function fiveThunk()
 return 5
 end
 local v1 = nil
 local function SomeComponent(p1)
 v1 = p1.dispatch
 end
 local v2 = connect(nil, function(p1)
 return {
 dispatch = p1
 }
 end)(SomeComponent)
 local v5 = Roact.mount((Roact.createElement(StoreProvider, {
 store = Rodux.Store.new(reducer, nil, { Rodux.thunkMiddleware })
 }, {
 someComponent = Roact.createElement(v2)
 })))
 expect(v1).to.be.a("function")
 expect(v1(fiveThunk)).to.equal(5)
 Roact.unmount(v5)
	end)
	it("should allow fields to be assigned on connected components", function()
 local v1 = connect(function(p1)
 return {
 count = p1.count
 }
 end)(NoopComponent)
 expect(function()
 v1.SomeEnum = {
 Value = 1
 }
 end).never.to.throw()
 expect(v1.SomeEnum).to.be.ok()
 expect(v1.SomeEnum.Value).to.equal(1)
	end)
	it("should never pass the store and innerProps to `mapStateToProps`", function()
 local t = {}
 local v12 = nil
 local v2 = connect(function(p1, p2)
 v12 = p2
 expect(p2.store).to.equal(nil)
 expect(p2.innerProps).to.equal(nil)
 expect(p2.somePropName).to.equal(t)
 return {
 count = p1.count
 }
 end)(NoopComponent)
 local v3 = Rodux.Store.new(v1)
 local v5 = Roact.mount((Roact.createElement(StoreProvider, {
 store = v3
 }, {
 parent = Roact.createElement(v2, {
 somePropName = t
 })
 })))
 v3:dispatch({
 type = "increment"
 })
 v3:flush()
 expect(v12.store).to.equal(nil)
 expect(v12.innerProps).to.equal(nil)
 expect(v12.somePropName).to.equal(t)
 Roact.unmount(v5)
	end)
end