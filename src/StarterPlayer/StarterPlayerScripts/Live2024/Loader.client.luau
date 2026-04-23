local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunConsts = require(ReplicatedStorage.App.RunConsts)
if require(ReplicatedStorage.App.RunUtils).getWorld() ~= RunConsts.MAIN_WORLD_NAME then
	return
end
local function getRunnerModule() --[[ Line: 7 | Upvalues: ReplicatedStorage (copy) ]]
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
	local v2, v3 = pcall(function() --[[ Line: 20 | Upvalues: v1 (ref), ReplicatedStorage (copy) ]]
		local Live2024 = ReplicatedStorage:FindFirstChild("Live2024")
		local v12
		if Live2024 then
			local Runner = Live2024:FindFirstChild("Runner")
			v12 = if Runner and Runner:IsA("ModuleScript") then Runner else nil
		else
			v12 = nil
		end
		v1 = v12
	end)
	if not v2 then
		warn(v3)
	end
	if v1 then
		task.wait(1)
		local v4, v5 = pcall(function() --[[ Line: 29 | Upvalues: v1 (ref) ]]
			local v12 = require(v1)
			print("gonna start!")
			v12.start()
		end)
		if not v4 then
			warn(v5)
		end
	else
		task.wait(1)
	end
until not v2