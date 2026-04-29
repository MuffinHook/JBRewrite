
local CurrentCamera = workspace.CurrentCamera

local CollectionService = game:GetService("CollectionService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local BaseUserControlledPlane = require(ReplicatedStorage.Game.Plane.BaseUserControlledPlane)
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local Audio = require(ReplicatedStorage.Std.Audio)
local PartUtils = require(ReplicatedStorage.Std.PartUtils)
local String = require(ReplicatedStorage.Std.String)
local Interval = require(ReplicatedStorage.Std.Interval)
local Confirmation = require(ReplicatedStorage.Module.Confirmation)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local SeekingMissileBinder = require(ReplicatedStorage.SeekingMissile.SeekingMissileBinder)
local NetObjPoolBinder = require(ReplicatedStorage.NetObjPool.NetObjPoolBinder)
local JetConsts = require(ReplicatedStorage.Game.Plane.JetConsts)

require(ReplicatedStorage.Game.Missile)
require(ReplicatedStorage.Module.Time)

local eventRemote = nil
local eventManager = nil
local rng = Random.new()

local JetClass = {
	__ClassName = "Jet"
}

JetClass.__index = JetClass

function JetClass.Init(config)
	eventRemote = config.Event
	eventManager = config.em
end

function JetClass.new(config)
	local jetInstance = setmetatable({}, JetClass)

	jetInstance.Meta = config
	jetInstance.Model = config.Model
	jetInstance.Plane = BaseUserControlledPlane.new(config, {
		SUSPENSION_HEIGHT_FRONT = 6.5,
		SUSPENSION_HEIGHT_BACK = 5.5,
		HEIGHT_MAX = 2100,
		MAX_THRUST = 1400
	})

	jetInstance.Maid = jetInstance.Plane.Maid

	jetInstance:SetupSeats()
	jetInstance.Seats = jetInstance.Plane.Seats

	jetInstance.Plane.OnTakeoff = function()
		Audio.ObjectLocal(jetInstance.Plane.PlaneGui, 3378079535)
	end

	jetInstance.MotorAileronRight = config.MotorAileronRight
	jetInstance.MotorAileronLeft = config.MotorAileronLeft
	jetInstance.MotorAileronTailLeft = config.MotorAileronTailLeft
	jetInstance.MotorAileronTailRight = config.MotorAileronTailRight

	jetInstance.Plane.WheelsConf = config.WheelsConf
	jetInstance.MissilesConf = config.MissilesConf
	jetInstance.MissilesConf.Idx = 1
	jetInstance.MissilesConf.LastFire = 0
	jetInstance.MissilesConf.Count = 0

	return jetInstance
end

function JetClass.SetupSeats(jet)
	local seatConfig = {}

	seatConfig.Part = assert(jet.Model.Passenger)
	seatConfig.Occupied = false

	table.insert(jet.Plane.Seats, seatConfig)
end

local function CanLaunchMissile(jet)
	local currentTime = os.clock()
	local MissilesConf = jet.MissilesConf

	if currentTime - MissilesConf.LastFire < 2 then
		return false
	end

	return MissilesConf.Count > 0
end

local function GetTargetPart(jet)
	local Model = jet.Model
	local Position = Model.PrimaryPart.Position
	local LookVector = Model.PrimaryPart.CFrame.LookVector

	local dotThreshold = 0.9238795325112867
	local targetPart = nil

	for _, TaggedPart in CollectionService:GetTagged(JetConsts.SEEKING_LOCK_TAG_NAME) do
		if not TaggedPart:IsDescendantOf(Model) then
			local offset = TaggedPart.Position - Position

			if offset.Magnitude < 768 then
				local dot = offset.Unit:Dot(LookVector)

				if dotThreshold <= dot then
					dotThreshold = dot
					targetPart = TaggedPart
				end
			end
		end
	end

	return targetPart
end

local function attemptSetSightColor(jet, color)
	local PlaneGui = jet.Plane.PlaneGui
	local currentTime = os.clock()

	if not jet.lastSightsColorChange then
		jet.lastSightsColorChange = 0
	end

	if currentTime - jet.lastSightsColorChange < 0.1 then
		return
	end

	if PlaneGui.Sights.ImageColor3 ~= color then
		jet.lastSightsColorChange = currentTime
		PlaneGui.Sights.ImageColor3 = color
	end
end

local function GetMissileTarget(jet, missilePart)
	local now = os.clock()

	if jet.targetPart and now - jet.targetPartFoundAt >= JetConsts.SEEKING_LOCK_MIN_DURATION then
		return jet.targetPart, nil
	end

	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = { jet.Model, LocalPlayer.Character }

	local raycastResult = Raycast.collidable(missilePart.Position, missilePart.CFrame.LookVector, 999, raycastParams)

	if raycastResult then
		return nil, raycastResult.Position
	end

	return nil, missilePart.Position + missilePart.CFrame.LookVector * 4096
end

local function AttemptLaunchLocalMissile(jet, seat)
	if not CanLaunchMissile(jet) then
		return false
	end

	local MissilesConf = jet.MissilesConf
	MissilesConf.LastFire = os.clock()

	local Idx = MissilesConf.Idx
	local missilePart = MissilesConf.Parts[Idx]

	local targetPart, targetPos = GetMissileTarget(jet, missilePart)

	MissilesConf.Idx = Idx % MissilesConf.NumParts + 1

	task.delay(2, PartUtils.setPropertyWithRollback(missilePart, "Transparency", 1))

	local obj = NetObjPoolBinder:Get(jet.Model:FindFirstChild("JetDriverMissilePool")):Get().obj

	obj.Anchored = false
	obj.CFrame = missilePart.CFrame
	obj.Velocity = missilePart.Velocity

	SeekingMissileBinder:Promise(obj):andThen(function(missile)
		table.insert(missile.ignoreList, jet.Model)

		if targetPart then
			missile:SetTargetPart(targetPart)
		else
			missile:SetTargetPos(targetPos)
		end
	end)

	MissilesConf.Count = MissilesConf.Count - 1

	seat.CameraSpring:Accelerate(Vector3.new(
		10 * (rng:NextNumber() * 2 - 1),
		10 * (rng:NextNumber() * 2 - 1),
		10 * (rng:NextNumber() * 2 - 1)
	) + Vector3.new(0, 0, -50))

	attemptSetSightColor(jet, Color3.fromRGB(0, 255, 0))

	eventRemote:FireServer("usqlew42", obj)

	return true
end

local function OpenMissileBuy(jet)
	local missingCount = math.max(0, JetConsts.MISSILE_COUNT_MAX - jet.MissilesConf.Count)

	if missingCount == 0 then
		return
	end

	if jet.IsMissileBuyOpen then
		return
	end

	jet.IsMissileBuyOpen = true
	jet.Plane:SetControlsEnabled(false)

	local confirmation = Confirmation.new(("Buy %d heat seeking missiles for $%s?"):format(
		missingCount,
		String.comma(missingCount * JetConsts.MISSILE_COST_PER)
	))

	confirmation.Maid:GiveTask(confirmation.OnYes:Connect(function()
		eventRemote:FireServer("qp3y3th9")
	end))

	confirmation.Maid:GiveTask(function()
		jet.IsMissileBuyOpen = false
		jet.Plane:SetControlsEnabled(true)
	end)
end

local function TryLaunchMissile(jet, seat)
	if RunUtils.isTradeWorld() then
		return false
	end

	if jet.MissilesConf.Count <= 0 then
		OpenMissileBuy(jet)
		return false
	end

	return AttemptLaunchLocalMissile(jet, seat)
end

local function UpdateAilerons(jet)
	local Joystickx = jet.Plane.Joystickx
	local Joysticky = jet.Plane.Joysticky
	local InputYaw = jet.Plane.InputYaw

	local joystickMagnitude = (Joystickx * Joystickx + Joysticky * Joysticky) ^ 0.5
	local normalizedX = joystickMagnitude > 1 and Joystickx / joystickMagnitude or Joystickx
	local normalizedY = joystickMagnitude > 1 and Joysticky / joystickMagnitude or Joysticky

	jet.MotorAileronRight.C0 = CFrame.new(0, 0, 1.5) * CFrame.Angles(0.3 * (normalizedY + normalizedX), 0, 0)
	jet.MotorAileronLeft.C0 = CFrame.new(0, 0, 1.5) * CFrame.Angles(0.3 * (normalizedY - normalizedX), 0, 0)
	jet.MotorAileronTailRight.C0 = CFrame.new(0, 0, 1.5) * CFrame.Angles(0, -0.5 * normalizedX + 0.3 * InputYaw, 0)
	jet.MotorAileronTailLeft.C0 = CFrame.new(0, 0, 1.5) * CFrame.Angles(0, -0.5 * normalizedX + 0.3 * InputYaw, 0)
end

local function UpdateTargetPart(jet)
	local targetPart = if jet.Plane.IsFlying then GetTargetPart(jet) else nil

	if targetPart ~= jet.targetPart then
		jet.targetPart = targetPart

		if targetPart ~= nil then
			jet.targetPartFoundAt = os.clock()
		end
	end
end

local function UpdateSights(jet)
	local PlaneGui = jet.Plane.PlaneGui
	local currentTime = os.clock()

	local targetPart = jet.targetPart
	local targetPos = if targetPart then targetPart.Position else nil

	if targetPos then
		local screenPos = CurrentCamera:WorldToScreenPoint(targetPos)

		PlaneGui.Sights.Position = UDim2.new(0, screenPos.X, 0, screenPos.Y)

		local lockTime = currentTime - jet.targetPartFoundAt
		local lockDuration = JetConsts.SEEKING_LOCK_MIN_DURATION

		local transparencyAlpha = math.cos(28.274333882308138 * math.sqrt(1 - math.min(lockTime / lockDuration, 1))) * 0.5 + 0.5
		local isBlinkingUp = jet.LastSightAlpha < transparencyAlpha

		if isBlinkingUp ~= jet.LastSightBlinkUp then
			jet.LastSightBlinkUp = isBlinkingUp

			if isBlinkingUp then
				Audio.ObjectLocal(PlaneGui, 6602021732, {
					Volume = 0.05,
					Pitch = 1
				})
			end
		end

		jet.LastSightAlpha = transparencyAlpha
		PlaneGui.Sights.ImageTransparency = 1 - transparencyAlpha

		if lockDuration <= lockTime then
			if not jet.TargetLocked then
				Audio.ObjectLocal(PlaneGui, 6602021732, {
					Volume = 0.1,
					Pitch = 1.2
				})
			end

			jet.TargetLocked = true
			attemptSetSightColor(jet, Color3.fromRGB(255, 0, 0))
		else
			jet.TargetLocked = false
			attemptSetSightColor(jet, Color3.fromRGB(255, 255, 255))
		end
	end

	PlaneGui.Sights.Visible = targetPos ~= nil
end

local function MountLocalPlayer(jet, player, seat)
	if not seat.Driver then
		return
	end

	jet.LastSightBlinkUp = true
	jet.LastSightAlpha = 0
	jet.TargetLocked = false
	jet.IsMissileBuyOpen = false

	seat.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		UpdateAilerons(jet)
	end))

	local PlaneGui = jet.Plane.PlaneGui
	PlaneGui.Sights.Size = UDim2.new(0.08, 0, 0.08, 0)

	seat.Maid:GiveTask(Interval.every(1/3):Connect(function()
		UpdateTargetPart(jet)
	end))

	seat.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		UpdateSights(jet)
	end))

	PlaneGui.Missiles.Visible = true

	seat.Maid:GiveTask(ActionButtonService.add({
		priority = 500,
		image = "rbxassetid://4939737424",
		keyCodes = { Enum.KeyCode.G },
		onPressed = function()
			OpenMissileBuy(jet)
		end
	}))

	seat.Maid:GiveTask(UserInputService.InputBegan:Connect(function(input, processed)
		if processed then
			return false
		end

		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			TryLaunchMissile(jet, seat)
		end
	end))

	seat.Maid:GiveTask(ActionButtonService.add({
		priority = 500,
		noSink = true,
		image = "rbxassetid://4939736393",
		keyCodes = { Enum.KeyCode.F, Enum.KeyCode.ButtonX },
		onPressed = function()
			TryLaunchMissile(jet, seat)
		end
	}))
end

local function MountThirdPlayer(jet, player, seat)
	local jetAudio = Audio.ObjectLocal(jet.Model.PrimaryPart, 9553468279, {
		Looped = true,
		Volume = 0,
		Pitch = 1,
		RollOffMinDistance = 86,
		RollOffMaxDistance = 896
	})

	seat.Maid:GiveTask(jetAudio)

	seat.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		local speed = jet.Model.PrimaryPart.Velocity:Dot(jet.Model.PrimaryPart.CFrame.LookVector)
		local alpha = math.clamp(speed / 300, 0, 1)

		jetAudio.Volume = alpha * 0.4
		jetAudio.PlaybackSpeed = alpha * 0.35 + 0.65
	end))
end

function JetClass.MountPlayer(jet, player, seat)
	jet.Plane:MountPlayer(player, seat)

	if player == LocalPlayer then
		MountLocalPlayer(jet, player, seat)
	else
		MountThirdPlayer(jet, player, seat)
	end
end

function JetClass.UnmountSeat(jet, seat)
	if seat.Player == LocalPlayer then
		local PlaneGui = jet.Plane.PlaneGui

		if seat.Driver then
			PlaneGui.Missiles.Visible = false
		end
	end

	return jet.Plane:UnmountSeat(seat)
end

function JetClass.UpdateMissileUI(jet, missileCount, maxMissiles)
	assert(missileCount)

	jet.MissilesConf.Count = missileCount
	jet.Plane.PlaneGui:FindFirstChild("Missiles").Body.Current.Count.Text = ("%d/%d"):format(missileCount, maxMissiles)
end

function JetClass.Destroy(jet)
	jet.Plane:Destroy()
end

return JetClass
