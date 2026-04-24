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
function t.setup(p1)
	local obj = p1.obj
	p1.maid:GiveTask(function()
		if p1._path then
			p1._path:Destroy()
			p1._path = nil
		end
		p1._waypoints = nil
	end)
	p1._waypoints = nil
	p1._nextWaypointIndex = nil
	p1.maid.reachedConnection = nil
	p1._lastJump = 0
	p1.onWaypoint = Signal.new()
	function p1.shouldMoveToNextWaypointFunc()
		return true
	end
	p1.lookAtConstraint = nil
	p1.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(obj, NPCConsts.LOOK_AT_CONSTRAINT_NAME, function(p12, p2)
		p1.lookAtConstraint = p12
		p2:GiveTask(function()
			p1.lookAtConstraint = nil
		end)
	end))
	local function updateTarget()
		local v1 = Maid.new()
		p1.maid.targetMaid = v1
		if p1:IsLocallyOwned() and (not p1.customUpdateTarget or p1:customUpdateTarget(v1) ~= true) then
			local v2 = NPCUtils.getTargetType(obj)
			if v2 and v2 == NPCConsts.DEST_TYPE.OBJ then
				if NPCUtils.getTarget(obj) then
					v1:GiveTask(RunService.PostSimulation:Connect(function()
						if obj.PrimaryPart then
							local v1 = NPCUtils.getTarget(obj)
							local Position = v1.Position
							local Magnitude = (v1.Velocity * Vector3.new(1, 0, 1)).Magnitude
							local Position_2 = obj.PrimaryPart.Position
							local v2 = if Magnitude > 0.1 then (v1.Velocity * Vector3.new(1, 0, 1)).Unit else Vector3.new(0, 0, 0)
							local v3 = GeomUtils.getTrajectoryInterceptTime(Position_2, obj.PrimaryPart.Velocity.Magnitude, Position, Magnitude, v2)
							local Magnitude_3 = ((Position - Position_2) * Vector3.new(1, 0, 1)).Magnitude
							if not v3 then
								v3 = math.clamp(Magnitude_3 / 36, 0, 1) * 3
							end
							local v4 = if NPCUtils.getExtrapolateTargetMovement(obj) then Position + v2 * Magnitude * v3 else Position
							local v5, v6
							if p1.hasAllowedRegion then
								local v7 = p1.allowedRegion:CastPoint(Position)
								v5, v6 = v7, p1.allowedRegion:CastPoint(Position_2)
							else
								v5 = true
								v6 = true
							end
							local v9 = NPCUtils.getHomePosition(obj)
							if v5 then
								t.goTo(p1, v4)
							elseif v9 and not v6 then
								t.goTo(p1, v9)
							else
								t.move(p1.humanoid, Vector3.new(0, 0, 0))
							end
						end
					end))
				end
			elseif v2 and v2 == NPCConsts.DEST_TYPE.POS then
				local v3 = NPCUtils.getTarget(obj)
				if v3 then
					v1:GiveTask(RunService.Heartbeat:Connect(function()
						t.goTo(p1, v3)
					end))
				end
			elseif v2 and v2 == NPCConsts.DEST_TYPE.IDLE then
				local v4 = nil
				v1:GiveTask(RunService.Heartbeat:Connect(function()
					if v4 then
						t.goTo(p1, v4)
					end
				end))
				v1:GiveTask(Interval.every(2):Connect(function()
					local v1 = NPCUtils.getTarget(obj)
					if v1 then
						local v2 = GeomUtils.randomPointOnCircle() * 16
						if math.random() < 0.5 then
							v4 = v1 + Vector3.new(v2.X, 0, v2.Y)
						end
					end
				end))
			elseif v2 then
				error("invalid targeType", v2)
			end
		end
	end
	updateTarget()
	p1.maid:GiveTask(obj:GetAttributeChangedSignal(NPCConsts.DEST_POS_ATTR_NAME):Connect(updateTarget))
	p1.maid:GiveTask(obj:GetAttributeChangedSignal(NPCConsts.DEST_TYPE_ATTR_NAME):Connect(updateTarget))
	p1.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(obj, NPCConsts.DEST_OBJ_VALUE_NAME, function(p1, p2)
		updateTarget()
		p2:GiveTask(p1.Changed:Connect(updateTarget))
	end))
	p1.maid:GiveTask(obj:GetAttributeChangedSignal(NPCConsts.NETWORK_OWNER_ID_ATTR_NAME):Connect(updateTarget))
	local function updateLookAt()
		local v1 = Maid.new()
		p1.maid.lookAtMaid = v1
		if p1:IsLocallyOwned() then
			local v2 = NPCUtils.getLookAtType(obj)
			if v2 and v2 == NPCConsts.DEST_TYPE.OBJ then
				local v3 = NPCUtils.getLookAt(obj)
				if v3 then
					v1.runtime = RunService.Heartbeat:Connect(function()
						t.lookAt(p1, v3.Position)
					end)
				else
					return
				end
			elseif v2 and v2 == NPCConsts.DEST_TYPE.POS then
				local v4 = NPCUtils.getLookAt(obj)
				if v4 then
					v1.runtime = RunService.Heartbeat:Connect(function()
						t.lookAt(p1, v4)
					end)
				else
					return
				end
			end
			v1:GiveTask(function()
				if p1.lookAtConstraint then
					p1.lookAtConstraint.Enabled = false
				end
			end)
		end
	end
	updateLookAt()
	p1.maid:GiveTask(obj:GetAttributeChangedSignal(NPCConsts.LOOK_AT_POS_ATTR_NAME):Connect(updateLookAt))
	p1.maid:GiveTask(obj:GetAttributeChangedSignal(NPCConsts.LOOK_AT_TYPE_ATTR_NAME):Connect(updateLookAt))
	p1.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(obj, NPCConsts.LOOK_AT_OBJ_VALUE_NAME, function(p1, p2)
		updateLookAt()
		p2:GiveTask(p1.Changed:Connect(updateLookAt))
	end))
	p1.maid:GiveTask(obj:GetAttributeChangedSignal(NPCConsts.NETWORK_OWNER_ID_ATTR_NAME):Connect(updateLookAt))
	p1.maid:GiveTask(Interval.every(1):Connect(function()
		t._createNewPath(p1)
		t._updatePathfind(p1)
	end))
	p1.maid:GiveTask(Interval.every(1):Connect(function()
		if p1:IsLocallyOwned() then
			local t = {
				[Enum.HumanoidStateType.Dead] = true,
				[Enum.HumanoidStateType.Running] = true,
				[Enum.HumanoidStateType.Jumping] = true,
				[Enum.HumanoidStateType.Landed] = true,
				[Enum.HumanoidStateType.Freefall] = true
			}
			local humanoid = p1.humanoid
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
	local v1 = RaycastParams.new()
	v1.FilterType = Enum.RaycastFilterType.Blacklist
	v1.FilterDescendantsInstances = {}
	v1.IgnoreWater = true
	p1.occlusionCastParams = v1
	p1.maid:GiveTask(Interval.every(1):Connect(function()
		v1.FilterDescendantsInstances = t._buildOcclusionBlacklist(p1)
	end))
	p1.allowedRegion = Region.new(RegionUtils.NilCondition)
	p1.maid:GiveTask(p1.allowedRegion)
	p1.hasAllowedRegion = false
	p1.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(obj, NPCConsts.ALLOWED_PRISMS_FOLDER_NAME, function(p12, p2)
		p2:GiveTask(RxInstanceUtils.observeChildren(p12, function(p13, p2)
			local t = {
				c = CFrame.new(),
				s = Vector3.new()
			}
			p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p13, "c", function(p1)
				t.c = p1.Value
			end))
			p2:GiveTask(RxInstanceUtils.observeOneChildNamed(p13, "s", function(p1)
				t.s = p1.Value
			end))
			p2:GiveTask((p1.allowedRegion:AddPrism(t)))
			local function f()
				p1.hasAllowedRegion = #p12:GetChildren() > 0
			end
			p1.hasAllowedRegion = #p12:GetChildren() > 0
			p2:GiveTask(f)
		end))
	end))
	p1.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(obj, NPCConsts.HOME_POSITION_OBJ_NAME, function(p12, p2)
		local function update()
			p1.homePosition = NPCUtils.getHomePosition(obj)
		end
		p1.homePosition = NPCUtils.getHomePosition(obj)
		p2:GiveTask(p12.Changed:Connect(update))
		p2:GiveTask(function()
			p1.homePosition = nil
		end)
	end))
end
function t._buildOcclusionBlacklist(p1)
	local t = { p1.obj }
	local t2 = {}
	for v1, v2 in CollectionService:GetTagged("Humanoid") do
		t2[v2] = true
		table.insert(t, v2.Parent)
	end
	for i, v in ipairs(Players:GetPlayers()) do
		if v.Character then
			local Humanoid = v.Character:FindFirstChild("Humanoid")
			if Humanoid and not t2[Humanoid.Parent] then
				table.insert(t, Humanoid.Parent)
			end
		end
	end
	for v5, v6 in CollectionService:GetTagged(DestructibleConsts.SPAWN_TAG_NAME) do
		if v6:FindFirstChild(DestructibleConsts.INSTANCE_VALUE_NAME) and v6[DestructibleConsts.INSTANCE_VALUE_NAME].Value then
			table.insert(t, v6[DestructibleConsts.INSTANCE_VALUE_NAME].Value)
		end
	end
	return t
end
function t._createNewPath(p1)
	if p1._path then
		p1._path:Destroy()
		p1._path = nil
	end
	p1._path = PathfindingService:CreatePath({
		AgentHeight = 4,
		AgentRadius = 2,
		WaypointSpacing = (1 / 0),
		Costs = p1.agentCosts
	})
end
function t.pathfindTo(p1, p2)
	p1._pathfindTo = p2
end
function t._updatePathfind(p1)
	local _pathfindTo = p1._pathfindTo
	if _pathfindTo then
		local v1, _ = pcall(function()
			p1._path:ComputeAsync(p1.obj.PrimaryPart.Position + p1.obj.PrimaryPart.CFrame.UpVector * -4, _pathfindTo)
		end)
		if p1.Destroy == nil then
			return
		end
		local v2 = v1 and p1._path.Status == Enum.PathStatus.Success
		p1._doesPathfindingPathExist = v2
		if v2 then
			p1._waypoints = p1._path:GetWaypoints()
			if not p1.maid.reachedConnection then
				p1.maid.reachedConnection = p1.humanoid.MoveToFinished:Connect(function(p12)
					if p12 and (p1._waypoints and p1._nextWaypointIndex < #p1._waypoints) then
						local v1 = p1
						v1._nextWaypointIndex = v1._nextWaypointIndex + 1
						local v2 = p1._waypoints[p1._nextWaypointIndex]
						p1.onWaypoint:Fire(v2)
						if p1.obj:GetAttribute(NPCConsts.JUMPING_DISABLED_ATTR_NAME) ~= true and v2.Action == Enum.PathWaypointAction.Jump then
							p1._lastJump = os.clock()
							p1.humanoid.Jump = true
						end
						if p1.shouldMoveToNextWaypointFunc(v2) then
							t.moveTo(p1.humanoid, v2.Position)
						end
					else
						t.move(p1.humanoid, Vector3.new(0, 0, 0))
						p1.maid.reachedConnection = nil
					end
				end)
			end
			p1._nextWaypointIndex = 2
			local v3 = p1._waypoints[p1._nextWaypointIndex]
			if v3 then
				p1.onWaypoint:Fire(v3)
				if p1.obj:GetAttribute(NPCConsts.JUMPING_DISABLED_ATTR_NAME) ~= true and v3.Action == Enum.PathWaypointAction.Jump then
					p1._lastJump = os.clock()
					p1.humanoid.Jump = true
				end
				if p1.shouldMoveToNextWaypointFunc(v3) then
					t.moveTo(p1.humanoid, v3.Position)
				end
			else
				t.move(p1.humanoid, Vector3.new(0, 0, 0))
			end
		else
			t.move(p1.humanoid, Vector3.new(0, 0, 0))
		end
	elseif p1.maid.reachedConnection then
		p1.maid.reachedConnection = nil
	end
end
function t.lookAt(p1, p2)
	if p1.lookAtConstraint ~= nil then
		if p2 == nil then
			if p1.lookAtConstraint.Enabled then
				p1.lookAtConstraint.Enabled = false
			end
		else
			if not p1.lookAtConstraint.Enabled then
				p1.lookAtConstraint.Enabled = true
			end
			p1.lookAtConstraint.CFrame = CFrame.lookAt(p1.lookAtConstraint.Attachment0.WorldPosition, p2)
		end
	end
end
function t.goTo(p1, p2)
	local humanoid = p1.humanoid
	local v1 = os.clock()
	if not p1._lastTargetOcclusionCheck then
		p1._lastTargetOcclusionCheck = 0
	end
	if v1 - p1._lastTargetOcclusionCheck > 1 then
		p1._lastTargetOcclusionCheck = v1
		p1._isTargetNonOccludedCached = t.isNonOccluded(humanoid.RootPart, p2, p1.occlusionCastParams)
	end
	if t.getDistTo(humanoid.RootPart, p2) >= humanoid.Parent:GetAttribute(NPCConsts.MIN_DIST_TO_TARGET_ATTR_NAME) then
		if p1._isTargetNonOccludedCached then
			t.zigZagTowards(humanoid, p2)
			p1._pathfindTo = nil
			return
		end
		t.pathfindTo(p1, p2)
		if not p1._doesPathfindingPathExist then
			t.moveTowards(humanoid, p2)
		end
	else
		t.move(humanoid, Vector3.new(0, 0, 0))
	end
end
function t.isNonOccluded(p1, p2, p3)
	local Position = p1.Position
	local v1 = p2 - Position
	if v1.Magnitude < 0.1 then
		return false
	else
		local v2 = Raycast.collidable(Position, v1.Unit, v1.Magnitude, p3)
		if v2 then
			return (v2.Position - p2).Magnitude < 0.1
		else
			return true
		end
	end
end
function t.moveTo(p1, p2)
	p1:MoveTo(p2)
end
function t.moveTowards(p1, p2)
	t.move(p1, (p2 - p1.RootPart.Position).Unit)
end
function t.zigZagTowards(p1, p2)
	local v1 = p1.Parent:GetAttribute(NPCConsts.SIDE_STRAFE_MULT_ATTR_NAME)
	local v2 = p1.Parent:GetAttribute(NPCConsts.FREQ_OFFSET_ATTR_NAME)
	local v3 = p2 - p1.RootPart.Position
	local v5 = math.clamp(v3.Magnitude / 24, 0, 1)
	local v6 = v3.Unit:Cross(Vector3.new(0, 1, 0))
	t.move(p1, v3.Unit + v6 * (math.cos(os.clock() * 7 + v2) * v5) * 0.3 * v1)
end
function t.move(p1, p2)
	p1:Move(p2)
end
function t.getDistTo(p1, p2)
	return ((p2 - p1.Position) * Vector3.new(1, 0, 1)).Magnitude
end
return t
