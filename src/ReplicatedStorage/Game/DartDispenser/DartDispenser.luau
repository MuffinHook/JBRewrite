-- Reviewed by Claude
-- variables reassigned
local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local Spring = require(ReplicatedStorage.Std.Spring)
local SimulatedPhysicsProjectile = require(ReplicatedStorage.Module.SimulatedPhysicsProjectile)
local DartDispenserConsts = require(script.Parent.DartDispenserConsts)
local randomGenerator = Random.new()
local Darts = Instance.new("Folder")
Darts.Name = "Darts"
Darts.Parent = workspace
local t = {}
t.__index = t
function t.new(self)
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._maid:GiveTask(self:WaitForChild(DartDispenserConsts.FIRE_REMOTE_NAME).OnClientEvent:Connect(function()
		t2:_fire(self)
	end))
	t2._damageRemote = self:WaitForChild(DartDispenserConsts.DAMAGE_REMOTE_NAME)
	return t2
end
function t._fire(self, dispenserPart)
	local v12 = randomGenerator:NextInteger(1, 1000000000)
	local updateKey = ("update_%d"):format(v12)
	local partKey = ("part_%d"):format(v12)
	local spawnCFrame = dispenserPart.CFrame * Vector3.new(0, 0, -dispenserPart.Size.Z * 0.5)
	local dart = ReplicatedStorage.Resource.Robbery.Tomb:FindFirstChild("Arrow"):Clone()
	dart.Parent = Darts
	local PrimaryPart = dart.PrimaryPart
	self._maid[partKey] = dart
	Audio.ObjectLocal(dispenserPart, 6856219972, {
		Volume = 0.6,
		RollOffMaxDistance = 128
	})
	local projectile = SimulatedPhysicsProjectile.new(spawnCFrame)
	function projectile.CollidableFunc(p1)
		return if p1.Parent == LocalPlayer.Character then true else p1:IsA("Terrain")
	end
	projectile.IgnoreList = { Darts }
	projectile._GravityVector = projectile._GravityVector / 20
	projectile.Velocity = dispenserPart.CFrame.LookVector * 300
	local currentPosition = spawnCFrame
	local LookVector = dispenserPart.CFrame.LookVector
	local hitPart = nil
	local hitOffset = nil
	local rotationAxis = nil
	local rotationSpring = Spring.new(0, 0, 0.3, 30)
	local startTime = os.clock()
	self._maid[updateKey] = RunService.Heartbeat:Connect(function()
		if hitPart then
			local v1, v22 = rotationSpring:Update()
			if math.abs(v1) < 0.001 and math.abs(v22) < 0.001 then
				self._maid[updateKey] = nil
				self._maid[partKey] = nil
				return
			end
			dart:SetPrimaryPartCFrame(hitPart.CFrame * hitOffset * CFrame.fromAxisAngle(rotationAxis, v1) * CFrame.new(0, 0, PrimaryPart.Size.Z * 0.5))
		else
			local v32, v4, v5 = projectile:Step(projectile:_GetNow(), currentPosition)
			local v6 = CFrame.new(currentPosition, v32) * CFrame.new(0, 0, PrimaryPart.Size.Z * 0.5)
			local LookVector_2 = v6.LookVector
			if v4 then
				rotationAxis = LookVector:Cross(LookVector_2)
				rotationSpring:Accelerate(20)
				local v72 = CFrame.new(v32, v32 + LookVector_2)
				v6 = v72 * CFrame.new(0, 0, PrimaryPart.Size.Z * 0.5)
				hitPart = v5
				hitOffset = v5.CFrame:ToObjectSpace(v72)
				Audio.ObjectLocal(PrimaryPart, 6856219902, {
					Volume = 0.6,
					RollOffMaxDistance = 128
				})
				if v5:IsDescendantOf(LocalPlayer.Character) then
					self._damageRemote:FireServer()
				end
			end
			dart:SetPrimaryPartCFrame(v6)
			LookVector = LookVector_2
			currentPosition = v32
		end
		if os.clock() - startTime > 3 then
			self._maid[updateKey] = nil
			self._maid[partKey] = nil
		end
	end)
end
function t.Destroy(self)
	local _maid = self._maid
	self._maid = nil
	_maid:Destroy()
end
return t
