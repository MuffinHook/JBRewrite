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
local function shakeCamAt(self, shakeConfig)
	local CurrentCamera = workspace.CurrentCamera
	local Last = Enum.RenderPriority.Last.Value
	local shakeInstance = Shake.new()
	shakeInstance.FadeInTime = 0
	shakeInstance.FadeOutTime = 0.125
	shakeInstance.Frequency = 0.1
	shakeInstance.Amplitude = shakeConfig and shakeConfig.Amplitude or 1
	shakeInstance.PositionInfluence = Vector3.new(1, 1, 1)
	shakeInstance.RotationInfluence = Vector3.new(1, 1, 1)
	shakeInstance.Sustain = shakeConfig and shakeConfig.Sustain or false
	local function callback(positionOffset, rotationOffset)
		local distanceFactor = (CurrentCamera.CFrame.Position - self).Magnitude / 100
		local scaledPositionOffset = Shake.InverseSquare(positionOffset, distanceFactor)
		local scaledRotationOffset = Shake.InverseSquare(rotationOffset, distanceFactor)
		local camera = CurrentCamera
		camera.CFrame = camera.CFrame * (CFrame.new(scaledPositionOffset) * CFrame.Angles(scaledRotationOffset.X, scaledRotationOffset.Y, scaledRotationOffset.Z))
	end
	shakeInstance:Start()
	shakeInstance:BindToRenderStep(Shake.NextRenderName(), Last, callback)
	return function()
		shakeInstance:StopSustain()
	end
end
local BossNPC = {}
BossNPC.__index = BossNPC
setmetatable(BossNPC, NPC)
function BossNPC.new(self, npcData)
	local instance = NPC.new(self, npcData)
	setmetatable(instance, BossNPC)
	instance:_setupArmBoneData()
	local function getTargetPosition()
		local adjustedTargetPosition = Vector3.new(0, 0, 0)
		if NPCUtils.getTargetType(self) == NPCConsts.DEST_TYPE.OBJ then
			local targetEntity = NPCUtils.getTarget(self)
			if targetEntity then
				adjustedTargetPosition = targetEntity.Position
			end
		end
		local Position = instance.obj:GetPivot().Position
		local offsetDirection = adjustedTargetPosition - Position
		local raycastParams = RaycastParams.new()
		raycastParams.FilterDescendantsInstances = { instance.obj }
		local raycastHit = Raycast.collidable(Position, offsetDirection.Unit, offsetDirection.Magnitude, raycastParams)
		if raycastHit then
			adjustedTargetPosition = raycastHit.Position
		end
		return adjustedTargetPosition
	end
	instance.maid.lastAttackMaidClient = nil
	local function handleAttackState()
		if instance.maid.lastAttackMaidClient then
			instance.maid.lastAttackMaidClient = nil
		end
		local mansionModel = instance.obj.Parent
		assert(CollectionService:HasTag(mansionModel, MansionRobberyConsts.TAG_NAME), "Invalid mansionModel")
		if MansionRobberyUtils.getIsPlayerInRobbery(mansionModel, Players.LocalPlayer) then
			local attackState = BossNPCUtils.getAttackState(self)
			if attackState == BossNPCConsts.ATTACK_STATE.ExtendoWhack then
				instance.maid.lastAttackMaidClient = instance:PlayArmGrab(getTargetPosition)
			elseif attackState == BossNPCConsts.ATTACK_STATE.LaserSweep then
				instance.maid.lastAttackMaidClient = instance:PlayLaserSweepVisual(getTargetPosition)
			elseif attackState == BossNPCConsts.ATTACK_STATE.AuraBlast then
				instance:PlayAuraBlast()
			elseif attackState == BossNPCConsts.ATTACK_STATE.MansionLasers then
				instance.maid.lastAttackMaidClient = instance:PlayMansionLasers()
			elseif attackState == BossNPCConsts.ATTACK_STATE.MansionCameras then
				instance.maid.lastAttackMaidClient = instance:PlayMansionCameras()
			elseif attackState == BossNPCConsts.ATTACK_STATE.CallInGuards then
				instance.maid.lastAttackMaidClient = instance:PlayCallInGuards()
			end
		end
	end
	handleAttackState()
	instance.maid:GiveTask(BossNPCUtils.getAttackStateChangedSignal(self):Connect(handleAttackState))
	BossNPCShared.setup(instance)
	return instance
end
function BossNPC._setupArmBoneData(self)
	local armBoneDataTable = {}
	for boneIndex, boneName in { "Shoulder.R.001", "Shoulder.R.002", "Shoulder.R.003", "Shoulder.R.004", "Arm.R.001", "Arm.R.002", "Arm.R.003", "Arm.R.004" } do
		local boneExists
		local boneObject = self.obj.PrimaryPart:FindFirstChild(boneName, true)
		boneExists = boneObject ~= nil
		assert(boneExists, "missing arm bone")
		assert(boneObject:IsA("Bone"), "bone is not a bone")
		table.insert(armBoneDataTable, {
			bone = boneObject,
			cf = boneObject.CFrame
		})
	end
	self.allArmBoneData = armBoneDataTable
	self.armBoneLungeTransforms = {
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
function BossNPC._resetArmBones(self)
	for boneIndex, boneData in self.allArmBoneData do
		boneData.bone.CFrame = boneData.cf
	end
end
function BossNPC._armGrabTarget(self, targetPos, animationAlpha, customTransforms)
	local allArmBoneData = self.allArmBoneData
	local baseWorldCFrame = allArmBoneData[1].bone.TransformedWorldCFrame
	local basePosition = baseWorldCFrame.Position
	for i = 2, #allArmBoneData do
		local boneData
		local boneEntry = allArmBoneData[i]
		local lerpedObjectSpacePos = baseWorldCFrame:PointToObjectSpace(basePosition:Lerp(targetPos, (i - 1) / (#allArmBoneData - 1)))
		boneData = if customTransforms then customTransforms[i] else boneEntry.bone.Transform
		local adjustedCFrame = boneEntry.cf * boneData:Inverse() + lerpedObjectSpacePos
		boneEntry.bone.CFrame = boneEntry.cf:Lerp(adjustedCFrame, animationAlpha)
		baseWorldCFrame = baseWorldCFrame * (adjustedCFrame * boneData)
	end
end
function BossNPC._armAnimateFromTo(self, getTargetPosFn, startAlpha, endAlpha, duration, easingDirection)
	local animationStartTime = os.clock()
	local currentAlpha = nil
	local heartbeatConnection = nil
	heartbeatConnection = RunService.Heartbeat:Connect(function()
		currentAlpha = (os.clock() - animationStartTime) / duration
		if currentAlpha >= 1 then
			currentAlpha = 1
			heartbeatConnection:Disconnect()
			heartbeatConnection = nil
		end
		local tweenAlpha = TweenService:GetValue(currentAlpha, Enum.EasingStyle.Quart, easingDirection)
		self:_armGrabTarget(getTargetPosFn(), startAlpha * (1 - tweenAlpha) + endAlpha * tweenAlpha, self.armBoneLungeTransforms)
	end)
	return function()
		if heartbeatConnection then
			heartbeatConnection:Disconnect()
		end
		return currentAlpha
	end
end
function BossNPC.DisplayAttackIndicator(self, maidContainer)
	local indicatorMaid = Maid.new()
	maidContainer.targetingMaid = indicatorMaid
	local targetEntity = NPCUtils.getTarget(self.obj)
	if targetEntity then
		local targetPlayer = Players:GetPlayerFromCharacter(targetEntity.parent)
		if targetPlayer then
			local indicatorPart = ReplicatedStorage.Resource:FindFirstChild("BossAttackIndicator"):Clone()
			indicatorPart.Anchored = true
			indicatorPart.CanCollide = false
			indicatorPart.CanTouch = false
			indicatorPart.CanQuery = false
			indicatorPart.Parent = workspace
			indicatorMaid:GiveTask(indicatorPart)
			local indicatorStartTime = os.clock()
			indicatorMaid:GiveTask(RunService.Heartbeat:Connect(function()
				if targetPlayer then
					local Character = targetPlayer.Character
					if Character then
						if Character:FindFirstChild("UpperTorso") then
							local playerBasePosition = Character.PrimaryPart.Position - Vector3.new(0, Character.Humanoid.HipHeight + Character.PrimaryPart.Size.Y / 2, 0)
							local rotationAngle = 6.283185307179586 * (os.clock() % 2) / 2
							indicatorPart.CFrame = CFrame.new(playerBasePosition) * CFrame.Angles(0, rotationAngle, 0)
							indicatorPart.Decal.Transparency = math.min(0.9, 1 - (math.cos((os.clock() - indicatorStartTime) * 6) + 1) * 2 / 3)
						else
							indicatorMaid:Destroy()
						end
					else
						indicatorMaid:Destroy()
					end
				else
					indicatorMaid:Destroy()
				end
			end))
		end
	end
end
function BossNPC.PlayArmGrab(self, getTargetPositionFunc)
	local attackMaid = Maid.new()
	local dialogueText = nil
	local targetEntity = NPCUtils.getTarget(self.obj)
	if targetEntity then
		local targetPlayer = Players:GetPlayerFromCharacter(targetEntity.Parent)
		if targetPlayer then
			self:DisplayAttackIndicator(attackMaid)
			local dialogueTexts = { "CEO: %s, you\'re mine!", "CEO: %s, you\'re going nowhere!", "CEO: Not so fast %s!" }
			dialogueText = dialogueTexts[math.random(#dialogueTexts)]:format(targetPlayer.DisplayName)
		end
	end
	if not dialogueText then
		dialogueText = "CEO: You\'re mine!"
	end
	mansionRobberyStore:dispatch({
		type = "setDialogueText",
		text = dialogueText
	})
	task.delay(3, function()
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = ""
		})
	end)
	local lungeAnimation = self.humanoid:WaitForChild("Animator"):LoadAnimation(self.obj:WaitForChild("ActionAnimationsFolder"):WaitForChild("LungeAnimation"))
	lungeAnimation:Play()
	attackMaid:GiveTask(function()
		lungeAnimation:Stop()
		lungeAnimation:Destroy()
	end)
	lungeAnimation:AdjustSpeed(0.2)
	attackMaid:GiveTask(task.delay(BossNPCConsts.EXTENDO_WHACK_WARM_UP_DURATION, function()
		lungeAnimation:AdjustSpeed(1)
		attackMaid.killAnimateTo = self:_armAnimateFromTo(getTargetPositionFunc, 0, 1, lungeAnimation.Length - 0.25, Enum.EasingDirection.In)
		Audio.ObjectLocal(self.obj.PrimaryPart, 11793693522, {
			Volume = 1,
			RollOffMinDistance = 64
		})
	end))
	local hasAttackConnected = false
	attackMaid:GiveTask(lungeAnimation.Stopped:Connect(function()
		if not hasAttackConnected then
			hasAttackConnected = true
			local finalTargetPosition = getTargetPositionFunc()
			if (Players.LocalPlayer.Character.PrimaryPart.Position - finalTargetPosition).Magnitude <= 3 then
				Falling.StartRagdolling(2)
				shakeCamAt(finalTargetPosition)
				Audio.ObjectLocal(Players.LocalPlayer.Character.PrimaryPart, 11793755625, {
					Volume = 1
				})
				self.obj:FindFirstChild(BossNPCConsts.DAMAGE_SELF_REMOTE_NAME):FireServer(40)
			else
				Audio.ObjectLocal(self.obj.PrimaryPart, 11793693028, {
					Volume = 0.3
				})
			end
			self:_armAnimateFromTo(getTargetPositionFunc, 1, 0, 0.2, Enum.EasingDirection.Out)
			task.delay(0.2, function()
				attackMaid:DoCleaning()
				Audio.ObjectLocal(self.obj.PrimaryPart, 11793694003, {
					Volume = 0.5,
					RollOffMinDistance = 64
				})
			end)
		end
	end))
	attackMaid:GiveTask(function()
		self:_resetArmBones()
	end)
	return attackMaid
end
function BossNPC.PlayLaserSweepVisual(self, getTargetPositionFunc)
	local laserDialogues = { "CEO: Block this you filthy casual!", "CEO: I\'ll turn you to dust with this unstoppable weapon!", "CEO: You\'ll never defeat me with that puny arsenal, my laser will decimate you all!", "CEO: You\'ll never be able to dodge my laser\'s deadly beam!" }
	mansionRobberyStore:dispatch({
		type = "setDialogueText",
		text = laserDialogues[math.random(#laserDialogues)]
	})
	task.delay(3, function()
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = ""
		})
	end)
	local laserMaid = Maid.new()
	local aimAnimation = self.humanoid:WaitForChild("Animator"):LoadAnimation(self.obj:WaitForChild("ActionAnimationsFolder"):WaitForChild("AimAnimation"))
	aimAnimation:Play()
	laserMaid:GiveTask(function()
		aimAnimation:Stop()
		aimAnimation:Destroy()
	end)
	local hasAnimationStopped = false
	laserMaid:GiveTask(aimAnimation.Stopped:Connect(function()
		if not hasAnimationStopped then
			hasAnimationStopped = true
			aimAnimation:Play()
			aimAnimation:AdjustSpeed(0)
			aimAnimation.TimePosition = aimAnimation.Length - 0.001
		end
	end))
	Audio.ObjectLocal(self.obj.PrimaryPart, 11831682028, {
		Volume = 0.3,
		RollOffMinDistance = 64
	})
	laserMaid:GiveTask(task.delay(BossNPCConsts.LASER_SWEEP_WARM_UP_DURATION, function()
		local laserBeam = Instance.new("Part")
		laserBeam.CanCollide = false
		laserBeam.CanQuery = false
		laserBeam.CanTouch = false
		laserBeam.Anchored = true
		laserBeam.Material = Enum.Material.Neon
		laserBeam.Color = Color3.new(1, 0.1, 0.1)
		laserBeam.Size = Vector3.new(0.2, 0.2, 1)
		laserBeam.Parent = workspace
		laserMaid:GiveTask(laserBeam)
		Audio.ObjectLocal(laserBeam, 11793588989, {
			Volume = 1
		})
		laserMaid:GiveTask((Audio.ObjectLocal(laserBeam, 11793547887, {
			Looped = true,
			Volume = 0.5
		})))
		local laserEndPosition = self.obj.PrimaryPart.CFrame * Vector3.new(0, -10, -10)
		local hitPlayersSet = {}
		laserMaid:GiveTask(function()
			table.clear(hitPlayersSet)
		end)
		laserMaid:GiveTask(RunService.Heartbeat:Connect(function()
			local laserTargetPosition = getTargetPositionFunc()
			laserEndPosition = laserEndPosition + (laserTargetPosition + (laserTargetPosition - self.obj.PrimaryPart.Position).Unit * 3 - laserEndPosition) * 0.1
			local laserOriginPosition = self.allArmBoneData[#self.allArmBoneData].bone.TransformedWorldCFrame.Position
			local laserDirection = laserEndPosition - laserOriginPosition
			local laserRaycastParams = RaycastParams.new()
			laserRaycastParams.FilterDescendantsInstances = { self.obj }
			local laserRaycastHit = Raycast.collidable(laserOriginPosition, laserDirection.Unit, laserDirection.Magnitude, laserRaycastParams)
			local laserFinalPosition = if laserRaycastHit then laserRaycastHit.Position else laserOriginPosition + laserDirection
			local laserLength = (laserFinalPosition - laserOriginPosition).Magnitude
			laserBeam.Size = Vector3.new(0.2, 0.2, laserLength)
			laserBeam.CFrame = CFrame.lookAt(Vector3.new(), laserFinalPosition - laserOriginPosition) * CFrame.new(0, 0, -laserLength * 0.5) + laserOriginPosition
			if (Players.LocalPlayer.Character.PrimaryPart.Position - laserFinalPosition).Magnitude <= 3 and not hitPlayersSet[Players.LocalPlayer] then
				self.obj:FindFirstChild(BossNPCConsts.DAMAGE_SELF_REMOTE_NAME):FireServer(40)
				Audio.ObjectLocal(Players.LocalPlayer.Character.PrimaryPart, 11793588652, {
					Volume = 1
				})
				hitPlayersSet[Players.LocalPlayer] = true
			end
		end))
	end))
	return laserMaid
end
function BossNPC.PlayMansionLasers(self)
	local laserMaid = Maid.new()
	local waveAnimation = self.humanoid:WaitForChild("Animator"):LoadAnimation(self.obj:WaitForChild("ActionAnimationsFolder"):WaitForChild("WaveRightAnimation"))
	laserMaid:GiveTask(task.delay(BossNPCConsts.WALK_TO_DEST_DURATION, function()
		Audio.ObjectLocal(self.obj.PrimaryPart, 11793818720, {
			Volume = 0.5
		})
		waveAnimation:Play()
		laserMaid:GiveTask(function()
			waveAnimation:Stop()
			waveAnimation:Destroy()
		end)
	end))
	return laserMaid
end
function BossNPC.PlayMansionCameras(self)
	local cameraMaid = Maid.new()
	local waveAnimation = self.humanoid:WaitForChild("Animator"):LoadAnimation(self.obj:WaitForChild("ActionAnimationsFolder"):WaitForChild("WaveLeftAnimation"))
	cameraMaid:GiveTask(task.delay(BossNPCConsts.WALK_TO_DEST_DURATION, function()
		Audio.ObjectLocal(self.obj.PrimaryPart, 11793818720, {
			Volume = 0.5
		})
		waveAnimation:Play()
		cameraMaid:GiveTask(function()
			waveAnimation:Stop()
			waveAnimation:Destroy()
		end)
	end))
	return cameraMaid
end
function BossNPC.PlayCallInGuards(self)
	local guardsMaid = Maid.new()
	local waveAnimation = self.humanoid:WaitForChild("Animator"):LoadAnimation(self.obj:WaitForChild("ActionAnimationsFolder"):WaitForChild("WaveLeftAnimation"))
	waveAnimation:Play()
	Audio.ObjectLocal(self.obj.PrimaryPart, 11793818440, {
		Volume = 0.5
	})
	guardsMaid:GiveTask(function()
		waveAnimation:Stop()
		waveAnimation:Destroy()
	end)
	return guardsMaid
end
function BossNPC.PlayAuraBlast(self)
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
	local auraMaid = Maid.new()
	self.maid.auraMaid = auraMaid
	local AuraPart = Instance.new("Part")
	AuraPart.Shape = Enum.PartType.Ball
	AuraPart.Position = self.obj.PrimaryPart.Position
	AuraPart.Name = "AuraPart"
	AuraPart.Color = Color3.fromRGB(85, 0, 170)
	AuraPart.Material = Enum.Material.Neon
	AuraPart.Transparency = 0.3
	AuraPart.CanCollide = false
	AuraPart.Anchored = true
	AuraPart.Size = Vector3.new(0, 0, 0)
	AuraPart.Parent = self.obj
	auraMaid:GiveTask(AuraPart)
	local auraStartTime = workspace:GetServerTimeNow()
	local hasPlayerBeenHit = false
	local function isPlayerInAura()
		local Character = Players.LocalPlayer.Character
		if Character then
			return (Character.PrimaryPart.Position - AuraPart.Position).Magnitude <= AuraPart.Size.X / 2
		end
	end
	auraMaid:GiveTask((shakeCamAt(self.obj.PrimaryPart.Position, {
		Sustain = true,
		Amplitude = 0.1
	})))
	auraMaid:GiveTask(RunService.Heartbeat:Connect(function()
		local auraElapsedRatio = (workspace:GetServerTimeNow() - auraStartTime) / BossNPCConsts.AURA_BLAST_DURATION
		if auraElapsedRatio > 1 then
			auraMaid:Destroy()
		else
			local auraSize = auraElapsedRatio * BossNPCConsts.AURA_BLAST_MAX_SIZE
			AuraPart.Size = Vector3.new(auraSize, auraSize, auraSize)
			if not hasPlayerBeenHit then
				local Character = Players.LocalPlayer.Character
				if if Character then (Character.PrimaryPart.Position - AuraPart.Position).Magnitude <= AuraPart.Size.X / 2 else nil then
					Falling.StartRagdolling(2)
					hasPlayerBeenHit = true
				end
			end
		end
	end))
	return auraMaid
end
return ManifestBinder.new(BossNPCConsts.TAG_NAME, {
	humanoid = "Humanoid"
}, BossNPC)
