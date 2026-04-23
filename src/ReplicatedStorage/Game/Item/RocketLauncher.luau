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
local function RandomVector() --[[ Line: 25 ]]
	local v1 = math.random() * 2 - 1
	local v2 = math.random() * 2 - 1
	return Vector3.new(v1, v2, math.random() * 2 - 1).Unit
end
local function attemptSetSightColor(p1, p2) --[[ Line: 28 ]]
	local PlaneGui = p1.PlaneGui
	local v1 = os.clock()
	if not p1.lastSightsColorChange then
		p1.lastSightsColorChange = 0
	end
	if v1 - p1.lastSightsColorChange < 0.1 then
	elseif PlaneGui.Sights.ImageColor3 ~= p2 then
		p1.lastSightsColorChange = v1
		PlaneGui.Sights.ImageColor3 = p2
	end
end
local function GetTargetPart(p1) --[[ Line: 43 | Upvalues: CollectionService (copy), JetConsts (copy), VehicleUtils (copy) ]]
	local Tip = p1.Model:FindFirstChild("Skeleton"):FindFirstChild("Tip")
	local Position = Tip.Position
	local LookVector = Tip.CFrame.LookVector
	local v1 = 0.9659258262890683
	local v2 = nil
	for v4, v5 in CollectionService:GetTagged(JetConsts.SEEKING_LOCK_TAG_NAME) do
		local v3
		local v6 = VehicleUtils.getParentModel(v5)
		local v7, v8
		if v6 then
			local v9 = VehicleUtils.getVehicleMakeFromModel(v6)
			v3 = if VehicleUtils.getVehicleDataForMake(v9).Type == "Heli" or v9 == "Jet" then true else v9 == "Stunt"
			if v3 and not v5:IsDescendantOf(p1.Model) then
				v7 = v5.Position - Position
				if v7.Magnitude < 768 then
					v8 = v7.Unit:Dot(LookVector)
					if v1 <= v8 then
						v1 = v8
						v2 = v5
					end
				end
			end
		elseif not v5:IsDescendantOf(p1.Model) then
			v7 = v5.Position - Position
			if v7.Magnitude < 768 then
				v8 = v7.Unit:Dot(LookVector)
				if v1 <= v8 then
					v1 = v8
					v2 = v5
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
function t.new(p1, p2, p3) --[[ Line: 79 | Upvalues: Gun (copy), t (copy), RxInstanceUtils (copy), GunSystemConsts (copy), Interval (copy), GetTargetPart (copy), ReplicatedStorage (copy), Players (copy), RunService (copy), CurrentCamera (copy), RocketLauncherConsts (copy), Audio (copy) ]]
	local v1 = Gun.new(p1, p2, p3)
	setmetatable(v1, t)
	v1:Setup(p3)
	v1.maid = v1.Maid
	v1.Maid:GiveTask(RxInstanceUtils.observeOneChildNamed(v1.inventoryItemValue, GunSystemConsts.SHOOT_REMOTE_NAME, function(p1, p2) --[[ Line: 88 | Upvalues: v1 (copy) ]]
		p2:GiveTask(p1.OnClientEvent:Connect(function(p1, p2, p3) --[[ Line: 90 | Upvalues: v1 (ref) ]]
			v1:Shoot(p1, p2, p3)
		end))
	end))
	v1.Maid:GiveTask(Interval.every(0.3333333333333333):Connect(function() --[[ Line: 97 | Upvalues: GetTargetPart (ref), v1 (copy) ]]
		local v12 = GetTargetPart(v1)
		if v12 ~= v1.targetPart then
			v1.targetPart = v12
			if v12 ~= nil then
				v1.targetPartFoundAt = os.clock()
			end
		end
	end))
	if v1.Local then
		local v3 = ReplicatedStorage.Resource.Plane.PlaneGui:Clone()
		v1.PlaneGui = v3
		v3.Sights.Size = UDim2.new(0.08, 0, 0.08, 0)
		v3.Parent = Players.LocalPlayer.PlayerGui
		v1.maid:GiveTask(v3)
		local v4 = true
		local v5 = 0
		local v6 = false
		v1.Maid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 116 | Upvalues: v1 (copy), CurrentCamera (ref), v3 (copy), RocketLauncherConsts (ref), v5 (ref), v4 (ref), Audio (ref), v6 (ref) ]]
			local v12 = os.clock()
			local targetPart = v1.targetPart
			local v2 = if targetPart then targetPart.Position else nil
			if v2 then
				local v32, _ = CurrentCamera:WorldToScreenPoint(v2)
				v3.Sights.Position = UDim2.new(0, v32.X, 0, v32.Y)
				local v42 = v12 - v1.targetPartFoundAt
				local SEEKING_LOCK_MIN_DURATION = RocketLauncherConsts.SEEKING_LOCK_MIN_DURATION
				local v7 = math.cos(28.274333882308138 * math.sqrt(1 - math.min(v42 / SEEKING_LOCK_MIN_DURATION, 1))) * 0.5 + 0.5
				v3.Sights.ImageTransparency = 1 - v7
				local v8 = v5 < v7
				if v8 ~= v4 then
					v4 = v8
					if v8 then
						Audio.ObjectLocal(v3, 6602021732, {
							Volume = 0.05,
							Pitch = 1
						})
					end
				end
				v5 = v7
				if SEEKING_LOCK_MIN_DURATION <= v42 then
					if not v6 then
						Audio.ObjectLocal(v3, 6602021732, {
							Volume = 0.1,
							Pitch = 1.2
						})
					end
					v6 = true
					local v9 = v1
					local v10 = Color3.new(255/255, 0/255, 0/255)
					local PlaneGui = v9.PlaneGui
					local v11 = os.clock()
					if not v9.lastSightsColorChange then
						v9.lastSightsColorChange = 0
					end
					if not (v11 - v9.lastSightsColorChange < 0.1) and PlaneGui.Sights.ImageColor3 ~= v10 then
						v9.lastSightsColorChange = v11
						PlaneGui.Sights.ImageColor3 = v10
					end
				else
					v6 = false
					local v122 = v1
					local v13 = Color3.new(255/255, 255/255, 255/255)
					local PlaneGui = v122.PlaneGui
					local v14 = os.clock()
					if not v122.lastSightsColorChange then
						v122.lastSightsColorChange = 0
					end
					if not (v14 - v122.lastSightsColorChange < 0.1) and PlaneGui.Sights.ImageColor3 ~= v13 then
						v122.lastSightsColorChange = v14
						PlaneGui.Sights.ImageColor3 = v13
					end
				end
			end
			v3.Sights.Visible = v2 ~= nil
		end))
	end
	return v1
end
function t.SetupShoot(p1) --[[ Line: 157 ]] end
function t._shootBroadcast(p1) --[[ Line: 158 ]] end
function t.SetupModel(p1) --[[ Line: 159 | Upvalues: Gun (copy), Joint (copy) ]]
	Gun.SetupModel(p1)
	Joint.Weld(p1.Model.Skeleton.Rocket, p1.BoundingBox)
	p1.Model.Skeleton.Rocket.Anchored = false
end
function t.ShootLocal(p1) --[[ Line: 165 | Upvalues: HapticEffect (copy), ItemCamera (copy) ]]
	if p1.Local then
		HapticEffect.basic(0.5, 0.35)
		p1.SpringCamera:Accelerate(Vector3.new(1, 0, 0) * math.clamp(20 / ItemCamera.GetCameraDistance(), 0.5, 1) * 10)
		p1.CrossHair.Spring:Accelerate(900)
	end
	return true
end
function t.SetupBulletEmitter(p1) --[[ Line: 178 ]] end
function t.LaunchRocket(p1, p2, p3, p4) --[[ Line: 179 | Upvalues: Players (copy), RocketLauncherConsts (copy), Raycast (copy), NetObjPoolBinder (copy), SeekingMissileBinder (copy), GunSystemConsts (copy) ]]
	assert(p2, "missing origin")
	assert(p3, "missing direction")
	assert(p4, "missing speed")
	if p1.Local then
		local LocalPlayer = Players.LocalPlayer
		local v1 = os.clock()
		local v2 = nil
		local Tip = p1.Model:FindFirstChild("Skeleton"):FindFirstChild("Tip")
		local v3 = if p1.targetPart and v1 - p1.targetPartFoundAt >= RocketLauncherConsts.SEEKING_LOCK_MIN_DURATION then p1.targetPart else nil
		p1.targetPartFoundAt = os.clock()
		if not v3 then
			local v4 = RaycastParams.new()
			v4.FilterDescendantsInstances = { p1.Model, LocalPlayer.Character }
			local v5 = Raycast.collidable(Tip.Position, Tip.CFrame.LookVector, 999, v4)
			if v5 then
				v2 = v5.Position
			end
		end
		if not (v3 or v2) then
			v2 = Tip.Position + Tip.CFrame.LookVector * 4096
		end
		local v6 = p1.inventoryItemValue:FindFirstChild(RocketLauncherConsts.MISSILE_OBJ_POOL_NAME)
		if v6 then
			local v7 = NetObjPoolBinder:Get(v6):Get()
			if v7 then
				local obj = v7.obj
				v7:SetActive(false)
				obj.CFrame = Tip.CFrame
				obj.Velocity = Tip.Velocity
				SeekingMissileBinder:Promise(obj):andThen(function(p12) --[[ Line: 224 | Upvalues: p1 (copy), v3 (ref), v2 (ref) ]]
					table.insert(p12.ignoreList, p1.Model)
					p12.raycastParams.FilterDescendantsInstances = p12.ignoreList
					if v3 then
						p12:SetTargetPart(v3)
					else
						p12:SetTargetPos(v2)
					end
				end)
				local v8 = Color3.new(0/255, 255/255, 0/255)
				local PlaneGui = p1.PlaneGui
				local v9 = os.clock()
				if not p1.lastSightsColorChange then
					p1.lastSightsColorChange = 0
				end
				if not (v9 - p1.lastSightsColorChange < 0.1) and PlaneGui.Sights.ImageColor3 ~= v8 then
					p1.lastSightsColorChange = v9
					PlaneGui.Sights.ImageColor3 = v8
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
function t.Shoot(p1) --[[ Line: 239 | Upvalues: Audio (copy), InventoryItemUtils (copy) ]]
	if p1.IsEquipping then
		return false
	else
		local v1 = p1.Tip.CFrame
		Audio.ObjectLocal(p1.Model.Skeleton.Rocket, p1.Config.Sound.weapon_cannon_shot_04, {
			Volume = 1
		})
		if p1.Local then
			p1:ShootLocal()
			p1:LaunchRocket(v1.p, v1.LookVector, p1.Config.RocketSpeed)
			if InventoryItemUtils.getAttr(p1.inventoryItemValue, "AmmoCurrentLocal") > 0 then
				p1:StartReloadProgressCircle(1 / p1.Config.FireFreq)
			end
		end
		return true
	end
end
function t.ShootSound(p1, p2) --[[ Line: 255 | Upvalues: Audio (copy) ]]
	if p2 then
		Audio.ObjectLocal(p1.Model.Skeleton.BoundingBox, p1.Config.Sound.gun_pistol_dry_fire_01, {
			Volume = 0.6,
			Pitch = 1 + math.random() * 0.1 - 0.05
		})
	end
end
function t.ReloadDropAmmoSound(p1) --[[ Line: 264 ]] end
function t.ReloadRefillAmmoSound(p1) --[[ Line: 265 ]] end
function t.ReloadDropAmmoVisual(p1) --[[ Line: 266 ]] end
function t.ReloadRefillAmmoVisual(p1) --[[ Line: 267 ]] end
return t