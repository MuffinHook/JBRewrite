return function() --[[ Line: 1 ]]
	local GlobalConfig = require(script.Parent.GlobalConfig)
	it("should have the correct methods", function() --[[ Line: 4 | Upvalues: GlobalConfig (copy) ]]
		expect(GlobalConfig).to.be.ok()
		expect(GlobalConfig.set).to.be.ok()
		expect(GlobalConfig.get).to.be.ok()
	end)
end