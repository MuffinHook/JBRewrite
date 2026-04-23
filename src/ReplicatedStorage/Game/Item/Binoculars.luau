-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemCamera = require(ReplicatedStorage.Game.ItemSystem.ItemCamera)
local PartUtils = require(ReplicatedStorage.Std.PartUtils)
local v1 = require(Players.LocalPlayer.PlayerScripts.PlayerModule):GetCameras()
local Basic = require(script.Parent.Basic)
local t = {
	Motion = {
		Hip = {
			Springs = {
				ItemOffset = Vector3.new(0, 0.6, -1.5),
				ItemRotation = Vector3.new(),
				NeckRotation = Vector3.new(),
				WaistRotation = Vector3.new()
			}
		},
		Eyes = {
			Springs = {
				ItemOffset = Vector3.new(0, 2.7, -1),
				ItemRotation = Vector3.new(),
				NeckRotation = Vector3.new(0.2, 0, 0),
				WaistRotation = Vector3.new(-0.2, 0, 0)
			}
		},
		RightWristRotation = CFrame.new(),
		LeftWristRotation = CFrame.new()
	}
}
local v3 = nil
local t2 = {
	__ClassName = "Binoculars"
}
t2.__index = t2
setmetatable(t2, Basic)
function t2.Init(p1)
	v3 = p1.ScreenGui
end
function t2.new(p1, p2, p3)
	local v1 = Basic.new(p1, p2, t, p3)
	setmetatable(v1, t2)
	if v1.Local then
		v1.Maid:GiveTask(function()
			v1:Hide()
		end)
	end
	return v1
end
function t2.Look(p1)
	if p1.Local then
		local v12 = v3.AbsoluteSize.X + 40
		local Y = v3.AbsoluteSize.Y
		v3.Binoculars.ImageLabel.Size = UDim2.new(0, v12, 0, v12 * 0.6)
		v3.Binoculars.ImageLabel.Position = UDim2.new(0.5, -v12 * 0.5, 0.5, -v12 * 0.6 * 0.5)
		v3.Binoculars.BarTop.Position = UDim2.new(0, 0, 0, -100)
		v3.Binoculars.BarTop.Size = UDim2.new(1, 0, 0, (Y - v12 * 0.6) * 0.5 + 20 + 100)
		v3.Binoculars.BarBottom.Size = UDim2.new(1, 0, 0, (Y - v12 * 0.6) * 0.5 + 20)
		v3.Binoculars.BarBottom.Position = UDim2.new(0, 0, 1, -((Y - v12 * 0.6) * 0.5 + 20))
		v3.Binoculars.Visible = true
		ItemCamera.Zoom(15)
		local activeCameraController = v1.activeCameraController
		if activeCameraController then
			p1.prevSubjectDistance = activeCameraController.currentSubjectDistance
			activeCameraController:SetCameraToSubjectDistance(0.5)
		end
		ItemCamera.setSensitivity(0.3)
		p1.rollbackTransparency = PartUtils.setPropertyWithRollback(p1.Model, "LocalTransparencyModifier", 1)
	end
	p1.SpringItemOffset:SetTarget(p1.Config.Motion.Eyes.Springs.ItemOffset)
	p1.SpringItemRotation:SetTarget(p1.Config.Motion.Eyes.Springs.ItemRotation)
	p1.SpringNeckRotation:SetTarget(p1.Config.Motion.Eyes.Springs.NeckRotation)
	p1.SpringWaistRotation:SetTarget(p1.Config.Motion.Eyes.Springs.WaistRotation)
end
function t2.Hide(p1)
	if p1.Local then
		if v3.Binoculars.Visible then
			v3.Binoculars.Visible = false
			ItemCamera.Zoom(70)
			if p1.prevSubjectDistance then
				local activeCameraController = v1.activeCameraController
				if activeCameraController then
					activeCameraController:SetCameraToSubjectDistance(p1.prevSubjectDistance)
				end
				p1.prevSubjectDistance = nil
			end
			ItemCamera.setSensitivity(1)
		end
		if p1.rollbackTransparency then
			p1.rollbackTransparency()
			p1.rollbackTransparency = nil
		end
	end
	p1.SpringItemOffset:SetTarget(p1.Config.Motion.Hip.Springs.ItemOffset)
	p1.SpringItemRotation:SetTarget(p1.Config.Motion.Hip.Springs.ItemRotation)
	p1.SpringNeckRotation:SetTarget(p1.Config.Motion.Hip.Springs.NeckRotation)
	p1.SpringWaistRotation:SetTarget(p1.Config.Motion.Hip.Springs.WaistRotation)
end
function t2.InputBegan(p1, p2, p3)
	if if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonR2 else false then
		p1:Look()
		if p1.Local then
			p1:BroadcastInputBegan(p2)
		end
	end
	Basic.InputBegan(p1, p2, p3)
end
function t2.InputEnded(p1, p2)
	if if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonR2 else false then
		p1:Hide()
		if p1.Local then
			p1:BroadcastInputBegan(p2)
		end
	end
end
return t2