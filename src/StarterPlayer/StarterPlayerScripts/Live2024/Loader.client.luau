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
	local runnerModule = nil
	local loadSuccess, loadError = pcall(function()
		local Live2024 = ReplicatedStorage:FindFirstChild("Live2024")
		local runnerInstance
		if Live2024 then
			local Runner = Live2024:FindFirstChild("Runner")
			runnerInstance = if Runner and Runner:IsA("ModuleScript") then Runner else nil
		else
			runnerInstance = nil
		end
		runnerModule = runnerInstance
	end)
	if not loadSuccess then
		warn(loadError)
	end
	if runnerModule then
		task.wait(1)
		local startSuccess, startError = pcall(function()
			local runnerInstance = require(runnerModule)
			print("gonna start!")
			runnerInstance.start()
		end)
		if not startSuccess then
			warn(startError)
		end
	else
		task.wait(1)
	end
until not loadSuccess
