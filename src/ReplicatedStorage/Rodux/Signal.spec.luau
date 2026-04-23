return function() --[[ Line: 1 ]]
	local Signal = require(script.Parent.Signal)
	it("should construct from nothing", function() --[[ Line: 4 | Upvalues: Signal (copy) ]]
		expect((Signal.new())).to.be.ok()
	end)
	it("should fire connected callbacks", function() --[[ Line: 10 | Upvalues: Signal (copy) ]]
		local v1 = 0
		local function f2(p1, p2) --[[ Line: 15 | Upvalues: v1 (ref) ]]
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
	it("should disconnect handlers", function() --[[ Line: 34 | Upvalues: Signal (copy) ]]
		local v1 = Signal.new()
		v1:connect(function() --[[ Line: 35 ]]
			error("Callback was called after disconnect!")
		end):disconnect()
		v1:fire()
	end)
	it("should fire handlers in order", function() --[[ Line: 47 | Upvalues: Signal (copy) ]]
		local v1 = Signal.new()
		local v2 = 0
		local v3 = 0
		local function f4() --[[ Line: 58 | Upvalues: v2 (ref), v3 (ref) ]]
			expect(v2).to.equal(1)
			expect(v3).to.equal(0)
			v3 = v3 + 1
		end
		v1:connect(function() --[[ Line: 52 | Upvalues: v2 (ref), v3 (ref) ]]
			expect(v2).to.equal(0)
			expect(v3).to.equal(0)
			v2 = v2 + 1
		end)
		v1:connect(f4)
		v1:fire()
		expect(v2).to.equal(1)
		expect(v3).to.equal(1)
	end)
	it("should continue firing despite mid-event disconnection", function() --[[ Line: 72 | Upvalues: Signal (copy) ]]
		local v1 = Signal.new()
		local v2 = 0
		local v3 = 0
		local v4 = nil
		v4 = v1:connect(function() --[[ Line: 78 | Upvalues: v4 (ref), v2 (ref) ]]
			v4:disconnect()
			v2 = v2 + 1
		end)
		v1:connect(function() --[[ Line: 83 | Upvalues: v3 (ref) ]]
			v3 = v3 + 1
		end)
		v1:fire()
		expect(v2).to.equal(1)
		expect(v3).to.equal(1)
	end)
	it("should skip listeners that were disconnected during event evaluation", function() --[[ Line: 93 | Upvalues: Signal (copy) ]]
		local v1 = Signal.new()
		local v2 = 0
		local v3 = 0
		local v4 = nil
		v1:connect(function() --[[ Line: 100 | Upvalues: v2 (ref), v4 (ref) ]]
			v2 = v2 + 1
			v4:disconnect()
		end)
		v4 = v1:connect(function() --[[ Line: 105 | Upvalues: v3 (ref) ]]
			v3 = v3 + 1
		end)
		v1:fire()
		expect(v2).to.equal(1)
		expect(v3).to.equal(0)
	end)
	it("should throw an error if the argument to `connect` is not a function", function() --[[ Line: 115 | Upvalues: Signal (copy) ]]
		local v1 = Signal.new()
		expect(function() --[[ Line: 117 | Upvalues: v1 (copy) ]]
			v1:connect("not a function")
		end).to.throw()
	end)
	it("should throw an error when disconnecting more than once", function() --[[ Line: 122 | Upvalues: Signal (copy) ]]
		local v1 = Signal.new():connect(function() --[[ Line: 125 ]] end)
		expect(v1.disconnect).never.to.throw()
		expect(v1.disconnect).to.throw()
	end)
	it("should throw an error when subscribing during dispatch", function() --[[ Line: 133 | Upvalues: Signal (copy) ]]
		local t = {
			_isDispatching = false
		}
		local v1 = Signal.new(t)
		v1:connect(function() --[[ Line: 139 | Upvalues: v1 (copy) ]]
			v1:connect(function() --[[ Line: 141 ]] end)
		end)
		t._isDispatching = true
		expect(function() --[[ Line: 145 | Upvalues: v1 (copy) ]]
			v1:fire()
		end).to.throw()
	end)
	it("should throw an error when unsubscribing during dispatch", function() --[[ Line: 150 | Upvalues: Signal (copy) ]]
		local t = {
			_isDispatching = false
		}
		local v1 = Signal.new(t)
		local v2 = nil
		v2 = v1:connect(function() --[[ Line: 157 | Upvalues: v2 (ref) ]]
			v2.disconnect()
		end)
		t._isDispatching = true
		expect(function() --[[ Line: 162 | Upvalues: v1 (copy) ]]
			v1:fire()
		end).to.throw()
	end)
end