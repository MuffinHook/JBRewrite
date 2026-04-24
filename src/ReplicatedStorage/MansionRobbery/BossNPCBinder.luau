-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Raycast = require(ReplicatedStorage.Std.Raycast)
local Audio = require(ReplicatedStorage.Std.Audio)
local TweenService = game:GetService("TweenService")
local NPC = require(ReplicatedStorage.NPC.NPC)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local BossNPCConsts = require(ReplicatedStorage.MansionRobbery.BossNPCConsts)
local BossNPCUtils = require(ReplicatedStorage.MansionRobbery.BossNPCUtils)
local Falling = require(ReplicatedStorage.Game.Falling)
local BossNPCShared = require(ReplicatedStorage.MansionRobbery.BossNPCShared)
local Maid = require(ReplicatedStorage.Std.Maid)
local RunService = game:GetService("RunService")
local mansionRobberyStore = require(ReplicatedStorage.MansionRobbery.mansionRobberyStore)
local MansionRobberyConsts = require(ReplicatedStorage.MansionRobbery.MansionRobberyConsts)
local CollectionService = game:GetService("CollectionService")
local MansionRobberyUtils = require(ReplicatedStorage.MansionRobbery.MansionRobberyUtils)
local NPCUtils = require(ReplicatedStorage.NPC.NPCUtils)
local NPCConsts = require(ReplicatedStorage.NPC.NPCConsts)
local Shake = require(ReplicatedStorage.Module.Shake)
local function shakeCamAt(p1, p2)
	local CurrentCamera = workspace.CurrentCamera
	local Last = Enum.RenderPriority.Last.Value
	local v1 = Shake.new()
	v1.FadeInTime = 0
	v1.FadeOutTime = 0.125
	v1.Frequency = 0.1
	v1.Amplitude = p2 and p2.Amplitude or 1
	v1.PositionInfluence = Vector3.new(1, 1, 1)
	v1.RotationInfluence = Vector3.new(1, 1, 1)
	v1.Sustain = p2 and p2.Sustain or false
	local function callback(p12, p2)
		local v1 = (CurrentCamera.CFrame.Position - p1).Magnitude / 100
		local v2 = Shake.InverseSquare(p12, v1)
		local v3 = Shake.InverseSquare(p2, v1)
		local v4 = CurrentCamera
		v4.CFrame = v4.CFrame * (CFrame.new(v2) * CFrame.Angles(v3.X, v3.Y, v3.Z))
	end
	v1:Start()
	v1:BindToRenderStep(Shake.NextRenderName(), Last, callback)
	return function()
		v1:StopSustain()
	end
end
local t = {}
t.__index = t
setmetatable(t, NPC)
function t.new(p1, p2)
	local v1 = NPC.new(p1, p2)
	setmetatable(v1, t)
	v1:_setupArmBoneData()
	local function getTargetPosition()
		local v12 = Vector3.new(0, 0, 0)
		if NPCUtils.getTargetType(p1) == NPCConsts.DEST_TYPE.OBJ then
			local v2 = NPCUtils.getTarget(p1)
			if v2 then
				v12 = v2.Position
			end
		end
		local Position = v1.obj:GetPivot().Position
		local v3 = v12 - Position
		local v4 = RaycastParams.new()
		v4.FilterDescendantsInstances = { v1.obj }
		local v5 = Raycast.collidable(Position, v3.Unit, v3.Magnitude, v4)
		if v5 then
			v12 = v5.Position
		end
		return v12
	end
	v1.maid.lastAttackMaidClient = nil
	local function handleAttackState()
		if v1.maid.lastAttackMaidClient then
			v1.maid.lastAttackMaidClient = nil
		end
		local v12 = v1.obj.Parent
		assert(CollectionService:HasTag(v12, MansionRobberyConsts.TAG_NAME), "Invalid mansionModel")
		if MansionRobberyUtils.getIsPlayerInRobbery(v12, Players.LocalPlayer) then
			local v3 = BossNPCUtils.getAttackState(p1)
			if v3 == BossNPCConsts.ATTACK_STATE.ExtendoWhack then
				v1.maid.lastAttackMaidClient = v1:PlayArmGrab(getTargetPosition)
			elseif v3 == BossNPCConsts.ATTACK_STATE.LaserSweep then
				v1.maid.lastAttackMaidClient = v1:PlayLaserSweepVisual(getTargetPosition)
			elseif v3 == BossNPCConsts.ATTACK_STATE.AuraBlast then
				v1:PlayAuraBlast()
			elseif v3 == BossNPCConsts.ATTACK_STATE.MansionLasers then
				v1.maid.lastAttackMaidClient = v1:PlayMansionLasers()
			elseif v3 == BossNPCConsts.ATTACK_STATE.MansionCameras then
				v1.maid.lastAttackMaidClient = v1:PlayMansionCameras()
			elseif v3 == BossNPCConsts.ATTACK_STATE.CallInGuards then
				v1.maid.lastAttackMaidClient = v1:PlayCallInGuards()
			end
		end
	end
	handleAttackState()
	v1.maid:GiveTask(BossNPCUtils.getAttackStateChangedSignal(p1):Connect(handleAttackState))
	BossNPCShared.setup(v1)
	return v1
end
function t._setupArmBoneData(p1)
	local t = {}
	for v2, v3 in { "Shoulder.R.001", "Shoulder.R.002", "Shoulder.R.003", "Shoulder.R.004", "Arm.R.001", "Arm.R.002", "Arm.R.003", "Arm.R.004" } do
		local v1
		local v4 = p1.obj.PrimaryPart:FindFirstChild(v3, true)
		v1 = v4 ~= nil
		assert(v1, "missing arm bone")
		assert(v4:IsA("Bone"), "bone is not a bone")
		table.insert(t, {
			bone = v4,
			cf = v4.CFrame
		})
	end
	p1.allArmBoneData = t
	p1.armBoneLungeTransforms = {
		CFrame.new(),
		CFrame.new(-0.53, 0.86, -0.07) * CFrame.Angles(0, -0.0002, 0.4672),
		CFrame.new(-0.57, 1.69, -0.13) * CFrame.Angles(0.0011, 0.0001, 0.1352),
		CFrame.new(-0.49, 2.11, -0.19) * CFrame.Angles(0.0008, 0.0001, 0.1112),
		CFrame.new(-0.02, 1.97, 0.02) * CFrame.Angles(0.0004, 0, -0.0002),
		CFrame.new(-0.01, 1.42, 0.02) * CFrame.Angles(0.0006, 0.0002, -0.0003),
		CFrame.new(0.07, 1.58, 0.49) * CFrame.Angles(0.2438, 0.1018, -0.0016),
		CFrame.new(0.06, 2.17, -0.15) * CFrame.Angles(0.0011, 0.0002, 0.1974)
	}
end
function t._resetArmBones(p1)
	for v1, v2 in p1.allArmBoneData do
		v2.bone.CFrame = v2.cf
	end
end
function t._armGrabTarget(p1, p2, p3, p4)
	local allArmBoneData = p1.allArmBoneData
	local TransformedWorldCFrame = allArmBoneData[1].bone.TransformedWorldCFrame
	local Position = TransformedWorldCFrame.Position
	for i = 2, #allArmBoneData do
		local v1
		local v2 = allArmBoneData[i]
		local v3 = TransformedWorldCFrame:PointToObjectSpace(Position:Lerp(p2, (i - 1) / (#allArmBoneData - 1)))
		v1 = if p4 then p4[i] else v2.bone.Transform
		local v4 = v2.cf * v1:Inverse() + v3
		v2.bone.CFrame = v2.cf:Lerp(v4, p3)
		TransformedWorldCFrame = TransformedWorldCFrame * (v4 * v1)
	end
end
function t._armAnimateFromTo(p1, p2, p3, p4, p5, p6)
	local v1 = os.clock()
	local v2 = nil
	local v3 = nil
	v3 = RunService.Heartbeat:Connect(function()
		v2 = (os.clock() - v1) / p5
		if v2 >= 1 then
			v2 = 1
			v3:Disconnect()
			v3 = nil
		end
		local v12 = TweenService:GetValue(v2, Enum.EasingStyle.Quart, p6)
		p1:_armGrabTarget(p2(), p3 * (1 - v12) + p4 * v12, p1.armBoneLungeTransforms)
	end)
	return function()
		if v3 then
			v3:Disconnect()
		end
		return v2
	end
end
function t.DisplayAttackIndicator(p1, p2)
	local v1 = Maid.new()
	p2.targetingMaid = v1
	local v2 = NPCUtils.getTarget(p1.obj)
	if v2 then
		local v3 = Players:GetPlayerFromCharacter(v2.parent)
		if v3 then
			local v4 = ReplicatedStorage.Resource:FindFirstChild("BossAttackIndicator"):Clone()
			v4.Anchored = true
			v4.CanCollide = false
			v4.CanTouch = false
			v4.CanQuery = false
			v4.Parent = workspace
			v1:GiveTask(v4)
			local v5 = os.clock()
			v1:GiveTask(RunService.Heartbeat:Connect(function()
				if v3 then
					local Character = v3.Character
					if Character then
						if Character:FindFirstChild("UpperTorso") then
							local v2 = Character.PrimaryPart.Position - Vector3.new(0, Character.Humanoid.HipHeight + Character.PrimaryPart.Size.Y / 2, 0)
							local v32 = 6.283185307179586 * (os.clock() % 2) / 2
							v4.CFrame = CFrame.new(v2) * CFrame.Angles(0, v32, 0)
							v4.Decal.Transparency = math.min(0.9, 1 - (math.cos((os.clock() - v5) * 6) + 1) * 2 / 3)
						else
							v1:Destroy()
						end
					else
						v1:Destroy()
					end
				else
					v1:Destroy()
				end
			end))
		end
	end
end
function t.PlayArmGrab(p1, p2)
	local v1 = Maid.new()
	local v2 = nil
	local v3 = NPCUtils.getTarget(p1.obj)
	if v3 then
		local v4 = Players:GetPlayerFromCharacter(v3.Parent)
		if v4 then
			p1:DisplayAttackIndicator(v1)
			local t = { "CEO: %s, you\'re mine!", "CEO: %s, you\'re going nowhere!", "CEO: Not so fast %s!" }
			v2 = t[math.random(#t)]:format(v4.DisplayName)
		end
	end
	if not v2 then
		v2 = "CEO: You\'re mine!"
	end
	mansionRobberyStore:dispatch({
		type = "setDialogueText",
		text = v2
	})
	task.delay(3, function()
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = ""
		})
	end)
	local v6 = p1.humanoid:WaitForChild("Animator"):LoadAnimation(p1.obj:WaitForChild("ActionAnimationsFolder"):WaitForChild("LungeAnimation"))
	v6:Play()
	v1:GiveTask(function()
		v6:Stop()
		v6:Destroy()
	end)
	v6:AdjustSpeed(0.2)
	v1:GiveTask(task.delay(BossNPCConsts.EXTENDO_WHACK_WARM_UP_DURATION, function()
		v6:AdjustSpeed(1)
		v1.killAnimateTo = p1:_armAnimateFromTo(p2, 0, 1, v6.Length - 0.25, Enum.EasingDirection.In)
		Audio.ObjectLocal(p1.obj.PrimaryPart, 11793693522, {
			Volume = 1,
			RollOffMinDistance = 64
		})
	end))
	local v7 = false
	v1:GiveTask(v6.Stopped:Connect(function()
		if not v7 then
			v7 = true
			local v12 = p2()
			if (Players.LocalPlayer.Character.PrimaryPart.Position - v12).Magnitude <= 3 then
				Falling.StartRagdolling(2)
				shakeCamAt(v12)
				Audio.ObjectLocal(Players.LocalPlayer.Character.PrimaryPart, 11793755625, {
					Volume = 1
				})
				p1.obj:FindFirstChild(BossNPCConsts.DAMAGE_SELF_REMOTE_NAME):FireServer(40)
			else
				Audio.ObjectLocal(p1.obj.PrimaryPart, 11793693028, {
					Volume = 0.3
				})
			end
			p1:_armAnimateFromTo(p2, 1, 0, 0.2, Enum.EasingDirection.Out)
			task.delay(0.2, function()
				v1:DoCleaning()
				Audio.ObjectLocal(p1.obj.PrimaryPart, 11793694003, {
					Volume = 0.5,
					RollOffMinDistance = 64
				})
			end)
		end
	end))
	v1:GiveTask(function()
		p1:_resetArmBones()
	end)
	return v1
end
function t.PlayLaserSweepVisual(p1, p2)
	local t = { "CEO: Block this you filthy casual!", "CEO: I\'ll turn you to dust with this unstoppable weapon!", "CEO: You\'ll never defeat me with that puny arsenal, my laser will decimate you all!", "CEO: You\'ll never be able to dodge my laser\'s deadly beam!" }
	mansionRobberyStore:dispatch({
		type = "setDialogueText",
		text = t[math.random(#t)]
	})
	task.delay(3, function()
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = ""
		})
	end)
	local v1 = Maid.new()
	local v2 = p1.humanoid:WaitForChild("Animator"):LoadAnimation(p1.obj:WaitForChild("ActionAnimationsFolder"):WaitForChild("AimAnimation"))
	v2:Play()
	v1:GiveTask(function()
		v2:Stop()
		v2:Destroy()
	end)
	local v3 = false
	v1:GiveTask(v2.Stopped:Connect(function()
		if not v3 then
			v3 = true
			v2:Play()
			v2:AdjustSpeed(0)
			v2.TimePosition = v2.Length - 0.001
		end
	end))
	Audio.ObjectLocal(p1.obj.PrimaryPart, 11831682028, {
		Volume = 0.3,
		RollOffMinDistance = 64
	})
	v1:GiveTask(task.delay(BossNPCConsts.LASER_SWEEP_WARM_UP_DURATION, function()
		local Part = Instance.new("Part")
		Part.CanCollide = false
		Part.CanQuery = false
		Part.CanTouch = false
		Part.Anchored = true
		Part.Material = Enum.Material.Neon
		Part.Color = Color3.new(1, 0.1, 0.1)
		Part.Size = Vector3.new(0.2, 0.2, 1)
		Part.Parent = workspace
		v1:GiveTask(Part)
		Audio.ObjectLocal(Part, 11793588989, {
			Volume = 1
		})
		v1:GiveTask((Audio.ObjectLocal(Part, 11793547887, {
			Looped = true,
			Volume = 0.5
		})))
		local v12 = p1.obj.PrimaryPart.CFrame * Vector3.new(0, -10, -10)
		local t = {}
		v1:GiveTask(function()
			table.clear(t)
		end)
		v1:GiveTask(RunService.Heartbeat:Connect(function()
			local v1 = p2()
			v12 = v12 + (v1 + (v1 - p1.obj.PrimaryPart.Position).Unit * 3 - v12) * 0.1
			local Position = p1.allArmBoneData[#p1.allArmBoneData].bone.TransformedWorldCFrame.Position
			local v2 = v12 - Position
			local v3 = RaycastParams.new()
			v3.FilterDescendantsInstances = { p1.obj }
			local v4 = Raycast.collidable(Position, v2.Unit, v2.Magnitude, v3)
			local v5 = if v4 then v4.Position else Position + v2
			local Magnitude = (v5 - Position).Magnitude
			Part.Size = Vector3.new(0.2, 0.2, Magnitude)
			Part.CFrame = CFrame.lookAt(Vector3.new(), v5 - Position) * CFrame.new(0, 0, -Magnitude * 0.5) + Position
			if (Players.LocalPlayer.Character.PrimaryPart.Position - v5).Magnitude <= 3 and not t[Players.LocalPlayer] then
				p1.obj:FindFirstChild(BossNPCConsts.DAMAGE_SELF_REMOTE_NAME):FireServer(40)
				Audio.ObjectLocal(Players.LocalPlayer.Character.PrimaryPart, 11793588652, {
					Volume = 1
				})
				t[Players.LocalPlayer] = true
			end
		end))
	end))
	return v1
end
function t.PlayMansionLasers(p1)
	local v1 = Maid.new()
	local v2 = p1.humanoid:WaitForChild("Animator"):LoadAnimation(p1.obj:WaitForChild("ActionAnimationsFolder"):WaitForChild("WaveRightAnimation"))
	v1:GiveTask(task.delay(BossNPCConsts.WALK_TO_DEST_DURATION, function()
		Audio.ObjectLocal(p1.obj.PrimaryPart, 11793818720, {
			Volume = 0.5
		})
		v2:Play()
		v1:GiveTask(function()
			v2:Stop()
			v2:Destroy()
		end)
	end))
	return v1
end
function t.PlayMansionCameras(p1)
	local v1 = Maid.new()
	local v2 = p1.humanoid:WaitForChild("Animator"):LoadAnimation(p1.obj:WaitForChild("ActionAnimationsFolder"):WaitForChild("WaveLeftAnimation"))
	v1:GiveTask(task.delay(BossNPCConsts.WALK_TO_DEST_DURATION, function()
		Audio.ObjectLocal(p1.obj.PrimaryPart, 11793818720, {
			Volume = 0.5
		})
		v2:Play()
		v1:GiveTask(function()
			v2:Stop()
			v2:Destroy()
		end)
	end))
	return v1
end
function t.PlayCallInGuards(p1)
	local v1 = Maid.new()
	local v2 = p1.humanoid:WaitForChild("Animator"):LoadAnimation(p1.obj:WaitForChild("ActionAnimationsFolder"):WaitForChild("WaveLeftAnimation"))
	v2:Play()
	Audio.ObjectLocal(p1.obj.PrimaryPart, 11793818440, {
		Volume = 0.5
	})
	v1:GiveTask(function()
		v2:Stop()
		v2:Destroy()
	end)
	return v1
end
function t.PlayAuraBlast(p1)
	mansionRobberyStore:dispatch({
		type = "setDialogueText",
		text = "CEO: Alright this has been going on too long. Enough is ENOUGH!"
	})
	task.delay(4, function()
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = ""
		})
	end)
	local v1 = Maid.new()
	p1.maid.auraMaid = v1
	local AuraPart = Instance.new("Part")
	AuraPart.Shape = Enum.PartType.Ball
	AuraPart.Position = p1.obj.PrimaryPart.Position
	AuraPart.Name = "AuraPart"
	AuraPart.Color = Color3.fromRGB(85, 0, 170)
	AuraPart.Material = Enum.Material.Neon
	AuraPart.Transparency = 0.3
	AuraPart.CanCollide = false
	AuraPart.Anchored = true
	AuraPart.Size = Vector3.new(0, 0, 0)
	AuraPart.Parent = p1.obj
	v1:GiveTask(AuraPart)
	local v2 = workspace:GetServerTimeNow()
	local v3 = false
	local function isPlayerInAura()
		local Character = Players.LocalPlayer.Character
		if Character then
			return (Character.PrimaryPart.Position - AuraPart.Position).Magnitude <= AuraPart.Size.X / 2
		end
	end
	v1:GiveTask((shakeCamAt(p1.obj.PrimaryPart.Position, {
		Sustain = true,
		Amplitude = 0.1
	})))
	v1:GiveTask(RunService.Heartbeat:Connect(function()
		local v12 = (workspace:GetServerTimeNow() - v2) / BossNPCConsts.AURA_BLAST_DURATION
		if v12 > 1 then
			v1:Destroy()
		else
			local v22 = v12 * BossNPCConsts.AURA_BLAST_MAX_SIZE
			AuraPart.Size = Vector3.new(v22, v22, v22)
			if not v3 then
				local Character = Players.LocalPlayer.Character
				if if Character then (Character.PrimaryPart.Position - AuraPart.Position).Magnitude <= AuraPart.Size.X / 2 else nil then
					Falling.StartRagdolling(2)
					v3 = true
				end
			end
		end
	end))
	return v1
end
return ManifestBinder.new(BossNPCConsts.TAG_NAME, {
	humanoid = "Humanoid"
}, t)
