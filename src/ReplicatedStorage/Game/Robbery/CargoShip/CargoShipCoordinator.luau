local LocalPlayer = game:GetService("Players").LocalPlayer
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local Silo = require(ReplicatedStorage.Game.Silo)
require(ReplicatedStorage.Std.Signal)
local Audio = require(ReplicatedStorage.Std.Audio)
local MinimapService = require(ReplicatedStorage.App.MinimapService)
local Interval = require(ReplicatedStorage.Std.Interval)
local CargoShip = require(script.Parent.CargoShip)
local function GetRootPart()
	local Character = LocalPlayer.Character
	if Character == nil then
		return nil
	else
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid == nil then
			return nil
		else
			return Humanoid.RootPart
		end
	end
end
local CargoShipBay = {}
CargoShipBay.__index = CargoShipBay
setmetatable(CargoShipBay, Silo)
function CargoShipBay.new(model)
	local bay = Silo.new(model)
	setmetatable(bay, CargoShipBay)
	bay.BayMaid = Maid.new()
	bay._door1Part = bay.Model:WaitForChild("Door1")
	bay._door2Part = bay.Model:WaitForChild("Door2")
	bay.Size = bay._door1Part.Size
	bay.BayMaid:GiveTask(Interval.every(0.5):Connect(function()
		local Character = LocalPlayer.Character
		if Character ~= nil then
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid ~= nil then
				local RootPart = Humanoid.RootPart
				if RootPart ~= nil then
					local isWithinRange = (RootPart.Position - bay.Model.Door1.Position).Magnitude < 128
					if isWithinRange ~= bay.IsOpen then
						if isWithinRange then
							bay:Open(2)
							return
						end
						bay:Close(2)
					end
				end
			end
		end
	end))
	return bay
end
function CargoShipBay.SetDoorOpen(bay, openAmount)
	local _door1Part = bay._door1Part
	local depthOffset = -bay.Size.Z * openAmount
	_door1Part.Size = Vector3.new(bay.Size.X, bay.Size.Y, bay.Size.Z + depthOffset)
	_door1Part.CFrame = bay.Door1CF * CFrame.new(0, 0, depthOffset * 0.5)
	local _door2Part = bay._door2Part
	local depthOffset2 = -bay.Size.Z * openAmount
	_door2Part.Size = Vector3.new(bay.Size.X, bay.Size.Y, bay.Size.Z + depthOffset2)
	_door2Part.CFrame = bay.Door2CF * CFrame.new(0, 0, depthOffset2 * 0.5)
end
function CargoShipBay.Destroy(bay)
	bay:SetDoorOpen(0)
	Silo.Destroy(bay)
	bay.BayMaid:DoCleaning()
	bay.BayMaid = nil
end
local cargoShipBinder = Binder.new("CargoShip", CargoShip)
return {
	Init = function(replicatorRef)
		local event = replicatorRef.Event
		local em = replicatorRef.em
		local function OnRocketExploded(explosionPosition)
			local Character = LocalPlayer.Character
			local rootPart
			if Character == nil then
				rootPart = nil
			else
				local Humanoid = Character:FindFirstChild("Humanoid")
				rootPart = if Humanoid == nil then nil else Humanoid.RootPart
			end
			if rootPart ~= nil and (explosionPosition - rootPart.Position).Magnitude < 64 then
				event:FireServer("pk1w8s32", explosionPosition)
			end
		end
		cargoShipBinder:GetClassAddedSignal():Connect(function(cargoShip)
			for i, turret in ipairs(cargoShip.ListTurret) do
				turret.Maid:GiveTask(turret.RocketWorld.OnRocketExploded:Connect(OnRocketExploded))
			end
		end)
		cargoShipBinder:Start()
		function em.kzlkcvqh(shipId, targetPosition)
			for _index, cargoShip in cargoShipBinder:GetAll() do
				if cargoShip:GetId() == shipId then
					cargoShip:SetTurretSeek(targetPosition)
				end
			end
		end
		local currentBay = nil
		local function AddedFun(part)
			assert(currentBay == nil, "Cargo bay already exists!")
			currentBay = CargoShipBay.new(part)
		end
		local function RemovedFun()
			assert(currentBay ~= nil, "Cargo bay already destroyed!")
			currentBay:Destroy()
			currentBay = nil
		end
		for i, cargoDepotDoorPart in ipairs(CollectionService:GetTagged("CargoDepotDoor")) do
			assert(currentBay == nil, "Cargo bay already exists!")
			currentBay = CargoShipBay.new(cargoDepotDoorPart)
		end
		CollectionService:GetInstanceAddedSignal("CargoDepotDoor"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("CargoDepotDoor"):Connect(RemovedFun)
		local soundInstance = nil
		local fadeTask = nil
		function em.gk9ob559(shouldPlay)
			if fadeTask ~= nil then
				fadeTask:Disconnect()
				fadeTask = nil
			end
			if shouldPlay then
				if soundInstance == nil then
					soundInstance = Audio.ObjectLocal(LocalPlayer.PlayerGui, 1837327837, {
						Looped = true,
						Volume = 0
					})
					soundInstance.SoundGroup = game.SoundService.RobberyMusic
				end
				fadeTask = Audio.FadeTo(soundInstance, 0.7, 2, function()
					fadeTask = nil
				end)
			else
				fadeTask = Audio.FadeTo(soundInstance, 0, 4, function()
					soundInstance:Destroy()
					soundInstance = nil
					fadeTask = nil
				end)
			end
		end
		function em.s98gnbty(shouldShow)
			if shouldShow then
				if currentBay ~= nil then
					MinimapService.addWaypoint({
						name = "CargoShip",
						position = (currentBay.Door1CF.p + currentBay.Door2CF.p) * 0.5,
						priority = 1000,
						minDist = 0
					})
				end
			else
				MinimapService.removeWaypointByName("CargoShip")
			end
		end
		function em.c8ag3yrn()
			Audio.ObjectLocal(LocalPlayer.PlayerGui, 1988476450)
		end
	end
}
