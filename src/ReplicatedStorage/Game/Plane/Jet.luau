-- Reviewed by Claude
-- variables reassigned

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

local t = {
	__ClassName = "Jet"
}

t.__index = t

function t.Init(p1)
	eventRemote = p1.Event
	eventManager = p1.em
end

function t.new(p1)
	local jetInstance = setmetatable({}, t)

	jetInstance.Meta = p1
	jetInstance.Model = p1.Model
	jetInstance.Plane = BaseUserControlledPlane.new(p1, {
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

	jetInstance.MotorAileronRight = p1.MotorAileronRight
	jetInstance.MotorAileronLeft = p1.MotorAileronLeft
	jetInstance.MotorAileronTailLeft = p1.MotorAileronTailLeft
	jetInstance.MotorAileronTailRight = p1.MotorAileronTailRight

	jetInstance.Plane.WheelsConf = p1.WheelsConf
	jetInstance.MissilesConf = p1.MissilesConf
	jetInstance.MissilesConf.Idx = 1
	jetInstance.MissilesConf.LastFire = 0
	jetInstance.MissilesConf.Count = 0

	return jetInstance
end

function t.SetupSeats(p1)
	local seatConfig = {}

	seatConfig.Part = assert(p1.Model.Passenger)
	seatConfig.Occupied = false

	table.insert(p1.Plane.Seats, seatConfig)
end

local function CanLaunchMissile(p1)
	local currentTime = os.clock()
	local MissilesConf = p1.MissilesConf

	if currentTime - MissilesConf.LastFire < 2 then
		return false
	end

	return MissilesConf.Count > 0
end

local function GetTargetPart(p1)
	local Model = p1.Model
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

local function attemptSetSightColor(p1, color)
	local PlaneGui = p1.Plane.PlaneGui
	local currentTime = os.clock()

	if not p1.lastSightsColorChange then
		p1.lastSightsColorChange = 0
	end

	if currentTime - p1.lastSightsColorChange < 0.1 then
		return
	end

	if PlaneGui.Sights.ImageColor3 ~= color then
		p1.lastSightsColorChange = currentTime
		PlaneGui.Sights.ImageColor3 = color
	end
end

local function GetMissileTarget(p1, missilePart)
	local now = os.clock()

	if p1.targetPart and now - p1.targetPartFoundAt >= JetConsts.SEEKING_LOCK_MIN_DURATION then
		return p1.targetPart, nil
	end

	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = { p1.Model, LocalPlayer.Character }

	local raycastResult = Raycast.collidable(missilePart.Position, missilePart.CFrame.LookVector, 999, raycastParams)

	if raycastResult then
		return nil, raycastResult.Position
	end

	return nil, missilePart.Position + missilePart.CFrame.LookVector * 4096
end

local function AttemptLaunchLocalMissile(p1, p2)
	if not CanLaunchMissile(p1) then
		return false
	end

	local MissilesConf = p1.MissilesConf
	MissilesConf.LastFire = os.clock()

	local Idx = MissilesConf.Idx
	local missilePart = MissilesConf.Parts[Idx]

	local targetPart, targetPos = GetMissileTarget(p1, missilePart)

	MissilesConf.Idx = Idx % MissilesConf.NumParts + 1

	task.delay(2, PartUtils.setPropertyWithRollback(missilePart, "Transparency", 1))

	local obj = NetObjPoolBinder:Get(p1.Model:FindFirstChild("JetDriverMissilePool")):Get().obj

	obj.Anchored = false
	obj.CFrame = missilePart.CFrame
	obj.Velocity = missilePart.Velocity

	SeekingMissileBinder:Promise(obj):andThen(function(missile)
		table.insert(missile.ignoreList, p1.Model)

		if targetPart then
			missile:SetTargetPart(targetPart)
		else
			missile:SetTargetPos(targetPos)
		end
	end)

	MissilesConf.Count = MissilesConf.Count - 1

	p2.CameraSpring:Accelerate(Vector3.new(
		10 * (rng:NextNumber() * 2 - 1),
		10 * (rng:NextNumber() * 2 - 1),
		10 * (rng:NextNumber() * 2 - 1)
	) + Vector3.new(0, 0, -50))

	attemptSetSightColor(p1, Color3.fromRGB(0, 255, 0))

	eventRemote:FireServer("u" .. ("f6xqsmh"):sub(4, 5):reverse() .. "lew42", obj)

	return true
end

local function OpenMissileBuy(p1)
	local missingCount = math.max(0, JetConsts.MISSILE_COUNT_MAX - p1.MissilesConf.Count)

	if missingCount == 0 then
		return
	end

	if p1.IsMissileBuyOpen then
		return
	end

	p1.IsMissileBuyOpen = true
	p1.Plane:SetControlsEnabled(false)

	local confirmation = Confirmation.new(("Buy %d heat seeking missiles for $%s?"):format(
		missingCount,
		String.comma(missingCount * JetConsts.MISSILE_COST_PER)
	))

	confirmation.Maid:GiveTask(confirmation.OnYes:Connect(function()
		eventRemote:FireServer("q" .. ("iufp3y3phw"):sub(5, 8):reverse():reverse():reverse() .. "" .. "" .. ("cdctv"):sub(4, 4):reverse() .. "h9")
	end))

	confirmation.Maid:GiveTask(function()
		p1.IsMissileBuyOpen = false
		p1.Plane:SetControlsEnabled(true)
	end)
end

local function TryLaunchMissile(p1, p2)
	if RunUtils.isTradeWorld() then
		return false
	end

	if p1.MissilesConf.Count <= 0 then
		OpenMissileBuy(p1)
		return false
	end

	return AttemptLaunchLocalMissile(p1, p2)
end

local function UpdateAilerons(p1)
	local Joystickx = p1.Plane.Joystickx
	local Joysticky = p1.Plane.Joysticky
	local InputYaw = p1.Plane.InputYaw

	local joystickMagnitude = (Joystickx * Joystickx + Joysticky * Joysticky) ^ 0.5
	local normalizedX = joystickMagnitude > 1 and Joystickx / joystickMagnitude or Joystickx
	local normalizedY = joystickMagnitude > 1 and Joysticky / joystickMagnitude or Joysticky

	p1.MotorAileronRight.C0 = CFrame.new(0, 0, 1.5) * CFrame.Angles(0.3 * (normalizedY + normalizedX), 0, 0)
	p1.MotorAileronLeft.C0 = CFrame.new(0, 0, 1.5) * CFrame.Angles(0.3 * (normalizedY - normalizedX), 0, 0)
	p1.MotorAileronTailRight.C0 = CFrame.new(0, 0, 1.5) * CFrame.Angles(0, -0.5 * normalizedX + 0.3 * InputYaw, 0)
	p1.MotorAileronTailLeft.C0 = CFrame.new(0, 0, 1.5) * CFrame.Angles(0, -0.5 * normalizedX + 0.3 * InputYaw, 0)
end

local function UpdateTargetPart(p1)
	local targetPart = if p1.Plane.IsFlying then GetTargetPart(p1) else nil

	if targetPart ~= p1.targetPart then
		p1.targetPart = targetPart

		if targetPart ~= nil then
			p1.targetPartFoundAt = os.clock()
		end
	end
end

local function UpdateSights(p1)
	local PlaneGui = p1.Plane.PlaneGui
	local currentTime = os.clock()

	local targetPart = p1.targetPart
	local targetPos = if targetPart then targetPart.Position else nil

	if targetPos then
		local screenPos = CurrentCamera:WorldToScreenPoint(targetPos)

		PlaneGui.Sights.Position = UDim2.new(0, screenPos.X, 0, screenPos.Y)

		local lockTime = currentTime - p1.targetPartFoundAt
		local lockDuration = JetConsts.SEEKING_LOCK_MIN_DURATION

		local transparencyAlpha = math.cos(28.274333882308138 * math.sqrt(1 - math.min(lockTime / lockDuration, 1))) * 0.5 + 0.5
		local isBlinkingUp = p1.LastSightAlpha < transparencyAlpha

		if isBlinkingUp ~= p1.LastSightBlinkUp then
			p1.LastSightBlinkUp = isBlinkingUp

			if isBlinkingUp then
				Audio.ObjectLocal(PlaneGui, 6602021732, {
					Volume = 0.05,
					Pitch = 1
				})
			end
		end

		p1.LastSightAlpha = transparencyAlpha
		PlaneGui.Sights.ImageTransparency = 1 - transparencyAlpha

		if lockDuration <= lockTime then
			if not p1.TargetLocked then
				Audio.ObjectLocal(PlaneGui, 6602021732, {
					Volume = 0.1,
					Pitch = 1.2
				})
			end

			p1.TargetLocked = true
			attemptSetSightColor(p1, Color3.fromRGB(255, 0, 0))
		else
			p1.TargetLocked = false
			attemptSetSightColor(p1, Color3.fromRGB(255, 255, 255))
		end
	end

	PlaneGui.Sights.Visible = targetPos ~= nil
end

local function MountLocalPlayer(p1, p2, p3)
	if not p3.Driver then
		return
	end

	p1.LastSightBlinkUp = true
	p1.LastSightAlpha = 0
	p1.TargetLocked = false
	p1.IsMissileBuyOpen = false

	p3.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		UpdateAilerons(p1)
	end))

	local PlaneGui = p1.Plane.PlaneGui
	PlaneGui.Sights.Size = UDim2.new(0.08, 0, 0.08, 0)

	p3.Maid:GiveTask(Interval.every(0.3333333333333333):Connect(function()
		UpdateTargetPart(p1)
	end))

	p3.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		UpdateSights(p1)
	end))

	PlaneGui.Missiles.Visible = true

	p3.Maid:GiveTask(ActionButtonService.add({
		priority = 500,
		image = "rbxassetid://4939737424",
		keyCodes = { Enum.KeyCode.G },
		onPressed = function()
			OpenMissileBuy(p1)
		end
	}))

	p3.Maid:GiveTask(UserInputService.InputBegan:Connect(function(input, processed)
		if processed then
			return false
		end

		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			TryLaunchMissile(p1, p3)
		end
	end))

	p3.Maid:GiveTask(ActionButtonService.add({
		priority = 500,
		noSink = true,
		image = "rbxassetid://4939736393",
		keyCodes = { Enum.KeyCode.F, Enum.KeyCode.ButtonX },
		onPressed = function()
			TryLaunchMissile(p1, p3)
		end
	}))
end

local function MountThirdPlayer(p1, p2, p3)
	local jetAudio = Audio.ObjectLocal(p1.Model.PrimaryPart, 9553468279, {
		Looped = true,
		Volume = 0,
		Pitch = 1,
		RollOffMinDistance = 86,
		RollOffMaxDistance = 896
	})

	p3.Maid:GiveTask(jetAudio)

	p3.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		local speed = p1.Model.PrimaryPart.Velocity:Dot(p1.Model.PrimaryPart.CFrame.LookVector)
		local alpha = math.clamp(speed / 300, 0, 1)

		jetAudio.Volume = alpha * 0.4
		jetAudio.PlaybackSpeed = alpha * 0.35 + 0.65
	end))
end

function t.MountPlayer(p1, p2, p3)
	p1.Plane:MountPlayer(p2, p3)

	if p2 == LocalPlayer then
		MountLocalPlayer(p1, p2, p3)
	else
		MountThirdPlayer(p1, p2, p3)
	end
end

function t.UnmountSeat(p1, p2)
	if p2.Player == LocalPlayer then
		local PlaneGui = p1.Plane.PlaneGui

		if p2.Driver then
			PlaneGui.Missiles.Visible = false
		end
	end

	return p1.Plane:UnmountSeat(p2)
end

function t.UpdateMissileUI(p1, p2, p3)
	assert(p2)

	p1.MissilesConf.Count = p2
	p1.Plane.PlaneGui:FindFirstChild("Missiles").Body.Current.Count.Text = ("%d/%d"):format(p2, p3)
end

function t.Destroy(p1)
	p1.Plane:Destroy()
end

return t