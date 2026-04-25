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

-- Random vector
local function RandomVector()
	local x = math.random() * 2 - 1
	local y = math.random() * 2 - 1
	local z = math.random() * 2 - 1
	return Vector3.new(x, y, z).Unit
end

-- Sight color throttling
local function attemptSetSightColor(rocketLauncher, color)
	local gui = rocketLauncher.PlaneGui
	local now = os.clock()

	if not rocketLauncher.lastSightsColorChange then
		rocketLauncher.lastSightsColorChange = 0
	end

	if now - rocketLauncher.lastSightsColorChange < 0.1 then
		return
	end

	if gui.Sights.ImageColor3 ~= color then
		rocketLauncher.lastSightsColorChange = now
		gui.Sights.ImageColor3 = color
	end
end

-- Target acquisition
local function GetTargetPart(rocketLauncher)
	local tip = rocketLauncher.Model:FindFirstChild("Skeleton"):FindFirstChild("Tip")
	local origin = tip.Position
	local forward = tip.CFrame.LookVector

	local bestAlignment = 0.9659258262890683
	local bestTarget = nil

	for _, candidatePart in CollectionService:GetTagged(JetConsts.SEEKING_LOCK_TAG_NAME) do
		local vehicleModel = VehicleUtils.getParentModel(candidatePart)

		local function tryTarget()
			local offset = candidatePart.Position - origin
			if offset.Magnitude >= 768 then
				return
			end

			local alignment = offset.Unit:Dot(forward)
			if bestAlignment <= alignment then
				bestAlignment = alignment
				bestTarget = candidatePart
			end
		end

		if vehicleModel then
			local vehicleMake = VehicleUtils.getVehicleMakeFromModel(vehicleModel)
			local vehicleData = VehicleUtils.getVehicleDataForMake(vehicleMake)

			local isAircraft =
				vehicleData.Type == "Heli"
				or vehicleMake == "Jet"
				or vehicleMake == "Stunt"

			if isAircraft and not candidatePart:IsDescendantOf(rocketLauncher.Model) then
				tryTarget()
			end
		elseif not candidatePart:IsDescendantOf(rocketLauncher.Model) then
			tryTarget()
		end
	end

	return bestTarget
end

local RocketLauncher = {
	__ClassName = "RocketLauncher"
}
RocketLauncher.__index = RocketLauncher
setmetatable(RocketLauncher, Gun)

function RocketLauncher.new(player, inventoryItem, config)
	local self = Gun.new(player, inventoryItem, config)
	setmetatable(self, RocketLauncher)

	self:Setup(config)
	self.maid = self.Maid

	-- Shoot remote listener
	self.Maid:GiveTask(
		RxInstanceUtils.observeOneChildNamed(self.inventoryItemValue, GunSystemConsts.SHOOT_REMOTE_NAME, function(remote, maid)
			maid:GiveTask(remote.OnClientEvent:Connect(function(origin, direction, speed)
				self:Shoot(origin, direction, speed)
			end))
		end)
	)

	-- Target tracking
	self.Maid:GiveTask(
		Interval.every(1/3):Connect(function()
			local target = GetTargetPart(self)
			if target ~= self.targetPart then
				self.targetPart = target
				if target then
					self.targetPartFoundAt = os.clock()
				end
			end
		end)
	)

	-- Local UI + tracking
	if self.Local then
		local gui = ReplicatedStorage.Resource.Plane.PlaneGui:Clone()
		self.PlaneGui = gui
		gui.Sights.Size = UDim2.new(0.08, 0, 0.08, 0)
		gui.Parent = Players.LocalPlayer.PlayerGui
		self.maid:GiveTask(gui)

		local wasIncreasing = true
		local lastProgress = 0
		local locked = false

		self.Maid:GiveTask(RunService.Heartbeat:Connect(function()
			local now = os.clock()
			local target = self.targetPart
			local targetPosition = target and target.Position or nil

			if targetPosition then
				local screenPos = CurrentCamera:WorldToScreenPoint(targetPosition)
				gui.Sights.Position = UDim2.new(0, screenPos.X, 0, screenPos.Y)

				local timeTracked = now - self.targetPartFoundAt
				local minLockTime = RocketLauncherConsts.SEEKING_LOCK_MIN_DURATION

				local progress = math.cos(28.274333882308138 * math.sqrt(1 - math.min(timeTracked / minLockTime, 1))) * 0.5 + 0.5
				gui.Sights.ImageTransparency = 1 - progress

				local increasing = lastProgress < progress
				if increasing ~= wasIncreasing then
					wasIncreasing = increasing
					if increasing then
						Audio.ObjectLocal(gui, 6602021732, { Volume = 0.05, Pitch = 1 })
					end
				end

				lastProgress = progress

				if timeTracked >= minLockTime then
					if not locked then
						Audio.ObjectLocal(gui, 6602021732, { Volume = 0.1, Pitch = 1.2 })
					end
					locked = true
					attemptSetSightColor(self, Color3.new(1, 0, 0))
				else
					locked = false
					attemptSetSightColor(self, Color3.new(1, 1, 1))
				end
			end

			gui.Sights.Visible = targetPosition ~= nil
		end))
	end

	return self
end