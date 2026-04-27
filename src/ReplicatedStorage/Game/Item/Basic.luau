local CurrentCamera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RayCast = require(ReplicatedStorage.Module.RayCast)
local Spring = require(ReplicatedStorage.Std.Spring)
local Joint = require(ReplicatedStorage.Std.Joint)
local R15IKv2 = require(ReplicatedStorage.Module.R15IKv2)
local InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local ConstraintUtils = require(ReplicatedStorage.Std.ConstraintUtils)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local Item = require(script.Parent.Item)
local defaultCFrame = CFrame.new()
local function FromAxisAngle(axisVector)
	local x = axisVector.x
	local y = axisVector.y
	local z = axisVector.z
	local magnitude = (x * x + y * y + z * z) ^ 0.5
	if magnitude > 0.00001 then
		local sinHalf = math.sin(magnitude * 0.5) / magnitude
		return CFrame.new(0, 0, 0, sinHalf * x, sinHalf * y, sinHalf * z, (math.cos(magnitude * 0.5)))
	else
		return defaultCFrame
	end
end
local t = {
	__ClassName = "Basic"
}
t.__index = t
setmetatable(t, Item)
function t.new(parent, inventoryItemValue, config, otherParent)
	local newItem = Item.new(parent, otherParent)
	setmetatable(newItem, t)
	newItem.inventoryItemValue = inventoryItemValue
	newItem.Config = config
	newItem.DoNotHide = true
	newItem:SetupModel()
	newItem:AttachModelToPlayer()
	newItem:SetupSprings()
	newItem:Equip()
	return newItem
end
function t.SetupModel(self)
	local itemName = InventoryItemUtils.getName(self.inventoryItemValue)
	local modelTemplate = ReplicatedStorage.Resource.ItemSystem.Models:FindFirstChild(itemName)
	if modelTemplate == nil then
		error(("Could not find model for item `%s`"):format(itemName))
	end
	local clonedModel = modelTemplate:Clone()
	self.Model = clonedModel
	local Center = clonedModel.Skeleton.Center
	self.Center = Center
	Joint.WeldAllTo(clonedModel, Center)
	self.Maid:GiveTask(function()
		self.Model:Destroy()
		self.Model = nil
	end)
end
function t.SetupArmWelds(self)
	Joint.Weld(self.Model.Skeleton.LeftArm, self.Center)
	Joint.Weld(self.Model.Skeleton.RightArm, self.Center)
	self.Model.Skeleton.LeftArm.Anchored = false
	self.Model.Skeleton.RightArm.Anchored = false
end
function t.AttachModelToPlayer(self)
	local UpperTorso = self.UpperTorso
	self.Center.CFrame = UpperTorso.CFrame
	local motorJoint = Joint.BlankMotor(self.Center, UpperTorso)
	self.Model.Parent = workspace.Items
	self.Motor = motorJoint
	self.Maid:GiveTask(function()
		self.Motor:Destroy()
		self.Motor = nil
	end)
end
function t.Equip(self)
	self.IK = R15IKv2.BuildPacketArms(self.Character)
	self.JointNeckC0 = self.JointNeck.C0
	self.JointWaistC0 = self.JointWaist.C0
	self.Maid:GiveTask(function()
		ConstraintUtils.setJointC0(self.JointNeck, self.JointNeckC0)
		ConstraintUtils.setJointC0(self.JointWaist, self.JointWaistC0)
	end)
	self.Maid:GiveTask(RunService.Stepped:Connect(function()
		self:Stepped()
	end))
	self.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		self:Heartbeat()
	end))
end
function t.GetRightArmPosition(self)
	return self.Model.Skeleton.RightArm.Position
end
function t.GetLeftArmPosition(self)
	return self.Model.Skeleton.LeftArm.Position
end
function t.UpdateArmIK(self)
	local IK = self.IK
	IK.RightArm = self:GetRightArmPosition()
	IK.LeftArm = self:GetLeftArmPosition()
	IK.RightAngle = self.Config.Motion.RightElbowAngle
	IK.LeftAngle = self.Config.Motion.LeftElbowAngle
end
function t.ComputeArmJoints(self)
	self:UpdateArmIK()
	R15IKv2.ComputeArms(self.IK)
end
function t.ApplyArmJoints(self)
	local IK = self.IK
	R15IKv2.ApplyArms(IK)
	if self.Config.Motion.RightWristRotation then
		IK.RightWrist.Transform = self.Config.Motion.RightWristRotation
	end
	if self.Config.Motion.LeftWristRotation then
		IK.LeftWrist.Transform = self.Config.Motion.LeftWristRotation
	end
end
function t.Stepped(self)
	self:ApplyArmJoints()
end
function t.Heartbeat(self)
	local offsetPosition = self.SpringItemOffset:Update()
	local rotationCFrame = FromAxisAngle((self.SpringItemRotation:Update()))
	self.Motor.C1 = rotationCFrame * CFrame.new(offsetPosition) * self.JointWaist.C1
	ConstraintUtils.setJointC0(self.JointWaist, self.JointWaistC0 * FromAxisAngle((self.SpringWaistRotation:Update())))
	ConstraintUtils.setJointC0(self.JointNeck, self.JointNeckC0 * FromAxisAngle((self.SpringNeckRotation:Update())))
	self:ComputeArmJoints()
end
function t.TransformLocalMousePosition(self, localPosition)
	return localPosition
end
function t.GetMouseLocation(self)
	if InputUtils.isGamepad() then
		local ViewportSize = workspace.CurrentCamera.ViewportSize
		return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.5, 0)
	else
		return UserInputService:GetMouseLocation()
	end
end
function t.UpdateMousePosition(self)
	local hitPosition
	if self.Local then
		local mouseLocation = self:GetMouseLocation()
		local raycastRay = CurrentCamera:ViewportPointToRay(mouseLocation.x, mouseLocation.y)
		local _, hitPoint = RayCast.RayIgnoreNonCollideWithIgnoreList(raycastRay.Origin, raycastRay.Direction, 999, self.IgnoreList)
		hitPosition = self:TransformLocalMousePosition(hitPoint)
	else
		hitPosition = nil
	end
	self.MousePosition = hitPosition
end
function t.SetupSprings(self, previousItemInstance)
	if self.Local and (previousItemInstance and previousItemInstance.SpringItemOffset) then
		self.SpringItemOffset = previousItemInstance.SpringItemOffset
		self.SpringItemOffset.Damp = 0.9
		self.SpringItemOffset.Freq = 20
		self.SpringItemOffset:SetTarget(self.Config.Motion.Hip.Springs.ItemOffset)
	else
		self.SpringItemOffset = Spring.new(self.Config.Motion.Hip.Springs.ItemOffset, Vector3.new(), 0.9, 20)
	end
	if self.Local and (previousItemInstance and previousItemInstance.SpringItemRotation) then
		self.SpringItemRotation = previousItemInstance.SpringItemRotation
		self.SpringItemRotation.Damp = 0.9
		self.SpringItemRotation.Freq = 20
		self.SpringItemRotation:SetTarget(self.Config.Motion.Hip.Springs.ItemRotation)
	else
		self.SpringItemRotation = Spring.new(self.Config.Motion.Hip.Springs.ItemRotation, Vector3.new(), 0.9, 20)
	end
	if self.Local and (previousItemInstance and previousItemInstance.SpringNeckRotation) then
		self.SpringNeckRotation = previousItemInstance.SpringNeckRotation
		self.SpringNeckRotation.Damp = 0.9
		self.SpringNeckRotation.Freq = 20
		self.SpringNeckRotation:SetTarget(self.Config.Motion.Hip.Springs.NeckRotation)
	else
		self.SpringNeckRotation = Spring.new(self.Config.Motion.Hip.Springs.NeckRotation, Vector3.new(), 0.9, 20)
	end
	if self.Local and (previousItemInstance and previousItemInstance.SpringWaistRotation) then
		self.SpringWaistRotation = previousItemInstance.SpringWaistRotation
		self.SpringWaistRotation.Damp = 0.9
		self.SpringWaistRotation.Freq = 20
		self.SpringWaistRotation:SetTarget(self.Config.Motion.Hip.Springs.WaistRotation)
	else
		self.SpringWaistRotation = Spring.new(self.Config.Motion.Hip.Springs.WaistRotation, Vector3.new(), 0.9, 20)
	end
end
function t.InputBegan(self, inputObject, gameProcessedEvent)
	Item.InputBegan(self, inputObject, gameProcessedEvent)
end
return t
