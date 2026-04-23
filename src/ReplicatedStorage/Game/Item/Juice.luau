local Basic = require(script.Parent.Basic)
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ShockwaveScreenFx = require(ReplicatedStorage.Game.ShockwaveScreenFx)
local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
require(ReplicatedStorage.Module.R15IKv2)
local Audio = require(ReplicatedStorage.Std.Audio)
local t = {
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
local v2 = nil
local t2 = {
	__ClassName = "Juice"
}
t2.__index = t2
setmetatable(t2, Basic)
function t2.Init(p1) --[[ Line: 39 | Upvalues: v2 (ref), CharacterUtil (copy), ShockwaveScreenFx (copy), RunService (copy) ]]
	v2 = p1.Event
	function p1.em.l2x2ypvi() --[[ Line: 44 | Upvalues: CharacterUtil (ref), ShockwaveScreenFx (ref), RunService (ref) ]]
		CharacterUtil.IsJuiced = true
		CharacterUtil.WalkSpeedSpring:Accelerate(20)
		local v1 = ShockwaveScreenFx.new()
		v1._maid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 48 | Upvalues: v1 (copy) ]]
			v1:Update()
		end))
		v1:SetActive(true)
		task.delay(3, function() --[[ Line: 52 | Upvalues: v1 (copy), CharacterUtil (ref) ]]
			v1:SetActive(false)
			CharacterUtil.IsJuiced = false
			task.wait(5)
			v1:Destroy()
		end)
	end
end
function t2.new(p1, p2, p3) --[[ Line: 60 | Upvalues: Basic (copy), t (copy), t2 (copy) ]]
	local v1 = Basic.new(p1, p2, t, p3)
	setmetatable(v1, t2)
	v1:DefaultDisableCamLock()
	return v1
end
function t2.UpdateArmIK(p1) --[[ Line: 68 ]]
	local IK = p1.IK
	IK.RightArm = p1.Model.Skeleton.RightArm.Position
	IK.RightAngle = p1.Config.Motion.RightElbowAngle
end
function t2.InputBegan(p1, p2, p3) --[[ Line: 74 | Upvalues: Audio (copy), v2 (ref), Basic (copy) ]]
	if if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonR2 else false then
		p1.SpringItemOffset:SetTarget(p1.Config.Motion.Eat.Springs.ItemOffset)
		p1.SpringItemRotation:SetTarget(p1.Config.Motion.Eat.Springs.ItemRotation)
		Audio.ObjectLocal(p1.Character.PrimaryPart, 7209853095, {
			Volume = 0.3
		})
		delay(0.3, function() --[[ Line: 84 | Upvalues: p1 (copy), v2 (ref) ]]
			p1.SpringItemOffset:SetTarget(p1.Config.Motion.Hip.Springs.ItemOffset)
			p1.SpringItemRotation:SetTarget(p1.Config.Motion.Hip.Springs.ItemRotation)
			if p1.Local then
				local v1 = tick()
				local v22 = p1.LastConsumed or 0
				p1.LastConsumed = v1
				if v1 - v22 < 5 then
					return false
				end
				v2:FireServer("l" .. "" .. ("ux2m3"):sub(2, 3):reverse():reverse():reverse():reverse():reverse() .. "2ypvi")
			end
		end)
		if p1.Local then
			p1:BroadcastInputBegan(p2)
		end
	end
	Basic.InputBegan(p1, p2, p3)
end
function t2.InputEnded(p1) --[[ Line: 103 ]] end
return t2