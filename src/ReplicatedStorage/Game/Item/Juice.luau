local Basic = require(script.Parent.Basic)
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ShockwaveScreenFx = require(ReplicatedStorage.Game.ShockwaveScreenFx)
local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
require(ReplicatedStorage.Module.R15IKv2)
local Audio = require(ReplicatedStorage.Std.Audio)
local motionConfig = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0.5, 0.8, -1.5),
				ItemRotation = Vector3.new(),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		Eat = {
			Springs = {
				ItemOffset = Vector3.new(0, 0.8, -1.5),
				ItemRotation = Vector3.new(0.9424778, 0, 0),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		RightWristRotation = CFrame.new(),
		LeftWristRotation = CFrame.new()
	}
}
local eventObject = nil
local Juice = {
	__ClassName = "Juice"
}
Juice.__index = Juice
setmetatable(Juice, Basic)
function Juice.Init(juiceItem)
	eventObject = juiceItem.Event
	function juiceItem.em.l2x2ypvi()
		CharacterUtil.IsJuiced = true
		CharacterUtil.WalkSpeedSpring:Accelerate(20)
		local shockwaveFx = ShockwaveScreenFx.new()
		shockwaveFx._maid:GiveTask(RunService.Heartbeat:Connect(function()
			shockwaveFx:Update()
		end))
		shockwaveFx:SetActive(true)
		task.delay(3, function()
			shockwaveFx:SetActive(false)
			CharacterUtil.IsJuiced = false
			task.wait(5)
			shockwaveFx:Destroy()
		end)
	end
end
function Juice.new(baseCharacter, basePart, baseConfig)
	local juiceInstance = Basic.new(baseCharacter, basePart, motionConfig, baseConfig)
	setmetatable(juiceInstance, Juice)
	juiceInstance:DefaultDisableCamLock()
	return juiceInstance
end
function Juice.UpdateArmIK(juiceItem)
	local IK = juiceItem.IK
	IK.RightArm = juiceItem.Model.Skeleton.RightArm.Position
	IK.RightAngle = juiceItem.Config.Motion.RightElbowAngle
end
function Juice.InputBegan(juiceItem, inputObject, p3)
	if if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then true elseif inputObject.UserInputType == Enum.UserInputType.Gamepad1 then inputObject.KeyCode == Enum.KeyCode.ButtonR2 else false then
		juiceItem.SpringItemOffset:SetTarget(juiceItem.Config.Motion.Eat.Springs.ItemOffset)
		juiceItem.SpringItemRotation:SetTarget(juiceItem.Config.Motion.Eat.Springs.ItemRotation)
		Audio.ObjectLocal(juiceItem.Character.PrimaryPart, 7209853095, {
			Volume = 0.3
		})
		task.delay(0.3, function()
			juiceItem.SpringItemOffset:SetTarget(juiceItem.Config.Motion.Hip.Springs.ItemOffset)
			juiceItem.SpringItemRotation:SetTarget(juiceItem.Config.Motion.Hip.Springs.ItemRotation)
			if juiceItem.Local then
				local now = tick()
				local lastConsumedTime = juiceItem.LastConsumed or 0
				juiceItem.LastConsumed = now
				if now - lastConsumedTime < 5 then
					return false
				end
				eventObject:FireServer("l2x2ypvi")
			end
		end)
		if juiceItem.Local then
			juiceItem:BroadcastInputBegan(inputObject)
		end
	end
	Basic.InputBegan(juiceItem, inputObject, p3)
end
function Juice.InputEnded(juiceItem)  end
return Juice
