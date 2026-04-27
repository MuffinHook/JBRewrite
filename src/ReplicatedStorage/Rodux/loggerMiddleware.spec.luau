return function()
	local Store = require(script.Parent.Store)
	local loggerMiddleware = require(script.Parent.loggerMiddleware)
	it("should print whenever an action is dispatched", function()
 local callCount = 0
 local outputLog = nil
 local function reducer(state, action)
 return state
 end
 local testStore = Store.new(reducer, {
 fooValue = 12345,
 barValue = {
 bazValue = "hiBaz"
 }
 }, { loggerMiddleware.middleware })
 function loggerMiddleware.outputFunction(logOutput)
 callCount = callCount + 1
 outputLog = logOutput
 end
 testStore:dispatch({
 type = "testActionType"
 })
 expect(callCount).to.equal(1)
 expect(outputLog:find("testActionType")).to.be.ok()
 expect(outputLog:find("fooValue")).to.be.ok()
 expect(outputLog:find("12345")).to.be.ok()
 expect(outputLog:find("barValue")).to.be.ok()
 expect(outputLog:find("bazValue")).to.be.ok()
 expect(outputLog:find("hiBaz")).to.be.ok()
 loggerMiddleware.outputFunction = print
	end)
end
