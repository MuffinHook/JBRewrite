-- Reviewed by Claude
local TestPlanner = require(script.Parent.TestPlanner)
local TestRunner = require(script.Parent.TestRunner)
local TextReporter = require(script.Parent.Reporters.TextReporter)
local t = {}
local function stripSpecSuffix(p1)
	return p1:gsub("%.spec$", "")
end
local function isSpecScript(p1)
	return p1:IsA("ModuleScript") and p1.Name:match("%.spec$")
end
local function getPath(p1, p2)
	local v1 = p2 or game
	local t = {}
	local v2, v3
	if p1.Name == "init.spec" then
		v2 = p1.Parent
		v3 = v1
	else
		v2 = p1
		v3 = v1
	end
	while v2 ~= nil and v2 ~= v3 do
		table.insert(t, (v2.Name:gsub("%.spec$", "")))
		v2 = v2.Parent
	end
	table.insert(t, (v3.Name:gsub("%.spec$", "")))
	return t
end
local function toStringPath(p1)
	local v1 = true
	local v2 = ""
	for i, v in ipairs(p1) do
		if v1 then
			v1 = false
			v2 = v
		else
			v2 = v .. " " .. v2
		end
	end
	return v2
end
function t.getModulesImpl(p1, p2, p3, p4)
	local v1 = p3 or {}
	local v2 = p4 or p2
	local v3 = v2:IsA("ModuleScript")
	if v3 and v2.Name:match("%.spec$") then
		local v6 = require(v2)
		local v7 = getPath(v2, p2)
		v8 = true
		v9 = ""
		v10 = v1
		for i, v in ipairs(v7) do
			if v8 then
				v8 = false
				v9 = v
			else
				v9 = v .. " " .. v9
			end
		end
		table.insert(v10, {
			method = v6,
			path = v7,
			pathStringForSorting = v9:lower()
		})
	end
end
function t.getModules(p1, p2)
	local t = {}
	p1:getModulesImpl(p2, t)
	for i, v in ipairs(p2:GetDescendants()) do
		p1:getModulesImpl(p2, t, v)
	end
	return t
end
function t.run(p1, p2, p3, p4)
	local v2 = p4 or {}
	if type(p2) ~= "table" then
		error(("Bad argument #1 to TestBootstrap:run. Expected table, got %s"):format((typeof(p2))), 2)
	end
	local v5 = tick()
	local t, v6 = {}, p3 or TextReporter
	for i, v in ipairs(p2) do
		for i2, v8 in ipairs((p1:getModules(v))) do
			table.insert(t, v8)
		end
	end
	local v8 = tick()
	local v9 = TestPlanner.createPlan(t, v2.testNamePattern, v2.extraEnvironment or {})
	local v10 = tick()
	local v11 = TestRunner.runPlan(v9)
	local v12 = tick()
	v6.report(v11)
	local v13 = tick()
	if v2.showTimingInfo then
		print(table.concat({
			("Took %f seconds to locate test modules"):format(v8 - v5),
			("Took %f seconds to create test plan"):format(v10 - v8),
			("Took %f seconds to run tests"):format(v12 - v10),
			("Took %f seconds to report tests"):format(v13 - v12)
		}, "\n"))
	end
	return v11
end
return t
