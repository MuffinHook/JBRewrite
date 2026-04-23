return function() --[[ Line: 1 ]]
	local NoYield = require(script.Parent.NoYield)
	it("should call functions normally", function() --[[ Line: 4 | Upvalues: NoYield (copy) ]]
		local v1 = 0
		local v2, v3 = NoYield(function(p1, p2) --[[ Name: test | Line: 7 | Upvalues: v1 (ref) ]]
			expect(p1).to.equal(5)
			expect(p2).to.equal(6)
			v1 = v1 + 1
			return 11, "hello"
		end, 5, 6)
		expect(v2).to.equal(11)
		expect(v3).to.equal("hello")
	end)
	it("should throw on yield", function() --[[ Line: 22 | Upvalues: NoYield (copy) ]]
		local v1 = 0
		local v2 = 0
		local function testMethod() --[[ Line: 26 | Upvalues: v1 (ref), v2 (ref) ]]
			v1 = v1 + 1
			wait()
			v2 = v2 + 1
		end
		local v3, v4 = pcall(NoYield, testMethod)
		expect(v1).to.equal(1)
		expect(v2).to.equal(0)
		expect(v3).to.equal(false)
		expect(v4:find("Attempted to yield inside changed event!")).to.be.ok()
		expect(v4:find("NoYield.spec")).to.be.ok()
	end)
	it("should propagate error messages", function() --[[ Line: 42 | Upvalues: NoYield (copy) ]]
		local v1 = 0
		local function test() --[[ Line: 45 | Upvalues: v1 (ref) ]]
			v1 = v1 + 1
			error("foo")
		end
		local v2, v3 = pcall(NoYield, test)
		expect(v2).to.equal(false)
		expect(v3:find("foo")).to.be.ok()
		expect(v3:find("NoYield.spec")).to.be.ok()
	end)
end