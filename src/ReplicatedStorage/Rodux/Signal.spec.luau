-- Reviewed by Claude
return function()
	local Signal = require(script.Parent.Signal)
	it("should construct from nothing", function()
 expect((Signal.new())).to.be.ok()
	end)
	it("should fire connected callbacks", function()
 local fn = 0
 local function f2(p1, p2)
 expect(p1).to.equal("Hello World")
 expect(p2).to.equal(7)
 fn = fn + 1
 end
 local v3 = Signal.new()
 local v4 = v3:connect(f2)
 v3:fire("Hello World", 7)
 expect(fn).to.equal(1)
 v4:disconnect()
 v3:fire("Hello World", 7)
 expect(fn).to.equal(1)
	end)
	it("should disconnect handlers", function()
 local fn = Signal.new()
 fn:connect(function()
 error("Callback was called after disconnect!")
 end):disconnect()
 fn:fire()
	end)
	it("should fire handlers in order", function()
 local fn = Signal.new()
 local v2 = 0
 local v3 = 0
 local function f4()
 expect(v2).to.equal(1)
 expect(v3).to.equal(0)
 v3 = v3 + 1
 end
 fn:connect(function()
 expect(v2).to.equal(0)
 expect(v3).to.equal(0)
 v2 = v2 + 1
 end)
 fn:connect(f4)
 fn:fire()
 expect(v2).to.equal(1)
 expect(v3).to.equal(1)
	end)
	it("should continue firing despite mid-event disconnection", function()
 local fn = Signal.new()
 local v2 = 0
 local v3 = 0
 local v4 = nil
 v4 = fn:connect(function()
 v4:disconnect()
 v2 = v2 + 1
 end)
 fn:connect(function()
 v3 = v3 + 1
 end)
 fn:fire()
 expect(v2).to.equal(1)
 expect(v3).to.equal(1)
	end)
	it("should skip listeners that were disconnected during event evaluation", function()
 local fn = Signal.new()
 local v2 = 0
 local v3 = 0
 local v4 = nil
 fn:connect(function()
 v2 = v2 + 1
 v4:disconnect()
 end)
 v4 = fn:connect(function()
 v3 = v3 + 1
 end)
 fn:fire()
 expect(v2).to.equal(1)
 expect(v3).to.equal(0)
	end)
	it("should throw an error if the argument to `connect` is not a function", function()
 local fn = Signal.new()
 expect(function()
 fn:connect("not a function")
 end).to.throw()
	end)
	it("should throw an error when disconnecting more than once", function()
 local fn = Signal.new():connect(function() end)
 expect(fn.disconnect).never.to.throw()
 expect(fn.disconnect).to.throw()
	end)
	it("should throw an error when subscribing during dispatch", function()
 local t = {
 _isDispatching = false
 }
 local fn = Signal.new(t)
 fn:connect(function()
 fn:connect(function() end)
 end)
 t._isDispatching = true
 expect(function()
 fn:fire()
 end).to.throw()
	end)
	it("should throw an error when unsubscribing during dispatch", function()
 local t = {
 _isDispatching = false
 }
 local fn = Signal.new(t)
 local v2 = nil
 v2 = fn:connect(function()
 v2.disconnect()
 end)
 t._isDispatching = true
 expect(function()
 fn:fire()
 end).to.throw()
	end)
end