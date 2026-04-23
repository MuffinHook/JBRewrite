return function() --[[ Line: 1 ]]
	local getDefaultInstanceProperty = require(script.Parent.getDefaultInstanceProperty)
	it("should get default name string values", function() --[[ Line: 4 | Upvalues: getDefaultInstanceProperty (copy) ]]
		local _, v1 = getDefaultInstanceProperty("StringValue", "Name")
		expect(v1).to.equal("Value")
	end)
	it("should get default empty string values", function() --[[ Line: 10 | Upvalues: getDefaultInstanceProperty (copy) ]]
		local _, v1 = getDefaultInstanceProperty("StringValue", "Value")
		expect(v1).to.equal("")
	end)
	it("should get default number values", function() --[[ Line: 16 | Upvalues: getDefaultInstanceProperty (copy) ]]
		local _, v1 = getDefaultInstanceProperty("IntValue", "Value")
		expect(v1).to.equal(0)
	end)
	it("should get nil default values", function() --[[ Line: 22 | Upvalues: getDefaultInstanceProperty (copy) ]]
		local _, v1 = getDefaultInstanceProperty("ObjectValue", "Value")
		expect(v1).to.equal(nil)
	end)
	it("should get bool default values", function() --[[ Line: 28 | Upvalues: getDefaultInstanceProperty (copy) ]]
		local _, v1 = getDefaultInstanceProperty("BoolValue", "Value")
		expect(v1).to.equal(false)
	end)
end