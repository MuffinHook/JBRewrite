-- Reviewed by Claude
return function()
	local Store = require(script.Parent.Store)
	local thunkMiddleware = require(script.Parent.thunkMiddleware)
	it("should dispatch thunks", function()
 local function reducer(p1, p2)
 return p1
 end
 local v2 = 0
 Store.new(reducer, {}, { thunkMiddleware }):dispatch(function(p1)
 v2 = v2 + 1
 end)
 expect(v2).to.equal(1)
	end)
	it("should allow normal actions to pass through", function()
 local v1 = 0
 local function reducer(p1, p2)
 v1 = v1 + 1
 return p1
 end
 Store.new(reducer, {}, { thunkMiddleware }):dispatch({
 type = "test"
 })
 expect(v1).to.equal(2)
	end)
	it("should return the value from the thunk", function()
 local function reducer(p1, p2)
 return p1
 end
 expect((Store.new(reducer, {}, { thunkMiddleware }):dispatch(function(p1)
 return "test"
 end))).to.equal("test")
	end)
	it("should report errors captured in thunks via the provided error reporter", function()
 local v1 = nil
 local v2 = nil
 local v3 = nil
 local t = {
 reportReducerError = function(p1, p2, p3)
 v1 = p1
 v2 = p2
 v3 = p3
 end
 }
 local function reducer(p1, p2)
 return p1
 end
 local v4 = Store.new(reducer, {
 Value = 1
 }, { thunkMiddleware }, t)
 local function thunk(p1)
 error("thunk failed")
 end
 v4:dispatch(thunk)
 expect(v1.Value).to.equal(1)
 expect(v2).to.equal(thunk)
 expect(v3.message).to.equal("Caught error in thunk")
	end)
	it("should recover and continue to update after a thunk errors", function()
 local v1 = nil
 local t = {
 reportReducerError = function(p1, p2, p3)
 v1 = p3
 end
 }
 local function reducer(p1, p2)
 return p1
 end
 local v2 = Store.new(reducer, {
 Value = 1
 }, { thunkMiddleware }, t)
 local function errorThunk(p1)
 error("thunk failed")
 end
 local v3 = false
 local function safeThunk(p1)
 v3 = true
 end
 v2:dispatch(errorThunk)
 expect(v1.message).to.equal("Caught error in thunk")
 v2:dispatch(safeThunk)
 expect(v3).to.equal(true)
	end)
end