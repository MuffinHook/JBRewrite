-- Reviewed by Claude
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
local v2 = CFrame.new()
local function FromAxisAngle(p1)
	local x = p1.x
	local y = p1.y
	local z = p1.z
	local v1 = (x * x + y * y + z * z) ^ 0.5
	if v1 > 0.00001 then
		local v22 = math.sin(v1 * 0.5) / v1
		return CFrame.new(0, 0, 0, v22 * x, v22 * y, v22 * z, (math.cos(v1 * 0.5)))
	else
		return v2
	end
end
local t = {
	__ClassName = "Basic"
}
t.__index = t
setmetatable(t, Item)
function t.new(p1, p2, p3, p4)
	local v1 = Item.new(p1, p4)
	setmetatable(v1, t)
	v1.inventoryItemValue = p2
	v1.Config = p3
	v1.DoNotHide = true
	v1:SetupModel()
	v1:AttachModelToPlayer()
	v1:SetupSprings()
	v1:Equip()
	return v1
end
function t.SetupModel(p1)
	local v1 = InventoryItemUtils.getName(p1.inventoryItemValue)
	local v2 = ReplicatedStorage.Resource.ItemSystem.Models:FindFirstChild(v1)
	if v2 == nil then
		error(("Could not find model for item `%s`"):format(v1))
	end
	local v3 = v2:Clone()
	p1.Model = v3
	local Center = v3.Skeleton.Center
	p1.Center = Center
	Joint.WeldAllTo(v3, Center)
	p1.Maid:GiveTask(function()
		p1.Model:Destroy()
		p1.Model = nil
	end)
end
function t.SetupArmWelds(p1)
	Joint.Weld(p1.Model.Skeleton.LeftArm, p1.Center)
	Joint.Weld(p1.Model.Skeleton.RightArm, p1.Center)
	p1.Model.Skeleton.LeftArm.Anchored = false
	p1.Model.Skeleton.RightArm.Anchored = false
end
function t.AttachModelToPlayer(p1)
	local UpperTorso = p1.UpperTorso
	p1.Center.CFrame = UpperTorso.CFrame
	local v1 = Joint.BlankMotor(p1.Center, UpperTorso)
	p1.Model.Parent = workspace.Items
	p1.Motor = v1
	p1.Maid:GiveTask(function()
		p1.Motor:Destroy()
		p1.Motor = nil
	end)
end
function t.Equip(p1)
	p1.IK = R15IKv2.BuildPacketArms(p1.Character)
	p1.JointNeckC0 = p1.JointNeck.C0
	p1.JointWaistC0 = p1.JointWaist.C0
	p1.Maid:GiveTask(function()
		ConstraintUtils.setJointC0(p1.JointNeck, p1.JointNeckC0)
		ConstraintUtils.setJointC0(p1.JointWaist, p1.JointWaistC0)
	end)
	p1.Maid:GiveTask(RunService.Stepped:Connect(function()
		p1:Stepped()
	end))
	p1.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		p1:Heartbeat()
	end))
end
function t.GetRightArmPosition(p1)
	return p1.Model.Skeleton.RightArm.Position
end
function t.GetLeftArmPosition(p1)
	return p1.Model.Skeleton.LeftArm.Position
end
function t.UpdateArmIK(p1)
	local IK = p1.IK
	IK.RightArm = p1:GetRightArmPosition()
	IK.LeftArm = p1:GetLeftArmPosition()
	IK.RightAngle = p1.Config.Motion.RightElbowAngle
	IK.LeftAngle = p1.Config.Motion.LeftElbowAngle
end
function t.ComputeArmJoints(p1)
	p1:UpdateArmIK()
	R15IKv2.ComputeArms(p1.IK)
end
function t.ApplyArmJoints(p1)
	local IK = p1.IK
	R15IKv2.ApplyArms(IK)
	if p1.Config.Motion.RightWristRotation then
		IK.RightWrist.Transform = p1.Config.Motion.RightWristRotation
	end
	if p1.Config.Motion.LeftWristRotation then
		IK.LeftWrist.Transform = p1.Config.Motion.LeftWristRotation
	end
end
function t.Stepped(p1)
	p1:ApplyArmJoints()
end
function t.Heartbeat(p1)
	local v1 = p1.SpringItemOffset:Update()
	local v2 = FromAxisAngle((p1.SpringItemRotation:Update()))
	p1.Motor.C1 = v2 * CFrame.new(v1) * p1.JointWaist.C1
	ConstraintUtils.setJointC0(p1.JointWaist, p1.JointWaistC0 * FromAxisAngle((p1.SpringWaistRotation:Update())))
	ConstraintUtils.setJointC0(p1.JointNeck, p1.JointNeckC0 * FromAxisAngle((p1.SpringNeckRotation:Update())))
	p1:ComputeArmJoints()
end
function t.TransformLocalMousePosition(p1, p2)
	return p2
end
function t.GetMouseLocation(p1)
	if InputUtils.isGamepad() then
		local ViewportSize = workspace.CurrentCamera.ViewportSize
		return Vector3.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.5, 0)
	else
		return UserInputService:GetMouseLocation()
	end
end
function t.UpdateMousePosition(p1)
	local v1
	if p1.Local then
		local v2 = p1:GetMouseLocation()
		local v3 = CurrentCamera:ViewportPointToRay(v2.x, v2.y)
		local _, v4 = RayCast.RayIgnoreNonCollideWithIgnoreList(v3.Origin, v3.Direction, 999, p1.IgnoreList)
		v1 = p1:TransformLocalMousePosition(v4)
	else
		v1 = nil
	end
	p1.MousePosition = v1
end
function t.SetupSprings(p1, p2)
	if p1.Local and (p2 and p2.SpringItemOffset) then
		p1.SpringItemOffset = p2.SpringItemOffset
		p1.SpringItemOffset.Damp = 0.9
		p1.SpringItemOffset.Freq = 20
		p1.SpringItemOffset:SetTarget(p1.Config.Motion.Hip.Springs.ItemOffset)
	else
		p1.SpringItemOffset = Spring.new(p1.Config.Motion.Hip.Springs.ItemOffset, Vector3.new(), 0.9, 20)
	end
	if p1.Local and (p2 and p2.SpringItemRotation) then
		p1.SpringItemRotation = p2.SpringItemRotation
		p1.SpringItemRotation.Damp = 0.9
		p1.SpringItemRotation.Freq = 20
		p1.SpringItemRotation:SetTarget(p1.Config.Motion.Hip.Springs.ItemRotation)
	else
		p1.SpringItemRotation = Spring.new(p1.Config.Motion.Hip.Springs.ItemRotation, Vector3.new(), 0.9, 20)
	end
	if p1.Local and (p2 and p2.SpringNeckRotation) then
		p1.SpringNeckRotation = p2.SpringNeckRotation
		p1.SpringNeckRotation.Damp = 0.9
		p1.SpringNeckRotation.Freq = 20
		p1.SpringNeckRotation:SetTarget(p1.Config.Motion.Hip.Springs.NeckRotation)
	else
		p1.SpringNeckRotation = Spring.new(p1.Config.Motion.Hip.Springs.NeckRotation, Vector3.new(), 0.9, 20)
	end
	if p1.Local and (p2 and p2.SpringWaistRotation) then
		p1.SpringWaistRotation = p2.SpringWaistRotation
		p1.SpringWaistRotation.Damp = 0.9
		p1.SpringWaistRotation.Freq = 20
		p1.SpringWaistRotation:SetTarget(p1.Config.Motion.Hip.Springs.WaistRotation)
	else
		p1.SpringWaistRotation = Spring.new(p1.Config.Motion.Hip.Springs.WaistRotation, Vector3.new(), 0.9, 20)
	end
end
function t.InputBegan(p1, p2, p3)
	Item.InputBegan(p1, p2, p3)
end
return t