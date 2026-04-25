-- Reviewed by Claude
-- variables reassigned
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
function Juice.Init(p1)
	eventObject = p1.Event
	function p1.em.l2x2ypvi()
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
function Juice.new(p1, p2, p3)
	local juiceInstance = Basic.new(p1, p2, motionConfig, p3)
	setmetatable(juiceInstance, Juice)
	juiceInstance:DefaultDisableCamLock()
	return juiceInstance
end
function Juice.UpdateArmIK(p1)
	local IK = p1.IK
	IK.RightArm = p1.Model.Skeleton.RightArm.Position
	IK.RightAngle = p1.Config.Motion.RightElbowAngle
end
function Juice.InputBegan(p1, p2, p3)
	if if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonR2 else false then
		p1.SpringItemOffset:SetTarget(p1.Config.Motion.Eat.Springs.ItemOffset)
		p1.SpringItemRotation:SetTarget(p1.Config.Motion.Eat.Springs.ItemRotation)
		Audio.ObjectLocal(p1.Character.PrimaryPart, 7209853095, {
			Volume = 0.3
		})
		delay(0.3, function()
			p1.SpringItemOffset:SetTarget(p1.Config.Motion.Hip.Springs.ItemOffset)
			p1.SpringItemRotation:SetTarget(p1.Config.Motion.Hip.Springs.ItemRotation)
			if p1.Local then
				local now = tick()
				local lastConsumedTime = p1.LastConsumed or 0
				p1.LastConsumed = now
				if now - lastConsumedTime < 5 then
					return false
				end
				eventObject:FireServer("l" .. "" .. ("ux2m3"):sub(2, 3):reverse():reverse():reverse():reverse():reverse() .. "2ypvi")
			end
		end)
		if p1.Local then
			p1:BroadcastInputBegan(p2)
		end
	end
	Basic.InputBegan(p1, p2, p3)
end
function Juice.InputEnded(p1)  end
return Juice
