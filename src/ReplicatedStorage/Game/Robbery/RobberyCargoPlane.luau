-- Reviewed by Claude
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local Time = require(ReplicatedStorage.Module.Time)
local Joint = require(ReplicatedStorage.Std.Joint)
local Timeline = require(ReplicatedStorage.Module.Timeline)
local Audio = require(ReplicatedStorage.Std.Audio)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
game:GetService("SoundService")
local MinimapService = require(ReplicatedStorage.App.MinimapService)
local DuffelBagUtils = require(ReplicatedStorage.Game.DuffelBag.DuffelBagUtils)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local RobberyCargoPlaneShared = require(ReplicatedStorage.Game.Robbery.RobberyCargoPlaneShared)
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
local RemoteEvent = nil
local em = nil
local Team = nil
local SoundIds = {
	alarm_siren_loop_01 = 4487202760,
	background_air_compressor_pump_loop_01 = 9058646197,
	prop_loop = 9058616635,
	hydraulic_strut_air_gas_shock_door_01 = 4487204926,
	collect_item_02 = 4487203151,
	truck_low_engine_rattle_loop = 9058628651,
	metal_sheet_impacts_01 = 4487205142,
	metal_sheet_impacts_02 = 4487205303,
	metal_sheet_impacts_03 = 4487205462,
	lever_sound = 1988476846
}
local MetalImpactSounds = { SoundIds.metal_sheet_impacts_01, SoundIds.metal_sheet_impacts_02, SoundIds.metal_sheet_impacts_03 }
local function Ease_InOutQuad(t)
	return t < 0.5 and 2 * t * t or -1 - 2 * (t - 2) * t
end
local function Ease_InOutSine(t)
	return (math.sin(math.pi * t - 1.5707963267948966) + 1) * 0.5
end
local function HideModel(model)
	for i, v in ipairs(model:GetChildren()) do
		if v:IsA("BasePart") then
			v.Transparency = 1
			v.CanCollide = false
		end
		HideModel(v)
	end
end
local function ShowModel(model)
	for i, v in ipairs(model:GetChildren()) do
		if v:IsA("BasePart") then
			v.Transparency = 0
			v.CanCollide = true
		end
		ShowModel(v)
	end
end
local function GetHumanoid()
	local Character = LocalPlayer.Character
	if Character == nil then
		return nil
	else
		return Character:FindFirstChild("Humanoid")
	end
end
local function GetHRP()
	local Character = LocalPlayer.Character
	local humanoid = if Character == nil then nil else Character:FindFirstChild("Humanoid")
	if humanoid == nil then
		return nil
	else
		return humanoid.RootPart
	end
end
local Lever = {}
Lever.__index = Lever
function Lever.new(leverModel, primaryPart)
	assert(leverModel)
	assert(leverModel.PrimaryPart)
	assert(primaryPart)
	local self = setmetatable({}, Lever)
	self.Model = leverModel
	self._leverMotor = Joint.Motor(leverModel.PrimaryPart, primaryPart)
	self.Length = leverModel.PrimaryPart.Size.Z
	self.OnSuccess = Signal.new()
	self.OnFail = Signal.new()
	local function Action(actionSpec, completed)
		if completed then
			self.OnSuccess:Fire()
		end
		return true
	end
	local spec = {
		Part = leverModel.PrimaryPart,
		Name = "Open Door",
		NoRay = true,
		Timed = true,
		Duration = 1,
		Dist = 8,
		Callback = Action
	}
	CircleAction.Add(spec, leverModel.PrimaryPart)
	self.Spec = spec
	self:Reset()
	return self
end
function Lever.SetAngle(self, angle)
	self._leverMotor.C1 = self._leverMotor.C0:Inverse() * CFrame.new(0, 0, self.Length * 0.5) * CFrame.Angles(angle, 0, 0) * CFrame.new(0, 0, -self.Length * 0.5) * self._leverMotor.C0
end
function Lever.Reset(self)
	self:SetAngle(0.7853981633974483)
end
function Lever.Pull(self)
	self:SetAngle(-0.7853981633974483)
end
function Lever.Destroy(self)
	self.OnSuccess:Destroy()
	self.OnSuccess = nil
	self.OnFail:Destroy()
	self.OnFail = nil
	self.Spec.Kill = true
	self.Spec = nil
end
local UnsafePositionReplication = ReplicatedStorage:FindFirstChild("UnsafePositionReplication")
local ChangePositionReplication = ReplicatedStorage:FindFirstChild("ChangePositionReplication")
local lastReplicationClock = os.clock()
local lastReplicatedOffset = CFrame.new()
local modelOffsetCache = {}
local replicateCharacterPlaneList = {}
local activePlane = nil
local CargoPlane = {}
CargoPlane.__index = CargoPlane
function CargoPlane.new(bornAt)
	assert(bornAt)
	local self = setmetatable({}, CargoPlane)
	self.BornAt = bornAt
	self.IsPlayerInsidePlane = false
	self.IsPlayerOnPlane = false
	self.OnPlayerEnter = Signal.new()
	self.OnPlayerLeave = Signal.new()
	local planeModel = ReplicatedStorage.Resource.RobberyCargoPlane.Plane:Clone()
	CollectionService:AddTag(planeModel.CargoPlane, "RobberyMarker")
	Joint.WeldAllTo(planeModel, planeModel.PrimaryPart, true)
	Joint.WeldAllTo(planeModel.ControlPanel, planeModel.PrimaryPart)
	Joint.WeldAllTo(planeModel.Crates, planeModel.PrimaryPart)
	Joint.WeldAllTo(planeModel.Model, planeModel.PrimaryPart)
	self._topDoorMotor = Joint.Motor(planeModel.TopDoor.Part, planeModel.PrimaryPart)
	planeModel.TopDoor.Part.Anchored = false
	Joint.WeldAllTo(planeModel.BottomDoor.Door, planeModel.BottomDoor.Door.PrimaryPart)
	self._bottomDoorMotor = Joint.Motor(planeModel.BottomDoor.Door.PrimaryPart, planeModel.PrimaryPart)
	Joint.WeldAllTo(planeModel.Lever, planeModel.Lever.PrimaryPart)
	planeModel.PrimaryPart.Anchored = true
	planeModel.Parent = workspace
	self.Model = planeModel
	self:SetupProps()
	self.SoundEngineFlying = Audio.ObjectLocal(planeModel.Root, SoundIds.prop_loop, {
		Volume = 0,
		Looped = true,
		EmitterSize = 128,
		RollOffMaxDistance = 1536
	})
	self.SoundEngineIdle = Audio.ObjectLocal(planeModel.Root, SoundIds.truck_low_engine_rattle_loop, {
		Volume = 0,
		Looped = true,
		EmitterSize = 64,
		RollOffMaxDistance = 1536
	})
	self.SoundEngineBackground = Audio.ObjectLocal(planeModel.Root, SoundIds.background_air_compressor_pump_loop_01, {
		Volume = 0,
		Looped = true,
		EmitterSize = 64
	})
	self.SoundWind = Audio.ObjectLocal(planeModel.WindNode, 9058653424, {
		Volume = 0,
		Looped = true,
		EmitterSize = 64,
		RollOffMaxDistance = 1536
	})
	self.Lever = Lever.new(planeModel.Lever, planeModel.PrimaryPart)
	self.Lever.OnSuccess:Connect(function()
		if self.CargoOpenedAt ~= nil and Time.GetNowSync() - self.CargoOpenedAt < self.SeqsCargoDuration then
			return false
		end
		Audio.ObjectLocal(self.Model.PrimaryPart, 700180643, {
			TimePosition = 1,
			MaxPlaybackTime = 0.6
		})
		planeModel.ControlPanel.Light.Color = Color3.new(0/255, 255/255, 0/255)
		delay(0.1, function()
			planeModel.ControlPanel.Light.Color = Color3.fromRGB(196, 40, 28)
		end)
		RemoteEvent:FireServer("w" .. ("o3jonpri"):sub(5, 6):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("oog1nt"):sub(3, 4):reverse() .. "" .. "" .. ("ohk"):sub(2, 2):reverse():reverse():reverse() .. "xm")
	end)
	self.Lever.OnFail:Connect(function()
		em.ShowNotification({
			Title = "CargoPlane",
			Text = "Keycard required. Search the crates..."
		})
		Audio.ObjectLocal(self.Model.PrimaryPart, 700180643, {
			TimePosition = 0,
			MaxPlaybackTime = 0.6
		})
		planeModel.ControlPanel.Light.Color = Color3.new(0/255, 0/255, 0/255)
		delay(0.1, function()
			planeModel.ControlPanel.Light.Color = Color3.fromRGB(196, 40, 28)
		end)
	end)
	self.RealRoll = 0
	self.RealDirection = planeModel.PrimaryPart.CFrame.LookVector
	self.CargoOpenAmount = 0
	self.ShouldDestroy = false
	local flightData = RobberyCargoPlaneShared.GetFlightData()
	local PathEnter = flightData.PathEnter
	PathEnter.ApproxTotalLength = PathEnter:ApproximateLength(1000)
	self.PathEnter = PathEnter
	local PathLeave = flightData.PathLeave
	PathLeave.ApproxTotalLength = PathLeave:ApproximateLength(1000)
	self.PathLeave = PathLeave
	local seqFunctions = {
		SeqEnter = function(p1)
			self:SeqEnter(p1)
		end,
		SeqCargoOpen = function(p1)
			self:SeqCargoOpen(p1)
		end,
		SeqLoadCrates = function(p1)
			self:SeqLoadCrates(p1)
		end,
		SeqCargoClose = function(p1)
			self:SeqCargoClose(p1)
		end,
		SeqLeave = function(p1)
			self:SeqLeave(p1)
		end,
		SeqHatchOpen = function(p1)
			self:SeqHatchOpen(p1)
		end,
		SeqHatchClose = function(p1)
			self:SeqHatchClose(p1)
		end,
		SeqNone = function() end
	}
	local seqList = {}
	for i = 1, #flightData.SeqsLayout do
		local entry = flightData.SeqsLayout[i]
		local seqName = entry[1]
		local seqFn = seqFunctions[seqName]
		if seqFn == nil then
			error("No seq function found for: " .. seqName)
		end
		table.insert(seqList, { seqFn, (assert(entry[2])) })
	end
	self.mTimeline = Timeline.new(seqList)
	local cargoSeqList = {
		{ seqFunctions.SeqCargoOpen, 2 },
		{ seqFunctions.SeqNone, 4 },
		{ seqFunctions.SeqCargoClose, 3 }
	}
	self.SeqsCargo = cargoSeqList
	self.Tl_Cargo = nil
	self.CargoOpenedAt = nil
	local cargoSeqDuration = 0
	for i, v in ipairs(cargoSeqList) do
		cargoSeqDuration = cargoSeqDuration + v[2]
	end
	self.SeqsCargoDuration = cargoSeqDuration
	self.HeartbeatConn = RunService.Heartbeat:Connect(function(dt)
		self:Update(dt)
	end)
	self.SoundMusic = nil
	self.OnPlayerEnter:Connect(function()
		if self.SoundMusic then
			self.SoundMusic:Destroy()
		end
		self.SoundMusic = Audio.ObjectLocal(LocalPlayer.PlayerGui, 1837315896, {
			Looped = true,
			Volume = 1,
			GroupName = "RobberyMusic"
		})
		if LocalPlayer.Character then
			for v1, v2 in LocalPlayer.Character:QueryDescendants("BasePart") do
				v2.CollisionGroup = "PlayersInTrain"
			end
		end
	end)
	self.OnPlayerLeave:Connect(function(forceFire)
		local SoundMusic = self.SoundMusic
		if SoundMusic then
			self.SoundMusic = nil
			Audio.promiseFadeTo(SoundMusic, 0, 1):finally(function()
				SoundMusic:Destroy()
			end):catch(warn)
		end
		local bag = DuffelBagUtils.getBag(LocalPlayer)
		if not self._setWaypoint and (bag and bag:GetRobbery() == RobberyConsts.ENUM_ROBBERY.CARGO_PLANE) then
			self._setWaypoint = true
			bag._maid:GiveTask(MinimapService.addWaypoint({
				position = Vector3.new(-346.243, 22.666, 2057.052),
				name = "CargoPlaneCollect",
				priority = 1000,
				minDist = 0
			}))
		end
		if (not forceFire or forceFire and self.IsPlayerInsidePlane) and LocalPlayer.Character then
			for v2, v3 in LocalPlayer.Character:QueryDescendants("BasePart") do
				v3.CollisionGroup = "Players"
			end
		end
	end)
	self:SetupCrates()
	self.Tl_Hatch = nil
	self.HatchOpenedAt = nil
	self.SeqsHatch = {
		{ seqFunctions.SeqHatchOpen, 0.5 },
		{ seqFunctions.SeqNone, 2 },
		{ seqFunctions.SeqHatchClose, 0.5 }
	}
	self:SetupHatch()
	return self
end
function CargoPlane.SetupHatch(self)
	self.TopDoorModel = self.Model.TopDoor
	self._hatchOffset = self.TopDoorModel.Part.CFrame:ToObjectSpace(self.TopDoorModel.Open.CFrame)
	self.TopDoorModel.Open:Destroy()
	local function Action(actionSpec, completed)
		if PlayerUtils.hasKey() == true then
			if completed then
				Audio.ObjectLocal(self.Model.PrimaryPart, 700180643, {
					TimePosition = 1,
					MaxPlaybackTime = 0.6
				})
				RemoteEvent:FireServer("u" .. "" .. ("bo2p"):sub(3, 3):reverse():reverse():reverse():reverse():reverse() .. "46rrbe")
			end
			return true
		else
			Audio.ObjectLocal(self.Model.PrimaryPart, 700180643, {
				TimePosition = 0,
				MaxPlaybackTime = 0.6
			})
			return false
		end
	end
	local spec = {
		Part = self.TopDoorModel.Part,
		Name = "Open Door",
		NoRay = true,
		Timed = true,
		Duration = 5,
		Dist = 8,
		Callback = Action
	}
	CircleAction.Add(spec, self.TopDoorModel.Part)
	self.SpecHatch = spec
end
function CargoPlane.SeqHatchOpen(self, t)
	local Part = self.TopDoorModel.Part
	if t == 0 then
		Audio.ObjectLocal(Part, 1791024087)
		Part.CanCollide = false
	end
	self._topDoorMotor.C1 = self._topDoorMotor.C0:Inverse() * CFrame.new():Lerp(self._hatchOffset, t) * self._topDoorMotor.C0
end
function CargoPlane.SeqHatchClose(self, t)
	local Part = self.TopDoorModel.Part
	if t == 0 then
		Audio.ObjectLocal(Part, 1791025004)
	elseif t == 1 then
		Part.CanCollide = true
	end
	self._topDoorMotor.C1 = self._topDoorMotor.C0:Inverse() * CFrame.new():Lerp(self._hatchOffset, 1 - t) * self._topDoorMotor.C0
end
function CargoPlane.SetupCrates(self)
	local Crates = self.Model.Crates
	local iterNext = next
	local iterStart, iterState = Crates:GetChildren()
	local crateList = {}
	for k, v in iterNext, iterStart, iterState do
		local crateEntry = {
			Name = v.Name,
			Model = v
		}
		crateEntry.Model.PrimaryPart = v["1"]
		table.insert(crateList, crateEntry)
	end
	self.Crates = crateList
	HideModel(Crates)
end
function CargoPlane.EnableCrates(self)
	self.CratesEnabled = true
	local function Action(actionSpec, completed)
		if completed then
			RemoteEvent:FireServer("x4dtvc4o", actionSpec.Part.Parent.Name)
		end
		return true
	end
	for i, v in ipairs(self.Crates) do
		local PrimaryPart = v.Model.PrimaryPart
		local spec = {
			Part = PrimaryPart,
			Name = "Inspect Crate",
			NoRay = true,
			Timed = true,
			Duration = 10,
			Dist = 8,
			Callback = Action
		}
		CircleAction.Add(spec, PrimaryPart)
		v.Spec = spec
	end
end
function CargoPlane.SetupProps(self)
	local Model = self.Model
	local PrimaryPart = Model.PrimaryPart
	local iterNext = next
	local iterStart, iterState = Model.Props:GetChildren()
	local propList = {}
	for k, v in iterNext, iterStart, iterState do
		local propEntry = {}
		local Prop = v.Prop
		propEntry.PartProp = Prop
		propEntry.PartDisc = v.Disc
		propEntry.Rotation = math.random()
		Joint.WeldAllTo(v, Prop)
		propEntry._motor = Joint.Motor(Prop, PrimaryPart)
		table.insert(propList, propEntry)
	end
	self.Props = propList
end
function CargoPlane.StepProps(self, speed)
	for i, v in ipairs(self.Props) do
		local Rotation = v.Rotation
		v._motor.C1 = v._motor.C0:Inverse() * CFrame.Angles(0, 0, Rotation) * v._motor.C0
		v.PartDisc.Transparency = (1 - math.clamp(speed, 0, 1)) * 0.30000000000000004 + 0.7
		v.Rotation = Rotation + speed
	end
end
function CargoPlane.Update(self, dt)
	debug.profilebegin("CargoPlane Update")
	local now = Time.GetNowSync()
	local elapsed = now - self.BornAt
	local isInsidePlane = false
	local isOnPlane = false
	debug.profilebegin("PlayerInPlane")
	local Character = LocalPlayer.Character
	local humanoid = if Character == nil then nil else Character:FindFirstChild("Humanoid")
	if humanoid then
		local RootPart = humanoid.RootPart
		if RootPart then
			local ignoreList = { workspace.Items }
			local Rain = workspace:FindFirstChild("Rain")
			if Rain ~= nil then
				table.insert(ignoreList, Rain)
			end
			for i, v in ipairs(Players:GetPlayers()) do
				local playerChar = v.Character
				if playerChar then
					table.insert(ignoreList, playerChar)
				end
			end
			local rootCFrame = RootPart.CFrame
			local hitBelow = RayCast.RayIgnoreNonCollideWithIgnoreList(rootCFrame.p, -rootCFrame.UpVector, 24, ignoreList, true)
			if hitBelow and hitBelow:IsDescendantOf(self.Model) then
				isOnPlane = true
			end
			if isOnPlane then
				local hitAbove = RayCast.RayIgnoreNonCollideWithIgnoreList(rootCFrame.p, rootCFrame.UpVector, 24, ignoreList, true)
				if hitAbove and hitAbove:IsDescendantOf(self.Model) then
					isInsidePlane = true
				end
			end
		end
	end
	debug.profileend()
	if isInsidePlane == true and self.IsPlayerInsidePlane == false then
		self.IsPlayerInsidePlane = isInsidePlane
		self.OnPlayerEnter:Fire()
	elseif isInsidePlane == false and self.IsPlayerInsidePlane == true then
		self.IsPlayerInsidePlane = isInsidePlane
		self.OnPlayerLeave:Fire()
	end
	if isOnPlane == true and self.IsPlayerOnPlane == false then
		self.IsPlayerOnPlane = isOnPlane
	elseif isOnPlane == false and self.IsPlayerOnPlane == true then
		self.IsPlayerOnPlane = isOnPlane
		ChangePositionReplication:FireServer(nil, false)
	end
	local Root = self.Model.Root
	local prevRootCFrame = Root.CFrame
	debug.profilebegin("Timeline Update")
	if self.mTimeline and self.mTimeline:Update(elapsed) then
		self.mTimeline = nil
	end
	debug.profileend()
	local newRootCFrame = Root.CFrame
	local frameDelta = (newRootCFrame.p - prevRootCFrame.p).Magnitude
	debug.profilebegin("Step Props")
	self:StepProps(frameDelta * 0.2)
	debug.profileend()
	if isOnPlane then
		local windUnit = (self.Model.WindNode.Position - newRootCFrame.p).Unit
		local planeDelta = newRootCFrame * prevRootCFrame:Inverse()
		if frameDelta > 0.01 and self.CargoOpenAmount > 0.0001 then
			planeDelta = planeDelta + windUnit * 0.3 * dt * 60
		end
		local playerChar = LocalPlayer.Character
		local playerHumanoid = if playerChar == nil then nil else playerChar:FindFirstChild("Humanoid")
		local playerRoot = if playerHumanoid == nil then nil else playerHumanoid.RootPart
		playerRoot.CFrame = planeDelta * playerRoot.CFrame
		local cameraOffset = CurrentCamera.CFrame:ToObjectSpace(CurrentCamera.Focus)
		CurrentCamera.CFrame = CurrentCamera.CFrame * cameraOffset * (planeDelta - planeDelta.p) * cameraOffset:Inverse()
		if UnsafePositionReplication and os.clock() - lastReplicationClock > 0.2 then
			local relativeOffset = newRootCFrame:ToObjectSpace(playerRoot.CFrame)
			if not (lastReplicatedOffset and relativeOffset:FuzzyEq(lastReplicatedOffset)) then
				lastReplicationClock = os.clock()
				UnsafePositionReplication:FireServer("Plane", nil, relativeOffset)
				lastReplicatedOffset = relativeOffset
			end
		end
		for k, replicatedModel in replicateCharacterPlaneList do
			local planeOffset = replicatedModel:GetAttribute("PlaneOffset")
			if playerRoot.Parent ~= replicatedModel and (replicatedModel.PrimaryPart and planeOffset) then
				local cacheEntry = modelOffsetCache[replicatedModel]
				if not cacheEntry then
					local newEntry = {
						LastOffset = newRootCFrame:ToObjectSpace(replicatedModel.PrimaryPart.CFrame)
					}
					modelOffsetCache[replicatedModel] = newEntry
					cacheEntry = newEntry
				end
				local smoothedOffset = cacheEntry.LastOffset:Lerp(planeOffset, 1 - math.exp(-5 * dt))
				cacheEntry.LastOffset = smoothedOffset
				replicatedModel.PrimaryPart.CFrame = newRootCFrame * smoothedOffset
			end
		end
	end
	if self.CargoOpenedAt ~= nil then
		local cargoElapsed = now - self.CargoOpenedAt
		if self.Tl_Cargo == nil and cargoElapsed < self.SeqsCargoDuration - 0.01 then
			self.Tl_Cargo = Timeline.new(self.SeqsCargo)
			Audio.FadeTo(self.SoundWind, 1, 0.5)
		end
		if self.Tl_Cargo ~= nil and self.Tl_Cargo:Update(cargoElapsed) == true then
			self.Tl_Cargo = nil
			Audio.FadeTo(self.SoundWind, 0, 0.5)
		end
	end
	if self.Tl_Hatch ~= nil and self.Tl_Hatch:Update(now - self.HatchOpenedAt) == true then
		self.Tl_Hatch = nil
	end
	debug.profileend()
	if self.ShouldDestroy then
		task.defer(self.Destroy, self)
	end
end
function CargoPlane.StepRoll(self, targetRoll, smoothing)
	if targetRoll ~= targetRoll then
		targetRoll = 0
	end
	local RealRoll = self.RealRoll
	local smoothedRoll = RealRoll + (targetRoll - RealRoll) * smoothing
	self.RealRoll = smoothedRoll
	return smoothedRoll
end
function CargoPlane.StepDirection(self, targetDirection)
	local RealDirection = self.RealDirection
	if targetDirection.Magnitude <= 0.001 then
		return RealDirection
	else
		local smoothed = RealDirection + (targetDirection - RealDirection) * 0.1
		self.RealDirection = smoothed
		return smoothed
	end
end
function CargoPlane.SeqEnter(self, t)
	if t == 0 then
		Audio.FadeTo(self.SoundEngineFlying, 0.75, 0.1)
	elseif t == 1 then
		Audio.FadeTo(self.SoundEngineFlying, 0, 1)
		Audio.FadeTo(self.SoundEngineIdle, 0.6, 1)
	end
	local eased = (math.sin(math.pi * t - 1.5707963267948966) + 1) * 0.5
	local Model = self.Model
	local PathEnter = self.PathEnter
	local pos, tangent = PathEnter:GetWorldPositionAt(PathEnter.ApproxTotalLength * eased)
	local smoothDir = self:StepDirection(tangent)
	local smoothRoll = self:StepRoll(if eased > 0.8 then 0 else math.acos((Model.PrimaryPart.CFrame.LookVector:Dot(tangent.Unit))) * 5, if eased > 0.8 then 0.03 else 0.01)
	Model.PrimaryPart.CFrame = CFrame.new(pos, pos + smoothDir) * CFrame.Angles(0, 0, smoothRoll)
end
function CargoPlane.SeqLeave(self, t)
	if t == 0 then
		Audio.FadeTo(self.SoundEngineIdle, 0, 1)
		Audio.FadeTo(self.SoundEngineFlying, 0.75, 1)
		Audio.FadeTo(self.SoundEngineBackground, 0.6, 1)
	end
	if t > 0.2 and not self.CratesEnabled then
		self:EnableCrates()
	end
	local eased = (math.sin(math.pi * t - 1.5707963267948966) + 1) * 0.5
	local Model = self.Model
	local PathLeave = self.PathLeave
	local pos, tangent = PathLeave:GetWorldPositionAt(PathLeave.ApproxTotalLength * eased)
	if tangent.Magnitude > 0 then
		self.Direction = tangent
	end
	local smoothDir = self:StepDirection(tangent)
	local smoothRoll = self:StepRoll(if eased < 0.2 then 0 else math.acos((Model.PrimaryPart.CFrame.LookVector:Dot(tangent.Unit))) * 5, if eased < 0.2 then 0.03 else 0.01)
	Model.PrimaryPart.CFrame = CFrame.new(pos, pos + smoothDir) * CFrame.Angles(0, 0, smoothRoll)
	if eased == 1 then
		self.ShouldDestroy = true
	end
end
function CargoPlane.SeqLoadCrates(self, t)
	for i = 1, math.floor(t * (#self.Crates - 1)) + 1 do
		local crate = self.Crates[i]
		if not crate.HasLoaded then
			crate.HasLoaded = true
			ShowModel(crate.Model)
		end
	end
	if t == 1 then
		ShowModel(self.Model.Crates)
	end
end
function CargoPlane.SeqCargoOpen(self, t)
	local Door = self.Model.BottomDoor.Door
	if t == 0 then
		Audio.ObjectLocal(Door.PrimaryPart, SoundIds.hydraulic_strut_air_gas_shock_door_01)
		Audio.ObjectLocal(activePlane.Lever.Model.PrimaryPart, SoundIds.lever_sound)
		self.Lever:Pull()
	end
	self._bottomDoorMotor.C1 = self._bottomDoorMotor.C0:Inverse() * CFrame.Angles(0, 0, -(t < 0.5 and 2 * t * t or -1 - 2 * (t - 2) * t) * math.pi * 0.15) * self._bottomDoorMotor.C0
	self.CargoOpenAmount = t
end
function CargoPlane.SeqCargoClose(self, t)
	local Door = self.Model.BottomDoor.Door
	if t == 0 then
		Audio.ObjectLocal(Door.PrimaryPart, SoundIds.hydraulic_strut_air_gas_shock_door_01)
		Audio.ObjectLocal(activePlane.Lever.Model.PrimaryPart, SoundIds.lever_sound)
		self.Lever:Reset()
	elseif t == 1 then
		self.CargoOpenedAt = nil
	end
	local invT = 1 - t
	self._bottomDoorMotor.C1 = self._bottomDoorMotor.C0:Inverse() * CFrame.Angles(0, 0, -(invT < 0.5 and 2 * invT * invT or -1 - 2 * (invT - 2) * invT) * math.pi * 0.15) * self._bottomDoorMotor.C0
	self.CargoOpenAmount = 1 - t
end
function CargoPlane.Destroy(self)
	self.HeartbeatConn:Disconnect()
	self.HeartbeatConn = nil
	if self.Crates ~= nil then
		for i = 1, #self.Crates do
			local crate = self.Crates[i]
			if crate.Spec then
				crate.Spec.Kill = true
			end
		end
		self.Crates = nil
	end
	self.OnPlayerEnter:Destroy()
	self.OnPlayerEnter = nil
	self.OnPlayerLeave:Fire(true)
	self.OnPlayerLeave:Destroy()
	self.OnPlayerLeave = nil
	self.SoundEngineFlying:Destroy()
	self.SoundEngineFlying = nil
	self.SoundEngineIdle:Destroy()
	self.SoundEngineIdle = nil
	self.SoundEngineBackground:Destroy()
	self.SoundEngineBackground = nil
	self.SoundWind:Destroy()
	self.SoundWind = nil
	self.Lever:Destroy()
	self.Lever = nil
	self.SpecHatch.Kill = true
	self.SpecHatch = nil
	self.Model:Destroy()
	self.Model = nil
	activePlane = nil
	setmetatable(self, nil)
end
return {
	Init = function(p1)
		local eventManager = p1.em
		RemoteEvent = p1.Event
		em = eventManager
		Team = p1.Team
		local ScreenGui = p1.ScreenGui
		local rng = Random.new()
		function eventManager.OnCargoPlaneStateChanged(state)
			if state then
				if activePlane == nil then
					activePlane = CargoPlane.new(state.BornAt)
				end
				activePlane.BornAt = state.BornAt
				if state.CargoOpenedAt ~= nil and activePlane.CargoOpenedAt ~= state.CargoOpenedAt then
					activePlane.CargoOpenedAt = state.CargoOpenedAt
				end
				if state.CrateNamesTaken ~= nil then
					local takenSet = {}
					for i, v in ipairs(state.CrateNamesTaken) do
						takenSet[v] = true
					end
					for i = #activePlane.Crates, 1, -1 do
						local crate = activePlane.Crates[i]
						if takenSet[crate.Name] then
							if crate.Spec then
								crate.Spec.Kill = true
							end
							HideModel(crate.Model)
							Audio.ObjectLocal(crate.Model:GetChildren()[1], MetalImpactSounds[rng:NextInteger(1, #MetalImpactSounds)], {
								Volume = 1
							})
							table.remove(activePlane.Crates, i)
						end
					end
				end
			elseif activePlane then
				activePlane:Destroy()
				activePlane = nil
			end
		end
		function eventManager.OnHatchOpenRequest()
			if activePlane == nil then
				error("No running plane to open hatch of.")
			end
			activePlane.HatchOpenedAt = Time.GetNowSync()
			activePlane.Tl_Hatch = Timeline.new(activePlane.SeqsHatch)
		end
		for v32, v42 in CollectionService:GetTagged("ReplicateCharacterPlane") do
			table.insert(replicateCharacterPlaneList, v42)
		end
		local pendingRemovals = {}
		CollectionService:GetInstanceAddedSignal("ReplicateCharacterPlane"):Connect(function(instance)
			table.insert(replicateCharacterPlaneList, instance)
			if pendingRemovals[instance] then
				task.cancel(pendingRemovals[instance])
				pendingRemovals[instance] = nil
			end
		end)
		CollectionService:GetInstanceRemovedSignal("ReplicateCharacterPlane"):Connect(function(instance)
			table.remove(replicateCharacterPlaneList, table.find(replicateCharacterPlaneList, instance))
			if pendingRemovals[instance] then
				task.cancel(pendingRemovals[instance])
			end
			pendingRemovals[instance] = task.delay(2, function()
				modelOffsetCache[instance] = nil
				pendingRemovals[instance] = nil
			end)
		end)
	end
}
