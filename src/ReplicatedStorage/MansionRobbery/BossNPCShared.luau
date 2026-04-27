local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local BossNPCConsts = require(ReplicatedStorage.MansionRobbery.BossNPCConsts)
local BossNPCUtils = require(ReplicatedStorage.MansionRobbery.BossNPCUtils)
local NPCUtils = require(ReplicatedStorage.NPC.NPCUtils)
local NPCConsts = require(ReplicatedStorage.NPC.NPCConsts)
local NPCShared = require(ReplicatedStorage.NPC.NPCShared)
local MansionRobberyUtils = require(ReplicatedStorage.MansionRobbery.MansionRobberyUtils)
return {
	setup = function(npcController)
		local obj = npcController.obj
		local movementState = nil
		local function handleMovement()
			movementState = BossNPCUtils.getMovementState(obj)
		end
		movementState = BossNPCUtils.getMovementState(obj)
		npcController.maid:GiveTask(BossNPCUtils.getMovementStateChangedSignal(obj):Connect(handleMovement))
		local attackState = nil
		npcController.maid.lastAttackMaidShared = nil
		local function handleAttackState()
			attackState = BossNPCUtils.getAttackState(obj)
			if npcController:IsLocallyOwned() then
				local attackMaid = Maid.new()
				npcController.maid.lastAttackMaidShared = attackMaid
				local isAttackActive = true
				attackMaid:GiveTask(function()
					isAttackActive = false
				end)
				if attackState == BossNPCConsts.ATTACK_STATE.ExtendoWhack then
					NPCUtils.setLookAt(obj, NPCUtils.getTarget(obj))
					attackMaid:GiveTask(function()
						NPCUtils.setLookAt(obj, nil)
					end)
					attackMaid:GiveTask(task.delay(BossNPCConsts.EXTENDO_WHACK_DURATION, function()
						if isAttackActive then
							task.defer(BossNPCUtils.setAttackState, obj, BossNPCConsts.ATTACK_STATE.None)
						end
					end))
				elseif attackState == BossNPCConsts.ATTACK_STATE.LaserSweep then
					NPCUtils.setLookAt(obj, NPCUtils.getTarget(obj))
					attackMaid:GiveTask(task.delay(BossNPCConsts.LASER_SWEEP_WARM_UP_DURATION, function()
						local targetParts = {}
						for player, playerInstance in Players:GetPlayers() do
							if playerInstance.Character and playerInstance.Character.PrimaryPart and MansionRobberyUtils.getIsPlayerInRobbery(npcController.obj.Parent, playerInstance) then
								table.insert(targetParts, playerInstance.Character.PrimaryPart)
							end
						end
						local bossCFrame = obj.PrimaryPart.CFrame
						local function resort()
							local clockwiseComparator = GeomUtils.generate2DPointClockwiseComparisonFunction()
							table.sort(targetParts, function(part1, part2)
								local pos1 = bossCFrame:PointToObjectSpace(part1.Position)
								local pos2 = bossCFrame:PointToObjectSpace(part2.Position)
								return clockwiseComparator(Vector2.new(pos1.X, -pos1.Z), (Vector2.new(pos2.X, -pos2.Z)))
							end)
						end
						while #targetParts > 0 and isAttackActive do
							local clockwiseComparator = GeomUtils.generate2DPointClockwiseComparisonFunction()
							table.sort(targetParts, function(part1, part2)
								local pos1 = bossCFrame:PointToObjectSpace(part1.Position)
								local pos2 = bossCFrame:PointToObjectSpace(part2.Position)
								return clockwiseComparator(Vector2.new(pos1.X, -pos1.Z), (Vector2.new(pos2.X, -pos2.Z)))
							end)
							NPCUtils.setTarget(obj, (table.remove(targetParts, 1)))
							NPCUtils.setLookAt(obj, NPCUtils.getTarget(obj))
							task.wait(BossNPCConsts.LASER_SWEEP_TIME_BTWN_TARAGETS)
						end
						if isAttackActive then
							task.defer(BossNPCUtils.setAttackState, obj, BossNPCConsts.ATTACK_STATE.None)
						end
					end))
					attackMaid:GiveTask(function()
						NPCUtils.setLookAt(obj, nil)
					end)
				elseif attackState == BossNPCConsts.ATTACK_STATE.AuraBlast then
					local attackStartTime = os.clock()
					local initialHealth = npcController.humanoid.Health
					local heartbeatConnection = nil
					heartbeatConnection = RunService.Heartbeat:Connect(function()
						local attackProgress = (os.clock() - attackStartTime) / BossNPCConsts.AURA_BLAST_DURATION
						if attackProgress >= 1 then
							heartbeatConnection:Disconnect()
							task.defer(BossNPCUtils.setAttackState, obj, BossNPCConsts.ATTACK_STATE.None)
						else
							npcController.humanoid.Health = math.min(initialHealth + attackProgress * BossNPCConsts.AURA_BLAST_PERCENT_HEALTH_TO_RECOVER / 100 * npcController.humanoid.MaxHealth, npcController.humanoid.MaxHealth)
						end
					end)
					Audio.ObjectLocal(npcController.obj.PrimaryPart, 11793816932, {
						Volume = 1,
						RollOffMinDistance = 128
					})
				end
			end
		end
		handleAttackState()
		npcController.maid:GiveTask(BossNPCUtils.getAttackStateChangedSignal(obj):Connect(handleAttackState))
		local function goToTargetPos(targetPosition)
			if attackState == BossNPCConsts.ATTACK_STATE.None or attackState == BossNPCConsts.ATTACK_STATE.LockedNone then
				if movementState == BossNPCConsts.MOVEMENT_STATE.StrafeTarget then
					local homePosition = NPCUtils.getHomePosition(obj)
					local strafeOffset = targetPosition - (targetPosition - homePosition).Unit * 20 - homePosition
					if strafeOffset.Magnitude > 80 then
						strafeOffset = strafeOffset.Unit * 80
					end
					NPCShared.goTo(npcController, homePosition + strafeOffset)
				elseif movementState == BossNPCConsts.MOVEMENT_STATE.GoToTarget then
					NPCShared.goTo(npcController, targetPosition)
				end
			else
				NPCShared.move(npcController.humanoid, Vector3.new(0, 0, 0))
			end
		end
		function npcController.customUpdateTarget(npcController, updateMaid)
			if NPCUtils.getTargetType(obj) == NPCConsts.DEST_TYPE.OBJ then
				local target = NPCUtils.getTarget(obj)
				if target then
					updateMaid:GiveTask(RunService.Heartbeat:Connect(function()
						goToTargetPos(target.Position)
					end))
					return true
				else
					return false
				end
			else
				return false
			end
		end
	end
}
