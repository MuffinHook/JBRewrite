local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AlexRagdoll = require(ReplicatedStorage.Module.AlexRagdoll)
local Audio = require(ReplicatedStorage.Std.Audio)
local Signal = require(ReplicatedStorage.Std.Signal)
local InventoryItemSystem = require(ReplicatedStorage.Inventory.InventoryItemSystem)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local Paraglide = require(ReplicatedStorage.Game.Paraglide)
local CharacterAnim = require(ReplicatedStorage.Game.CharacterAnim)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HapticEffect = require(ReplicatedStorage.App.HapticEffect)
local LocalPlayer = Players.LocalPlayer
local JetPack = nil
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local ControllerImage = require(ReplicatedStorage.ControllerImage)
local TagUtils = require(ReplicatedStorage.Tag.TagUtils)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local C4Consts = require(ReplicatedStorage.Game.C4.C4Consts)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
Vector3.new()
local remoteEvent = nil
local eventManager = nil
local fallingGui = nil
local function GuiUpdateInput()
	if UserInputService.GamepadEnabled then
		fallingGui.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
		fallingGui.Button.Gamepad.Visible = true
	else
		fallingGui.Button.Gamepad.Visible = false
	end
end
local function GuiPromptSkydive()
	fallingGui.Enabled = true
	fallingGui.Button.Image = ("rbxassetid://%d"):format(4915090302)
	if UserInputService.GamepadEnabled then
		fallingGui.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
		fallingGui.Button.Gamepad.Visible = true
	else
		fallingGui.Button.Gamepad.Visible = false
	end
end
local function GuiPromptParachute()
	fallingGui.Enabled = true
	fallingGui.Button.Image = ("rbxassetid://%d"):format(4915089706)
	if UserInputService.GamepadEnabled then
		fallingGui.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
		fallingGui.Button.Gamepad.Visible = true
	else
		fallingGui.Button.Gamepad.Visible = false
	end
end
local function GuiPromptNone()
	fallingGui.Enabled = false
end
local function GetHumanoid()
	local Character = LocalPlayer.Character
	if Character == nil then
		return nil
	else
		return Character:FindFirstChild("Humanoid")
	end
end
local function getRootPart()
	local Character = LocalPlayer.Character
	if Character then
		return Character.PrimaryPart
	end
end
local function getTotalMass(instance)
	assert(instance)
	local nextFunc = next
	local childrenTable, initialKey = instance:GetChildren()
	local sum = 0
	for _, child in nextFunc, childrenTable, initialKey do
		if child:IsA("BasePart") then
			sum = sum + child:GetMass()
		end
		sum = sum + getTotalMass(child)
	end
	return sum
end
local OnRagdoll = Signal.new()
local OnRagdolled = Signal.new()
local OnUnragdolled = Signal.new()
local isRagdolling = false
local ragdollTimerFired = false
local ragdollStartTime = 0
local isSkydiving = false
local isFalling = false
local function IsSkydiving()
	return isSkydiving
end
local function IsRagdolling()
	return isRagdolling
end
local skydiveTrack = nil
local skydiveForce = nil
local characterMass = nil
local ragdollDuration = 0
local fallStartY = 0
local peakFallSpeed = 0
local windSound = nil
local windFadeConnection = nil
local hapticHandle = nil
local function StartSkydiving()
	assert(isSkydiving == false)
	local Character = LocalPlayer.Character
	local humanoid = if Character == nil then nil else Character:FindFirstChild("Humanoid")
	if humanoid == nil then
		return false
	end
	isSkydiving = true
	if skydiveTrack then
		skydiveTrack:Stop()
		skydiveTrack = nil
	end
	skydiveTrack = CharacterAnim.getSkydiveTrack()
	skydiveTrack:Play(0.3)
	characterMass = getTotalMass(humanoid.Parent)
	skydiveForce = Instance.new("VectorForce")
	skydiveForce.Force = Vector3.new(0, 0, 0)
	skydiveForce.Attachment0 = CharacterUtils.getRootAttachment(humanoid.RootPart)
	skydiveForce.Parent = humanoid.RootPart
	fallingGui.Enabled = true
	fallingGui.Button.Image = ("rbxassetid://%d"):format(4915089706)
	if UserInputService.GamepadEnabled then
		fallingGui.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
		fallingGui.Button.Gamepad.Visible = true
	else
		fallingGui.Button.Gamepad.Visible = false
	end
	if windSound ~= nil then
		windSound:Stop()
		windSound:Destroy()
		windSound = nil
	end
	windSound = Audio.ObjectLocal(LocalPlayer.PlayerGui, 9058653424, {
		Volume = 0,
		Looped = true
	})
	if windFadeConnection then
		windFadeConnection:Disconnect()
		windFadeConnection = nil
	end
	windFadeConnection = Audio.FadeTo(windSound, 0.4, 4)
	if hapticHandle then
		hapticHandle:Destroy()
	end
	hapticHandle = HapticEffect.basic(0.15, (1 / 0))
end
local function StopSkydiving()
	assert(isSkydiving == true)
	isSkydiving = false
	if skydiveTrack then
		skydiveTrack:Stop()
		skydiveTrack = nil
	end
	if skydiveForce then
		skydiveForce:Destroy()
	end
	if windSound then
		local fadingSound = windSound
		windSound = nil
		if windFadeConnection then
			windFadeConnection:Disconnect()
			windFadeConnection = nil
		end
		windFadeConnection = Audio.FadeTo(fadingSound, 0, 0.1)
		task.delay(1, function()
			fadingSound:Destroy()
			fadingSound = nil
		end)
	end
	if hapticHandle then
		hapticHandle:Destroy()
		hapticHandle = nil
	end
end
local function StartRagdolling(duration)
	if isRagdolling == true then
		ragdollDuration = if duration == nil then 1.2 else duration
		ragdollStartTime = tick()
		return true
	else
		local Character = LocalPlayer.Character
		local humanoid = if Character == nil then nil else Character:FindFirstChild("Humanoid")
		if humanoid ~= nil and not (humanoid.Sit or humanoid.PlatformStand) then
			for i, v in ipairs(InventoryItemSystem.getEquippedFor(LocalPlayer)) do
				local _ = not InventoryItemSystem.toggleEquip(v)
			end
			ragdollDuration = if duration == nil then 1.2 else duration
			OnRagdoll:Fire()
			isRagdolling = true
			ragdollStartTime = tick()
			AlexRagdoll.Ragdoll(humanoid.Parent)
			OnRagdolled:Fire()
			remoteEvent:FireServer("startRagdoll")
			return true
		end
		return false
	end
end
local function StartFalling(startY)
	assert(isFalling == false)
	fallStartY = startY
	isFalling = true
end
local function StopFalling(landY)
	assert(isFalling == true)
	isFalling = false
	if isSkydiving == true then
		StopSkydiving()
	end
	fallingGui.Enabled = false
	if landY then
		local fallDistance = fallStartY - landY
		if fallDistance > 32 and isRagdolling == false then
			local Character = LocalPlayer.Character
			local rootPart = if Character then Character.PrimaryPart else nil
			if rootPart and not TagUtils.isPointInTag(rootPart.Position, "NoRagdoll") then
				StartRagdolling()
			end
		end
		if fallDistance > 24 and not RunUtils.isTradeWorld() then
			local Character = LocalPlayer.Character
			local rootPart = if Character then Character.PrimaryPart else nil
			if rootPart and not TagUtils.isPointInTag(rootPart.Position, "NoFallDamage") then
				remoteEvent:FireServer("fallDamage", fallDistance)
			end
		end
	end
	peakFallSpeed = 0
end
local function StartParachuting()
	assert(Paraglide.IsFlying() == false)
	if isFalling == true then
		StopFalling()
	end
	Paraglide.Parachute()
	fallingGui.Enabled = true
	fallingGui.Button.Image = ("rbxassetid://%d"):format(4915090302)
	if UserInputService.GamepadEnabled then
		fallingGui.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
		fallingGui.Button.Gamepad.Visible = true
	else
		fallingGui.Button.Gamepad.Visible = false
	end
end
local function StopParachuting()
	assert(Paraglide.IsFlying() == true)
	Paraglide.ParachuteStop()
end
local raycastExcludeList = {}
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
local lastPosition = nil
local lastHeartbeatTime = nil
local function Heartbeat()
	local now = tick()
	lastHeartbeatTime = now
	local Character = LocalPlayer.Character
	local humanoid = if Character == nil then nil else Character:FindFirstChild("Humanoid")
	if humanoid and (humanoid.RootPart and (humanoid.Health > 0.001 and (not humanoid.Sit and (not humanoid.PlatformStand and humanoid:GetState() ~= Enum.HumanoidStateType.Climbing)))) then
		local RootPart = humanoid.RootPart
		local rootCFrame = RootPart.CFrame
		if workspace:FindFirstChild("NetworkFixPart1") and not table.find(raycastExcludeList, workspace.NetworkFixPart1) then
			table.insert(raycastExcludeList, workspace.NetworkFixPart1)
		end
		raycastParams.FilterDescendantsInstances = raycastExcludeList
		local groundRayResult = Raycast.collidable(rootCFrame.p, Vector3.new(0, -1, 0), humanoid.HipHeight + RootPart.Size.Y * 0.5 + 2, raycastParams)
		if groundRayResult == nil then
			local shouldTrackFalling = Paraglide.IsFlying() ~= true
			if JetPack.IsFlying() == true then
				shouldTrackFalling = false
			end
			if VehicleUtils.GetLocalVehiclePacket() ~= nil then
				shouldTrackFalling = false
			end
			if shouldTrackFalling then
				if isFalling == false then
					assert(isFalling == false)
					fallStartY = rootCFrame.Y
					isFalling = true
				end
			elseif isFalling == true then
				StopFalling(rootCFrame.Y)
			end
			if isFalling == true and fallStartY < rootCFrame.Y then
				fallStartY = rootCFrame.Y
			end
		elseif isFalling == true then
			local landY = rootCFrame.Y
			if groundRayResult.Instance:IsA("Terrain") and groundRayResult.Material == Enum.Material.Water then
				landY = nil
			end
			StopFalling(landY)
		end
		local Position = RootPart.Position
		local AssemblyLinearVelocity = RootPart.AssemblyLinearVelocity
		if isFalling == true then
			local absVerticalSpeed = math.abs(AssemblyLinearVelocity.Y)
			if peakFallSpeed < absVerticalSpeed then
				peakFallSpeed = absVerticalSpeed
			end
			if absVerticalSpeed >= 50 and (fallStartY - rootCFrame.Y >= 30 and (isSkydiving == false and not TagUtils.isPointInTag(Position, "NoParachute"))) then
				StartSkydiving()
			end
			if isSkydiving == true and skydiveForce then
				local dragForce = absVerticalSpeed * 0.6 * math.abs(absVerticalSpeed)
				local maxDragForce = 196.2 * characterMass * 10
				if dragForce < 0 then
					dragForce = 0
				elseif maxDragForce < dragForce then
					dragForce = maxDragForce
				end
				if AssemblyLinearVelocity.Y > 0 then
					RootPart.AssemblyLinearVelocity = RootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
				end
				skydiveForce.Force = Vector3.new(0, dragForce, 0)
			end
		end
		lastPosition = Position
	else
		if isFalling == true then
			StopFalling()
		end
		if lastPosition ~= nil then
			lastPosition = nil
		end
	end
	if isRagdolling == true and (ragdollTimerFired == false and ragdollDuration < now - ragdollStartTime) then
		ragdollTimerFired = true
		remoteEvent:FireServer("endRagdoll")
	end
end
local function AttemptUseParachute()
	if Paraglide.IsFlying() == true then
		assert(Paraglide.IsFlying() == true)
		Paraglide.ParachuteStop()
	end
	if isSkydiving and Paraglide.IsFlying() == false then
		assert(Paraglide.IsFlying() == false)
		if isFalling == true then
			StopFalling()
		end
		Paraglide.Parachute()
		fallingGui.Enabled = true
		fallingGui.Button.Image = ("rbxassetid://%d"):format(4915090302)
		if UserInputService.GamepadEnabled then
			fallingGui.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
			fallingGui.Button.Gamepad.Visible = true
			return
		end
		fallingGui.Button.Gamepad.Visible = false
	end
end
local DefaultActions = require(ReplicatedStorage.Game.DefaultActions)
return {
	Init = function(moduleArgs)
		local em = moduleArgs.em
		remoteEvent = moduleArgs.Event
		eventManager = em
		fallingGui = ReplicatedStorage.StarterGui:FindFirstChild("FallingGui")
		fallingGui.Parent = LocalPlayer.PlayerGui
		JetPack = require(ReplicatedStorage.Game.JetPack.JetPack)
		function em.unragdollPlayer(shouldUnragdoll)
			if shouldUnragdoll then
				local Character = LocalPlayer.Character
				local humanoid = if Character == nil then nil else Character:FindFirstChild("Humanoid")
				if humanoid and humanoid.Health > 0 then
					AlexRagdoll.Unragdoll(humanoid.Parent)
					OnUnragdolled:Fire()
				end
			end
			isRagdolling = false
			ragdollTimerFired = false
		end
		DefaultActions.onJumpPressed:Connect(function()
			if Paraglide.IsFlying() == true then
				assert(Paraglide.IsFlying() == true)
				Paraglide.ParachuteStop()
			end
			if isSkydiving and Paraglide.IsFlying() == false then
				assert(Paraglide.IsFlying() == false)
				if isFalling == true then
					StopFalling()
				end
				Paraglide.Parachute()
				fallingGui.Enabled = true
				fallingGui.Button.Image = ("rbxassetid://%d"):format(4915090302)
				if UserInputService.GamepadEnabled then
					fallingGui.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
					fallingGui.Button.Gamepad.Visible = true
					return
				end
				fallingGui.Button.Gamepad.Visible = false
			end
		end)
		fallingGui.Button.MouseButton1Down:Connect(function()
			if Paraglide.IsFlying() == true then
				assert(Paraglide.IsFlying() == true)
				Paraglide.ParachuteStop()
			end
			if isSkydiving and Paraglide.IsFlying() == false then
				assert(Paraglide.IsFlying() == false)
				if isFalling == true then
					StopFalling()
				end
				Paraglide.Parachute()
				fallingGui.Enabled = true
				fallingGui.Button.Image = ("rbxassetid://%d"):format(4915090302)
				if UserInputService.GamepadEnabled then
					fallingGui.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
					fallingGui.Button.Gamepad.Visible = true
					return
				end
				fallingGui.Button.Gamepad.Visible = false
			end
		end)
		waitForChild(ReplicatedStorage, "AttemptUseParachute"):andThen(function(remoteEvt)
			remoteEvt.OnClientEvent:Connect(function(forceParachute)
				if forceParachute then
					assert(Paraglide.IsFlying() == false)
					if isFalling == true then
						StopFalling()
					end
					Paraglide.Parachute()
					fallingGui.Enabled = true
					fallingGui.Button.Image = ("rbxassetid://%d"):format(4915090302)
					if UserInputService.GamepadEnabled then
						fallingGui.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
						fallingGui.Button.Gamepad.Visible = true
					else
						fallingGui.Button.Gamepad.Visible = false
					end
				else
					if Paraglide.IsFlying() == true then
						assert(Paraglide.IsFlying() == true)
						Paraglide.ParachuteStop()
					end
					if isSkydiving and Paraglide.IsFlying() == false then
						assert(Paraglide.IsFlying() == false)
						if isFalling == true then
							StopFalling()
						end
						Paraglide.Parachute()
						fallingGui.Enabled = true
						fallingGui.Button.Image = ("rbxassetid://%d"):format(4915090302)
						if UserInputService.GamepadEnabled then
							fallingGui.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
							fallingGui.Button.Gamepad.Visible = true
							return
						end
						fallingGui.Button.Gamepad.Visible = false
					end
				end
			end)
		end)
		RunService.Heartbeat:Connect(function()
			Heartbeat()
		end)
		Paraglide.OnParachuteStopped:Connect(function()
			fallingGui.Enabled = false
		end)
		Players.LocalPlayer.CharacterAdded:Connect(function(character)
			isRagdolling = false
			table.insert(raycastExcludeList, character)
		end)
		Players.LocalPlayer.CharacterRemoving:Connect(function(character)
			local index = table.find(raycastExcludeList, character)
			if index then
				table.remove(raycastExcludeList, index)
			end
		end)
		if Players.LocalPlayer.Character then
			table.insert(raycastExcludeList, Players.LocalPlayer.Character)
		end
		CollectionService:GetInstanceAddedSignal(C4Consts.TAG_NAME):Connect(function(instance)
			table.insert(raycastExcludeList, instance)
		end)
		CollectionService:GetInstanceRemovedSignal(C4Consts.TAG_NAME):Connect(function(instance)
			local index = table.find(raycastExcludeList, instance)
			if index then
				table.remove(raycastExcludeList, index)
			end
		end)
	end,
	IsSkydiving = IsSkydiving,
	IsRagdolling = IsRagdolling,
	StopSkydiving = StopSkydiving,
	StartRagdolling = StartRagdolling,
	OnRagdoll = OnRagdoll,
	OnRagdolled = OnRagdolled,
	OnUnragdolled = OnUnragdolled
}
