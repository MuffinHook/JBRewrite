local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local PathfindingService = game:GetService("PathfindingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local Interval = require(ReplicatedStorage.Std.Interval)
local Region = require(ReplicatedStorage.Std.Region)
local Signal = require(ReplicatedStorage.Std.Signal)
local RegionUtils = require(ReplicatedStorage.Std.Region.RegionUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local NPCConsts = require(ReplicatedStorage.NPC.NPCConsts)
local NPCUtils = require(ReplicatedStorage.NPC.NPCUtils)
local DestructibleConsts = require(ReplicatedStorage.Game.Destructible.DestructibleConsts)
local NPCShared = {}
function NPCShared.setup(self)
	local npcModel = self.obj
	self.maid:GiveTask(function()
		if self._path then
			self._path:Destroy()
			self._path = nil
		end
		self._waypoints = nil
	end)
	self._waypoints = nil
	self._nextWaypointIndex = nil
	self.maid.reachedConnection = nil
	self._lastJump = 0
	self.onWaypoint = Signal.new()
	function self.shouldMoveToNextWaypointFunc()
		return true
	end
	self.lookAtConstraint = nil
	self.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(npcModel, NPCConsts.LOOK_AT_CONSTRAINT_NAME, function(constraintInstance, constraintMaid)
		self.lookAtConstraint = constraintInstance
		constraintMaid:GiveTask(function()
			self.lookAtConstraint = nil
		end)
	end))
	local function updateTarget()
		local targetMaidInstance = Maid.new()
		self.maid.targetMaid = targetMaidInstance
		if self:IsLocallyOwned() and (not self.customUpdateTarget or self:customUpdateTarget(targetMaidInstance) ~= true) then
			local destType = NPCUtils.getTargetType(npcModel)
			if destType and destType == NPCConsts.DEST_TYPE.OBJ then
				if NPCUtils.getTarget(npcModel) then
					targetMaidInstance:GiveTask(RunService.PostSimulation:Connect(function()
						if npcModel.PrimaryPart then
							local targetInstance = NPCUtils.getTarget(npcModel)
							local targetPosition = targetInstance.Position
							local targetVelMagnitude = (targetInstance.Velocity * Vector3.new(1, 0, 1)).Magnitude
							local npcPosition = npcModel.PrimaryPart.Position
							local targetDirection = if targetVelMagnitude > 0.1 then (targetInstance.Velocity * Vector3.new(1, 0, 1)).Unit else Vector3.new(0, 0, 0)
							local interceptTime = GeomUtils.getTrajectoryInterceptTime(npcPosition, npcModel.PrimaryPart.Velocity.Magnitude, targetPosition, targetVelMagnitude, targetDirection)
							local distanceToTarget = ((targetPosition - npcPosition) * Vector3.new(1, 0, 1)).Magnitude
							if not interceptTime then
								interceptTime = math.clamp(distanceToTarget / 36, 0, 1) * 3
							end
							local extrapolatedTargetPos = if NPCUtils.getExtrapolateTargetMovement(npcModel) then targetPosition + targetDirection * targetVelMagnitude * interceptTime else targetPosition
							local targetInRegion, npcInRegion
							if self.hasAllowedRegion then
								local targetCastPoint = self.allowedRegion:CastPoint(targetPosition)
								targetInRegion, npcInRegion = targetCastPoint, self.allowedRegion:CastPoint(npcPosition)
							else
								targetInRegion = true
								npcInRegion = true
							end
							local homePos = NPCUtils.getHomePosition(npcModel)
							if targetInRegion then
								NPCShared.goTo(self, extrapolatedTargetPos)
							elseif homePos and not npcInRegion then
								NPCShared.goTo(self, homePos)
							else
								NPCShared.move(self.humanoid, Vector3.new(0, 0, 0))
							end
						end
					end))
				end
			elseif destType and destType == NPCConsts.DEST_TYPE.POS then
				local destPos = NPCUtils.getTarget(npcModel)
				if destPos then
					targetMaidInstance:GiveTask(RunService.Heartbeat:Connect(function()
						NPCShared.goTo(self, destPos)
					end))
				end
			elseif destType and destType == NPCConsts.DEST_TYPE.IDLE then
				local idleWanderTarget = nil
				targetMaidInstance:GiveTask(RunService.Heartbeat:Connect(function()
					if idleWanderTarget then
						NPCShared.goTo(self, idleWanderTarget)
					end
				end))
				targetMaidInstance:GiveTask(Interval.every(2):Connect(function()
					local currentIdleTarget = NPCUtils.getTarget(npcModel)
					if currentIdleTarget then
						local randomOffset = GeomUtils.randomPointOnCircle() * 16
						if math.random() < 0.5 then
							idleWanderTarget = currentIdleTarget + Vector3.new(randomOffset.X, 0, randomOffset.Y)
						end
					end
				end))
			elseif destType then
				error("invalid targeType", destType)
			end
		end
	end
	updateTarget()
	self.maid:GiveTask(npcModel:GetAttributeChangedSignal(NPCConsts.DEST_POS_ATTR_NAME):Connect(updateTarget))
	self.maid:GiveTask(npcModel:GetAttributeChangedSignal(NPCConsts.DEST_TYPE_ATTR_NAME):Connect(updateTarget))
	self.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(npcModel, NPCConsts.DEST_OBJ_VALUE_NAME, function(self, destObjMaid)
		updateTarget()
		destObjMaid:GiveTask(self.Changed:Connect(updateTarget))
	end))
	self.maid:GiveTask(npcModel:GetAttributeChangedSignal(NPCConsts.NETWORK_OWNER_ID_ATTR_NAME):Connect(updateTarget))
	local function updateLookAt()
		local lookAtMaidInstance = Maid.new()
		self.maid.lookAtMaid = lookAtMaidInstance
		if self:IsLocallyOwned() then
			local lookAtType = NPCUtils.getLookAtType(npcModel)
			if lookAtType and lookAtType == NPCConsts.DEST_TYPE.OBJ then
				local lookAtObj = NPCUtils.getLookAt(npcModel)
				if lookAtObj then
					lookAtMaidInstance.runtime = RunService.Heartbeat:Connect(function()
						NPCShared.lookAt(self, lookAtObj.Position)
					end)
				else
					return
				end
			elseif lookAtType and lookAtType == NPCConsts.DEST_TYPE.POS then
				local lookAtPos = NPCUtils.getLookAt(npcModel)
				if lookAtPos then
					lookAtMaidInstance.runtime = RunService.Heartbeat:Connect(function()
						NPCShared.lookAt(self, lookAtPos)
					end)
				else
					return
				end
			end
			lookAtMaidInstance:GiveTask(function()
				if self.lookAtConstraint then
					self.lookAtConstraint.Enabled = false
				end
			end)
		end
	end
	updateLookAt()
	self.maid:GiveTask(npcModel:GetAttributeChangedSignal(NPCConsts.LOOK_AT_POS_ATTR_NAME):Connect(updateLookAt))
	self.maid:GiveTask(npcModel:GetAttributeChangedSignal(NPCConsts.LOOK_AT_TYPE_ATTR_NAME):Connect(updateLookAt))
	self.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(npcModel, NPCConsts.LOOK_AT_OBJ_VALUE_NAME, function(self, lookAtObjMaid)
		updateLookAt()
		lookAtObjMaid:GiveTask(self.Changed:Connect(updateLookAt))
	end))
	self.maid:GiveTask(npcModel:GetAttributeChangedSignal(NPCConsts.NETWORK_OWNER_ID_ATTR_NAME):Connect(updateLookAt))
	self.maid:GiveTask(Interval.every(1):Connect(function()
		NPCShared._createNewPath(self)
		NPCShared._updatePathfind(self)
	end))
	self.maid:GiveTask(Interval.every(1):Connect(function()
		if self:IsLocallyOwned() then
			local allowedHumanoidStates = {
				[Enum.HumanoidStateType.Dead] = true,
				[Enum.HumanoidStateType.Running] = true,
				[Enum.HumanoidStateType.Jumping] = true,
				[Enum.HumanoidStateType.Landed] = true,
				[Enum.HumanoidStateType.Freefall] = true
			}
			local humanoid = self.humanoid
			for i, humanoidState in ipairs(Enum.HumanoidStateType:GetEnumItems()) do
				if humanoidState ~= Enum.HumanoidStateType.None and (humanoid:GetStateEnabled(humanoidState) and not allowedHumanoidStates[humanoidState]) then
					humanoid:SetStateEnabled(humanoidState, false)
				end
			end
			if not allowedHumanoidStates[humanoid:GetState()] then
				humanoid:ChangeState(Enum.HumanoidStateType.Running)
			end
		end
	end))
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.FilterDescendantsInstances = {}
	raycastParams.IgnoreWater = true
	self.occlusionCastParams = raycastParams
	self.maid:GiveTask(Interval.every(1):Connect(function()
		raycastParams.FilterDescendantsInstances = NPCShared._buildOcclusionBlacklist(self)
	end))
	self.allowedRegion = Region.new(RegionUtils.NilCondition)
	self.maid:GiveTask(self.allowedRegion)
	self.hasAllowedRegion = false
	self.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(npcModel, NPCConsts.ALLOWED_PRISMS_FOLDER_NAME, function(prismsFolder, prismsMaid)
		prismsMaid:GiveTask(RxInstanceUtils.observeChildren(prismsFolder, function(prismChild, prismChildMaid)
			local prismData = {
				cframe = CFrame.new(),
				size = Vector3.new()
			}
			prismChildMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(prismChild, "c", function(self)
				prismData.cframe = self.Value
			end))
			prismChildMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(prismChild, "s", function(self)
				prismData.size = self.Value
			end))
			prismChildMaid:GiveTask((self.allowedRegion:AddPrism(prismData)))
			local function updateAllowedRegionStatus()
				self.hasAllowedRegion = #prismsFolder:GetChildren() > 0
			end
			self.hasAllowedRegion = #prismsFolder:GetChildren() > 0
			prismChildMaid:GiveTask(updateAllowedRegionStatus)
		end))
	end))
	self.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(npcModel, NPCConsts.HOME_POSITION_OBJ_NAME, function(homePositionObj, homePosMaid)
		local function update()
			self.homePosition = NPCUtils.getHomePosition(npcModel)
		end
		self.homePosition = NPCUtils.getHomePosition(npcModel)
		homePosMaid:GiveTask(homePositionObj.Changed:Connect(update))
		homePosMaid:GiveTask(function()
			self.homePosition = nil
		end)
	end))
end
function NPCShared._buildOcclusionBlacklist(self)
	local blacklistTable = { self.obj }
	local humanoidInstanceMap = {}
	for instance, humanoid in CollectionService:GetTagged("Humanoid") do
		humanoidInstanceMap[humanoid] = true
		table.insert(blacklistTable, humanoid.Parent)
	end
	for i, player in ipairs(Players:GetPlayers()) do
		if player.Character then
			local Humanoid = player.Character:FindFirstChild("Humanoid")
			if Humanoid and not humanoidInstanceMap[Humanoid.Parent] then
				table.insert(blacklistTable, Humanoid.Parent)
			end
		end
	end
	for destructibleIndex, destructibleInstance in CollectionService:GetTagged(DestructibleConsts.SPAWN_TAG_NAME) do
		if destructibleInstance:FindFirstChild(DestructibleConsts.INSTANCE_VALUE_NAME) and destructibleInstance[DestructibleConsts.INSTANCE_VALUE_NAME].Value then
			table.insert(blacklistTable, destructibleInstance[DestructibleConsts.INSTANCE_VALUE_NAME].Value)
		end
	end
	return blacklistTable
end
function NPCShared._createNewPath(self)
	if self._path then
		self._path:Destroy()
		self._path = nil
	end
	self._path = PathfindingService:CreatePath({
		AgentHeight = 4,
		AgentRadius = 2,
		WaypointSpacing = (1 / 0),
		Costs = self.agentCosts
	})
end
function NPCShared.pathfindTo(self, destination)
	self._pathfindTo = destination
end
function NPCShared._updatePathfind(self)
	local pathfindDestination = self._pathfindTo
	if pathfindDestination then
		local isSuccess, _ = pcall(function()
			self._path:ComputeAsync(self.obj.PrimaryPart.Position + self.obj.PrimaryPart.CFrame.UpVector * -4, pathfindDestination)
		end)
		if self.Destroy == nil then
			return
		end
		local pathExists = isSuccess and self._path.Status == Enum.PathStatus.Success
		self._doesPathfindingPathExist = pathExists
		if pathExists then
			self._waypoints = self._path:GetWaypoints()
			if not self.maid.reachedConnection then
				self.maid.reachedConnection = self.humanoid.MoveToFinished:Connect(function(reachedWaypoint)
					if reachedWaypoint and (self._waypoints and self._nextWaypointIndex < #self._waypoints) then
						local instance = self
						instance._nextWaypointIndex = instance._nextWaypointIndex + 1
						local currentWaypoint = self._waypoints[self._nextWaypointIndex]
						self.onWaypoint:Fire(currentWaypoint)
						if self.obj:GetAttribute(NPCConsts.JUMPING_DISABLED_ATTR_NAME) ~= true and currentWaypoint.Action == Enum.PathWaypointAction.Jump then
							self._lastJump = os.clock()
							self.humanoid.Jump = true
						end
						if self.shouldMoveToNextWaypointFunc(currentWaypoint) then
							NPCShared.moveTo(self.humanoid, currentWaypoint.Position)
						end
					else
						NPCShared.move(self.humanoid, Vector3.new(0, 0, 0))
						self.maid.reachedConnection = nil
					end
				end)
			end
			self._nextWaypointIndex = 2
			local firstWaypoint = self._waypoints[self._nextWaypointIndex]
			if firstWaypoint then
				self.onWaypoint:Fire(firstWaypoint)
				if self.obj:GetAttribute(NPCConsts.JUMPING_DISABLED_ATTR_NAME) ~= true and firstWaypoint.Action == Enum.PathWaypointAction.Jump then
					self._lastJump = os.clock()
					self.humanoid.Jump = true
				end
				if self.shouldMoveToNextWaypointFunc(firstWaypoint) then
					NPCShared.moveTo(self.humanoid, firstWaypoint.Position)
				end
			else
				NPCShared.move(self.humanoid, Vector3.new(0, 0, 0))
			end
		else
			NPCShared.move(self.humanoid, Vector3.new(0, 0, 0))
		end
	elseif self.maid.reachedConnection then
		self.maid.reachedConnection = nil
	end
end
function NPCShared.lookAt(self, targetPos)
	if self.lookAtConstraint ~= nil then
		if targetPos == nil then
			if self.lookAtConstraint.Enabled then
				self.lookAtConstraint.Enabled = false
			end
		else
			if not self.lookAtConstraint.Enabled then
				self.lookAtConstraint.Enabled = true
			end
			self.lookAtConstraint.CFrame = CFrame.lookAt(self.lookAtConstraint.Attachment0.WorldPosition, targetPos)
		end
	end
end
function NPCShared.goTo(self, targetPos)
	local humanoid = self.humanoid
	local currentTime = os.clock()
	if not self._lastTargetOcclusionCheck then
		self._lastTargetOcclusionCheck = 0
	end
	if currentTime - self._lastTargetOcclusionCheck > 1 then
		self._lastTargetOcclusionCheck = currentTime
		self._isTargetNonOccludedCached = NPCShared.isNonOccluded(humanoid.RootPart, targetPos, self.occlusionCastParams)
	end
	if NPCShared.getDistTo(humanoid.RootPart, targetPos) >= humanoid.Parent:GetAttribute(NPCConsts.MIN_DIST_TO_TARGET_ATTR_NAME) then
		if self._isTargetNonOccludedCached then
			NPCShared.zigZagTowards(humanoid, targetPos)
			self._pathfindTo = nil
			return
		end
		NPCShared.pathfindTo(self, targetPos)
		if not self._doesPathfindingPathExist then
			NPCShared.moveTowards(humanoid, targetPos)
		end
	else
		NPCShared.move(humanoid, Vector3.new(0, 0, 0))
	end
end
function NPCShared.isNonOccluded(self, rayDestination, raycastParams)
	local originPos = self.Position
	local rayDirection = rayDestination - originPos
	if rayDirection.Magnitude < 0.1 then
		return false
	else
		local raycastResult = Raycast.collidable(originPos, rayDirection.Unit, rayDirection.Magnitude, raycastParams)
		if raycastResult then
			return (raycastResult.Position - rayDestination).Magnitude < 0.1
		else
			return true
		end
	end
end
function NPCShared.moveTo(self, targetPos)
	self:MoveTo(targetPos)
end
function NPCShared.moveTowards(self, targetPos)
	NPCShared.move(self, (targetPos - self.RootPart.Position).Unit)
end
function NPCShared.zigZagTowards(self, targetPos)
	local strafeMult = self.Parent:GetAttribute(NPCConsts.SIDE_STRAFE_MULT_ATTR_NAME)
	local freqOffset = self.Parent:GetAttribute(NPCConsts.FREQ_OFFSET_ATTR_NAME)
	local directionToTarget = targetPos - self.RootPart.Position
	local distanceRatio = math.clamp(directionToTarget.Magnitude / 24, 0, 1)
	local perpendicular = directionToTarget.Unit:Cross(Vector3.new(0, 1, 0))
	NPCShared.move(self, directionToTarget.Unit + perpendicular * (math.cos(os.clock() * 7 + freqOffset) * distanceRatio) * 0.3 * strafeMult)
end
function NPCShared.move(self, movementDir)
	self:Move(movementDir)
end
function NPCShared.getDistTo(self, targetPos)
	return ((targetPos - self.Position) * Vector3.new(1, 0, 1)).Magnitude
end
return NPCShared
