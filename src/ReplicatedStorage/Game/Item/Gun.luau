local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local CurrentCamera = workspace.CurrentCamera
local Debris = game:GetService("Debris")
game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HapticEffect = require(ReplicatedStorage.App.HapticEffect)
local Time = require(ReplicatedStorage.Module.Time)
local Joint = require(ReplicatedStorage.Std.Joint)
local R15IKv2 = require(ReplicatedStorage.Module.R15IKv2)
local Spring = require(ReplicatedStorage.Std.Spring)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local Audio = require(ReplicatedStorage.Std.Audio)
local ItemSystem = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
local ItemCamera = require(ReplicatedStorage.Game.ItemSystem.ItemCamera)
local BulletEmitter = require(ReplicatedStorage.Game.ItemSystem.BulletEmitter)
local CrossHair = require(ReplicatedStorage.Game.CrossHair)
local AmmoGui = require(ReplicatedStorage.Game.AmmoGui)
local ItemSkinIds = require(ReplicatedStorage.Game.ItemSkin.ItemSkinIds)
local UI = require(ReplicatedStorage.Game.ItemSkin.UI.UI)
local HomeItemBinder = require(ReplicatedStorage.Home.HomeItem.HomeItemBinder)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local CameraBinder = require(ReplicatedStorage.CCTV.CameraBinder)
local ExplodableBarrelBinder = require(ReplicatedStorage.ExplodableBarrel.ExplodableBarrelBinder)
local ForcefieldConsts = require(ReplicatedStorage.Forcefield.ForcefieldConsts)
local GunUtils = require(ReplicatedStorage.Game.GunShop.GunUtils)
local GameSettingsService = require(ReplicatedStorage.GameSettings.GameSettingsService)
local gameSettingType = require(ReplicatedStorage.GameSettings.gameSettingType)
local ItemDataUtils = require(ReplicatedStorage.App.ItemDataUtils)
local GunSystemConsts = require(ReplicatedStorage.Game.ItemSystem.GunSystemConsts)
local MovementRollService = require(ReplicatedStorage.MovementRoll.MovementRollService)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local DestructibleConsts = require(ReplicatedStorage.Game.Destructible.DestructibleConsts)
local GunShopUtils = require(ReplicatedStorage.Game.GunShop.GunShopUtils)
local AimAssist = require(ReplicatedStorage.Game.ItemSystem.AimAssist)
local ConstraintUtils = require(ReplicatedStorage.Std.ConstraintUtils)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local Interval = require(ReplicatedStorage.Std.Interval)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local Item = require(script.Parent.Item)

local identityCFrame = CFrame.new()

local function FromAxisAngle(axisAngle)
	local x = axisAngle.x
	local y = axisAngle.y
	local z = axisAngle.z
	local magnitude = (x * x + y * y + z * z) ^ 0.5
	if magnitude > 0.00001 then
		local sinHalf = math.sin(magnitude * 0.5) / magnitude
		return CFrame.new(0, 0, 0, sinHalf * x, sinHalf * y, sinHalf * z, (math.cos(magnitude * 0.5)))
	else
		return identityCFrame
	end
end

local function RandomVector()
	local rx = math.random() * 2 - 1
	local ry = math.random() * 2 - 1
	return Vector3.new(rx, ry, math.random() * 2 - 1).Unit
end

local ImpactSoundIds = {
	bullet_impact_bass = 2837091387,
	bullet_impact_metal_light_01 = 2121004076,
	bullet_impact_rock_03 = 2121004325,
	bullet_impact_wood_light_04 = 2121004681
}

local MaterialImpactSoundMap = {
	[Enum.Material.Wood] = ImpactSoundIds.bullet_impact_wood_light_04,
	[Enum.Material.Metal] = ImpactSoundIds.bullet_impact_metal_light_01,
	[Enum.Material.DiamondPlate] = ImpactSoundIds.bullet_impact_metal_light_01,
	[Enum.Material.Slate] = ImpactSoundIds.bullet_impact_rock_03
}

local gunEvent = nil
local mouseMovementRemote = nil
local scopeSensitivity = 1

local Gun = {
	__ClassName = "Gun"
}
Gun.__index = Gun
setmetatable(Gun, Item)

local initialized = false

function Gun.Init(eventBus)
	assert(not initialized, "gun already Init")
	initialized = true
	gunEvent = eventBus.Event
	waitForChild(ReplicatedStorage, "ItemSystemGunMouseMovement"):andThen(function(remote)
		mouseMovementRemote = remote
		remote.OnClientEvent:Connect(function(positionMap)
			for userId, mousePos in positionMap do
				local player = Players:GetPlayerByUserId((tonumber(userId)))
				if player then
					local equippedItem = ItemSystem.GetEquipped(player)
					if equippedItem ~= nil and (equippedItem.Local == false and equippedItem.SetThirdMousePosition) then
						equippedItem:SetThirdMousePosition(mousePos)
					end
				end
			end
		end)
	end)
	function eventBus.em.ssc92uk2(player, isLeaning, isLeaningRight)
		local equippedItem = ItemSystem.GetEquipped(player)
		if equippedItem ~= nil and equippedItem.SetLeaning then
			equippedItem:SetLeaning(isLeaning, isLeaningRight)
		end
	end
	local scopeSensSetting = {
		name = "scopeSens",
		title = "Scope Sensitivity",
		type = gameSettingType.Slider,
		defaultValue = 100,
		order = 210,
		min = 10,
		max = 100,
		step = 1,
		textMap = function(value)
			return ("%d%%"):format(value)
		end
	}
	GameSettingsService.add(scopeSensSetting)
	local function handleSetting(value)
		scopeSensitivity = value / 100
	end
	scopeSensitivity = scopeSensSetting:getValue() / 100
	scopeSensSetting.onChanged:Connect(handleSetting)
end

function Gun.new(itemValue, inventoryItemValue, config)
	local self = Item.new(itemValue, config)
	setmetatable(self, Gun)
	self.inventoryItemValue = inventoryItemValue
	local itemName = InventoryItemUtils.getName(inventoryItemValue)
	local configModule = ReplicatedStorage.Game.ItemConfig:FindFirstChild(itemName)
	if configModule == nil then
		error(("No config file exists for item: %s"):format(itemName))
	end
	self.Config = require(configModule)
	self.LastReplicateMousePosition = tick()
	self.SimulateLocal = false
	self.MinimalFx = false
	return self
end

function Gun.Setup(self, previousSprings)
	self:SetupModel()
	self.IgnoreList = { self.Character, self.Model, workspace.Items }
	if self.Local then
		local localVehicleModel = VehicleUtils.GetLocalVehicleModel()
		if localVehicleModel then
			table.insert(self.IgnoreList, localVehicleModel)
		end
		for _, tagged in CollectionService:GetTagged(DestructibleConsts.SPAWN_TAG_NAME) do
			if tagged:FindFirstChild(DestructibleConsts.INSTANCE_VALUE_NAME) and tagged[DestructibleConsts.INSTANCE_VALUE_NAME].Value then
				table.insert(self.IgnoreList, tagged[DestructibleConsts.INSTANCE_VALUE_NAME].Value)
			end
		end
	end
	self:SetupArmWelds()
	self:SetupTip()
	self:AttachModelToPlayer()
	self:SetupBulletEmitter()
	self:SetupSprings(previousSprings)
	self.IK = R15IKv2.BuildPacketArms(self.Character)
	if self.Local then
		self:SetupCrossHair()
	end
	self:SetupAmmoGui()
	if self.Local then
		local recoilSpring = Spring.new(Vector3.new(), Vector3.new(), 0.6, 75)
		self.SpringCamera = recoilSpring
		ItemCamera.SetRecoilSpring(recoilSpring)
	end
	if not self.Local then
		self.SpringThirdMousePosition = Spring.new(Vector3.new(), Vector3.new(), 0.9, 20)
	end
	self.JointNeckC0 = self.JointNeck.C0
	self.JointWaistC0 = self.JointWaist.C0
	self.IsShooting = false
	self.IsReloading = false
	self.IsEquipping = false
	self.IsScoping = false
	self.IsLeaning = false
	self.IsLeaningRight = false
	self.MousePosition = Vector3.new()
	self._lastUpdateViewDist = 0
	self:SetupShoot()
	self:Equip()
	self.Maid:GiveTask(function()
		ConstraintUtils.setJointC0(self.JointNeck, self.JointNeckC0)
		ConstraintUtils.setJointC0(self.JointWaist, self.JointWaistC0)
	end)
	self.Maid:GiveTask(function()
		self.Motor:Destroy()
		self.Motor = nil
		self.Model:Destroy()
		self.Model = nil
	end)
end

function Gun.SetupShoot(self)
	self.Maid:GiveTask(RxInstanceUtils.observeOneChildNamed(self.inventoryItemValue, GunSystemConsts.SHOOT_REMOTE_NAME, function(shootRemote, maid)
		maid:GiveTask(shootRemote.OnClientEvent:Connect(function()
			self:Shoot()
		end))
	end))
end

function Gun.SetupCrossHair(self)
	self.CrossHair = CrossHair.Make()
	self.CrossHair.Gui.Parent = self.Player.PlayerGui
	self.Maid:GiveTask(function()
		self.CrossHair:Destroy()
		self.CrossHair = nil
	end)
end

function Gun.SetupAmmoGui(self)
	if self.Local then
		local itemName = InventoryItemUtils.getName(self.inventoryItemValue)
		self.AmmoGui = AmmoGui.new(GunShopUtils.getTranslatedTitleFromName(itemName))
		local initialAmmo = InventoryItemUtils.getAttr(self.inventoryItemValue, "AmmoCurrent")
		if initialAmmo then
			InventoryItemUtils.setAttr(self.inventoryItemValue, "AmmoCurrentLocal", initialAmmo)
		end
		local lastAmmoCurrent = 0
		self.Maid:GiveTask(self.inventoryItemValue:GetAttributeChangedSignal("AmmoCurrent"):Connect(function()
			local ammoCurrent = InventoryItemUtils.getAttr(self.inventoryItemValue, "AmmoCurrent")
			if lastAmmoCurrent < ammoCurrent then
				InventoryItemUtils.setAttr(self.inventoryItemValue, "AmmoCurrentLocal", ammoCurrent)
			end
			lastAmmoCurrent = ammoCurrent
		end))
		local function updateAmmo()
			local ammoCurrentLocal = InventoryItemUtils.getAttr(self.inventoryItemValue, "AmmoCurrentLocal") or 0
			local itemConfig = ItemDataUtils.getConfig(itemName)
			self.AmmoGui:Update(ammoCurrentLocal, if itemConfig and itemConfig.MagSize then itemConfig.MagSize else nil)
		end
		self.Maid:GiveTask(self.inventoryItemValue:GetAttributeChangedSignal("AmmoCurrentLocal"):Connect(updateAmmo))
		self.Maid:GiveTask(self.inventoryItemValue:GetAttributeChangedSignal("AmmoLeft"):Connect(updateAmmo))
		local ammoCurrentLocal = InventoryItemUtils.getAttr(self.inventoryItemValue, "AmmoCurrentLocal") or 0
		local itemConfig = ItemDataUtils.getConfig(itemName)
		self.AmmoGui:Update(ammoCurrentLocal, if itemConfig and itemConfig.MagSize then itemConfig.MagSize else nil)
		local boundingBox = self.Model and self.Model:FindFirstChild("BoundingBox", true)
		self.Maid:GiveTask(RunService.Heartbeat:Connect(function(dt)
			if boundingBox then
				self.AmmoGui:UpdatePosition(boundingBox, dt)
			end
		end))
		self.Maid:GiveTask(function()
			self.AmmoGui:Destroy()
			self.AmmoGui = nil
		end)
	end
end

function Gun.SetupModel(self, modelName)
	if modelName == nil then
		modelName = InventoryItemUtils.getName(self.inventoryItemValue)
	end
	local modelTemplate = ReplicatedStorage.Resource.ItemSystem.Models:FindFirstChild(modelName)
	if modelTemplate == nil then
		error(("Could not find model for item `%s`"):format(modelName))
	end
	local modelClone = modelTemplate:Clone()
	for _, desc in modelClone:GetDescendants() do
		if desc:IsA("BasePart") then
			desc.CanCollide = false
			desc.CanQuery = false
			desc.CanTouch = false
		end
	end
	self.Model = modelClone
	local BoundingBox = modelClone.Skeleton.BoundingBox
	self.BoundingBox = BoundingBox
	Joint.WeldAllTo(modelClone.Model, BoundingBox)
	if self.ApplySkin then
		local function updateSkin()
			self:ApplySkinLocal(self.inventoryItemValue:GetAttribute("SkinName"))
		end
		self.Maid:GiveTask(self.inventoryItemValue:GetAttributeChangedSignal("SkinName"):Connect(updateSkin))
		self:ApplySkinLocal(self.inventoryItemValue:GetAttribute("SkinName"))
	end
end

function Gun.SetupTip(self)
	local Tip = self.Model.Skeleton.Tip
	self.Tip = Tip
	self.TipOffset = self.BoundingBox.CFrame:PointToObjectSpace(Tip.Position)
	Joint.Weld(self.Model.Skeleton.Tip, self.BoundingBox)
	self.Model.Skeleton.Tip.Anchored = false
end

function Gun.SetupArmWelds(self)
	Joint.Weld(self.Model.Skeleton.LeftArm, self.BoundingBox)
	Joint.Weld(self.Model.Skeleton.RightArm, self.BoundingBox)
	self.Model.Skeleton.LeftArm.Anchored = false
	self.Model.Skeleton.RightArm.Anchored = false
end

function Gun.ApplySkinLocal(self, skinName)
	local textureId
	if skinName == nil or skinName == "None" then
		textureId = ""
	else
		local skinEntry = ItemSkinIds[skinName]
		if skinEntry == nil then
			error(("No skin by name of %s exists."):format(skinName))
		end
		local skinImageId = skinEntry[self.__ClassName]
		if skinImageId == nil then
			error(("Skin %s has no image id for item: %s"):format(skinName, self.__ClassName))
		end
		textureId = ("rbxassetid://%d"):format(skinImageId)
	end
	for _, desc in self.Model:GetDescendants() do
		if desc:IsA("MeshPart") and desc:GetAttribute("ApplyGunTexture") == true then
			desc.TextureID = textureId
		end
	end
end

function Gun.ApplySkin(self, skinName)
	if self.Local then
		gunEvent:FireServer("cvro44st", self.inventoryItemValue, skinName)
	end
end

function Gun.AttachModelToPlayer(self)
	local UpperTorso = self.UpperTorso
	self.BoundingBox.CFrame = UpperTorso.CFrame
	local motor = Joint.BlankMotor6D(self.BoundingBox, UpperTorso)
	self.Model.Parent = workspace.Items
	self.Motor = motor
end

function Gun.BulletEmitterOnLocalHitPlayer(self, hitPart, encoded1, encoded2, encoded3, encoded4, encoded5, encoded6, encoded7, encoded8, encoded9, encoded10, encoded11, encoded12, hitInfo)
	local now = Time.GetNowSync()
	self.inventoryItemValue:FindFirstChild(GunSystemConsts.DAMAGE_REMOTE_NAME):FireServer(hitPart, encoded1, encoded2, encoded3, encoded4 - 0.6609848067581097 * now, encoded5, encoded6, encoded7 + 0.3968011188544949 * now, encoded8, encoded9, encoded10, encoded11, encoded12 + 0.6369049829533174 * now, hitInfo)
	if self.CrossHair then
		self.CrossHair:Flare()
	end
	if not self.MinimalFx then
		Audio.ObjectLocal(self.Tip, ImpactSoundIds.bullet_impact_bass, {
			TimePosition = 0,
			Volume = 1,
			Pitch = 1
		})
	end
end

function Gun.BulletEmitterShieldDamage(self, shield)
	if self.Local then
		ReplicatedStorage.Forcefield:FindFirstChild(ForcefieldConsts.DAMAGE_REMOTE_NAME):FireServer(shield.Id, self.__ClassName)
	end
end

function Gun.SetupBulletEmitter(self)
	self.LastImpactSound = 0
	self.LastImpact = 0
	self.BulletEmitter = BulletEmitter.new(self.Local)
	self.BulletEmitter.IgnoreList = assert(self.IgnoreList)
	self.BulletEmitter.LifeSpan = 1
	self.BulletEmitter.GravityVector = (self.Config.GravityMultiplier or 1) * Vector3.new(0, -workspace.Gravity / 10, 0)
	local BulletEmitterOnLocalHitPlayer = self.BulletEmitterOnLocalHitPlayer
	self.BulletEmitter.OnLocalHitPlayer:Connect(function(...)
		BulletEmitterOnLocalHitPlayer(self, ...)
	end)
	local BulletEmitterShieldDamage = self.BulletEmitterShieldDamage
	self.BulletEmitter.OnShieldDamage:Connect(function(...)
		BulletEmitterShieldDamage(self, ...)
	end)
	self.BulletEmitter.OnHitSurface:Connect(function(hitPart, hitPosition, hitNormal, hitMaterial)
		local now = tick()
		if not self.MinimalFx then
			local Part = Instance.new("Part")
			Part.Color = hitPart.Color
			Part.Massless = true
			Part.Size = Vector3.new(0.5, 0.5, 0.1)
			Part.Anchored = false
			Part.CanCollide = false
			Part.Transparency = 1
			Part.CFrame = CFrame.new(Vector3.new(), hitNormal) * CFrame.Angles(0, 0, math.random() * math.pi * 2) + hitPosition
			local Decal = Instance.new("Decal")
			Decal.Texture = "rbxassetid://2078626"
			Decal.Color3 = hitPart.Color
			Decal.Face = Enum.NormalId.Front
			Decal.Parent = Part
			Joint.Weld(Part, hitPart)
			Part.Parent = workspace.Items
			Debris:AddItem(Part, 2)
			if self.Local and now - self.LastImpactSound > 0.03 then
				local impactSoundId = MaterialImpactSoundMap[hitMaterial]
				if impactSoundId ~= nil then
					self.LastImpactSound = now
					Audio.ObjectLocal(Part, impactSoundId, {
						Volume = 0.4
					})
				end
			end
			local debrisEmitter = ReplicatedStorage.Resource.ItemSystem.Projectiles.Debris:Clone()
			debrisEmitter.EmissionDirection = Enum.NormalId.Front
			debrisEmitter.Size = NumberSequence.new(0.1)
			debrisEmitter.SpreadAngle = Vector2.new(15, 15)
			debrisEmitter.Parent = Part
			debrisEmitter:Emit(3)
		end
		if self.Local and now - self.LastImpact > 0.1 then
			self.LastImpact = now
			if hitPart:IsDescendantOf(workspace.Vehicles) then
				local current = hitPart
				loopCount = 0
				repeat
					current = current.Parent
					loopCount = loopCount + 1
					if current ~= nil and current:FindFirstChild("BoundingBox") then
						break
					end
				until loopCount >= 5
				local vehicleBoundingBox = if current == nil then false else current:FindFirstChild("BoundingBox")
				if vehicleBoundingBox then
					gunEvent:FireServer("uw4j5uqm", vehicleBoundingBox.Parent, self.__ClassName)
				end
			end
			if hitPart.Name == "ShootingRangePart" then
				Audio.ObjectLocal(hitPart, 737592495, {
					Volume = 1,
					Pitch = 2 + math.random() * 0.2,
					EmitterSize = 15
				})
				Audio.ObjectLocal(hitPart, 690530166, {
					MaxPlaybackTime = 0.8
				})
				return
			end
			if workspace:FindFirstChild("Museum") and hitPart:IsDescendantOf(workspace.Museum) then
				gunEvent:FireServer("s1bqgxg1", hitPart)
				return
			end
			local current = hitPart
			while true do
				local homeItem = HomeItemBinder:Get(current)
				if homeItem then
					homeItem:Damage()
					return
				end
				local camera = CameraBinder:Get(current)
				if camera then
					camera:Damage()
					return
				end
				local explodableBarrel = ExplodableBarrelBinder:Get(current)
				if explodableBarrel then
					gunEvent:FireServer("s1bqgxg1", explodableBarrel.obj, self.__ClassName)
					return
				end
				current = current.Parent
				local _ = current == workspace
			end
		end
	end)
	local heartbeatConnection = RunService.Heartbeat:Connect(function()
		debug.profilebegin("Gun Bullet Emitter Update")
		self.BulletEmitter:Update()
		debug.profileend()
	end)
	self.Maid:GiveTask(function()
		if #self.BulletEmitter.Bullets > 0 then
			self.BulletEmitter.OnQueueEmptied:Connect(function()
				heartbeatConnection:Disconnect()
				heartbeatConnection = nil
				self.BulletEmitter:Destroy()
			end)
		else
			heartbeatConnection:Disconnect()
			heartbeatConnection = nil
			self.BulletEmitter:Destroy()
		end
	end)
end

function Gun.SetupSprings(self, previousSprings)
	if self.Local and (previousSprings and previousSprings.SpringItemOffset) then
		self.SpringItemOffset = previousSprings.SpringItemOffset
		self.SpringItemOffset.Damp = 0.7
		self.SpringItemOffset.Freq = 50
		self.SpringItemOffset:SetTarget(self.Config.Motion.Hip.Springs.ItemOffset)
	else
		self.SpringItemOffset = Spring.new(self.Config.Motion.Hip.Springs.ItemOffset, Vector3.new(), 0.7, 50)
	end
	if self.Local and (previousSprings and previousSprings.SpringItemRotation) then
		self.SpringItemRotation = previousSprings.SpringItemRotation
		self.SpringItemRotation.Damp = 0.9
		self.SpringItemRotation.Freq = 25
		self.SpringItemRotation:SetTarget(self.Config.Motion.Hip.Springs.ItemRotation)
	else
		self.SpringItemRotation = Spring.new(self.Config.Motion.Hip.Springs.ItemRotation, Vector3.new(), 0.9, 25)
	end
	if self.Local and (previousSprings and previousSprings.SpringNeckRotation) then
		self.SpringNeckRotation = previousSprings.SpringNeckRotation
		self.SpringNeckRotation.Damp = 0.9
		self.SpringNeckRotation.Freq = 25
		self.SpringNeckRotation:SetTarget(self.Config.Motion.Hip.Springs.NeckRotation)
	else
		self.SpringNeckRotation = Spring.new(self.Config.Motion.Hip.Springs.NeckRotation, Vector3.new(), 0.9, 25)
	end
end

function Gun.UpdateItemSprings(self)
	local offsetPosition = self.SpringItemOffset:Update()
	local rotationPosition, rotationVelocity = self.SpringItemRotation:Update()
	local rotationCFrame = FromAxisAngle(rotationPosition)
	local rotationVelocityCFrame = FromAxisAngle(rotationVelocity * 0.01)
	self.ItemOffsetPosition = offsetPosition
	self.ItemRotationCFrame = rotationCFrame
	self.ItemRotationVelocityCFrame = rotationVelocityCFrame
end

function Gun.UpdateItemJoints(self) end

function Gun.ApplyItemJointsC1(self)
	if self.Motor then
		self.Motor.C1 = self.ItemRotationCFrame * CFrame.new(self.ItemOffsetPosition) * self.JointWaist.C1
	end
end

function Gun.ApplyItemJointsTransform(self)
	if self.Motor then
		self.Motor.Transform = (self.ItemRotationCFrame * CFrame.new(self.ItemOffsetPosition) * self.JointWaist.C1):Inverse()
	end
end

function Gun.UpdateBodySprings(self)
	self.NeckRotationPosition = self.SpringNeckRotation:Update()
end

function Gun.UpdateMousePosition(self)
	local now = tick()
	local mousePos = if self.Local then self:ProjectMouseLocationToWorld((self:GetMouseLocation())) else self.SpringThirdMousePosition:Update()
	self.MousePosition = mousePos
	if self.Local and (mouseMovementRemote and now - self.LastReplicateMousePosition > 0.25) then
		self.LastReplicateMousePosition = now
		mouseMovementRemote:FireServer(mousePos)
	end
end

function Gun.ComputeBodyJoints(self)
	local JointRoot = self.JointRoot
	local JointWaist = self.JointWaist
	self.JointWaist.Transform = CFrame.new()
	self.JointNeck.Transform = CFrame.new()
	local localMouseDir = (self.RootPart.CFrame * JointRoot.C0 * JointRoot.Transform * JointRoot.C1:Inverse() * self.JointWaistC0 * JointWaist.Transform):PointToObjectSpace(self.MousePosition)
	local tipOffset = self.ItemRotationCFrame:Inverse() * JointWaist.C1:Inverse() * self.ItemRotationCFrame * CFrame.new(self.ItemOffsetPosition + self.TipOffset) * JointWaist.C1
	local yawAngle, pitchAngle = GeomUtils.offsetLookAtTarget(tipOffset.x, tipOffset.y, tipOffset.z, localMouseDir.x, localMouseDir.y, localMouseDir.z)
	if pitchAngle < -1.382300767579509 then
		pitchAngle = -1.382300767579509
	end
	self.JointWaistTransform = CFrame.Angles(0, yawAngle, 0) * CFrame.Angles(pitchAngle, 0, 0) * self.ItemRotationCFrame:inverse()
	self.JointNeckTransform = self.ItemRotationCFrame * FromAxisAngle(self.NeckRotationPosition) * self.ItemRotationVelocityCFrame
end

function Gun.ApplyBodyJointsC1(self)
	if self.JointWaistTransform then
		ConstraintUtils.setJointC0(self.JointWaist, self.JointWaistC0 * self.JointWaistTransform)
		ConstraintUtils.setJointC0(self.JointNeck, self.JointNeckC0 * self.JointNeckTransform)
	end
end

function Gun.ApplyBodyJointsTransform(self)
	if self.JointWaistTransform then
		self.JointWaist.Transform = self.JointWaistTransform
		self.JointNeck.Transform = self.JointNeckTransform
	end
end

function Gun.ClearBodyTransform(self)
	self.JointWaist.Transform = CFrame.new()
	self.JointNeck.Transform = CFrame.new()
end

function Gun.UpdateArmIK(self)
	local IK = self.IK
	local Model = self.Model
	IK.RightArm = Model.Skeleton.RightArm.Position
	IK.LeftArm = Model.Skeleton.LeftArm.Position
	IK.RightAngle = self.Config.Motion.RightElbowAngle
	IK.LeftAngle = self.Config.Motion.LeftElbowAngle
end

function Gun.ComputeArmJoints(self)
	if self.Model:IsDescendantOf(workspace) then
		if self.Character.PrimaryPart then
			self:UpdateArmIK()
			R15IKv2.ComputeArms(self.IK)
		end
	end
end

function Gun.ApplyArmJoints(self)
	local IK = self.IK
	R15IKv2.ApplyArms(IK)
	if self.Config.Motion.RightWristRotation then
		IK.RightWrist.Transform = self.Config.Motion.RightWristRotation
	end
	if self.Config.Motion.LeftWristRotation then
		IK.LeftWrist.Transform = self.Config.Motion.LeftWristRotation
	end
end

function Gun.ReloadDropAmmoVisual(self)
	local Ammo = self.Model.Model:FindFirstChild("Ammo")
	if Ammo then
		local droppedAmmo = Ammo:Clone()
		droppedAmmo:ClearAllChildren()
		droppedAmmo.CFrame = Ammo.CFrame
		droppedAmmo.CanCollide = true
		droppedAmmo.CollisionGroup = "NoCollide"
		droppedAmmo.Velocity = Vector3.new(0, -20, 0)
		droppedAmmo.Parent = workspace
		Debris:AddItem(droppedAmmo, 6)
		Ammo.Transparency = 1
	end
end

function Gun.ReloadRefillAmmoVisual(self)
	local Ammo = self.Model.Model:FindFirstChild("Ammo")
	if Ammo then
		Ammo.Transparency = 0
	end
end

function Gun.ReloadDropAmmoSound(self)
	error("TODO: Implement")
end

function Gun.ReloadRefillAmmoSound(self)
	error("TODO: Implement")
end

function Gun._reloadBroadcast(self)
	local reloadRemote = self.inventoryItemValue:FindFirstChild(GunSystemConsts.RELOAD_REMOTE_NAME)
	if reloadRemote then
		reloadRemote:FireServer()
	end
end

function Gun.ReloadLocal(self, reloadTime)
	self:StartReloadProgressCircle()
	return true
end

function Gun.ReloadAnyone(self)
	self:ReloadDropAmmoVisual()
	self:ReloadDropAmmoSound()
	task.delay(self.Config.ReloadTime - (self.Config.LocalReloadOffset or 0), function()
		if self.Destroyed then
			return false
		else
			self:ReloadRefillAmmoVisual()
			if self.Destroyed then
				return false
			else
				self:ReloadRefillAmmoSound()
				return not self.Destroyed
			end
		end
	end)
end

function Gun._checkReloadCondition(self)
	if self.IsReloading or self.Local and self.inventoryItemValue:GetAttribute("IsReloading") then
		return false
	else
		return not (self:GetAmmoLeft() <= 0)
	end
end

function Gun.Reload(self)
	if self:_checkReloadCondition() then
		self.IsReloading = true
		task.delay(self.Config.ReloadTime, function()
			if self.Destroyed then
				return false
			else
				self.IsReloading = false
				return true
			end
		end)
		if self.Local or self.SimulateLocal then
			self:_reloadBroadcast()
		end
		if self.Local then
			self:ReloadLocal()
		end
		self:ReloadAnyone()
		return true
	else
		return false
	end
end

function Gun.GetAmmoLeft(self)
	return InventoryItemUtils.getAttr(self.inventoryItemValue, "AmmoLeft") or (1 / 0)
end

function Gun.ShootCheckConditions(self)
	local Tip = self.Tip
	if not (self.IsReloading or (self.IsEquipping or (self.BlockFire or self.inventoryItemValue:GetAttribute("IsReloading")))) then
		if self.Local then
			if InventoryItemUtils.getAttr(self.inventoryItemValue, "AmmoCurrentLocal") <= 0 then
				self:ShootSound(true)
				if self.IsReloading == false then
					self:InputBegan({
						UserInputType = Enum.UserInputType.Keyboard,
						KeyCode = Enum.KeyCode.R
					})
				end
			elseif Tip then
				local Position = self.RootPart.Position
				local tipDelta = Tip.Position - Position
				local _, hitPos = RayCast.RayIgnoreNonCollideWithIgnoreList(Position, tipDelta.Unit, tipDelta.Magnitude, self.IgnoreList, nil, nil, self._customCollideFunc)
				if (hitPos - Tip.Position).Magnitude > 0.1 then
					return false
				else
					return self:CheckNextShotPossible() and true or false
				end
			else
				return self:CheckNextShotPossible() and true or false
			end
		else
			return self:CheckNextShotPossible() and true or false
		end
	end
	return false
end

function Gun.CheckNextShotPossible(self)
	local serverTime = workspace:GetServerTimeNow()
	local nextShotTime = GunUtils.getNextShotPossible(self.Player)
	return not (nextShotTime and serverTime < nextShotTime)
end

function Gun.SetNextShotPossible(self)
	local FireFreq = self.Config.FireFreq
	local Player = self.Player
	local serverTime = workspace:GetServerTimeNow()
	GunUtils.setLastShotTime(Player, serverTime)
	if FireFreq then
		GunUtils.setNextShotPossible(Player, serverTime + 1 / FireFreq)
		return true
	else
		warn("No FireFreq")
		return false
	end
end

function Gun.ShootLocal(self)
	if self.Local then
		HapticEffect.basic(0.2, 0.25)
		local scopeMultiplier = if self.IsScoping then 0.3 else 1
		self.SpringCamera:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 0.15 * self.Config.CamShakeMagnitude * scopeMultiplier)
		self.CrossHair.Spring:Accelerate(600 * if self.IsScoping then 0.3 else 1)
		return true
	else
		return false
	end
end

function Gun.ShootOther(self)
	self.SpringItemOffset:Accelerate(Vector3.new(0, 0, 50) + Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 3)
	self.SpringItemRotation:Accelerate((Vector3.new(-1, 2, 0)).Unit * 12 + Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 2)
	local tipCFrame = self.Tip.CFrame
	local TipDirection = self.TipDirection
	if TipDirection then
		local function getLocalBulletDirection()
			return GunUtils.getBulletDirection(tipCFrame, TipDirection, (self.BulletSpread or 0) + (self.Config.BulletSpread or 0))
		end
		if self.Config.BulletsPerShot then
			for i = 1, self.Config.BulletsPerShot do
				self.BulletEmitter:Emit(tipCFrame.Position, GunUtils.getBulletDirection(tipCFrame, TipDirection, (self.BulletSpread or 0) + (self.Config.BulletSpread or 0)), self.Config.BulletSpeed)
			end
		else
			self.BulletEmitter:Emit(tipCFrame.Position, GunUtils.getBulletDirection(tipCFrame, TipDirection, (self.BulletSpread or 0) + (self.Config.BulletSpread or 0)), self.Config.BulletSpeed)
		end
		return true
	end
end

function Gun.ShootFx(self)
	local Tip = self.Tip
	if Tip then
		local _ = ({
			Flintlock = 1,
			NerfRevolver = 20,
			Revolver = 20,
			Shotgun = 20,
			Sniper = 3
		})[self.__ClassName]
		local ParticleEmitter = Tip:FindFirstChild("ParticleEmitter")
		if ParticleEmitter then
			ParticleEmitter:Emit(1)
		end
		local ParticleEmitterFlash = Tip:FindFirstChild("ParticleEmitterFlash")
		if ParticleEmitterFlash then
			ParticleEmitterFlash:Emit(1)
		end
		local PointLight = Tip:FindFirstChild("PointLight", true)
		if PointLight then
			PointLight.Enabled = true
			task.delay(0.1, function()
				PointLight.Enabled = false
			end)
		end
	end
end

function Gun.Shoot(self)
	self:ShootLocal()
	self:ShootOther()
	self:ShootSound(false)
	self:ShootFx()
	return true
end

function Gun.ShootSound(self, isEmpty)
	error("TODO: Implement")
end

function Gun._attemptShoot(self)
	if self:ShootCheckConditions() then
		if self.PreFireFunc then
			self:PreFireFunc()
			if self.Destroyed or not self:ShootCheckConditions() then
				return false
			else
				self:DecrementAmmo()
				self:SetNextShotPossible()
				if self.Local or self.SimulateLocal then
					self:_shootBroadcast()
				end
				self:Shoot()
				return true
			end
		else
			self:DecrementAmmo()
			self:SetNextShotPossible()
			if self.Local or self.SimulateLocal then
				self:_shootBroadcast()
			end
			self:Shoot()
			return true
		end
	else
		return false
	end
end

function Gun._startReloading(self)
	if self.IsReloading == false then
		self:InputBegan({
			UserInputType = Enum.UserInputType.Keyboard,
			KeyCode = Enum.KeyCode.R
		})
	end
end

function Gun.DecrementAmmo(self)
	if self.Local or self.SimulateLocal then
		local newAmmo = InventoryItemUtils.getAttr(self.inventoryItemValue, "AmmoCurrent") - 1
		InventoryItemUtils.setAttr(self.inventoryItemValue, "AmmoCurrentLocal", newAmmo)
		if newAmmo <= 0 then
			self:_startReloading()
		end
		return true
	else
		return false
	end
end

function Gun._shootBroadcast(self)
	local shootRemote = self.inventoryItemValue:FindFirstChild(GunSystemConsts.SHOOT_REMOTE_NAME)
	if shootRemote then
		shootRemote:FireServer()
	end
end

function Gun.UpdateCrossHair(self)
	if self.CrossHair then
		self.CrossHair:Update(self:GetMouseLocation())
	end
end

function Gun.RenderStepped(self)
	if self.Local then
		self:UpdateCrossHair()
	end
	debug.profilebegin("UpdateMousePosition")
	self:UpdateMousePosition()
	debug.profileend()
	debug.profilebegin("UpdateItemSprings")
	self:UpdateItemSprings()
	debug.profileend()
	debug.profilebegin("UpdateBodySprings")
	self:UpdateBodySprings()
	debug.profileend()
	debug.profilebegin("ComputeBodyJoints")
	self:ComputeBodyJoints()
	debug.profileend()
	if self.Local then
		if not MovementRollService.isPlayerRolling(self.Player) then
			debug.profilebegin("ApplyBodyJoints")
			self:ApplyBodyJointsC1()
			debug.profileend()
		end
		debug.profilebegin("ApplyItemJoints")
		self:ApplyItemJointsC1()
		debug.profileend()
	end
	self:UpdateItemJoints()
	debug.profilebegin("ComputeArmJoints")
	self:ComputeArmJoints()
	debug.profileend()
	local Tip = self.Tip
	if Tip ~= nil then
		self.TipDirection = Tip.CFrame.LookVector
	end
	if (self.Local or self.SimulateLocal) and self.IsShooting == true then
		self:_attemptShoot()
	end
end

function Gun.Stepped(self)
	self:ClearBodyTransform()
	if not self.Local then
		debug.profilebegin("ApplyBodyJoints")
		self:ApplyBodyJointsTransform()
		debug.profileend()
		debug.profilebegin("ApplyItemJoints")
		self:ApplyItemJointsTransform()
		debug.profileend()
	end
	self:ApplyArmJoints()
end

function Gun.ShootBegin(self, input)
	if self.Config.FireAuto or InputUtils.isTouch() and self.Config.FireAutoMobile then
		self.IsShooting = true
	else
		self:_attemptShoot()
	end
end

function Gun.ShootEnd(self, input)
	if self.IsShooting == true then
		self.IsShooting = false
	end
end

function Gun.LocalScopeChanged(self)
	if AimAssist.canAimAssist() then
		local maid = self.maid
		local function finishedCallback()
			maid.aimAssistMaid = nil
		end
		if self.IsScoping then
			maid.aimAssistMaid = AimAssist.aimAssist(self, finishedCallback)
			maid.aimAssistScan = Interval.every(0.25):Connect(function()
				if maid.aimAssistMaid == nil then
					maid.aimAssistMaid = AimAssist.aimAssist(self, finishedCallback)
				end
			end)
			return
		end
		maid.aimAssistMaid = nil
		maid.aimAssistScan = nil
	end
end

function Gun.ScopeBegin(self)
	if self.IsLeaning or (VehicleUtils.GetLocalVehiclePacket() or self.IsScoping) then
		return false
	else
		self.SpringItemOffset:SetTarget(self.Config.Motion.Scope.Springs.ItemOffset)
		self.SpringItemRotation:SetTarget(self.Config.Motion.Scope.Springs.ItemRotation)
		self.SpringNeckRotation:SetTarget(self.Config.Motion.Scope.Springs.NeckRotation)
		if self.Local then
			ItemCamera.Zoom(self.Config.Motion.Scope.FOV or 50)
			self.CrossHair:ADS(true)
			if math.abs(scopeSensitivity - 1) > 0.001 then
				ItemCamera.setSensitivity(scopeSensitivity)
			end
		end
		self.IsScoping = true
		if self.Local then
			self:LocalScopeChanged()
		end
		return true
	end
end

function Gun.ScopeEnd(self)
	if self.IsLeaning then
		return false
	elseif self.IsScoping then
		self.SpringItemOffset:SetTarget(self.Config.Motion.Hip.Springs.ItemOffset)
		self.SpringItemRotation:SetTarget(self.Config.Motion.Hip.Springs.ItemRotation)
		self.SpringNeckRotation:SetTarget(self.Config.Motion.Hip.Springs.NeckRotation)
		if self.Local then
			ItemCamera.Zoom(70)
			self.CrossHair:ADS(false)
			ItemCamera.setSensitivity(1)
		end
		self.IsScoping = false
		if self.Local then
			self:LocalScopeChanged()
		end
		return true
	else
		return false
	end
end

function Gun.SetLeaning(self, isLeaning, isLeaningRight)
	self.IsLeaning = isLeaning
	self.IsLeaningRight = isLeaningRight
	if self.IsLeaning then
		if self.IsLeaningRight == true then
			self.SpringItemOffset:SetTarget(Vector3.new(0.9, 1, -1.9))
			self.SpringItemRotation:SetTarget(Vector3.new(0.2, 0, 0.6))
			self.SpringNeckRotation:SetTarget(Vector3.new(0, 0, -0.5))
		else
			self.SpringItemOffset:SetTarget(Vector3.new(-0.6, 1, -1.9))
			self.SpringItemRotation:SetTarget(Vector3.new(0.2, 0, -0.6))
			self.SpringNeckRotation:SetTarget(Vector3.new(0, 0, 0.5))
		end
	else
		self.SpringItemOffset:SetTarget(self.Config.Motion.Hip.Springs.ItemOffset)
		self.SpringItemRotation:SetTarget(self.Config.Motion.Hip.Springs.ItemRotation)
		self.SpringNeckRotation:SetTarget(self.Config.Motion.Hip.Springs.NeckRotation)
	end
	if self.Local then
		gunEvent:FireServer("ssc92uk2", isLeaning, isLeaningRight)
	end
end

function Gun.InputBegan(self, input, gameProcessed)
	if gameProcessed then
		return false
	end
	local isShoot = if input.UserInputType == Enum.UserInputType.MouseButton1 then true elseif input.UserInputType == Enum.UserInputType.Gamepad1 then input.KeyCode == Enum.KeyCode.ButtonR2 else false
	local isScope = input.UserInputType == Enum.UserInputType.MouseButton2
	local isReload = if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.R then true elseif input.UserInputType == Enum.UserInputType.Gamepad1 then input.KeyCode == Enum.KeyCode.ButtonX else false
	local isSkinToggleKey = if input.UserInputType == Enum.UserInputType.Keyboard then input.KeyCode == Enum.KeyCode.V else false
	local isSkinToggleFlag = if type(input) == "table" then input.FlagToggleSkins ~= nil else false
	if isShoot then
		self:ShootBegin(input)
	elseif isScope and self.ScopeBegin then
		self:ScopeBegin()
		if self.Local then
			self:BroadcastInputBegan(input)
		end
	elseif isReload and self.Reload then
		task.spawn(self.Reload, self)
		if self.Local then
			self:BroadcastInputBegan(input)
		end
	elseif isSkinToggleKey then
		if UI.IsOpen == false then
			Item.InputBegan(self, input, gameProcessed)
		end
	elseif isSkinToggleFlag and UI.IsOpen == false then
		UI.Open()
		self.CrossHair:Disable()
		if ItemCamera.Locked == true then
			ItemCamera.setLocked(false)
			function self.Maid.undoCameraLock()
				ItemCamera.setLocked(true)
			end
		end
	elseif isSkinToggleFlag then
		UI.Close()
		self.CrossHair:Enable()
		self.Maid.undoCameraLock = nil
	end
end

function Gun.InputEnded(self, input, gameProcessed)
	if gameProcessed then
		return false
	end
	local isShoot = if input.UserInputType == Enum.UserInputType.MouseButton1 then true elseif input.UserInputType == Enum.UserInputType.Gamepad1 then input.KeyCode == Enum.KeyCode.ButtonR2 else false
	local isScope = input.UserInputType == Enum.UserInputType.MouseButton2
	if isShoot then
		self:ShootEnd(input)
	elseif isScope and self.ScopeEnd then
		self:ScopeEnd()
		if self.Local then
			self:BroadcastInputEnded(input)
		end
	end
end

function Gun.SetThirdMousePosition(self, position)
	self.SpringThirdMousePosition:SetTarget(position)
end

function Gun._getUncachedViewDist(self)
	return (self.RootPart.Position - CurrentCamera.CFrame.Position).Magnitude
end

function Gun._getViewDist(self)
	local now = os.clock()
	if now - self._lastUpdateViewDist > 0.1 then
		self._lastUpdateViewDist = now
		local dist = self:_getUncachedViewDist()
		self._viewDist = dist
		return dist
	else
		return self._viewDist
	end
end

function Gun._getUpdateRate(self, maxDist)
	if self.Model:IsDescendantOf(workspace) then
		local threshold = maxDist or 512
		local dist = self:_getViewDist()
		if dist < threshold then
			return 0
		else
			return (dist - threshold) / (1024 - threshold)
		end
	else
		return 1
	end
end

function Gun.Equip(self)
	self:RenderStepped()
	self:Stepped()
	local equipTime = GunUtils.getEquipTime((InventoryItemUtils.getName(self.inventoryItemValue))) or GunSystemConsts.GUN_EQUIP_TIME
	if GunUtils.getShouldAddEquipTime(self) and equipTime > 0 then
		if InventoryItemUtils.getAttr(self.inventoryItemValue, "AmmoCurrent") <= 0 then
			self.maid:GiveTask(task.defer(function()
				self:_startReloading()
			end))
		else
			self.IsEquipping = true
			self:StartReloadProgressCircle(equipTime)
			self.maid:GiveTask(task.delay(equipTime, function()
				self.IsEquipping = false
			end))
		end
	end
	self.maid:GiveTask(function()
		local Player = self.Player
		if Player and Player.SetAttribute then
			GunUtils.setNextShotPossible(Player, nil)
		end
	end)
	local lastRenderTime = 0
	if self.Local then
		self.Maid:GiveTask(RunService.RenderStepped:Connect(function()
			if not self.Destroyed then
				local now = os.clock()
				if now - lastRenderTime > self:_getUpdateRate() then
					lastRenderTime = now
					debug.profilebegin("Gun RenderStepped")
					self:RenderStepped()
					debug.profileend()
				end
			end
		end))
	else
		self.Maid:GiveTask(RunService.Heartbeat:Connect(function()
			if not self.Destroyed then
				local now = os.clock()
				if now - lastRenderTime > self:_getUpdateRate() then
					lastRenderTime = now
					debug.profilebegin("Gun RenderStepped")
					self:RenderStepped()
					debug.profileend()
				end
			end
		end))
	end
	local lastSteppedTime = 0
	self.Maid:GiveTask(RunService.Stepped:Connect(function()
		if not self.Destroyed then
			local now = os.clock()
			local updateRate = self:_getUpdateRate()
			if self.Local or self.SimulateLocal then
				updateRate = 0
			end
			if updateRate < now - lastSteppedTime then
				lastSteppedTime = now
				debug.profilebegin("Gun Stepped")
				self:Stepped()
				debug.profileend()
			end
		end
	end))
	if self.Heartbeat then
		self.Maid:GiveTask(RunService.Heartbeat:Connect(function()
			if not self.Destroyed then
				debug.profilebegin("Gun Heartbeat")
				self:Heartbeat()
				debug.profileend()
			end
		end))
	end
end

function Gun.Unequip(self)
	if self.IsLeaning then
		self:SetLeaning(false)
	end
	if self.IsScoping then
		self:ScopeEnd()
		CurrentCamera.FieldOfView = 70
	end
	if self.Local and UI.IsOpen == true then
		UI.Close()
	end
end

function Gun.Destroy(self)
	self:Unequip()
	Item.Destroy(self)
end

return Gun
