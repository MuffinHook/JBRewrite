-- Reviewed by Claude
-- variables reassigned
local TestPlan = require(script.Parent.TestPlan)
return {
	createPlan = function(modules, testNamePattern, extraEnvironment)
		local testPlan = TestPlan.new(testNamePattern, extraEnvironment)
		table.sort(modules, function(moduleA, moduleB)
			return moduleA.pathStringForSorting < moduleB.pathStringForSorting
		end)
		for i, module in ipairs(modules) do
			testPlan:addRoot(module.path, module.method)
		end
		return testPlan
	end
}
