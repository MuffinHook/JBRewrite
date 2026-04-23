return function() --[[ Line: 1 ]]
	local Store = require(script.Parent.Store)
	describe("new", function() --[[ Line: 4 | Upvalues: Store (copy) ]]
		it("should instantiate with a reducer", function() --[[ Line: 5 | Upvalues: Store (ref) ]]
			local v1 = Store.new(function(p1, p2) --[[ Line: 6 ]]
				return "hello, world"
			end)
			expect(v1).to.be.ok()
			expect(v1:getState()).to.equal("hello, world")
			v1:destruct()
		end)
		it("should instantiate with a reducer and an initial state", function() --[[ Line: 16 | Upvalues: Store (ref) ]]
			local v1 = Store.new(function(p1, p2) --[[ Line: 17 ]]
				return p1
			end, "initial state")
			expect(v1).to.be.ok()
			expect(v1:getState()).to.equal("initial state")
			v1:destruct()
		end)
		it("should instantiate with a reducer, initial state, and middlewares", function() --[[ Line: 27 | Upvalues: Store (ref) ]]
			local v1 = Store.new(function(p1, p2) --[[ Line: 28 ]]
				return p1
			end, "initial state", {})
			expect(v1).to.be.ok()
			expect(v1:getState()).to.equal("initial state")
			v1:destruct()
		end)
		it("should modify the dispatch method when middlewares are passed", function() --[[ Line: 38 | Upvalues: Store (ref) ]]
			local v1 = 0
			local v2 = 0
			local v3 = nil
			local v4 = nil
			local v5 = nil
			local function reducer(p1, p2) --[[ Line: 45 ]]
				if p2.type == "test" then
					return "test state"
				else
					return p1
				end
			end
			local v6 = Store.new(reducer, "initial state", { function(p1, p2) --[[ Name: testMiddleware | Line: 53 | Upvalues: v1 (ref), v3 (ref), v4 (ref), v2 (ref), v5 (ref) ]]
					v1 = v1 + 1
					v3 = p1
					v4 = p2
					return function(p12) --[[ Line: 58 | Upvalues: v2 (ref), v5 (ref), p1 (copy) ]]
						v2 = v2 + 1
						v5 = p12
						p1(p12)
					end
				end })
			expect(v1).to.equal(1)
			expect(v2).to.equal(0)
			expect(v3).to.be.a("function")
			expect(v4).to.equal(v6)
			v6:dispatch({
				type = "test"
			})
			expect(v1).to.equal(1)
			expect(v2).to.equal(1)
			expect(v5.type).to.equal("test")
			v6:flush()
			expect(v6:getState()).to.equal("test state")
			v6:destruct()
		end)
		it("should execute middleware left-to-right", function() --[[ Line: 88 | Upvalues: Store (ref) ]]
			local t = {}
			local function reducer(p1) --[[ Line: 91 ]]
				return p1
			end
			local v1 = Store.new(reducer, 5, { function(p1, p2) --[[ Name: middlewareA | Line: 95 | Upvalues: t (copy) ]]
					table.insert(t, "instantiate a")
					return function(p12) --[[ Line: 97 | Upvalues: t (ref), p1 (copy) ]]
						table.insert(t, "execute a")
						return p1(p12)
					end
				end, function(p1, p2) --[[ Name: middlewareB | Line: 103 | Upvalues: t (copy) ]]
					table.insert(t, "instantiate b")
					return function(p12) --[[ Line: 105 | Upvalues: t (ref), p1 (copy) ]]
						table.insert(t, "execute b")
						return p1(p12)
					end
				end })
			expect(#t).to.equal(2)
			expect(t[1]).to.equal("instantiate b")
			expect(t[2]).to.equal("instantiate a")
			v1:dispatch({
				type = "test"
			})
			expect(#t).to.equal(4)
			expect(t[3]).to.equal("execute a")
			expect(t[4]).to.equal("execute b")
			v1:destruct()
		end)
		it("should send an initial action with a \'type\' field", function() --[[ Line: 128 | Upvalues: Store (ref) ]]
			local v1 = nil
			local v2 = 0
			local v3 = Store.new(function(p1, p2) --[[ Line: 132 | Upvalues: v1 (ref), v2 (ref) ]]
				v1 = p2
				v2 = v2 + 1
				return p1
			end)
			expect(v2).to.equal(1)
			expect(v1).to.be.a("table")
			expect(v1.type).to.be.ok()
			v3:destruct()
		end)
		it("should report a reducer error thrown when handling the INIT action", function() --[[ Line: 146 | Upvalues: Store (ref) ]]
			local v1 = nil
			local v2 = nil
			local v3 = nil
			local t = {
				reportReducerError = function(p1, p2, p3) --[[ Name: reportReducerError | Line: 149 | Upvalues: v1 (ref), v2 (ref), v3 (ref) ]]
					v1 = p1
					v2 = p2
					v3 = p3
				end,
				reportUpdateError = function() --[[ Name: reportUpdateError | Line: 154 ]] end
			}
			local v4 = Store.new(function(p1, p2) --[[ Line: 160 ]]
				error("Z4PH0D")
			end, {
				Value = 1
			}, nil, t)
			expect(v1.Value).to.equal(1)
			expect(v2.type).to.equal("@@INIT")
			expect(v3.message).to.equal("Caught error in reducer with init")
			expect(string.find(v3.thrownValue, "Z4PH0D")).to.be.ok()
			expect(string.find(v3.thrownValue, script.Name)).to.be.ok()
			v4:destruct()
		end)
		it("should report a reducer error thrown when handling a subsequent action", function() --[[ Line: 181 | Upvalues: Store (ref) ]]
			local v1 = nil
			local v2 = nil
			local v3 = nil
			local t = {
				reportReducerError = function(p1, p2, p3) --[[ Name: reportReducerError | Line: 184 | Upvalues: v1 (ref), v2 (ref), v3 (ref) ]]
					v1 = p1
					v2 = p2
					v3 = p3
				end,
				reportUpdateError = function() --[[ Name: reportUpdateError | Line: 189 ]] end
			}
			local v4 = Store.new(function(p1, p2) --[[ Line: 195 ]]
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
			}, nil, t)
			expect(v1).to.equal(nil)
			expect(v2).to.equal(nil)
			expect(v3).to.equal(nil)
			v4:dispatch({
				type = "Increment"
			})
			v4:dispatch({
				type = "ThrowError"
			})
			expect(v1.Value).to.equal(2)
			expect(v2.type).to.equal("ThrowError")
			expect(v3.message).to.equal("Caught error in reducer")
			expect(string.find(v3.thrownValue, "Z4PH0D")).to.be.ok()
			expect(string.find(v3.thrownValue, script.Name)).to.be.ok()
			v4:destruct()
		end)
	end)
	describe("getState", function() --[[ Line: 231 | Upvalues: Store (copy) ]]
		it("should get the current state", function() --[[ Line: 232 | Upvalues: Store (ref) ]]
			local v1 = Store.new(function(p1, p2) --[[ Line: 233 ]]
				return "foo"
			end)
			expect((v1:getState())).to.equal("foo")
			v1:destruct()
		end)
		it("should throw errors if triggered during dispatches", function() --[[ Line: 244 | Upvalues: Store (ref) ]]
			local v1 = nil
			v1 = Store.new(function(p1, p2) --[[ Line: 246 | Upvalues: v1 (ref) ]]
				if p2.type ~= "@@INIT" then
					v1:getState()
				end
			end)
			expect(function() --[[ Line: 252 | Upvalues: v1 (ref) ]]
				v1:dispatch({
					type = "SomeAction"
				})
			end).to.throw()
			v1:destruct()
		end)
	end)
	describe("dispatch", function() --[[ Line: 260 | Upvalues: Store (copy) ]]
		it("should be sent through the reducer", function() --[[ Line: 261 | Upvalues: Store (ref) ]]
			local v1 = Store.new(function(p1, p2) --[[ Line: 262 ]]
				local v1 = p1 or "foo"
				if p2.type == "act" then
					return "bar"
				else
					return v1
				end
			end)
			expect(v1).to.be.ok()
			expect(v1:getState()).to.equal("foo")
			v1:dispatch({
				type = "act"
			})
			v1:flush()
			expect(v1:getState()).to.equal("bar")
			v1:destruct()
		end)
		it("should trigger the changed event after a flush", function() --[[ Line: 286 | Upvalues: Store (ref) ]]
			local v1 = Store.new(function(p1, p2) --[[ Line: 287 ]]
				local v1 = p1 or 0
				if p2.type == "increment" then
					return v1 + 1
				else
					return v1
				end
			end)
			local v2 = 0
			v1.changed:connect(function(p1, p2) --[[ Line: 299 | Upvalues: v2 (ref) ]]
				expect(p2).to.equal(0)
				expect(p1).to.equal(1)
				v2 = v2 + 1
			end)
			v1:dispatch({
				type = "increment"
			})
			v1:flush()
			expect(v2).to.equal(1)
			v1:destruct()
		end)
		it("should handle actions dispatched within the changed event", function() --[[ Line: 317 | Upvalues: Store (ref) ]]
			local v1 = Store.new(function(p1, p2) --[[ Line: 318 ]]
				local v1 = p1 or {
					value = 0
				}
				if p2.type == "increment" then
					return {
						value = v1.value + 1
					}
				elseif p2.type == "decrement" then
					return {
						value = v1.value - 1
					}
				else
					return v1
				end
			end)
			local v2 = 0
			v1.changed:connect(function(p1, p2) --[[ Line: 338 | Upvalues: v1 (copy), v2 (ref) ]]
				expect(p1).never.to.equal(p2)
				if p1.value > 0 then
					v1:dispatch({
						type = "decrement"
					})
				end
				v2 = v2 + 1
			end)
			v1:dispatch({
				type = "increment"
			})
			v1:flush()
			v1:flush()
			expect(v2).to.equal(2)
			v1:destruct()
		end)
		it("should prevent yielding from changed handler", function() --[[ Line: 361 | Upvalues: Store (ref) ]]
			local v1 = nil
			local v2 = nil
			local t = {
				reportUpdateError = function(p1, p2, p3, p4) --[[ Name: reportUpdateError | Line: 364 | Upvalues: v1 (ref), v2 (ref) ]]
					v1 = p4.message
					v2 = p4.thrownValue
				end,
				reportReducerError = function() --[[ Name: reportReducerError | Line: 368 ]] end
			}
			local v3 = 0
			local v4 = 0
			local v5 = Store.new(function(p1, p2) --[[ Line: 375 ]]
				return (p1 or 0) + 1
			end, nil, nil, t)
			v5.changed:connect(function(p1, p2) --[[ Line: 380 | Upvalues: v3 (ref), v4 (ref) ]]
				v3 = v3 + 1
				wait()
				v4 = v4 + 1
			end)
			v5:dispatch({
				type = "increment"
			})
			v5:flush()
			expect(v3).to.equal(1)
			expect(v4).to.equal(0)
			expect(v1).to.equal("Caught error flushing store updates")
			expect(string.find(v2, script.Name)).to.be.ok()
			expect(string.find(v2, "to yield")).to.be.ok()
			v5:destruct()
		end)
		it("should throw if an action is dispatched without a type field", function() --[[ Line: 411 | Upvalues: Store (ref) ]]
			local v1 = Store.new(function(p1, p2) --[[ Line: 412 ]]
				return p1
			end)
			expect(function() --[[ Line: 416 | Upvalues: v1 (copy) ]]
				v1:dispatch({})
			end).to.throw()
			v1:destruct()
		end)
		it("should throw if the action is not a function or table", function() --[[ Line: 423 | Upvalues: Store (ref) ]]
			local v1 = Store.new(function(p1, p2) --[[ Line: 424 ]]
				return p1
			end)
			expect(function() --[[ Line: 428 | Upvalues: v1 (copy) ]]
				v1:dispatch(1)
			end).to.throw()
			v1:destruct()
		end)
		it("should report an error if the listeners error when flushing", function() --[[ Line: 435 | Upvalues: Store (ref) ]]
			local v1 = nil
			local v2 = nil
			local v3 = nil
			local v4 = nil
			local t = {
				reportReducerError = function() --[[ Name: reportReducerError | Line: 438 ]] end,
				reportUpdateError = function(p1, p2, p3, p4) --[[ Name: reportUpdateError | Line: 441 | Upvalues: v1 (ref), v2 (ref), v3 (ref), v4 (ref) ]]
					v1 = p1
					v2 = p2
					v3 = p3
					v4 = p4
				end
			}
			local v5 = Store.new(function(p1, p2) --[[ Line: 449 ]]
				if p2.type == "Increment" then
					return {
						Value = p1.Value + p2.amount
					}
				else
					return p1
				end
			end, {
				Value = 1
			}, nil, t)
			v5.changed:connect(function(p1, p2) --[[ Line: 462 ]]
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
				v5:dispatch(v)
			end
			v5:flush()
			expect(v4.message).to.equal("Caught error flushing store updates")
			expect(string.find(v4.thrownValue, script.Name)).to.be.ok()
			expect(v3[1]).to.equal(list[1])
			expect(v3[2]).to.equal(list[2])
			expect(v3[3]).to.equal(list[3])
			expect(v1.Value).to.equal(1)
			expect(v2.Value).to.equal(15)
			v5:destruct()
		end)
		it("should throw errors if dispatching while a dispatch is already happening", function() --[[ Line: 496 | Upvalues: Store (ref) ]]
			local v1 = nil
			v1 = Store.new(function(p1, p2) --[[ Line: 498 | Upvalues: v1 (ref) ]]
				if p2.type == "SomeAction" then
					v1:dispatch({
						type = "MidDispatchAction"
					})
				end
			end)
			expect(function() --[[ Line: 504 | Upvalues: v1 (ref) ]]
				v1:dispatch({
					type = "SomeAction"
				})
			end).to.throw()
			v1:destruct()
		end)
	end)
	describe("flush", function() --[[ Line: 512 | Upvalues: Store (copy) ]]
		it("should not fire a changed event if there were no dispatches", function() --[[ Line: 513 | Upvalues: Store (ref) ]]
			local v1 = Store.new(function() --[[ Line: 514 ]] end)
			local v2 = 0
			v1.changed:connect(function() --[[ Line: 517 | Upvalues: v2 (ref) ]]
				v2 = v2 + 1
			end)
			v1:flush()
			expect(v2).to.equal(0)
			v1:dispatch({
				type = "increment"
			})
			v1:flush()
			expect(v2).to.equal(1)
			v1:flush()
			expect(v2).to.equal(1)
			v1:destruct()
		end)
	end)
end