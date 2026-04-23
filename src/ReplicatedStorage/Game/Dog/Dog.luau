local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Audio = require(ReplicatedStorage.Std.Audio)
local Maid = require(ReplicatedStorage.Std.Maid)
local Spring = require(ReplicatedStorage.Std.Spring)
local DogConsts = require(ReplicatedStorage.Game.Dog.DogConsts)
local Promise = require(ReplicatedStorage.Std.Promise)
local Interval = require(ReplicatedStorage.Std.Interval)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local DogSystem = require(script.Parent.DogSystem)
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 29 | Upvalues: t (copy), Maid (copy), DogConsts (copy), Spring (copy), RunService (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._obj = p1
	t2._mapAnimTrack = {}
	t2._damageRemote = p1:WaitForChild(DogConsts.DAMAGE_REMOTE_NAME)
	t2._breedIdValue = p1:WaitForChild(DogConsts.BREED_ID_VALUE_NAME)
	t2._animController = p1:WaitForChild("AnimationController")
	while not p1.PrimaryPart do
		task.wait(0.01)
	end
	t2._bodyVelocity = p1.PrimaryPart:WaitForChild(DogConsts.BODY_VELOCITY_NAME)
	t2._bodyGyro = p1.PrimaryPart:WaitForChild(DogConsts.BODY_GYRO_NAME)
	t2:SetSpeed(0)
	t2:SetDirection((Vector3.new()))
	t2:SetAnimSpeed(0)
	t2._stateId = nil
	t2._attackStateId = DogConsts.ATTACK_STATE.TO
	t2._animStateId = nil
	t2._animTrack = nil
	t2._goalPos = nil
	t2._targetSpeedSpring = Spring.new(0, 0, 1, 1)
	t2._lastUpdate = os.clock()
	t2._lastJump = os.clock()
	t2._lastAttack = os.clock()
	t2._lastAttackSend = os.clock()
	t2._lastAnimTransition = os.clock()
	t2._lastDiscoverOpp = os.clock()
	t2._lastDiscoverDog = os.clock()
	t2._lastStuckAt = os.clock()
	t2._ownerIdValue = p1:WaitForChild(DogConsts.OWNER_ID_VALUE_NAME)
	t2._maid:GiveTask(t2._ownerIdValue.Changed:Connect(function() --[[ Line: 66 | Upvalues: t2 (copy) ]]
		t2:_updateOwner()
	end))
	t2:_updateOwner()
	t2._targetIdValue = p1:WaitForChild(DogConsts.TARGET_ID_VALUE_NAME)
	t2._maid:GiveTask(t2._targetIdValue.Changed:Connect(function() --[[ Line: 72 | Upvalues: t2 (copy) ]]
		t2:_updateTarget()
	end))
	t2:_updateTarget()
	t2._maid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 77 | Upvalues: t2 (copy) ]]
		t2:_updateAnimSpeed()
	end))
	t2._barkRemote = p1:WaitForChild(DogConsts.BARK_REMOTE_NAME)
	t2._maid:GiveTask(t2._barkRemote.OnClientEvent:Connect(function() --[[ Line: 82 | Upvalues: t2 (copy) ]]
		t2:_bark()
	end))
	t2._animRemote = p1:WaitForChild(DogConsts.ANIM_REMOTE_NAME)
	t2._maid:GiveTask(t2._animRemote.OnClientEvent:Connect(function(p1) --[[ Line: 87 | Upvalues: t2 (copy) ]]
		t2:_playAnim(p1)
	end))
	t2._isMountedValue = p1:WaitForChild(DogConsts.IS_MOUNTED_NAME)
	t2._maid:GiveTask(t2._isMountedValue.Changed:Connect(function(p1) --[[ Line: 92 | Upvalues: t2 (copy), DogConsts (ref) ]]
		if p1 then
			t2:SetAnimation(DogConsts.ANIM_STATE.REST)
		else
			t2._obj:SetPrimaryPartCFrame(t2._obj.PrimaryPart.CFrame * CFrame.new(0, 10, 0))
		end
		t2:_setEnabled(not p1)
	end))
	t2._giveUpRemote = p1:WaitForChild(DogConsts.GIVE_UP_REMOTE_NAME)
	t2._lastGiveUpSend = os.clock()
	t2:_updateBreed(t2._breedIdValue.Value)
	t2._maid:GiveTask(t2._breedIdValue.Changed:Connect(function(p1) --[[ Line: 106 | Upvalues: t2 (copy) ]]
		t2:_updateBreed(p1)
	end))
	t2:SetState(DogConsts.STATE.FOLLOW)
	t2:SetAnimation(DogConsts.ANIM_STATE.IDLE)
	local Collider = t2._obj:FindFirstChild("Collider")
	if not Collider then
		error("Dog is missing `Collider` part.")
	end
	t2._collider = Collider
	t2:_setEnabled(true)
	return t2
end
function t._setEnabled(p1, p2) --[[ Line: 123 ]]
	p1._enabled = p2
end
function t._setForcesEnabled(p1, p2) --[[ Line: 126 | Upvalues: DogConsts (copy) ]]
	if p2 then
		p1._bodyVelocity.MaxForce = DogConsts.BODY_VELOCITY_MAX_FORCE
		p1._bodyGyro.MaxTorque = DogConsts.BODY_GYRO_MAX_TORQUE
	else
		p1._bodyVelocity.MaxForce = Vector3.new()
		p1._bodyGyro.MaxTorque = Vector3.new()
	end
end
function t._updateBreed(p1, p2) --[[ Line: 135 ]]
	assert(p2 ~= nil)
	p1:_loadAnimations(p2)
end
function t._loadAnimations(p1, p2) --[[ Line: 139 | Upvalues: DogConsts (copy), DogSystem (copy) ]]
	assert(p2 ~= nil)
	assert(p1._mapAnimTrack[DogConsts.ANIM_STATE.WALK] == nil)
	for k, v in pairs(DogSystem.getAnimInsts(p2)) do
		p1._mapAnimTrack[k] = p1._animController:LoadAnimation(v)
	end
end
function t._getAnimTrack(p1, p2) --[[ Line: 148 ]]
	local v1 = p1._mapAnimTrack[p2]
	if v1 then
		return v1
	end
end
function t._updateOwner(p1) --[[ Line: 156 | Upvalues: Maid (copy), LocalPlayer (copy), RunService (copy), Interval (copy), PlayerUtils (copy), DogConsts (copy), VehicleUtils (copy) ]]
	local v1 = p1:GetOwner()
	if v1 then
		local v2 = Maid.new()
		p1._maid.ownerMaid = v2
		if v1 == LocalPlayer then
			v2:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 163 | Upvalues: p1 (copy) ]]
				p1:_updateLocalOwner()
			end))
			v2:GiveTask(p1._obj.Mouth.Touched:Connect(function(...) --[[ Line: 166 | Upvalues: p1 (copy) ]]
				p1:_onMouthTouched(...)
			end))
			v2:GiveTask(Interval.every(1):Connect(function() --[[ Line: 169 | Upvalues: PlayerUtils (ref), v1 (copy), p1 (copy), DogConsts (ref) ]]
				local v12 = PlayerUtils.getRootPart(v1)
				if v12 and (p1._stateId ~= DogConsts.STATE.ATTACK and ((v12.Position - p1._obj.PrimaryPart.Position).Magnitude > DogConsts.TELEPORT_AFTER_DIST or os.clock() - p1._lastStuckAt > DogConsts.TELEPORT_AFTER_STUCK_FOR)) then
					p1._obj:SetPrimaryPartCFrame(v12.CFrame * CFrame.new(0, 10, 5))
				end
			end))
			p1._maid:GiveTask(VehicleUtils.OnVehicleEntered:Connect(function(p12, p2) --[[ Line: 187 | Upvalues: p1 (copy) ]]
				if p2 then
				elseif p12.Model:FindFirstChild("DogSit") then
					p1:_setEnabled(false)
					p1:_setForcesEnabled(false)
				end
			end))
			p1._maid:GiveTask(VehicleUtils.OnVehicleExited:Connect(function(p12, p2) --[[ Line: 198 | Upvalues: p1 (copy) ]]
				if p2 then
				elseif p12.Model:FindFirstChild("DogSit") then
					p1:_setEnabled(true)
					p1:_setForcesEnabled(true)
				end
			end))
			p1:_setEnabled(true)
			p1:_setForcesEnabled(true)
			v2:GiveTask(function() --[[ Line: 212 | Upvalues: p1 (copy) ]]
				p1:_setEnabled(false)
				p1:_setForcesEnabled(false)
			end)
		end
	else
		p1._maid.ownerMaid = nil
	end
end
function t._updateTarget(p1) --[[ Line: 221 | Upvalues: DogConsts (copy) ]]
	if p1:GetTarget() then
		p1:SetState(DogConsts.STATE.ATTACK)
	else
		p1:SetState(DogConsts.STATE.FOLLOW)
	end
end
function t._onMouthTouched(p1, p2) --[[ Line: 229 ]]
	local v1 = os.clock()
	local v2 = p1:GetTarget()
	if v2 and (p2:IsDescendantOf(v2.Character) and (v1 - p1._lastAttack < 2 and v1 - p1._lastAttackSend > 1)) then
		p1._lastAttackSend = v1
		p1._damageRemote:FireServer()
	end
end
function t.GetBreedId(p1) --[[ Line: 243 ]]
	return p1._breedIdValue.Value
end
function t._playAnim(p1, p2) --[[ Line: 247 ]]
	local v1 = p1:_getAnimTrack(p2)
	if v1 then
		v1:Play(0.25)
	end
end
function t._playAnimNetwork(p1, p2) --[[ Line: 253 ]]
	p1:_playAnim(p2)
	p1._animRemote:FireServer(p2)
end
function t.SetAnimation(p1, p2) --[[ Line: 257 | Upvalues: DogConsts (copy), PlayerUtils (copy), DogSystem (copy), LocalPlayer (copy), Promise (copy) ]]
	assert(p2 ~= p1._animStateId)
	if p1._animTrack ~= nil then
		local _animTrack = p1._animTrack
		p1._animTrack = nil
		_animTrack:Stop(0.25)
	end
	p1._animStateId = p2
	p1._animTrack = p1:_getAnimTrack(p2)
	if p1._animTrack then
		p1._animTrack:Play(0.25)
	end
	if p2 == DogConsts.ANIM_STATE.PET then
		local v1 = p1:GetOwner()
		if PlayerUtils.getHumanoid(v1) then
			local v2 = DogSystem.getPetTrack()
			if v2 and v1 == LocalPlayer then
				v2:Play(0.25)
				local v3 = nil
				v3 = v2.Stopped:Connect(function() --[[ Line: 281 | Upvalues: v3 (ref), p1 (copy), DogConsts (ref) ]]
					v3:Disconnect()
					p1:SetAnimation(DogConsts.ANIM_STATE.IDLE_PLAY)
				end)
			elseif v2 then
				Promise.delay(v2.Length):andThen(function() --[[ Line: 286 | Upvalues: p1 (copy), DogConsts (ref) ]]
					p1:SetAnimation(DogConsts.ANIM_STATE.IDLE_PLAY)
				end)
			end
		end
	elseif p2 == DogConsts.ANIM_STATE.IDLE_PLAY then
		Promise.delay(1):andThen(function() --[[ Line: 293 | Upvalues: p1 (copy), DogConsts (ref) ]]
			p1:SetAnimation(DogConsts.ANIM_STATE.IDLE)
			p1:_updateTarget()
		end)
	end
	local v5 = DogConsts.ANIM_SPS[p1:GetBreedId()][p1._animStateId]
	if v5 and p1._animTrack then
		p1._animTrack:AdjustSpeed(p1._speed / v5)
	end
	p1._lastAnimTransition = os.clock()
end
function t._bark(p1) --[[ Line: 309 | Upvalues: DogConsts (copy), Audio (copy) ]]
	if p1._animStateId == DogConsts.ANIM_STATE.REST then
		p1:SetAnimation(DogConsts.ANIM_STATE.IDLE)
	end
	p1:_playAnim(DogConsts.ANIM_STATE.BARK)
	Audio.ObjectLocal(p1._obj.PrimaryPart, DogConsts.BARK_SOUND_ID[p1:GetBreedId()], {
		Volume = 0.3,
		Pitch = 1 + 0.1 * math.random()
	})
end
function t.Bark(p1) --[[ Line: 320 ]]
	p1._barkRemote:FireServer()
	p1:_bark()
end
function t.SetState(p1, p2) --[[ Line: 324 | Upvalues: DogConsts (copy) ]]
	assert(p2 ~= nil)
	if p2 == DogConsts.STATE.ATTACK then
		p1._attackStateId = DogConsts.ATTACK_STATE.TO
		p1._goToPosition = nil
	end
	p1._stateId = p2
end
function t.DistanceTo(p1, p2) --[[ Line: 333 ]]
	return ((p2 - p1._obj.PrimaryPart.Position) * Vector3.new(1, 0, 1)).Magnitude
end
function t._getGoalRootPart(p1) --[[ Line: 337 | Upvalues: DogConsts (copy), PlayerUtils (copy) ]]
	local v1 = nil
	if p1._stateId == DogConsts.STATE.ATTACK then
		v1 = p1:GetTarget()
	elseif p1._stateId == DogConsts.STATE.FOLLOW then
		v1 = p1:GetOwner()
	end
	if v1 then
		return PlayerUtils.getRootPart(v1)
	end
end
function t._getGoalPos(p1) --[[ Line: 349 | Upvalues: DogConsts (copy) ]]
	local v1 = p1:_getGoalRootPart()
	if v1 and p1._stateId == DogConsts.STATE.ATTACK then
		if p1._attackStateId == DogConsts.ATTACK_STATE.TO then
			return v1.Position + v1.Velocity * DogConsts.ATTACK_LEAD_TIME
		end
		if p1._attackStateId == DogConsts.ATTACK_STATE.AWAY then
			return p1._goToPosition
		end
	elseif v1 and p1._stateId == DogConsts.STATE.FOLLOW then
		local _lastRootPartPos = p1._lastRootPartPos
		local Position = v1.Position
		local v2 = false
		if _lastRootPartPos and (Position - _lastRootPartPos).Magnitude > 0.1 or not (p1._goalPos and _lastRootPartPos) then
			v2 = true
		end
		if v2 then
			p1._lastRootPartPos = Position
			local v3 = v1.CFrame * Vector3.new(-4, 0, 1)
			local v4 = v1.CFrame * Vector3.new(4, 0, 1)
			if p1:DistanceTo(v3) < p1:DistanceTo(v4) then
				return v3
			else
				return v4
			end
		else
			return p1._goalPos
		end
	elseif v1 and (p1._stateId ~= DogConsts.STATE.REST and p1._stateId ~= DogConsts.STATE.PET) then
		error("Invalid state")
	end
end
function t._getTargetSpeed(p1, p2, p3) --[[ Line: 398 ]]
	local v1
	if p1._goalPos then
		local v2 = (p2 - p1._goalPos).Magnitude / p3
		local v3 = p1._targetSpeedSpring:SetTarget(v2)
		if v3 < v2 then
			p1._targetSpeedSpring.Freq = 3
			return v3
		end
		p1._targetSpeedSpring.Freq = 10
		v1 = v3
	else
		v1 = 0
	end
	return v1
end
function t._getGoalSpeed(p1, p2) --[[ Line: 413 | Upvalues: DogConsts (copy) ]]
	local v2 = DogConsts.TOP_SPEED[p1:GetBreedId()]
	if p1._stateId == DogConsts.STATE.ATTACK then
		return v2 * 0.8
	end
	if p1._stateId == DogConsts.STATE.FOLLOW then
		local v3
		if p2 >= 1 then
			local v5 = (p2 - 6) / 122
			v3 = math.max(p1._targetSpeed + p2 / 5, (1 - v5) * 10 + v5 * v2)
		else
			v3 = 0
		end
		if v3 <= 4 then
			v3 = 0
		end
		return math.clamp(v3, 0, v2)
	end
end
function t.Jump(p1) --[[ Line: 438 ]]
	if p1._enabled then
		p1._lastJump = os.clock()
		p1._obj.PrimaryPart.Velocity = Vector3.new(0, 30, 0)
	end
end
function t._getNearestDog(p1, p2) --[[ Line: 446 | Upvalues: PlayerUtils (copy), DogSystem (copy) ]]
	local v1 = p1:GetOwner()
	local v2 = PlayerUtils.getRootPart(v1)
	if v2 then
		local v3 = p2 or (1 / 0)
		local v4 = nil
		for i, v in ipairs(DogSystem.getAll()) do
			if v ~= p1 and v:GetOwner().TeamValue.Value ~= v1.TeamValue.Value then
				local Magnitude = (v._obj.PrimaryPart.Position - v2.Position).Magnitude
				if Magnitude < v3 then
					v3 = Magnitude
					v4 = v
				end
			end
		end
		return v4
	end
end
function t._getNearestOpp(p1, p2) --[[ Line: 471 | Upvalues: PlayerUtils (copy), Players (copy) ]]
	local v1 = p1:GetOwner()
	local v2 = PlayerUtils.getRootPart(v1)
	if v2 then
		local v3 = p2 or (1 / 0)
		local v4 = nil
		for i, v in ipairs(Players:GetPlayers()) do
			if v ~= v1 and v.TeamValue.Value ~= v1.TeamValue.Value then
				local v5 = PlayerUtils.getRootPart(v)
				if v5 then
					local Magnitude = (v5.Position - v2.Position).Magnitude
					if Magnitude < v3 then
						v3 = Magnitude
						v4 = v
					end
				end
			end
		end
		return v4
	end
end
function t._updateAnimSpeed(p1) --[[ Line: 499 | Upvalues: PlayerUtils (copy), DogConsts (copy) ]]
	if p1._enabled then
		local v2 = PlayerUtils.getRootPart((p1:GetOwner()))
		if v2 then
			local PrimaryPart = p1._obj.PrimaryPart
			if p1._stateId == DogConsts.STATE.REST or p1._stateId == DogConsts.STATE.PET then
				local v3 = PrimaryPart.Position - v2.Position
				local Magnitude = v3.Magnitude
				local v4 = v3.Unit:Dot(v2.CFrame.LookVector)
				if Magnitude > 8 then
					p1:_updateTarget()
				elseif Magnitude < 4 and (v4 > 0.75 and p1._stateId ~= DogConsts.STATE.PET) then
					p1:SetAnimation(DogConsts.ANIM_STATE.PET)
					p1:SetState(DogConsts.STATE.PET)
				end
			end
			if p1._stateId == DogConsts.STATE.FOLLOW or p1._stateId == DogConsts.STATE.ATTACK then
				local Magnitude = PrimaryPart.Velocity.Magnitude
				if Magnitude < 1 then
					Magnitude = 0
				end
				if math.abs(Magnitude - p1._animSpeed) > 1 or p1._animSpeed ~= 0 and Magnitude == 0 then
					p1:SetAnimSpeed(Magnitude)
				end
			end
			if p1._stateId == DogConsts.STATE.FOLLOW and (p1._animStateId == DogConsts.ANIM_STATE.IDLE and os.clock() - p1._lastAnimTransition > 6) then
				p1:SetState(DogConsts.STATE.REST)
				p1:SetAnimation(DogConsts.ANIM_STATE.REST)
			end
		end
	end
end
function t._discoverDog(p1) --[[ Line: 550 | Upvalues: DogConsts (copy) ]]
	local v1 = os.clock()
	local PrimaryPart = p1._obj.PrimaryPart
	p1._lastDiscoverDog = v1
	local v2 = p1:_getNearestDog(DogConsts.CONFUSION_OPP_RADIUS)
	if v2 then
		p1:SetDirection(((v2._obj.PrimaryPart.Position - PrimaryPart.Position) * Vector3.new(1, 0, 1)).Unit)
		p1:Bark()
		p1:_playAnimNetwork(DogConsts.ANIM_STATE.POINT)
		return true
	end
end
function t._discoverOpp(p1) --[[ Line: 567 | Upvalues: DogConsts (copy), PlayerUtils (copy) ]]
	local v1 = os.clock()
	local PrimaryPart = p1._obj.PrimaryPart
	p1._lastDiscoverOpp = v1
	local v2 = p1:_getNearestOpp(DogConsts.BARK_OPP_RADIUS)
	if v2 then
		p1:_barkAt(((PlayerUtils.getRootPart(v2).Position - PrimaryPart.Position) * Vector3.new(1, 0, 1)).Unit)
		return true
	end
end
function t._barkAt(p1, p2) --[[ Line: 581 | Upvalues: DogConsts (copy) ]]
	assert(math.abs(p2.Magnitude - 1) < 0.001)
	p1:SetDirection(p2)
	p1:Bark()
	p1:_playAnimNetwork(DogConsts.ANIM_STATE.POINT)
end
function t._updateLocalOwner(p1) --[[ Line: 590 | Upvalues: DogConsts (copy), RayCast (copy), Promise (copy), PlayerUtils (copy) ]]
	if p1._enabled then
		local v1 = os.clock()
		local v2 = v1 - p1._lastUpdate
		p1._lastUpdate = v1
		if p1._stateId == DogConsts.STATE.FOLLOW or p1._stateId == DogConsts.STATE.ATTACK then
			local v3 = p1:_getGoalPos()
			if v3 then
				p1._targetSpeed = p1:_getTargetSpeed(v3, v2)
				p1._goalPos = v3
				local PrimaryPart = p1._obj.PrimaryPart
				local v4 = (v3 - PrimaryPart.Position) * Vector3.new(1, 0, 1)
				local Magnitude = v4.Magnitude
				local v5 = p1:_getGoalSpeed(Magnitude)
				p1:SetSpeed(v5)
				if v5 > 0 then
					p1:SetDirection(v4.Unit)
				end
				local v6 = if p1:GetBreedId() == DogConsts.ENUM_BREED.GERMAN then -1 else 1
				p1._bodyGyro.CFrame = CFrame.new(Vector3.new(), p1._direction * v6) + PrimaryPart.Position
				p1._bodyVelocity.Velocity = PrimaryPart.CFrame.LookVector * v6 * p1._speed
				if v5 * 0.5 < math.abs((PrimaryPart.Velocity:Dot(PrimaryPart.CFrame.LookVector))) or v5 < 5 then
					p1._lastStuckAt = v1
				end
				if v1 - p1._lastStuckAt > 0.1 and v1 - p1._lastJump > 0.5 then
					p1:Jump()
				end
				if p1._stateId == DogConsts.STATE.ATTACK then
					if p1._attackStateId == DogConsts.ATTACK_STATE.TO then
						local ATTACK_LEAD_TIME = DogConsts.ATTACK_LEAD_TIME
						if Magnitude <= v5 * ATTACK_LEAD_TIME and not p1._goToPosition then
							local v8 = math.random() * 8 + 16
							if math.random() > 0.5 then
								v8 = -v8
							end
							local v9 = math.random() * 8 + 16
							if math.random() > 0.5 then
								v9 = -v9
							end
							local v10 = v3 + Vector3.new(v8, 0, v9)
							local Position = PrimaryPart.Position
							local _, v12 = RayCast.RayIgnoreNonCollideWithIgnoreList(Position, (v10 - Position).Unit, (v10 - Position).Magnitude, { p1._obj, p1:_getGoalRootPart().Parent })
							p1._goToPosition = v12
							p1._lastAttack = os.clock()
							p1:Jump()
							p1:Bark()
							Promise.delay(ATTACK_LEAD_TIME):andThen(function() --[[ Line: 669 | Upvalues: p1 (copy), DogConsts (ref) ]]
								p1._attackStateId = DogConsts.ATTACK_STATE.AWAY
							end)
						end
					elseif p1._attackStateId == DogConsts.ATTACK_STATE.AWAY and Magnitude <= 10 then
						p1._goToPosition = nil
						p1._attackStateId = DogConsts.ATTACK_STATE.TO
					end
					if DogConsts.GIVE_UP_AFTER_DIST < Magnitude and v1 - p1._lastGiveUpSend > 1 then
						p1._lastGiveUpSend = v1
						p1._giveUpRemote:FireServer()
					end
				end
			else
				return
			end
		else
			p1._lastStuckAt = v1
		end
		if (p1._animStateId == DogConsts.ANIM_STATE.IDLE or p1._animStateId == DogConsts.ANIM_STATE.REST) and v1 - p1._lastAnimTransition > 1.5 then
			local PrimaryPart = p1._obj.PrimaryPart
			local v13 = p1:_getNearestDog(DogConsts.BARK_CONFUSION_RADIUS)
			if v13 then
				if v1 - p1._lastDiscoverDog > 1 then
					p1._lastDiscoverDog = v1
					p1:_barkAt(((v13._obj.PrimaryPart.Position - PrimaryPart.Position) * Vector3.new(1, 0, 1)).Unit)
				end
			else
				local v14 = p1:_getNearestOpp(DogConsts.BARK_OPP_RADIUS)
				if v14 and v1 - p1._lastDiscoverOpp > 10 then
					p1._lastDiscoverOpp = v1
					p1:_barkAt(((PlayerUtils.getRootPart(v14).Position - PrimaryPart.Position) * Vector3.new(1, 0, 1)).Unit)
				end
			end
		end
		if p1._stateId == DogConsts.STATE.ATTACK and (v1 - p1._lastStuckAt > DogConsts.GIVE_UP_AFTER_STUCK_FOR and v1 - p1._lastGiveUpSend > 1) then
			p1._lastGiveUpSend = v1
			p1._giveUpRemote:FireServer()
		end
	end
end
function t.SetDirection(p1, p2) --[[ Line: 729 ]]
	p1._direction = p2
end
function t.SetSpeed(p1, p2) --[[ Line: 732 ]]
	if p2 < 0 then
		p2 = 0
	end
	p1._speed = p2
end
function t.SetAnimSpeed(p1, p2) --[[ Line: 738 | Upvalues: DogConsts (copy) ]]
	p1._animSpeed = p2
	if p2 > 21 then
		if p1._animStateId ~= DogConsts.ANIM_STATE.SPRINT then
			p1:SetAnimation(DogConsts.ANIM_STATE.SPRINT)
		end
	elseif p2 > 0.01 then
		if p1._animStateId ~= DogConsts.ANIM_STATE.WALK then
			p1:SetAnimation(DogConsts.ANIM_STATE.WALK)
		end
	elseif p1._animStateId ~= DogConsts.ANIM_STATE.IDLE then
		p1:SetAnimation(DogConsts.ANIM_STATE.IDLE)
	end
	if p1._animStateId then
		local v2 = DogConsts.ANIM_SPS[p1:GetBreedId()][p1._animStateId]
		if v2 and p1._animTrack then
			if p2 <= 0.01 then
				p2 = 0.01
			end
			p1._animTrack:AdjustSpeed(p2 / v2)
		end
	end
end
function t.GetOwner(p1) --[[ Line: 766 | Upvalues: Players (copy) ]]
	local _ownerIdValue = p1._ownerIdValue
	if _ownerIdValue then
		return Players:GetPlayerByUserId(_ownerIdValue.Value)
	end
end
function t.GetTarget(p1) --[[ Line: 775 | Upvalues: Players (copy) ]]
	local _targetIdValue = p1._targetIdValue
	if _targetIdValue then
		return Players:GetPlayerByUserId(_targetIdValue.Value)
	end
end
function t.Destroy(p1) --[[ Line: 784 ]]
	local _maid = p1._maid
	assert(_maid ~= nil)
	p1._maid = nil
	_maid:Destroy()
end
return t