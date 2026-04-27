game:GetService("CollectionService")
game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local StreamingHelperUtils = require(ReplicatedStorage.App.StreamingHelperUtils)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Players = game:GetService("Players")
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local LocalPlayer = Players.LocalPlayer
local vehicleList = {}
local vehicleById = {}
local modulesByClassName = {}
local function RegisterModule(moduleClass)
	assert(moduleClass.__ClassName ~= nil)
	modulesByClassName[moduleClass.__ClassName] = moduleClass
end
local function Isv2(vehicle)
	return vehicle.Meta ~= nil
end
local function Init(event)
	local _ = event.Event
	local function copyTableRecursive(sourceTable, targetTable)
		for key, value in next, sourceTable do
			if type(value) == "table" then
				copyTableRecursive(value, targetTable)
			else
				targetTable[key] = value
			end
		end
	end
	local function ProcessPacket(packetData)
		assert(packetData)
		local packetId = packetData.Id
		assert(packetId)
		if vehicleById[packetId] == nil then
			local vehicleModule = modulesByClassName[packetData.ClassName]
			if vehicleModule == nil then
				error("No vehicle module has been registered for class name: " .. packetData.ClassName)
			end
			if vehicleModule.FromPacket then
				vehicleModule.FromPacket(packetData)
			else
				packetData = vehicleModule.new(packetData)
			end
			if packetData.Maid == nil then
				warn("No maid for vehicle packet", packetData)
			end
			assert(packetData.Seats, "Vehicle needs seats")
			local vehicleMaid = packetData.Maid
			for seatIndex, seatData in packetData.Seats do
				local PlayerName = seatData.Part:WaitForChild("PlayerName")
				seatData.Occupied = false
				seatData.Maid = Maid.new()
				local function update()
					local wasOccupied = seatData.Occupied
					local foundPlayer = Players:FindFirstChild(PlayerName.Value)
					local isOccupied = foundPlayer ~= nil
					if isOccupied then
						seatData.Player = foundPlayer
						seatData.Occupied = isOccupied
						seatData.Maid:DoCleaning()
					end
					if isOccupied ~= wasOccupied and isOccupied then
						packetData:MountPlayer(seatData.Player, seatData)
					elseif isOccupied ~= wasOccupied then
						packetData:UnmountSeat(seatData)
					end
					if not isOccupied then
						seatData.Player = foundPlayer
						seatData.Occupied = isOccupied
						seatData.Maid:DoCleaning()
					end
				end
				update()
				vehicleMaid:GiveTask(PlayerName.Changed:Connect(update))
			end
			table.insert(vehicleList, packetData)
			vehicleById[packetId] = packetData
		else
			if vehicleById[packetId].Meta ~= nil then
				copyTableRecursive(packetData, vehicleById[packetId].Meta)
			else
				copyTableRecursive(packetData, vehicleById[packetId])
			end
		end
	end
	local function removeIdFromList(idToRemove)
		for i = #vehicleList, 1, -1 do
			local hasMeta, actualId
			local currentVehicle = vehicleList[i]
			hasMeta = currentVehicle.Meta ~= nil
			actualId = if hasMeta then currentVehicle.Meta.Id else currentVehicle.Id
			assert(actualId)
			if actualId == idToRemove then
				vehicleById[actualId] = nil
				table.remove(vehicleList, i)
				if currentVehicle.Seats then
					for j = 1, #currentVehicle.Seats do
						local seatToUnmount = currentVehicle.Seats[j]
						if seatToUnmount.Occupied then
							currentVehicle:UnmountSeat(seatToUnmount)
							seatToUnmount.Maid:DoCleaning()
						end
					end
				end
				currentVehicle:Destroy()
			end
		end
	end
	Binder.new("VehicleSystemPacket", function(instanceData)
		task.wait()
		local packetMaid = Maid.new()
		StreamingHelperUtils.yieldForAllValuesPopulated(instanceData)
		local vehiclePacket = TableUtils.createTableFromObjectValues(instanceData)
		local vehicleId = if vehiclePacket.Meta ~= nil then vehiclePacket.Meta.Id else vehiclePacket.Id
		local function create()
			ProcessPacket(vehiclePacket)
		end
		local function destroy()
			removeIdFromList(vehicleId)
		end
		packetMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(vehiclePacket.Model, "BoundingBox", function(boundingBox, maidInstance)
			ProcessPacket(vehiclePacket)
			maidInstance:GiveTask(destroy)
		end))
		return packetMaid
	end):Start()
	function event.em.ih5093c4(vehicleToFollow)
		local vehicleInstance = vehicleById[vehicleToFollow]
		assert(vehicleInstance)
		vehicleInstance:FollowPlayer(LocalPlayer)
	end
end
local function GetVehiclePacket(targetPlayer)
	for i = 1, #vehicleList do
		local currentVehicle = vehicleList[i]
		for j = 1, #currentVehicle.Seats do
			local seatInfo = currentVehicle.Seats[j]
			if seatInfo.Occupied and seatInfo.Player == targetPlayer then
				return currentVehicle, seatInfo
			end
		end
	end
	return nil
end
return {
	Init = Init,
	RegisterModule = RegisterModule,
	GetVehiclePacket = GetVehiclePacket,
	WaitForVehiclePacket = function(targetPlayer)
		local startTime = os.clock()
		while os.clock() - startTime < 5 do
			local foundVehicle, foundSeat = GetVehiclePacket(targetPlayer)
			if foundVehicle ~= nil then
				return foundVehicle, foundSeat
			end
			task.wait()
		end
		return nil
	end,
	GetPlayerSeat = function(vehiclePacket, playerToFind)
		assert(vehiclePacket ~= nil)
		assert(playerToFind ~= nil)
		for i = 1, #vehiclePacket.Seats do
			local seatToCheck = vehiclePacket.Seats[i]
			if seatToCheck.Occupied and seatToCheck.Player == playerToFind then
				return seatToCheck
			end
		end
		return nil
	end
}
