local CollectionService = game:GetService("CollectionService")
local CurrentCamera = workspace.CurrentCamera
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")
local RunService = game:GetService("RunService")
local instance
if RunService:IsServer() then
	local ServerStorage = game:GetService("ServerStorage")
	instance = require(ServerStorage.Logging.ServerLoggingUtils)
else
	instance = nil
end
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
local VehicleCombatData = require(ReplicatedStorage.Game.Garage.VehicleCombatData)
local VehicleData = require(ReplicatedStorage.Game.Garage.VehicleData)
local Roact = require(ReplicatedStorage.Roact)
local Signal = require(ReplicatedStorage.Std.Signal)
local Confirmation = require(ReplicatedStorage.Module.Confirmation)
local VehicleConsts = require(ReplicatedStorage.Vehicle.VehicleConsts)
local Audio = require(ReplicatedStorage.Std.Audio)
local Shockwave = require(ReplicatedStorage.Game.Shockwave)
local cameraModule = nil
local VehicleUtils = {
	OnVehicleEntered = Signal.new(),
	OnVehicleExited = Signal.new(),
	OnVehicleJumpExited = Signal.new(),
	LastMPHClient = 0,
	GetLocalVehiclePacket = function()
		if RunService:IsStudio() and (RunService:IsServer() and RunService:IsClient()) then
			return {
				Type = "Chassis",
				Make = "Camaro",
				Model = ReplicatedStorage.Resource.Vehicles:FindFirstChild("Camaro")
			}
		else
			return nil
		end
	end
}
function VehicleUtils.GetLocalVehiclePacketForCustomize()
	local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
	if vehiclePacket and not RunUtils.isTradeWorld() then
		return vehiclePacket
	else
		return {
			Type = "Chassis",
			Make = "Camaro"
		}
	end
end
function VehicleUtils.Init(vehicleConfig)
	cameraModule = require(Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetCameras()
	VehicleUtils.LastVehicleExit = 0
	VehicleUtils.LastVehicleEject = 0
	VehicleUtils.GetLocalVehiclePacket = vehicleConfig.GetVehiclePacket
	VehicleUtils.Classes = {}
	local speedBarBinding, updateSpeedBarRatio = Roact.createBinding(0)
	VehicleUtils.spdBarRatio = speedBarBinding
	VehicleUtils.updateSpdBarRatio = updateSpeedBarRatio
	VehicleUtils._forceUpdateNitroBar = false
	VehicleUtils.nitroState = vehicleConfig.nitroState
	local eventManager = vehicleConfig.em
	local eventSignal = vehicleConfig.Event
	function eventManager.scrfqlpx(ejectTime)
		VehicleUtils.LastVehicleEject = ejectTime
	end
	function VehicleUtils.canLocalLock()
		local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
		return vehiclePacket and (not vehiclePacket.Passenger and (vehiclePacket.Model and not vehiclePacket.Model:GetAttribute("DisableLocking"))) and true or false
	end
	function VehicleUtils.toggleLocalLocked()
		local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
		eventSignal:FireServer("lockVehicle", vehiclePacket.Model:GetAttribute("Locked") ~= true)
	end
	function VehicleUtils.canLocalEject()
		local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
		return vehiclePacket and (not vehiclePacket.Passenger and (vehiclePacket.Model and not vehiclePacket.Model:GetAttribute("DisableEjecting"))) and true or false
	end
	function VehicleUtils.attemptPassengerEject(passenger)
		eventSignal:FireServer("ejectPassenger", passenger)
	end
	function VehicleUtils.attemptBuyMissiles()
		eventSignal:FireServer("attemptBuyMissiles")
	end
	local isMissileConfirmationOpen = false
	function VehicleUtils.promptMissileBuy()
		if not isMissileConfirmationOpen then
			isMissileConfirmationOpen = true
			local confirmationDialog = Confirmation.new("Buy 10 Explosives for $5,000?")
			confirmationDialog.Maid:GiveTask(confirmationDialog.OnYes:Connect(function()
				VehicleUtils.attemptBuyMissiles()
			end))
			confirmationDialog.Maid:GiveTask(function()
				isMissileConfirmationOpen = false
			end)
		end
	end
	function eventManager.asxzm3xn(...)
		VehicleUtils.vehicleEffect(...)
	end
end
function VehicleUtils.GetLocalVehicleModel()
	local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
	if vehiclePacket == nil then
		return false
	else
		return vehiclePacket.Model
	end
end
function VehicleUtils.CleanVehicleModel(vehicleModel)
	local descendants = vehicleModel:GetDescendants()
	for i = 1, #descendants do
		local descendant = descendants[i]
		if not (descendant:IsA("BasePart") or (descendant:IsA("Model") or descendant:IsA("ValueBase"))) then
			descendant:Destroy()
		end
	end
end
function VehicleUtils.getHeadlights(vehiclePacket)
	local headlights = {}
	for i, v in ipairs(vehiclePacket.Model.Body:GetChildren()) do
		if v.Name == "Headlight" then
			table.insert(headlights, (v:FindFirstChildWhichIsA("Light")))
		end
	end
	return headlights
end
function VehicleUtils.setHeadlightsEnabled(vehicleRoot, isEnabled)
	local Model = vehicleRoot:FindFirstChild("Model")
	if Model then
		local Body = Model:FindFirstChild("Body")
		if Body then
			for i, v in ipairs(Body:GetChildren()) do
				if v.Name == "Headlight" then
					local lightInstance = v:FindFirstChildWhichIsA("Light")
					if lightInstance.Enabled ~= isEnabled then
						lightInstance.Enabled = isEnabled
					end
				end
			end
			local function scanModelForName(modelPart, partName)
				for i, v in ipairs(modelPart:GetDescendants()) do
					if v.Name == partName then
						local materialValue = isEnabled and Enum.Material.Neon or Enum.Material.Glass
						if v.Material ~= materialValue then
							v.Material = materialValue
						end
						v.Reflectance = 0.1
						for _, descendant in v:GetDescendants() do
							if descendant:IsA("Beam") then
								descendant.Enabled = isEnabled
							end
						end
					end
				end
			end
			scanModelForName(Model, "Headlights")
			local Preset = vehicleRoot:FindFirstChild("Preset")
			if Preset then
				scanModelForName(Preset, "Headlights")
			end
		end
	end
end
function VehicleUtils.setBrakelightsEnabled(vehicleRoot, isEnabled)
	local Model = vehicleRoot:FindFirstChild("Model")
	if Model then
		local Body = Model:FindFirstChild("Body")
		if Body then
			for i, v in ipairs(Body:GetChildren()) do
				if v.Name == "Brakelight" then
					local lightInstance = v:FindFirstChildWhichIsA("Light")
					if lightInstance.Enabled ~= isEnabled then
						lightInstance.Enabled = isEnabled
					end
				end
			end
			for i, v in ipairs(Model:GetChildren()) do
				local materialValue
				if v.Name == "Brakelights" then
					materialValue = isEnabled and Enum.Material.Neon or Enum.Material.Glass
					if v.Material ~= materialValue then
						v.Material = materialValue
					end
					if math.abs(v.Reflectance - 0.1) > 0.001 then
						v.Reflectance = 0.1
					end
					for _, child in v:GetChildren() do
						if child:IsA("Trail") and child.Enabled ~= isEnabled then
							child.Enabled = isEnabled
						end
					end
				end
			end
			vehicleRoot:SetAttribute("BrakeLightEnabled", isEnabled)
		end
	end
end
function VehicleUtils.getBrakelightsEnabled(vehicleRoot)
	return vehicleRoot:GetAttribute("BrakeLightEnabled") == true
end
function VehicleUtils.getTireHealth(tire)
	return tire:GetAttribute(VehicleConsts.TIRE_HEALTH_ATTR_NAME)
end
function VehicleUtils.setTireHealth(tire, healthValue)
	tire:SetAttribute(VehicleConsts.TIRE_HEALTH_ATTR_NAME, healthValue)
end
function VehicleUtils.getTireHealthChangedSignal(tire)
	return tire:GetAttributeChangedSignal(VehicleConsts.TIRE_HEALTH_ATTR_NAME)
end
function VehicleUtils.setTireMaxHealth(tire, maxHealthValue)
	tire:SetAttribute(VehicleConsts.TIRE_MAX_HEALTH_ATTR_NAME, maxHealthValue)
end
function VehicleUtils.getTireMaxHealth(tire)
	return tire:GetAttribute(VehicleConsts.TIRE_MAX_HEALTH_ATTR_NAME)
end
function VehicleUtils.getTireMaxHealthChangedSignal(tire)
	return tire:GetAttributeChangedSignal(VehicleConsts.TIRE_MAX_HEALTH_ATTR_NAME)
end
function VehicleUtils.getVehicleCombatConfig(vehicleMake)
	assert(type(vehicleMake) == "string", "Invalid make")
	local combatConfig = VehicleCombatData[vehicleMake]
	if not combatConfig then
		if RunService:IsServer() then
			instance.sendGameAnalyticsError(nil, "Missing combat config data for Make " .. vehicleMake, "critical")
		end
		combatConfig = VehicleCombatData.Default
	end
	return combatConfig
end
function VehicleUtils.getSeats(vehicleModel)
	local seats = {}
	for i, v in ipairs(vehicleModel:GetChildren()) do
		if v.Name == "Seat" or v.Name == "Passenger" then
			local Player = v:FindFirstChild("Player")
			local PlayerName = v:FindFirstChild("PlayerName")
			if Player and (Player.Value and PlayerName) then
				table.insert(seats, {
					Part = v,
					Player = Players:FindFirstChild(PlayerName.Value)
				})
			end
		end
	end
	table.sort(seats, function(seatA, seatB)
		return seatA.Player.DisplayName < seatB.Player.DisplayName
	end)
	return seats
end
function VehicleUtils.prepareCameraSubject(vehiclePacket, isSeatCamera, shouldReturnOffsets)
	local cameraSubject = nil
	if vehiclePacket.Seat and not vehiclePacket.Seat:FindFirstChild("NoCameraSubject") then
		if vehiclePacket.Passenger then
			cameraSubject = vehiclePacket.Model:FindFirstChild("CameraPassenger", true)
		end
		if vehiclePacket.Seat:FindFirstChild("Turret") then
			cameraSubject = vehiclePacket.Model:FindFirstChild("TurretCamera", true)
		end
		if not cameraSubject then
			cameraSubject = vehiclePacket.Model:FindFirstChild("Camera", true)
		end
	end
	if cameraSubject then
		cameraSubject:SetAttribute("VehicleSeatCam", isSeatCamera == true)
	end
	local BoundingBox = vehiclePacket.Model:FindFirstChild("BoundingBox")
	local activeCameraController = cameraModule.activeCameraController
	if activeCameraController and (cameraSubject and not shouldReturnOffsets) then
		local Magnitude = BoundingBox.Size.Magnitude
		activeCameraController:SetCameraToSubjectDistance(Magnitude)
		CurrentCamera.CFrame = cameraSubject.CFrame * CFrame.Angles(-0.3141592653589793, 0, 0) * CFrame.new(0, 0, Magnitude)
		return cameraSubject
	elseif shouldReturnOffsets then
		local Magnitude = BoundingBox.Size.Magnitude
		return cameraSubject, (CFrame.Angles(-0.3141592653589793, 0, 0) * CFrame.new(0, 0, Magnitude)).Position, Magnitude
	else
		return cameraSubject
	end
end
function VehicleUtils.getParentModel(instance)
	while true do
		instance = instance.Parent
		if not instance then
			return
		end
		if CollectionService:HasTag(instance, "Vehicle") then
			return instance
		end
	end
end
function VehicleUtils.getVehicleMakeFromModel(vehicleModel)
	assert(CollectionService:HasTag(vehicleModel, "Vehicle"), "Model is not a vehicle")
	return vehicleModel.Name
end
function VehicleUtils.getVehicleDataForMake(vehicleMake)
	for i, v in ipairs(VehicleData) do
		if v.Make == vehicleMake then
			return v
		end
	end
	error("Invalid make: " .. vehicleMake)
end
function VehicleUtils.fixNetworkingCharacters()
	local Falling = require(ReplicatedStorage.Game.Falling)
	local Paraglide = require(ReplicatedStorage.Game.Paraglide)
	task.delay(2, function()
		local Character = Players.LocalPlayer.Character
		if Character and (Falling.IsSkydiving() or (Paraglide.IsFlying() or Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall)) then
			local hipHeightOffset = Character.Humanoid.HipHeight + Character.HumanoidRootPart.Size.Y / 2
			local Velocity = Character.HumanoidRootPart.Velocity
			Character.Humanoid.JumpPower = 0
			local NetworkFixPart1 = Instance.new("Part")
			NetworkFixPart1.Name = "NetworkFixPart1"
			NetworkFixPart1.Transparency = 1
			NetworkFixPart1.Size = Vector3.new(3, 0.1, 3)
			NetworkFixPart1.Anchored = true
			NetworkFixPart1.CFrame = Character.HumanoidRootPart.CFrame - Vector3.new(0, hipHeightOffset, 0)
			NetworkFixPart1.Parent = workspace
			Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
			task.delay(0.01, function()
				NetworkFixPart1:Destroy()
				Character.HumanoidRootPart.Velocity = Velocity
				if Paraglide.IsFlying() then
					Character.Humanoid.PlatformStand = true
					Character.Humanoid:ChangeState(Enum.HumanoidStateType.PlatformStanding)
				end
				task.wait(0.1)
				Character.Humanoid.JumpPower = StarterPlayer.CharacterJumpPower
			end)
		end
	end)
end
function VehicleUtils.vehicleEffect(effectType, vehicleModel)
	if effectType == "Jump" and (vehicleModel and vehicleModel.Parent) then
		local JumpEffect = vehicleModel:FindFirstChild("JumpEffect", true)
		local BlastEffect = vehicleModel:FindFirstChild("BlastEffect", true)
		local Engine = vehicleModel:FindFirstChild("Engine")
		if BlastEffect then
			BlastEffect:Emit(5)
		end
		if JumpEffect then
			JumpEffect.Enabled = true
			task.delay(1, function()
				JumpEffect.Enabled = false
			end)
		end
		if Engine then
			Audio.ObjectLocal(Engine, 130019374714708, {
				Volume = 0.5
			})
		end
	elseif effectType == "Nuke" and (vehicleModel and (vehicleModel.Parent and vehicleModel.PrimaryPart)) then
		Shockwave.new(vehicleModel.PrimaryPart.Position, {
			Duration = 12,
			MaxRadius = 6400,
			Power = 80
		}).OnPastLocalPlayer:Connect(function()
			local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
			if vehiclePacket ~= nil then
				if vehiclePacket.Make == "AdminNuke" and not vehiclePacket.Passenger then
					VehicleUtils.Classes.Chassis.runAction(true)
					return
				end
				CharacterUtil.OnJump()
				task.wait(0.1)
			end
		end)
	end
end
return VehicleUtils
