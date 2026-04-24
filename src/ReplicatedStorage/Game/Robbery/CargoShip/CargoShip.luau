-- Reviewed by Claude
local CurrentCamera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Time = require(ReplicatedStorage.Module.Time)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local Audio = require(ReplicatedStorage.Std.Audio)
local Turret = require(ReplicatedStorage.Turret2.Turret)
local CargoShipShared = require(script.Parent.CargoShipShared)
local v2 = Vector3.new()
local function GetHumanoid(p1)
	local Character = p1.Character
	if Character == nil then
		return nil
	else
		return Character:FindFirstChild("Humanoid")
	end
end
local function GetRootPart(p1)
	local Character = p1.Character
	local v1 = if Character == nil then nil else Character:FindFirstChild("Humanoid")
	if v1 == nil then
		return nil
	else
		return v1.RootPart
	end
end
local t = {}
t.__index = t
function t.new(p1)
	assert(p1 ~= nil)
	local t2 = {}
	setmetatable(t2, t)
	RxInstanceUtils.yieldForProperty(p1, "PrimaryPart")
	t2.Model = p1
	t2.Maid = Maid.new()
	t2.ListTurret = { Turret.new(t2.Model.TurretFront), (Turret.new(t2.Model.TurretBack)) }
	t2.Path = CargoShipShared.GetPath()
	t2._cargoShipIdObj = p1:WaitForChild("CargoShipId")
	local CargoShipBornAt = p1:WaitForChild("CargoShipBornAt")
	t2.BornAt = CargoShipBornAt.Value
	t2.Maid:GiveTask(CargoShipBornAt.Changed:Connect(function()
		t2.BornAt = CargoShipBornAt.Value
	end))
	local v3 = t2.Path.ApproxLength / CargoShipShared.Speed
	t2.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		local v1 = Time.GetNowSync()
		local v22 = (v1 - t2.BornAt) / v3
		if v22 > 1 then
			v22 = 1
		end
		t2.SwayZ = math.cos(v1 * 1.8) * 0.15
		t2.SwayX = math.sin(v1 * 1.5) * 0.1
		local v4, v5 = t2.Path:GetWorldPositionAt(t2.Path.ApproxLength * v22)
		local v6 = CFrame.Angles(0, 0, t2.SwayZ * math.pi * 0.05) * CFrame.Angles(t2.SwayX * math.pi * 0.05, 0, 0)
		t2:SetPrimaryPartCFrame(CFrame.new(v2, v5) * v6 + v4)
	end))
	local v4 = nil
	local function ChooseNextHorn()
		assert(true)
		v4 = tick() + 60 * (1 + math.random() * 1)
	end
	assert(true)
	v4 = tick() + 60 * (1 + math.random() * 1)
	t2.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		if t2.Model:IsDescendantOf(workspace) == false then
			t2:Destroy()
		else
			for i, v in ipairs(t2.ListTurret) do
				local v1, v2
				if v.TargetUserId ~= nil then
					local v3 = Players:GetPlayerByUserId(v.TargetUserId)
					if v3 ~= nil then
						local Character = v3.Character
						v1 = if Character == nil then nil else Character:FindFirstChild("Humanoid")
						v2 = if v1 == nil then nil else v1.RootPart
						if v2 ~= nil then
							v:PointAt(v2.Position)
							v:Update()
						end
					end
				end
			end
			if v4 < tick() then
				assert(true)
				v4 = tick() + 60 * (1 + math.random() * 1)
				t2:FireHorn()
			end
		end
	end))
	t2:FireHorn()
	Audio.ObjectLocal(t2.Model.PrimaryPart, 5144228425, {
		Looped = true,
		Volume = 1,
		MaxDistance = 512,
		EmitterSize = 128
	})
	t2:ListenForFirstPickup()
	return t2
end
function t.GetId(p1)
	return p1._cargoShipIdObj.Value
end
function t.FireHorn(p1)
	Audio.ObjectLocal(p1.Model.PrimaryPart, 5128574531, {
		MaxDistance = 4000,
		EmitterSize = 256,
		Volume = 1,
		RollOffMode = Enum.RollOffMode.Linear
	})
end
function t.ListenForFirstPickup(p1)
	local v1 = nil
	v1 = p1.Model.ChildAdded:Connect(function(p12)
		if p12.Name == "HasFirstRobbed" then
			v1:Disconnect()
			Audio.ObjectLocal(p1.Model.PrimaryPart, 5136785479, {
				Looped = true,
				Volume = 1,
				MaxDistance = 1024,
				EmitterSize = 64
			})
		end
	end)
end
function t.SetTurretSeek(p1, p2)
	for i, v in ipairs(p1.ListTurret) do
		v.TargetUserId = p2[v.Model.Name]
	end
end
function t.SetPrimaryPartCFrame(p1, p2)
	local v1 = false
	local Character = LocalPlayer.Character
	local v2 = if Character == nil then nil else Character:FindFirstChild("Humanoid")
	local v3 = if v2 == nil then nil else v2.RootPart
	if v3 then
		local v4 = v3.CFrame
		local v5 = RayCast.RayIgnoreNonCollide(v4.p, -v4.UpVector, 16, v3.Parent)
		if v5 and v5:IsDescendantOf(p1.Model) then
			v1 = true
		end
	end
	local v6 = p1.Model.PrimaryPart.CFrame
	p1.Model.PrimaryPart.CFrame = p2
	if v1 then
		local v7 = p2 * v6:Inverse()
		v3.CFrame = v7 * v3.CFrame
		local v8 = CurrentCamera.CFrame:ToObjectSpace(CurrentCamera.Focus)
		CurrentCamera.CFrame = CurrentCamera.CFrame * v8 * (v7 - v7.p) * v8:Inverse()
	end
end
function t.Destroy(p1)
	p1.Maid:Destroy()
	p1.Maid = nil
end
return t
