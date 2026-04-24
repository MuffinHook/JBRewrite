-- Reviewed by Claude
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GunUtils = require(ReplicatedStorage.Game.GunShop.GunUtils)
local GunSystemConsts = require(ReplicatedStorage.Game.ItemSystem.GunSystemConsts)
local Joint = require(ReplicatedStorage.Std.Joint)
local Spring = require(ReplicatedStorage.Std.Spring)
local R15IKv2 = require(ReplicatedStorage.Module.R15IKv2)
local InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local ConstraintUtils = require(ReplicatedStorage.Std.ConstraintUtils)
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
	__ClassName = "Melee"
}
t.__index = t
setmetatable(t, Item)
function t.new(p1, p2, p3, p4)
	local v1 = Item.new(p1, p4)
	setmetatable(v1, t)
	v1.Config = p3
	v1.inventoryItemValue = p2
	v1.JointNeckC0 = v1.JointNeck.C0
	v1.JointWaistC0 = v1.JointWaist.C0
	v1.Maid:GiveTask(function()
		ConstraintUtils.setJointC0(v1.JointNeck, v1.JointNeckC0)
		ConstraintUtils.setJointC0(v1.JointWaist, v1.JointWaistC0)
	end)
	v1.IK = R15IKv2.BuildPacketArms(v1.Character)
	v1.IsEquipping = false
	v1:SetupModel()
	v1:AttachModelToPlayer()
	v1:SetupSprings(p4)
	v1:Equip()
	return v1
end
function t.Equip(p1)
	local v2 = GunUtils.getEquipTime((InventoryItemUtils.getName(p1.inventoryItemValue))) or GunSystemConsts.GUN_EQUIP_TIME
	if GunUtils.getShouldAddEquipTime(p1) and v2 > 0 then
		p1.IsEquipping = true
		p1:StartReloadProgressCircle(v2)
		p1.maid:GiveTask(task.delay(v2, function()
			p1.IsEquipping = false
		end))
	end
	p1.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		p1:Heartbeat()
	end))
	p1.Maid:GiveTask(RunService.Stepped:Connect(function()
		p1:Stepped()
	end))
end
function t.SetupSprings(p1, p2)
	if p1.Local and (p2 and p2.SpringItemOffset) then
		p1.SpringItemOffset = p2.SpringItemOffset
		p1.SpringItemOffset.Damp = 0.85
		p1.SpringItemOffset.Freq = 8
		p1.SpringItemOffset:SetTarget(p1.Config.Motion.Hip.Springs.ItemOffset)
	else
		p1.SpringItemOffset = Spring.new(p1.Config.Motion.Hip.Springs.ItemOffset, Vector3.new(), 0.85, 8)
	end
	if p1.Local and (p2 and p2.SpringItemRotation) then
		p1.SpringItemRotation = p2.SpringItemRotation
		p1.SpringItemRotation.Damp = 0.85
		p1.SpringItemRotation.Freq = 8
		p1.SpringItemRotation:SetTarget(p1.Config.Motion.Hip.Springs.ItemRotation)
	else
		p1.SpringItemRotation = Spring.new(p1.Config.Motion.Hip.Springs.ItemRotation, Vector3.new(), 0.85, 8)
	end
	if p1.Local and (p2 and p2.SpringNeckRotation) then
		p1.SpringNeckRotation = p2.SpringNeckRotation
		p1.SpringNeckRotation.Damp = 0.85
		p1.SpringNeckRotation.Freq = 8
		p1.SpringNeckRotation:SetTarget(p1.Config.Motion.Hip.Springs.NeckRotation)
	else
		p1.SpringNeckRotation = Spring.new(p1.Config.Motion.Hip.Springs.NeckRotation, Vector3.new(), 0.85, 8)
	end
	if p1.Local and (p2 and p2.SpringWaistRotation) then
		p1.SpringWaistRotation = p2.SpringWaistRotation
		p1.SpringWaistRotation.Damp = 0.85
		p1.SpringWaistRotation.Freq = 8
		p1.SpringWaistRotation:SetTarget(p1.Config.Motion.Hip.Springs.WaistRotation)
	else
		p1.SpringWaistRotation = Spring.new(p1.Config.Motion.Hip.Springs.WaistRotation, Vector3.new(), 0.85, 8)
	end
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
function t.SwingLunge(p1)
	error("TODO: Implement")
end
function t.SwingSwoosh(p1)
	error("TODO: Implement")
end
function t.Heartbeat(p1)
	local v1 = p1.SpringItemOffset:Update()
	local v2 = FromAxisAngle((p1.SpringItemRotation:Update()))
	p1.Motor.C1 = CFrame.new(v1) * v2 * CFrame.new(1.6, 1, -1.5) * p1.JointWaist.C1
	ConstraintUtils.setJointC0(p1.JointWaist, p1.JointWaistC0 * FromAxisAngle((p1.SpringWaistRotation:Update())))
	ConstraintUtils.setJointC0(p1.JointNeck, p1.JointNeckC0 * FromAxisAngle((p1.SpringNeckRotation:Update())))
end
function t.Stepped(p1)
	local IK = p1.IK
	IK.RightArm = p1.Center.CFrame * Vector3.new(0, 0, 0.2)
	R15IKv2.Arms(IK)
	IK.LeftWrist.Transform = CFrame.new()
	IK.RightWrist.Transform = CFrame.Angles(0, -0.3, 0)
end
function t._getLastUse(p1)
	return p1.Model:GetAttribute("LastUse") or 0
end
function t.Swing(p1, p2)
	if p1.IsEquipping then
		return false
	end
	local v1 = workspace:GetServerTimeNow()
	if v1 - p1:_getLastUse() < p1.Config.ReloadTime then
		return false
	end
	p1.Model:SetAttribute("LastUse", v1)
	GunUtils.setLastShotTime(p1.Player, v1)
	if math.random() > 0.8 then
		p1:SwingLunge()
	else
		p1:SwingSwoosh()
	end
	if p1.Local then
		p1:BroadcastInputBegan(p2)
	end
end
function t.ShootBegin(p1, p2)
	p1:Swing(p2)
end
function t.InputBegan(p1, p2, p3)
	if if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonR2 else false then
		p1:ShootBegin(p2)
	end
	Item.InputBegan(p1, p2, p3)
end
function t.InputEnded(p1, p2, p3)  end
return t
