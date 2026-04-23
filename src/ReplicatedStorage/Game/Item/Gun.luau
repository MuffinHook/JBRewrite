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
local v2 = CFrame.new()
local function FromAxisAngle(p1) --[[ Line: 50 | Upvalues: v2 (copy) ]]
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
local function RandomVector() --[[ Line: 60 ]]
	local v1 = math.random() * 2 - 1
	local v2 = math.random() * 2 - 1
	return Vector3.new(v1, v2, math.random() * 2 - 1).Unit
end
local t = {
	bullet_impact_bass = 2837091387,
	bullet_impact_metal_light_01 = 2121004076,
	bullet_impact_rock_03 = 2121004325,
	bullet_impact_wood_light_04 = 2121004681
}
local t2 = {
	[Enum.Material.Wood] = t.bullet_impact_wood_light_04,
	[Enum.Material.Metal] = t.bullet_impact_metal_light_01,
	[Enum.Material.DiamondPlate] = t.bullet_impact_metal_light_01,
	[Enum.Material.Slate] = t.bullet_impact_rock_03
}
local v3 = nil
local v4 = nil
local v5 = 1
local t3 = {
	__ClassName = "Gun"
}
t3.__index = t3
setmetatable(t3, Item)
local v6 = false
function t3.Init(p1) --[[ Line: 89 | Upvalues: v6 (ref), v3 (ref), waitForChild (copy), ReplicatedStorage (copy), v4 (ref), Players (copy), ItemSystem (copy), gameSettingType (copy), GameSettingsService (copy), v5 (ref) ]]
	assert(not v6, "gun already Init")
	v6 = true
	v3 = p1.Event
	waitForChild(ReplicatedStorage, "ItemSystemGunMouseMovement"):andThen(function(p1) --[[ Line: 96 | Upvalues: v4 (ref), Players (ref), ItemSystem (ref) ]]
		v4 = p1
		p1.OnClientEvent:Connect(function(p1) --[[ Line: 98 | Upvalues: Players (ref), ItemSystem (ref) ]]
			for v1, v2 in p1 do
				local v3 = Players:GetPlayerByUserId((tonumber(v1)))
				if v3 then
					local v4 = ItemSystem.GetEquipped(v3)
					if v4 ~= nil and (v4.Local == false and v4.SetThirdMousePosition) then
						v4:SetThirdMousePosition(v2)
					end
				end
			end
		end)
	end)
	function p1.em.ssc92uk2(p1, p2, p3) --[[ Line: 113 | Upvalues: ItemSystem (ref) ]]
		local v1 = ItemSystem.GetEquipped(p1)
		if v1 ~= nil and v1.SetLeaning then
			v1:SetLeaning(p2, p3)
		end
	end
	local t = {
		name = "scopeSens",
		title = "Scope Sensitivity",
		type = gameSettingType.Slider,
		defaultValue = 100,
		order = 210,
		min = 10,
		max = 100,
		step = 1,
		textMap = function(p1) --[[ Name: textMap | Line: 131 ]]
			return ("%d%%"):format(p1)
		end
	}
	GameSettingsService.add(t)
	local function handleSetting(p1) --[[ Line: 136 | Upvalues: v5 (ref) ]]
		v5 = p1 / 100
	end
	v5 = t:getValue() / 100
	t.onChanged:Connect(handleSetting)
end
function t3.new(p1, p2, p3) --[[ Line: 142 | Upvalues: Item (copy), t3 (copy), InventoryItemUtils (copy), ReplicatedStorage (copy) ]]
	local v1 = Item.new(p1, p3)
	setmetatable(v1, t3)
	v1.inventoryItemValue = p2
	local v3 = InventoryItemUtils.getName(p2)
	local v4 = ReplicatedStorage.Game.ItemConfig:FindFirstChild(v3)
	if v4 == nil then
		error(("No config file exists for item: %s"):format(v3))
	end
	v1.Config = require(v4)
	v1.LastReplicateMousePosition = tick()
	v1.SimulateLocal = false
	v1.MinimalFx = false
	return v1
end
function t3.Setup(p1, p2) --[[ Line: 164 | Upvalues: VehicleUtils (copy), CollectionService (copy), DestructibleConsts (copy), R15IKv2 (copy), Spring (copy), ItemCamera (copy), ConstraintUtils (copy) ]]
	p1:SetupModel()
	p1.IgnoreList = { p1.Character, p1.Model, workspace.Items }
	if p1.Local then
		local v1 = VehicleUtils.GetLocalVehicleModel()
		if v1 then
			table.insert(p1.IgnoreList, v1)
		end
		for v2, v3 in CollectionService:GetTagged(DestructibleConsts.SPAWN_TAG_NAME) do
			if v3:FindFirstChild(DestructibleConsts.INSTANCE_VALUE_NAME) and v3[DestructibleConsts.INSTANCE_VALUE_NAME].Value then
				table.insert(p1.IgnoreList, v3[DestructibleConsts.INSTANCE_VALUE_NAME].Value)
			end
		end
	end
	p1:SetupArmWelds()
	p1:SetupTip()
	p1:AttachModelToPlayer()
	p1:SetupBulletEmitter()
	p1:SetupSprings(p2)
	p1.IK = R15IKv2.BuildPacketArms(p1.Character)
	if p1.Local then
		p1:SetupCrossHair()
	end
	p1:SetupAmmoGui()
	if p1.Local then
		local v5 = Spring.new(Vector3.new(), Vector3.new(), 0.6, 75)
		p1.SpringCamera = v5
		ItemCamera.SetRecoilSpring(v5)
	end
	if not p1.Local then
		p1.SpringThirdMousePosition = Spring.new(Vector3.new(), Vector3.new(), 0.9, 20)
	end
	p1.JointNeckC0 = p1.JointNeck.C0
	p1.JointWaistC0 = p1.JointWaist.C0
	p1.IsShooting = false
	p1.IsReloading = false
	p1.IsEquipping = false
	p1.IsScoping = false
	p1.IsLeaning = false
	p1.IsLeaningRight = false
	p1.MousePosition = Vector3.new()
	p1._lastUpdateViewDist = 0
	p1:SetupShoot()
	p1:Equip()
	p1.Maid:GiveTask(function() --[[ Line: 223 | Upvalues: ConstraintUtils (ref), p1 (copy) ]]
		ConstraintUtils.setJointC0(p1.JointNeck, p1.JointNeckC0)
		ConstraintUtils.setJointC0(p1.JointWaist, p1.JointWaistC0)
	end)
	p1.Maid:GiveTask(function() --[[ Line: 228 | Upvalues: p1 (copy) ]]
		p1.Motor:Destroy()
		p1.Motor = nil
		p1.Model:Destroy()
		p1.Model = nil
	end)
end
function t3.SetupShoot(p1) --[[ Line: 235 | Upvalues: RxInstanceUtils (copy), GunSystemConsts (copy) ]]
	p1.Maid:GiveTask(RxInstanceUtils.observeOneChildNamed(p1.inventoryItemValue, GunSystemConsts.SHOOT_REMOTE_NAME, function(p12, p2) --[[ Line: 240 | Upvalues: p1 (copy) ]]
		p2:GiveTask(p12.OnClientEvent:Connect(function() --[[ Line: 241 | Upvalues: p1 (ref) ]]
			p1:Shoot()
		end))
	end))
end
function t3.SetupCrossHair(p1) --[[ Line: 248 | Upvalues: CrossHair (copy) ]]
	p1.CrossHair = CrossHair.Make()
	p1.CrossHair.Gui.Parent = p1.Player.PlayerGui
	p1.Maid:GiveTask(function() --[[ Line: 252 | Upvalues: p1 (copy) ]]
		p1.CrossHair:Destroy()
		p1.CrossHair = nil
	end)
end
function t3.SetupAmmoGui(p1) --[[ Line: 257 | Upvalues: InventoryItemUtils (copy), AmmoGui (copy), GunShopUtils (copy), ItemDataUtils (copy), RunService (copy) ]]
	if p1.Local then
		local v1 = InventoryItemUtils.getName(p1.inventoryItemValue)
		p1.AmmoGui = AmmoGui.new(GunShopUtils.getTranslatedTitleFromName(v1))
		local v2 = InventoryItemUtils.getAttr(p1.inventoryItemValue, "AmmoCurrent")
		if v2 then
			InventoryItemUtils.setAttr(p1.inventoryItemValue, "AmmoCurrentLocal", v2)
		end
		local v3 = 0
		p1.Maid:GiveTask(p1.inventoryItemValue:GetAttributeChangedSignal("AmmoCurrent"):Connect(function() --[[ Line: 272 | Upvalues: InventoryItemUtils (ref), p1 (copy), v3 (ref) ]]
			local v1 = InventoryItemUtils.getAttr(p1.inventoryItemValue, "AmmoCurrent")
			if v3 < v1 then
				InventoryItemUtils.setAttr(p1.inventoryItemValue, "AmmoCurrentLocal", v1)
			end
			v3 = v1
		end))
		local function updateAmmo() --[[ Line: 280 | Upvalues: InventoryItemUtils (ref), p1 (copy), ItemDataUtils (ref), v1 (copy) ]]
			local v12 = InventoryItemUtils.getAttr(p1.inventoryItemValue, "AmmoCurrentLocal") or 0
			local v2 = ItemDataUtils.getConfig(v1)
			p1.AmmoGui:Update(v12, if v2 and v2.MagSize then v2.MagSize else nil)
		end
		p1.Maid:GiveTask(p1.inventoryItemValue:GetAttributeChangedSignal("AmmoCurrentLocal"):Connect(updateAmmo))
		p1.Maid:GiveTask(p1.inventoryItemValue:GetAttributeChangedSignal("AmmoLeft"):Connect(updateAmmo))
		local v4 = InventoryItemUtils.getAttr(p1.inventoryItemValue, "AmmoCurrentLocal") or 0
		local v5 = ItemDataUtils.getConfig(v1)
		p1.AmmoGui:Update(v4, if v5 and v5.MagSize then v5.MagSize else nil)
		local v7 = p1.Model and p1.Model:FindFirstChild("BoundingBox", true)
		p1.Maid:GiveTask(RunService.Heartbeat:Connect(function(p12) --[[ Line: 295 | Upvalues: v7 (copy), p1 (copy) ]]
			if v7 then
				p1.AmmoGui:UpdatePosition(v7, p12)
			end
		end))
		p1.Maid:GiveTask(function() --[[ Line: 301 | Upvalues: p1 (copy) ]]
			p1.AmmoGui:Destroy()
			p1.AmmoGui = nil
		end)
	end
end
function t3.SetupModel(p1, p2) --[[ Line: 307 | Upvalues: InventoryItemUtils (copy), ReplicatedStorage (copy), Joint (copy) ]]
	if p2 == nil then
		p2 = InventoryItemUtils.getName(p1.inventoryItemValue)
	end
	local v2 = ReplicatedStorage.Resource.ItemSystem.Models:FindFirstChild(p2)
	if v2 == nil then
		error(("Could not find model for item `%s`"):format(p2))
	end
	local v3 = v2:Clone()
	local v4 = v3
	for v5, v6 in v3:GetDescendants() do
		if v6:IsA("BasePart") then
			v6.CanCollide = false
			v6.CanQuery = false
			v6.CanTouch = false
		end
	end
	p1.Model = v4
	local BoundingBox = v4.Skeleton.BoundingBox
	p1.BoundingBox = BoundingBox
	Joint.WeldAllTo(v4.Model, BoundingBox)
	if p1.ApplySkin then
		local function updateSkin() --[[ Line: 331 | Upvalues: p1 (copy) ]]
			p1:ApplySkinLocal(p1.inventoryItemValue:GetAttribute("SkinName"))
		end
		p1.Maid:GiveTask(p1.inventoryItemValue:GetAttributeChangedSignal("SkinName"):Connect(updateSkin))
		p1:ApplySkinLocal(p1.inventoryItemValue:GetAttribute("SkinName"))
	end
end
function t3.SetupTip(p1) --[[ Line: 338 | Upvalues: Joint (copy) ]]
	local Tip = p1.Model.Skeleton.Tip
	p1.Tip = Tip
	p1.TipOffset = p1.BoundingBox.CFrame:PointToObjectSpace(Tip.Position)
	Joint.Weld(p1.Model.Skeleton.Tip, p1.BoundingBox)
	p1.Model.Skeleton.Tip.Anchored = false
end
function t3.SetupArmWelds(p1) --[[ Line: 347 | Upvalues: Joint (copy) ]]
	Joint.Weld(p1.Model.Skeleton.LeftArm, p1.BoundingBox)
	Joint.Weld(p1.Model.Skeleton.RightArm, p1.BoundingBox)
	p1.Model.Skeleton.LeftArm.Anchored = false
	p1.Model.Skeleton.RightArm.Anchored = false
end
function t3.ApplySkinLocal(p1, p2) --[[ Line: 353 | Upvalues: ItemSkinIds (copy) ]]
	local v1
	if p2 == nil or p2 == "None" then
		v1 = ""
	else
		local v2 = ItemSkinIds[p2]
		if v2 == nil then
			error(("No skin by name of %s exists."):format(p2))
		end
		local v3 = v2[p1.__ClassName]
		if v3 == nil then
			error(("Skin %s has no image id for item: %s"):format(p2, p1.__ClassName))
		end
		v1 = ("rbxassetid://%d"):format(v3)
	end
	for v5, v6 in p1.Model:GetDescendants() do
		if v6:IsA("MeshPart") and v6:GetAttribute("ApplyGunTexture") == true then
			v6.TextureID = v1
		end
	end
end
function t3.ApplySkin(p1, p2) --[[ Line: 375 | Upvalues: v3 (ref) ]]
	if p1.Local then
		v3:FireServer("c" .. ("etdvf"):sub(4, 4):reverse() .. "ro44st", p1.inventoryItemValue, p2)
	end
end
function t3.AttachModelToPlayer(p1) --[[ Line: 380 | Upvalues: Joint (copy) ]]
	local UpperTorso = p1.UpperTorso
	p1.BoundingBox.CFrame = UpperTorso.CFrame
	local v1 = Joint.BlankMotor6D(p1.BoundingBox, UpperTorso)
	p1.Model.Parent = workspace.Items
	p1.Motor = v1
end
function t3.BulletEmitterOnLocalHitPlayer(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15) --[[ Line: 393 | Upvalues: Time (copy), GunSystemConsts (copy), Audio (copy), t (copy) ]]
	local v1 = Time.GetNowSync()
	p1.inventoryItemValue:FindFirstChild(GunSystemConsts.DAMAGE_REMOTE_NAME):FireServer(p2, p3, p4, p5, p6 - 0.6609848067581097 * v1, p7, p8, p9 + 0.3968011188544949 * v1, p10, p11, p12, p13, p14 + 0.6369049829533174 * v1, p15)
	if p1.CrossHair then
		p1.CrossHair:Flare()
	end
	if not p1.MinimalFx then
		Audio.ObjectLocal(p1.Tip, t.bullet_impact_bass, {
			TimePosition = 0,
			Volume = 1,
			Pitch = 1
		})
	end
end
function t3.BulletEmitterShieldDamage(p1, p2) --[[ Line: 435 | Upvalues: ReplicatedStorage (copy), ForcefieldConsts (copy) ]]
	if p1.Local then
		ReplicatedStorage.Forcefield:FindFirstChild(ForcefieldConsts.DAMAGE_REMOTE_NAME):FireServer(p2.Id, p1.__ClassName)
	end
end
function t3.SetupBulletEmitter(p1) --[[ Line: 443 | Upvalues: BulletEmitter (copy), Joint (copy), Debris (copy), t2 (copy), Audio (copy), ReplicatedStorage (copy), v3 (ref), HomeItemBinder (copy), CameraBinder (copy), ExplodableBarrelBinder (copy), RunService (copy) ]]
	p1.LastImpactSound = 0
	p1.LastImpact = 0
	p1.BulletEmitter = BulletEmitter.new(p1.Local)
	p1.BulletEmitter.IgnoreList = assert(p1.IgnoreList)
	p1.BulletEmitter.LifeSpan = 1
	p1.BulletEmitter.GravityVector = (p1.Config.GravityMultiplier or 1) * Vector3.new(0, -workspace.Gravity / 10, 0)
	local BulletEmitterOnLocalHitPlayer = p1.BulletEmitterOnLocalHitPlayer
	p1.BulletEmitter.OnLocalHitPlayer:Connect(function(...) --[[ Line: 453 | Upvalues: BulletEmitterOnLocalHitPlayer (copy), p1 (copy) ]]
		BulletEmitterOnLocalHitPlayer(p1, ...)
	end)
	local BulletEmitterShieldDamage = p1.BulletEmitterShieldDamage
	p1.BulletEmitter.OnShieldDamage:Connect(function(...) --[[ Line: 458 | Upvalues: BulletEmitterShieldDamage (copy), p1 (copy) ]]
		BulletEmitterShieldDamage(p1, ...)
	end)
	p1.BulletEmitter.OnHitSurface:Connect(function(p12, p2, p3, p4) --[[ Line: 462 | Upvalues: p1 (copy), Joint (ref), Debris (ref), t2 (ref), Audio (ref), ReplicatedStorage (ref), v3 (ref), HomeItemBinder (ref), CameraBinder (ref), ExplodableBarrelBinder (ref) ]]
		local v1 = tick()
		if not p1.MinimalFx then
			local Part = Instance.new("Part")
			Part.Color = p12.Color
			Part.Massless = true
			Part.Size = Vector3.new(0.5, 0.5, 0.1)
			Part.Anchored = false
			Part.CanCollide = false
			Part.Transparency = 1
			Part.CFrame = CFrame.new(Vector3.new(), p3) * CFrame.Angles(0, 0, math.random() * math.pi * 2) + p2
			local Decal = Instance.new("Decal")
			Decal.Texture = "rbxassetid://2078626"
			Decal.Color3 = p12.Color
			Decal.Face = Enum.NormalId.Front
			Decal.Parent = Part
			Joint.Weld(Part, p12)
			Part.Parent = workspace.Items
			Debris:AddItem(Part, 2)
			if p1.Local and v1 - p1.LastImpactSound > 0.03 then
				local v2 = t2[p4]
				if v2 ~= nil then
					p1.LastImpactSound = v1
					Audio.ObjectLocal(Part, v2, {
						Volume = 0.4
					})
				end
			end
			local v32 = ReplicatedStorage.Resource.ItemSystem.Projectiles.Debris:Clone()
			v32.EmissionDirection = Enum.NormalId.Front
			v32.Size = NumberSequence.new(0.1)
			v32.SpreadAngle = Vector2.new(15, 15)
			v32.Parent = Part
			v32:Emit(3)
		end
		if p1.Local and v1 - p1.LastImpact > 0.1 then
			p1.LastImpact = v1
			if p12:IsDescendantOf(workspace.Vehicles) then
				v4 = p12
				count = 0
				repeat
					v4 = v4.Parent
					count = count + 1
					if v4 ~= nil and v4:FindFirstChild("BoundingBox") then
						break
					end
				until count >= 5
				local v5 = if v4 == nil then false else v4:FindFirstChild("BoundingBox")
				if v5 then
					v3:FireServer("u" .. ("m3wmc9"):sub(3, 3):reverse():reverse():reverse() .. "" .. "" .. ("p2j4j4qac"):sub(5, 6):reverse() .. "" .. "" .. ("u5ej"):sub(2, 2):reverse():reverse():reverse() .. "uqm", v5.Parent, p1.__ClassName)
				end
			end
			if p12.Name == "ShootingRangePart" then
				Audio.ObjectLocal(p12, 737592495, {
					Volume = 1,
					Pitch = 2 + math.random() * 0.2,
					EmitterSize = 15
				})
				Audio.ObjectLocal(p12, 690530166, {
					MaxPlaybackTime = 0.8
				})
				return
			end
			if workspace:FindFirstChild("Museum") and p12:IsDescendantOf(workspace.Museum) then
				v3:FireServer("s" .. ("wqs1pzrc"):sub(4, 4):reverse() .. "" .. "" .. ("x53bf"):sub(4, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("mixcgqt6fl"):sub(5, 6):reverse():reverse():reverse() .. "" .. "" .. ("l9ozxgem"):sub(5, 5):reverse():reverse():reverse():reverse():reverse() .. "g1", p12)
				return
			end
			local v6 = p12
			while true do
				local v7 = HomeItemBinder:Get(v6)
				if v7 then
					v7:Damage()
					return
				end
				local v8 = CameraBinder:Get(v6)
				if v8 then
					v8:Damage()
					return
				end
				local v9 = ExplodableBarrelBinder:Get(v6)
				if v9 then
					v3:FireServer("s" .. ("xb1d1"):sub(3, 3):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("sibs"):sub(3, 3):reverse() .. "" .. "" .. ("nmxgqe"):sub(3, 5):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("taago"):sub(4, 4):reverse() .. "1", v9.obj, p1.__ClassName)
					return
				end
				v6 = v6.Parent
				local _ = v6 == workspace
			end
		end
	end)
	local v32 = RunService.Heartbeat:Connect(function() --[[ Line: 554 | Upvalues: p1 (copy) ]]
		debug.profilebegin("Gun Bullet Emitter Update")
		p1.BulletEmitter:Update()
		debug.profileend()
	end)
	p1.Maid:GiveTask(function() --[[ Line: 560 | Upvalues: p1 (copy), v32 (ref) ]]
		if #p1.BulletEmitter.Bullets > 0 then
			p1.BulletEmitter.OnQueueEmptied:Connect(function() --[[ Line: 563 | Upvalues: v32 (ref), p1 (ref) ]]
				v32:Disconnect()
				v32 = nil
				p1.BulletEmitter:Destroy()
			end)
		else
			v32:Disconnect()
			v32 = nil
			p1.BulletEmitter:Destroy()
		end
	end)
end
function t3.SetupSprings(p1, p2) --[[ Line: 575 | Upvalues: Spring (copy) ]]
	if p1.Local and (p2 and p2.SpringItemOffset) then
		p1.SpringItemOffset = p2.SpringItemOffset
		p1.SpringItemOffset.Damp = 0.7
		p1.SpringItemOffset.Freq = 50
		p1.SpringItemOffset:SetTarget(p1.Config.Motion.Hip.Springs.ItemOffset)
	else
		p1.SpringItemOffset = Spring.new(p1.Config.Motion.Hip.Springs.ItemOffset, Vector3.new(), 0.7, 50)
	end
	if p1.Local and (p2 and p2.SpringItemRotation) then
		p1.SpringItemRotation = p2.SpringItemRotation
		p1.SpringItemRotation.Damp = 0.9
		p1.SpringItemRotation.Freq = 25
		p1.SpringItemRotation:SetTarget(p1.Config.Motion.Hip.Springs.ItemRotation)
	else
		p1.SpringItemRotation = Spring.new(p1.Config.Motion.Hip.Springs.ItemRotation, Vector3.new(), 0.9, 25)
	end
	if p1.Local and (p2 and p2.SpringNeckRotation) then
		p1.SpringNeckRotation = p2.SpringNeckRotation
		p1.SpringNeckRotation.Damp = 0.9
		p1.SpringNeckRotation.Freq = 25
		p1.SpringNeckRotation:SetTarget(p1.Config.Motion.Hip.Springs.NeckRotation)
	else
		p1.SpringNeckRotation = Spring.new(p1.Config.Motion.Hip.Springs.NeckRotation, Vector3.new(), 0.9, 25)
	end
end
function t3.UpdateItemSprings(p1) --[[ Line: 605 | Upvalues: FromAxisAngle (copy) ]]
	local v1 = p1.SpringItemOffset:Update()
	local v2, v3 = p1.SpringItemRotation:Update()
	local v4 = FromAxisAngle(v2)
	local v5 = FromAxisAngle(v3 * 0.01)
	p1.ItemOffsetPosition = v1
	p1.ItemRotationCFrame = v4
	p1.ItemRotationVelocityCFrame = v5
end
function t3.UpdateItemJoints(p1) --[[ Line: 616 ]] end
function t3.ApplyItemJointsC1(p1) --[[ Line: 617 ]]
	if p1.Motor then
		p1.Motor.C1 = p1.ItemRotationCFrame * CFrame.new(p1.ItemOffsetPosition) * p1.JointWaist.C1
	end
end
function t3.ApplyItemJointsTransform(p1) --[[ Line: 622 ]]
	if p1.Motor then
		p1.Motor.Transform = (p1.ItemRotationCFrame * CFrame.new(p1.ItemOffsetPosition) * p1.JointWaist.C1):Inverse()
	end
end
function t3.UpdateBodySprings(p1) --[[ Line: 627 ]]
	p1.NeckRotationPosition = p1.SpringNeckRotation:Update()
end
function t3.UpdateMousePosition(p1) --[[ Line: 631 | Upvalues: v4 (ref) ]]
	local v1 = tick()
	local v2 = if p1.Local then p1:ProjectMouseLocationToWorld((p1:GetMouseLocation())) else p1.SpringThirdMousePosition:Update()
	p1.MousePosition = v2
	if p1.Local and (v4 and v1 - p1.LastReplicateMousePosition > 0.25) then
		p1.LastReplicateMousePosition = v1
		v4:FireServer(v2)
	end
end
function t3.ComputeBodyJoints(p1) --[[ Line: 651 | Upvalues: GeomUtils (copy), FromAxisAngle (copy) ]]
	local JointRoot = p1.JointRoot
	local JointWaist = p1.JointWaist
	p1.JointWaist.Transform = CFrame.new()
	p1.JointNeck.Transform = CFrame.new()
	local v1 = (p1.RootPart.CFrame * JointRoot.C0 * JointRoot.Transform * JointRoot.C1:Inverse() * p1.JointWaistC0 * JointWaist.Transform):PointToObjectSpace(p1.MousePosition)
	local v2 = p1.ItemRotationCFrame:Inverse() * JointWaist.C1:Inverse() * p1.ItemRotationCFrame * CFrame.new(p1.ItemOffsetPosition + p1.TipOffset) * JointWaist.C1
	local v3, v4 = GeomUtils.offsetLookAtTarget(v2.x, v2.y, v2.z, v1.x, v1.y, v1.z)
	if v4 < -1.382300767579509 then
		v4 = -1.382300767579509
	end
	p1.JointWaistTransform = CFrame.Angles(0, v3, 0) * CFrame.Angles(v4, 0, 0) * p1.ItemRotationCFrame:inverse()
	p1.JointNeckTransform = p1.ItemRotationCFrame * FromAxisAngle(p1.NeckRotationPosition) * p1.ItemRotationVelocityCFrame
end
function t3.ApplyBodyJointsC1(p1) --[[ Line: 684 | Upvalues: ConstraintUtils (copy) ]]
	if p1.JointWaistTransform then
		ConstraintUtils.setJointC0(p1.JointWaist, p1.JointWaistC0 * p1.JointWaistTransform)
		ConstraintUtils.setJointC0(p1.JointNeck, p1.JointNeckC0 * p1.JointNeckTransform)
	end
end
function t3.ApplyBodyJointsTransform(p1) --[[ Line: 690 ]]
	if p1.JointWaistTransform then
		p1.JointWaist.Transform = p1.JointWaistTransform
		p1.JointNeck.Transform = p1.JointNeckTransform
	end
end
function t3.ClearBodyTransform(p1) --[[ Line: 696 ]]
	p1.JointWaist.Transform = CFrame.new()
	p1.JointNeck.Transform = CFrame.new()
end
function t3.UpdateArmIK(p1) --[[ Line: 703 ]]
	local IK = p1.IK
	local Model = p1.Model
	IK.RightArm = Model.Skeleton.RightArm.Position
	IK.LeftArm = Model.Skeleton.LeftArm.Position
	IK.RightAngle = p1.Config.Motion.RightElbowAngle
	IK.LeftAngle = p1.Config.Motion.LeftElbowAngle
end
function t3.ComputeArmJoints(p1) --[[ Line: 712 | Upvalues: R15IKv2 (copy) ]]
	if p1.Model:IsDescendantOf(workspace) then
		if p1.Character.PrimaryPart then
			p1:UpdateArmIK()
			R15IKv2.ComputeArms(p1.IK)
		end
	end
end
function t3.ApplyArmJoints(p1) --[[ Line: 727 | Upvalues: R15IKv2 (copy) ]]
	local IK = p1.IK
	R15IKv2.ApplyArms(IK)
	if p1.Config.Motion.RightWristRotation then
		IK.RightWrist.Transform = p1.Config.Motion.RightWristRotation
	end
	if p1.Config.Motion.LeftWristRotation then
		IK.LeftWrist.Transform = p1.Config.Motion.LeftWristRotation
	end
end
function t3.ReloadDropAmmoVisual(p1) --[[ Line: 738 | Upvalues: Debris (copy) ]]
	local Ammo = p1.Model.Model:FindFirstChild("Ammo")
	if Ammo then
		local v1 = Ammo:Clone()
		v1:ClearAllChildren()
		v1.CFrame = Ammo.CFrame
		v1.CanCollide = true
		v1.CollisionGroup = "NoCollide"
		v1.Velocity = Vector3.new(0, -20, 0)
		v1.Parent = workspace
		Debris:AddItem(v1, 6)
		Ammo.Transparency = 1
	end
end
function t3.ReloadRefillAmmoVisual(p1) --[[ Line: 754 ]]
	local Ammo = p1.Model.Model:FindFirstChild("Ammo")
	if Ammo then
		Ammo.Transparency = 0
	end
end
function t3.ReloadDropAmmoSound(p1) --[[ Line: 762 ]]
	error("TODO: Implement")
end
function t3.ReloadRefillAmmoSound(p1) --[[ Line: 765 ]]
	error("TODO: Implement")
end
function t3._reloadBroadcast(p1) --[[ Line: 769 | Upvalues: GunSystemConsts (copy) ]]
	local v1 = p1.inventoryItemValue:FindFirstChild(GunSystemConsts.RELOAD_REMOTE_NAME)
	if v1 then
		v1:FireServer()
	end
end
function t3.ReloadLocal(p1, p2) --[[ Line: 775 ]]
	p1:StartReloadProgressCircle()
	return true
end
function t3.ReloadAnyone(p1) --[[ Line: 779 ]]
	p1:ReloadDropAmmoVisual()
	p1:ReloadDropAmmoSound()
	task.delay(p1.Config.ReloadTime - (p1.Config.LocalReloadOffset or 0), function() --[[ Line: 785 | Upvalues: p1 (copy) ]]
		if p1.Destroyed then
			return false
		else
			p1:ReloadRefillAmmoVisual()
			if p1.Destroyed then
				return false
			else
				p1:ReloadRefillAmmoSound()
				return not p1.Destroyed
			end
		end
	end)
end
function t3._checkReloadCondition(p1) --[[ Line: 802 ]]
	if p1.IsReloading or p1.Local and p1.inventoryItemValue:GetAttribute("IsReloading") then
		return false
	else
		return not (p1:GetAmmoLeft() <= 0)
	end
end
function t3.Reload(p1) --[[ Line: 816 ]]
	if p1:_checkReloadCondition() then
		p1.IsReloading = true
		task.delay(p1.Config.ReloadTime, function() --[[ Line: 824 | Upvalues: p1 (copy) ]]
			if p1.Destroyed then
				return false
			else
				p1.IsReloading = false
				return true
			end
		end)
		if p1.Local or p1.SimulateLocal then
			p1:_reloadBroadcast()
		end
		if p1.Local then
			p1:ReloadLocal()
		end
		p1:ReloadAnyone()
		return true
	else
		return false
	end
end
function t3.GetAmmoLeft(p1) --[[ Line: 840 | Upvalues: InventoryItemUtils (copy) ]]
	return InventoryItemUtils.getAttr(p1.inventoryItemValue, "AmmoLeft") or (1 / 0)
end
function t3.ShootCheckConditions(p1) --[[ Line: 844 | Upvalues: InventoryItemUtils (copy), RayCast (copy) ]]
	local Tip = p1.Tip
	if not (p1.IsReloading or (p1.IsEquipping or (p1.BlockFire or p1.inventoryItemValue:GetAttribute("IsReloading")))) then
		if p1.Local then
			if InventoryItemUtils.getAttr(p1.inventoryItemValue, "AmmoCurrentLocal") <= 0 then
				p1:ShootSound(true)
				if p1.IsReloading == false then
					p1:InputBegan({
						UserInputType = Enum.UserInputType.Keyboard,
						KeyCode = Enum.KeyCode.R
					})
				end
			elseif Tip then
				local Position = p1.RootPart.Position
				local v1 = Tip.Position - Position
				local _, v2 = RayCast.RayIgnoreNonCollideWithIgnoreList(Position, v1.Unit, v1.Magnitude, p1.IgnoreList, nil, nil, p1._customCollideFunc)
				if (v2 - Tip.Position).Magnitude > 0.1 then
					return false
				else
					return p1:CheckNextShotPossible() and true or false
				end
			else
				return p1:CheckNextShotPossible() and true or false
			end
		else
			return p1:CheckNextShotPossible() and true or false
		end
	end
	return false
end
function t3.CheckNextShotPossible(p1) --[[ Line: 894 | Upvalues: GunUtils (copy) ]]
	local v1 = workspace:GetServerTimeNow()
	local v2 = GunUtils.getNextShotPossible(p1.Player)
	return not (v2 and v1 < v2)
end
function t3.SetNextShotPossible(p1) --[[ Line: 904 | Upvalues: GunUtils (copy) ]]
	local FireFreq = p1.Config.FireFreq
	local Player = p1.Player
	local v1 = workspace:GetServerTimeNow()
	GunUtils.setLastShotTime(Player, v1)
	if FireFreq then
		GunUtils.setNextShotPossible(Player, v1 + 1 / FireFreq)
		return true
	else
		warn("No FireFreq")
		return false
	end
end
function t3.ShootLocal(p1) --[[ Line: 917 | Upvalues: HapticEffect (copy) ]]
	if p1.Local then
		HapticEffect.basic(0.2, 0.25)
		local v1 = if p1.IsScoping then 0.3 else 1
		p1.SpringCamera:Accelerate(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 0.15 * p1.Config.CamShakeMagnitude * v1)
		p1.CrossHair.Spring:Accelerate(600 * if p1.IsScoping then 0.3 else 1)
		return true
	else
		return false
	end
end
function t3.ShootOther(p1) --[[ Line: 933 | Upvalues: GunUtils (copy) ]]
	p1.SpringItemOffset:Accelerate(Vector3.new(0, 0, 50) + Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 3)
	p1.SpringItemRotation:Accelerate((Vector3.new(-1, 2, 0)).Unit * 12 + Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 2)
	local v8 = p1.Tip.CFrame
	local TipDirection = p1.TipDirection
	if TipDirection then
		local function getLocalBulletDirection() --[[ Line: 947 | Upvalues: p1 (copy), GunUtils (ref), v8 (copy), TipDirection (copy) ]]
			return GunUtils.getBulletDirection(v8, TipDirection, (p1.BulletSpread or 0) + (p1.Config.BulletSpread or 0))
		end
		if p1.Config.BulletsPerShot then
			for i = 1, p1.Config.BulletsPerShot do
				p1.BulletEmitter:Emit(v8.Position, GunUtils.getBulletDirection(v8, TipDirection, (p1.BulletSpread or 0) + (p1.Config.BulletSpread or 0)), p1.Config.BulletSpeed)
			end
		else
			p1.BulletEmitter:Emit(v8.Position, GunUtils.getBulletDirection(v8, TipDirection, (p1.BulletSpread or 0) + (p1.Config.BulletSpread or 0)), p1.Config.BulletSpeed)
		end
		return true
	end
end
function t3.ShootFx(p1) --[[ Line: 962 ]]
	local Tip = p1.Tip
	if Tip then
		local _ = ({
			Flintlock = 1,
			NerfRevolver = 20,
			Revolver = 20,
			Shotgun = 20,
			Sniper = 3
		})[p1.__ClassName]
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
			task.delay(0.1, function() --[[ Line: 990 | Upvalues: PointLight (copy) ]]
				PointLight.Enabled = false
			end)
		end
	end
end
function t3.Shoot(p1) --[[ Line: 995 ]]
	p1:ShootLocal()
	p1:ShootOther()
	p1:ShootSound(false)
	p1:ShootFx()
	return true
end
function t3.ShootSound(p1, p2) --[[ Line: 1002 ]]
	error("TODO: Implement")
end
function t3._attemptShoot(p1) --[[ Line: 1005 ]]
	if p1:ShootCheckConditions() then
		if p1.PreFireFunc then
			p1:PreFireFunc()
			if p1.Destroyed or not p1:ShootCheckConditions() then
				return false
			else
				p1:DecrementAmmo()
				p1:SetNextShotPossible()
				if p1.Local or p1.SimulateLocal then
					p1:_shootBroadcast()
				end
				p1:Shoot()
				return true
			end
		else
			p1:DecrementAmmo()
			p1:SetNextShotPossible()
			if p1.Local or p1.SimulateLocal then
				p1:_shootBroadcast()
			end
			p1:Shoot()
			return true
		end
	else
		return false
	end
end
function t3._startReloading(p1) --[[ Line: 1026 ]]
	if p1.IsReloading == false then
		p1:InputBegan({
			UserInputType = Enum.UserInputType.Keyboard,
			KeyCode = Enum.KeyCode.R
		})
	end
end
function t3.DecrementAmmo(p1) --[[ Line: 1031 | Upvalues: InventoryItemUtils (copy) ]]
	if p1.Local or p1.SimulateLocal then
		local v1 = InventoryItemUtils.getAttr(p1.inventoryItemValue, "AmmoCurrent") - 1
		InventoryItemUtils.setAttr(p1.inventoryItemValue, "AmmoCurrentLocal", v1)
		if v1 <= 0 then
			p1:_startReloading()
		end
		return true
	else
		return false
	end
end
function t3._shootBroadcast(p1) --[[ Line: 1044 | Upvalues: GunSystemConsts (copy) ]]
	local v1 = p1.inventoryItemValue:FindFirstChild(GunSystemConsts.SHOOT_REMOTE_NAME)
	if v1 then
		v1:FireServer()
	end
end
function t3.UpdateCrossHair(p1) --[[ Line: 1050 ]]
	if p1.CrossHair then
		p1.CrossHair:Update(p1:GetMouseLocation())
	end
end
function t3.RenderStepped(p1) --[[ Line: 1055 | Upvalues: MovementRollService (copy) ]]
	if p1.Local then
		p1:UpdateCrossHair()
	end
	debug.profilebegin("UpdateMousePosition")
	p1:UpdateMousePosition()
	debug.profileend()
	debug.profilebegin("UpdateItemSprings")
	p1:UpdateItemSprings()
	debug.profileend()
	debug.profilebegin("UpdateBodySprings")
	p1:UpdateBodySprings()
	debug.profileend()
	debug.profilebegin("ComputeBodyJoints")
	p1:ComputeBodyJoints()
	debug.profileend()
	if p1.Local then
		if not MovementRollService.isPlayerRolling(p1.Player) then
			debug.profilebegin("ApplyBodyJoints")
			p1:ApplyBodyJointsC1()
			debug.profileend()
		end
		debug.profilebegin("ApplyItemJoints")
		p1:ApplyItemJointsC1()
		debug.profileend()
	end
	p1:UpdateItemJoints()
	debug.profilebegin("ComputeArmJoints")
	p1:ComputeArmJoints()
	debug.profileend()
	local Tip = p1.Tip
	if Tip ~= nil then
		p1.TipDirection = Tip.CFrame.LookVector
	end
	if (p1.Local or p1.SimulateLocal) and p1.IsShooting == true then
		p1:_attemptShoot()
	end
end
function t3.Stepped(p1) --[[ Line: 1106 ]]
	p1:ClearBodyTransform()
	if not p1.Local then
		debug.profilebegin("ApplyBodyJoints")
		p1:ApplyBodyJointsTransform()
		debug.profileend()
		debug.profilebegin("ApplyItemJoints")
		p1:ApplyItemJointsTransform()
		debug.profileend()
	end
	p1:ApplyArmJoints()
end
function t3.ShootBegin(p1, p2) --[[ Line: 1121 | Upvalues: InputUtils (copy) ]]
	if p1.Config.FireAuto or InputUtils.isTouch() and p1.Config.FireAutoMobile then
		p1.IsShooting = true
	else
		p1:_attemptShoot()
	end
end
function t3.ShootEnd(p1, p2) --[[ Line: 1128 ]]
	if p1.IsShooting == true then
		p1.IsShooting = false
	end
end
function t3.LocalScopeChanged(p1) --[[ Line: 1134 | Upvalues: AimAssist (copy), Interval (copy) ]]
	if AimAssist.canAimAssist() then
		local maid = p1.maid
		local function finishedCallback() --[[ Line: 1137 | Upvalues: maid (copy) ]]
			maid.aimAssistMaid = nil
		end
		if p1.IsScoping then
			maid.aimAssistMaid = AimAssist.aimAssist(p1, finishedCallback)
			maid.aimAssistScan = Interval.every(0.25):Connect(function() --[[ Line: 1142 | Upvalues: maid (copy), AimAssist (ref), p1 (copy), finishedCallback (copy) ]]
				if maid.aimAssistMaid == nil then
					maid.aimAssistMaid = AimAssist.aimAssist(p1, finishedCallback)
				end
			end)
			return
		end
		maid.aimAssistMaid = nil
		maid.aimAssistScan = nil
	end
end
function t3.ScopeBegin(p1) --[[ Line: 1155 | Upvalues: VehicleUtils (copy), ItemCamera (copy), v5 (ref) ]]
	if p1.IsLeaning or (VehicleUtils.GetLocalVehiclePacket() or p1.IsScoping) then
		return false
	else
		p1.SpringItemOffset:SetTarget(p1.Config.Motion.Scope.Springs.ItemOffset)
		p1.SpringItemRotation:SetTarget(p1.Config.Motion.Scope.Springs.ItemRotation)
		p1.SpringNeckRotation:SetTarget(p1.Config.Motion.Scope.Springs.NeckRotation)
		if p1.Local then
			ItemCamera.Zoom(p1.Config.Motion.Scope.FOV or 50)
			p1.CrossHair:ADS(true)
			if math.abs(v5 - 1) > 0.001 then
				ItemCamera.setSensitivity(v5)
			end
		end
		p1.IsScoping = true
		if p1.Local then
			p1:LocalScopeChanged()
		end
		return true
	end
end
function t3.ScopeEnd(p1) --[[ Line: 1183 | Upvalues: ItemCamera (copy) ]]
	if p1.IsLeaning then
		return false
	elseif p1.IsScoping then
		p1.SpringItemOffset:SetTarget(p1.Config.Motion.Hip.Springs.ItemOffset)
		p1.SpringItemRotation:SetTarget(p1.Config.Motion.Hip.Springs.ItemRotation)
		p1.SpringNeckRotation:SetTarget(p1.Config.Motion.Hip.Springs.NeckRotation)
		if p1.Local then
			ItemCamera.Zoom(70)
			p1.CrossHair:ADS(false)
			ItemCamera.setSensitivity(1)
		end
		p1.IsScoping = false
		if p1.Local then
			p1:LocalScopeChanged()
		end
		return true
	else
		return false
	end
end
function t3.SetLeaning(p1, p2, p3) --[[ Line: 1204 | Upvalues: v3 (ref) ]]
	p1.IsLeaning = p2
	p1.IsLeaningRight = p3
	if p1.IsLeaning then
		if p1.IsLeaningRight == true then
			p1.SpringItemOffset:SetTarget(Vector3.new(0.9, 1, -1.9))
			p1.SpringItemRotation:SetTarget(Vector3.new(0.2, 0, 0.6))
			p1.SpringNeckRotation:SetTarget(Vector3.new(0, 0, -0.5))
		else
			p1.SpringItemOffset:SetTarget(Vector3.new(-0.6, 1, -1.9))
			p1.SpringItemRotation:SetTarget(Vector3.new(0.2, 0, -0.6))
			p1.SpringNeckRotation:SetTarget(Vector3.new(0, 0, 0.5))
		end
	else
		p1.SpringItemOffset:SetTarget(p1.Config.Motion.Hip.Springs.ItemOffset)
		p1.SpringItemRotation:SetTarget(p1.Config.Motion.Hip.Springs.ItemRotation)
		p1.SpringNeckRotation:SetTarget(p1.Config.Motion.Hip.Springs.NeckRotation)
	end
	if p1.Local then
		v3:FireServer("s" .. "" .. ("w29csl96d"):sub(2, 5):reverse():reverse():reverse():reverse():reverse() .. "uk2", p2, p3)
	end
end
function t3.InputBegan(p1, p2, p3) --[[ Line: 1226 | Upvalues: UI (copy), Item (copy), ItemCamera (copy) ]]
	if p3 then
		return false
	end
	local v1 = if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonR2 else false
	local v2 = p2.UserInputType == Enum.UserInputType.MouseButton2
	local v3 = if p2.UserInputType == Enum.UserInputType.Keyboard and p2.KeyCode == Enum.KeyCode.R then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonX else false
	local v4 = if p2.UserInputType == Enum.UserInputType.Keyboard then p2.KeyCode == Enum.KeyCode.V else false
	local v5 = if type(p2) == "table" then p2.FlagToggleSkins ~= nil else false
	if v1 then
		p1:ShootBegin(p2)
	elseif v2 and p1.ScopeBegin then
		p1:ScopeBegin()
		if p1.Local then
			p1:BroadcastInputBegan(p2)
		end
	elseif v3 and p1.Reload then
		task.spawn(p1.Reload, p1)
		if p1.Local then
			p1:BroadcastInputBegan(p2)
		end
	elseif v4 then
		if UI.IsOpen == false then
			Item.InputBegan(p1, p2, p3)
		end
	elseif v5 and UI.IsOpen == false then
		UI.Open()
		p1.CrossHair:Disable()
		if ItemCamera.Locked == true then
			ItemCamera.setLocked(false)
			function p1.Maid.undoCameraLock() --[[ Line: 1263 | Upvalues: ItemCamera (ref) ]]
				ItemCamera.setLocked(true)
			end
		end
	elseif v5 then
		UI.Close()
		p1.CrossHair:Enable()
		p1.Maid.undoCameraLock = nil
	end
end
function t3.InputEnded(p1, p2, p3) --[[ Line: 1274 ]]
	if p3 then
		return false
	end
	local v1 = if p2.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p2.UserInputType == Enum.UserInputType.Gamepad1 then p2.KeyCode == Enum.KeyCode.ButtonR2 else false
	local v2 = p2.UserInputType == Enum.UserInputType.MouseButton2
	if v1 then
		p1:ShootEnd(p2)
	elseif v2 and p1.ScopeEnd then
		p1:ScopeEnd()
		if p1.Local then
			p1:BroadcastInputEnded(p2)
		end
	end
end
function t3.SetThirdMousePosition(p1, p2) --[[ Line: 1292 ]]
	p1.SpringThirdMousePosition:SetTarget(p2)
end
function t3._getUncachedViewDist(p1) --[[ Line: 1295 | Upvalues: CurrentCamera (copy) ]]
	return (p1.RootPart.Position - CurrentCamera.CFrame.Position).Magnitude
end
function t3._getViewDist(p1) --[[ Line: 1298 ]]
	local v1 = os.clock()
	if v1 - p1._lastUpdateViewDist > 0.1 then
		p1._lastUpdateViewDist = v1
		local v2 = p1:_getUncachedViewDist()
		p1._viewDist = v2
		return v2
	else
		return p1._viewDist
	end
end
function t3._getUpdateRate(p1, p2) --[[ Line: 1309 ]]
	if p1.Model:IsDescendantOf(workspace) then
		local v1 = p2 or 512
		local v2 = p1:_getViewDist()
		if v2 < v1 then
			return 0
		else
			return (v2 - v1) / (1024 - v1)
		end
	else
		return 1
	end
end
function t3.Equip(p1) --[[ Line: 1322 | Upvalues: InventoryItemUtils (copy), GunUtils (copy), GunSystemConsts (copy), RunService (copy) ]]
	p1:RenderStepped()
	p1:Stepped()
	local v2 = GunUtils.getEquipTime((InventoryItemUtils.getName(p1.inventoryItemValue))) or GunSystemConsts.GUN_EQUIP_TIME
	if GunUtils.getShouldAddEquipTime(p1) and v2 > 0 then
		if InventoryItemUtils.getAttr(p1.inventoryItemValue, "AmmoCurrent") <= 0 then
			p1.maid:GiveTask(task.defer(function() --[[ Line: 1334 | Upvalues: p1 (copy) ]]
				p1:_startReloading()
			end))
		else
			p1.IsEquipping = true
			p1:StartReloadProgressCircle(v2)
			p1.maid:GiveTask(task.delay(v2, function() --[[ Line: 1340 | Upvalues: p1 (copy) ]]
				p1.IsEquipping = false
			end))
		end
	end
	p1.maid:GiveTask(function() --[[ Line: 1346 | Upvalues: p1 (copy), GunUtils (ref) ]]
		local Player = p1.Player
		if Player and Player.SetAttribute then
			GunUtils.setNextShotPossible(Player, nil)
		end
	end)
	local v3 = 0
	if p1.Local then
		p1.Maid:GiveTask(RunService.RenderStepped:Connect(function() --[[ Line: 1357 | Upvalues: p1 (copy), v3 (ref) ]]
			if not p1.Destroyed then
				local v1 = os.clock()
				if v1 - v3 > p1:_getUpdateRate() then
					v3 = v1
					debug.profilebegin("Gun RenderStepped")
					p1:RenderStepped()
					debug.profileend()
				end
			end
		end))
	else
		p1.Maid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 1370 | Upvalues: p1 (copy), v3 (ref) ]]
			if not p1.Destroyed then
				local v1 = os.clock()
				if v1 - v3 > p1:_getUpdateRate() then
					v3 = v1
					debug.profilebegin("Gun RenderStepped")
					p1:RenderStepped()
					debug.profileend()
				end
			end
		end))
	end
	local v4 = 0
	p1.Maid:GiveTask(RunService.Stepped:Connect(function() --[[ Line: 1385 | Upvalues: p1 (copy), v4 (ref) ]]
		if not p1.Destroyed then
			local v1 = os.clock()
			local v2 = p1:_getUpdateRate()
			if p1.Local or p1.SimulateLocal then
				v2 = 0
			end
			if v2 < v1 - v4 then
				v4 = v1
				debug.profilebegin("Gun Stepped")
				p1:Stepped()
				debug.profileend()
			end
		end
	end))
	if p1.Heartbeat then
		p1.Maid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 1403 | Upvalues: p1 (copy) ]]
			if not p1.Destroyed then
				debug.profilebegin("Gun Heartbeat")
				p1:Heartbeat()
				debug.profileend()
			end
		end))
	end
end
function t3.Unequip(p1) --[[ Line: 1412 | Upvalues: CurrentCamera (copy), UI (copy) ]]
	if p1.IsLeaning then
		p1:SetLeaning(false)
	end
	if p1.IsScoping then
		p1:ScopeEnd()
		CurrentCamera.FieldOfView = 70
	end
	if p1.Local and UI.IsOpen == true then
		UI.Close()
	end
end
function t3.Destroy(p1) --[[ Line: 1428 | Upvalues: Item (copy) ]]
	p1:Unequip()
	Item.Destroy(p1)
end
return t3