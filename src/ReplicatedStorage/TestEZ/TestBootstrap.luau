local TestPlanner = require(script.Parent.TestPlanner)
local TestRunner = require(script.Parent.TestRunner)
local TextReporter = require(script.Parent.Reporters.TextReporter)
local bootstrapModule = {}
local function stripSpecSuffix(name)
	return name:gsub("%.spec$", "")
end
local function isSpecScript(instance)
	return instance:IsA("ModuleScript") and instance.Name:match("%.spec$")
end
local function getPath(script, rootContainer)
	local containerRoot = rootContainer or game
	local pathParts = {}
	local currentNode, stopNode
	if script.Name == "init.spec" then
		currentNode = script.Parent
		stopNode = containerRoot
	else
		currentNode = script
		stopNode = containerRoot
	end
	while currentNode ~= nil and currentNode ~= stopNode do
		table.insert(pathParts, (currentNode.Name:gsub("%.spec$", "")))
		currentNode = currentNode.Parent
	end
	table.insert(pathParts, (stopNode.Name:gsub("%.spec$", "")))
	return pathParts
end
local function toStringPath(pathParts)
	local isFirst = true
	local pathString = ""
	for i, part in ipairs(pathParts) do
		if isFirst then
			isFirst = false
			pathString = part
		else
			pathString = part .. " " .. pathString
		end
	end
	return pathString
end
function bootstrapModule.getModulesImpl(self, rootFolder, moduleList, scriptChild)
	local results = moduleList or {}
	local currentScript = scriptChild or rootFolder
	local isModuleScript = currentScript:IsA("ModuleScript")
	if isModuleScript and currentScript.Name:match("%.spec$") then
		local moduleFunc = require(currentScript)
		local pathParts = getPath(currentScript, rootFolder)
		local isFirstPart = true
		local sortPath = ""
		local outputList = results
		for i, part in ipairs(pathParts) do
			if isFirstPart then
				isFirstPart = false
				sortPath = part
			else
				sortPath = part .. " " .. sortPath
			end
		end
		table.insert(outputList, {
			method = moduleFunc,
			path = pathParts,
			pathStringForSorting = sortPath:lower()
		})
	end
end
function bootstrapModule.getModules(self, rootFolder)
	local modules = {}
	self:getModulesImpl(rootFolder, modules)
	for i, descendant in ipairs(rootFolder:GetDescendants()) do
		self:getModulesImpl(rootFolder, modules, descendant)
	end
	return modules
end
function bootstrapModule.run(self, testFolders, reporter, options)
	local runOptions = options or {}
	if type(testFolders) ~= "table" then
		error(("Bad argument #1 to TestBootstrap:run. Expected table, got %s"):format((typeof(testFolders))), 2)
	end
	local startLocateTime = tick()
	local allModules, reporterModule = {}, reporter or TextReporter
	for i, folder in ipairs(testFolders) do
		for i2, module in ipairs((self:getModules(folder))) do
			table.insert(allModules, module)
		end
	end
	local endLocateTime = tick()
	local testPlan = TestPlanner.createPlan(allModules, runOptions.testNamePattern, runOptions.extraEnvironment or {})
	local endPlanTime = tick()
	local testResults = TestRunner.runPlan(testPlan)
	local endRunTime = tick()
	reporterModule.report(testResults)
	local endReportTime = tick()
	if runOptions.showTimingInfo then
		print(table.concat({
			("Took %f seconds to locate test modules"):format(endLocateTime - startLocateTime),
			("Took %f seconds to create test plan"):format(endPlanTime - endLocateTime),
			("Took %f seconds to run tests"):format(endRunTime - endPlanTime),
			("Took %f seconds to report tests"):format(endReportTime - endRunTime)
		}, "\n"))
	end
	return testResults
end
return bootstrapModule
