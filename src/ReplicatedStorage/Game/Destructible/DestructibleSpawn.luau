-- Reviewed by Claude
-- variables reassigned
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
local t = {}
t.__index = t
function t.new(p1)
	local instance = {}
	setmetatable(instance, t)
	instance._obj = p1
	instance._objName = p1.Name
	instance._maid = Maid.new()
	instance:_setup(p1, instance._maid)
	return instance
end
function t.GetOnHitSignal(p1)
	if not p1._onHitSignal then
		p1._onHitSignal = Signal.new()
		p1._maid:GiveTask(p1._onHitSignal)
	end
	return p1._onHitSignal
end
function t.GetInst(p1)
	return p1._instValue.Value
end
function t.GetPrefab(p1)
	return ReplicatedStorage:FindFirstChild(DestructibleConsts.PREFAB_FOLDER_NAME):FindFirstChild(p1._objName)
end
function t._setup(p1, p2, p3)
	local instValueObj = p2:FindFirstChild(DestructibleConsts.INSTANCE_VALUE_NAME)
	if not instValueObj then
		local newValueObj = Instance.new("ObjectValue")
		newValueObj.Name = DestructibleConsts.INSTANCE_VALUE_NAME
		newValueObj.Value = nil
		newValueObj.Parent = p2
		instValueObj = newValueObj
	end
	p1._instValue = instValueObj
	p1._wasTouched = false
	p3:GiveTask(RxInstanceUtils.observeOneChildNamed(p2, DestructibleConsts.BROADCAST_COLLIDE_REMOTE_NAME, function(p12, p2)
		p1._broadcastCollideRemote = p12
		p2:GiveTask(p12.OnClientEvent:Connect(function(p12)
			if not p1._wasTouched then
				p1:_handleHitPosition(p12)
			end
		end))
	end))
	p3:GiveTask(instValueObj.Changed:Connect(function()
		p1:_handleInst()
	end))
	p1:_handleInst()
end
function t._handleHitPosition(p1, p2)
	local _instValue = p1._instValue
	p1._wasTouched = true
	local instValue = _instValue.Value
	if instValue then
		if p1._onHitSignal then
			p1._onHitSignal:Fire()
		end
		local PrimaryPart = instValue.PrimaryPart
		PrimaryPart.Anchored = false
		local impulseMidpoint = (p2 + PrimaryPart.Position) * 0.5
		local Unit = (PrimaryPart.Position - p2).Unit
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
function t._handleInst(p1)
	debug.profilebegin("DestructibleSpawn.handleInst")
	local _instValue = p1._instValue
	local _obj = p1._obj
	local _maid = p1._maid
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
				p1._wasTouched = false
			end)
			local clonedPrefab = ReplicatedStorage:FindFirstChild(DestructibleConsts.PREFAB_FOLDER_NAME):FindFirstChild(_obj.Name):Clone()
			clonedPrefab:SetPrimaryPartCFrame(_obj.Value)
			clonedPrefab.Parent = spawnFolder
			_instValue.Value = clonedPrefab
			instMaid:GiveTask(clonedPrefab.PrimaryPart.Touched:Connect(function(p12)
				if p12:IsDescendantOf(spawnFolder) then
				elseif p12:IsDescendantOf(workspace:FindFirstChild("Vehicles")) then
					if not p1._wasTouched then
						p1._wasTouched = true
						local Position = p12.Position
						p1._broadcastCollideRemote:FireServer(Position)
						p1:_handleHitPosition(Position)
					end
				end
			end))
			instMaid:GiveTask(clonedPrefab.AncestryChanged:Connect(function(p1, p2)
				if not p2 then
					_instValue.Value = nil
				end
			end))
		end
		debug.profileend()
	end
end
t.Update = t._handleInst
function t.Destroy(p1)
	local _maid = p1._maid
	p1._maid = nil
	_maid:Destroy()
	setmetatable(p1, nil)
end
return t
