-- Reviewed by Claude
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CurrentCamera = workspace.CurrentCamera
local Audio = require(ReplicatedStorage.Std.Audio)
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local RateLimiter = require(ReplicatedStorage.Std.RateLimiter)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local DestructibleConsts = require(script.Parent.DestructibleConsts)
local v1 = Instance.new("Folder")
v1.Parent = workspace
local v2 = RateLimiter.new(50)
local t = {}
t.__index = t
function t.new(p1)
	local t2 = {}
	setmetatable(t2, t)
	t2._obj = p1
	t2._objName = p1.Name
	t2._maid = Maid.new()
	t2:_setup(p1, t2._maid)
	return t2
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
	local v1 = p2:FindFirstChild(DestructibleConsts.INSTANCE_VALUE_NAME)
	if not v1 then
		local v2 = Instance.new("ObjectValue")
		v2.Name = DestructibleConsts.INSTANCE_VALUE_NAME
		v2.Value = nil
		v2.Parent = p2
		v1 = v2
	end
	p1._instValue = v1
	p1._wasTouched = false
	p3:GiveTask(RxInstanceUtils.observeOneChildNamed(p2, DestructibleConsts.BROADCAST_COLLIDE_REMOTE_NAME, function(p12, p2)
		p1._broadcastCollideRemote = p12
		p2:GiveTask(p12.OnClientEvent:Connect(function(p12)
			if not p1._wasTouched then
				p1:_handleHitPosition(p12)
			end
		end))
	end))
	p3:GiveTask(v1.Changed:Connect(function()
		p1:_handleInst()
	end))
	p1:_handleInst()
end
function t._handleHitPosition(p1, p2)
	local _instValue = p1._instValue
	p1._wasTouched = true
	local v1 = _instValue.Value
	if v1 then
		if p1._onHitSignal then
			p1._onHitSignal:Fire()
		end
		local PrimaryPart = v1.PrimaryPart
		PrimaryPart.Anchored = false
		local v2 = (p2 + PrimaryPart.Position) * 0.5
		local Unit = (PrimaryPart.Position - p2).Unit
		PrimaryPart:ApplyImpulseAtPosition(Unit * PrimaryPart.AssemblyMass * 30, v2)
		local CrashParticles = Instance.new("Part")
		CrashParticles.Name = "CrashParticles"
		CrashParticles.Transparency = 1
		CrashParticles.Anchored = true
		CrashParticles.CanCollide = false
		CrashParticles.CFrame = CFrame.lookAt(v2, v2 + Unit)
		CrashParticles.Size = Vector3.new(4, 1, 1)
		CrashParticles.Parent = workspace
		local v3 = ReplicatedStorage.Resource.CrashParticle:Clone()
		v3.Parent = CrashParticles
		v3:Emit(10)
		Debris:AddItem(CrashParticles, 5)
		Audio.ObjectLocal(PrimaryPart, 7018764077, {
			Volume = 0.15,
			RollOffMaxDistance = 128,
			PlaybackSpeed = math.random() * 0.1 + 0.95
		})
		task.wait()
		v1:BreakJoints()
		task.wait(DestructibleConsts.DURATION)
		v1:Destroy()
	end
end
function t._handleInst(p1)
	debug.profilebegin("DestructibleSpawn.handleInst")
	local _instValue = p1._instValue
	local _obj = p1._obj
	local _maid = p1._maid
	local v12 = _instValue.Value
	if v2:CanUseBudget(1) then
		local Magnitude = (CurrentCamera.CFrame.p - _obj.Value.p).Magnitude
		if v12 or not (Magnitude < DestructibleConsts.MAX_DIST_TO_LOAD) then
			if v12 and DestructibleConsts.MAX_DIST_TO_LOAD < Magnitude then
				v2:UseBudget(1)
				v12:Destroy()
			end
		else
			v2:UseBudget(1)
			local v22 = Maid.new()
			_maid._instMaid = v22
			v22:GiveTask(function()
				p1._wasTouched = false
			end)
			local v3 = ReplicatedStorage:FindFirstChild(DestructibleConsts.PREFAB_FOLDER_NAME):FindFirstChild(_obj.Name):Clone()
			v3:SetPrimaryPartCFrame(_obj.Value)
			v3.Parent = v1
			_instValue.Value = v3
			v22:GiveTask(v3.PrimaryPart.Touched:Connect(function(p12)
				if p12:IsDescendantOf(v1) then
				elseif p12:IsDescendantOf(workspace:FindFirstChild("Vehicles")) then
					if not p1._wasTouched then
						p1._wasTouched = true
						local Position = p12.Position
						p1._broadcastCollideRemote:FireServer(Position)
						p1:_handleHitPosition(Position)
					end
				end
			end))
			v22:GiveTask(v3.AncestryChanged:Connect(function(p1, p2)
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
