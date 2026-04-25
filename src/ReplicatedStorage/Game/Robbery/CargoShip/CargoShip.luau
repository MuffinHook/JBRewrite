-- Reviewed by Claude
-- variables reassigned
local CurrentCamera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Time = require(ReplicatedStorage.Module.Time)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local Audio = require(ReplicatedStorage.Std.Audio)
local Turret = require(ReplicatedStorage.Turret2.Turret)
local CargoShipShared = require(script.Parent.CargoShipShared)
local zeroVector = Vector3.new()
local function GetHumanoid(p1)
	local Character = p1.Character
	if Character == nil then
		return nil
	else
		return Character:FindFirstChild("Humanoid")
	end
end
local function GetRootPart(p1)
	local Character = p1.Character
	local humanoid = if Character == nil then nil else Character:FindFirstChild("Humanoid")
	if humanoid == nil then
		return nil
	else
		return humanoid.RootPart
	end
end
local t = {}
t.__index = t
function t.new(p1)
	assert(p1 ~= nil)
	local cargoShip = {}
	setmetatable(cargoShip, t)
	RxInstanceUtils.yieldForProperty(p1, "PrimaryPart")
	cargoShip.Model = p1
	cargoShip.Maid = Maid.new()
	cargoShip.ListTurret = { Turret.new(cargoShip.Model.TurretFront), (Turret.new(cargoShip.Model.TurretBack)) }
	cargoShip.Path = CargoShipShared.GetPath()
	cargoShip._cargoShipIdObj = p1:WaitForChild("CargoShipId")
	local CargoShipBornAt = p1:WaitForChild("CargoShipBornAt")
	cargoShip.BornAt = CargoShipBornAt.Value
	cargoShip.Maid:GiveTask(CargoShipBornAt.Changed:Connect(function()
		cargoShip.BornAt = CargoShipBornAt.Value
	end))
	local tripDuration = cargoShip.Path.ApproxLength / CargoShipShared.Speed
	cargoShip.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		local currentTime = Time.GetNowSync()
		local pathProgress = (currentTime - cargoShip.BornAt) / tripDuration
		if pathProgress > 1 then
			pathProgress = 1
		end
		cargoShip.SwayZ = math.cos(currentTime * 1.8) * 0.15
		cargoShip.SwayX = math.sin(currentTime * 1.5) * 0.1
		local pathPosition, pathCFrame = cargoShip.Path:GetWorldPositionAt(cargoShip.Path.ApproxLength * pathProgress)
		local swayRotation = CFrame.Angles(0, 0, cargoShip.SwayZ * math.pi * 0.05) * CFrame.Angles(cargoShip.SwayX * math.pi * 0.05, 0, 0)
		cargoShip:SetPrimaryPartCFrame(CFrame.new(zeroVector, pathCFrame) * swayRotation + pathPosition)
	end))
	local nextHornTick = nil
	local function ChooseNextHorn()
		assert(true)
		nextHornTick = tick() + 60 * (1 + math.random() * 1)
	end
	assert(true)
	nextHornTick = tick() + 60 * (1 + math.random() * 1)
	cargoShip.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		if cargoShip.Model:IsDescendantOf(workspace) == false then
			cargoShip:Destroy()
		else
			for i, v in ipairs(cargoShip.ListTurret) do
				local turretHumanoid, turretRootPart
				if v.TargetUserId ~= nil then
					local targetPlayer = Players:GetPlayerByUserId(v.TargetUserId)
					if targetPlayer ~= nil then
						local Character = targetPlayer.Character
						turretHumanoid = if Character == nil then nil else Character:FindFirstChild("Humanoid")
						turretRootPart = if turretHumanoid == nil then nil else turretHumanoid.RootPart
						if turretRootPart ~= nil then
							v:PointAt(turretRootPart.Position)
							v:Update()
						end
					end
				end
			end
			if nextHornTick < tick() then
				assert(true)
				nextHornTick = tick() + 60 * (1 + math.random() * 1)
				cargoShip:FireHorn()
			end
		end
	end))
	cargoShip:FireHorn()
	Audio.ObjectLocal(cargoShip.Model.PrimaryPart, 5144228425, {
		Looped = true,
		Volume = 1,
		MaxDistance = 512,
		EmitterSize = 128
	})
	cargoShip:ListenForFirstPickup()
	return cargoShip
end
function t.GetId(p1)
	return p1._cargoShipIdObj.Value
end
function t.FireHorn(p1)
	Audio.ObjectLocal(p1.Model.PrimaryPart, 5128574531, {
		MaxDistance = 4000,
		EmitterSize = 256,
		Volume = 1,
		RollOffMode = Enum.RollOffMode.Linear
	})
end
function t.ListenForFirstPickup(p1)
	local childAddedConnection = nil
	childAddedConnection = p1.Model.ChildAdded:Connect(function(p12)
		if p12.Name == "HasFirstRobbed" then
			childAddedConnection:Disconnect()
			Audio.ObjectLocal(p1.Model.PrimaryPart, 5136785479, {
				Looped = true,
				Volume = 1,
				MaxDistance = 1024,
				EmitterSize = 64
			})
		end
	end)
end
function t.SetTurretSeek(p1, p2)
	for i, v in ipairs(p1.ListTurret) do
		v.TargetUserId = p2[v.Model.Name]
	end
end
function t.SetPrimaryPartCFrame(p1, p2)
	local isPlayerOnCargo = false
	local Character = LocalPlayer.Character
	local playerHumanoid = if Character == nil then nil else Character:FindFirstChild("Humanoid")
	local playerRootPart = if playerHumanoid == nil then nil else playerHumanoid.RootPart
	if playerRootPart then
		local playerCFrame = playerRootPart.CFrame
		local raycastHit = RayCast.RayIgnoreNonCollide(playerCFrame.p, -playerCFrame.UpVector, 16, playerRootPart.Parent)
		if raycastHit and raycastHit:IsDescendantOf(p1.Model) then
			isPlayerOnCargo = true
		end
	end
	local oldCFrame = p1.Model.PrimaryPart.CFrame
	p1.Model.PrimaryPart.CFrame = p2
	if isPlayerOnCargo then
		local cfromeDelta = p2 * oldCFrame:Inverse()
		playerRootPart.CFrame = cfromeDelta * playerRootPart.CFrame
		local cameraSpaceOffset = CurrentCamera.CFrame:ToObjectSpace(CurrentCamera.Focus)
		CurrentCamera.CFrame = CurrentCamera.CFrame * cameraSpaceOffset * (cfromeDelta - cfromeDelta.p) * cameraSpaceOffset:Inverse()
	end
end
function t.Destroy(p1)
	p1.Maid:Destroy()
	p1.Maid = nil
end
return t
