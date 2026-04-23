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
local v1 = nil
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local ControllerImage = require(ReplicatedStorage.ControllerImage)
local TagUtils = require(ReplicatedStorage.Tag.TagUtils)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local C4Consts = require(ReplicatedStorage.Game.C4.C4Consts)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
Vector3.new()
local v2 = nil
local v3 = nil
local v4 = nil
local function GuiUpdateInput() --[[ Line: 34 | Upvalues: UserInputService (copy), v4 (ref), ControllerImage (copy) ]]
	if UserInputService.GamepadEnabled then
		v4.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
		v4.Button.Gamepad.Visible = true
	else
		v4.Button.Gamepad.Visible = false
	end
end
local function GuiPromptSkydive() --[[ Line: 42 | Upvalues: v4 (ref), UserInputService (copy), ControllerImage (copy) ]]
	v4.Enabled = true
	v4.Button.Image = ("rbxassetid://%d"):format(4915090302)
	if UserInputService.GamepadEnabled then
		v4.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
		v4.Button.Gamepad.Visible = true
	else
		v4.Button.Gamepad.Visible = false
	end
end
local function GuiPromptParachute() --[[ Line: 47 | Upvalues: v4 (ref), UserInputService (copy), ControllerImage (copy) ]]
	v4.Enabled = true
	v4.Button.Image = ("rbxassetid://%d"):format(4915089706)
	if UserInputService.GamepadEnabled then
		v4.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
		v4.Button.Gamepad.Visible = true
	else
		v4.Button.Gamepad.Visible = false
	end
end
local function GuiPromptNone() --[[ Line: 52 | Upvalues: v4 (ref) ]]
	v4.Enabled = false
end
local function GetHumanoid() --[[ Line: 56 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character
	if Character == nil then
		return nil
	else
		return Character:FindFirstChild("Humanoid")
	end
end
local function getRootPart() --[[ Line: 64 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character
	if Character then
		return Character.PrimaryPart
	end
end
local function v5(p1) --[[ Line: 78 | Upvalues: v5 (copy) ]]
	assert(p1)
	local v1 = next
	local v2, v3 = p1:GetChildren()
	local sum = 0
	for v4, v52 in v1, v2, v3 do
		if v52:IsA("BasePart") then
			sum = sum + v52:GetMass()
		end
		sum = sum + v5(v52)
	end
	return sum
end
local v6 = Signal.new()
local v7 = Signal.new()
local v8 = Signal.new()
local v9 = false
local v10 = false
local v11 = 0
local v12 = false
local v13 = false
local function IsSkydiving() --[[ Line: 106 | Upvalues: v12 (ref) ]]
	return v12
end
local function IsRagdolling() --[[ Line: 109 | Upvalues: v9 (ref) ]]
	return v9
end
local v14 = nil
local v15 = nil
local v16 = nil
local v17 = 0
local v18 = 0
local v19 = 0
local v20 = nil
local v21 = nil
local v22 = nil
local function StartSkydiving() --[[ Line: 124 | Upvalues: v12 (ref), LocalPlayer (copy), v14 (ref), CharacterAnim (copy), v16 (ref), v5 (copy), v15 (ref), CharacterUtils (copy), v4 (ref), UserInputService (copy), ControllerImage (copy), v20 (ref), Audio (copy), v21 (ref), v22 (ref), HapticEffect (copy) ]]
	assert(v12 == false)
	local Character = LocalPlayer.Character
	local v2 = if Character == nil then nil else Character:FindFirstChild("Humanoid")
	if v2 == nil then
		return false
	end
	v12 = true
	if v14 then
		v14:Stop()
		v14 = nil
	end
	v14 = CharacterAnim.getSkydiveTrack()
	v14:Play(0.3)
	v16 = v5(v2.Parent)
	v15 = Instance.new("VectorForce")
	v15.Force = Vector3.new(0, 0, 0)
	v15.Attachment0 = CharacterUtils.getRootAttachment(v2.RootPart)
	v15.Parent = v2.RootPart
	v4.Enabled = true
	v4.Button.Image = ("rbxassetid://%d"):format(4915089706)
	if UserInputService.GamepadEnabled then
		v4.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
		v4.Button.Gamepad.Visible = true
	else
		v4.Button.Gamepad.Visible = false
	end
	if v20 ~= nil then
		v20:Stop()
		v20:Destroy()
		v20 = nil
	end
	v20 = Audio.ObjectLocal(LocalPlayer.PlayerGui, 9058653424, {
		Volume = 0,
		Looped = true
	})
	if v21 then
		v21:Disconnect()
		v21 = nil
	end
	v21 = Audio.FadeTo(v20, 0.4, 4)
	if v22 then
		v22:Destroy()
	end
	v22 = HapticEffect.basic(0.15, (1 / 0))
end
local function StopSkydiving() --[[ Line: 163 | Upvalues: v12 (ref), v14 (ref), v15 (ref), v20 (ref), v21 (ref), Audio (copy), v22 (ref) ]]
	assert(v12 == true)
	v12 = false
	if v14 then
		v14:Stop()
		v14 = nil
	end
	if v15 then
		v15:Destroy()
	end
	if v20 then
		local v2 = v20
		v20 = nil
		if v21 then
			v21:Disconnect()
			v21 = nil
		end
		v21 = Audio.FadeTo(v2, 0, 0.1)
		delay(1, function() --[[ Line: 183 | Upvalues: v2 (ref) ]]
			v2:Destroy()
			v2 = nil
		end)
	end
	if v22 then
		v22:Destroy()
		v22 = nil
	end
end
local function StartRagdolling(p1) --[[ Line: 193 | Upvalues: v9 (ref), v17 (ref), v11 (ref), LocalPlayer (copy), InventoryItemSystem (copy), v6 (copy), AlexRagdoll (copy), v7 (copy), v2 (ref) ]]
	if v9 == true then
		v17 = if p1 == nil then 1.2 else p1
		v11 = tick()
		return true
	else
		local Character = LocalPlayer.Character
		local v1 = if Character == nil then nil else Character:FindFirstChild("Humanoid")
		if v1 ~= nil and not (v1.Sit or v1.PlatformStand) then
			for i, v in ipairs(InventoryItemSystem.getEquippedFor(LocalPlayer)) do
				local _ = not InventoryItemSystem.toggleEquip(v)
			end
			v17 = if p1 == nil then 1.2 else p1
			v6:Fire()
			v9 = true
			v11 = tick()
			AlexRagdoll.Ragdoll(v1.Parent)
			v7:Fire()
			v2:FireServer("l" .. ("as81bo"):sub(5, 5):reverse():reverse():reverse() .. "wt9cvb")
			return true
		end
		return false
	end
end
local function StartFalling(p1) --[[ Line: 233 | Upvalues: v13 (ref), v18 (ref) ]]
	assert(v13 == false)
	v18 = p1
	v13 = true
end
local function StopFalling(p1) --[[ Line: 238 | Upvalues: v13 (ref), v12 (ref), StopSkydiving (copy), v4 (ref), v18 (ref), v9 (ref), LocalPlayer (copy), TagUtils (copy), StartRagdolling (copy), RunUtils (copy), v2 (ref), v19 (ref) ]]
	assert(v13 == true)
	v13 = false
	if v12 == true then
		StopSkydiving()
	end
	v4.Enabled = false
	if p1 then
		local v22 = v18 - p1
		if v22 > 32 and v9 == false then
			local Character = LocalPlayer.Character
			local v3 = if Character then Character.PrimaryPart else nil
			if v3 and not TagUtils.isPointInTag(v3.Position, "NoRagdoll") then
				StartRagdolling()
			end
		end
		if v22 > 24 and not RunUtils.isTradeWorld() then
			local Character = LocalPlayer.Character
			local v42 = if Character then Character.PrimaryPart else nil
			if v42 and not TagUtils.isPointInTag(v42.Position, "NoFallDamage") then
				v2:FireServer("u" .. ("tv52x"):sub(4, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("q36iwcx"):sub(2, 5):reverse() .. "hk", v22)
			end
		end
	end
	v19 = 0
end
local function StartParachuting() --[[ Line: 270 | Upvalues: Paraglide (copy), v13 (ref), StopFalling (copy), v4 (ref), UserInputService (copy), ControllerImage (copy) ]]
	assert(Paraglide.IsFlying() == false)
	if v13 == true then
		StopFalling()
	end
	Paraglide.Parachute()
	v4.Enabled = true
	v4.Button.Image = ("rbxassetid://%d"):format(4915090302)
	if UserInputService.GamepadEnabled then
		v4.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
		v4.Button.Gamepad.Visible = true
	else
		v4.Button.Gamepad.Visible = false
	end
end
local function StopParachuting() --[[ Line: 279 | Upvalues: Paraglide (copy) ]]
	assert(Paraglide.IsFlying() == true)
	Paraglide.ParachuteStop()
end
local t = {}
local v23 = RaycastParams.new()
v23.FilterType = Enum.RaycastFilterType.Exclude
local v24 = nil
local v25 = nil
local function Heartbeat() --[[ Line: 291 | Upvalues: v25 (ref), LocalPlayer (copy), t (copy), v23 (copy), Raycast (copy), Paraglide (copy), v1 (ref), VehicleUtils (copy), v13 (ref), v18 (ref), StopFalling (copy), v19 (ref), v12 (ref), TagUtils (copy), StartSkydiving (copy), v15 (ref), v16 (ref), v24 (ref), v9 (ref), v10 (ref), v11 (ref), v17 (ref), v2 (ref) ]]
	local v14 = tick()
	v25 = v14
	local Character = LocalPlayer.Character
	local v22 = if Character == nil then nil else Character:FindFirstChild("Humanoid")
	if v22 and (v22.RootPart and (v22.Health > 0.001 and (not v22.Sit and (not v22.PlatformStand and v22:GetState() ~= Enum.HumanoidStateType.Climbing)))) then
		local RootPart = v22.RootPart
		local v3 = RootPart.CFrame
		if workspace:FindFirstChild("NetworkFixPart1") and not table.find(t, workspace.NetworkFixPart1) then
			table.insert(t, workspace.NetworkFixPart1)
		end
		v23.FilterDescendantsInstances = t
		local v6 = Raycast.collidable(v3.p, Vector3.new(0, -1, 0), v22.HipHeight + RootPart.Size.Y * 0.5 + 2, v23)
		if v6 == nil then
			local v7 = Paraglide.IsFlying() ~= true
			if v1.IsFlying() == true then
				v7 = false
			end
			if VehicleUtils.GetLocalVehiclePacket() ~= nil then
				v7 = false
			end
			if v7 then
				if v13 == false then
					assert(v13 == false)
					v18 = v3.Y
					v13 = true
				end
			elseif v13 == true then
				StopFalling(v3.Y)
			end
			if v13 == true and v18 < v3.Y then
				v18 = v3.Y
			end
		elseif v13 == true then
			local Y = v3.Y
			if v6.Instance:IsA("Terrain") and v6.Material == Enum.Material.Water then
				Y = nil
			end
			StopFalling(Y)
		end
		local Position = RootPart.Position
		local AssemblyLinearVelocity = RootPart.AssemblyLinearVelocity
		if v13 == true then
			local v92 = math.abs(AssemblyLinearVelocity.Y)
			if v19 < v92 then
				v19 = v92
			end
			if v92 >= 50 and (v18 - v3.Y >= 30 and (v12 == false and not TagUtils.isPointInTag(Position, "NoParachute"))) then
				StartSkydiving()
			end
			if v12 == true and v15 then
				local v102 = v92 * 0.6 * math.abs(v92)
				local v112 = 196.20000000000002 * v16 * 10
				if v102 < 0 then
					v102 = 0
				elseif v112 < v102 then
					v102 = v112
				end
				if AssemblyLinearVelocity.Y > 0 then
					RootPart.AssemblyLinearVelocity = RootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
				end
				v15.Force = Vector3.new(0, v102, 0)
			end
		end
		v24 = Position
	else
		if v13 == true then
			StopFalling()
		end
		if v24 ~= nil then
			v24 = nil
		end
	end
	if v9 == true and (v10 == false and v17 < v14 - v11) then
		v10 = true
		v2:FireServer("s" .. "" .. ("ygnwz1j"):sub(4, 4):reverse():reverse():reverse() .. "" .. "" .. ("s1rmwu"):sub(2, 5):reverse() .. "" .. "" .. ("wm21tsffq"):sub(5, 5):reverse() .. "z")
	end
end
local function AttemptUseParachute() --[[ Line: 417 | Upvalues: Paraglide (copy), v12 (ref), v13 (ref), StopFalling (copy), v4 (ref), UserInputService (copy), ControllerImage (copy) ]]
	if Paraglide.IsFlying() == true then
		assert(Paraglide.IsFlying() == true)
		Paraglide.ParachuteStop()
	end
	if v12 and Paraglide.IsFlying() == false then
		assert(Paraglide.IsFlying() == false)
		if v13 == true then
			StopFalling()
		end
		Paraglide.Parachute()
		v4.Enabled = true
		v4.Button.Image = ("rbxassetid://%d"):format(4915090302)
		if UserInputService.GamepadEnabled then
			v4.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
			v4.Button.Gamepad.Visible = true
			return
		end
		v4.Button.Gamepad.Visible = false
	end
end
local DefaultActions = require(ReplicatedStorage.Game.DefaultActions)
return {
	Init = function(p1) --[[ Name: Init | Line: 428 | Upvalues: v2 (ref), v3 (ref), v4 (ref), ReplicatedStorage (copy), LocalPlayer (copy), v1 (ref), AlexRagdoll (copy), v8 (copy), v9 (ref), v10 (ref), DefaultActions (copy), Paraglide (copy), v12 (ref), v13 (ref), StopFalling (copy), UserInputService (copy), ControllerImage (copy), waitForChild (copy), RunService (copy), Heartbeat (copy), Players (copy), t (copy), CollectionService (copy), C4Consts (copy) ]]
		local em = p1.em
		v2 = p1.Event
		v3 = em
		v4 = ReplicatedStorage.StarterGui:FindFirstChild("FallingGui")
		v4.Parent = LocalPlayer.PlayerGui
		v1 = require(ReplicatedStorage.Game.JetPack.JetPack)
		function em.swwmr1tz(p1) --[[ Line: 436 | Upvalues: LocalPlayer (ref), AlexRagdoll (ref), v8 (ref), v9 (ref), v10 (ref) ]]
			if p1 then
				local Character = LocalPlayer.Character
				local v1 = if Character == nil then nil else Character:FindFirstChild("Humanoid")
				if v1 and v1.Health > 0 then
					AlexRagdoll.Unragdoll(v1.Parent)
					v8:Fire()
				end
			end
			v9 = false
			v10 = false
		end
		DefaultActions.onJumpPressed:Connect(function() --[[ Line: 449 | Upvalues: Paraglide (ref), v12 (ref), v13 (ref), StopFalling (ref), v4 (ref), UserInputService (ref), ControllerImage (ref) ]]
			if Paraglide.IsFlying() == true then
				assert(Paraglide.IsFlying() == true)
				Paraglide.ParachuteStop()
			end
			if v12 and Paraglide.IsFlying() == false then
				assert(Paraglide.IsFlying() == false)
				if v13 == true then
					StopFalling()
				end
				Paraglide.Parachute()
				v4.Enabled = true
				v4.Button.Image = ("rbxassetid://%d"):format(4915090302)
				if UserInputService.GamepadEnabled then
					v4.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
					v4.Button.Gamepad.Visible = true
					return
				end
				v4.Button.Gamepad.Visible = false
			end
		end)
		v4.Button.MouseButton1Down:Connect(function() --[[ Line: 452 | Upvalues: Paraglide (ref), v12 (ref), v13 (ref), StopFalling (ref), v4 (ref), UserInputService (ref), ControllerImage (ref) ]]
			if Paraglide.IsFlying() == true then
				assert(Paraglide.IsFlying() == true)
				Paraglide.ParachuteStop()
			end
			if v12 and Paraglide.IsFlying() == false then
				assert(Paraglide.IsFlying() == false)
				if v13 == true then
					StopFalling()
				end
				Paraglide.Parachute()
				v4.Enabled = true
				v4.Button.Image = ("rbxassetid://%d"):format(4915090302)
				if UserInputService.GamepadEnabled then
					v4.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
					v4.Button.Gamepad.Visible = true
					return
				end
				v4.Button.Gamepad.Visible = false
			end
		end)
		waitForChild(ReplicatedStorage, "AttemptUseParachute"):andThen(function(p1) --[[ Line: 455 | Upvalues: Paraglide (ref), v13 (ref), StopFalling (ref), v4 (ref), UserInputService (ref), ControllerImage (ref), v12 (ref) ]]
			p1.OnClientEvent:Connect(function(p1) --[[ Line: 456 | Upvalues: Paraglide (ref), v13 (ref), StopFalling (ref), v4 (ref), UserInputService (ref), ControllerImage (ref), v12 (ref) ]]
				if p1 then
					assert(Paraglide.IsFlying() == false)
					if v13 == true then
						StopFalling()
					end
					Paraglide.Parachute()
					v4.Enabled = true
					v4.Button.Image = ("rbxassetid://%d"):format(4915090302)
					if UserInputService.GamepadEnabled then
						v4.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
						v4.Button.Gamepad.Visible = true
					else
						v4.Button.Gamepad.Visible = false
					end
				else
					if Paraglide.IsFlying() == true then
						assert(Paraglide.IsFlying() == true)
						Paraglide.ParachuteStop()
					end
					if v12 and Paraglide.IsFlying() == false then
						assert(Paraglide.IsFlying() == false)
						if v13 == true then
							StopFalling()
						end
						Paraglide.Parachute()
						v4.Enabled = true
						v4.Button.Image = ("rbxassetid://%d"):format(4915090302)
						if UserInputService.GamepadEnabled then
							v4.Button.Gamepad.Image = ControllerImage.getImageIdForKeyCode(Enum.KeyCode.ButtonA)
							v4.Button.Gamepad.Visible = true
							return
						end
						v4.Button.Gamepad.Visible = false
					end
				end
			end)
		end)
		RunService.Heartbeat:Connect(function() --[[ Line: 465 | Upvalues: Heartbeat (ref) ]]
			Heartbeat()
		end)
		Paraglide.OnParachuteStopped:Connect(function() --[[ Line: 469 | Upvalues: v4 (ref) ]]
			v4.Enabled = false
		end)
		Players.LocalPlayer.CharacterAdded:Connect(function(p1) --[[ Line: 473 | Upvalues: v9 (ref), t (ref) ]]
			v9 = false
			table.insert(t, p1)
		end)
		Players.LocalPlayer.CharacterRemoving:Connect(function(p1) --[[ Line: 477 | Upvalues: t (ref) ]]
			local v1 = table.find(t, p1)
			if v1 then
				table.remove(t, v1)
			end
		end)
		if Players.LocalPlayer.Character then
			table.insert(t, Players.LocalPlayer.Character)
		end
		CollectionService:GetInstanceAddedSignal(C4Consts.TAG_NAME):Connect(function(p1) --[[ Line: 487 | Upvalues: t (ref) ]]
			table.insert(t, p1)
		end)
		CollectionService:GetInstanceRemovedSignal(C4Consts.TAG_NAME):Connect(function(p1) --[[ Line: 490 | Upvalues: t (ref) ]]
			local v1 = table.find(t, p1)
			if v1 then
				table.remove(t, v1)
			end
		end)
	end,
	IsSkydiving = IsSkydiving,
	IsRagdolling = IsRagdolling,
	StopSkydiving = StopSkydiving,
	StartRagdolling = StartRagdolling,
	OnRagdoll = v6,
	OnRagdolled = v7,
	OnUnragdolled = v8
}