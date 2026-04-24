-- Reviewed by Claude
local CurrentCamera = workspace.CurrentCamera
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HapticEffect = require(ReplicatedStorage.App.HapticEffect)
local ItemCamera = require(ReplicatedStorage.Game.ItemSystem.ItemCamera)
local Joint = require(ReplicatedStorage.Std.Joint)
local Audio = require(ReplicatedStorage.Std.Audio)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local GunSystemConsts = require(ReplicatedStorage.Game.ItemSystem.GunSystemConsts)
local JetConsts = require(ReplicatedStorage.Game.Plane.JetConsts)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local NetObjPoolBinder = require(ReplicatedStorage.NetObjPool.NetObjPoolBinder)
local RocketLauncherConsts = require(ReplicatedStorage.RocketLauncher.RocketLauncherConsts)
require(ReplicatedStorage.RocketLauncher.RocketLauncherUtils)
local SeekingMissileBinder = require(ReplicatedStorage.SeekingMissile.SeekingMissileBinder)
local Interval = require(ReplicatedStorage.Std.Interval)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local Gun = require(script.Parent.Gun)
local function RandomVector()
	local instance = math.random() * 2 - 1
	local v2 = math.random() * 2 - 1
	return Vector3.new(instance, v2, math.random() * 2 - 1).Unit
end
local function attemptSetSightColor(p1, p2)
	local PlaneGui = p1.PlaneGui
	local instance = os.clock()
	if not p1.lastSightsColorChange then
		p1.lastSightsColorChange = 0
	end
	if instance - p1.lastSightsColorChange < 0.1 then
	elseif PlaneGui.Sights.ImageColor3 ~= p2 then
		p1.lastSightsColorChange = instance
		PlaneGui.Sights.ImageColor3 = p2
	end
end
local function GetTargetPart(p1)
	local Tip = p1.Model:FindFirstChild("Skeleton"):FindFirstChild("Tip")
	local Position = Tip.Position
	local LookVector = Tip.CFrame.LookVector
	local instance = 0.9659258262890683
	local v2 = nil
	for var4, var5 in CollectionService:GetTagged(JetConsts.SEEKING_LOCK_TAG_NAME) do
		local var3
		local var6 = VehicleUtils.getParentModel(var5)
		local var7, var8
		if var6 then
			local var9 = VehicleUtils.getVehicleMakeFromModel(var6)
			var3 = if VehicleUtils.getVehicleDataForMake(var9).Type == "Heli" or var9 == "Jet" then true else var9 == "Stunt"
			if var3 and not var5:IsDescendantOf(p1.Model) then
				var7 = var5.Position - Position
				if var7.Magnitude < 768 then
					var8 = var7.Unit:Dot(LookVector)
					if instance <= var8 then
						instance = var8
						v2 = var5
					end
				end
			end
		elseif not var5:IsDescendantOf(p1.Model) then
			var7 = var5.Position - Position
			if var7.Magnitude < 768 then
				var8 = var7.Unit:Dot(LookVector)
				if instance <= var8 then
					instance = var8
					v2 = var5
				end
			end
		end
	end
	return v2
end
local t = {
	__ClassName = "RocketLauncher"
}
t.__index = t
setmetatable(t, Gun)
function t.new(p1, p2, p3)
	local instance = Gun.new(p1, p2, p3)
	setmetatable(instance, t)
	instance:Setup(p3)
	instance.maid = instance.Maid
	instance.Maid:GiveTask(RxInstanceUtils.observeOneChildNamed(instance.inventoryItemValue, GunSystemConsts.SHOOT_REMOTE_NAME, function(p1, p2)
		p2:GiveTask(p1.OnClientEvent:Connect(function(p1, p2, p3)
			instance:Shoot(p1, p2, p3)
		end))
	end))
	instance.Maid:GiveTask(Interval.every(0.3333333333333333):Connect(function()
		local var12 = GetTargetPart(instance)
		if var12 ~= instance.targetPart then
			instance.targetPart = var12
			if var12 ~= nil then
				instance.targetPartFoundAt = os.clock()
			end
		end
	end))
	if instance.Local then
		local var3 = ReplicatedStorage.Resource.Plane.PlaneGui:Clone()
		instance.PlaneGui = var3
		var3.Sights.Size = UDim2.new(0.08, 0, 0.08, 0)
		var3.Parent = Players.LocalPlayer.PlayerGui
		instance.maid:GiveTask(var3)
		local var4 = true
		local var5 = 0
		local var6 = false
		instance.Maid:GiveTask(RunService.Heartbeat:Connect(function()
			local var12 = os.clock()
			local targetPart = instance.targetPart
			local v2 = if targetPart then targetPart.Position else nil
			if v2 then
				local v32, _ = CurrentCamera:WorldToScreenPoint(v2)
				var3.Sights.Position = UDim2.new(0, v32.X, 0, v32.Y)
				local var42 = var12 - instance.targetPartFoundAt
				local SEEKING_LOCK_MIN_DURATION = RocketLauncherConsts.SEEKING_LOCK_MIN_DURATION
				local var7 = math.cos(28.274333882308138 * math.sqrt(1 - math.min(var42 / SEEKING_LOCK_MIN_DURATION, 1))) * 0.5 + 0.5
				var3.Sights.ImageTransparency = 1 - var7
				local var8 = var5 < var7
				if var8 ~= var4 then
					var4 = var8
					if var8 then
						Audio.ObjectLocal(var3, 6602021732, {
							Volume = 0.05,
							Pitch = 1
						})
					end
				end
				var5 = var7
				if SEEKING_LOCK_MIN_DURATION <= var42 then
					if not var6 then
						Audio.ObjectLocal(var3, 6602021732, {
							Volume = 0.1,
							Pitch = 1.2
						})
					end
					var6 = true
					local var9 = instance
					local color10 = Color3.new(255/255, 0/255, 0/255)
					local PlaneGui = var9.PlaneGui
					local var11 = os.clock()
					if not var9.lastSightsColorChange then
						var9.lastSightsColorChange = 0
					end
					if not (var11 - var9.lastSightsColorChange < 0.1) and PlaneGui.Sights.ImageColor3 ~= color10 then
						var9.lastSightsColorChange = var11
						PlaneGui.Sights.ImageColor3 = color10
					end
				else
					var6 = false
					local var122 = instance
					local color13 = Color3.new(255/255, 255/255, 255/255)
					local PlaneGui = var122.PlaneGui
					local var14 = os.clock()
					if not var122.lastSightsColorChange then
						var122.lastSightsColorChange = 0
					end
					if not (var14 - var122.lastSightsColorChange < 0.1) and PlaneGui.Sights.ImageColor3 ~= color13 then
						var122.lastSightsColorChange = var14
						PlaneGui.Sights.ImageColor3 = color13
					end
				end
			end
			var3.Sights.Visible = v2 ~= nil
		end))
	end
	return instance
end
function t.SetupShoot(p1)  end
function t._shootBroadcast(p1)  end
function t.SetupModel(p1)
	Gun.SetupModel(p1)
	Joint.Weld(p1.Model.Skeleton.Rocket, p1.BoundingBox)
	p1.Model.Skeleton.Rocket.Anchored = false
end
function t.ShootLocal(p1)
	if p1.Local then
		HapticEffect.basic(0.5, 0.35)
		p1.SpringCamera:Accelerate(Vector3.new(1, 0, 0) * math.clamp(20 / ItemCamera.GetCameraDistance(), 0.5, 1) * 10)
		p1.CrossHair.Spring:Accelerate(900)
	end
	return true
end
function t.SetupBulletEmitter(p1)  end
function t.LaunchRocket(p1, p2, p3, p4)
	assert(p2, "missing origin")
	assert(p3, "missing direction")
	assert(p4, "missing speed")
	if p1.Local then
		local LocalPlayer = Players.LocalPlayer
		local instance = os.clock()
		local v2 = nil
		local Tip = p1.Model:FindFirstChild("Skeleton"):FindFirstChild("Tip")
		local var3 = if p1.targetPart and instance - p1.targetPartFoundAt >= RocketLauncherConsts.SEEKING_LOCK_MIN_DURATION then p1.targetPart else nil
		p1.targetPartFoundAt = os.clock()
		if not var3 then
			local var4 = RaycastParams.new()
			var4.FilterDescendantsInstances = { p1.Model, LocalPlayer.Character }
			local var5 = Raycast.collidable(Tip.Position, Tip.CFrame.LookVector, 999, var4)
			if var5 then
				v2 = var5.Position
			end
		end
		if not (var3 or v2) then
			v2 = Tip.Position + Tip.CFrame.LookVector * 4096
		end
		local var6 = p1.inventoryItemValue:FindFirstChild(RocketLauncherConsts.MISSILE_OBJ_POOL_NAME)
		if var6 then
			local var7 = NetObjPoolBinder:Get(var6):Get()
			if var7 then
				local obj = var7.obj
				var7:SetActive(false)
				obj.CFrame = Tip.CFrame
				obj.Velocity = Tip.Velocity
				SeekingMissileBinder:Promise(obj):andThen(function(p12)
					table.insert(p12.ignoreList, p1.Model)
					p12.raycastParams.FilterDescendantsInstances = p12.ignoreList
					if var3 then
						p12:SetTargetPart(var3)
					else
						p12:SetTargetPos(v2)
					end
				end)
				local var8 = Color3.new(0/255, 255/255, 0/255)
				local PlaneGui = p1.PlaneGui
				local var9 = os.clock()
				if not p1.lastSightsColorChange then
					p1.lastSightsColorChange = 0
				end
				if not (var9 - p1.lastSightsColorChange < 0.1) and PlaneGui.Sights.ImageColor3 ~= var8 then
					p1.lastSightsColorChange = var9
					PlaneGui.Sights.ImageColor3 = var8
				end
				p1.inventoryItemValue:FindFirstChild(GunSystemConsts.SHOOT_REMOTE_NAME):FireServer(p2, p3, p4, obj)
			else
				warn("No missile available in pool")
				return
			end
		else
			warn("No missile pool obj available")
			return
		end
	end
end
function t.Shoot(p1)
	if p1.IsEquipping then
		return false
	else
		local instance = p1.Tip.CFrame
		Audio.ObjectLocal(p1.Model.Skeleton.Rocket, p1.Config.Sound.weapon_cannon_shot_04, {
			Volume = 1
		})
		if p1.Local then
			p1:ShootLocal()
			p1:LaunchRocket(instance.p, instance.LookVector, p1.Config.RocketSpeed)
			if InventoryItemUtils.getAttr(p1.inventoryItemValue, "AmmoCurrentLocal") > 0 then
				p1:StartReloadProgressCircle(1 / p1.Config.FireFreq)
			end
		end
		return true
	end
end
function t.ShootSound(p1, p2)
	if p2 then
		Audio.ObjectLocal(p1.Model.Skeleton.BoundingBox, p1.Config.Sound.gun_pistol_dry_fire_01, {
			Volume = 0.6,
			Pitch = 1 + math.random() * 0.1 - 0.05
		})
	end
end
function t.ReloadDropAmmoSound(p1)  end
function t.ReloadRefillAmmoSound(p1)  end
function t.ReloadDropAmmoVisual(p1)  end
function t.ReloadRefillAmmoVisual(p1)  end
return t
