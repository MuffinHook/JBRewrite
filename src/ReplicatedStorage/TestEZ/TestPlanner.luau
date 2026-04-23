local TestPlan = require(script.Parent.TestPlan)
return {
	createPlan = function(p1, p2, p3) --[[ Name: createPlan | Line: 26 | Upvalues: TestPlan (copy) ]]
		local v1 = TestPlan.new(p2, p3)
		table.sort(p1, function(p1, p2) --[[ Line: 29 ]]
			return p1.pathStringForSorting < p2.pathStringForSorting
		end)
		for i, v in ipairs(p1) do
			v1:addRoot(v.path, v.method)
		end
		return v1
	end
}