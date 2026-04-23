local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local LevelConsts = require(script.Parent.LevelConsts)
local t = {}
function t.init() --[[ Line: 9 | Upvalues: Players (copy), t (copy) ]]
	for i, v in ipairs(Players:GetPlayers()) do
		t.connectPlayer(v)
	end
	Players.PlayerAdded:Connect(t.connectPlayer)
end
function t.connectPlayer(p1) --[[ Line: 15 | Upvalues: waitForChild (copy), LevelConsts (copy), t (copy) ]]
	waitForChild(p1, LevelConsts.LEVEL_VALUE_NAME):andThen(function(p12) --[[ Line: 17 | Upvalues: t (ref), p1 (copy) ]]
		if t._onLevelChangedSignal then
			t._onLevelChangedSignal:Fire(p1, p12.Value)
		end
		p12:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 21 | Upvalues: t (ref), p1 (ref), p12 (copy) ]]
			if t._onLevelChangedSignal then
				t._onLevelChangedSignal:Fire(p1, p12.Value)
			end
		end)
	end):catch(warn)
	waitForChild(p1, LevelConsts.EXP_VALUE_NAME):andThen(function(p12) --[[ Line: 30 | Upvalues: t (ref), p1 (copy) ]]
		if t._onExpChangedSignal then
			t._onExpChangedSignal:Fire(p1, p12.Value)
		end
		p12:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 34 | Upvalues: t (ref), p1 (ref), p12 (copy) ]]
			if t._onExpChangedSignal then
				t._onExpChangedSignal:Fire(p1, p12.Value)
			end
		end)
	end):catch(warn)
end
function t.getOnLevelChangedSignal() --[[ Line: 42 | Upvalues: t (copy), Signal (copy) ]]
	if not t._onLevelChangedSignal then
		t._onLevelChangedSignal = Signal.new()
	end
	return t._onLevelChangedSignal
end
function t.getOnExpChangedSignal() --[[ Line: 49 | Upvalues: t (copy), Signal (copy) ]]
	if not t._onExpChangedSignal then
		t._onExpChangedSignal = Signal.new()
	end
	return t._onExpChangedSignal
end
return t