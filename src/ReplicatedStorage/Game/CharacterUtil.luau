local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HumanoidUnloadConsts = require(ReplicatedStorage.HumanoidUnload.HumanoidUnloadConsts)
local Signal = require(ReplicatedStorage.Std.Signal)
local Spring = require(ReplicatedStorage.Std.Spring)
local CharacterUtil = {
	OnJump = nil,
	IsCrawling = false,
	IsCrawlingChanged = Signal.new(),
	WalkSpeedSpring = Spring.new(1, 0, 0.8, 10),
	IsJuiced = false,
	setHumanoidEnabled = function(humanoid, enabled)
		for i, v in ipairs(Enum.HumanoidStateType:GetEnumItems()) do
			if v ~= Enum.HumanoidStateType.Dead and (v ~= Enum.HumanoidStateType.None and (v ~= Enum.HumanoidStateType.Jumping and v ~= Enum.HumanoidStateType.FallingDown)) then
				humanoid:SetStateEnabled(v, enabled)
			end
		end
	end,
	stopAnims = function(animator)
		local Animator = animator:FindFirstChildOfClass("Animator")
		for i, v in ipairs(Animator:GetPlayingAnimationTracks()) do
			v:Stop(0)
		end
	end,
	getPositionFromCharacter = function(character)
		local Humanoid = character:FindFirstChild("Humanoid")
		if Humanoid then
			local positionObj = Humanoid:FindFirstChild(HumanoidUnloadConsts.SERVER_POSITION_OBJ_NAME)
			if positionObj then
				return positionObj.Value
			else
				return nil
			end
		else
			return nil
		end
	end
}
function CharacterUtil.getAllCharacterPositions()
	local characterPositions = {}
	for i, player in Players:GetPlayers() do
		local Character = player.Character
		if Character then
			local position = CharacterUtil.getPositionFromCharacter(Character)
			if position then
				characterPositions[Character] = position
			end
		end
	end
	return characterPositions
end
return CharacterUtil
