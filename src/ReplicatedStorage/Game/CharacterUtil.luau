-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HumanoidUnloadConsts = require(ReplicatedStorage.HumanoidUnload.HumanoidUnloadConsts)
local Signal = require(ReplicatedStorage.Std.Signal)
local Spring = require(ReplicatedStorage.Std.Spring)
local t = {
	OnJump = nil,
	IsCrawling = false,
	IsCrawlingChanged = Signal.new(),
	WalkSpeedSpring = Spring.new(1, 0, 0.8, 10),
	IsJuiced = false,
	setHumanoidEnabled = function(p1, p2)
		for i, v in ipairs(Enum.HumanoidStateType:GetEnumItems()) do
			if v ~= Enum.HumanoidStateType.Dead and (v ~= Enum.HumanoidStateType.None and (v ~= Enum.HumanoidStateType.Jumping and v ~= Enum.HumanoidStateType.FallingDown)) then
				p1:SetStateEnabled(v, p2)
			end
		end
	end,
	stopAnims = function(p1)
		local Animator = p1:FindFirstChildOfClass("Animator")
		for i, v in ipairs(Animator:GetPlayingAnimationTracks()) do
			v:Stop(0)
		end
	end,
	getPositionFromCharacter = function(p1)
		local Humanoid = p1:FindFirstChild("Humanoid")
		if Humanoid then
			local v1 = Humanoid:FindFirstChild(HumanoidUnloadConsts.SERVER_POSITION_OBJ_NAME)
			if v1 then
				return v1.Value
			else
				return nil
			end
		else
			return nil
		end
	end
}
function t.getAllCharacterPositions()
	local t2 = {}
	for v1, v2 in Players:GetPlayers() do
		local Character = v2.Character
		if Character then
			local v3 = t.getPositionFromCharacter(Character)
			if v3 then
				t2[Character] = v3
			end
		end
	end
	return t2
end
return t
