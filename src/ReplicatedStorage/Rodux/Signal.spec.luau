return function()
	local Signal = require(script.Parent.Signal)
	it("should construct from nothing", function()
 expect((Signal.new())).to.be.ok()
	end)
	it("should fire connected callbacks", function()
 local callCount = 0
 local function testCallback(message, count)
 expect(message).to.equal("Hello World")
 expect(count).to.equal(7)
 callCount = callCount + 1
 end
 local signal = Signal.new()
 local connection = signal:connect(testCallback)
 signal:fire("Hello World", 7)
 expect(callCount).to.equal(1)
 connection:disconnect()
 signal:fire("Hello World", 7)
 expect(callCount).to.equal(1)
	end)
	it("should disconnect handlers", function()
 local signal = Signal.new()
 signal:connect(function()
 error("Callback was called after disconnect!")
 end):disconnect()
 signal:fire()
	end)
	it("should fire handlers in order", function()
 local signal = Signal.new()
 local firstCallbackCount = 0
 local secondCallbackCount = 0
 local function secondHandler()
 expect(firstCallbackCount).to.equal(1)
 expect(secondCallbackCount).to.equal(0)
 secondCallbackCount = secondCallbackCount + 1
 end
 signal:connect(function()
 expect(firstCallbackCount).to.equal(0)
 expect(secondCallbackCount).to.equal(0)
 firstCallbackCount = firstCallbackCount + 1
 end)
 signal:connect(secondHandler)
 signal:fire()
 expect(firstCallbackCount).to.equal(1)
 expect(secondCallbackCount).to.equal(1)
	end)
	it("should continue firing despite mid-event disconnection", function()
 local signal = Signal.new()
 local firstCallbackCount = 0
 local secondCallbackCount = 0
 local firstConnection = nil
 firstConnection = signal:connect(function()
 firstConnection:disconnect()
 firstCallbackCount = firstCallbackCount + 1
 end)
 signal:connect(function()
 secondCallbackCount = secondCallbackCount + 1
 end)
 signal:fire()
 expect(firstCallbackCount).to.equal(1)
 expect(secondCallbackCount).to.equal(1)
	end)
	it("should skip listeners that were disconnected during event evaluation", function()
 local signal = Signal.new()
 local firstCallbackCount = 0
 local secondCallbackCount = 0
 local secondConnection = nil
 signal:connect(function()
 firstCallbackCount = firstCallbackCount + 1
 secondConnection:disconnect()
 end)
 secondConnection = signal:connect(function()
 secondCallbackCount = secondCallbackCount + 1
 end)
 signal:fire()
 expect(firstCallbackCount).to.equal(1)
 expect(secondCallbackCount).to.equal(0)
	end)
	it("should throw an error if the argument to `connect` is not a function", function()
 local signal = Signal.new()
 expect(function()
 signal:connect("not a function")
 end).to.throw()
	end)
	it("should throw an error when disconnecting more than once", function()
 local signal = Signal.new():connect(function() end)
 expect(signal.disconnect).never.to.throw()
 expect(signal.disconnect).to.throw()
	end)
	it("should throw an error when subscribing during dispatch", function()
 local dispatchContext = {
 _isDispatching = false
 }
 local signal = Signal.new(dispatchContext)
 signal:connect(function()
 signal:connect(function() end)
 end)
 dispatchContext._isDispatching = true
 expect(function()
 signal:fire()
 end).to.throw()
	end)
	it("should throw an error when unsubscribing during dispatch", function()
 local dispatchContext = {
 _isDispatching = false
 }
 local signal = Signal.new(dispatchContext)
 local handlerConnection = nil
 handlerConnection = signal:connect(function()
 handlerConnection.disconnect()
 end)
 dispatchContext._isDispatching = true
 expect(function()
 signal:fire()
 end).to.throw()
	end)
end
