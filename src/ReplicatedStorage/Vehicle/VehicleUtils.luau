-- Reviewed by Claude
local CollectionService = game:GetService("CollectionService")
local CurrentCamera = workspace.CurrentCamera
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")
local RunService = game:GetService("RunService")
local v1
if RunService:IsServer() then
	local ServerStorage = game:GetService("ServerStorage")
	v1 = require(ServerStorage.Logging.ServerLoggingUtils)
else
	v1 = nil
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
local v2 = nil
local t = {
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
function t.GetLocalVehiclePacketForCustomize()
	local v1 = t.GetLocalVehiclePacket()
	if v1 and not RunUtils.isTradeWorld() then
		return v1
	else
		return {
			Type = "Chassis",
			Make = "Camaro"
		}
	end
end
function t.Init(p1)
	v2 = require(Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetCameras()
	t.LastVehicleExit = 0
	t.LastVehicleEject = 0
	t.GetLocalVehiclePacket = p1.GetVehiclePacket
	t.Classes = {}
	local v3, v4 = Roact.createBinding(0)
	t.spdBarRatio = v3
	t.updateSpdBarRatio = v4
	t._forceUpdateNitroBar = false
	t.nitroState = p1.nitroState
	local em = p1.em
	local v5 = p1.Event
	function em.scrfqlpx(p1)
		t.LastVehicleEject = p1
	end
	function t.canLocalLock()
		local v1 = t.GetLocalVehiclePacket()
		return v1 and (not v1.Passenger and (v1.Model and not v1.Model:GetAttribute("DisableLocking"))) and true or false
	end
	function t.toggleLocalLocked()
		local v1 = t.GetLocalVehiclePacket()
		v5:FireServer("r" .. "" .. ("fusvu"):sub(2, 2):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("pjngo4g"):sub(2, 3):reverse():reverse():reverse() .. "" .. "" .. ("x4dvxg"):sub(4, 4):reverse():reverse():reverse() .. "omi", v1.Model:GetAttribute("Locked") ~= true)
	end
	function t.canLocalEject()
		local v1 = t.GetLocalVehiclePacket()
		return v1 and (not v1.Passenger and (v1.Model and not v1.Model:GetAttribute("DisableEjecting"))) and true or false
	end
	function t.attemptPassengerEject(p1)
		v5:FireServer("t" .. ("uug3jewsj"):sub(2, 7):reverse():reverse():reverse():reverse():reverse() .. "t", p1)
	end
	function t.attemptBuyMissiles()
		v5:FireServer("b" .. ("ji139irheem"):sub(4, 7):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("ry5n2o"):sub(4, 5):reverse() .. "x")
	end
	local v6 = false
	function t.promptMissileBuy()
		if not v6 then
			v6 = true
			local v1 = Confirmation.new("Buy 10 Explosives for $5,000?")
			v1.Maid:GiveTask(v1.OnYes:Connect(function()
				t.attemptBuyMissiles()
			end))
			v1.Maid:GiveTask(function()
				v6 = false
			end)
		end
	end
	function em.asxzm3xn(...)
		t.vehicleEffect(...)
	end
end
function t.GetLocalVehicleModel()
	local v1 = t.GetLocalVehiclePacket()
	if v1 == nil then
		return false
	else
		return v1.Model
	end
end
function t.CleanVehicleModel(p1)
	local v1 = p1:GetDescendants()
	for i = 1, #v1 do
		local v2 = v1[i]
		if not (v2:IsA("BasePart") or (v2:IsA("Model") or v2:IsA("ValueBase"))) then
			v2:Destroy()
		end
	end
end
function t.getHeadlights(p1)
	local t = {}
	for i, v in ipairs(p1.Model.Body:GetChildren()) do
		if v.Name == "Headlight" then
			table.insert(t, (v:FindFirstChildWhichIsA("Light")))
		end
	end
	return t
end
function t.setHeadlightsEnabled(p1, p2)
	local Model = p1:FindFirstChild("Model")
	if Model then
		local Body = Model:FindFirstChild("Body")
		if Body then
			for i, v in ipairs(Body:GetChildren()) do
				if v.Name == "Headlight" then
					local v1 = v:FindFirstChildWhichIsA("Light")
					if v1.Enabled ~= p2 then
						v1.Enabled = p2
					end
				end
			end
			local function scanModelForName(p1, p22)
				for i, v in ipairs(p1:GetDescendants()) do
					if v.Name == p22 then
						local v1 = p2 and Enum.Material.Neon or Enum.Material.Glass
						if v.Material ~= v1 then
							v.Material = v1
						end
						v.Reflectance = 0.1
						for v2, v3 in v:GetDescendants() do
							if v3:IsA("Beam") then
								v3.Enabled = p2
							end
						end
					end
				end
			end
			scanModelForName(Model, "Headlights")
			local Preset = p1:FindFirstChild("Preset")
			if Preset then
				scanModelForName(Preset, "Headlights")
			end
		end
	end
end
function t.setBrakelightsEnabled(p1, p2)
	local Model = p1:FindFirstChild("Model")
	if Model then
		local Body = Model:FindFirstChild("Body")
		if Body then
			for i, v in ipairs(Body:GetChildren()) do
				if v.Name == "Brakelight" then
					local v1 = v:FindFirstChildWhichIsA("Light")
					if v1.Enabled ~= p2 then
						v1.Enabled = p2
					end
				end
			end
			for i, v in ipairs(Model:GetChildren()) do
				local v2
				if v.Name == "Brakelights" then
					v2 = p2 and Enum.Material.Neon or Enum.Material.Glass
					if v.Material ~= v2 then
						v.Material = v2
					end
					if math.abs(v.Reflectance - 0.1) > 0.001 then
						v.Reflectance = 0.1
					end
					for v4, v5 in v:GetChildren() do
						if v5:IsA("Trail") and v5.Enabled ~= p2 then
							v5.Enabled = p2
						end
					end
				end
			end
			p1:SetAttribute("BrakeLightEnabled", p2)
		end
	end
end
function t.getBrakelightsEnabled(p1)
	return p1:GetAttribute("BrakeLightEnabled") == true
end
function t.getTireHealth(p1)
	return p1:GetAttribute(VehicleConsts.TIRE_HEALTH_ATTR_NAME)
end
function t.setTireHealth(p1, p2)
	p1:SetAttribute(VehicleConsts.TIRE_HEALTH_ATTR_NAME, p2)
end
function t.getTireHealthChangedSignal(p1)
	return p1:GetAttributeChangedSignal(VehicleConsts.TIRE_HEALTH_ATTR_NAME)
end
function t.setTireMaxHealth(p1, p2)
	p1:SetAttribute(VehicleConsts.TIRE_MAX_HEALTH_ATTR_NAME, p2)
end
function t.getTireMaxHealth(p1)
	return p1:GetAttribute(VehicleConsts.TIRE_MAX_HEALTH_ATTR_NAME)
end
function t.getTireMaxHealthChangedSignal(p1)
	return p1:GetAttributeChangedSignal(VehicleConsts.TIRE_MAX_HEALTH_ATTR_NAME)
end
function t.getVehicleCombatConfig(p1)
	assert(type(p1) == "string", "Invalid make")
	local v2 = VehicleCombatData[p1]
	if not v2 then
		if RunService:IsServer() then
			v1.sendGameAnalyticsError(nil, "Missing combat config data for Make " .. p1, "critical")
		end
		v2 = VehicleCombatData.Default
	end
	return v2
end
function t.getSeats(p1)
	local t = {}
	for i, v in ipairs(p1:GetChildren()) do
		if v.Name == "Seat" or v.Name == "Passenger" then
			local Player = v:FindFirstChild("Player")
			local PlayerName = v:FindFirstChild("PlayerName")
			if Player and (Player.Value and PlayerName) then
				table.insert(t, {
					Part = v,
					Player = Players:FindFirstChild(PlayerName.Value)
				})
			end
		end
	end
	table.sort(t, function(p1, p2)
		return p1.Player.DisplayName < p2.Player.DisplayName
	end)
	return t
end
function t.prepareCameraSubject(p1, p2, p3)
	local v1 = nil
	if p1.Seat and not p1.Seat:FindFirstChild("NoCameraSubject") then
		if p1.Passenger then
			v1 = p1.Model:FindFirstChild("CameraPassenger", true)
		end
		if p1.Seat:FindFirstChild("Turret") then
			v1 = p1.Model:FindFirstChild("TurretCamera", true)
		end
		if not v1 then
			v1 = p1.Model:FindFirstChild("Camera", true)
		end
	end
	if v1 then
		v1:SetAttribute("VehicleSeatCam", p2 == true)
	end
	local BoundingBox = p1.Model:FindFirstChild("BoundingBox")
	local activeCameraController = v2.activeCameraController
	if activeCameraController and (v1 and not p3) then
		local Magnitude = BoundingBox.Size.Magnitude
		activeCameraController:SetCameraToSubjectDistance(Magnitude)
		CurrentCamera.CFrame = v1.CFrame * CFrame.Angles(-0.3141592653589793, 0, 0) * CFrame.new(0, 0, Magnitude)
		return v1
	elseif p3 then
		local Magnitude = BoundingBox.Size.Magnitude
		return v1, (CFrame.Angles(-0.3141592653589793, 0, 0) * CFrame.new(0, 0, Magnitude)).Position, Magnitude
	else
		return v1
	end
end
function t.getParentModel(p1)
	while true do
		p1 = p1.Parent
		if not p1 then
			return
		end
		if CollectionService:HasTag(p1, "Vehicle") then
			return p1
		end
	end
end
function t.getVehicleMakeFromModel(p1)
	assert(CollectionService:HasTag(p1, "Vehicle"), "Model is not a vehicle")
	return p1.Name
end
function t.getVehicleDataForMake(p1)
	for i, v in ipairs(VehicleData) do
		if v.Make == p1 then
			return v
		end
	end
	error("Invalid make: " .. p1)
end
function t.fixNetworkingCharacters()
	local Falling = require(ReplicatedStorage.Game.Falling)
	local Paraglide = require(ReplicatedStorage.Game.Paraglide)
	task.delay(2, function()
		local Character = Players.LocalPlayer.Character
		if Character and (Falling.IsSkydiving() or (Paraglide.IsFlying() or Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall)) then
			local v1 = Character.Humanoid.HipHeight + Character.HumanoidRootPart.Size.Y / 2
			local Velocity = Character.HumanoidRootPart.Velocity
			Character.Humanoid.JumpPower = 0
			local NetworkFixPart1 = Instance.new("Part")
			NetworkFixPart1.Name = "NetworkFixPart1"
			NetworkFixPart1.Transparency = 1
			NetworkFixPart1.Size = Vector3.new(3, 0.1, 3)
			NetworkFixPart1.Anchored = true
			NetworkFixPart1.CFrame = Character.HumanoidRootPart.CFrame - Vector3.new(0, v1, 0)
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
function t.vehicleEffect(p1, p2)
	if p1 == "Jump" and (p2 and p2.Parent) then
		local JumpEffect = p2:FindFirstChild("JumpEffect", true)
		local BlastEffect = p2:FindFirstChild("BlastEffect", true)
		local Engine = p2:FindFirstChild("Engine")
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
	elseif p1 == "Nuke" and (p2 and (p2.Parent and p2.PrimaryPart)) then
		Shockwave.new(p2.PrimaryPart.Position, {
			Duration = 12,
			MaxRadius = 6400,
			Power = 80
		}).OnPastLocalPlayer:Connect(function()
			local v1 = t.GetLocalVehiclePacket()
			if v1 ~= nil then
				if v1.Make == "AdminNuke" and not v1.Passenger then
					t.Classes.Chassis.runAction(true)
					return
				end
				CharacterUtil.OnJump()
				task.wait(0.1)
			end
		end)
	end
end
return t
