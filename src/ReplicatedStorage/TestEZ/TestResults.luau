local TestEnum = require(script.Parent.TestEnum)
local t = {
	[TestEnum.TestStatus.Success] = "+",
	[TestEnum.TestStatus.Failure] = "-",
	[TestEnum.TestStatus.Skipped] = "~"
}
local t2 = {}
t2.__index = t2
function t2.new(p1) --[[ Line: 25 | Upvalues: t2 (copy) ]]
	local t = {
		successCount = 0,
		failureCount = 0,
		skippedCount = 0,
		planNode = p1,
		children = {},
		errors = {}
	}
	setmetatable(t, t2)
	return t
end
function t2.createNode(p1) --[[ Line: 43 ]]
	return {
		planNode = p1,
		children = {},
		errors = {},
		status = nil
	}
end
function t2.visitAllNodes(p1, p2, p3) --[[ Line: 57 ]]
	for i, v in ipairs((p3 or p1).children) do
		p2(v)
		p1:visitAllNodes(p2, v)
	end
end
function t2.visualize(p1, p2, p3) --[[ Line: 70 | Upvalues: TestEnum (copy), t (copy) ]]
	local v1 = p3 or 0
	local t2 = {}
	for i, v in ipairs((p2 or p1).children) do
		if v.planNode.type == TestEnum.NodeType.It then
			local v3 = ("%s[%s] %s"):format((" "):rep(3 * v1), t[v.status] or "?", v.planNode.phrase)
			if v.messages and #v.messages > 0 then
				v3 = v3 .. "\n " .. (" "):rep(3 * v1) .. table.concat(v.messages, "\n " .. (" "):rep(3 * v1))
			end
			table.insert(t2, v3)
		else
			local v4 = ("%s%s"):format((" "):rep(3 * v1), v.planNode.phrase or "")
			if v.status then
				v4 = v4 .. (" (%s)"):format(v.status)
			end
			table.insert(t2, v4)
			if #v.children > 0 then
				table.insert(t2, (p1:visualize(v, v1 + 1)))
			end
		end
	end
	return table.concat(t2, "\n")
end
return t2