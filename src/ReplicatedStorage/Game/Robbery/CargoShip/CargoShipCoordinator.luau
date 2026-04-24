-- Reviewed by Claude
local LocalPlayer = game:GetService("Players").LocalPlayer
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local Silo = require(ReplicatedStorage.Game.Silo)
require(ReplicatedStorage.Std.Signal)
local Audio = require(ReplicatedStorage.Std.Audio)
local MinimapService = require(ReplicatedStorage.App.MinimapService)
local Interval = require(ReplicatedStorage.Std.Interval)
local CargoShip = require(script.Parent.CargoShip)
local function GetRootPart()
	local Character = LocalPlayer.Character
	if Character == nil then
		return nil
	else
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid == nil then
			return nil
		else
			return Humanoid.RootPart
		end
	end
end
local t = {}
t.__index = t
setmetatable(t, Silo)
function t.new(p1)
	local v1 = Silo.new(p1)
	setmetatable(v1, t)
	v1.BayMaid = Maid.new()
	v1._door1Part = v1.Model:WaitForChild("Door1")
	v1._door2Part = v1.Model:WaitForChild("Door2")
	v1.Size = v1._door1Part.Size
	v1.BayMaid:GiveTask(Interval.every(0.5):Connect(function()
		local Character = LocalPlayer.Character
		if Character ~= nil then
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid ~= nil then
				local RootPart = Humanoid.RootPart
				if RootPart ~= nil then
					local v12 = (RootPart.Position - v1.Model.Door1.Position).Magnitude < 128
					if v12 ~= v1.IsOpen then
						if v12 then
							v1:Open(2)
							return
						end
						v1:Close(2)
					end
				end
			end
		end
	end))
	return v1
end
function t.SetDoorOpen(p1, p2)
	local _door1Part = p1._door1Part
	local v1 = -p1.Size.Z * p2
	_door1Part.Size = Vector3.new(p1.Size.X, p1.Size.Y, p1.Size.Z + v1)
	_door1Part.CFrame = p1.Door1CF * CFrame.new(0, 0, v1 * 0.5)
	local _door2Part = p1._door2Part
	local v3 = -p1.Size.Z * p2
	_door2Part.Size = Vector3.new(p1.Size.X, p1.Size.Y, p1.Size.Z + v3)
	_door2Part.CFrame = p1.Door2CF * CFrame.new(0, 0, v3 * 0.5)
end
function t.Destroy(p1)
	p1:SetDoorOpen(0)
	Silo.Destroy(p1)
	p1.BayMaid:DoCleaning()
	p1.BayMaid = nil
end
local v2 = Binder.new("CargoShip", CargoShip)
return {
	Init = function(p1)
		local v1 = p1.Event
		local em = p1.em
		local function OnRocketExploded(p1)
			local Character = LocalPlayer.Character
			local v12
			if Character == nil then
				v12 = nil
			else
				local Humanoid = Character:FindFirstChild("Humanoid")
				v12 = if Humanoid == nil then nil else Humanoid.RootPart
			end
			if v12 ~= nil and (p1 - v12.Position).Magnitude < 64 then
				v1:FireServer("p" .. ("kmko"):sub(3, 3):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("fw1zvj"):sub(2, 3):reverse() .. "8s32", p1)
			end
		end
		v2:GetClassAddedSignal():Connect(function(p1)
			for i, v in ipairs(p1.ListTurret) do
				v.Maid:GiveTask(v.RocketWorld.OnRocketExploded:Connect(OnRocketExploded))
			end
		end)
		v2:Start()
		function em.kzlkcvqh(p1, p2)
			for v1, v22 in v2:GetAll() do
				if v22:GetId() == p1 then
					v22:SetTurretSeek(p2)
				end
			end
		end
		local v22 = nil
		local function AddedFun(p1)
			assert(v22 == nil, "Cargo bay already exists!")
			v22 = t.new(p1)
		end
		local function RemovedFun()
			assert(v22 ~= nil, "Cargo bay already destroyed!")
			v22:Destroy()
			v22 = nil
		end
		for i, v in ipairs(CollectionService:GetTagged("CargoDepotDoor")) do
			assert(v22 == nil, "Cargo bay already exists!")
			v22 = t.new(v)
		end
		CollectionService:GetInstanceAddedSignal("CargoDepotDoor"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("CargoDepotDoor"):Connect(RemovedFun)
		local v4 = nil
		local v5 = nil
		function em.gk9ob559(p1)
			if v5 ~= nil then
				v5:Disconnect()
				v5 = nil
			end
			if p1 then
				if v4 == nil then
					v4 = Audio.ObjectLocal(LocalPlayer.PlayerGui, 1837327837, {
						Looped = true,
						Volume = 0
					})
					v4.SoundGroup = game.SoundService.RobberyMusic
				end
				v5 = Audio.FadeTo(v4, 0.7, 2, function()
					v5 = nil
				end)
			else
				v5 = Audio.FadeTo(v4, 0, 4, function()
					v4:Destroy()
					v4 = nil
					v5 = nil
				end)
			end
		end
		function em.s98gnbty(p1)
			if p1 then
				if v22 ~= nil then
					MinimapService.addWaypoint({
						name = "CargoShip",
						position = (v22.Door1CF.p + v22.Door2CF.p) * 0.5,
						priority = 1000,
						minDist = 0
					})
				end
			else
				MinimapService.removeWaypointByName("CargoShip")
			end
		end
		function em.c8ag3yrn()
			Audio.ObjectLocal(LocalPlayer.PlayerGui, 1988476450)
		end
	end
}
