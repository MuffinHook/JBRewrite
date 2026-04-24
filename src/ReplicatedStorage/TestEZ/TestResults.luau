-- Reviewed by Claude
-- variables reassigned
local TestEnum = require(script.Parent.TestEnum)
local statusSymbols = {
	[TestEnum.TestStatus.Success] = "+",
	[TestEnum.TestStatus.Failure] = "-",
	[TestEnum.TestStatus.Skipped] = "~"
}
local testResultsClass = {}
testResultsClass.__index = testResultsClass
function testResultsClass.new(planNode)
	local results = {
		successCount = 0,
		failureCount = 0,
		skippedCount = 0,
		planNode = planNode,
		children = {},
		errors = {}
	}
	setmetatable(results, testResultsClass)
	return results
end
function testResultsClass.createNode(planNode)
	return {
		planNode = planNode,
		children = {},
		errors = {},
		status = nil
	}
end
function testResultsClass.visitAllNodes(self, callback, startNode)
	for i, child in ipairs((startNode or self).children) do
		callback(child)
		self:visitAllNodes(callback, child)
	end
end
function testResultsClass.visualize(self, startNode, depth)
	local currentDepth = depth or 0
	local outputLines = {}
	for i, node in ipairs((startNode or self).children) do
		if node.planNode.type == TestEnum.NodeType.It then
			local nodeLine = ("%s[%s] %s"):format((" "):rep(3 * currentDepth), statusSymbols[node.status] or "?", node.planNode.phrase)
			if node.messages and #node.messages > 0 then
				nodeLine = nodeLine .. "\n " .. (" "):rep(3 * currentDepth) .. table.concat(node.messages, "\n " .. (" "):rep(3 * currentDepth))
			end
			table.insert(outputLines, nodeLine)
		else
			local describeNodeLine = ("%s%s"):format((" "):rep(3 * currentDepth), node.planNode.phrase or "")
			if node.status then
				describeNodeLine = describeNodeLine .. (" (%s)"):format(node.status)
			end
			table.insert(outputLines, describeNodeLine)
			if #node.children > 0 then
				table.insert(outputLines, (self:visualize(node, currentDepth + 1)))
			end
		end
	end
	return table.concat(outputLines, "\n")
end
return testResultsClass
