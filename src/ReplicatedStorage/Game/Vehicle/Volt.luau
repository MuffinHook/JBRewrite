-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CurrentCamera = workspace.CurrentCamera
local Audio = require(ReplicatedStorage.Std.Audio)
local Time = require(ReplicatedStorage.Module.Time)
local C4Binder = require(ReplicatedStorage.Game.C4.C4Binder)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local WheelWorld = require(ReplicatedStorage.Module.Wheel.WheelWorld)
local Wheel = require(ReplicatedStorage.Module.Wheel.Wheel)
game:GetService("UserInputService")
local Players = game:GetService("Players")
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local LocalPlayer = Players.LocalPlayer
local v1 = nil
local v2 = nil
local t = {
	tire_pop = 4534995816,
	tire_leak = 17871250897,
	tire_respawn = 77257382359638
}
local t2 = { 0, 0, 0, 0, 0, 0 }
local function GetMoveVector()
	return Vector3.new()
end
local ControlModule = LocalPlayer.PlayerScripts:WaitForChild("PlayerModule", 5).ControlModule
if ControlModule then
	local v3 = require(ControlModule)
	GetMoveVector = function()
		return v3:GetMoveVector()
	end
end
local function SetHumanoidEnabled(p1, p2)
	local v1 = next
	local v2, v3 = Enum.HumanoidStateType:GetEnumItems()
	for v4, v5 in v1, v2, v3 do
		if v5 ~= Enum.HumanoidStateType.Dead and (v5 ~= Enum.HumanoidStateType.None and v5 ~= Enum.HumanoidStateType.Jumping) then
			p1.Humanoid:SetStateEnabled(v5, p2)
		end
	end
end
local function v4(p1)
	local sum = 0
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("BasePart") then
			local v1 = v:GetMass()
			if v.CustomPhysicalProperties then
				local Density = v.CustomPhysicalProperties.Density
				if Density ~= Density then
					Density = 0
				end
				v1 = v1 * Density
			end
			sum = sum + v1
		end
		sum = sum + v4(v)
	end
	return sum
end
local v5 = os.clock()
local function VehicleEnter(p1)
	t2 = { 0, 0, 0, 0, 0, 0 }
	v5 = os.clock()
	local Character = LocalPlayer.Character
	SetHumanoidEnabled(Character, false)
	Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	p1.Rotate.MaxTorque = Vector3.new(0, 10000000, 10000000)
	p1.fv = Vector3.new()
	p1.hv = 0
	p1.Mass = v4(p1.Model)
	p1._defaultForwardFriction = 0.01
	local v1 = WheelWorld.new()
	v1:SetModel(p1.Model)
	local v2 = Wheel.new(p1.Model.SuspensionFront)
	v2:SetSpringConstants(2, 4)
	v2:SetVisualRadius(1)
	v2:SetForwardFriction(p1._defaultForwardFriction)
	v2:SetForwardFriction2(0)
	v2:SetHorizontalFriction(0)
	v2:SetSuspensionHeight(6.5)
	v1:AddWheel(v2)
	local v3 = Wheel.new(p1.Model.SuspensionBack)
	v3:SetSpringConstants(2, 4)
	v3:SetVisualRadius(1)
	v3:SetForwardFriction(p1._defaultForwardFriction)
	v3:SetForwardFriction2(0.001)
	v3:SetHorizontalFriction(0)
	v3:SetSuspensionHeight(6.5)
	v1:AddWheel(v3)
	p1.WheelWorld = v1
	function p1.setForward(p1)
		t2[1] = if p1 then 1 else 0
	end
	function p1.setBackward(p1)
		t2[3] = if p1 then 1 else 0
	end
end
local function VehicleLeave(p1)
	local Character = LocalPlayer.Character
	if Character and Character:FindFirstChild("Humanoid") then
		SetHumanoidEnabled(Character, true)
	end
	p1.Rotate.MaxTorque = Vector3.new()
	p1.Force.Force = Vector3.new()
	p1.WheelWorld:Destroy()
	p1.WheelWorld = nil
	CurrentCamera.FieldOfView = 70
	t2 = { 0, 0, 0, 0, 0, 0 }
end
local v6 = Vector3.new()
os.clock()
local function Update(p1)
	local v1 = os.clock()
	local v2 = v1 - v5
	v5 = v1
	local v3 = t2[1] - t2[3]
	local v4 = t2[2] - t2[4]
	if InputUtils.isTouch() then
		local Character = LocalPlayer.Character
		if Character and Character:FindFirstChild("Humanoid") then
			local X = GetMoveVector().X
			local v52 = math.clamp(X, -1, 1)
			v4 = -v52 * math.abs(v52)
		end
	end
	local Model = p1.Model
	local Engine = Model:FindFirstChild("Engine")
	if Engine then
		local BoundingBox = Model.BoundingBox
		local t3 = {}
		for v62, v7 in C4Binder:GetAll() do
			table.insert(t3, v7.obj)
		end
		t3[#t3 + 1] = Model
		t3[#t3 + 1] = LocalPlayer.Character
		for i, v in ipairs(p1.WheelWorld.Wheels) do
			v.IgnoreModel = t3
			v:Update(v2, 0)
		end
		local v8 = Model:GetAttribute("VehicleTiresLastPop") or 0
		local v10 = math.min((Time.GetNowSync() - v8) / p1.DisableDuration, 1) < 0.999
		if v10 then
			v3 = 0
		end
		if p1.AreTiresPopped ~= v10 then
			local t4 = {
				Volume = 1
			}
			if p1.AreTiresPopped == nil or not v10 then
				if p1.AreTiresPopped ~= nil and v10 ~= nil then
					Audio.ObjectLocal(Engine, t.tire_respawn, t4)
				end
			else
				Audio.ObjectLocal(Engine, t.tire_pop, t4)
				Audio.ObjectLocal(Engine, t.tire_leak, t4)
			end
			for i, v in ipairs(p1.WheelWorld.Wheels) do
				local v11
				v11 = if v10 then 50 else 1
				v:SetForwardFriction(p1._defaultForwardFriction * v11)
			end
			p1.AreTiresPopped = v10
		end
		if p1.LockMovement then
			v4 = 0
			v3 = 0
		end
		local v12 = Engine.Velocity:Dot(Engine.CFrame.LookVector)
		local v13 = v12 * v2 / 1.7035
		p1.FrontWheelMotor.C1 = p1.FrontWheelMotor.C1 * p1.FrontWheelMotor.C0:Inverse() * CFrame.Angles(-v13, 0, 0) * p1.FrontWheelMotor.C0
		p1.BackWheelMotor.C1 = p1.BackWheelMotor.C1 * p1.BackWheelMotor.C0:Inverse() * CFrame.Angles(-v13, 0, 0) * p1.BackWheelMotor.C0
		local v14 = v12 / 200
		if v14 ~= v14 then
			v14 = 0
		end
		local v15 = math.clamp(v14, 0, 3)
		local v16, v17
		if v15 < 0.825155 then
			v16 = v15 * v15 * v15
			if not v16 then
				v17 = v15
				v16 = 1 - math.exp(-v15)
			end
		else
			v17 = v15
			v16 = 1 - math.exp(-v15)
		end
		local FieldOfView = CurrentCamera.FieldOfView
		CurrentCamera.FieldOfView = FieldOfView + (v16 * 30 + 70 - FieldOfView) * 0.7
		local Magnitude = Engine.Velocity.Magnitude
		local v18 = 145
		if v3 < 0 then
			v18 = v18 * if v12 > 0 then 0.5 else 0.15
		end
		local sum = Engine.CFrame.LookVector * v3 * Engine.AssemblyMass * v18
		if p1.Nitro then
			sum = sum + Engine.CFrame.LookVector * Engine.AssemblyMass * 50
		end
		if not RayCast.RayIgnoreNonCollideWithIgnoreList(BoundingBox.CFrame * Vector3.new(0, -BoundingBox.Size.Y * 0.5, 0), Vector3.new(0, -1, 0), 10, t3) then
			sum = v6
		end
		p1.Force.Force = sum - math.min(50, Engine.Velocity:Dot(Engine.CFrame.RightVector)) * 10 * Engine.CFrame.RightVector * Engine.AssemblyMass
		local hv = p1.hv
		local v22 = hv + (v4 - hv) * 0.1
		local v23 = if v4 * v4 <= 0.01 then v22 * 0.9 else v22 * 0.99
		p1.hv = v23
		local v24 = if Engine.Velocity:Dot(Engine.CFrame.LookVector) < -5 then -1 else 1
		p1.Rotate.CFrame = CFrame.new(v6, Engine.CFrame.LookVector) * CFrame.Angles(0, 0.5 * v23 * v24, 0.8 * v23 * v24)
	end
end
local t3 = {
	[Enum.KeyCode.A] = 2,
	[Enum.KeyCode.D] = 4,
	[Enum.KeyCode.Q] = 5,
	[Enum.KeyCode.E] = 6,
	[Enum.KeyCode.ButtonR2] = 1,
	[Enum.KeyCode.ButtonL2] = 3,
	[Enum.KeyCode.Left] = 2,
	[Enum.KeyCode.Right] = 4
}
local function InputBegan(p1)
	if p1.UserInputType == Enum.UserInputType.Keyboard then
		local KeyCode = p1.KeyCode
		if t3[KeyCode] then
			t2[t3[KeyCode]] = 1
		end
	end
end
local function InputEnded(p1)
	if p1.UserInputType == Enum.UserInputType.Keyboard then
		local KeyCode = p1.KeyCode
		if t3[KeyCode] then
			t2[t3[KeyCode]] = 0
		end
	elseif p1.UserInputType == Enum.UserInputType.Gamepad1 then
		local KeyCode = p1.KeyCode
		if KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
			t2[t3[KeyCode]] = 0
		end
	end
end
local function InputChanged(p1, p2)
	if p1.UserInputType == Enum.UserInputType.Gamepad1 then
		local KeyCode = p1.KeyCode
		if KeyCode == Enum.KeyCode.Thumbstick1 then
			local Position = p1.Position
			local X = Position.X
			local Y = Position.Y
			t2[2] = X < -0.24 and (-X) ^ 2 or 0
			t2[4] = X > 0.24 and X ^ 2 or 0
		elseif KeyCode == Enum.KeyCode.ButtonR2 or KeyCode == Enum.KeyCode.ButtonL2 then
			local Z = p1.Position.Z
			t2[t3[KeyCode]] = Z > 0.05 and Z ^ 0.5 or 0
		end
	end
end
return {
	Init = function(p1)
		v1 = p1.Event
		v2 = p1.em
	end,
	VehicleEnter = VehicleEnter,
	VehicleLeave = VehicleLeave,
	InputBegan = InputBegan,
	InputEnded = InputEnded,
	InputChanged = InputChanged,
	Update = Update
}
