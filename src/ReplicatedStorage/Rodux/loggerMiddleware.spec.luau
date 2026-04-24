-- Reviewed by Claude
return function()
	local Store = require(script.Parent.Store)
	local loggerMiddleware = require(script.Parent.loggerMiddleware)
	it("should print whenever an action is dispatched", function()
 local v1 = 0
 local v2 = nil
 local function reducer(p1, p2)
 return p1
 end
 local v3 = Store.new(reducer, {
 fooValue = 12345,
 barValue = {
 bazValue = "hiBaz"
 }
 }, { loggerMiddleware.middleware })
 function loggerMiddleware.outputFunction(p1)
 v1 = v1 + 1
 v2 = p1
 end
 v3:dispatch({
 type = "testActionType"
 })
 expect(v1).to.equal(1)
 expect(v2:find("testActionType")).to.be.ok()
 expect(v2:find("fooValue")).to.be.ok()
 expect(v2:find("12345")).to.be.ok()
 expect(v2:find("barValue")).to.be.ok()
 expect(v2:find("bazValue")).to.be.ok()
 expect(v2:find("hiBaz")).to.be.ok()
 loggerMiddleware.outputFunction = print
	end)
end