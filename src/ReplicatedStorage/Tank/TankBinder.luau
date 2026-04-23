game:GetService("GuiService")
local Players = game:GetService("Players")
local CurrentCamera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TankUtils = require(script.Parent.TankUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local Signal = require(ReplicatedStorage.Std.Signal)
local Enumer = require(ReplicatedStorage.Std.Enumer)
local Spring = require(ReplicatedStorage.Std.Spring)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local AccelTween = require(ReplicatedStorage.Std.AccelTween)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local DrivingControls = require(ReplicatedStorage.DrivingControls.DrivingControls)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local MilitaryTurretUtils = require(ReplicatedStorage.Game.MilitaryTurret.MilitaryTurretUtils)
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local WheelWorld = require(ReplicatedStorage.Module.Wheel.WheelWorld)
local Wheel = require(ReplicatedStorage.Module.Wheel.Wheel)
local Missile = require(ReplicatedStorage.Game.Missile)
local Time = require(ReplicatedStorage.Module.Time)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local v1 = Enumer({ "Wheel", "Front", "Gear" })
local t = {}
t.__index = t
function t.new(p1, p2) --[[ Line: 33 | Upvalues: t (copy), Maid (copy), Signal (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2.obj = p1
	t2.manifest = p2
	t2._maid = Maid.new()
	t2._onGunnerSeatLeft = Signal.new()
	t2._gunnerMaid = Maid.new()
	t2._maid:GiveTask(t2._gunnerMaid)
	t2._lastShoot = 0
	t2.mobileInputObject = nil
	t2._flagBrakelightsEnabled = false
	t2:_handleIdleUpdate()
	t2:_listenSeats("Seat")
	t2:_listenSeats("Passenger")
	t2:_listenNetwork()
	return t2
end
function t._listenSeats(p1, p2) --[[ Line: 55 | Upvalues: RxInstanceUtils (copy) ]]
	p1._maid:GiveTask(RxInstanceUtils.observeChildrenNamed(p1.obj, p2, function(p12, p2) --[[ Line: 56 | Upvalues: RxInstanceUtils (ref), p1 (copy) ]]
		p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p12, "PlayerName", function(p13, p2) --[[ Line: 58 | Upvalues: p1 (ref), p12 (copy) ]]
			p1:_handlePlayerNameChanged(p12, p13, p2)
			p2:GiveTask(p13.Changed:Connect(function() --[[ Line: 60 | Upvalues: p1 (ref), p12 (ref), p13 (copy), p2 (copy) ]]
				p1:_handlePlayerNameChanged(p12, p13, p2)
			end))
		end))
	end))
end
function t._handlePlayerNameChanged(p1, p2, p3, p4) --[[ Line: 67 | Upvalues: Players (copy), Maid (copy) ]]
	local v1 = Players:FindFirstChild(p3.Value)
	if v1 then
		local v2 = Maid.new()
		p4.seatMaid = v2
		p1:_handleSeated(v1, v2, p2)
	else
		p4.seatMaid = nil
	end
end
function t._getMouseLocation(p1) --[[ Line: 79 | Upvalues: InputUtils (copy), CurrentCamera (copy), UserInputService (copy) ]]
	if InputUtils.isTouch() then
		local ViewportSize = CurrentCamera.ViewportSize
		return Vector2.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.5)
	else
		return UserInputService:GetMouseLocation()
	end
end
function t._transformLocalMousePosition(p1, p2) --[[ Line: 90 ]]
	return p2
end
function t._getIgnoreList(p1) --[[ Line: 93 ]]
	return { p1.obj }
end
function t._projectMouseLocationToWorld(p1, p2) --[[ Line: 96 | Upvalues: CurrentCamera (copy), Raycast (copy) ]]
	local v1 = CurrentCamera:ViewportPointToRay(p2.x, p2.y)
	p1.raycastParams.FilterDescendantsInstances = p1:_getIgnoreList()
	local v2 = Raycast.collidable(v1.Origin, v1.Direction, 999, p1.raycastParams)
	return p1:_transformLocalMousePosition(v2 and v2.Position or v1.Origin + v1.Direction * 999), v1.Direction
end
function t._getMouseWorldPosition(p1) --[[ Line: 105 ]]
	return p1:_projectMouseLocationToWorld(p1:_getMouseLocation())
end
function t._flip(p1) --[[ Line: 108 ]]
	local PrimaryPart = p1.obj.PrimaryPart
	local LookVector = PrimaryPart.CFrame.LookVector
	local Unit = LookVector:Cross(Vector3.new(0, 1, 0)).Unit
	p1.obj:SetPrimaryPartCFrame(CFrame.fromMatrix(PrimaryPart.Position, Unit, Vector3.new(0, 1, 0), -LookVector))
end
function t._handleSeated(p1, p2, p3, p4) --[[ Line: 115 ]]
	if p4.Name == "Seat" then
		p1:_handleSeatedDriver(p2, p3)
	end
	p3:GiveTask(p1._onGunnerSeatLeft:Connect(function(p12) --[[ Line: 121 | Upvalues: p1 (copy), p2 (copy), p3 (copy) ]]
		p1:_checkIfThisPlayerIsGunner(p2, p3)
	end))
	p1:_checkIfThisPlayerIsGunner(p2, p3)
end
function t._checkIfThisPlayerIsGunner(p1, p2, p3) --[[ Line: 126 | Upvalues: TankUtils (copy) ]]
	local v1 = TankUtils.getGunner(p1.obj)
	if v1 == p2 and (v1 and v1 ~= p1._currentGunner) then
		p1._currentGunner = v1
		p1:_handleSeatedGunner(v1, p3)
	end
end
function t._handleSeatedGunner(p1, p2, p3) --[[ Line: 139 | Upvalues: Players (copy), Maid (copy), Audio (copy), AccelTween (copy), Spring (copy), RunService (copy), MilitaryTurretUtils (copy), VehicleUtils (copy), Raycast (copy), Time (copy), ActionButtonService (copy), UserInputService (copy) ]]
	local v1 = p2 == Players.LocalPlayer
	local v2 = Maid.new()
	p1._maid.gunnerMaid = v2
	p3:GiveTask(function() --[[ Line: 143 | Upvalues: p1 (copy), v2 (copy) ]]
		if p1._maid.gunnerMaid == v2 then
			p1._currentGunner = nil
			p1._maid.gunnerMaid = nil
			p1._onGunnerSeatLeft:Fire(nil)
		end
	end)
	local v3 = Audio.ObjectLocal(p1.obj.PrimaryPart, 8206012878, {
		Volume = 0,
		Pitch = 1,
		Looped = true
	})
	v2:GiveTask(function() --[[ Line: 153 | Upvalues: Audio (ref), v3 (copy) ]]
		Audio.promiseFadeTo(v3, 0, 0.5):andThen(function() --[[ Line: 154 | Upvalues: v3 (ref) ]]
			v3:Destroy()
		end)
	end)
	local v4 = RaycastParams.new()
	v4.FilterType = Enum.RaycastFilterType.Blacklist
	v4.FilterDescendantsInstances = p1:_getIgnoreList()
	v4.IgnoreWater = true
	p1.raycastParams = v4
	local topMotor = p1.manifest.topMotor
	local gunMotor = p1.manifest.gunMotor
	if not p1._lastPitch then
		p1._lastPitch = 0
	end
	if not p1._lastYaw then
		p1._lastYaw = 0
	end
	if not p1._pitchAccel then
		p1._pitchAccel = AccelTween.new(20)
	end
	if not p1._yawAccel then
		p1._yawAccel = AccelTween.new(15)
	end
	if not p1._kickSpring then
		p1._kickSpring = Spring.new(0, 0, 0.5, 15)
	end
	local v5 = os.clock()
	local v6 = false
	v2:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 187 | Upvalues: v1 (copy), v6 (ref), topMotor (copy), p1 (copy), gunMotor (copy), MilitaryTurretUtils (ref), v5 (ref), v3 (copy) ]]
		if v1 then
			if v6 then
				local v12 = topMotor.Part1.CFrame * topMotor.C0:Inverse()
				local v2 = p1:_getMouseWorldPosition()
				local v32 = v12:PointToObjectSpace(v2)
				local v62 = math.atan2(-v32.x, -v32.z)
				local v7 = (v12 * CFrame.Angles(0, v62, 0) * gunMotor.C0:Inverse()):PointToObjectSpace(v2)
				local v9 = math.atan2(v7.y, -v7.z)
				p1._lastYaw = p1._lastYaw + MilitaryTurretUtils.shortAngleDist(p1._lastYaw, v62)
				p1._lastPitch = math.clamp(v9, -0.2617993877991494, 0.5235987755982988)
			end
			local v10 = os.clock()
			if v10 - v5 > 0.06666666666666667 then
				v5 = v10
				p1.manifest.replicateRingRemote:FireServer(p1._lastYaw, p1._lastPitch)
			end
		end
		if p1._yawAccel.t ~= p1._lastYaw then
			p1._yawAccel.t = p1._lastYaw
		end
		if p1._pitchAccel.t ~= p1._lastPitch then
			p1._pitchAccel.t = p1._lastPitch
		end
		v3.Volume = (math.clamp(math.abs(p1._yawAccel.v) / 4, 0, 1) * 0.9 + 0.1) * 0.8
		local v13 = p1._kickSpring:Update()
		topMotor.C1 = topMotor.C0:Inverse() * CFrame.Angles(0, p1._yawAccel.p, 0) * topMotor.C0
		gunMotor.C1 = gunMotor.C0:Inverse() * CFrame.Angles(p1._pitchAccel.p, 0, 0) * CFrame.new(0, 0, v13) * gunMotor.C0
	end))
	if v1 then
		local function shoot() --[[ Line: 231 | Upvalues: p1 (copy), Players (ref), VehicleUtils (ref), gunMotor (copy), Raycast (ref), Time (ref) ]]
			if p1.obj:GetAttribute("TankDisabled") == true then
				return
			end
			if Players.LocalPlayer:GetAttribute("MissileCount") <= 0 and not Players.LocalPlayer.Character:GetAttribute("TankRoyaleAlive") then
				VehicleUtils.promptMissileBuy()
				return false
			end
			local v2 = os.clock()
			if not (v2 - p1._lastShoot < 1 / p1.obj:GetAttribute("MissileLaunchHz")) then
				p1._lastShoot = v2
				local Part0 = gunMotor.Part0
				local v3 = Part0.CFrame
				local v4 = Raycast.collidable(v3.p, v3.LookVector, 999, p1.raycastParams)
				local v5 = v4 and v4.Position or v3.p + v3.LookVector * 999
				local v6 = v3 * CFrame.new(0, 0, -14)
				local v7 = Time.GetNowSync()
				p1:_launchMissile(v6, Part0.Velocity, v5, v7)
				p1.manifest.shootRemote:FireServer(p1._yawAccel.p, p1._pitchAccel.p, v5, v7)
			end
		end
		v2:GiveTask(ActionButtonService.add({
			priority = 350,
			image = "rbxassetid://4939740665",
			keyCodes = { Enum.KeyCode.F, Enum.KeyCode.ButtonX },
			onPressed = function() --[[ Name: onPressed | Line: 267 | Upvalues: shoot (copy) ]]
				shoot()
			end
		}))
		v2:GiveTask(UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 272 | Upvalues: v6 (ref), p1 (copy) ]]
			if not p2 and p12.UserInputType == Enum.UserInputType.MouseButton1 then
				v6 = true
			elseif not p2 and p12.UserInputType == Enum.UserInputType.Touch then
				p1._mobileInputObject = p12
			end
		end))
		v2:GiveTask(UserInputService.InputEnded:Connect(function(p12, p2) --[[ Line: 282 | Upvalues: v6 (ref), p1 (copy) ]]
			if not p2 and p12.UserInputType == Enum.UserInputType.MouseButton1 then
				v6 = false
			elseif not p2 and p12.UserInputType == Enum.UserInputType.Touch then
				local is_mobileInputObject = p1._mobileInputObject == p12
			end
		end))
		v2:GiveTask(ActionButtonService.add({
			priority = 975,
			image = "rbxassetid://4939736720",
			touchIsToggle = true,
			keyCodes = { Enum.KeyCode.Q, Enum.KeyCode.ButtonL1 },
			onPressed = function() --[[ Name: onPressed | Line: 299 | Upvalues: p1 (copy), v6 (ref) ]]
				p1._mobileInputObject = nil
				v6 = true
			end,
			onReleased = function() --[[ Name: onReleased | Line: 303 | Upvalues: v6 (ref) ]]
				v6 = false
			end
		}))
	end
end
function t._updateTreads(p1, p2, p3) --[[ Line: 309 | Upvalues: v1 (copy) ]]
	local count = 0
	local sum = 0
	local count_2 = 0
	local t = {}
	local t2 = {}
	local t3 = {}
	local sum_2 = 0
	for i, v in ipairs(p2.Wheels) do
		local v12, v2, v3 = v:Update(p3, 0)
		v.wheelMotor.C1 = CFrame.new(0, v12, 0) * CFrame.Angles(v2, 0, 0)
		t[v.PartNode] = v12
		t2[v.PartNode] = v.treadType
		t3[v.PartNode] = v.fakeTreadMotor
		if v.fakeTreadMotor then
			v.fakeTreadMotor.C1 = CFrame.new(0, v12, 0)
		end
		if v._isRight then
			count = count + 1
			sum_2 = sum_2 + v3
		else
			sum = sum + v3
			count_2 = count_2 + 1
		end
	end
	local v4 = sum / count_2
	local v5 = sum_2 / count
	for i, v in ipairs(p2.Wheels) do
		local v6
		local PartNode = v.PartNode
		local treadToTarget = v.treadToTarget
		local v7 = t[PartNode]
		local v8 = t[treadToTarget]
		local v9 = nil
		local v10 = nil
		if t2[PartNode] == v1.Wheel then
			v9 = PartNode.CFrame * Vector3.new(0, v7 - v.RadiusVisual + 0.1, 0)
		elseif t2[PartNode] == v1.Gear then
			v9 = t3[PartNode].Part0.Bottom.WorldPosition
		elseif t2[PartNode] == v1.Front then
			v9 = t3[PartNode].Part0.Top.WorldPosition
		end
		if t2[treadToTarget] == v1.Wheel then
			v10 = treadToTarget.CFrame * Vector3.new(0, v8 - v.RadiusVisual + 0.1, 0)
		elseif t2[treadToTarget] == v1.Gear then
			v10 = t3[treadToTarget].Part0.Top.WorldPosition
		elseif t2[treadToTarget] == v1.Front then
			v10 = t3[treadToTarget].Part0.Bottom.WorldPosition
		end
		local Magnitude = (v9 - v10).Magnitude
		v.treadMotor.C1 = PartNode.CFrame:ToObjectSpace(CFrame.lookAt(v9, v10, p1.obj.PrimaryPart.CFrame.UpVector) * CFrame.new(0, 0, -Magnitude * 0.5))
		local Part0 = v.treadMotor.Part0
		Part0.Size = Vector3.new(Part0.Size.X, Part0.Size.Y, Magnitude)
		v6 = if v._isRight and v5 then v5 else v4
		local v16 = v.treadTex[1].OffsetStudsV - v6
		for i2, v2 in ipairs(v.treadTex) do
			v2.OffsetStudsV = v16
		end
	end
	return v4, v5
end
local function getUpdateRate(p1, p2, p3) --[[ Line: 391 ]]
	if p1 < p2 then
		return 0
	else
		return (p1 - p2) / (p3 - p2)
	end
end
function t._handleIdleUpdate(p1) --[[ Line: 397 | Upvalues: Maid (copy), RunService (copy), CharacterUtils (copy), Players (copy) ]]
	local v1 = Maid.new()
	p1._maid.lqMaid = v1
	local v2 = p1:_buildWheelWorld(v1, false)
	local v3 = os.clock()
	v1:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 402 | Upvalues: v3 (ref), CharacterUtils (ref), Players (ref), p1 (copy), v2 (copy) ]]
		local v1 = os.clock()
		local v22 = v1 - v3
		local v32 = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
		if v32 then
			local Magnitude = (v32.Position - p1.obj.PrimaryPart.Position).Magnitude
			if not (v22 < if Magnitude < 0 then 0 else (Magnitude - 0) / 256) then
				v3 = v1
				p1:_updateTreads(v2, v22)
			end
		end
	end))
end
function t._handleSeatedDriver(p1, p2, p3) --[[ Line: 418 | Upvalues: Players (copy), DrivingControls (copy), VehicleUtils (copy), AccelTween (copy), Audio (copy), RunService (copy), ActionButtonService (copy) ]]
	p1._maid.lqMaid = nil
	p3:GiveTask(function() --[[ Line: 420 | Upvalues: p1 (copy) ]]
		p1:_handleIdleUpdate()
	end)
	local isLocalPlayer = p2 == Players.LocalPlayer
	local v1
	if isLocalPlayer then
		v1 = DrivingControls.new()
		p3:GiveTask(v1)
		local obj = p1.obj
		p3:GiveTask(function() --[[ Line: 431 | Upvalues: VehicleUtils (ref), obj (copy) ]]
			VehicleUtils.setBrakelightsEnabled(obj, false)
		end)
	else
		v1 = nil
	end
	local v2 = p1:_buildWheelWorld(p3, isLocalPlayer)
	local v3 = v2:GetEffWheelCount()
	local v4 = AccelTween.new(500)
	local v5 = AccelTween.new(2000)
	local v6 = Audio.ObjectLocal(p1.obj.PrimaryPart, 9058406725, {
		Volume = 0,
		Pitch = 1,
		Looped = true
	})
	p3:GiveTask(function() --[[ Line: 446 | Upvalues: Audio (ref), v6 (copy) ]]
		Audio.promiseFadeTo(v6, 0, 0.5):andThen(function() --[[ Line: 447 | Upvalues: v6 (ref) ]]
			v6:Destroy()
		end)
	end)
	local v7 = Audio.ObjectLocal(p1.obj.PrimaryPart, 8206014264, {
		Volume = 0,
		Pitch = 1,
		Looped = true
	})
	p3:GiveTask(function() --[[ Line: 453 | Upvalues: Audio (ref), v7 (copy) ]]
		Audio.promiseFadeTo(v7, 0, 0.5):andThen(function() --[[ Line: 454 | Upvalues: v7 (ref) ]]
			v7:Destroy()
		end)
	end)
	local v8 = 0
	p3:GiveTask(RunService.Heartbeat:Connect(function(p12) --[[ Line: 461 | Upvalues: v1 (ref), VehicleUtils (ref), p1 (copy), v4 (copy), v5 (copy), v8 (ref), v2 (copy), v3 (copy) ]]
		local v12 = 60
		if v1 then
			local v22 = VehicleUtils.GetLocalVehiclePacket()
			local v32 = if p1.obj:GetAttribute("TankDisabled") == true then true else v22.LockMovement
			local v42 = v1:GetForwardBackward()
			if v32 then
				v42 = 0
			end
			if v4.t ~= v42 then
				v4.t = v42
				v4.v = 0
			end
			local v52 = v1:GetLeftRight()
			if v32 then
				v52 = 0
			end
			if v5.t ~= v52 then
				v5.t = v52
				v5.v = 0
			end
			if v4.p < 0 then
				v12 = v12 * 0.5
			end
			v8 = if math.abs(v4.p) < 0.1 then v8 + math.sign(0 - v8) * 75 * p12 else v8 + math.sign(v12 - v8) * 30 * p12
			v8 = math.max(v8, 0)
			local v9 = v42 < 1e-6
			if p1._flagBrakelightsEnabled ~= v9 then
				p1._flagBrakelightsEnabled = v9
				VehicleUtils.setBrakelightsEnabled(p1.obj, v9)
			end
		end
		for i, v in ipairs(v2.Wheels) do
			local v10
			local _isRight = v._isRight
			if v1 then
				local p = v4.p
				local p_2 = v5.p
				local sum = Vector3.new()
				if math.abs(p) >= 0.001 then
					sum = sum + Vector3.new(0, 0, -v8 * p) / v3
				end
				if math.abs(p_2) >= 0.001 then
					v10 = if _isRight then 1 else -1
					sum = sum + Vector3.new(0, 0, -10 * p_2 * v10) / v3
				end
				v:SetExternalGroundAccel(sum)
			end
		end
	end))
	p3:GiveTask(RunService.Heartbeat:Connect(function(p12) --[[ Line: 525 | Upvalues: p1 (copy), v2 (copy), v7 (copy), v6 (copy) ]]
		local v1, v22 = p1:_updateTreads(v2, p12)
		v7.Volume = (math.clamp((math.abs(v1) + math.abs(v22)) * 0.5 / p12 / 10, 0, 1) * 0.9 + 0.1) * 0.8
		local v62 = math.abs((p1.obj.PrimaryPart.Velocity:Dot(p1.obj.PrimaryPart.CFrame.LookVector)))
		v6.Volume = (math.clamp(v62 / 90, 0, 1) * 0.6 + 0.4) * 1
		v6.PlaybackSpeed = math.clamp(v62 / 100, 0, 1) * 0.4 + 0.8
	end))
	if isLocalPlayer then
		local v9 = os.clock()
		p3:GiveTask(ActionButtonService.add({
			priority = 850,
			image = "rbxassetid://4939737424",
			keyCodes = { Enum.KeyCode.V, Enum.KeyCode.ButtonR1 },
			onPressed = function() --[[ Name: onPressed | Line: 545 | Upvalues: v9 (ref), p1 (copy) ]]
				local v1 = os.clock()
				if not (v1 - v9 < 1) then
					v9 = v1
					p1:_flip()
				end
			end
		}))
	end
end
function t._listenNetwork(p1) --[[ Line: 556 ]]
	p1._maid:GiveTask(p1.manifest.replicateRingRemote.OnClientEvent:Connect(function(p12, p2) --[[ Line: 557 | Upvalues: p1 (copy) ]]
		p1._lastYaw = p12
		p1._lastPitch = p2
	end))
	p1._maid:GiveTask(p1.manifest.shootRemote.OnClientEvent:Connect(function(p12, p2, p3, p4) --[[ Line: 561 | Upvalues: p1 (copy) ]]
		local topMotor = p1.manifest.topMotor
		local gunMotor = p1.manifest.gunMotor
		p1._lastYaw = p12
		p1._lastPitch = p2
		p1:_launchMissile(topMotor.Part1.CFrame * topMotor.C0:Inverse() * CFrame.Angles(0, p12, 0) * gunMotor.C0:Inverse() * CFrame.Angles(p2, 0, 0) * CFrame.new(0, 0, -14) * CFrame.new(0, 0, -14), gunMotor.Part0.Velocity, p3, p4)
	end))
end
function t._launchMissile(p1, p2, p3, p4, p5) --[[ Line: 582 | Upvalues: Missile (copy), Audio (copy) ]]
	Missile.LaunchMissile(p2, p3, p4, p5, "TankMissile", 0, p1:_getIgnoreList())
	p1.obj.PrimaryPart:ApplyImpulseAtPosition(-p2.LookVector * p1.obj.PrimaryPart.AssemblyMass * 30, p2.p)
	p1._kickSpring:Accelerate(80)
	Audio.ObjectLocal(p1.obj.PrimaryPart, 8206015084, {
		Volume = 0.6
	})
	local ParticlePart = p1.obj:FindFirstChild("Top"):FindFirstChild("Gun"):FindFirstChild("ParticlePart")
	for i, v in ipairs(ParticlePart:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v:Emit(10)
		end
	end
end
function t._buildWheelWorld(p1, p2, p3) --[[ Line: 595 | Upvalues: WheelWorld (copy), Wheel (copy), v1 (copy) ]]
	local v12 = WheelWorld.new()
	v12:SetModel(p1.obj)
	p2:GiveTask(v12)
	for i, v in ipairs(p1.obj:FindFirstChild("Wheels"):GetChildren()) do
		local v2
		local v3 = p1.obj.PrimaryPart.CFrame:ToObjectSpace(v.CFrame)
		v2 = v3.x > 0
		local _ = v3.z < 0
		local v4 = Wheel.new(v, not p3)
		local Wheel_2 = v1.Wheel
		if v.Name == "Front" then
			Wheel_2 = v1.Front
		elseif v.Name == "Gear" then
			Wheel_2 = v1.Gear
		end
		v4.treadType = Wheel_2
		v4._isRight = v2
		v4:SetSpringConstants(2, 6)
		v4:SetHorizontalFriction(6)
		v4:SetForwardFriction(2)
		v4:SetForwardFriction2(0.01)
		v4:SetVisualRadius(1.6384999999999998)
		if Wheel_2 == v1.Wheel then
			v4:SetSuspensionHeight(5.3)
		else
			v4:SetSuspensionHeight(3.3)
		end
		v4:SetVersion(2)
		if p3 then
			v4:SetApplyForces(Wheel_2 == v1.Wheel)
		end
		v12:AddWheel(v4)
		v4.wheelMotor = v:FindFirstChild("WheelMotor")
		v4.fakeTreadMotor = v:FindFirstChild("FakeTreadMotor")
		v4.treadMotor = v:FindFirstChild("TreadMotor")
		v4.treadToTarget = v:FindFirstChild("_TrackToWheel").Value
		v4.treadTex = { v4.treadMotor.Part0:FindFirstChild("TreadTex0"), v4.treadMotor.Part0:FindFirstChild("TreadTex1") }
		if v4.fakeTreadMotor then
			for i2, v5 in ipairs(v4.fakeTreadMotor.Part0.Parent:GetChildren()) do
				if v5.Name == "Tread" then
					for i3, v6 in ipairs(v5:GetChildren()) do
						if v6:IsA("Texture") then
							table.insert(v4.treadTex, v6)
						end
					end
				end
			end
		end
	end
	return v12
end
function t.Destroy(p1) --[[ Line: 654 ]]
	p1._maid:Destroy()
	setmetatable(p1, nil)
end
return ManifestBinder.new("Tank", {
	topMotor = "BoundingBox/TopMotor",
	gunMotor = "BoundingBox/GunMotor",
	shootRemote = "ShootRemote",
	replicateRingRemote = "ReplicateRingRemote"
}, t)