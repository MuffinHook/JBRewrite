return function()
	local NoYield = require(script.Parent.NoYield)
	it("should call functions normally", function()
 local callCount = 0
 local firstReturn, secondReturn = NoYield(function(arg1, arg2)
 expect(arg1).to.equal(5)
 expect(arg2).to.equal(6)
 callCount = callCount + 1
 return 11, "hello"
 end, 5, 6)
 expect(firstReturn).to.equal(11)
 expect(secondReturn).to.equal("hello")
	end)
	it("should throw on yield", function()
 local executionCountBeforeYield = 0
 local executionCountAfterYield = 0
 local function testMethod()
 executionCountBeforeYield = executionCountBeforeYield + 1
 wait()
 executionCountAfterYield = executionCountAfterYield + 1
 end
 local didSucceed, errorMessage = pcall(NoYield, testMethod)
 expect(executionCountBeforeYield).to.equal(1)
 expect(executionCountAfterYield).to.equal(0)
 expect(didSucceed).to.equal(false)
 expect(errorMessage:find("Attempted to yield inside changed event!")).to.be.ok()
 expect(errorMessage:find("NoYield.spec")).to.be.ok()
	end)
	it("should propagate error messages", function()
 local callCount = 0
 local function test()
 callCount = callCount + 1
 error("foo")
 end
 local didSucceed, errorMessage = pcall(NoYield, test)
 expect(didSucceed).to.equal(false)
 expect(errorMessage:find("foo")).to.be.ok()
 expect(errorMessage:find("NoYield.spec")).to.be.ok()
	end)
end
