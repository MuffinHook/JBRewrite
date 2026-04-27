local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local LevelConsts = require(script.Parent.LevelConsts)
local LevelSystem = {}
function LevelSystem.init()
	for i, player in ipairs(Players:GetPlayers()) do
		LevelSystem.connectPlayer(player)
	end
	Players.PlayerAdded:Connect(LevelSystem.connectPlayer)
end
function LevelSystem.connectPlayer(player)
	waitForChild(player, LevelConsts.LEVEL_VALUE_NAME):andThen(function(levelValue)
		if LevelSystem._onLevelChangedSignal then
			LevelSystem._onLevelChangedSignal:Fire(player, levelValue.Value)
		end
		levelValue:GetPropertyChangedSignal("Value"):Connect(function()
			if LevelSystem._onLevelChangedSignal then
				LevelSystem._onLevelChangedSignal:Fire(player, levelValue.Value)
			end
		end)
	end):catch(warn)
	waitForChild(player, LevelConsts.EXP_VALUE_NAME):andThen(function(expValue)
		if LevelSystem._onExpChangedSignal then
			LevelSystem._onExpChangedSignal:Fire(player, expValue.Value)
		end
		expValue:GetPropertyChangedSignal("Value"):Connect(function()
			if LevelSystem._onExpChangedSignal then
				LevelSystem._onExpChangedSignal:Fire(player, expValue.Value)
			end
		end)
	end):catch(warn)
end
function LevelSystem.getOnLevelChangedSignal()
	if not LevelSystem._onLevelChangedSignal then
		LevelSystem._onLevelChangedSignal = Signal.new()
	end
	return LevelSystem._onLevelChangedSignal
end
function LevelSystem.getOnExpChangedSignal()
	if not LevelSystem._onExpChangedSignal then
		LevelSystem._onExpChangedSignal = Signal.new()
	end
	return LevelSystem._onExpChangedSignal
end
return LevelSystem
