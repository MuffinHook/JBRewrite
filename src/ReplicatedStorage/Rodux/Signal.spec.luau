-- Reviewed by Claude
return function()
	local Signal = require(script.Parent.Signal)
	it("should construct from nothing", function()
 expect((Signal.new())).to.be.ok()
	end)
	it("should fire connected callbacks", function()
 local v1 = 0
 local function f2(p1, p2)
 expect(p1).to.equal("Hello World")
 expect(p2).to.equal(7)
 v1 = v1 + 1
 end
 local v3 = Signal.new()
 local v4 = v3:connect(f2)
 v3:fire("Hello World", 7)
 expect(v1).to.equal(1)
 v4:disconnect()
 v3:fire("Hello World", 7)
 expect(v1).to.equal(1)
	end)
	it("should disconnect handlers", function()
 local v1 = Signal.new()
 v1:connect(function()
 error("Callback was called after disconnect!")
 end):disconnect()
 v1:fire()
	end)
	it("should fire handlers in order", function()
 local v1 = Signal.new()
 local v2 = 0
 local v3 = 0
 local function f4()
 expect(v2).to.equal(1)
 expect(v3).to.equal(0)
 v3 = v3 + 1
 end
 v1:connect(function()
 expect(v2).to.equal(0)
 expect(v3).to.equal(0)
 v2 = v2 + 1
 end)
 v1:connect(f4)
 v1:fire()
 expect(v2).to.equal(1)
 expect(v3).to.equal(1)
	end)
	it("should continue firing despite mid-event disconnection", function()
 local v1 = Signal.new()
 local v2 = 0
 local v3 = 0
 local v4 = nil
 v4 = v1:connect(function()
 v4:disconnect()
 v2 = v2 + 1
 end)
 v1:connect(function()
 v3 = v3 + 1
 end)
 v1:fire()
 expect(v2).to.equal(1)
 expect(v3).to.equal(1)
	end)
	it("should skip listeners that were disconnected during event evaluation", function()
 local v1 = Signal.new()
 local v2 = 0
 local v3 = 0
 local v4 = nil
 v1:connect(function()
 v2 = v2 + 1
 v4:disconnect()
 end)
 v4 = v1:connect(function()
 v3 = v3 + 1
 end)
 v1:fire()
 expect(v2).to.equal(1)
 expect(v3).to.equal(0)
	end)
	it("should throw an error if the argument to `connect` is not a function", function()
 local v1 = Signal.new()
 expect(function()
 v1:connect("not a function")
 end).to.throw()
	end)
	it("should throw an error when disconnecting more than once", function()
 local v1 = Signal.new():connect(function() end)
 expect(v1.disconnect).never.to.throw()
 expect(v1.disconnect).to.throw()
	end)
	it("should throw an error when subscribing during dispatch", function()
 local t = {
 _isDispatching = false
 }
 local v1 = Signal.new(t)
 v1:connect(function()
 v1:connect(function() end)
 end)
 t._isDispatching = true
 expect(function()
 v1:fire()
 end).to.throw()
	end)
	it("should throw an error when unsubscribing during dispatch", function()
 local t = {
 _isDispatching = false
 }
 local v1 = Signal.new(t)
 local v2 = nil
 v2 = v1:connect(function()
 v2.disconnect()
 end)
 t._isDispatching = true
 expect(function()
 v1:fire()
 end).to.throw()
	end)
end