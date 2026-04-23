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
	setup = function(p1) --[[ Name: setup | Line: 15 | Upvalues: BossNPCUtils (copy), Maid (copy), BossNPCConsts (copy), NPCUtils (copy), Players (copy), MansionRobberyUtils (copy), GeomUtils (copy), RunService (copy), Audio (copy), NPCShared (copy), NPCConsts (copy) ]]
		local obj = p1.obj
		local v1 = nil
		local function handleMovement() --[[ Line: 19 | Upvalues: v1 (ref), BossNPCUtils (ref), obj (copy) ]]
			v1 = BossNPCUtils.getMovementState(obj)
		end
		v1 = BossNPCUtils.getMovementState(obj)
		p1.maid:GiveTask(BossNPCUtils.getMovementStateChangedSignal(obj):Connect(handleMovement))
		local v2 = nil
		p1.maid.lastAttackMaidShared = nil
		local function handleAttackState() --[[ Line: 27 | Upvalues: v2 (ref), BossNPCUtils (ref), obj (copy), p1 (copy), Maid (ref), BossNPCConsts (ref), NPCUtils (ref), Players (ref), MansionRobberyUtils (ref), GeomUtils (ref), RunService (ref), Audio (ref) ]]
			v2 = BossNPCUtils.getAttackState(obj)
			if p1:IsLocallyOwned() then
				local v1 = Maid.new()
				p1.maid.lastAttackMaidShared = v1
				local v22 = true
				v1:GiveTask(function() --[[ Line: 38 | Upvalues: v22 (ref) ]]
					v22 = false
				end)
				if v2 == BossNPCConsts.ATTACK_STATE.ExtendoWhack then
					NPCUtils.setLookAt(obj, NPCUtils.getTarget(obj))
					v1:GiveTask(function() --[[ Line: 43 | Upvalues: NPCUtils (ref), obj (ref) ]]
						NPCUtils.setLookAt(obj, nil)
					end)
					v1:GiveTask(task.delay(BossNPCConsts.EXTENDO_WHACK_DURATION, function() --[[ Line: 46 | Upvalues: v22 (ref), BossNPCUtils (ref), obj (ref), BossNPCConsts (ref) ]]
						if v22 then
							task.defer(BossNPCUtils.setAttackState, obj, BossNPCConsts.ATTACK_STATE.None)
						end
					end))
				elseif v2 == BossNPCConsts.ATTACK_STATE.LaserSweep then
					NPCUtils.setLookAt(obj, NPCUtils.getTarget(obj))
					v1:GiveTask(task.delay(BossNPCConsts.LASER_SWEEP_WARM_UP_DURATION, function() --[[ Line: 55 | Upvalues: Players (ref), p1 (ref), MansionRobberyUtils (ref), obj (ref), GeomUtils (ref), v22 (ref), NPCUtils (ref), BossNPCConsts (ref), BossNPCUtils (ref) ]]
						local t = {}
						for v1, v2 in Players:GetPlayers() do
							if v2.Character and v2.Character.PrimaryPart and MansionRobberyUtils.getIsPlayerInRobbery(p1.obj.Parent, v2) then
								table.insert(t, v2.Character.PrimaryPart)
							end
						end
						local v4 = obj.PrimaryPart.CFrame
						local function resort() --[[ Line: 73 | Upvalues: GeomUtils (ref), t (copy), v4 (copy) ]]
							local v1 = GeomUtils.generate2DPointClockwiseComparisonFunction()
							table.sort(t, function(p1, p2) --[[ Line: 75 | Upvalues: v4 (ref), v1 (copy) ]]
								local v12 = v4:PointToObjectSpace(p1.Position)
								local v2 = v4:PointToObjectSpace(p2.Position)
								return v1(Vector2.new(v12.X, -v12.Z), (Vector2.new(v2.X, -v2.Z)))
							end)
						end
						while #t > 0 and v22 do
							local v5 = GeomUtils.generate2DPointClockwiseComparisonFunction()
							table.sort(t, function(p1, p2) --[[ Line: 75 | Upvalues: v4 (copy), v5 (copy) ]]
								local v1 = v4:PointToObjectSpace(p1.Position)
								local v2 = v4:PointToObjectSpace(p2.Position)
								return v5(Vector2.new(v1.X, -v1.Z), (Vector2.new(v2.X, -v2.Z)))
							end)
							NPCUtils.setTarget(obj, (table.remove(t, 1)))
							NPCUtils.setLookAt(obj, NPCUtils.getTarget(obj))
							task.wait(BossNPCConsts.LASER_SWEEP_TIME_BTWN_TARAGETS)
						end
						if v22 then
							task.defer(BossNPCUtils.setAttackState, obj, BossNPCConsts.ATTACK_STATE.None)
						end
					end))
					v1:GiveTask(function() --[[ Line: 103 | Upvalues: NPCUtils (ref), obj (ref) ]]
						NPCUtils.setLookAt(obj, nil)
					end)
				elseif v2 == BossNPCConsts.ATTACK_STATE.AuraBlast then
					local v3 = os.clock()
					local Health = p1.humanoid.Health
					local v4 = nil
					v4 = RunService.Heartbeat:Connect(function() --[[ Line: 111 | Upvalues: v3 (copy), BossNPCConsts (ref), v4 (ref), BossNPCUtils (ref), obj (ref), p1 (ref), Health (copy) ]]
						local v1 = (os.clock() - v3) / BossNPCConsts.AURA_BLAST_DURATION
						if v1 >= 1 then
							v4:Disconnect()
							task.defer(BossNPCUtils.setAttackState, obj, BossNPCConsts.ATTACK_STATE.None)
						else
							p1.humanoid.Health = math.min(Health + v1 * BossNPCConsts.AURA_BLAST_PERCENT_HEALTH_TO_RECOVER / 100 * p1.humanoid.MaxHealth, p1.humanoid.MaxHealth)
						end
					end)
					Audio.ObjectLocal(p1.obj.PrimaryPart, 11793816932, {
						Volume = 1,
						RollOffMinDistance = 128
					})
				end
			end
		end
		handleAttackState()
		p1.maid:GiveTask(BossNPCUtils.getAttackStateChangedSignal(obj):Connect(handleAttackState))
		local function goToTargetPos(p12) --[[ Line: 131 | Upvalues: v2 (ref), BossNPCConsts (ref), NPCShared (ref), p1 (copy), v1 (ref), NPCUtils (ref), obj (copy) ]]
			if v2 == BossNPCConsts.ATTACK_STATE.None or v2 == BossNPCConsts.ATTACK_STATE.LockedNone then
				if v1 == BossNPCConsts.MOVEMENT_STATE.StrafeTarget then
					local v12 = NPCUtils.getHomePosition(obj)
					local v22 = p12 - (p12 - v12).Unit * 20 - v12
					if v22.Magnitude > 80 then
						v22 = v22.Unit * 80
					end
					NPCShared.goTo(p1, v12 + v22)
				elseif v1 == BossNPCConsts.MOVEMENT_STATE.GoToTarget then
					NPCShared.goTo(p1, p12)
				end
			else
				NPCShared.move(p1.humanoid, Vector3.new(0, 0, 0))
			end
		end
		function p1.customUpdateTarget(p1, p2) --[[ Line: 152 | Upvalues: NPCUtils (ref), obj (copy), NPCConsts (ref), RunService (ref), goToTargetPos (copy) ]]
			if NPCUtils.getTargetType(obj) == NPCConsts.DEST_TYPE.OBJ then
				local v1 = NPCUtils.getTarget(obj)
				if v1 then
					p2:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 159 | Upvalues: goToTargetPos (ref), v1 (copy) ]]
						goToTargetPos(v1.Position)
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