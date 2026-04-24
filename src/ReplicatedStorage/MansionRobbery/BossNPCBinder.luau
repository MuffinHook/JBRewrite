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
local function shakeCamAt(self, p2)
	local CurrentCamera = workspace.CurrentCamera
	local Last = Enum.RenderPriority.Last.Value
	local instance = Shake.new()
	instance.FadeInTime = 0
	instance.FadeOutTime = 0.125
	instance.Frequency = 0.1
	instance.Amplitude = p2 and p2.Amplitude or 1
	instance.PositionInfluence = Vector3.new(1, 1, 1)
	instance.RotationInfluence = Vector3.new(1, 1, 1)
	instance.Sustain = p2 and p2.Sustain or false
	local function callback(p12, p2)
		local instance = (CurrentCamera.CFrame.Position - self).Magnitude / 100
		local vector2 = Shake.InverseSquare(p12, instance)
		local var3 = Shake.InverseSquare(p2, instance)
		local var4 = CurrentCamera
		var4.CFrame = var4.CFrame * (CFrame.new(vector2) * CFrame.Angles(var3.X, var3.Y, var3.Z))
	end
	instance:Start()
	instance:BindToRenderStep(Shake.NextRenderName(), Last, callback)
	return function()
		instance:StopSustain()
	end
end
local t = {}
t.__index = t
setmetatable(t, NPC)
function t.new(self, p2)
	local instance = NPC.new(self, p2)
	setmetatable(instance, t)
	instance:_setupArmBoneData()
	local function getTargetPosition()
		local vector12 = Vector3.new(0, 0, 0)
		if NPCUtils.getTargetType(self) == NPCConsts.DEST_TYPE.OBJ then
			local vector2 = NPCUtils.getTarget(self)
			if vector2 then
				vector12 = vector2.Position
			end
		end
		local Position = instance.obj:GetPivot().Position
		local var3 = vector12 - Position
		local var4 = RaycastParams.new()
		var4.FilterDescendantsInstances = { instance.obj }
		local var5 = Raycast.collidable(Position, var3.Unit, var3.Magnitude, var4)
		if var5 then
			vector12 = var5.Position
		end
		return vector12
	end
	instance.maid.lastAttackMaidClient = nil
	local function handleAttackState()
		if instance.maid.lastAttackMaidClient then
			instance.maid.lastAttackMaidClient = nil
		end
		local vector12 = instance.obj.Parent
		assert(CollectionService:HasTag(vector12, MansionRobberyConsts.TAG_NAME), "Invalid mansionModel")
		if MansionRobberyUtils.getIsPlayerInRobbery(vector12, Players.LocalPlayer) then
			local var3 = BossNPCUtils.getAttackState(self)
			if var3 == BossNPCConsts.ATTACK_STATE.ExtendoWhack then
				instance.maid.lastAttackMaidClient = instance:PlayArmGrab(getTargetPosition)
			elseif var3 == BossNPCConsts.ATTACK_STATE.LaserSweep then
				instance.maid.lastAttackMaidClient = instance:PlayLaserSweepVisual(getTargetPosition)
			elseif var3 == BossNPCConsts.ATTACK_STATE.AuraBlast then
				instance:PlayAuraBlast()
			elseif var3 == BossNPCConsts.ATTACK_STATE.MansionLasers then
				instance.maid.lastAttackMaidClient = instance:PlayMansionLasers()
			elseif var3 == BossNPCConsts.ATTACK_STATE.MansionCameras then
				instance.maid.lastAttackMaidClient = instance:PlayMansionCameras()
			elseif var3 == BossNPCConsts.ATTACK_STATE.CallInGuards then
				instance.maid.lastAttackMaidClient = instance:PlayCallInGuards()
			end
		end
	end
	handleAttackState()
	instance.maid:GiveTask(BossNPCUtils.getAttackStateChangedSignal(self):Connect(handleAttackState))
	BossNPCShared.setup(instance)
	return instance
end
function t._setupArmBoneData(self)
	local t = {}
	for vector2, var3 in { "Shoulder.R.001", "Shoulder.R.002", "Shoulder.R.003", "Shoulder.R.004", "Arm.R.001", "Arm.R.002", "Arm.R.003", "Arm.R.004" } do
		local instance
		local var4 = self.obj.PrimaryPart:FindFirstChild(var3, true)
		instance = var4 ~= nil
		assert(instance, "missing arm bone")
		assert(var4:IsA("Bone"), "bone is not a bone")
		table.insert(t, {
			bone = var4,
			cf = var4.CFrame
		})
	end
	self.allArmBoneData = t
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
function t._resetArmBones(self)
	for instance, vector2 in self.allArmBoneData do
		vector2.bone.CFrame = vector2.cf
	end
end
function t._armGrabTarget(self, p2, p3, p4)
	local allArmBoneData = self.allArmBoneData
	local TransformedWorldCFrame = allArmBoneData[1].bone.TransformedWorldCFrame
	local Position = TransformedWorldCFrame.Position
	for i = 2, #allArmBoneData do
		local instance
		local vector2 = allArmBoneData[i]
		local var3 = TransformedWorldCFrame:PointToObjectSpace(Position:Lerp(p2, (i - 1) / (#allArmBoneData - 1)))
		instance = if p4 then p4[i] else vector2.bone.Transform
		local var4 = vector2.cf * instance:Inverse() + var3
		vector2.bone.CFrame = vector2.cf:Lerp(var4, p3)
		TransformedWorldCFrame = TransformedWorldCFrame * (var4 * instance)
	end
end
function t._armAnimateFromTo(self, p2, p3, p4, p5, p6)
	local instance = os.clock()
	local vector2 = nil
	local var3 = nil
	var3 = RunService.Heartbeat:Connect(function()
		vector2 = (os.clock() - instance) / p5
		if vector2 >= 1 then
			vector2 = 1
			var3:Disconnect()
			var3 = nil
		end
		local vector12 = TweenService:GetValue(vector2, Enum.EasingStyle.Quart, p6)
		self:_armGrabTarget(p2(), p3 * (1 - vector12) + p4 * vector12, self.armBoneLungeTransforms)
	end)
	return function()
		if var3 then
			var3:Disconnect()
		end
		return vector2
	end
end
function t.DisplayAttackIndicator(self, p2)
	local instance = Maid.new()
	p2.targetingMaid = instance
	local vector2 = NPCUtils.getTarget(self.obj)
	if vector2 then
		local var3 = Players:GetPlayerFromCharacter(vector2.parent)
		if var3 then
			local var4 = ReplicatedStorage.Resource:FindFirstChild("BossAttackIndicator"):Clone()
			var4.Anchored = true
			var4.CanCollide = false
			var4.CanTouch = false
			var4.CanQuery = false
			var4.Parent = workspace
			instance:GiveTask(var4)
			local var5 = os.clock()
			instance:GiveTask(RunService.Heartbeat:Connect(function()
				if var3 then
					local Character = var3.Character
					if Character then
						if Character:FindFirstChild("UpperTorso") then
							local vector2 = Character.PrimaryPart.Position - Vector3.new(0, Character.Humanoid.HipHeight + Character.PrimaryPart.Size.Y / 2, 0)
							local var32 = 6.283185307179586 * (os.clock() % 2) / 2
							var4.CFrame = CFrame.new(vector2) * CFrame.Angles(0, var32, 0)
							var4.Decal.Transparency = math.min(0.9, 1 - (math.cos((os.clock() - var5) * 6) + 1) * 2 / 3)
						else
							instance:Destroy()
						end
					else
						instance:Destroy()
					end
				else
					instance:Destroy()
				end
			end))
		end
	end
end
function t.PlayArmGrab(self, p2)
	local instance = Maid.new()
	local vector2 = nil
	local var3 = NPCUtils.getTarget(self.obj)
	if var3 then
		local var4 = Players:GetPlayerFromCharacter(var3.Parent)
		if var4 then
			self:DisplayAttackIndicator(instance)
			local t = { "CEO: %s, you\'re mine!", "CEO: %s, you\'re going nowhere!", "CEO: Not so fast %s!" }
			vector2 = t[math.random(#t)]:format(var4.DisplayName)
		end
	end
	if not vector2 then
		vector2 = "CEO: You\'re mine!"
	end
	mansionRobberyStore:dispatch({
		type = "setDialogueText",
		text = vector2
	})
	task.delay(3, function()
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = ""
		})
	end)
	local var6 = self.humanoid:WaitForChild("Animator"):LoadAnimation(self.obj:WaitForChild("ActionAnimationsFolder"):WaitForChild("LungeAnimation"))
	var6:Play()
	instance:GiveTask(function()
		var6:Stop()
		var6:Destroy()
	end)
	var6:AdjustSpeed(0.2)
	instance:GiveTask(task.delay(BossNPCConsts.EXTENDO_WHACK_WARM_UP_DURATION, function()
		var6:AdjustSpeed(1)
		instance.killAnimateTo = self:_armAnimateFromTo(p2, 0, 1, var6.Length - 0.25, Enum.EasingDirection.In)
		Audio.ObjectLocal(self.obj.PrimaryPart, 11793693522, {
			Volume = 1,
			RollOffMinDistance = 64
		})
	end))
	local var7 = false
	instance:GiveTask(var6.Stopped:Connect(function()
		if not var7 then
			var7 = true
			local vector12 = p2()
			if (Players.LocalPlayer.Character.PrimaryPart.Position - vector12).Magnitude <= 3 then
				Falling.StartRagdolling(2)
				shakeCamAt(vector12)
				Audio.ObjectLocal(Players.LocalPlayer.Character.PrimaryPart, 11793755625, {
					Volume = 1
				})
				self.obj:FindFirstChild(BossNPCConsts.DAMAGE_SELF_REMOTE_NAME):FireServer(40)
			else
				Audio.ObjectLocal(self.obj.PrimaryPart, 11793693028, {
					Volume = 0.3
				})
			end
			self:_armAnimateFromTo(p2, 1, 0, 0.2, Enum.EasingDirection.Out)
			task.delay(0.2, function()
				instance:DoCleaning()
				Audio.ObjectLocal(self.obj.PrimaryPart, 11793694003, {
					Volume = 0.5,
					RollOffMinDistance = 64
				})
			end)
		end
	end))
	instance:GiveTask(function()
		self:_resetArmBones()
	end)
	return instance
end
function t.PlayLaserSweepVisual(self, p2)
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
	local instance = Maid.new()
	local vector2 = self.humanoid:WaitForChild("Animator"):LoadAnimation(self.obj:WaitForChild("ActionAnimationsFolder"):WaitForChild("AimAnimation"))
	vector2:Play()
	instance:GiveTask(function()
		vector2:Stop()
		vector2:Destroy()
	end)
	local var3 = false
	instance:GiveTask(vector2.Stopped:Connect(function()
		if not var3 then
			var3 = true
			vector2:Play()
			vector2:AdjustSpeed(0)
			vector2.TimePosition = vector2.Length - 0.001
		end
	end))
	Audio.ObjectLocal(self.obj.PrimaryPart, 11831682028, {
		Volume = 0.3,
		RollOffMinDistance = 64
	})
	instance:GiveTask(task.delay(BossNPCConsts.LASER_SWEEP_WARM_UP_DURATION, function()
		local Part = Instance.new("Part")
		Part.CanCollide = false
		Part.CanQuery = false
		Part.CanTouch = false
		Part.Anchored = true
		Part.Material = Enum.Material.Neon
		Part.Color = Color3.new(1, 0.1, 0.1)
		Part.Size = Vector3.new(0.2, 0.2, 1)
		Part.Parent = workspace
		instance:GiveTask(Part)
		Audio.ObjectLocal(Part, 11793588989, {
			Volume = 1
		})
		instance:GiveTask((Audio.ObjectLocal(Part, 11793547887, {
			Looped = true,
			Volume = 0.5
		})))
		local vector12 = self.obj.PrimaryPart.CFrame * Vector3.new(0, -10, -10)
		local t = {}
		instance:GiveTask(function()
			table.clear(t)
		end)
		instance:GiveTask(RunService.Heartbeat:Connect(function()
			local instance = p2()
			vector12 = vector12 + (instance + (instance - self.obj.PrimaryPart.Position).Unit * 3 - vector12) * 0.1
			local Position = self.allArmBoneData[#self.allArmBoneData].bone.TransformedWorldCFrame.Position
			local vector2 = vector12 - Position
			local var3 = RaycastParams.new()
			var3.FilterDescendantsInstances = { self.obj }
			local var4 = Raycast.collidable(Position, vector2.Unit, vector2.Magnitude, var3)
			local var5 = if var4 then var4.Position else Position + vector2
			local Magnitude = (var5 - Position).Magnitude
			Part.Size = Vector3.new(0.2, 0.2, Magnitude)
			Part.CFrame = CFrame.lookAt(Vector3.new(), var5 - Position) * CFrame.new(0, 0, -Magnitude * 0.5) + Position
			if (Players.LocalPlayer.Character.PrimaryPart.Position - var5).Magnitude <= 3 and not t[Players.LocalPlayer] then
				self.obj:FindFirstChild(BossNPCConsts.DAMAGE_SELF_REMOTE_NAME):FireServer(40)
				Audio.ObjectLocal(Players.LocalPlayer.Character.PrimaryPart, 11793588652, {
					Volume = 1
				})
				t[Players.LocalPlayer] = true
			end
		end))
	end))
	return instance
end
function t.PlayMansionLasers(self)
	local instance = Maid.new()
	local vector2 = self.humanoid:WaitForChild("Animator"):LoadAnimation(self.obj:WaitForChild("ActionAnimationsFolder"):WaitForChild("WaveRightAnimation"))
	instance:GiveTask(task.delay(BossNPCConsts.WALK_TO_DEST_DURATION, function()
		Audio.ObjectLocal(self.obj.PrimaryPart, 11793818720, {
			Volume = 0.5
		})
		vector2:Play()
		instance:GiveTask(function()
			vector2:Stop()
			vector2:Destroy()
		end)
	end))
	return instance
end
function t.PlayMansionCameras(self)
	local instance = Maid.new()
	local vector2 = self.humanoid:WaitForChild("Animator"):LoadAnimation(self.obj:WaitForChild("ActionAnimationsFolder"):WaitForChild("WaveLeftAnimation"))
	instance:GiveTask(task.delay(BossNPCConsts.WALK_TO_DEST_DURATION, function()
		Audio.ObjectLocal(self.obj.PrimaryPart, 11793818720, {
			Volume = 0.5
		})
		vector2:Play()
		instance:GiveTask(function()
			vector2:Stop()
			vector2:Destroy()
		end)
	end))
	return instance
end
function t.PlayCallInGuards(self)
	local instance = Maid.new()
	local vector2 = self.humanoid:WaitForChild("Animator"):LoadAnimation(self.obj:WaitForChild("ActionAnimationsFolder"):WaitForChild("WaveLeftAnimation"))
	vector2:Play()
	Audio.ObjectLocal(self.obj.PrimaryPart, 11793818440, {
		Volume = 0.5
	})
	instance:GiveTask(function()
		vector2:Stop()
		vector2:Destroy()
	end)
	return instance
end
function t.PlayAuraBlast(self)
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
	local instance = Maid.new()
	self.maid.auraMaid = instance
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
	instance:GiveTask(AuraPart)
	local vector2 = workspace:GetServerTimeNow()
	local var3 = false
	local function isPlayerInAura()
		local Character = Players.LocalPlayer.Character
		if Character then
			return (Character.PrimaryPart.Position - AuraPart.Position).Magnitude <= AuraPart.Size.X / 2
		end
	end
	instance:GiveTask((shakeCamAt(self.obj.PrimaryPart.Position, {
		Sustain = true,
		Amplitude = 0.1
	})))
	instance:GiveTask(RunService.Heartbeat:Connect(function()
		local vector12 = (workspace:GetServerTimeNow() - vector2) / BossNPCConsts.AURA_BLAST_DURATION
		if vector12 > 1 then
			instance:Destroy()
		else
			local var22 = vector12 * BossNPCConsts.AURA_BLAST_MAX_SIZE
			AuraPart.Size = Vector3.new(var22, var22, var22)
			if not var3 then
				local Character = Players.LocalPlayer.Character
				if if Character then (Character.PrimaryPart.Position - AuraPart.Position).Magnitude <= AuraPart.Size.X / 2 else nil then
					Falling.StartRagdolling(2)
					var3 = true
				end
			end
		end
	end))
	return instance
end
return ManifestBinder.new(BossNPCConsts.TAG_NAME, {
	humanoid = "Humanoid"
}, t)
