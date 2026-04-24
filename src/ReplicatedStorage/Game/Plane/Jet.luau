-- Reviewed by Claude
local CurrentCamera = workspace.CurrentCamera
local CollectionService = game:GetService("CollectionService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseUserControlledPlane = require(ReplicatedStorage.Game.Plane.BaseUserControlledPlane)
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local Audio = require(ReplicatedStorage.Std.Audio)
local PartUtils = require(ReplicatedStorage.Std.PartUtils)
local String = require(ReplicatedStorage.Std.String)
local Interval = require(ReplicatedStorage.Std.Interval)
require(ReplicatedStorage.Game.Missile)
local Confirmation = require(ReplicatedStorage.Module.Confirmation)
local Raycast = require(ReplicatedStorage.Std.Raycast)
require(ReplicatedStorage.Module.Time)
local UserInputService = game:GetService("UserInputService")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local SeekingMissileBinder = require(ReplicatedStorage.SeekingMissile.SeekingMissileBinder)
local NetObjPoolBinder = require(ReplicatedStorage.NetObjPool.NetObjPoolBinder)
local JetConsts = require(ReplicatedStorage.Game.Plane.JetConsts)
local v1 = nil
local v2 = nil
local v3 = Random.new()
local function RandomVector(p1)
	local v1 = p1 * (v3:NextNumber() * 2 - 1)
	local v2 = p1 * (v3:NextNumber() * 2 - 1)
	return Vector3.new(v1, v2, p1 * (v3:NextNumber() * 2 - 1))
end
local t = {
	__ClassName = "Jet"
}
t.__index = t
function t.Init(p1)
	v1 = p1.Event
	v2 = p1.em
end
function t.new(p1)
	local v2 = setmetatable({}, t)
	v2.Meta = p1
	v2.Model = p1.Model
	v2.Plane = BaseUserControlledPlane.new(p1, {
		SUSPENSION_HEIGHT_FRONT = 6.5,
		SUSPENSION_HEIGHT_BACK = 5.5,
		HEIGHT_MAX = 2100,
		MAX_THRUST = 1400
	})
	v2.Maid = v2.Plane.Maid
	v2:SetupSeats()
	v2.Seats = v2.Plane.Seats
	local function OnTakeoff()
		Audio.ObjectLocal(v2.Plane.PlaneGui, 3378079535)
	end
	v2.Plane.OnTakeoff = OnTakeoff
	v2.MotorAileronRight = p1.MotorAileronRight
	v2.MotorAileronLeft = p1.MotorAileronLeft
	v2.MotorAileronTailLeft = p1.MotorAileronTailLeft
	v2.MotorAileronTailRight = p1.MotorAileronTailRight
	v2.Plane.WheelsConf = p1.WheelsConf
	v2.MissilesConf = p1.MissilesConf
	v2.MissilesConf.Idx = 1
	v2.MissilesConf.LastFire = 0
	v2.MissilesConf.Count = 0
	return v2
end
function t.SetupSeats(p1)
	local t = {}
	t.Part = assert(p1.Model.Passenger)
	t.Occupied = false
	table.insert(p1.Plane.Seats, t)
end
local function ClampUnitVectorCone(p1, p2, p3)
	local v1 = p1:VectorToObjectSpace(p2)
	local v2 = math.acos(v1.Z)
	local v3 = math.atan2(v1.Y, v1.X)
	local v4 = math.clamp(v2, math.pi - p3, math.pi + p3)
	return p1:VectorToWorldSpace((Vector3.new(math.sin(v4) * math.cos(v3), math.sin(v4) * math.sin(v3), (math.cos(v4)))))
end
local function CanLaunchMissile(p1, p2)
	local v1 = os.clock()
	local MissilesConf = p1.MissilesConf
	if v1 - MissilesConf.LastFire < 2 then
		return false
	else
		return not (MissilesConf.Count <= 0)
	end
end
local function GetTargetPart(p1)
	local Model = p1.Model
	local Position = Model.PrimaryPart.Position
	local LookVector = Model.PrimaryPart.CFrame.LookVector
	local v1 = 0.9238795325112867
	local v2 = nil
	for v3, v4 in CollectionService:GetTagged(JetConsts.SEEKING_LOCK_TAG_NAME) do
		if not v4:IsDescendantOf(Model) then
			local v5 = v4.Position - Position
			if v5.Magnitude < 768 then
				local v6 = v5.Unit:Dot(LookVector)
				if v1 <= v6 then
					v1 = v6
					v2 = v4
				end
			end
		end
	end
	return v2
end
local function attemptSetSightColor(p1, p2)
	local PlaneGui = p1.Plane.PlaneGui
	local v1 = os.clock()
	if not p1.lastSightsColorChange then
		p1.lastSightsColorChange = 0
	end
	if v1 - p1.lastSightsColorChange < 0.1 then
	elseif PlaneGui.Sights.ImageColor3 ~= p2 then
		p1.lastSightsColorChange = v1
		PlaneGui.Sights.ImageColor3 = p2
	end
end
local function AttemptLaunchLocalMissile(p1, p2)
	local v12 = os.clock()
	local MissilesConf = p1.MissilesConf
	if not (v12 - MissilesConf.LastFire < 2 or MissilesConf.Count <= 0) then
		local v32 = os.clock()
		local MissilesConf_2 = p1.MissilesConf
		MissilesConf_2.LastFire = os.clock()
		local Idx = MissilesConf_2.Idx
		local v4 = MissilesConf_2.Parts[Idx]
		local v5 = nil
		local v6 = if p1.targetPart and v32 - p1.targetPartFoundAt >= JetConsts.SEEKING_LOCK_MIN_DURATION then p1.targetPart else nil
		if not v6 then
			local v7 = RaycastParams.new()
			v7.FilterDescendantsInstances = { p1.Model, LocalPlayer.Character }
			local v8 = Raycast.collidable(v4.Position, v4.CFrame.LookVector, 999, v7)
			if v8 then
				v5 = v8.Position
			end
		end
		if not (v6 or v5) then
			v5 = v4.Position + v4.CFrame.LookVector * 4096
		end
		MissilesConf_2.Idx = Idx % MissilesConf_2.NumParts + 1
		task.delay(2, PartUtils.setPropertyWithRollback(v4, "Transparency", 1))
		local obj = NetObjPoolBinder:Get(p1.Model:FindFirstChild("JetDriverMissilePool")):Get().obj
		obj.Anchored = false
		obj.CFrame = v4.CFrame
		obj.Velocity = v4.Velocity
		SeekingMissileBinder:Promise(obj):andThen(function(p12)
			table.insert(p12.ignoreList, p1.Model)
			if v6 then
				p12:SetTargetPart(v6)
			else
				p12:SetTargetPos(v5)
			end
		end)
		MissilesConf_2.Count = MissilesConf_2.Count - 1
		p2.CameraSpring:Accelerate(Vector3.new(10 * (v3:NextNumber() * 2 - 1), 10 * (v3:NextNumber() * 2 - 1), 10 * (v3:NextNumber() * 2 - 1)) + Vector3.new(0, 0, -50))
		local v122 = Color3.new(0/255, 255/255, 0/255)
		local PlaneGui = p1.Plane.PlaneGui
		local v13 = os.clock()
		if not p1.lastSightsColorChange then
			p1.lastSightsColorChange = 0
		end
		if not (v13 - p1.lastSightsColorChange < 0.1) and PlaneGui.Sights.ImageColor3 ~= v122 then
			p1.lastSightsColorChange = v13
			PlaneGui.Sights.ImageColor3 = v122
		end
		v1:FireServer("u" .. ("f6xqsmh"):sub(4, 5):reverse() .. "lew42", obj)
	end
end
local function MountLocalPlayer(p1, p2, p3)
	if p3.Driver then
		local function HeartbeatAilerons(p12)
			local Joystickx = p1.Plane.Joystickx
			local Joysticky = p1.Plane.Joysticky
			local InputYaw = p1.Plane.InputYaw
			local v1 = (Joystickx * Joystickx + Joysticky * Joysticky) ^ 0.5
			local v2 = v1 > 1 and Joystickx / v1 or Joystickx
			local v3 = v1 > 1 and Joysticky / v1 or Joysticky
			p1.MotorAileronRight.C0 = CFrame.new(0, 0, 1.5) * CFrame.Angles(0.3 * (v3 + v2), 0, 0)
			p1.MotorAileronLeft.C0 = CFrame.new(0, 0, 1.5) * CFrame.Angles(0.3 * (v3 - v2), 0, 0)
			p1.MotorAileronTailRight.C0 = CFrame.new(0, 0, 1.5) * CFrame.Angles(0, -0.5 * v2 + 0.3 * InputYaw, 0)
			p1.MotorAileronTailLeft.C0 = CFrame.new(0, 0, 1.5) * CFrame.Angles(0, -0.5 * v2 + 0.3 * InputYaw, 0)
		end
		local function Heartbeat(p1)
			HeartbeatAilerons(p1)
		end
		p3.Maid:GiveTask(RunService.Heartbeat:Connect(Heartbeat))
		local PlaneGui = p1.Plane.PlaneGui
		PlaneGui.Sights.Size = UDim2.new(0.08, 0, 0.08, 0)
		p3.Maid:GiveTask(Interval.every(0.3333333333333333):Connect(function()
			local v1 = if p1.Plane.IsFlying then GetTargetPart(p1) else nil
			if v1 ~= p1.targetPart then
				p1.targetPart = v1
				if v1 ~= nil then
					p1.targetPartFoundAt = os.clock()
				end
			end
		end))
		local v12 = true
		local v2 = 0
		local v3 = false
		p3.Maid:GiveTask(RunService.Heartbeat:Connect(function()
			local v1 = os.clock()
			local targetPart = p1.targetPart
			local v22 = if targetPart then targetPart.Position else nil
			if v22 then
				local v32, _ = CurrentCamera:WorldToScreenPoint(v22)
				PlaneGui.Sights.Position = UDim2.new(0, v32.X, 0, v32.Y)
				local v4 = v1 - p1.targetPartFoundAt
				local SEEKING_LOCK_MIN_DURATION = JetConsts.SEEKING_LOCK_MIN_DURATION
				local v7 = math.cos(28.274333882308138 * math.sqrt(1 - math.min(v4 / SEEKING_LOCK_MIN_DURATION, 1))) * 0.5 + 0.5
				PlaneGui.Sights.ImageTransparency = 1 - v7
				local v8 = v2 < v7
				if v8 ~= v12 then
					v12 = v8
					if v8 then
						Audio.ObjectLocal(PlaneGui, 6602021732, {
							Volume = 0.05,
							Pitch = 1
						})
					end
				end
				v2 = v7
				if SEEKING_LOCK_MIN_DURATION <= v4 then
					if not v3 then
						Audio.ObjectLocal(PlaneGui, 6602021732, {
							Volume = 0.1,
							Pitch = 1.2
						})
					end
					v3 = true
					local v9 = p1
					local v10 = Color3.new(255/255, 0/255, 0/255)
					local PlaneGui_2 = v9.Plane.PlaneGui
					local v11 = os.clock()
					if not v9.lastSightsColorChange then
						v9.lastSightsColorChange = 0
					end
					if not (v11 - v9.lastSightsColorChange < 0.1) and PlaneGui_2.Sights.ImageColor3 ~= v10 then
						v9.lastSightsColorChange = v11
						PlaneGui_2.Sights.ImageColor3 = v10
					end
				else
					v3 = false
					local v122 = p1
					local v13 = Color3.new(255/255, 255/255, 255/255)
					local PlaneGui_2 = v122.Plane.PlaneGui
					local v14 = os.clock()
					if not v122.lastSightsColorChange then
						v122.lastSightsColorChange = 0
					end
					if not (v14 - v122.lastSightsColorChange < 0.1) and PlaneGui_2.Sights.ImageColor3 ~= v13 then
						v122.lastSightsColorChange = v14
						PlaneGui_2.Sights.ImageColor3 = v13
					end
				end
			end
			PlaneGui.Sights.Visible = v22 ~= nil
		end))
		local v4 = false
		local function OpenMissileBuy()
			local v2 = math.max(0, JetConsts.MISSILE_COUNT_MAX - p1.MissilesConf.Count)
			if v2 == 0 then
			elseif not v4 then
				v4 = true
				p1.Plane:SetControlsEnabled(false)
				local v42 = Confirmation.new(("Buy %d heat seeking missiles for $%s?"):format(v2, String.comma(v2 * JetConsts.MISSILE_COST_PER)))
				v42.Maid:GiveTask(v42.OnYes:Connect(function()
					v1:FireServer("q" .. ("iufp3y3phw"):sub(5, 8):reverse():reverse():reverse() .. "" .. "" .. ("cdctv"):sub(4, 4):reverse() .. "h9")
				end))
				v42.Maid:GiveTask(function()
					v4 = false
					p1.Plane:SetControlsEnabled(true)
				end)
			end
		end
		PlaneGui.Missiles.Visible = true
		p3.Maid:GiveTask(ActionButtonService.add({
			priority = 500,
			image = "rbxassetid://4939737424",
			keyCodes = { Enum.KeyCode.G },
			onPressed = function()
				OpenMissileBuy()
			end
		}))
		local function attemptLaunchLocalMissile()
			if RunUtils.isTradeWorld() then
				return false
			end
			if p1.MissilesConf.Count <= 0 then
				OpenMissileBuy()
				return false
			end
			AttemptLaunchLocalMissile(p1, p3)
		end
		local function InputBegan(p12, p2)
			if p2 then
				return false
			end
			if p12.UserInputType == Enum.UserInputType.MouseButton1 and not RunUtils.isTradeWorld() then
				if p1.MissilesConf.Count <= 0 then
					OpenMissileBuy()
					return
				end
				AttemptLaunchLocalMissile(p1, p3)
			end
		end
		p3.Maid:GiveTask(UserInputService.InputBegan:Connect(InputBegan))
		p3.Maid:GiveTask(ActionButtonService.add({
			priority = 500,
			noSink = true,
			image = "rbxassetid://4939736393",
			keyCodes = { Enum.KeyCode.F, Enum.KeyCode.ButtonX },
			onPressed = function()
				if RunUtils.isTradeWorld() then
				elseif p1.MissilesConf.Count <= 0 then
					OpenMissileBuy()
				else
					AttemptLaunchLocalMissile(p1, p3)
				end
			end
		}))
	end
end
local function MountThirdPlayer(p1, p2, p3)
	local v1 = Audio.ObjectLocal(p1.Model.PrimaryPart, 9553468279, {
		Looped = true,
		Volume = 0,
		Pitch = 1,
		RollOffMinDistance = 86,
		RollOffMaxDistance = 896
	})
	p3.Maid:GiveTask(v1)
	p3.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		local v12 = p1.Model.PrimaryPart.Velocity:Dot(p1.Model.PrimaryPart.CFrame.LookVector)
		local v2 = math.clamp(v12 / 300, 0, 1)
		local v3 = math.clamp(v12 / 300, 0, 1)
		v1.Volume = v2 * 0.4
		v1.PlaybackSpeed = v3 * 0.35 + 0.65
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
local function UnmountLocalPlayer(p1, p2)
	local PlaneGui = p1.Plane.PlaneGui
	if p2.Driver then
		PlaneGui.Missiles.Visible = false
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
