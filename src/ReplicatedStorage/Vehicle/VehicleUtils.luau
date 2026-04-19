local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterPlayer = game:GetService("StarterPlayer")

local ServerLoggingUtils
if RunService:IsServer() then
	ServerLoggingUtils = require(game:GetService("ServerStorage").Logging.ServerLoggingUtils)
end

local Signal = require(ReplicatedStorage.Std.Signal)
local VehicleConsts = require(ReplicatedStorage.Vehicle.VehicleConsts)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local Roact = require(ReplicatedStorage.Roact)
local Confirmation = require(ReplicatedStorage.Module.Confirmation)
local VehicleCombatData = require(ReplicatedStorage.Game.Garage.VehicleCombatData)
local VehicleData = require(ReplicatedStorage.Game.Garage.VehicleData)

local Audio = require(ReplicatedStorage.Std.Audio)
local Shockwave = require(ReplicatedStorage.Game.Shockwave)
local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)

local CameraController

local VehicleUtils = {
	ClassName = "VehicleUtils",

	OnVehicleEntered = Signal.new(),
	OnVehicleExited = Signal.new(),
	OnVehicleJumpExited = Signal.new(),

	LastMPHClient = 0,
	LastVehicleExit = 0,
	LastVehicleEject = 0,

	Classes = {},
}

--// VEHICLE PACKET

function VehicleUtils.GetLocalVehiclePacket()
	if RunService:IsStudio() and RunService:IsServer() and RunService:IsClient() then
		return {
			Type = "Chassis",
			Make = "Camaro",
			Model = ReplicatedStorage.Resource.Vehicles:FindFirstChild("Camaro"),
		}
	end

	return nil
end

function VehicleUtils.GetLocalVehiclePacketForCustomize()
	local packet = VehicleUtils.GetLocalVehiclePacket()

	if not packet or RunUtils.isTradeWorld() then
		return {
			Type = "Chassis",
			Make = "Camaro",
		}
	end

	return packet
end

--// INIT

function VehicleUtils.Init(config)
	CameraController = require(
		Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
	):GetCameras()

	VehicleUtils.GetLocalVehiclePacket = config.GetVehiclePacket
	VehicleUtils.nitroState = config.nitroState

	local binding, updateBinding = Roact.createBinding(0)
	VehicleUtils.spdBarRatio = binding
	VehicleUtils.updateSpdBarRatio = updateBinding

	local em = config.em
	local RemoteEvent = config.Event

	function em.setVehicleEjectTime(time)
		VehicleUtils.LastVehicleEject = time
	end

	function VehicleUtils.canLocalLock()
		local packet = VehicleUtils.GetLocalVehiclePacket()

		return packet
			and not packet.Passenger
			and packet.Model
			and not packet.Model:GetAttribute("DisableLocking")
	end

	function VehicleUtils.toggleLocalLocked()
		local model = VehicleUtils.GetLocalVehiclePacket().Model
		local locked = model:GetAttribute("Locked") ~= true

		RemoteEvent:FireServer("toggleLock", locked)
	end

	function VehicleUtils.canLocalEject()
		local packet = VehicleUtils.GetLocalVehiclePacket()

		return packet
			and not packet.Passenger
			and packet.Model
			and not packet.Model:GetAttribute("DisableEjecting")
	end

	function VehicleUtils.attemptPassengerEject(target)
		RemoteEvent:FireServer("ejectPassenger", target)
	end

	function VehicleUtils.attemptBuyMissiles()
		RemoteEvent:FireServer("buyMissiles")
	end

	local isPromptOpen = false

	function VehicleUtils.promptMissileBuy()
		if isPromptOpen then return end
		isPromptOpen = true

		local prompt = Confirmation.new("Buy 10 Explosives for $5,000?")

		prompt.Maid:GiveTask(prompt.OnYes:Connect(function()
			VehicleUtils.attemptBuyMissiles()
		end))

		prompt.Maid:GiveTask(function()
			isPromptOpen = false
		end)
	end

	function em.vehicleEffect(...)
		VehicleUtils.vehicleEffect(...)
	end
end

--// BASIC GETTERS

function VehicleUtils.GetLocalVehicleModel()
	local packet = VehicleUtils.GetLocalVehiclePacket()
	return packet and packet.Model or nil
end

--// CLEANUP

function VehicleUtils.CleanVehicleModel(model)
	for _, obj in ipairs(model:GetDescendants()) do
		if not obj:IsA("BasePart")
			and not obj:IsA("Model")
			and not obj:IsA("ValueBase") then
			obj:Destroy()
		end
	end
end

--// LIGHTS

function VehicleUtils.getHeadlights(vehicle)
	local lights = {}

	for _, part in ipairs(vehicle.Model.Body:GetChildren()) do
		if part.Name == "Headlight" then
			local light = part:FindFirstChildWhichIsA("Light")
			if light then
				table.insert(lights, light)
			end
		end
	end

	return lights
end

function VehicleUtils.setHeadlightsEnabled(vehicle, enabled)
	local model = vehicle:FindFirstChild("Model")
	if not model then return end

	local body = model:FindFirstChild("Body")
	if not body then return end

	for _, part in ipairs(body:GetChildren()) do
		if part.Name == "Headlight" then
			local light = part:FindFirstChildWhichIsA("Light")
			if light then
				light.Enabled = enabled
			end
		end
	end
end

function VehicleUtils.setBrakelightsEnabled(vehicle, enabled)
	local model = vehicle:FindFirstChild("Model")
	if not model then return end

	local body = model:FindFirstChild("Body")
	if not body then return end

	for _, part in ipairs(body:GetChildren()) do
		if part.Name == "Brakelight" then
			local light = part:FindFirstChildWhichIsA("Light")
			if light then
				light.Enabled = enabled
			end
		end
	end

	vehicle:SetAttribute("BrakeLightEnabled", enabled)
end

function VehicleUtils.getBrakelightsEnabled(vehicle)
	return vehicle:GetAttribute("BrakeLightEnabled") == true
end

--// TIRES

function VehicleUtils.getTireHealth(vehicle)
	return vehicle:GetAttribute(VehicleConsts.TIRE_HEALTH_ATTR_NAME)
end

function VehicleUtils.setTireHealth(vehicle, value)
	vehicle:SetAttribute(VehicleConsts.TIRE_HEALTH_ATTR_NAME, value)
end

function VehicleUtils.getTireMaxHealth(vehicle)
	return vehicle:GetAttribute(VehicleConsts.TIRE_MAX_HEALTH_ATTR_NAME)
end

--// VEHICLE LOOKUP

function VehicleUtils.getVehicleDataForMake(make)
	for _, data in ipairs(VehicleData) do
		if data.Make == make then
			return data
		end
	end

	error("Invalid make: " .. make)
end

--// VEHICLE EFFECT

function VehicleUtils.vehicleEffect(effectType, vehicle)
	Audio.ObjectLocal(nil, 130019374714708, {
		Volume = 0.5,
	})

	if effectType == "Nuke" and vehicle and vehicle.PrimaryPart then
		Shockwave.new(vehicle.PrimaryPart.Position, {
			Duration = 12,
			MaxRadius = 6400,
			Power = 80,
		}).OnPastLocalPlayer:Connect(function()
			local packet = VehicleUtils.GetLocalVehiclePacket()

			if packet and packet.Make == "AdminNuke" and not packet.Passenger then
				VehicleUtils.Classes.Chassis.runAction(true)
				return
			end

			CharacterUtil.OnJump()
			task.wait(0.1)
		end)
	end
end

return VehicleUtils