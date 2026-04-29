local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerModule = nil
local CurrentCamera = workspace.CurrentCamera
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local JetPackUtil = require(ReplicatedStorage.Game.JetPack.JetPackUtil)
local Paraglide = require(ReplicatedStorage.Game.Paraglide)
local Audio = require(ReplicatedStorage.Std.Audio)
local Time = require(ReplicatedStorage.Module.Time)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local Spring = require(ReplicatedStorage.Std.Spring)
local Signal = require(ReplicatedStorage.Std.Signal)
local Region = require(ReplicatedStorage.Std.Region)
local RegionUtils = require(ReplicatedStorage.Std.Region.RegionUtils)
local DefaultActions = require(ReplicatedStorage.Game.DefaultActions)
local AccelTween = require(ReplicatedStorage.Std.AccelTween)
local Interval = require(ReplicatedStorage.Std.Interval)
local VehicleUtils_2 = require(ReplicatedStorage.Vehicle.VehicleUtils)
local JetPackGui = require(script.Parent.JetPackGui)
local Falling = nil
local Event = nil
local function SetHumanoidEnabled(humanoid, enabled)
	local iterNext = next
	local enumItems, startIndex = Enum.HumanoidStateType:GetEnumItems()
	for _, stateType in iterNext, enumItems, startIndex do
		if stateType ~= Enum.HumanoidStateType.Dead and (stateType ~= Enum.HumanoidStateType.None and stateType ~= Enum.HumanoidStateType.Jumping) then
			humanoid:SetStateEnabled(stateType, enabled)
		end
	end
end
local NoFlyZones = {}
local InNoFlyZone = false
local Signals = {
	OnEquipped = nil
}
local abs = math.abs
local JetPack = {
	LocalMaxFuel = 15,
	LocalFuel = 15,
	LocalFuelType = "Standard"
}
local Packets = {}
local SteppedConn = nil
local HeartbeatConn = nil
local ThreadsRunning = false
local function StopThreads()
	assert(ThreadsRunning == true)
	SteppedConn:Disconnect()
	SteppedConn = nil
	HeartbeatConn:Disconnect()
	HeartbeatConn = nil
	ThreadsRunning = false
end
local function CheckThreads()
	if ThreadsRunning == false then
		return true
	elseif #Packets == 0 then
		assert(ThreadsRunning == true)
		SteppedConn:Disconnect()
		SteppedConn = nil
		HeartbeatConn:Disconnect()
		HeartbeatConn = nil
		ThreadsRunning = false
		return true
	else
		return false
	end
end
local function Stepped(_, deltaTime)
	local shouldReturn
	if ThreadsRunning == false then
		shouldReturn = true
	elseif #Packets == 0 then
		assert(ThreadsRunning == true)
		SteppedConn:Disconnect()
		SteppedConn = nil
		HeartbeatConn:Disconnect()
		HeartbeatConn = nil
		ThreadsRunning = false
		shouldReturn = true
	else
		shouldReturn = false
	end
	if shouldReturn then
		return false
	end
	for i = #Packets, 1, -1 do
		JetPack.Stepped(Packets[i], deltaTime)
	end
end
local function Heartbeat(deltaTime)
	local shouldReturn
	if ThreadsRunning == false then
		shouldReturn = true
	elseif #Packets == 0 then
		assert(ThreadsRunning == true)
		SteppedConn:Disconnect()
		SteppedConn = nil
		HeartbeatConn:Disconnect()
		HeartbeatConn = nil
		ThreadsRunning = false
		shouldReturn = true
	else
		shouldReturn = false
	end
	if shouldReturn then
		return false
	end
	for i = #Packets, 1, -1 do
		JetPack.Heartbeat(Packets[i], deltaTime)
	end
end
local function StartThreads()
	assert(ThreadsRunning == false)
	ThreadsRunning = true
	HeartbeatConn = RunService.Stepped:Connect(Stepped)
	SteppedConn = RunService.Heartbeat:Connect(Heartbeat)
end
local function AddPacket(packet)
	table.insert(Packets, packet)
	if #Packets == 1 then
		assert(ThreadsRunning == false)
		ThreadsRunning = true
		HeartbeatConn = RunService.Stepped:Connect(Stepped)
		SteppedConn = RunService.Heartbeat:Connect(Heartbeat)
	end
end
local function GetPacketByPlayer(player)
	for i = #Packets, 1, -1 do
		local packet = Packets[i]
		if packet.Player == player then
			return packet, i
		end
	end
	return nil
end
function JetPack.Equip(player, fuelData)
	if Paraglide.IsFlying() == true then
		Paraglide.ParachuteStop()
	end
	assert(player, "Player is nil")
	local Character = player.Character
	assert(Character, "Character is nil")
	local Humanoid = Character:FindFirstChild("Humanoid")
	if Humanoid then
		if Humanoid.Health <= 0 then
			return nil
		else
			local RootPart = Humanoid.RootPart
			if RootPart then
				local packet = {
					Player = player,
					Character = Character,
					Humanoid = Humanoid,
					RootPart = RootPart,
					Model = Character.JetPack,
					IsThrusting = false,
					EquippedAt = tick(),
					SoundThrust = Audio.ObjectLocal(RootPart, 9058734199, {
						Looped = true,
						Volume = 0
					}),
					SoundThrustVolumeTarget = 0.3
				}
				Audio.ObjectLocal(RootPart, 1386598740, {
					TimePosition = 0.5,
					Volume = 0.1
				})
				if player == LocalPlayer then
					JetPack.EquipLocal(packet)
				else
					assert(fuelData)
					local Model = packet.Model
					assert(JetPackUtil.Fuel[fuelData])
				end
				table.insert(Packets, packet)
				if #Packets == 1 then
					assert(ThreadsRunning == false)
					ThreadsRunning = true
					HeartbeatConn = RunService.Stepped:Connect(Stepped)
					SteppedConn = RunService.Heartbeat:Connect(Heartbeat)
				end
				if player == LocalPlayer then
					Event:FireServer("effrclru")
				end
				return packet
			else
				return nil
			end
		end
	else
		return nil
	end
end
function JetPack.UpdateFuel()
	JetPackGui.UpdateFuel(JetPack.LocalFuel, JetPack.LocalMaxFuel)
	for _, child in LocalPlayer.Character:GetChildren() do
		if child:IsA("Model") and child:GetAttribute("IsJetPack") == true then
			local FuelBar = child:FindFirstChild("FuelBar")
			local barCount = #FuelBar:GetChildren()
			local litCount = math.ceil(barCount * JetPack.LocalFuel / JetPack.LocalMaxFuel - 0.001)
			for i = 1, barCount do
				if i <= litCount then
					FuelBar[i].Color = Color3.fromRGB(78, 109, 130)
					FuelBar[i].Material = Enum.Material.Neon
				else
					FuelBar[i].Color = Color3.fromRGB(42, 56, 66)
					FuelBar[i].Material = Enum.Material.SmoothPlastic
				end
			end
		end
	end
end
function JetPack.EquipLocal(packet)
	local Humanoid = packet.Humanoid
	local Animator = Humanoid:FindFirstChildOfClass("Animator")
	SetHumanoidEnabled(Humanoid, false)
	Humanoid:ChangeState(Enum.HumanoidStateType.Flying)
	task.delay(0.1, function()
		local localPlayer = Players.LocalPlayer
		local foundPacket = nil
		for i = #Packets, 1, -1 do
			local jetPacket = Packets[i]
			if jetPacket.Player == localPlayer then
				foundPacket = jetPacket
				break
			end
		end
		if foundPacket then
			for _, track in Animator:GetPlayingAnimationTracks() do
				track:Stop(0.1)
			end
		end
	end)
	local RootPart = packet.RootPart
	packet.MovingSpring = Spring.new(0, 0, 0.8, 10)
	local BodyVelocity = Instance.new("BodyVelocity")
	BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
	BodyVelocity.Velocity = RootPart.Velocity
	BodyVelocity.Parent = RootPart
	packet.BodyVelocity = BodyVelocity
	local BodyGyro = Instance.new("BodyGyro")
	BodyGyro.MaxTorque = Vector3.new(1000000, 1000000, 1000000)
	BodyGyro.D = 100
	BodyGyro.P = 500
	BodyGyro.Parent = RootPart
	packet.BodyGyro = BodyGyro
	local groundSmokeLeft = ReplicatedStorage.Resource.JetPack.GroundSmoke:Clone()
	groundSmokeLeft.Parent = workspace
	packet.GroundSmokeLeft = groundSmokeLeft
	local groundSmokeRight = ReplicatedStorage.Resource.JetPack.GroundSmoke:Clone()
	groundSmokeRight.Parent = workspace
	packet.GroundSmokeRight = groundSmokeRight
	packet.GroundSmokeLastEmit = tick()
	packet.ConnAnimationPlayed = Humanoid.AnimationPlayed:Connect(function(track)
		track:Stop()
	end)
	local fuelConfig = JetPackUtil.Fuel[JetPack.LocalFuelType]
	assert(fuelConfig)
	packet.LeanAngle = fuelConfig.LeanAngle
	assert(JetPack.LocalFuel)
	assert(JetPack.LocalMaxFuel)
	JetPack.UpdateFuel()
	Signals.OnEquipped:Fire()
end
function JetPack.Unequip(player)
	local foundPacket = nil
	local foundIndex = nil
	for i = #Packets, 1, -1 do
		local packet = Packets[i]
		if packet.Player == player then
			foundPacket = packet
			foundIndex = i
			break
		end
	end
	if foundPacket then
		assert(foundPacket)
		if foundPacket.IsThrusting then
			JetPack.StopThrust(player)
		end
		table.remove(Packets, foundIndex)
		foundPacket.SoundThrust:Destroy()
		foundPacket.SoundThrust = nil
		JetPack.SetThrustVisual(foundPacket, 0)
		if player == LocalPlayer then
			JetPack.UnequipLocal(foundPacket)
		end
		if player == LocalPlayer then
			Event:FireServer("ab3zo4do")
		end
	end
	return nil
end
function JetPack.UnequipLocal(packet)
	local Humanoid = packet.Humanoid
	local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
	if not vehiclePacket or vehiclePacket.Make ~= "Volt" then
		SetHumanoidEnabled(Humanoid, true)
	end
	Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	packet.BodyGyro:Destroy()
	packet.BodyGyro = nil
	packet.BodyVelocity:Destroy()
	packet.BodyVelocity = nil
	packet.ConnAnimationPlayed:Disconnect()
	packet.ConnAnimationPlayed = nil
end
function JetPack.UpdateJoints(packet, thrustBlend)
	local Character = packet.Character
	if not Character:IsDescendantOf(workspace) then
		JetPack.Unequip(packet.Player)
	end
	local Neck = Character.Head:FindFirstChild("Neck")
	if not Neck then
		JetPack.Unequip(packet.Player)
		return false
	end
	local pitchAngle, _, _ = packet.RootPart.CFrame:ToOrientation()
	Neck.Transform = CFrame.Angles(-pitchAngle * 0.7, 0, 0)
	Character.RightLowerArm.RightElbow.Transform = CFrame.Angles(1.2566370614359172, 0, -0.37699111843077515)
	Character.LeftLowerArm.LeftElbow.Transform = CFrame.Angles(1.2566370614359172, 0, 0.37699111843077515)
	Character.RightUpperArm.RightShoulder.Transform = CFrame.Angles(0.3141592653589793, 0, 0)
	Character.LeftUpperArm.LeftShoulder.Transform = CFrame.Angles(0.3141592653589793, 0, 0)
	Character.RightUpperLeg.RightHip.Transform = CFrame.Angles(math.pi * thrustBlend * 0.15, 0, 0.05 + thrustBlend * 0.1)
	Character.LeftUpperLeg.LeftHip.Transform = CFrame.Angles(math.pi * thrustBlend * 0.15, 0, -0.05 + thrustBlend * -0.1)
	Character.RightLowerLeg.RightKnee.Transform = CFrame.Angles(math.pi * thrustBlend * -0.3, 0, 0)
	Character.LeftLowerLeg.LeftKnee.Transform = CFrame.Angles(math.pi * thrustBlend * -0.3, 0, 0)
end
function JetPack.Stepped(packet, deltaTime)
	local Humanoid = packet.Humanoid
	if Humanoid.Health <= 0 then
		JetPack.Unequip(packet.Player)
	elseif Humanoid:IsDescendantOf(workspace) then
		if packet.Player == LocalPlayer then
			JetPack.SteppedLocal(packet, deltaTime)
		else
			JetPack.UpdateJoints(packet, (math.clamp(packet.RootPart.Velocity.Magnitude / 20, 0, 1)))
		end
	else
		JetPack.Unequip(packet.Player)
	end
end
function JetPack.SteppedLocal(packet, deltaTime)
	JetPack.UpdateJoints(packet, packet.MovingSpring:Update() * 0.5 + 0.5)
	for i, zone in ipairs(NoFlyZones) do
		zone.Region:Update({ LocalPlayer })
	end
end
function JetPack.Heartbeat(packet, deltaTime)
	local Humanoid = packet.Humanoid
	if Humanoid.Health <= 0 then
		JetPack.Unequip(packet.Player)
	elseif Humanoid:IsDescendantOf(workspace) then
		packet.SoundThrust.Volume = packet.SoundThrust.Volume + (packet.SoundThrustVolumeTarget - packet.SoundThrust.Volume) * 0.1
		if packet.Player == LocalPlayer then
			JetPack.HeartbeatLocal(packet, deltaTime)
		end
	else
		JetPack.Unequip(packet.Player)
	end
end
local ThrustAccelTween = AccelTween.new(80)
function JetPack.HeartbeatLocal(packet, deltaTime)
	local now = tick()
	local moveVector = PlayerModule:GetControls():GetMoveVector()
	local _, _2, _3, _4, m12, m13, _5, m22, m23, _6, m32, m33 = CurrentCamera.CFrame:GetComponents()
	local flatCFrame = CFrame.new(0, 0, 0, -m32 * m23 + m22 * m33, 0, m13, m32 * m13 - m12 * m33, 1, m23, -m22 * m13 + m12 * m23, 0, m33)
	local Humanoid = packet.Humanoid
	local RootPart = Humanoid.RootPart
	local isMoving = moveVector.Magnitude > 0.001
	if isMoving then
		packet.LastCF = flatCFrame * CFrame.new(Vector3.new(), moveVector)
	end
	packet.MovingSpring:SetTarget(if isMoving and packet.IsThrusting then 1 else 0)
	local BodyGyro = packet.BodyGyro
	if packet.LastCF then
		local Position = RootPart.Position
		local targetCFrame = packet.LastCF * CFrame.Angles(isMoving and packet.IsThrusting and packet.LeanAngle or 0, 0, 0)
		BodyGyro.CFrame = targetCFrame + Vector3.new(Position.x, Position.y, Position.z)
	end
	local Velocity = RootPart.Velocity
	local dragScale = 1
	local targetSpeed
	if packet.IsThrusting then
		if os.clock() - packet.ThrustingBornAt > 1 then
			targetSpeed = 450
		else
			targetSpeed = 200
			dragScale = dragScale * 3
		end
	else
		targetSpeed = 100
	end
	if ThrustAccelTween.t ~= targetSpeed then
		if ThrustAccelTween.t < 200 or targetSpeed < ThrustAccelTween.t then
			ThrustAccelTween.pt = targetSpeed
		else
			ThrustAccelTween.t = targetSpeed
		end
	end
	packet.BodyVelocity.Velocity = Velocity + (Vector3.new(0, -2746.8, 0) + Vector3.new(dragScale * -4 * 0.5 * Velocity.x * abs(Velocity.x), -6 * Velocity.y * abs(Velocity.y), dragScale * -4 * 0.5 * Velocity.z * abs(Velocity.z)) + RootPart.CFrame.UpVector * (14 * ThrustAccelTween.p)) / 14 * deltaTime
	local groundHit, groundPos = RayCast.RayIgnoreNonCollide(RootPart.Position, Vector3.new(0, -1, 0), 20, LocalPlayer.Character)
	if groundHit ~= nil and (packet.IsThrusting and (now - packet.GroundSmokeLastEmit > 0.05 and packet.LastCF)) then
		packet.GroundSmokeRight.CFrame = CFrame.new(groundPos.x, groundPos.y + 1, groundPos.z) + packet.LastCF * Vector3.new(2, 0, 0)
		packet.GroundSmokeRight.LandingSmoke:Emit(1)
		packet.GroundSmokeLeft.CFrame = CFrame.new(groundPos.x, groundPos.y + 1, groundPos.z) + packet.LastCF * Vector3.new(-2, 0, 0)
		packet.GroundSmokeLeft.LandingSmoke:Emit(1)
		packet.GroundSmokeLastEmit = now
	end
	if now - packet.EquippedAt > 0.1 and not packet.IsThrusting then
		local groundCheck, _ = RayCast.RayIgnoreNonCollide(RootPart.Position, Vector3.new(0, -1, 0), Humanoid.HipHeight + RootPart.Size.Y * 0.5 + 0.5, LocalPlayer.Character)
		if groundCheck then
			JetPack.Unequip(LocalPlayer)
		end
	end
	JetPack.LocalFuel = JetPack.LocalFuel - deltaTime * if packet.IsThrusting then 1 else 1/3
	if JetPack.LocalFuel < 0 then
		JetPack.LocalFuel = 0
		JetPack.Unequip(packet.Player)
	end
	JetPack.UpdateFuel()
	if VehicleUtils.GetLocalVehiclePacket() ~= nil then
		JetPack.Unequip(packet.Player)
	end
end
function JetPack.SetThrustVisual(packet, intensity)
	local anyThrust = intensity > 0.001
	local fullThrust = intensity > 0.5
	local Model = packet.Model
	if Model and Model.Parent then
		for _, descendant in Model.Body:GetDescendants() do
			if descendant:IsA("ParticleEmitter") then
				if descendant.Name == "Flamethrower" then
					descendant.Enabled = fullThrust
				else
					descendant.Enabled = anyThrust
				end
			end
		end
	end
end
function JetPack.StartThrust(player)
	assert(player)
	local packet = nil
	for i = #Packets, 1, -1 do
		local currentPacket = Packets[i]
		if currentPacket.Player == player then
			packet = currentPacket
			break
		end
	end
	if packet then
		assert(packet.IsThrusting == false)
		packet.IsThrusting = true
		packet.ThrustingBornAt = os.clock()
		local Humanoid = packet.Humanoid
		local RootPart = Humanoid.RootPart
		if not RayCast.RayIgnoreNonCollide(RootPart.Position, Vector3.new(0, -1, 0), Humanoid.HipHeight + RootPart.Size.Y * 0.5 + 16, Humanoid.Parent) then
			packet.ThrustingBornAt = packet.ThrustingBornAt - 2
		end
		packet.SoundThrustVolumeTarget = 0.3
		JetPack.SetThrustVisual(packet, 1)
		if player == LocalPlayer then
			Event:FireServer("d0r024ne")
		end
	end
end
function JetPack.StopThrust(player)
	assert(player)
	local packet = nil
	for i = #Packets, 1, -1 do
		local currentPacket = Packets[i]
		if currentPacket.Player == player then
			packet = currentPacket
			break
		end
	end
	if packet then
		assert(packet.IsThrusting == true)
		packet.IsThrusting = false
		packet.SoundThrustVolumeTarget = 0.05
		JetPack.SetThrustVisual(packet, 0.3)
		if player == LocalPlayer then
			Event:FireServer("m1jxlp0h")
		end
	end
end
local function IsFlying()
	local localPlayer = LocalPlayer
	local packet = nil
	for i = #Packets, 1, -1 do
		local currentPacket = Packets[i]
		if currentPacket.Player == localPlayer then
			packet = currentPacket
			break
		end
	end
	return packet ~= nil
end
local function IsThrusting()
	local localPlayer = LocalPlayer
	local packet = nil
	for i = #Packets, 1, -1 do
		local currentPacket = Packets[i]
		if currentPacket.Player == localPlayer then
			packet = currentPacket
			break
		end
	end
	return if packet == nil then false else packet.IsThrusting == true
end
local LastJumpTime = 0
local function OnJump()
	if not Falling.IsRagdolling() then
		local now = tick()
		for i, zone in ipairs(NoFlyZones) do
			zone.Region:Update({ LocalPlayer })
		end
		local localPlayer = LocalPlayer
		local packet = nil
		for i = #Packets, 1, -1 do
			local currentPacket = Packets[i]
			if currentPacket.Player == localPlayer then
				packet = currentPacket
				break
			end
		end
		if now - LastJumpTime < 0.22 and packet == nil then
			if InNoFlyZone == false then
				packet = JetPack.Equip(LocalPlayer)
			end
		elseif now - LastJumpTime < 0.22 then
			packet = JetPack.Unequip(LocalPlayer)
		end
		if packet ~= nil and (InNoFlyZone == false and Time.GetNowSync() - VehicleUtils.LastVehicleEject > 10) then
			JetPack.StartThrust(LocalPlayer)
		end
		LastJumpTime = now
	end
end
local function jumpPressed()
	OnJump()
end
local function jumpReleased()
	local localPlayer = LocalPlayer
	local packet = nil
	for i = #Packets, 1, -1 do
		local currentPacket = Packets[i]
		if currentPacket.Player == localPlayer then
			packet = currentPacket
			break
		end
	end
	if if packet == nil then false else packet.IsThrusting == true then
		JetPack.StopThrust(LocalPlayer)
	end
end
local function Stunned()
	local localPlayer = LocalPlayer
	local packet = nil
	for i = #Packets, 1, -1 do
		local currentPacket = Packets[i]
		if currentPacket.Player == localPlayer then
			packet = currentPacket
			break
		end
	end
	if packet ~= nil then
		JetPack.LocalFuel = math.max(0, JetPack.LocalFuel - 5)
		JetPack.UpdateFuel()
	end
end
return {
	Init = function(initData)
		Falling = require(ReplicatedStorage.Game.Falling)
		PlayerModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"))
		Signals.OnEquipped = Signal.new()
		JetPackGui.Init()
		Falling.OnRagdolled:Connect(function()
			JetPack.Unequip(LocalPlayer)
		end)
		local eventManager = initData.em
		Event = initData.Event
		function eventManager.OnEquipJetPack(player, fuelData)
			assert(player)
			JetPack.Equip(player, fuelData)
		end
		function eventManager.OnUnequipJetPack(player)
			assert(player)
			JetPack.Unequip(player)
		end
		function eventManager.OnStartThrust(player)
			assert(player)
			JetPack.StartThrust(player)
		end
		function eventManager.OnStopThrust(player)
			assert(player)
			JetPack.StopThrust(player)
		end
		local hasJetPack = false
		local jumpPressedConn = nil
		local jumpReleasedConn = nil
		function eventManager.OnInitializeJetPack()
			assert(hasJetPack == false)
			jumpPressedConn = DefaultActions.onJumpPressed:Connect(jumpPressed)
			jumpReleasedConn = DefaultActions.onJumpReleased:Connect(jumpReleased)
			hasJetPack = true
			JetPack.LocalFuel = JetPack.LocalMaxFuel
			JetPack.UpdateFuel()
		end
		function eventManager.OnRemoveJetPack()
			assert(hasJetPack == true)
			jumpPressedConn:Disconnect()
			jumpPressedConn = nil
			jumpReleasedConn:Disconnect()
			jumpReleasedConn = nil
			hasJetPack = false
			local localPlayer = LocalPlayer
			local packet = nil
			for i = #Packets, 1, -1 do
				local currentPacket = Packets[i]
				if currentPacket.Player == localPlayer then
					packet = currentPacket
					break
				end
			end
			if packet ~= nil then
				JetPack.LocalFuel = 0
				JetPack.UpdateFuel()
			end
		end
		function eventManager.OnTakeDamage(damage)
			JetPack.LocalFuel = math.max(JetPack.LocalFuel - damage / 10, 0)
			JetPack.UpdateFuel()
		end
		local function AddedFun(part)
			local zoneEntry = {
				Part = part,
				Region = Region.new(RegionUtils.ConditionPlayer)
			}
			zoneEntry.Region:AddPart(zoneEntry.Part)
			zoneEntry.Region.OnObjAdded:Connect(function(player)
				assert(player == LocalPlayer)
				InNoFlyZone = true
				local localPlayer = LocalPlayer
				local packet = nil
				for i = #Packets, 1, -1 do
					local currentPacket = Packets[i]
					if currentPacket.Player == localPlayer then
						packet = currentPacket
						break
					end
				end
				if if packet == nil then false else packet.IsThrusting == true == true then
					JetPack.StopThrust(LocalPlayer)
				end
			end)
			zoneEntry.Region.OnObjRemoved:Connect(function(player)
				assert(player == LocalPlayer)
				InNoFlyZone = false
			end)
			table.insert(NoFlyZones, zoneEntry)
		end
		local function RemovedFun(part)
			for i = #NoFlyZones, 1, -1 do
				local zone = NoFlyZones[i]
				if zone.Part == part then
					table.remove(NoFlyZones, i)
					zone.Region:Destroy()
					return
				end
			end
		end
		for i, taggedPart in ipairs(CollectionService:GetTagged("JetPackNoFly")) do
			AddedFun(taggedPart)
		end
		CollectionService:GetInstanceAddedSignal("JetPackNoFly"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("JetPackNoFly"):Connect(RemovedFun)
		Falling.OnRagdoll:Connect(function()
			local localPlayer = LocalPlayer
			local packet = nil
			for i = #Packets, 1, -1 do
				local currentPacket = Packets[i]
				if currentPacket.Player == localPlayer then
					packet = currentPacket
					break
				end
			end
			if packet then
				JetPack.Unequip(LocalPlayer)
			end
		end)
		Interval.every(0.2):Connect(function()
			if hasJetPack then
				local character = assert(LocalPlayer.Character)
				local Humanoid = character:FindFirstChild("Humanoid")
				assert(Humanoid)
				local RootPart = Humanoid.RootPart
				assert(RootPart)
				if RayCast.RayIgnoreNonCollide(RootPart.Position, Vector3.new(0, -1, 0), Humanoid.HipHeight + RootPart.Size.Y * 0.5 + 2, character) ~= nil and JetPack.LocalFuel < JetPack.LocalMaxFuel then
					local jetPackRef = JetPack
					jetPackRef.LocalFuel = jetPackRef.LocalFuel + 0.1
					if JetPack.LocalFuel > JetPack.LocalMaxFuel then
						JetPack.LocalFuel = JetPack.LocalMaxFuel
					end
					JetPack.UpdateFuel()
				end
			end
		end)
		VehicleUtils_2.OnVehicleEntered:Connect(function()
			local localPlayer = LocalPlayer
			local packet = nil
			for i = #Packets, 1, -1 do
				local currentPacket = Packets[i]
				if currentPacket.Player == localPlayer then
					packet = currentPacket
					break
				end
			end
			if packet then
				JetPack.Unequip(LocalPlayer)
			end
		end)
	end,
	Stunned = Stunned,
	IsFlying = IsFlying,
	IsThrusting = IsThrusting,
	Signal = Signals
}
