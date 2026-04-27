local TestService = game:GetService("TestService")
local TestEnum = require(script.Parent.Parent.TestEnum)
local reporterModule = {}
local function teamCityEscape(text)
	return string.gsub(string.gsub(string.gsub(text, "([]|\'[])", "|%1"), "\r", "|r"), "\n", "|n")
end
local function teamCityEnterSuite(name)
	return string.format("##teamcity[testSuiteStarted name=\'%s\']", (string.gsub(string.gsub(string.gsub(name, "([]|\'[])", "|%1"), "\r", "|r"), "\n", "|n")))
end
local function teamCityLeaveSuite(name)
	return string.format("##teamcity[testSuiteFinished name=\'%s\']", (string.gsub(string.gsub(string.gsub(name, "([]|\'[])", "|%1"), "\r", "|r"), "\n", "|n")))
end
local function teamCityEnterCase(name)
	return string.format("##teamcity[testStarted name=\'%s\']", (string.gsub(string.gsub(string.gsub(name, "([]|\'[])", "|%1"), "\r", "|r"), "\n", "|n")))
end
local function teamCityLeaveCase(name)
	return string.format("##teamcity[testFinished name=\'%s\']", (string.gsub(string.gsub(string.gsub(name, "([]|\'[])", "|%1"), "\r", "|r"), "\n", "|n")))
end
local function teamCityFailCase(name, message)
	return string.format("##teamcity[testFailed name=\'%s\' message=\'%s\']", string.gsub(string.gsub(string.gsub(name, "([]|\'[])", "|%1"), "\r", "|r"), "\n", "|n"), (string.gsub(string.gsub(string.gsub(message, "([]|\'[])", "|%1"), "\r", "|r"), "\n", "|n")))
end
local function processNode(resultNode, outputList, depth)
	local currentList = outputList or {}
	local currentDepth = depth or 0
	if resultNode.status == TestEnum.TestStatus.Skipped then
		return currentList
	elseif resultNode.planNode.type == TestEnum.NodeType.Describe then
		table.insert(currentList, teamCityEnterSuite(resultNode.planNode.phrase))
		local nodeOutputList = currentList
		for i, child in ipairs(resultNode.children) do
			processNode(child, nodeOutputList, currentDepth + 1)
		end
		table.insert(nodeOutputList, teamCityLeaveSuite(resultNode.planNode.phrase))
	else
		table.insert(currentList, teamCityEnterCase(resultNode.planNode.phrase))
		if resultNode.status == TestEnum.TestStatus.Failure then
			table.insert(currentList, teamCityFailCase(resultNode.planNode.phrase, table.concat(resultNode.errors, "\n")))
		end
		table.insert(currentList, teamCityLeaveCase(resultNode.planNode.phrase))
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
