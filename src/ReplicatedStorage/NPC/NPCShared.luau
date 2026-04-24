-- Reviewed by Claude
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
local t = {}
function t.setup(self)
	local obj = self.obj
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
	self.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(obj, NPCConsts.LOOK_AT_CONSTRAINT_NAME, function(p12, p2)
		self.lookAtConstraint = p12
		p2:GiveTask(function()
			self.lookAtConstraint = nil
		end)
	end))
	local function updateTarget()
		local instance = Maid.new()
		self.maid.targetMaid = instance
		if self:IsLocallyOwned() and (not self.customUpdateTarget or self:customUpdateTarget(instance) ~= true) then
			local vector2 = NPCUtils.getTargetType(obj)
			if vector2 and vector2 == NPCConsts.DEST_TYPE.OBJ then
				if NPCUtils.getTarget(obj) then
					instance:GiveTask(RunService.PostSimulation:Connect(function()
						if obj.PrimaryPart then
							local instance = NPCUtils.getTarget(obj)
							local Position = instance.Position
							local Magnitude = (instance.Velocity * Vector3.new(1, 0, 1)).Magnitude
							local Position_2 = obj.PrimaryPart.Position
							local vector2 = if Magnitude > 0.1 then (instance.Velocity * Vector3.new(1, 0, 1)).Unit else Vector3.new(0, 0, 0)
							local var3 = GeomUtils.getTrajectoryInterceptTime(Position_2, obj.PrimaryPart.Velocity.Magnitude, Position, Magnitude, vector2)
							local Magnitude_3 = ((Position - Position_2) * Vector3.new(1, 0, 1)).Magnitude
							if not var3 then
								var3 = math.clamp(Magnitude_3 / 36, 0, 1) * 3
							end
							local var4 = if NPCUtils.getExtrapolateTargetMovement(obj) then Position + vector2 * Magnitude * var3 else Position
							local var5, vector6
							if self.hasAllowedRegion then
								local var7 = self.allowedRegion:CastPoint(Position)
								var5, vector6 = var7, self.allowedRegion:CastPoint(Position_2)
							else
								var5 = true
								vector6 = true
							end
							local var9 = NPCUtils.getHomePosition(obj)
							if var5 then
								t.goTo(self, var4)
							elseif var9 and not vector6 then
								t.goTo(self, var9)
							else
								t.move(self.humanoid, Vector3.new(0, 0, 0))
							end
						end
					end))
				end
			elseif vector2 and vector2 == NPCConsts.DEST_TYPE.POS then
				local var3 = NPCUtils.getTarget(obj)
				if var3 then
					instance:GiveTask(RunService.Heartbeat:Connect(function()
						t.goTo(self, var3)
					end))
				end
			elseif vector2 and vector2 == NPCConsts.DEST_TYPE.IDLE then
				local var4 = nil
				instance:GiveTask(RunService.Heartbeat:Connect(function()
					if var4 then
						t.goTo(self, var4)
					end
				end))
				instance:GiveTask(Interval.every(2):Connect(function()
					local instance = NPCUtils.getTarget(obj)
					if instance then
						local vector2 = GeomUtils.randomPointOnCircle() * 16
						if math.random() < 0.5 then
							var4 = instance + Vector3.new(vector2.X, 0, vector2.Y)
						end
					end
				end))
			elseif vector2 then
				error("invalid targeType", vector2)
			end
		end
	end
	updateTarget()
	self.maid:GiveTask(obj:GetAttributeChangedSignal(NPCConsts.DEST_POS_ATTR_NAME):Connect(updateTarget))
	self.maid:GiveTask(obj:GetAttributeChangedSignal(NPCConsts.DEST_TYPE_ATTR_NAME):Connect(updateTarget))
	self.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(obj, NPCConsts.DEST_OBJ_VALUE_NAME, function(self, p2)
		updateTarget()
		p2:GiveTask(self.Changed:Connect(updateTarget))
	end))
	self.maid:GiveTask(obj:GetAttributeChangedSignal(NPCConsts.NETWORK_OWNER_ID_ATTR_NAME):Connect(updateTarget))
	local function updateLookAt()
		local instance = Maid.new()
		self.maid.lookAtMaid = instance
		if self:IsLocallyOwned() then
			local vector2 = NPCUtils.getLookAtType(obj)
			if vector2 and vector2 == NPCConsts.DEST_TYPE.OBJ then
				local var3 = NPCUtils.getLookAt(obj)
				if var3 then
					instance.runtime = RunService.Heartbeat:Connect(function()
						t.lookAt(self, var3.Position)
					end)
				else
					return
				end
			elseif vector2 and vector2 == NPCConsts.DEST_TYPE.POS then
				local var4 = NPCUtils.getLookAt(obj)
				if var4 then
					instance.runtime = RunService.Heartbeat:Connect(function()
						t.lookAt(self, var4)
					end)
				else
					return
				end
			end
			instance:GiveTask(function()
				if self.lookAtConstraint then
					self.lookAtConstraint.Enabled = false
				end
			end)
		end
	end
	updateLookAt()
	self.maid:GiveTask(obj:GetAttributeChangedSignal(NPCConsts.LOOK_AT_POS_ATTR_NAME):Connect(updateLookAt))
	self.maid:GiveTask(obj:GetAttributeChangedSignal(NPCConsts.LOOK_AT_TYPE_ATTR_NAME):Connect(updateLookAt))
	self.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(obj, NPCConsts.LOOK_AT_OBJ_VALUE_NAME, function(self, p2)
		updateLookAt()
		p2:GiveTask(self.Changed:Connect(updateLookAt))
	end))
	self.maid:GiveTask(obj:GetAttributeChangedSignal(NPCConsts.NETWORK_OWNER_ID_ATTR_NAME):Connect(updateLookAt))
	self.maid:GiveTask(Interval.every(1):Connect(function()
		t._createNewPath(self)
		t._updatePathfind(self)
	end))
	self.maid:GiveTask(Interval.every(1):Connect(function()
		if self:IsLocallyOwned() then
			local t = {
				[Enum.HumanoidStateType.Dead] = true,
				[Enum.HumanoidStateType.Running] = true,
				[Enum.HumanoidStateType.Jumping] = true,
				[Enum.HumanoidStateType.Landed] = true,
				[Enum.HumanoidStateType.Freefall] = true
			}
			local humanoid = self.humanoid
			for i, v in ipairs(Enum.HumanoidStateType:GetEnumItems()) do
				if v ~= Enum.HumanoidStateType.None and (humanoid:GetStateEnabled(v) and not t[v]) then
					humanoid:SetStateEnabled(v, false)
				end
			end
			if not t[humanoid:GetState()] then
				humanoid:ChangeState(Enum.HumanoidStateType.Running)
			end
		end
	end))
	local instance = RaycastParams.new()
	instance.FilterType = Enum.RaycastFilterType.Blacklist
	instance.FilterDescendantsInstances = {}
	instance.IgnoreWater = true
	self.occlusionCastParams = instance
	self.maid:GiveTask(Interval.every(1):Connect(function()
		instance.FilterDescendantsInstances = t._buildOcclusionBlacklist(self)
	end))
	self.allowedRegion = Region.new(RegionUtils.NilCondition)
	self.maid:GiveTask(self.allowedRegion)
	self.hasAllowedRegion = false
	self.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(obj, NPCConsts.ALLOWED_PRISMS_FOLDER_NAME, function(p12, p2)
		p2:GiveTask(RxInstanceUtils.observeChildren(p12, function(p13, p2)
			local t = {
				c = CFrame.new(),
				s = Vector3.new()
			}
			p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p13, "c", function(self)
				t.c = self.Value
			end))
			p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p13, "s", function(self)
				t.s = self.Value
			end))
			p2:GiveTask((self.allowedRegion:AddPrism(t)))
			local function f()
				self.hasAllowedRegion = #p12:GetChildren() > 0
			end
			self.hasAllowedRegion = #p12:GetChildren() > 0
			p2:GiveTask(f)
		end))
	end))
	self.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(obj, NPCConsts.HOME_POSITION_OBJ_NAME, function(p12, p2)
		local function update()
			self.homePosition = NPCUtils.getHomePosition(obj)
		end
		self.homePosition = NPCUtils.getHomePosition(obj)
		p2:GiveTask(p12.Changed:Connect(update))
		p2:GiveTask(function()
			self.homePosition = nil
		end)
	end))
end
function t._buildOcclusionBlacklist(self)
	local t = { self.obj }
	local t2 = {}
	for instance, vector2 in CollectionService:GetTagged("Humanoid") do
		t2[vector2] = true
		table.insert(t, vector2.Parent)
	end
	for i, v in ipairs(Players:GetPlayers()) do
		if v.Character then
			local Humanoid = v.Character:FindFirstChild("Humanoid")
			if Humanoid and not t2[Humanoid.Parent] then
				table.insert(t, Humanoid.Parent)
			end
		end
	end
	for var5, vector6 in CollectionService:GetTagged(DestructibleConsts.SPAWN_TAG_NAME) do
		if vector6:FindFirstChild(DestructibleConsts.INSTANCE_VALUE_NAME) and vector6[DestructibleConsts.INSTANCE_VALUE_NAME].Value then
			table.insert(t, vector6[DestructibleConsts.INSTANCE_VALUE_NAME].Value)
		end
	end
	return t
end
function t._createNewPath(self)
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
function t.pathfindTo(self, p2)
	self._pathfindTo = p2
end
function t._updatePathfind(self)
	local _pathfindTo = self._pathfindTo
	if _pathfindTo then
		local instance, _ = pcall(function()
			self._path:ComputeAsync(self.obj.PrimaryPart.Position + self.obj.PrimaryPart.CFrame.UpVector * -4, _pathfindTo)
		end)
		if self.Destroy == nil then
			return
		end
		local vector2 = instance and self._path.Status == Enum.PathStatus.Success
		self._doesPathfindingPathExist = vector2
		if vector2 then
			self._waypoints = self._path:GetWaypoints()
			if not self.maid.reachedConnection then
				self.maid.reachedConnection = self.humanoid.MoveToFinished:Connect(function(p12)
					if p12 and (self._waypoints and self._nextWaypointIndex < #self._waypoints) then
						local instance = self
						instance._nextWaypointIndex = instance._nextWaypointIndex + 1
						local vector2 = self._waypoints[self._nextWaypointIndex]
						self.onWaypoint:Fire(vector2)
						if self.obj:GetAttribute(NPCConsts.JUMPING_DISABLED_ATTR_NAME) ~= true and vector2.Action == Enum.PathWaypointAction.Jump then
							self._lastJump = os.clock()
							self.humanoid.Jump = true
						end
						if self.shouldMoveToNextWaypointFunc(vector2) then
							t.moveTo(self.humanoid, vector2.Position)
						end
					else
						t.move(self.humanoid, Vector3.new(0, 0, 0))
						self.maid.reachedConnection = nil
					end
				end)
			end
			self._nextWaypointIndex = 2
			local var3 = self._waypoints[self._nextWaypointIndex]
			if var3 then
				self.onWaypoint:Fire(var3)
				if self.obj:GetAttribute(NPCConsts.JUMPING_DISABLED_ATTR_NAME) ~= true and var3.Action == Enum.PathWaypointAction.Jump then
					self._lastJump = os.clock()
					self.humanoid.Jump = true
				end
				if self.shouldMoveToNextWaypointFunc(var3) then
					t.moveTo(self.humanoid, var3.Position)
				end
			else
				t.move(self.humanoid, Vector3.new(0, 0, 0))
			end
		else
			t.move(self.humanoid, Vector3.new(0, 0, 0))
		end
	elseif self.maid.reachedConnection then
		self.maid.reachedConnection = nil
	end
end
function t.lookAt(self, p2)
	if self.lookAtConstraint ~= nil then
		if p2 == nil then
			if self.lookAtConstraint.Enabled then
				self.lookAtConstraint.Enabled = false
			end
		else
			if not self.lookAtConstraint.Enabled then
				self.lookAtConstraint.Enabled = true
			end
			self.lookAtConstraint.CFrame = CFrame.lookAt(self.lookAtConstraint.Attachment0.WorldPosition, p2)
		end
	end
end
function t.goTo(self, p2)
	local humanoid = self.humanoid
	local instance = os.clock()
	if not self._lastTargetOcclusionCheck then
		self._lastTargetOcclusionCheck = 0
	end
	if instance - self._lastTargetOcclusionCheck > 1 then
		self._lastTargetOcclusionCheck = instance
		self._isTargetNonOccludedCached = t.isNonOccluded(humanoid.RootPart, p2, self.occlusionCastParams)
	end
	if t.getDistTo(humanoid.RootPart, p2) >= humanoid.Parent:GetAttribute(NPCConsts.MIN_DIST_TO_TARGET_ATTR_NAME) then
		if self._isTargetNonOccludedCached then
			t.zigZagTowards(humanoid, p2)
			self._pathfindTo = nil
			return
		end
		t.pathfindTo(self, p2)
		if not self._doesPathfindingPathExist then
			t.moveTowards(humanoid, p2)
		end
	else
		t.move(humanoid, Vector3.new(0, 0, 0))
	end
end
function t.isNonOccluded(self, p2, p3)
	local Position = self.Position
	local instance = p2 - Position
	if instance.Magnitude < 0.1 then
		return false
	else
		local vector2 = Raycast.collidable(Position, instance.Unit, instance.Magnitude, p3)
		if vector2 then
			return (vector2.Position - p2).Magnitude < 0.1
		else
			return true
		end
	end
end
function t.moveTo(self, p2)
	self:MoveTo(p2)
end
function t.moveTowards(self, p2)
	t.move(self, (p2 - self.RootPart.Position).Unit)
end
function t.zigZagTowards(self, p2)
	local instance = self.Parent:GetAttribute(NPCConsts.SIDE_STRAFE_MULT_ATTR_NAME)
	local vector2 = self.Parent:GetAttribute(NPCConsts.FREQ_OFFSET_ATTR_NAME)
	local var3 = p2 - self.RootPart.Position
	local var5 = math.clamp(var3.Magnitude / 24, 0, 1)
	local vector6 = var3.Unit:Cross(Vector3.new(0, 1, 0))
	t.move(self, var3.Unit + vector6 * (math.cos(os.clock() * 7 + vector2) * var5) * 0.3 * instance)
end
function t.move(self, p2)
	self:Move(p2)
end
function t.getDistTo(self, p2)
	return ((p2 - self.Position) * Vector3.new(1, 0, 1)).Magnitude
end
return t
