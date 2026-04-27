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
local DartDispenser = {}
DartDispenser.__index = DartDispenser
function DartDispenser.new(self)
	local instance = {}
	setmetatable(instance, DartDispenser)
	instance._maid = Maid.new()
	instance._maid:GiveTask(self:WaitForChild(DartDispenserConsts.FIRE_REMOTE_NAME).OnClientEvent:Connect(function()
		instance:_fire(self)
	end))
	instance._damageRemote = self:WaitForChild(DartDispenserConsts.DAMAGE_REMOTE_NAME)
	return instance
end
function DartDispenser._fire(self, dispenserPart)
	local randomId = randomGenerator:NextInteger(1, 1000000000)
	local updateKey = ("update_%d"):format(randomId)
	local partKey = ("part_%d"):format(randomId)
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
	function projectile.CollidableFunc(part)
		return if part.Parent == LocalPlayer.Character then true else part:IsA("Terrain")
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
			local rotationAngle, rotationVelocity = rotationSpring:Update()
			if math.abs(rotationAngle) < 0.001 and math.abs(rotationVelocity) < 0.001 then
				self._maid[updateKey] = nil
				self._maid[partKey] = nil
				return
			end
			dart:SetPrimaryPartCFrame(hitPart.CFrame * hitOffset * CFrame.fromAxisAngle(rotationAxis, rotationAngle) * CFrame.new(0, 0, PrimaryPart.Size.Z * 0.5))
		else
			local newPosition, didCollide, collisionPart = projectile:Step(projectile:_GetNow(), currentPosition)
			local dartCFrame = CFrame.new(currentPosition, newPosition) * CFrame.new(0, 0, PrimaryPart.Size.Z * 0.5)
			local newLookVector = dartCFrame.LookVector
			if didCollide then
				rotationAxis = LookVector:Cross(newLookVector)
				rotationSpring:Accelerate(20)
				local collisionCFrame = CFrame.new(newPosition, newPosition + newLookVector)
				dartCFrame = collisionCFrame * CFrame.new(0, 0, PrimaryPart.Size.Z * 0.5)
				hitPart = collisionPart
				hitOffset = collisionPart.CFrame:ToObjectSpace(collisionCFrame)
				Audio.ObjectLocal(PrimaryPart, 6856219902, {
					Volume = 0.6,
					RollOffMaxDistance = 128
				})
				if collisionPart:IsDescendantOf(LocalPlayer.Character) then
					self._damageRemote:FireServer()
				end
			end
			dart:SetPrimaryPartCFrame(dartCFrame)
			LookVector = newLookVector
			currentPosition = newPosition
		end
		if os.clock() - startTime > 3 then
			self._maid[updateKey] = nil
			self._maid[partKey] = nil
		end
	end)
end
function DartDispenser.Destroy(self)
	local _maid = self._maid
	self._maid = nil
	_maid:Destroy()
end
return DartDispenser
