local RunService = game:GetService("RunService")
game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Audio = require(ReplicatedStorage.Std.Audio)
local Signal = require(ReplicatedStorage.Std.Signal)
local C4Consts = require(ReplicatedStorage.Game.C4.C4Consts)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local LocalPlayer = game:GetService("Players").LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local remoteEvent = nil
local eventManager = nil
local createVector3 = Vector3.new
local FindPartOnRayWithIgnoreList = workspace.FindPartOnRayWithIgnoreList
local function findPartOnRay(rayOrigin, rayDirection, ...)
	local magnitude = rayDirection.magnitude
	local unit = rayDirection.unit
	local distanceTraveled = 0
	local ignoreList = { ... }
	TableUtils.concatInPlace(ignoreList, CollectionService:GetTagged(C4Consts.TAG_NAME))
	if workspace:FindFirstChild("NetworkFixPart1") then
		table.insert(ignoreList, workspace.NetworkFixPart1)
	end
	local rayCount, currentPosition = 0, rayOrigin
	while true do
		local hitPart, hitPosition
		rayCount = rayCount + 1
		local foundPart, foundPosition, foundMaterial = FindPartOnRayWithIgnoreList(workspace, Ray.new(currentPosition, unit * (magnitude - distanceTraveled)), ignoreList, false, true)
		if foundPart then
			foundPart = foundPart.CanCollide
		end
		local canCollideNow = foundPart
		if not foundPart then
			table.insert(ignoreList, canCollideNow)
		end
		distanceTraveled = (rayOrigin - foundPosition).magnitude
		if foundPart or (magnitude - distanceTraveled <= 0.001 or rayCount > 4) then
			if canCollideNow then
				hitPosition = foundPosition
				hitPart = foundMaterial
			else
				hitPart = createVector3
				hitPosition = rayOrigin + unit * magnitude
			end
			return canCollideNow, hitPosition, hitPart
		end
		currentPosition = foundPosition
	end
end
local stopParachuteCallback = nil
local stopGliderCallback = nil
local onParachuteStopped = Signal.new()
local onGliderStopped = Signal.new()
local currentFlightState = nil
local function IsFlying()
	return currentFlightState ~= nil
end
local function UpdateParachute()
	local HumanoidRootPart = currentFlightState.HumanoidRootPart
	local cameraAngled = CurrentCamera.CFrame * CFrame.Angles(0.2, 0, 0)
	local rotationClamp = math.clamp(HumanoidRootPart.RotVelocity.y, -4, 4)
	local verticalDot = math.abs((cameraAngled.LookVector:Dot(Vector3.new(0, 1, 0))))
	local horizontalDirection = Vector3.new(cameraAngled.LookVector.X, 0, cameraAngled.lookVector.Z)
	currentFlightState.Velocity.Velocity = horizontalDirection * 60 * math.max(0.5, verticalDot) + Vector3.new(0, verticalDot, 0) * -40
	currentFlightState.Gyro.CFrame = CFrame.new(Vector3.new(), cameraAngled.lookVector) * CFrame.new(0, 0, rotationClamp * 0.125)
	local hitGround, _ = findPartOnRay(HumanoidRootPart.Position, Vector3.new(0, -4, 0), HumanoidRootPart.Parent)
	if hitGround and not hitGround:IsDescendantOf(workspace.Vehicles) then
		stopParachuteCallback()
	end
end
local function RawParachute()
	if currentFlightState then
		print("Already has parachute")
		return false
	else
		local Character = LocalPlayer.Character
		if Character then
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid then
				local PrimaryPart = Character.PrimaryPart
				if PrimaryPart then
					if Humanoid.PlatformStand or Humanoid.Sit then
						return false
					else
						Humanoid.PlatformStand = true
						Humanoid:ChangeState(Enum.HumanoidStateType.PlatformStanding)
						currentFlightState = {
							Type = "Parachute"
						}
						local BodyGyro = Instance.new("BodyGyro")
						BodyGyro.MaxTorque = Vector3.new(10000, 10000, 10000)
						BodyGyro.CFrame = CurrentCamera.CFrame * CFrame.Angles(0.2, 0, 0)
						BodyGyro.Parent = PrimaryPart
						local BodyVelocity = Instance.new("BodyVelocity")
						BodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
						BodyVelocity.Velocity = Vector3.new(0, -1, 0)
						BodyVelocity.Parent = PrimaryPart
						currentFlightState.Gyro = BodyGyro
						currentFlightState.Velocity = BodyVelocity
						currentFlightState.HumanoidRootPart = PrimaryPart
						currentFlightState.Humanoid = Humanoid
						Audio.ObjectLocal(Humanoid.RootPart, 4482070135)
						currentFlightState.Loop = RunService.Heartbeat:Connect(UpdateParachute)
						return true
					end
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	end
end
local function RawParachuteStop()
	if currentFlightState and currentFlightState.Type == "Parachute" then
		currentFlightState.Gyro:Destroy()
		currentFlightState.Velocity:Destroy()
		currentFlightState.Loop:Disconnect()
		currentFlightState.Humanoid.PlatformStand = false
		currentFlightState = nil
		onParachuteStopped:Fire()
		return true
	else
		return false
	end
end
local function Parachute()
	if not RawParachute() then
		return false
	end
	remoteEvent:FireServer("openParachute")
end
stopParachuteCallback = function()
	local stopSucceeded
	if currentFlightState and currentFlightState.Type == "Parachute" then
		currentFlightState.Gyro:Destroy()
		currentFlightState.Velocity:Destroy()
		currentFlightState.Loop:Disconnect()
		currentFlightState.Humanoid.PlatformStand = false
		currentFlightState = nil
		onParachuteStopped:Fire()
		stopSucceeded = true
	else
		stopSucceeded = false
	end
	if not stopSucceeded then
		return false
	end
	remoteEvent:FireServer("closeParachute")
end
local function UpdateGlider()
	local HumanoidRootPart = currentFlightState.HumanoidRootPart
	local cameraAngled = CurrentCamera.CFrame * CFrame.Angles(0.2, 0, 0)
	local verticalDot = math.abs((math.clamp(cameraAngled.lookVector:Dot(Vector3.new(0, 1, 0)), -1, -0.06)))
	local horizontalDirection = Vector3.new(cameraAngled.lookVector.X, 0, cameraAngled.lookVector.Z)
	currentFlightState.Velocity.Velocity = horizontalDirection * 60 * math.max(0.9, verticalDot) + Vector3.new(0, verticalDot, 0) * -90
	currentFlightState.Gyro.CFrame = CFrame.new(Vector3.new(), cameraAngled.lookVector * 1) * CFrame.Angles(-1.8849555921538759, 0, 0)
	local hitGround, _ = findPartOnRay(HumanoidRootPart.Position, Vector3.new(0, -3, 0), HumanoidRootPart.Parent)
	if hitGround and (not hitGround:IsDescendantOf(workspace.Vehicles) and tick() - currentFlightState.Started > 1) then
		stopGliderCallback()
	end
end
local function RawGlider()
	if currentFlightState then
		print("Already has glider")
		return false
	else
		local Character = LocalPlayer.Character
		if Character then
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid then
				local PrimaryPart = Character.PrimaryPart
				if PrimaryPart then
					if Humanoid.PlatformStand or Humanoid.Sit then
						return false
					else
						Humanoid.PlatformStand = true
						Humanoid:ChangeState(Enum.HumanoidStateType.PlatformStanding)
						currentFlightState = {
							Type = "Glider"
						}
						local BodyGyro = Instance.new("BodyGyro")
						BodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
						BodyGyro.CFrame = CurrentCamera.CFrame * CFrame.Angles(-math.pi / 2, 0, 0)
						BodyGyro.Parent = PrimaryPart
						local BodyVelocity = Instance.new("BodyVelocity")
						BodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
						BodyVelocity.Velocity = Vector3.new(0, -1, 0)
						BodyVelocity.Parent = PrimaryPart
						currentFlightState.Gyro = BodyGyro
						currentFlightState.Velocity = BodyVelocity
						currentFlightState.HumanoidRootPart = PrimaryPart
						currentFlightState.Humanoid = Humanoid
						currentFlightState.Started = tick()
						currentFlightState.Loop = RunService.Heartbeat:Connect(UpdateGlider)
						return true
					end
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	end
end
local function RawGliderStop()
	if currentFlightState and currentFlightState.Type == "Glider" then
		currentFlightState.Gyro:Destroy()
		currentFlightState.Velocity:Destroy()
		currentFlightState.Loop:Disconnect()
		currentFlightState.Humanoid.PlatformStand = false
		currentFlightState.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		currentFlightState = nil
		onGliderStopped:Fire()
		return true
	else
		return false
	end
end
local function Glider()
	if not RawGlider() then
		return false
	end
	remoteEvent:FireServer("openGlider")
end
stopGliderCallback = function()
	if not RawGliderStop() then
		return false
	end
	remoteEvent:FireServer("closeGlider")
end
return {
	Init = function(initConfig)
		local em = initConfig.em
		remoteEvent = initConfig.Event
		eventManager = em
		function em.openParachute()
			if not RawParachute() then
				remoteEvent:FireServer("closeParachute")
			end
		end
		function em.closeParachute()
			if currentFlightState then
				if currentFlightState.Type == "Parachute" then
					currentFlightState.Gyro:Destroy()
					currentFlightState.Velocity:Destroy()
					currentFlightState.Loop:Disconnect()
					currentFlightState.Humanoid.PlatformStand = false
					currentFlightState = nil
					onParachuteStopped:Fire()
				end
			end
		end
		function em.openGlider()
			if not RawGlider() then
				remoteEvent:FireServer("closeGlider")
			end
		end
		function em.closeGlider()
			RawGliderStop()
		end
		require(script.Parent.DefaultActions).onJumpPressed:Connect(function()
			if currentFlightState and currentFlightState.Type == "Glider" then
				stopGliderCallback()
			end
		end)
	end,
	Parachute = Parachute,
	ParachuteStop = stopParachuteCallback,
	Glider = Glider,
	GliderStop = stopGliderCallback,
	IsFlying = IsFlying,
	OnParachuteStopped = onParachuteStopped,
	OnGliderStopped = onGliderStopped
}
