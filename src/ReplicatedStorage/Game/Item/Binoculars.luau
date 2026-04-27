local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemCamera = require(ReplicatedStorage.Game.ItemSystem.ItemCamera)
local PartUtils = require(ReplicatedStorage.Std.PartUtils)
local cameraControllers = require(Players.LocalPlayer.PlayerScripts.PlayerModule):GetCameras()
local Basic = require(script.Parent.Basic)
local motionConfig = {
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
local screenGui = nil
local BinocularsClass = {
	__ClassName = "Binoculars"
}
BinocularsClass.__index = BinocularsClass
setmetatable(BinocularsClass, Basic)
function BinocularsClass.Init(config)
	screenGui = config.ScreenGui
end
function BinocularsClass.new(self, player, config)
	local instance = Basic.new(self, player, motionConfig, config)
	setmetatable(instance, BinocularsClass)
	if instance.Local then
		instance.Maid:GiveTask(function()
			instance:Hide()
		end)
	end
	return instance
end
function BinocularsClass.Look(self)
	if self.Local then
		local binocularWidth = screenGui.AbsoluteSize.X + 40
		local screenHeight = screenGui.AbsoluteSize.Y
		screenGui.Binoculars.ImageLabel.Size = UDim2.new(0, binocularWidth, 0, binocularWidth * 0.6)
		screenGui.Binoculars.ImageLabel.Position = UDim2.new(0.5, -binocularWidth * 0.5, 0.5, -binocularWidth * 0.6 * 0.5)
		screenGui.Binoculars.BarTop.Position = UDim2.new(0, 0, 0, -100)
		screenGui.Binoculars.BarTop.Size = UDim2.new(1, 0, 0, (screenHeight - binocularWidth * 0.6) * 0.5 + 20 + 100)
		screenGui.Binoculars.BarBottom.Size = UDim2.new(1, 0, 0, (screenHeight - binocularWidth * 0.6) * 0.5 + 20)
		screenGui.Binoculars.BarBottom.Position = UDim2.new(0, 0, 1, -((screenHeight - binocularWidth * 0.6) * 0.5 + 20))
		screenGui.Binoculars.Visible = true
		ItemCamera.Zoom(15)
		local activeCameraController = cameraControllers.activeCameraController
		if activeCameraController then
			self.prevSubjectDistance = activeCameraController.currentSubjectDistance
			activeCameraController:SetCameraToSubjectDistance(0.5)
		end
		ItemCamera.setSensitivity(0.3)
		self.rollbackTransparency = PartUtils.setPropertyWithRollback(self.Model, "LocalTransparencyModifier", 1)
	end
	self.SpringItemOffset:SetTarget(self.Config.Motion.Eyes.Springs.ItemOffset)
	self.SpringItemRotation:SetTarget(self.Config.Motion.Eyes.Springs.ItemRotation)
	self.SpringNeckRotation:SetTarget(self.Config.Motion.Eyes.Springs.NeckRotation)
	self.SpringWaistRotation:SetTarget(self.Config.Motion.Eyes.Springs.WaistRotation)
end
function BinocularsClass.Hide(self)
	if self.Local then
		if screenGui.Binoculars.Visible then
			screenGui.Binoculars.Visible = false
			ItemCamera.Zoom(70)
			if self.prevSubjectDistance then
				local activeCameraController = cameraControllers.activeCameraController
				if activeCameraController then
					activeCameraController:SetCameraToSubjectDistance(self.prevSubjectDistance)
				end
				self.prevSubjectDistance = nil
			end
			ItemCamera.setSensitivity(1)
		end
		if self.rollbackTransparency then
			self.rollbackTransparency()
			self.rollbackTransparency = nil
		end
	end
	self.SpringItemOffset:SetTarget(self.Config.Motion.Hip.Springs.ItemOffset)
	self.SpringItemRotation:SetTarget(self.Config.Motion.Hip.Springs.ItemRotation)
	self.SpringNeckRotation:SetTarget(self.Config.Motion.Hip.Springs.NeckRotation)
	self.SpringWaistRotation:SetTarget(self.Config.Motion.Hip.Springs.WaistRotation)
end
function BinocularsClass.InputBegan(self, inputObject, gameProcessed)
	if if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then true elseif inputObject.UserInputType == Enum.UserInputType.Gamepad1 then inputObject.KeyCode == Enum.KeyCode.ButtonR2 else false then
		self:Look()
		if self.Local then
			self:BroadcastInputBegan(inputObject)
		end
	end
	Basic.InputBegan(self, inputObject, gameProcessed)
end
function BinocularsClass.InputEnded(self, inputObject)
	if if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then true elseif inputObject.UserInputType == Enum.UserInputType.Gamepad1 then inputObject.KeyCode == Enum.KeyCode.ButtonR2 else false then
		self:Hide()
		if self.Local then
			self:BroadcastInputBegan(inputObject)
		end
	end
end
return BinocularsClass
