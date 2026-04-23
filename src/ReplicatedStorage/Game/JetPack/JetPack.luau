local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local v1 = nil
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
local v2 = nil
local v3 = nil
local function SetHumanoidEnabled(p1, p2) --[[ Line: 44 ]]
	local v1 = next
	local v2, v3 = Enum.HumanoidStateType:GetEnumItems()
	for v4, v5 in v1, v2, v3 do
		if v5 ~= Enum.HumanoidStateType.Dead and (v5 ~= Enum.HumanoidStateType.None and v5 ~= Enum.HumanoidStateType.Jumping) then
			p1:SetStateEnabled(v5, p2)
		end
	end
end
local t = {}
local v4 = false
local t2 = {
	OnEquipped = nil
}
local abs = math.abs
local t3 = {
	LocalMaxFuel = 15,
	LocalFuel = 15,
	LocalFuelType = "Standard"
}
local t4 = {}
local v5 = nil
local v6 = nil
local v7 = false
local function StopThreads() --[[ Line: 77 | Upvalues: v7 (ref), v5 (ref), v6 (ref) ]]
	assert(v7 == true)
	v5:Disconnect()
	v5 = nil
	v6:Disconnect()
	v6 = nil
	v7 = false
end
local function CheckThreads() --[[ Line: 85 | Upvalues: v7 (ref), t4 (copy), v5 (ref), v6 (ref) ]]
	if v7 == false then
		return true
	elseif #t4 == 0 then
		assert(v7 == true)
		v5:Disconnect()
		v5 = nil
		v6:Disconnect()
		v6 = nil
		v7 = false
		return true
	else
		return false
	end
end
local function Stepped(p1, p2) --[[ Line: 96 | Upvalues: v7 (ref), t4 (copy), v5 (ref), v6 (ref), t3 (copy) ]]
	local v1
	if v7 == false then
		v1 = true
	elseif #t4 == 0 then
		assert(v7 == true)
		v5:Disconnect()
		v5 = nil
		v6:Disconnect()
		v6 = nil
		v7 = false
		v1 = true
	else
		v1 = false
	end
	if v1 then
		return false
	end
	for i = #t4, 1, -1 do
		t3.Stepped(t4[i], p2)
	end
end
local function Heartbeat(p1) --[[ Line: 104 | Upvalues: v7 (ref), t4 (copy), v5 (ref), v6 (ref), t3 (copy) ]]
	local v1
	if v7 == false then
		v1 = true
	elseif #t4 == 0 then
		assert(v7 == true)
		v5:Disconnect()
		v5 = nil
		v6:Disconnect()
		v6 = nil
		v7 = false
		v1 = true
	else
		v1 = false
	end
	if v1 then
		return false
	end
	for i = #t4, 1, -1 do
		t3.Heartbeat(t4[i], p1)
	end
end
local function StartThreads() --[[ Line: 112 | Upvalues: v7 (ref), v6 (ref), RunService (copy), Stepped (copy), v5 (ref), Heartbeat (copy) ]]
	assert(v7 == false)
	v7 = true
	v6 = RunService.Stepped:Connect(Stepped)
	v5 = RunService.Heartbeat:Connect(Heartbeat)
end
local function AddPacket(p1) --[[ Line: 119 | Upvalues: t4 (copy), v7 (ref), v6 (ref), RunService (copy), Stepped (copy), v5 (ref), Heartbeat (copy) ]]
	table.insert(t4, p1)
	if #t4 == 1 then
		assert(v7 == false)
		v7 = true
		v6 = RunService.Stepped:Connect(Stepped)
		v5 = RunService.Heartbeat:Connect(Heartbeat)
	end
end
local function GetPacketByPlayer(p1) --[[ Line: 125 | Upvalues: t4 (copy) ]]
	for i = #t4, 1, -1 do
		local v1 = t4[i]
		if v1.Player == p1 then
			return v1, i
		end
	end
	return nil
end
function t3.Equip(p1, p2) --[[ Line: 134 | Upvalues: Paraglide (copy), Audio (copy), LocalPlayer (copy), t3 (copy), JetPackUtil (copy), t4 (copy), v7 (ref), v6 (ref), RunService (copy), Stepped (copy), v5 (ref), Heartbeat (copy), v3 (ref) ]]
	if Paraglide.IsFlying() == true then
		Paraglide.ParachuteStop()
	end
	assert(p1, "Player is nil")
	local Character = p1.Character
	assert(Character, "Character is nil")
	local Humanoid = Character:FindFirstChild("Humanoid")
	if Humanoid then
		if Humanoid.Health <= 0 then
			return nil
		else
			local RootPart = Humanoid.RootPart
			if RootPart then
				local t = {
					Player = p1,
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
				if p1 == LocalPlayer then
					t3.EquipLocal(t)
				else
					assert(p2)
					local Model = t.Model
					assert(JetPackUtil.Fuel[p2])
				end
				table.insert(t4, t)
				if #t4 == 1 then
					assert(v7 == false)
					v7 = true
					v6 = RunService.Stepped:Connect(Stepped)
					v5 = RunService.Heartbeat:Connect(Heartbeat)
				end
				if p1 == LocalPlayer then
					v3:FireServer("e" .. ("sf63ffuh6"):sub(5, 6):reverse():reverse():reverse() .. "" .. "" .. ("ccrw"):sub(2, 3):reverse():reverse():reverse():reverse():reverse() .. "lru")
				end
				return t
			else
				return nil
			end
		end
	else
		return nil
	end
end
function t3.UpdateFuel() --[[ Line: 182 | Upvalues: JetPackGui (copy), t3 (copy), LocalPlayer (copy) ]]
	JetPackGui.UpdateFuel(t3.LocalFuel, t3.LocalMaxFuel)
	for v1, v2 in LocalPlayer.Character:GetChildren() do
		if v2:IsA("Model") and v2:GetAttribute("IsJetPack") == true then
			local FuelBar = v2:FindFirstChild("FuelBar")
			local v3 = #FuelBar:GetChildren()
			local v5 = math.ceil(v3 * t3.LocalFuel / t3.LocalMaxFuel - 0.001)
			for i = 1, v3 do
				if i <= v5 then
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
function t3.EquipLocal(p1) --[[ Line: 201 | Upvalues: SetHumanoidEnabled (copy), Players (copy), t4 (copy), Spring (copy), ReplicatedStorage (copy), JetPackUtil (copy), t3 (copy), t2 (copy) ]]
	local Humanoid = p1.Humanoid
	local Animator = Humanoid:FindFirstChildOfClass("Animator")
	SetHumanoidEnabled(Humanoid, false)
	Humanoid:ChangeState(Enum.HumanoidStateType.Flying)
	task.delay(0.1, function() --[[ Line: 209 | Upvalues: Players (ref), t4 (ref), Animator (copy) ]]
		local LocalPlayer = Players.LocalPlayer
		local v1 = nil
		for i = #t4, 1, -1 do
			local v2 = t4[i]
			if v2.Player == LocalPlayer then
				v1 = v2
				break
			end
		end
		if v1 then
			for v3, v4 in Animator:GetPlayingAnimationTracks() do
				v4:Stop(0.1)
			end
		end
	end)
	local RootPart = p1.RootPart
	p1.MovingSpring = Spring.new(0, 0, 0.8, 10)
	local BodyVelocity = Instance.new("BodyVelocity")
	BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
	BodyVelocity.Velocity = RootPart.Velocity
	BodyVelocity.Parent = RootPart
	p1.BodyVelocity = BodyVelocity
	local BodyGyro = Instance.new("BodyGyro")
	BodyGyro.MaxTorque = Vector3.new(1000000, 1000000, 1000000)
	BodyGyro.D = 100
	BodyGyro.P = 500
	BodyGyro.Parent = RootPart
	p1.BodyGyro = BodyGyro
	local v1 = ReplicatedStorage.Resource.JetPack.GroundSmoke:Clone()
	v1.Parent = workspace
	p1.GroundSmokeLeft = v1
	local v2 = ReplicatedStorage.Resource.JetPack.GroundSmoke:Clone()
	v2.Parent = workspace
	p1.GroundSmokeRight = v2
	p1.GroundSmokeLastEmit = tick()
	p1.ConnAnimationPlayed = Humanoid.AnimationPlayed:Connect(function(p1) --[[ Line: 249 ]]
		p1:Stop()
	end)
	local v3 = JetPackUtil.Fuel[t3.LocalFuelType]
	assert(v3)
	p1.LeanAngle = v3.LeanAngle
	assert(t3.LocalFuel)
	assert(t3.LocalMaxFuel)
	t3.UpdateFuel()
	t2.OnEquipped:Fire()
end
function t3.Unequip(p1) --[[ Line: 264 | Upvalues: t4 (copy), t3 (copy), LocalPlayer (copy), v3 (ref) ]]
	local v1 = nil
	local v2 = nil
	for i = #t4, 1, -1 do
		local v32 = t4[i]
		if v32.Player == p1 then
			v1 = v32
			v2 = i
			break
		end
	end
	if v1 then
		assert(v1)
		if v1.IsThrusting then
			t3.StopThrust(p1)
		end
		table.remove(t4, v2)
		v1.SoundThrust:Destroy()
		v1.SoundThrust = nil
		t3.SetThrustVisual(v1, 0)
		if p1 == LocalPlayer then
			t3.UnequipLocal(v1)
		end
		if p1 == LocalPlayer then
			v3:FireServer("a" .. ("acbuq"):sub(3, 3):reverse():reverse():reverse():reverse():reverse() .. "3zo4do")
		end
	end
	return nil
end
function t3.UnequipLocal(p1) --[[ Line: 288 | Upvalues: VehicleUtils (copy), SetHumanoidEnabled (copy) ]]
	local Humanoid = p1.Humanoid
	local v1 = VehicleUtils.GetLocalVehiclePacket()
	if not v1 or v1.Make ~= "Volt" then
		SetHumanoidEnabled(Humanoid, true)
	end
	Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	p1.BodyGyro:Destroy()
	p1.BodyGyro = nil
	p1.BodyVelocity:Destroy()
	p1.BodyVelocity = nil
	p1.ConnAnimationPlayed:Disconnect()
	p1.ConnAnimationPlayed = nil
end
function t3.UpdateJoints(p1, p2) --[[ Line: 305 | Upvalues: t3 (copy) ]]
	local Character = p1.Character
	if not Character:IsDescendantOf(workspace) then
		t3.Unequip(p1.Player)
	end
	local Neck = Character.Head:FindFirstChild("Neck")
	if not Neck then
		t3.Unequip(p1.Player)
		return false
	end
	local v1, _, _2 = p1.RootPart.CFrame:ToOrientation()
	Neck.Transform = CFrame.Angles(-v1 * 0.7, 0, 0)
	Character.RightLowerArm.RightElbow.Transform = CFrame.Angles(1.2566370614359172, 0, -0.37699111843077515)
	Character.LeftLowerArm.LeftElbow.Transform = CFrame.Angles(1.2566370614359172, 0, 0.37699111843077515)
	Character.RightUpperArm.RightShoulder.Transform = CFrame.Angles(0.3141592653589793, 0, 0)
	Character.LeftUpperArm.LeftShoulder.Transform = CFrame.Angles(0.3141592653589793, 0, 0)
	Character.RightUpperLeg.RightHip.Transform = CFrame.Angles(math.pi * p2 * 0.15, 0, 0.05 + p2 * 0.1)
	Character.LeftUpperLeg.LeftHip.Transform = CFrame.Angles(math.pi * p2 * 0.15, 0, -0.05 + p2 * -0.1)
	Character.RightLowerLeg.RightKnee.Transform = CFrame.Angles(math.pi * p2 * -0.3, 0, 0)
	Character.LeftLowerLeg.LeftKnee.Transform = CFrame.Angles(math.pi * p2 * -0.3, 0, 0)
end
function t3.Stepped(p1, p2) --[[ Line: 341 | Upvalues: t3 (copy), LocalPlayer (copy) ]]
	local Humanoid = p1.Humanoid
	if Humanoid.Health <= 0 then
		t3.Unequip(p1.Player)
	elseif Humanoid:IsDescendantOf(workspace) then
		if p1.Player == LocalPlayer then
			t3.SteppedLocal(p1, p2)
		else
			t3.UpdateJoints(p1, (math.clamp(p1.RootPart.Velocity.Magnitude / 20, 0, 1)))
		end
	else
		t3.Unequip(p1.Player)
	end
end
function t3.SteppedLocal(p1, p2) --[[ Line: 361 | Upvalues: t3 (copy), t (copy), LocalPlayer (copy) ]]
	t3.UpdateJoints(p1, p1.MovingSpring:Update() * 0.5 + 0.5)
	for i, v in ipairs(t) do
		v.Region:Update({ LocalPlayer })
	end
end
function t3.Heartbeat(p1, p2) --[[ Line: 370 | Upvalues: t3 (copy), LocalPlayer (copy) ]]
	local Humanoid = p1.Humanoid
	if Humanoid.Health <= 0 then
		t3.Unequip(p1.Player)
	elseif Humanoid:IsDescendantOf(workspace) then
		p1.SoundThrust.Volume = p1.SoundThrust.Volume + (p1.SoundThrustVolumeTarget - p1.SoundThrust.Volume) * 0.1
		if p1.Player == LocalPlayer then
			t3.HeartbeatLocal(p1, p2)
		end
	else
		t3.Unequip(p1.Player)
	end
end
local v8 = AccelTween.new(80)
function t3.HeartbeatLocal(p1, p2) --[[ Line: 389 | Upvalues: v1 (ref), CurrentCamera (copy), v8 (copy), abs (copy), RayCast (copy), LocalPlayer (copy), t3 (copy), VehicleUtils (copy) ]]
	local v12 = tick()
	local v2 = v1:GetControls():GetMoveVector()
	local _, _2, _3, _4, v3, v4, _5, v5, v6, _6, v7, v82 = CurrentCamera.CFrame:GetComponents()
	local v9 = CFrame.new(0, 0, 0, -v7 * v6 + v5 * v82, 0, v4, v7 * v4 - v3 * v82, 1, v6, -v5 * v4 + v3 * v6, 0, v82)
	local Humanoid = p1.Humanoid
	local RootPart = Humanoid.RootPart
	local v10 = v2.Magnitude > 0.001
	if v10 then
		p1.LastCF = v9 * CFrame.new(Vector3.new(), v2)
	end
	p1.MovingSpring:SetTarget(if v10 and p1.IsThrusting then 1 else 0)
	local BodyGyro = p1.BodyGyro
	if p1.LastCF then
		local Position = RootPart.Position
		local v13 = p1.LastCF * CFrame.Angles(v10 and p1.IsThrusting and p1.LeanAngle or 0, 0, 0)
		BodyGyro.CFrame = v13 + Vector3.new(Position.x, Position.y, Position.z)
	end
	local Velocity = RootPart.Velocity
	local v14 = 1
	local v15
	if p1.IsThrusting then
		if os.clock() - p1.ThrustingBornAt > 1 then
			v15 = 450
		else
			v15 = 200
			v14 = v14 * 3
		end
	else
		v15 = 100
	end
	if v8.t ~= v15 then
		if v8.t < 200 or v15 < v8.t then
			v8.pt = v15
		else
			v8.t = v15
		end
	end
	p1.BodyVelocity.Velocity = Velocity + (Vector3.new(0, -2746.8, 0) + Vector3.new(v14 * -4 * 0.5 * Velocity.x * abs(Velocity.x), -6 * Velocity.y * abs(Velocity.y), v14 * -4 * 0.5 * Velocity.z * abs(Velocity.z)) + RootPart.CFrame.UpVector * (14 * v8.p)) / 14 * p2
	local v19, v20 = RayCast.RayIgnoreNonCollide(RootPart.Position, Vector3.new(0, -1, 0), 20, LocalPlayer.Character)
	if v19 ~= nil and (p1.IsThrusting and (v12 - p1.GroundSmokeLastEmit > 0.05 and p1.LastCF)) then
		p1.GroundSmokeRight.CFrame = CFrame.new(v20.x, v20.y + 1, v20.z) + p1.LastCF * Vector3.new(2, 0, 0)
		p1.GroundSmokeRight.LandingSmoke:Emit(1)
		p1.GroundSmokeLeft.CFrame = CFrame.new(v20.x, v20.y + 1, v20.z) + p1.LastCF * Vector3.new(-2, 0, 0)
		p1.GroundSmokeLeft.LandingSmoke:Emit(1)
		p1.GroundSmokeLastEmit = v12
	end
	if v12 - p1.EquippedAt > 0.1 and not p1.IsThrusting then
		local v21, _7 = RayCast.RayIgnoreNonCollide(RootPart.Position, Vector3.new(0, -1, 0), Humanoid.HipHeight + RootPart.Size.Y * 0.5 + 0.5, LocalPlayer.Character)
		if v21 then
			t3.Unequip(LocalPlayer)
		end
	end
	t3.LocalFuel = t3.LocalFuel - p2 * if p1.IsThrusting then 1 else 0.3333333333333333
	if t3.LocalFuel < 0 then
		t3.LocalFuel = 0
		t3.Unequip(p1.Player)
	end
	t3.UpdateFuel()
	if VehicleUtils.GetLocalVehiclePacket() ~= nil then
		t3.Unequip(p1.Player)
	end
end
function t3.SetThrustVisual(p1, p2) --[[ Line: 486 ]]
	local v1 = p2 > 0.001
	local v2 = p2 > 0.5
	local Model = p1.Model
	if Model and Model.Parent then
		for v3, v4 in Model.Body:GetDescendants() do
			if v4:IsA("ParticleEmitter") then
				if v4.Name == "Flamethrower" then
					v4.Enabled = v2
				else
					v4.Enabled = v1
				end
			end
		end
	end
end
function t3.StartThrust(p1) --[[ Line: 502 | Upvalues: t4 (copy), RayCast (copy), t3 (copy), LocalPlayer (copy), v3 (ref) ]]
	assert(p1)
	local v1 = nil
	for i = #t4, 1, -1 do
		local v2 = t4[i]
		if v2.Player == p1 then
			v1 = v2
			break
		end
	end
	if v1 then
		assert(v1.IsThrusting == false)
		v1.IsThrusting = true
		v1.ThrustingBornAt = os.clock()
		local Humanoid = v1.Humanoid
		local RootPart = Humanoid.RootPart
		if not RayCast.RayIgnoreNonCollide(RootPart.Position, Vector3.new(0, -1, 0), Humanoid.HipHeight + RootPart.Size.Y * 0.5 + 16, Humanoid.Parent) then
			v1.ThrustingBornAt = v1.ThrustingBornAt - 2
		end
		v1.SoundThrustVolumeTarget = 0.3
		t3.SetThrustVisual(v1, 1)
		if p1 == LocalPlayer then
			v3:FireServer("d" .. ("pxq1r0o"):sub(5, 6):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("mqf90gsik"):sub(5, 5):reverse():reverse():reverse() .. "" .. "" .. ("jey2y"):sub(4, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("u1kn4n3a"):sub(4, 5):reverse() .. "e")
		end
	end
end
function t3.StopThrust(p1) --[[ Line: 531 | Upvalues: t4 (copy), t3 (copy), LocalPlayer (copy), v3 (ref) ]]
	assert(p1)
	local v1 = nil
	for i = #t4, 1, -1 do
		local v2 = t4[i]
		if v2.Player == p1 then
			v1 = v2
			break
		end
	end
	if v1 then
		assert(v1.IsThrusting == true)
		v1.IsThrusting = false
		v1.SoundThrustVolumeTarget = 0.05
		t3.SetThrustVisual(v1, 0.3)
		if p1 == LocalPlayer then
			v3:FireServer("m" .. ("gplxj1n5"):sub(2, 6):reverse():reverse():reverse():reverse():reverse() .. "0h")
		end
	end
end
local function IsFlying() --[[ Line: 553 | Upvalues: LocalPlayer (copy), t4 (copy) ]]
	local v1 = LocalPlayer
	local v2 = nil
	for i = #t4, 1, -1 do
		local v3 = t4[i]
		if v3.Player == v1 then
			v2 = v3
			break
		end
	end
	return v2 ~= nil
end
local function IsThrusting() --[[ Line: 557 | Upvalues: LocalPlayer (copy), t4 (copy) ]]
	local v1 = LocalPlayer
	local v2 = nil
	for i = #t4, 1, -1 do
		local v3 = t4[i]
		if v3.Player == v1 then
			v2 = v3
			break
		end
	end
	return if v2 == nil then false else v2.IsThrusting == true
end
local v9 = 0
local function OnJump() --[[ Line: 563 | Upvalues: v2 (ref), t (copy), LocalPlayer (copy), t4 (copy), v9 (ref), v4 (ref), t3 (copy), Time (copy), VehicleUtils (copy) ]]
	if not v2.IsRagdolling() then
		local v1 = tick()
		for i, v in ipairs(t) do
			v.Region:Update({ LocalPlayer })
		end
		local v22 = LocalPlayer
		local v3 = nil
		for i = #t4, 1, -1 do
			local v42 = t4[i]
			if v42.Player == v22 then
				v3 = v42
				break
			end
		end
		if v1 - v9 < 0.22 and v3 == nil then
			if v4 == false then
				v3 = t3.Equip(LocalPlayer)
			end
		elseif v1 - v9 < 0.22 then
			v3 = t3.Unequip(LocalPlayer)
		end
		if v3 ~= nil and (v4 == false and Time.GetNowSync() - VehicleUtils.LastVehicleEject > 10) then
			t3.StartThrust(LocalPlayer)
		end
		v9 = v1
	end
end
local function jumpPressed() --[[ Line: 592 | Upvalues: OnJump (copy) ]]
	OnJump()
end
local function jumpReleased() --[[ Line: 595 | Upvalues: LocalPlayer (copy), t4 (copy), t3 (copy) ]]
	local v1 = LocalPlayer
	local v2 = nil
	for i = #t4, 1, -1 do
		local v3 = t4[i]
		if v3.Player == v1 then
			v2 = v3
			break
		end
	end
	if if v2 == nil then false else v2.IsThrusting == true then
		t3.StopThrust(LocalPlayer)
	end
end
local function Stunned() --[[ Line: 600 | Upvalues: LocalPlayer (copy), t4 (copy), t3 (copy) ]]
	local v1 = LocalPlayer
	local v2 = nil
	for i = #t4, 1, -1 do
		local v3 = t4[i]
		if v3.Player == v1 then
			v2 = v3
			break
		end
	end
	if v2 ~= nil then
		t3.LocalFuel = math.max(0, t3.LocalFuel - 5)
		t3.UpdateFuel()
	end
end
return {
	Init = function(p1) --[[ Name: Init | Line: 608 | Upvalues: v2 (ref), ReplicatedStorage (copy), v1 (ref), LocalPlayer (copy), t2 (copy), Signal (copy), JetPackGui (copy), t3 (copy), v3 (ref), DefaultActions (copy), jumpPressed (copy), jumpReleased (copy), t4 (copy), Region (copy), RegionUtils (copy), v4 (ref), t (copy), CollectionService (copy), Interval (copy), RayCast (copy), VehicleUtils_2 (copy) ]]
		v2 = require(ReplicatedStorage.Game.Falling)
		v1 = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"))
		t2.OnEquipped = Signal.new()
		JetPackGui.Init()
		v2.OnRagdolled:Connect(function() --[[ Line: 614 | Upvalues: t3 (ref), LocalPlayer (ref) ]]
			t3.Unequip(LocalPlayer)
		end)
		local em = p1.em
		v3 = p1.Event
		function em.effrclru(p1, p2) --[[ Line: 620 | Upvalues: t3 (ref) ]]
			assert(p1)
			t3.Equip(p1, p2)
		end
		function em.ab3zo4do(p1) --[[ Line: 624 | Upvalues: t3 (ref) ]]
			assert(p1)
			t3.Unequip(p1)
		end
		function em.d0r024ne(p1) --[[ Line: 628 | Upvalues: t3 (ref) ]]
			assert(p1)
			t3.StartThrust(p1)
		end
		function em.m1jxlp0h(p1) --[[ Line: 632 | Upvalues: t3 (ref) ]]
			assert(p1)
			t3.StopThrust(p1)
		end
		local v12 = false
		local v22 = nil
		local v32 = nil
		function em.injzgvkb() --[[ Line: 638 | Upvalues: v12 (ref), v22 (ref), DefaultActions (ref), jumpPressed (ref), v32 (ref), jumpReleased (ref), t3 (ref) ]]
			assert(v12 == false)
			v22 = DefaultActions.onJumpPressed:Connect(jumpPressed)
			v32 = DefaultActions.onJumpReleased:Connect(jumpReleased)
			v12 = true
			t3.LocalFuel = t3.LocalMaxFuel
			t3.UpdateFuel()
		end
		function em.ijrarcvd() --[[ Line: 649 | Upvalues: v12 (ref), v22 (ref), v32 (ref), LocalPlayer (ref), t4 (ref), t3 (ref) ]]
			assert(v12 == true)
			v22:Disconnect()
			v22 = nil
			v32:Disconnect()
			v32 = nil
			v12 = false
			local v2 = LocalPlayer
			local v3 = nil
			for i = #t4, 1, -1 do
				local v4 = t4[i]
				if v4.Player == v2 then
					v3 = v4
					break
				end
			end
			if v3 ~= nil then
				t3.LocalFuel = 0
				t3.UpdateFuel()
			end
		end
		function em.tco34g38(p1) --[[ Line: 662 | Upvalues: t3 (ref) ]]
			t3.LocalFuel = math.max(t3.LocalFuel - p1 / 10, 0)
			t3.UpdateFuel()
		end
		local function AddedFun(p1) --[[ Line: 667 | Upvalues: Region (ref), RegionUtils (ref), LocalPlayer (ref), v4 (ref), t4 (ref), t3 (ref), t (ref) ]]
			local t2 = {
				Part = p1,
				Region = Region.new(RegionUtils.ConditionPlayer)
			}
			t2.Region:AddPart(t2.Part)
			t2.Region.OnObjAdded:Connect(function(p1) --[[ Line: 673 | Upvalues: LocalPlayer (ref), v4 (ref), t4 (ref), t3 (ref) ]]
				assert(p1 == LocalPlayer)
				v4 = true
				local v2 = LocalPlayer
				local v3 = nil
				for i = #t4, 1, -1 do
					local v42 = t4[i]
					if v42.Player == v2 then
						v3 = v42
						break
					end
				end
				if if v3 == nil then false else v3.IsThrusting == true == true then
					t3.StopThrust(LocalPlayer)
				end
			end)
			t2.Region.OnObjRemoved:Connect(function(p1) --[[ Line: 680 | Upvalues: LocalPlayer (ref), v4 (ref) ]]
				assert(p1 == LocalPlayer)
				v4 = false
			end)
			table.insert(t, t2)
		end
		local function RemovedFun(p1) --[[ Line: 686 | Upvalues: t (ref) ]]
			for i = #t, 1, -1 do
				local v1 = t[i]
				if v1.Part == p1 then
					table.remove(t, i)
					v1.Region:Destroy()
					return
				end
			end
		end
		for i, v in ipairs(CollectionService:GetTagged("JetPackNoFly")) do
			AddedFun(v)
		end
		CollectionService:GetInstanceAddedSignal("JetPackNoFly"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("JetPackNoFly"):Connect(RemovedFun)
		v2.OnRagdoll:Connect(function() --[[ Line: 704 | Upvalues: LocalPlayer (ref), t4 (ref), t3 (ref) ]]
			local v1 = LocalPlayer
			local v2 = nil
			for i = #t4, 1, -1 do
				local v3 = t4[i]
				if v3.Player == v1 then
					v2 = v3
					break
				end
			end
			if v2 then
				t3.Unequip(LocalPlayer)
			end
		end)
		Interval.every(0.2):Connect(function() --[[ Line: 711 | Upvalues: v12 (ref), LocalPlayer (ref), RayCast (ref), t3 (ref) ]]
			if v12 then
				local v1 = assert(LocalPlayer.Character)
				local Humanoid = v1:FindFirstChild("Humanoid")
				assert(Humanoid)
				local RootPart = Humanoid.RootPart
				assert(RootPart)
				if RayCast.RayIgnoreNonCollide(RootPart.Position, Vector3.new(0, -1, 0), Humanoid.HipHeight + RootPart.Size.Y * 0.5 + 2, v1) ~= nil and t3.LocalFuel < t3.LocalMaxFuel then
					local v3 = t3
					v3.LocalFuel = v3.LocalFuel + 0.1
					if t3.LocalFuel > t3.LocalMaxFuel then
						t3.LocalFuel = t3.LocalMaxFuel
					end
					t3.UpdateFuel()
				end
			end
		end)
		VehicleUtils_2.OnVehicleEntered:Connect(function() --[[ Line: 738 | Upvalues: LocalPlayer (ref), t4 (ref), t3 (ref) ]]
			local v1 = LocalPlayer
			local v2 = nil
			for i = #t4, 1, -1 do
				local v3 = t4[i]
				if v3.Player == v1 then
					v2 = v3
					break
				end
			end
			if v2 then
				t3.Unequip(LocalPlayer)
			end
		end)
	end,
	Stunned = Stunned,
	IsFlying = IsFlying,
	IsThrusting = IsThrusting,
	Signal = t2
}