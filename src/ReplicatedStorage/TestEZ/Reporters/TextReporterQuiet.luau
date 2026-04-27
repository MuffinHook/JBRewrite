local TestService = game:GetService("TestService")
local TestEnum = require(script.Parent.Parent.TestEnum)
local indentation = (" "):rep(3)
local statusSymbols = {
	[TestEnum.TestStatus.Success] = "+",
	[TestEnum.TestStatus.Failure] = "-",
	[TestEnum.TestStatus.Skipped] = "~"
}
local reporterModule = {}
local function processNode(resultNode, outputList, depth)
	local currentList = outputList or {}
	local currentDepth = depth or 0
	if resultNode.status == TestEnum.TestStatus.Skipped then
		return currentList
	else
		table.insert(currentList, if resultNode.status == TestEnum.TestStatus.Success then nil else ("%s[%s] %s"):format(indentation:rep(currentDepth), statusSymbols[resultNode.status] or "?", resultNode.planNode.phrase))
		local nodeOutputList = currentList
		for i, child in ipairs(resultNode.children) do
			processNode(child, nodeOutputList, currentDepth + 1)
		end
		return nodeOutputList
	end
end
local function reportRoot(results)
	local outputList = {}
	for i, child in ipairs(results.children) do
		processNode(child, outputList, 0)
	end
	return outputList
end
local function report(results)
	return table.concat(reportRoot(results), "\n")
end
function reporterModule.report(results)
	local outputLines = {}
	local nodeOutputList = reportRoot(results)
	outputLines[1] = "Test results:"
	outputLines[2] = table.concat(nodeOutputList, "\n")
	outputLines[3] = ("%d passed, %d failed, %d skipped"):format(results.successCount, results.failureCount, results.skippedCount)
	print(table.concat(outputLines, "\n"))
	if results.failureCount > 0 then
		print(("%d test nodes reported failures."):format(results.failureCount))
	end
	if #results.errors > 0 then
		print("Errors reported by tests:")
		print("")
		for i, errorMsg in ipairs(results.errors) do
			TestService:Error(errorMsg)
			print("")
		end
	end
end
return reporterModule
