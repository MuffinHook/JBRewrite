-- Reviewed by Claude
return function()
	local Store = require(script.Parent.Store)
	describe("new", function()
 it("should instantiate with a reducer", function()
 local fn = Store.new(function(p1, p2)
 return "hello, world"
 end)
 expect(fn).to.be.ok()
 expect(fn:getState()).to.equal("hello, world")
 fn:destruct()
 end)
 it("should instantiate with a reducer and an initial state", function()
 local fn = Store.new(function(p1, p2)
 return p1
 end, "initial state")
 expect(fn).to.be.ok()
 expect(fn:getState()).to.equal("initial state")
 fn:destruct()
 end)
 it("should instantiate with a reducer, initial state, and middlewares", function()
 local fn = Store.new(function(p1, p2)
 return p1
 end, "initial state", {})
 expect(fn).to.be.ok()
 expect(fn:getState()).to.equal("initial state")
 fn:destruct()
 end)
 it("should modify the dispatch method when middlewares are passed", function()
 local fn = 0
 local v2 = 0
 local fn3 = nil
 local fn4 = nil
 local fn5 = nil
 local function reducer(p1, p2)
 if p2.type == "test" then
 return "test state"
 else
 return p1
 end
 end
 local fn2 = Store.new(reducer, "initial state", { function(p1, p2)
 fn = fn + 1
 fn3 = p1
 fn4 = p2
 return function(p12)
 v2 = v2 + 1
 fn5 = p12
 p1(p12)
 end
 end })
 expect(fn).to.equal(1)
 expect(v2).to.equal(0)
 expect(fn3).to.be.a("function")
 expect(fn4).to.equal(fn2)
 fn2:dispatch({
 type = "test"
 })
 expect(fn).to.equal(1)
 expect(v2).to.equal(1)
 expect(fn5.type).to.equal("test")
 fn2:flush()
 expect(fn2:getState()).to.equal("test state")
 fn2:destruct()
 end)
 it("should execute middleware left-to-right", function()
 local tbl = {}
 local function reducer(p1)
 return p1
 end
 local fn = Store.new(reducer, 5, { function(p1, p2)
 table.insert(tbl, "instantiate a")
 return function(p12)
 table.insert(tbl, "execute a")
 return p1(p12)
 end
 end, function(p1, p2)
 table.insert(tbl, "instantiate b")
 return function(p12)
 table.insert(tbl, "execute b")
 return p1(p12)
 end
 end })
 expect(#tbl).to.equal(2)
 expect(tbl[1]).to.equal("instantiate b")
 expect(tbl[2]).to.equal("instantiate a")
 fn:dispatch({
 type = "test"
 })
 expect(#tbl).to.equal(4)
 expect(tbl[3]).to.equal("execute a")
 expect(tbl[4]).to.equal("execute b")
 fn:destruct()
 end)
 it("should send an initial action with a \'type\' field", function()
 local fn = nil
 local v2 = 0
 local fn3 = Store.new(function(p1, p2)
 fn = p2
 v2 = v2 + 1
 return p1
 end)
 expect(v2).to.equal(1)
 expect(fn).to.be.a("table")
 expect(fn.type).to.be.ok()
 fn3:destruct()
 end)
 it("should report a reducer error thrown when handling the INIT action", function()
 local fn = nil
 local v2 = nil
 local fn3 = nil
 local tbl = {
 reportReducerError = function(p1, p2, p3)
 fn = p1
 v2 = p2
 fn3 = p3
 end,
 reportUpdateError = function() end
 }
 local fn4 = Store.new(function(p1, p2)
 error("Z4PH0D")
 end, {
 Value = 1
 }, nil, tbl)
 expect(fn.Value).to.equal(1)
 expect(v2.type).to.equal("@@INIT")
 expect(fn3.message).to.equal("Caught error in reducer with init")
 expect(string.find(fn3.thrownValue, "Z4PH0D")).to.be.ok()
 expect(string.find(fn3.thrownValue, script.Name)).to.be.ok()
 fn4:destruct()
 end)
 it("should report a reducer error thrown when handling a subsequent action", function()
 local fn = nil
 local v2 = nil
 local fn3 = nil
 local tbl = {
 reportReducerError = function(p1, p2, p3)
 fn = p1
 v2 = p2
 fn3 = p3
 end,
 reportUpdateError = function() end
 }
 local fn4 = Store.new(function(p1, p2)
 if p2.type == "ThrowError" then
 error("Z4PH0D")
 elseif p2.type == "Increment" then
 return {
 Value = p1.Value + 1
 }
 else
 return p1
 end
 end, {
 Value = 1
 }, nil, tbl)
 expect(fn).to.equal(nil)
 expect(v2).to.equal(nil)
 expect(fn3).to.equal(nil)
 fn4:dispatch({
 type = "Increment"
 })
 fn4:dispatch({
 type = "ThrowError"
 })
 expect(fn.Value).to.equal(2)
 expect(v2.type).to.equal("ThrowError")
 expect(fn3.message).to.equal("Caught error in reducer")
 expect(string.find(fn3.thrownValue, "Z4PH0D")).to.be.ok()
 expect(string.find(fn3.thrownValue, script.Name)).to.be.ok()
 fn4:destruct()
 end)
	end)
	describe("getState", function()
 it("should get the current state", function()
 local fn = Store.new(function(p1, p2)
 return "foo"
 end)
 expect((fn:getState())).to.equal("foo")
 fn:destruct()
 end)
 it("should throw errors if triggered during dispatches", function()
 local fn = nil
 fn = Store.new(function(p1, p2)
 if p2.type ~= "@@INIT" then
 fn:getState()
 end
 end)
 expect(function()
 fn:dispatch({
 type = "SomeAction"
 })
 end).to.throw()
 fn:destruct()
 end)
	end)
	describe("dispatch", function()
 it("should be sent through the reducer", function()
 local fn = Store.new(function(p1, p2)
 local fn = p1 or "foo"
 if p2.type == "act" then
 return "bar"
 else
 return fn
 end
 end)
 expect(fn).to.be.ok()
 expect(fn:getState()).to.equal("foo")
 fn:dispatch({
 type = "act"
 })
 fn:flush()
 expect(fn:getState()).to.equal("bar")
 fn:destruct()
 end)
 it("should trigger the changed event after a flush", function()
 local fn = Store.new(function(p1, p2)
 local fn = p1 or 0
 if p2.type == "increment" then
 return fn + 1
 else
 return fn
 end
 end)
 local v2 = 0
 fn.changed:connect(function(p1, p2)
 expect(p2).to.equal(0)
 expect(p1).to.equal(1)
 v2 = v2 + 1
 end)
 fn:dispatch({
 type = "increment"
 })
 fn:flush()
 expect(v2).to.equal(1)
 fn:destruct()
 end)
 it("should handle actions dispatched within the changed event", function()
 local fn = Store.new(function(p1, p2)
 local fn = p1 or {
 value = 0
 }
 if p2.type == "increment" then
 return {
 value = fn.value + 1
 }
 elseif p2.type == "decrement" then
 return {
 value = fn.value - 1
 }
 else
 return fn
 end
 end)
 local v2 = 0
 fn.changed:connect(function(p1, p2)
 expect(p1).never.to.equal(p2)
 if p1.value > 0 then
 fn:dispatch({
 type = "decrement"
 })
 end
 v2 = v2 + 1
 end)
 fn:dispatch({
 type = "increment"
 })
 fn:flush()
 fn:flush()
 expect(v2).to.equal(2)
 fn:destruct()
 end)
 it("should prevent yielding from changed handler", function()
 local fn = nil
 local v2 = nil
 local tbl = {
 reportUpdateError = function(p1, p2, p3, p4)
 fn = p4.message
 v2 = p4.thrownValue
 end,
 reportReducerError = function() end
 }
 local fn3 = 0
 local fn4 = 0
 local fn5 = Store.new(function(p1, p2)
 return (p1 or 0) + 1
 end, nil, nil, tbl)
 fn5.changed:connect(function(p1, p2)
 fn3 = fn3 + 1
 wait()
 fn4 = fn4 + 1
 end)
 fn5:dispatch({
 type = "increment"
 })
 fn5:flush()
 expect(fn3).to.equal(1)
 expect(fn4).to.equal(0)
 expect(fn).to.equal("Caught error flushing store updates")
 expect(string.find(v2, script.Name)).to.be.ok()
 expect(string.find(v2, "to yield")).to.be.ok()
 fn5:destruct()
 end)
 it("should throw if an action is dispatched without a type field", function()
 local fn = Store.new(function(p1, p2)
 return p1
 end)
 expect(function()
 fn:dispatch({})
 end).to.throw()
 fn:destruct()
 end)
 it("should throw if the action is not a function or table", function()
 local fn = Store.new(function(p1, p2)
 return p1
 end)
 expect(function()
 fn:dispatch(1)
 end).to.throw()
 fn:destruct()
 end)
 it("should report an error if the listeners error when flushing", function()
 local fn = nil
 local v2 = nil
 local fn3 = nil
 local fn4 = nil
 local tbl = {
 reportReducerError = function() end,
 reportUpdateError = function(p1, p2, p3, p4)
 fn = p1
 v2 = p2
 fn3 = p3
 fn4 = p4
 end
 }
 local fn5 = Store.new(function(p1, p2)
 if p2.type == "Increment" then
 return {
 Value = p1.Value + p2.amount
 }
 else
 return p1
 end
 end, {
 Value = 1
 }, nil, tbl)
 fn5.changed:connect(function(p1, p2)
 if p1.Value == 15 then
 error("Z4PH0D")
 end
 end)
 local list = {
 {
 type = "Increment",
 amount = 1
 },
 {
 type = "Increment",
 amount = 3
 },
 {
 type = "Increment",
 amount = 10
 }
 }
 for i, v in ipairs(list) do
 fn5:dispatch(v)
 end
 fn5:flush()
 expect(fn4.message).to.equal("Caught error flushing store updates")
 expect(string.find(fn4.thrownValue, script.Name)).to.be.ok()
 expect(fn3[1]).to.equal(list[1])
 expect(fn3[2]).to.equal(list[2])
 expect(fn3[3]).to.equal(list[3])
 expect(fn.Value).to.equal(1)
 expect(v2.Value).to.equal(15)
 fn5:destruct()
 end)
 it("should throw errors if dispatching while a dispatch is already happening", function()
 local fn = nil
 fn = Store.new(function(p1, p2)
 if p2.type == "SomeAction" then
 fn:dispatch({
 type = "MidDispatchAction"
 })
 end
 end)
 expect(function()
 fn:dispatch({
 type = "SomeAction"
 })
 end).to.throw()
 fn:destruct()
 end)
	end)
	describe("flush", function()
 it("should not fire a changed event if there were no dispatches", function()
 local fn = Store.new(function() end)
 local v2 = 0
 fn.changed:connect(function()
 v2 = v2 + 1
 end)
 fn:flush()
 expect(v2).to.equal(0)
 fn:dispatch({
 type = "increment"
 })
 fn:flush()
 expect(v2).to.equal(1)
 fn:flush()
 expect(v2).to.equal(1)
 fn:destruct()
 end)
	end)
end