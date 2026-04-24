-- Reviewed by Claude
local TestService = game:GetService("TestService")
local TestEnum = require(script.Parent.Parent.TestEnum)
local v1 = (" "):rep(3)
local t = {
	[TestEnum.TestStatus.Success] = "+",
	[TestEnum.TestStatus.Failure] = "-",
	[TestEnum.TestStatus.Skipped] = "~"
}
local t2 = {}
local function v2(p1, p2, p3)
	local v12 = p2 or {}
	local v22 = p3 or 0
	if p1.status == TestEnum.TestStatus.Skipped then
		return v12
	else
		table.insert(v12, if p1.status == TestEnum.TestStatus.Success then nil else ("%s[%s] %s"):format(v1:rep(v22), t[p1.status] or "?", p1.planNode.phrase))
		local v6 = v12
		for i, v in ipairs(p1.children) do
			v2(v, v6, v22 + 1)
		end
		return v6
	end
end
local function reportRoot(p1)
	local t = {}
	for i, v in ipairs(p1.children) do
		v2(v, t, 0)
	end
	return t
end
local function report(p1)
	return table.concat(reportRoot(p1), "\n")
end
function t2.report(p1)
	local t = {}
	local v1 = reportRoot(p1)
	t[1] = "Test results:"
	t[2] = table.concat(v1, "\n")
	t[3] = ("%d passed, %d failed, %d skipped"):format(p1.successCount, p1.failureCount, p1.skippedCount)
	print(table.concat(t, "\n"))
	if p1.failureCount > 0 then
		print(("%d test nodes reported failures."):format(p1.failureCount))
	end
	if #p1.errors > 0 then
		print("Errors reported by tests:")
		print("")
		for i, v in ipairs(p1.errors) do
			TestService:Error(v)
			print("")
		end
	end
end
return t2
