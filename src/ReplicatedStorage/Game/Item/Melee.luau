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
local IDENTITY_CFRAME = CFrame.new()
local function FromAxisAngle(axisAngle)
	local x = axisAngle.x
	local y = axisAngle.y
	local z = axisAngle.z
	local magnitude = (x * x + y * y + z * z) ^ 0.5
	if magnitude > 0.00001 then
		local sinHalf = math.sin(magnitude * 0.5) / magnitude
		return CFrame.new(0, 0, 0, sinHalf * x, sinHalf * y, sinHalf * z, (math.cos(magnitude * 0.5)))
	else
		return IDENTITY_CFRAME
	end
end
local MeleeClass = {
	__ClassName = "Melee"
}
MeleeClass.__index = MeleeClass
setmetatable(MeleeClass, Item)
function MeleeClass.new(self, inventoryItemValue, config, setupInfo)
	local self = Item.new(self, setupInfo)
	setmetatable(self, MeleeClass)
	self.Config = config
	self.inventoryItemValue = inventoryItemValue
	self.JointNeckC0 = self.JointNeck.C0
	self.JointWaistC0 = self.JointWaist.C0
	self.Maid:GiveTask(function()
		ConstraintUtils.setJointC0(self.JointNeck, self.JointNeckC0)
		ConstraintUtils.setJointC0(self.JointWaist, self.JointWaistC0)
	end)
	self.IK = R15IKv2.BuildPacketArms(self.Character)
	self.IsEquipping = false
	self:SetupModel()
	self:AttachModelToPlayer()
	self:SetupSprings(setupInfo)
	self:Equip()
	return self
end
function MeleeClass.Equip(self)
	local equipTime = GunUtils.getEquipTime((InventoryItemUtils.getName(self.inventoryItemValue))) or GunSystemConsts.GUN_EQUIP_TIME
	if GunUtils.getShouldAddEquipTime(self) and equipTime > 0 then
		self.IsEquipping = true
		self:StartReloadProgressCircle(equipTime)
		self.maid:GiveTask(task.delay(equipTime, function()
			self.IsEquipping = false
		end))
	end
	self.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		self:Heartbeat()
	end))
	self.Maid:GiveTask(RunService.Stepped:Connect(function()
		self:Stepped()
	end))
end
function MeleeClass.SetupSprings(self, setupInfo)
	if self.Local and (setupInfo and setupInfo.SpringItemOffset) then
		self.SpringItemOffset = setupInfo.SpringItemOffset
		self.SpringItemOffset.Damp = 0.85
		self.SpringItemOffset.Freq = 8
		self.SpringItemOffset:SetTarget(self.Config.Motion.Hip.Springs.ItemOffset)
	else
		self.SpringItemOffset = Spring.new(self.Config.Motion.Hip.Springs.ItemOffset, Vector3.new(), 0.85, 8)
	end
	if self.Local and (setupInfo and setupInfo.SpringItemRotation) then
		self.SpringItemRotation = setupInfo.SpringItemRotation
		self.SpringItemRotation.Damp = 0.85
		self.SpringItemRotation.Freq = 8
		self.SpringItemRotation:SetTarget(self.Config.Motion.Hip.Springs.ItemRotation)
	else
		self.SpringItemRotation = Spring.new(self.Config.Motion.Hip.Springs.ItemRotation, Vector3.new(), 0.85, 8)
	end
	if self.Local and (setupInfo and setupInfo.SpringNeckRotation) then
		self.SpringNeckRotation = setupInfo.SpringNeckRotation
		self.SpringNeckRotation.Damp = 0.85
		self.SpringNeckRotation.Freq = 8
		self.SpringNeckRotation:SetTarget(self.Config.Motion.Hip.Springs.NeckRotation)
	else
		self.SpringNeckRotation = Spring.new(self.Config.Motion.Hip.Springs.NeckRotation, Vector3.new(), 0.85, 8)
	end
	if self.Local and (setupInfo and setupInfo.SpringWaistRotation) then
		self.SpringWaistRotation = setupInfo.SpringWaistRotation
		self.SpringWaistRotation.Damp = 0.85
		self.SpringWaistRotation.Freq = 8
		self.SpringWaistRotation:SetTarget(self.Config.Motion.Hip.Springs.WaistRotation)
	else
		self.SpringWaistRotation = Spring.new(self.Config.Motion.Hip.Springs.WaistRotation, Vector3.new(), 0.85, 8)
	end
end
function MeleeClass.SetupModel(self)
	local itemName = InventoryItemUtils.getName(self.inventoryItemValue)
	local modelTemplate = ReplicatedStorage.Resource.ItemSystem.Models:FindFirstChild(itemName)
	if modelTemplate == nil then
		error(("Could not find model for item `%s`"):format(itemName))
	end
	local modelClone = modelTemplate:Clone()
	self.Model = modelClone
	local Center = modelClone.Skeleton.Center
	self.Center = Center
	Joint.WeldAllTo(modelClone, Center)
	self.Maid:GiveTask(function()
		self.Model:Destroy()
		self.Model = nil
	end)
end
function MeleeClass.AttachModelToPlayer(self)
	local UpperTorso = self.UpperTorso
	self.Center.CFrame = UpperTorso.CFrame
	local motor = Joint.BlankMotor(self.Center, UpperTorso)
	self.Model.Parent = workspace.Items
	self.Motor = motor
	self.Maid:GiveTask(function()
		self.Motor:Destroy()
		self.Motor = nil
	end)
end
function MeleeClass.SwingLunge(self)
	error("TODO: Implement")
end
function MeleeClass.SwingSwoosh(self)
	error("TODO: Implement")
end
function MeleeClass.Heartbeat(self)
	local springOffset = self.SpringItemOffset:Update()
	local rotationCFrame = FromAxisAngle((self.SpringItemRotation:Update()))
	self.Motor.C1 = CFrame.new(springOffset) * rotationCFrame * CFrame.new(1.6, 1, -1.5) * self.JointWaist.C1
	ConstraintUtils.setJointC0(self.JointWaist, self.JointWaistC0 * FromAxisAngle((self.SpringWaistRotation:Update())))
	ConstraintUtils.setJointC0(self.JointNeck, self.JointNeckC0 * FromAxisAngle((self.SpringNeckRotation:Update())))
end
function MeleeClass.Stepped(self)
	local IK = self.IK
	IK.RightArm = self.Center.CFrame * Vector3.new(0, 0, 0.2)
	R15IKv2.Arms(IK)
	IK.LeftWrist.Transform = CFrame.new()
	IK.RightWrist.Transform = CFrame.Angles(0, -0.3, 0)
end
function MeleeClass._getLastUse(self)
	return self.Model:GetAttribute("LastUse") or 0
end
function MeleeClass.Swing(self, inputKey)
	if self.IsEquipping then
		return false
	end
	local currentTime = workspace:GetServerTimeNow()
	if currentTime - self:_getLastUse() < self.Config.ReloadTime then
		return false
	end
	self.Model:SetAttribute("LastUse", currentTime)
	GunUtils.setLastShotTime(self.Player, currentTime)
	if math.random() > 0.8 then
		self:SwingLunge()
	else
		self:SwingSwoosh()
	end
	if self.Local then
		self:BroadcastInputBegan(inputKey)
	end
end
function MeleeClass.ShootBegin(self, inputKey)
	self:Swing(inputKey)
end
function MeleeClass.InputBegan(self, inputObject, gameProcessed)
	if if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then true elseif inputObject.UserInputType == Enum.UserInputType.Gamepad1 then inputObject.KeyCode == Enum.KeyCode.ButtonR2 else false then
		self:ShootBegin(inputObject)
	end
	Item.InputBegan(self, inputObject, gameProcessed)
end
function MeleeClass.InputEnded(self, inputObject, gameProcessed)  end
return MeleeClass
