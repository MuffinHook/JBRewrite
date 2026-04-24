-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunConsts = require(ReplicatedStorage.App.RunConsts)
if require(ReplicatedStorage.App.RunUtils).getWorld() ~= RunConsts.MAIN_WORLD_NAME then
	return
end
local function getRunnerModule()
	local Live2024 = ReplicatedStorage:FindFirstChild("Live2024")
	if Live2024 then
		local Runner = Live2024:FindFirstChild("Runner")
		if Runner and Runner:IsA("ModuleScript") then
			return Runner
		else
			return nil
		end
	else
		return nil
	end
end
repeat
	local v1 = nil
	local v2, v3 = pcall(function()
		local Live2024 = ReplicatedStorage:FindFirstChild("Live2024")
		local module12
		if Live2024 then
			local Runner = Live2024:FindFirstChild("Runner")
			module12 = if Runner and Runner:IsA("ModuleScript") then Runner else nil
		else
			module12 = nil
		end
		v1 = module12
	end)
	if not v2 then
		warn(v3)
	end
	if v1 then
		task.wait(1)
		local v4, v5 = pcall(function()
			local module12 = require(v1)
			print("gonna start!")
			module12.start()
		end)
		if not v4 then
			warn(v5)
		end
	else
		task.wait(1)
	end
until not v2
