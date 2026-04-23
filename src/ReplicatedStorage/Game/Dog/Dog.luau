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
local Dog = {}
Dog.__index = Dog
function Dog.new(model)
	local self = {}
	setmetatable(self, Dog)
	self._maid = Maid.new()
	self._obj = model
	self._mapAnimTrack = {}
	self._damageRemote = model:WaitForChild(DogConsts.DAMAGE_REMOTE_NAME)
	self._breedIdValue = model:WaitForChild(DogConsts.BREED_ID_VALUE_NAME)
	self._animController = model:WaitForChild("AnimationController")
	while not model.PrimaryPart do
		task.wait(0.01)
	end
	self._bodyVelocity = model.PrimaryPart:WaitForChild(DogConsts.BODY_VELOCITY_NAME)
	self._bodyGyro = model.PrimaryPart:WaitForChild(DogConsts.BODY_GYRO_NAME)
	self:SetSpeed(0)
	self:SetDirection((Vector3.new()))
	self:SetAnimSpeed(0)
	self._stateId = nil
	self._attackStateId = DogConsts.ATTACK_STATE.TO
	self._animStateId = nil
	self._animTrack = nil
	self._goalPos = nil
	self._targetSpeedSpring = Spring.new(0, 0, 1, 1)
	self._lastUpdate = os.clock()
	self._lastJump = os.clock()
	self._lastAttack = os.clock()
	self._lastAttackSend = os.clock()
	self._lastAnimTransition = os.clock()
	self._lastDiscoverOpp = os.clock()
	self._lastDiscoverDog = os.clock()
	self._lastStuckAt = os.clock()
	self._ownerIdValue = model:WaitForChild(DogConsts.OWNER_ID_VALUE_NAME)
	self._maid:GiveTask(self._ownerIdValue.Changed:Connect(function()
		self:_updateOwner()
	end))
	self:_updateOwner()
	self._targetIdValue = model:WaitForChild(DogConsts.TARGET_ID_VALUE_NAME)
	self._maid:GiveTask(self._targetIdValue.Changed:Connect(function()
		self:_updateTarget()
	end))
	self:_updateTarget()
	self._maid:GiveTask(RunService.Heartbeat:Connect(function()
		self:_updateAnimSpeed()
	end))
	self._barkRemote = model:WaitForChild(DogConsts.BARK_REMOTE_NAME)
	self._maid:GiveTask(self._barkRemote.OnClientEvent:Connect(function()
		self:_bark()
	end))
	self._animRemote = model:WaitForChild(DogConsts.ANIM_REMOTE_NAME)
	self._maid:GiveTask(self._animRemote.OnClientEvent:Connect(function(animStateId)
		self:_playAnim(animStateId)
	end))
	self._isMountedValue = model:WaitForChild(DogConsts.IS_MOUNTED_NAME)
	self._maid:GiveTask(self._isMountedValue.Changed:Connect(function(isMounted)
		if isMounted then
			self:SetAnimation(DogConsts.ANIM_STATE.REST)
		else
			self._obj:SetPrimaryPartCFrame(self._obj.PrimaryPart.CFrame * CFrame.new(0, 10, 0))
		end
		self:_setEnabled(not isMounted)
	end))
	self._giveUpRemote = model:WaitForChild(DogConsts.GIVE_UP_REMOTE_NAME)
	self._lastGiveUpSend = os.clock()
	self:_updateBreed(self._breedIdValue.Value)
	self._maid:GiveTask(self._breedIdValue.Changed:Connect(function(newBreedId)
		self:_updateBreed(newBreedId)
	end))
	self:SetState(DogConsts.STATE.FOLLOW)
	self:SetAnimation(DogConsts.ANIM_STATE.IDLE)
	local Collider = self._obj:FindFirstChild("Collider")
	if not Collider then
		error("Dog is missing `Collider` part.")
	end
	self._collider = Collider
	self:_setEnabled(true)
	return self
end
function Dog._setEnabled(self, enabled)
	self._enabled = enabled
end
function Dog._setForcesEnabled(self, enabled)
	if enabled then
		self._bodyVelocity.MaxForce = DogConsts.BODY_VELOCITY_MAX_FORCE
		self._bodyGyro.MaxTorque = DogConsts.BODY_GYRO_MAX_TORQUE
	else
		self._bodyVelocity.MaxForce = Vector3.new()
		self._bodyGyro.MaxTorque = Vector3.new()
	end
end
function Dog._updateBreed(self, breedId)
	assert(breedId ~= nil)
	self:_loadAnimations(breedId)
end
function Dog._loadAnimations(self, breedId)
	assert(breedId ~= nil)
	assert(self._mapAnimTrack[DogConsts.ANIM_STATE.WALK] == nil)
	for k, v in pairs(DogSystem.getAnimInsts(breedId)) do
		self._mapAnimTrack[k] = self._animController:LoadAnimation(v)
	end
end
function Dog._getAnimTrack(self, animStateId)
	local track = self._mapAnimTrack[animStateId]
	if track then
		return track
	end
end
function Dog._updateOwner(self)
	local owner = self:GetOwner()
	if owner then
		local ownerMaid = Maid.new()
		self._maid.ownerMaid = ownerMaid
		if owner == LocalPlayer then
			ownerMaid:GiveTask(RunService.Heartbeat:Connect(function()
				self:_updateLocalOwner()
			end))
			ownerMaid:GiveTask(self._obj.Mouth.Touched:Connect(function(...)
				self:_onMouthTouched(...)
			end))
			ownerMaid:GiveTask(Interval.every(1):Connect(function()
				local rootPart = PlayerUtils.getRootPart(owner)
				if rootPart and (self._stateId ~= DogConsts.STATE.ATTACK and ((rootPart.Position - self._obj.PrimaryPart.Position).Magnitude > DogConsts.TELEPORT_AFTER_DIST or os.clock() - self._lastStuckAt > DogConsts.TELEPORT_AFTER_STUCK_FOR)) then
					self._obj:SetPrimaryPartCFrame(rootPart.CFrame * CFrame.new(0, 10, 5))
				end
			end))
			self._maid:GiveTask(VehicleUtils.OnVehicleEntered:Connect(function(vehicle, isEntering)
				if isEntering then
				elseif vehicle.Model:FindFirstChild("DogSit") then
					self:_setEnabled(false)
					self:_setForcesEnabled(false)
				end
			end))
			self._maid:GiveTask(VehicleUtils.OnVehicleExited:Connect(function(vehicle, isExiting)
				if isExiting then
				elseif vehicle.Model:FindFirstChild("DogSit") then
					self:_setEnabled(true)
					self:_setForcesEnabled(true)
				end
			end))
			self:_setEnabled(true)
			self:_setForcesEnabled(true)
			ownerMaid:GiveTask(function()
				self:_setEnabled(false)
				self:_setForcesEnabled(false)
			end)
		end
	else
		self._maid.ownerMaid = nil
	end
end
function Dog._updateTarget(self)
	if self:GetTarget() then
		self:SetState(DogConsts.STATE.ATTACK)
	else
		self:SetState(DogConsts.STATE.FOLLOW)
	end
end
function Dog._onMouthTouched(self, touchedPart)
	local now = os.clock()
	local target = self:GetTarget()
	if target and (touchedPart:IsDescendantOf(target.Character) and (now - self._lastAttack < 2 and now - self._lastAttackSend > 1)) then
		self._lastAttackSend = now
		self._damageRemote:FireServer()
	end
end
function Dog.GetBreedId(self)
	return self._breedIdValue.Value
end
function Dog._playAnim(self, animStateId)
	local track = self:_getAnimTrack(animStateId)
	if track then
		track:Play(0.25)
	end
end
function Dog._playAnimNetwork(self, animStateId)
	self:_playAnim(animStateId)
	self._animRemote:FireServer(animStateId)
end
function Dog.SetAnimation(self, animStateId)
	assert(animStateId ~= self._animStateId)
	if self._animTrack ~= nil then
		local prevTrack = self._animTrack
		self._animTrack = nil
		prevTrack:Stop(0.25)
	end
	self._animStateId = animStateId
	self._animTrack = self:_getAnimTrack(animStateId)
	if self._animTrack then
		self._animTrack:Play(0.25)
	end
	if animStateId == DogConsts.ANIM_STATE.PET then
		local owner = self:GetOwner()
		if PlayerUtils.getHumanoid(owner) then
			local petTrack = DogSystem.getPetTrack()
			if petTrack and owner == LocalPlayer then
				petTrack:Play(0.25)
				local stoppedConn = nil
				stoppedConn = petTrack.Stopped:Connect(function()
					stoppedConn:Disconnect()
					self:SetAnimation(DogConsts.ANIM_STATE.IDLE_PLAY)
				end)
			elseif petTrack then
				Promise.delay(petTrack.Length):andThen(function()
					self:SetAnimation(DogConsts.ANIM_STATE.IDLE_PLAY)
				end)
			end
		end
	elseif animStateId == DogConsts.ANIM_STATE.IDLE_PLAY then
		Promise.delay(1):andThen(function()
			self:SetAnimation(DogConsts.ANIM_STATE.IDLE)
			self:_updateTarget()
		end)
	end
	local animSps = DogConsts.ANIM_SPS[self:GetBreedId()][self._animStateId]
	if animSps and self._animTrack then
		self._animTrack:AdjustSpeed(self._speed / animSps)
	end
	self._lastAnimTransition = os.clock()
end
function Dog._bark(self)
	if self._animStateId == DogConsts.ANIM_STATE.REST then
		self:SetAnimation(DogConsts.ANIM_STATE.IDLE)
	end
	self:_playAnim(DogConsts.ANIM_STATE.BARK)
	Audio.ObjectLocal(self._obj.PrimaryPart, DogConsts.BARK_SOUND_ID[self:GetBreedId()], {
		Volume = 0.3,
		Pitch = 1 + 0.1 * math.random()
	})
end
function Dog.Bark(self)
	self._barkRemote:FireServer()
	self:_bark()
end
function Dog.SetState(self, stateId)
	assert(stateId ~= nil)
	if stateId == DogConsts.STATE.ATTACK then
		self._attackStateId = DogConsts.ATTACK_STATE.TO
		self._goToPosition = nil
	end
	self._stateId = stateId
end
function Dog.DistanceTo(self, position)
	return ((position - self._obj.PrimaryPart.Position) * Vector3.new(1, 0, 1)).Magnitude
end
function Dog._getGoalRootPart(self)
	local goalPlayer = nil
	if self._stateId == DogConsts.STATE.ATTACK then
		goalPlayer = self:GetTarget()
	elseif self._stateId == DogConsts.STATE.FOLLOW then
		goalPlayer = self:GetOwner()
	end
	if goalPlayer then
		return PlayerUtils.getRootPart(goalPlayer)
	end
end
function Dog._getGoalPos(self)
	local goalRootPart = self:_getGoalRootPart()
	if goalRootPart and self._stateId == DogConsts.STATE.ATTACK then
		if self._attackStateId == DogConsts.ATTACK_STATE.TO then
			return goalRootPart.Position + goalRootPart.Velocity * DogConsts.ATTACK_LEAD_TIME
		end
		if self._attackStateId == DogConsts.ATTACK_STATE.AWAY then
			return self._goToPosition
		end
	elseif goalRootPart and self._stateId == DogConsts.STATE.FOLLOW then
		local lastRootPartPos = self._lastRootPartPos
		local rootPartPos = goalRootPart.Position
		local shouldRecalculate = false
		if lastRootPartPos and (rootPartPos - lastRootPartPos).Magnitude > 0.1 or not (self._goalPos and lastRootPartPos) then
			shouldRecalculate = true
		end
		if shouldRecalculate then
			self._lastRootPartPos = rootPartPos
			local leftPos = goalRootPart.CFrame * Vector3.new(-4, 0, 1)
			local rightPos = goalRootPart.CFrame * Vector3.new(4, 0, 1)
			if self:DistanceTo(leftPos) < self:DistanceTo(rightPos) then
				return leftPos
			else
				return rightPos
			end
		else
			return self._goalPos
		end
	elseif goalRootPart and (self._stateId ~= DogConsts.STATE.REST and self._stateId ~= DogConsts.STATE.PET) then
		error("Invalid state")
	end
end
function Dog._getTargetSpeed(self, goalPos, dt)
	local result
	if self._goalPos then
		local dist = (goalPos - self._goalPos).Magnitude / dt
		local springVal = self._targetSpeedSpring:SetTarget(dist)
		if springVal < dist then
			self._targetSpeedSpring.Freq = 3
			return springVal
		end
		self._targetSpeedSpring.Freq = 10
		result = springVal
	else
		result = 0
	end
	return result
end
function Dog._getGoalSpeed(self, distToGoal)
	local topSpeed = DogConsts.TOP_SPEED[self:GetBreedId()]
	if self._stateId == DogConsts.STATE.ATTACK then
		return topSpeed * 0.8
	end
	if self._stateId == DogConsts.STATE.FOLLOW then
		local speed
		if distToGoal >= 1 then
			local t = (distToGoal - 6) / 122
			speed = math.max(self._targetSpeed + distToGoal / 5, (1 - t) * 10 + t * topSpeed)
		else
			speed = 0
		end
		if speed <= 4 then
			speed = 0
		end
		return math.clamp(speed, 0, topSpeed)
	end
end
function Dog.Jump(self)
	if self._enabled then
		self._lastJump = os.clock()
		self._obj.PrimaryPart.Velocity = Vector3.new(0, 30, 0)
	end
end
function Dog._getNearestDog(self, maxDist)
	local owner = self:GetOwner()
	local ownerRootPart = PlayerUtils.getRootPart(owner)
	if ownerRootPart then
		local bestDist = maxDist or (1 / 0)
		local nearestDog = nil
		for i, dog in ipairs(DogSystem.getAll()) do
			if dog ~= self and dog:GetOwner().TeamValue.Value ~= owner.TeamValue.Value then
				local dist = (dog._obj.PrimaryPart.Position - ownerRootPart.Position).Magnitude
				if dist < bestDist then
					bestDist = dist
					nearestDog = dog
				end
			end
		end
		return nearestDog
	end
end
function Dog._getNearestOpp(self, maxDist)
	local owner = self:GetOwner()
	local ownerRootPart = PlayerUtils.getRootPart(owner)
	if ownerRootPart then
		local bestDist = maxDist or (1 / 0)
		local nearestOpp = nil
		for i, player in ipairs(Players:GetPlayers()) do
			if player ~= owner and player.TeamValue.Value ~= owner.TeamValue.Value then
				local oppRootPart = PlayerUtils.getRootPart(player)
				if oppRootPart then
					local dist = (oppRootPart.Position - ownerRootPart.Position).Magnitude
					if dist < bestDist then
						bestDist = dist
						nearestOpp = player
					end
				end
			end
		end
		return nearestOpp
	end
end
function Dog._updateAnimSpeed(self)
	if self._enabled then
		local ownerRootPart = PlayerUtils.getRootPart((self:GetOwner()))
		if ownerRootPart then
			local primaryPart = self._obj.PrimaryPart
			if self._stateId == DogConsts.STATE.REST or self._stateId == DogConsts.STATE.PET then
				local toOwner = primaryPart.Position - ownerRootPart.Position
				local dist = toOwner.Magnitude
				local dotToLook = toOwner.Unit:Dot(ownerRootPart.CFrame.LookVector)
				if dist > 8 then
					self:_updateTarget()
				elseif dist < 4 and (dotToLook > 0.75 and self._stateId ~= DogConsts.STATE.PET) then
					self:SetAnimation(DogConsts.ANIM_STATE.PET)
					self:SetState(DogConsts.STATE.PET)
				end
			end
			if self._stateId == DogConsts.STATE.FOLLOW or self._stateId == DogConsts.STATE.ATTACK then
				local velocityMag = primaryPart.Velocity.Magnitude
				if velocityMag < 1 then
					velocityMag = 0
				end
				if math.abs(velocityMag - self._animSpeed) > 1 or self._animSpeed ~= 0 and velocityMag == 0 then
					self:SetAnimSpeed(velocityMag)
				end
			end
			if self._stateId == DogConsts.STATE.FOLLOW and (self._animStateId == DogConsts.ANIM_STATE.IDLE and os.clock() - self._lastAnimTransition > 6) then
				self:SetState(DogConsts.STATE.REST)
				self:SetAnimation(DogConsts.ANIM_STATE.REST)
			end
		end
	end
end
function Dog._discoverDog(self)
	local now = os.clock()
	local primaryPart = self._obj.PrimaryPart
	self._lastDiscoverDog = now
	local nearestDog = self:_getNearestDog(DogConsts.CONFUSION_OPP_RADIUS)
	if nearestDog then
		self:SetDirection(((nearestDog._obj.PrimaryPart.Position - primaryPart.Position) * Vector3.new(1, 0, 1)).Unit)
		self:Bark()
		self:_playAnimNetwork(DogConsts.ANIM_STATE.POINT)
		return true
	end
end
function Dog._discoverOpp(self)
	local now = os.clock()
	local primaryPart = self._obj.PrimaryPart
	self._lastDiscoverOpp = now
	local nearestOpp = self:_getNearestOpp(DogConsts.BARK_OPP_RADIUS)
	if nearestOpp then
		self:_barkAt(((PlayerUtils.getRootPart(nearestOpp).Position - primaryPart.Position) * Vector3.new(1, 0, 1)).Unit)
		return true
	end
end
function Dog._barkAt(self, direction)
	assert(math.abs(direction.Magnitude - 1) < 0.001)
	self:SetDirection(direction)
	self:Bark()
	self:_playAnimNetwork(DogConsts.ANIM_STATE.POINT)
end
function Dog._updateLocalOwner(self)
	if self._enabled then
		local now = os.clock()
		local dt = now - self._lastUpdate
		self._lastUpdate = now
		if self._stateId == DogConsts.STATE.FOLLOW or self._stateId == DogConsts.STATE.ATTACK then
			local goalPos = self:_getGoalPos()
			if goalPos then
				self._targetSpeed = self:_getTargetSpeed(goalPos, dt)
				self._goalPos = goalPos
				local primaryPart = self._obj.PrimaryPart
				local toGoal = (goalPos - primaryPart.Position) * Vector3.new(1, 0, 1)
				local distToGoal = toGoal.Magnitude
				local goalSpeed = self:_getGoalSpeed(distToGoal)
				self:SetSpeed(goalSpeed)
				if goalSpeed > 0 then
					self:SetDirection(toGoal.Unit)
				end
				local facingSign = if self:GetBreedId() == DogConsts.ENUM_BREED.GERMAN then -1 else 1
				self._bodyGyro.CFrame = CFrame.new(Vector3.new(), self._direction * facingSign) + primaryPart.Position
				self._bodyVelocity.Velocity = primaryPart.CFrame.LookVector * facingSign * self._speed
				if goalSpeed * 0.5 < math.abs((primaryPart.Velocity:Dot(primaryPart.CFrame.LookVector))) or goalSpeed < 5 then
					self._lastStuckAt = now
				end
				if now - self._lastStuckAt > 0.1 and now - self._lastJump > 0.5 then
					self:Jump()
				end
				if self._stateId == DogConsts.STATE.ATTACK then
					if self._attackStateId == DogConsts.ATTACK_STATE.TO then
						local attackLeadTime = DogConsts.ATTACK_LEAD_TIME
						if distToGoal <= goalSpeed * attackLeadTime and not self._goToPosition then
							local offsetX = math.random() * 8 + 16
							if math.random() > 0.5 then
								offsetX = -offsetX
							end
							local offsetZ = math.random() * 8 + 16
							if math.random() > 0.5 then
								offsetZ = -offsetZ
							end
							local awayTarget = goalPos + Vector3.new(offsetX, 0, offsetZ)
							local primaryPos = primaryPart.Position
							local _, hitPos = RayCast.RayIgnoreNonCollideWithIgnoreList(primaryPos, (awayTarget - primaryPos).Unit, (awayTarget - primaryPos).Magnitude, { self._obj, self:_getGoalRootPart().Parent })
							self._goToPosition = hitPos
							self._lastAttack = os.clock()
							self:Jump()
							self:Bark()
							Promise.delay(attackLeadTime):andThen(function()
								self._attackStateId = DogConsts.ATTACK_STATE.AWAY
							end)
						end
					elseif self._attackStateId == DogConsts.ATTACK_STATE.AWAY and distToGoal <= 10 then
						self._goToPosition = nil
						self._attackStateId = DogConsts.ATTACK_STATE.TO
					end
					if DogConsts.GIVE_UP_AFTER_DIST < distToGoal and now - self._lastGiveUpSend > 1 then
						self._lastGiveUpSend = now
						self._giveUpRemote:FireServer()
					end
				end
			else
				return
			end
		else
			self._lastStuckAt = now
		end
		if (self._animStateId == DogConsts.ANIM_STATE.IDLE or self._animStateId == DogConsts.ANIM_STATE.REST) and now - self._lastAnimTransition > 1.5 then
			local primaryPart = self._obj.PrimaryPart
			local nearestDog = self:_getNearestDog(DogConsts.BARK_CONFUSION_RADIUS)
			if nearestDog then
				if now - self._lastDiscoverDog > 1 then
					self._lastDiscoverDog = now
					self:_barkAt(((nearestDog._obj.PrimaryPart.Position - primaryPart.Position) * Vector3.new(1, 0, 1)).Unit)
				end
			else
				local nearestOpp = self:_getNearestOpp(DogConsts.BARK_OPP_RADIUS)
				if nearestOpp and now - self._lastDiscoverOpp > 10 then
					self._lastDiscoverOpp = now
					self:_barkAt(((PlayerUtils.getRootPart(nearestOpp).Position - primaryPart.Position) * Vector3.new(1, 0, 1)).Unit)
				end
			end
		end
		if self._stateId == DogConsts.STATE.ATTACK and (now - self._lastStuckAt > DogConsts.GIVE_UP_AFTER_STUCK_FOR and now - self._lastGiveUpSend > 1) then
			self._lastGiveUpSend = now
			self._giveUpRemote:FireServer()
		end
	end
end
function Dog.SetDirection(self, direction)
	self._direction = direction
end
function Dog.SetSpeed(self, speed)
	if speed < 0 then
		speed = 0
	end
	self._speed = speed
end
function Dog.SetAnimSpeed(self, speed)
	self._animSpeed = speed
	if speed > 21 then
		if self._animStateId ~= DogConsts.ANIM_STATE.SPRINT then
			self:SetAnimation(DogConsts.ANIM_STATE.SPRINT)
		end
	elseif speed > 0.01 then
		if self._animStateId ~= DogConsts.ANIM_STATE.WALK then
			self:SetAnimation(DogConsts.ANIM_STATE.WALK)
		end
	elseif self._animStateId ~= DogConsts.ANIM_STATE.IDLE then
		self:SetAnimation(DogConsts.ANIM_STATE.IDLE)
	end
	if self._animStateId then
		local animSps = DogConsts.ANIM_SPS[self:GetBreedId()][self._animStateId]
		if animSps and self._animTrack then
			if speed <= 0.01 then
				speed = 0.01
			end
			self._animTrack:AdjustSpeed(speed / animSps)
		end
	end
end
function Dog.GetOwner(self)
	local ownerIdValue = self._ownerIdValue
	if ownerIdValue then
		return Players:GetPlayerByUserId(ownerIdValue.Value)
	end
end
function Dog.GetTarget(self)
	local targetIdValue = self._targetIdValue
	if targetIdValue then
		return Players:GetPlayerByUserId(targetIdValue.Value)
	end
end
function Dog.Destroy(self)
	local maid = self._maid
	assert(maid ~= nil)
	self._maid = nil
	maid:Destroy()
end
return Dog
