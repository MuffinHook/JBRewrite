local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CurrentCamera = workspace.CurrentCamera
local Audio = require(ReplicatedStorage.Std.Audio)
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local RateLimiter = require(ReplicatedStorage.Std.RateLimiter)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local DestructibleConsts = require(script.Parent.DestructibleConsts)
local spawnFolder = Instance.new("Folder")
spawnFolder.Parent = workspace
local rateLimiter = RateLimiter.new(50)
local DestructibleSpawn = {}
DestructibleSpawn.__index = DestructibleSpawn
function DestructibleSpawn.new(destructibleObj)
	local instance = {}
	setmetatable(instance, DestructibleSpawn)
	instance._obj = destructibleObj
	instance._objName = destructibleObj.Name
	instance._maid = Maid.new()
	instance:_setup(destructibleObj, instance._maid)
	return instance
end
function DestructibleSpawn.GetOnHitSignal(self)
	if not self._onHitSignal then
		self._onHitSignal = Signal.new()
		self._maid:GiveTask(self._onHitSignal)
	end
	return self._onHitSignal
end
function DestructibleSpawn.GetInst(self)
	return self._instValue.Value
end
function DestructibleSpawn.GetPrefab(self)
	return ReplicatedStorage:FindFirstChild(DestructibleConsts.PREFAB_FOLDER_NAME):FindFirstChild(self._objName)
end
function DestructibleSpawn._setup(self, parent, maid)
	local instValueObj = parent:FindFirstChild(DestructibleConsts.INSTANCE_VALUE_NAME)
	if not instValueObj then
		local newValueObj = Instance.new("ObjectValue")
		newValueObj.Name = DestructibleConsts.INSTANCE_VALUE_NAME
		newValueObj.Value = nil
		newValueObj.Parent = parent
		instValueObj = newValueObj
	end
	self._instValue = instValueObj
	self._wasTouched = false
	maid:GiveTask(RxInstanceUtils.observeOneChildNamed(parent, DestructibleConsts.BROADCAST_COLLIDE_REMOTE_NAME, function(remote, maidForRemote)
		self._broadcastCollideRemote = remote
		maidForRemote:GiveTask(remote.OnClientEvent:Connect(function(hitPosition)
			if not self._wasTouched then
				self:_handleHitPosition(hitPosition)
			end
		end))
	end))
	maid:GiveTask(instValueObj.Changed:Connect(function()
		self:_handleInst()
	end))
	self:_handleInst()
end
function DestructibleSpawn._handleHitPosition(self, hitPosition)
	local _instValue = self._instValue
	self._wasTouched = true
	local instValue = _instValue.Value
	if instValue then
		if self._onHitSignal then
			self._onHitSignal:Fire()
		end
		local PrimaryPart = instValue.PrimaryPart
		PrimaryPart.Anchored = false
		local impulseMidpoint = (hitPosition + PrimaryPart.Position) * 0.5
		local Unit = (PrimaryPart.Position - hitPosition).Unit
		PrimaryPart:ApplyImpulseAtPosition(Unit * PrimaryPart.AssemblyMass * 30, impulseMidpoint)
		local CrashParticles = Instance.new("Part")
		CrashParticles.Name = "CrashParticles"
		CrashParticles.Transparency = 1
		CrashParticles.Anchored = true
		CrashParticles.CanCollide = false
		CrashParticles.CFrame = CFrame.lookAt(impulseMidpoint, impulseMidpoint + Unit)
		CrashParticles.Size = Vector3.new(4, 1, 1)
		CrashParticles.Parent = workspace
		local particleClone = ReplicatedStorage.Resource.CrashParticle:Clone()
		particleClone.Parent = CrashParticles
		particleClone:Emit(10)
		Debris:AddItem(CrashParticles, 5)
		Audio.ObjectLocal(PrimaryPart, 7018764077, {
			Volume = 0.15,
			RollOffMaxDistance = 128,
			PlaybackSpeed = math.random() * 0.1 + 0.95
		})
		task.wait()
		instValue:BreakJoints()
		task.wait(DestructibleConsts.DURATION)
		instValue:Destroy()
	end
end
function DestructibleSpawn._handleInst(self)
	debug.profilebegin("DestructibleSpawn.handleInst")
	local _instValue = self._instValue
	local _obj = self._obj
	local _maid = self._maid
	local loadedInst = _instValue.Value
	if rateLimiter:CanUseBudget(1) then
		local Magnitude = (CurrentCamera.CFrame.p - _obj.Value.p).Magnitude
		if loadedInst or not (Magnitude < DestructibleConsts.MAX_DIST_TO_LOAD) then
			if loadedInst and DestructibleConsts.MAX_DIST_TO_LOAD < Magnitude then
				rateLimiter:UseBudget(1)
				loadedInst:Destroy()
			end
		else
			rateLimiter:UseBudget(1)
			local instMaid = Maid.new()
			_maid._instMaid = instMaid
			instMaid:GiveTask(function()
				self._wasTouched = false
			end)
			local clonedPrefab = ReplicatedStorage:FindFirstChild(DestructibleConsts.PREFAB_FOLDER_NAME):FindFirstChild(_obj.Name):Clone()
			clonedPrefab:SetPrimaryPartCFrame(_obj.Value)
			clonedPrefab.Parent = spawnFolder
			_instValue.Value = clonedPrefab
			instMaid:GiveTask(clonedPrefab.PrimaryPart.Touched:Connect(function(touchedPart)
				if touchedPart:IsDescendantOf(spawnFolder) then
				elseif touchedPart:IsDescendantOf(workspace:FindFirstChild("Vehicles")) then
					if not self._wasTouched then
						self._wasTouched = true
						local Position = touchedPart.Position
						self._broadcastCollideRemote:FireServer(Position)
						self:_handleHitPosition(Position)
					end
				end
			end))
			instMaid:GiveTask(clonedPrefab.AncestryChanged:Connect(function(child, parent)
				if not parent then
					_instValue.Value = nil
				end
			end))
		end
		debug.profileend()
	end
end
DestructibleSpawn.Update = DestructibleSpawn._handleInst
function DestructibleSpawn.Destroy(self)
	local _maid = self._maid
	self._maid = nil
	_maid:Destroy()
	setmetatable(self, nil)
end
return DestructibleSpawn
