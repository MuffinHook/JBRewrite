-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local RunService = game:GetService("RunService")
return function(character)
	local maid = Maid.new()
	local AnimationsFolder = character:FindFirstChild("AnimationsFolder")
	if not AnimationsFolder then
		AnimationsFolder = Instance.new("Folder")
		AnimationsFolder.Name = "AnimationsFolder"
		AnimationsFolder.Parent = character
		for _, animClone in script.Parent:FindFirstChild("Res"):FindFirstChild("DefaultAnimations"):GetChildren() do
			animClone:Clone().Parent = AnimationsFolder
		end
	end
	local Humanoid = character:FindFirstChild("Humanoid")
	local currentState = "Standing"
	local ScaleDampeningPercent = Humanoid:FindFirstChild("ScaleDampeningPercent")
	local currentSpeed = 0
	local lastBlendSpeed = 0
	local lastBlendDirection = {
		x = 0,
		y = 0
	}
	local lastBlendTime = 0
	local currentAnimName = ""
	local currentAnimObject = nil
	local currentTrack = nil
	local keyframeConnection = nil
	local currentAnimSpeed = 1
	local loadedAnimIds = {}
	local animationSets = {}
	local defaultAnimations = {
		idle = {
			{
				id = "http://www.roblox.com/asset/?id=507766666",
				weight = 1
			},
			{
				id = "http://www.roblox.com/asset/?id=507766951",
				weight = 1
			},
			{
				id = "http://www.roblox.com/asset/?id=507766388",
				weight = 9
			}
		},
		walk = {
			{
				id = "http://www.roblox.com/asset/?id=507777826",
				weight = 10
			}
		},
		run = {
			{
				id = "http://www.roblox.com/asset/?id=507767714",
				weight = 10
			}
		},
		swim = {
			{
				id = "http://www.roblox.com/asset/?id=507784897",
				weight = 10
			}
		},
		swimidle = {
			{
				id = "http://www.roblox.com/asset/?id=507785072",
				weight = 10
			}
		},
		jump = {
			{
				id = "http://www.roblox.com/asset/?id=507765000",
				weight = 10
			}
		},
		fall = {
			{
				id = "http://www.roblox.com/asset/?id=507767968",
				weight = 10
			}
		},
		climb = {
			{
				id = "http://www.roblox.com/asset/?id=507765644",
				weight = 10
			}
		},
		sit = {
			{
				id = "http://www.roblox.com/asset/?id=2506281703",
				weight = 10
			}
		},
		toolnone = {
			{
				id = "http://www.roblox.com/asset/?id=507768375",
				weight = 10
			}
		},
		toolslash = {
			{
				id = "http://www.roblox.com/asset/?id=522635514",
				weight = 10
			}
		},
		toollunge = {
			{
				id = "http://www.roblox.com/asset/?id=522638767",
				weight = 10
			}
		},
		wave = {
			{
				id = "http://www.roblox.com/asset/?id=507770239",
				weight = 10
			}
		},
		point = {
			{
				id = "http://www.roblox.com/asset/?id=507770453",
				weight = 10
			}
		},
		dance = {
			{
				id = "http://www.roblox.com/asset/?id=507771019",
				weight = 10
			},
			{
				id = "http://www.roblox.com/asset/?id=507771955",
				weight = 10
			},
			{
				id = "http://www.roblox.com/asset/?id=507772104",
				weight = 10
			}
		},
		dance2 = {
			{
				id = "http://www.roblox.com/asset/?id=507776043",
				weight = 10
			},
			{
				id = "http://www.roblox.com/asset/?id=507776720",
				weight = 10
			},
			{
				id = "http://www.roblox.com/asset/?id=507776879",
				weight = 10
			}
		},
		dance3 = {
			{
				id = "http://www.roblox.com/asset/?id=507777268",
				weight = 10
			},
			{
				id = "http://www.roblox.com/asset/?id=507777451",
				weight = 10
			},
			{
				id = "http://www.roblox.com/asset/?id=507777623",
				weight = 10
			}
		},
		laugh = {
			{
				id = "http://www.roblox.com/asset/?id=507770818",
				weight = 10
			}
		},
		cheer = {
			{
				id = "http://www.roblox.com/asset/?id=507770677",
				weight = 10
			}
		}
	}
	local strafeAnimations = {}
	local nonStrafeAnimations = {}
	local activeLocomotionSet = strafeAnimations
	local emoteLoops = {
		wave = false,
		point = false,
		dance = true,
		dance2 = true,
		dance3 = true,
		laugh = false,
		cheer = false
	}
	math.randomseed(tick())
	local function destroyWalkAnimations()
		for k, v in pairs(strafeAnimations) do
			if v.track then
				v.track:Stop()
				v.track:Destroy()
				v.track = nil
			end
		end
		for k, v in pairs(nonStrafeAnimations) do
			if v.track then
				v.track:Stop()
				v.track:Destroy()
				v.track = nil
			end
		end
		lastBlendSpeed = 0
	end
	local maxLvX = nil
	local minLvX = nil
	local maxLvY = nil
	local minLvY = nil
	local function resetVelocityBounds(_)
		maxLvX = 0
		minLvX = 0
		maxLvY = 0
		minLvY = 0
	end
	local function updateVelocityBounds(vel)
		if vel then
			if maxLvX < vel.x then
				maxLvX = vel.x
			end
			if maxLvY < vel.y then
				maxLvY = vel.y
			end
			if vel.x < minLvX then
				minLvX = vel.x
			end
			if vel.y < minLvY then
				minLvY = vel.y
			end
		end
	end
	local function checkStrafingEnabled(_)
		if maxLvX ~= 0 and (minLvX ~= 0 and (maxLvY ~= 0 and minLvY ~= 0)) and (strafeAnimations.run and strafeAnimations.walk) then
			if activeLocomotionSet ~= strafeAnimations then
				activeLocomotionSet = strafeAnimations
				warn("Strafing reenabled")
			end
			return
		elseif maxLvX ~= 0 and (minLvX ~= 0 and (maxLvY ~= 0 and minLvY ~= 0)) and activeLocomotionSet == strafeAnimations then
			warn("Strafe blending disabled.  Run and walk must be strafing-friendly.")
		end
		activeLocomotionSet = nonStrafeAnimations
	end
	local function setupWalkAnimations()
		maxLvX = 0
		minLvX = 0
		maxLvY = 0
		minLvY = 0
		for k, v in pairs(strafeAnimations) do
			local lv = v.lv
			if lv then
				if maxLvX < lv.x then
					maxLvX = lv.x
				end
				if maxLvY < lv.y then
					maxLvY = lv.y
				end
				if lv.x < minLvX then
					minLvX = lv.x
				end
				if lv.y < minLvY then
					minLvY = lv.y
				end
			end
		end
		checkStrafingEnabled()
		for k, v in pairs(activeLocomotionSet) do
			v.track = Humanoid:LoadAnimation(animationSets[k][1].anim)
			v.track.Priority = Enum.AnimationPriority.Core
		end
	end
	local function replaceLocomotionTrack(animName, linearVelocity)
		local wasWalking
		if currentAnimName == "walk" and activeLocomotionSet[animName] then
			destroyWalkAnimations()
			wasWalking = true
		else
			wasWalking = false
		end
		if linearVelocity then
			strafeAnimations[animName] = {
				lv = linearVelocity,
				speed = linearVelocity.Magnitude
			}
		else
			strafeAnimations[animName] = nil
		end
		if (animName == "run" or animName == "walk") and linearVelocity then
			nonStrafeAnimations[animName] = strafeAnimations[animName]
		elseif animName == "run" or animName == "walk" then
			local defaultSpeed = if animName == "run" then 12.8 else 6.4
			nonStrafeAnimations[animName] = {
				lv = Vector2.new(0, defaultSpeed),
				speed = defaultSpeed
			}
			strafeAnimations[animName] = nil
		end
		if wasWalking then
			setupWalkAnimations()
			lastBlendTime = 0
		end
	end
	local function loadAnimationSet(animName, defaultSet)
		if animationSets[animName] ~= nil then
			for k, v in pairs(animationSets[animName].connections) do
				v:disconnect()
			end
		end
		animationSets[animName] = {}
		animationSets[animName].count = 0
		animationSets[animName].totalWeight = 0
		animationSets[animName].connections = {}
		local animFolder = AnimationsFolder:FindFirstChild(animName)
		if animFolder ~= nil then
			local function onChildAdded(_)
				loadAnimationSet(animName, defaultSet)
			end
			table.insert(animationSets[animName].connections, animFolder.ChildAdded:connect(onChildAdded))
			local function onChildRemoved(_)
				loadAnimationSet(animName, defaultSet)
			end
			table.insert(animationSets[animName].connections, animFolder.ChildRemoved:connect(onChildRemoved))
			for k, v in pairs(animFolder:GetChildren()) do
				local weight
				if v:IsA("Animation") then
					local Weight = v:FindFirstChild("Weight")
					weight = if Weight == nil then 1 else Weight.Value
					animationSets[animName].count = animationSets[animName].count + 1
					local count = animationSets[animName].count
					animationSets[animName][count] = {}
					animationSets[animName][count].anim = v
					animationSets[animName][count].weight = weight
					animationSets[animName].totalWeight = animationSets[animName].totalWeight + animationSets[animName][count].weight
					local function onAnimChanged(_)
						loadAnimationSet(animName, defaultSet)
					end
					table.insert(animationSets[animName].connections, v.Changed:connect(onAnimChanged))
					local function onAnimChildAdded(_)
						loadAnimationSet(animName, defaultSet)
					end
					table.insert(animationSets[animName].connections, v.ChildAdded:connect(onAnimChildAdded))
					local function onAnimChildRemoved(_)
						loadAnimationSet(animName, defaultSet)
					end
					table.insert(animationSets[animName].connections, v.ChildRemoved:connect(onAnimChildRemoved))
					replaceLocomotionTrack(animName, (v:GetAttribute("LinearVelocity")))
				end
			end
		end
		if animationSets[animName].count <= 0 then
			for k, v in pairs(defaultSet) do
				animationSets[animName][k] = {}
				animationSets[animName][k].anim = Instance.new("Animation")
				animationSets[animName][k].anim.Name = animName
				animationSets[animName][k].anim.AnimationId = v.id
				animationSets[animName][k].weight = v.weight
				animationSets[animName].count = animationSets[animName].count + 1
				animationSets[animName].totalWeight = animationSets[animName].totalWeight + v.weight
			end
		end
		for k, v in pairs(animationSets) do
			for i = 1, v.count do
				if loadedAnimIds[v[i].anim.AnimationId] == nil then
					Humanoid:LoadAnimation(v[i].anim)
					loadedAnimIds[v[i].anim.AnimationId] = true
				end
			end
		end
	end
	local function scriptChildModified(child)
		local defaultSet = defaultAnimations[child.Name]
		if defaultSet == nil then
			if child:isA("StringValue") then
				defaultAnimations[child.Name] = {}
				loadAnimationSet(child.Name, defaultAnimations[child.Name])
			end
		else
			loadAnimationSet(child.Name, defaultSet)
		end
	end
	maid:GiveTask(AnimationsFolder.ChildAdded:connect(scriptChildModified))
	maid:GiveTask(AnimationsFolder.ChildRemoved:connect(scriptChildModified))
	maid:GiveTask(function()
		for animName, animSet in animationSets do
			for _, conn in animSet.connections do
				conn:Disconnect()
			end
		end
	end)
	local animator = if Humanoid then Humanoid:FindFirstChildOfClass("Animator") else nil
	if not animator and RunService:IsServer() then
		animator = Instance.new("Animator")
		assert(animator).Parent = Humanoid
	elseif not animator then
		animator = Humanoid
	end
	if animator then
		for i, v in ipairs((animator:GetPlayingAnimationTracks())) do
			v:Stop(0)
			v:Destroy()
		end
	end
	for k, v in pairs(defaultAnimations) do
		loadAnimationSet(k, v)
	end
	for _, child in AnimationsFolder:GetChildren() do
		if child:isA("StringValue") then
			defaultAnimations[child.Name] = {}
			loadAnimationSet(child.Name, defaultAnimations[child.Name])
		end
	end
	local currentToolAnim = "None"
	local toolAnimExpiry = 0
	local jumpFallTimer = 0
	local isEmoting = false
	local function stopAllAnimations()
		local prevAnimName = currentAnimName
		if emoteLoops[prevAnimName] ~= nil and emoteLoops[prevAnimName] == false then
			prevAnimName = "idle"
		end
		if isEmoting then
			prevAnimName = "idle"
			isEmoting = false
		end
		currentAnimName = ""
		currentAnimObject = nil
		if keyframeConnection ~= nil then
			keyframeConnection:disconnect()
		end
		if currentTrack ~= nil then
			currentTrack:Stop()
			currentTrack:Destroy()
			currentTrack = nil
		end
		for k, v in pairs(activeLocomotionSet) do
			if v.track then
				v.track:Stop()
				v.track:Destroy()
				v.track = nil
			end
		end
		return prevAnimName
	end
	local function getHeightScale()
		if Humanoid and Humanoid.AutomaticScalingEnabled then
			local heightScale = Humanoid.HipHeight / 2
			if ScaleDampeningPercent == nil then
				ScaleDampeningPercent = Humanoid:FindFirstChild("ScaleDampeningPercent")
			end
			if ScaleDampeningPercent ~= nil then
				heightScale = 1 + (Humanoid.HipHeight - 2) * ScaleDampeningPercent.Value / 2
			end
			return heightScale
		else
			return 1
		end
	end
	local function signedAngle(a, b)
		return -math.atan2(a.x * b.y - a.y * b.x, a.x * b.x + a.y * b.y)
	end
	local function get2DWeight(inputDir, refDir, otherDir, speed, refSpeed, otherSpeed)
		local avgSpeed = 0.5 * (refSpeed + otherSpeed)
		local inputDelta = {
			x = (speed - refSpeed) / avgSpeed
		}
		inputDelta.y = 2 * -math.atan2(refDir.x * inputDir.y - refDir.y * inputDir.x, refDir.x * inputDir.x + refDir.y * inputDir.y)
		local otherDelta = {
			x = (otherSpeed - refSpeed) / avgSpeed
		}
		otherDelta.y = 2 * -math.atan2(refDir.x * otherDir.y - refDir.y * otherDir.x, refDir.x * otherDir.x + refDir.y * otherDir.y)
		return math.clamp(1 - (inputDelta.x * otherDelta.x + inputDelta.y * otherDelta.y) / (0.0001 + (otherDelta.x * otherDelta.x + otherDelta.y * otherDelta.y)), 0, 1)
	end
	local function blend2D(inputDir, speed)
		local weights = {}
		local sum = 0
		for k, v in pairs(activeLocomotionSet) do
			if inputDir.x * v.lv.x < 0 or inputDir.y * v.lv.y < 0 then
				weights[k] = 0
			else
				weights[k] = (1 / 0)
				for k2, v2 in pairs(activeLocomotionSet) do
					if not (inputDir.x * v2.lv.x < 0 or inputDir.y * v2.lv.y < 0) then
						weights[k] = math.min(weights[k], (get2DWeight(inputDir, v.lv, v2.lv, speed, v.speed, v2.speed)))
					end
				end
				sum = sum + weights[k]
			end
		end
		local weightSum = 0
		local weightedLvX = 0
		local weightedLvY = 0
		for k, v in pairs(activeLocomotionSet) do
			if weights[k] / sum > 0.1 then
				weightSum = weightSum + weights[k]
				weightedLvX = weightedLvX + weights[k] * v.lv.x
				weightedLvY = weightedLvY + weights[k] * v.lv.y
			else
				weights[k] = 0
			end
		end
		local weightSqSum = weightedLvX * weightedLvX + weightedLvY * weightedLvY
		local speedScale = if weightSqSum > 0.0001 then math.sqrt(speed * speed / weightSqSum) else 0
		local heightScale
		if Humanoid and Humanoid.AutomaticScalingEnabled then
			local hipScale = Humanoid.HipHeight / 2
			if ScaleDampeningPercent == nil then
				ScaleDampeningPercent = Humanoid:FindFirstChild("ScaleDampeningPercent")
			end
			if ScaleDampeningPercent ~= nil then
				hipScale = 1 + (Humanoid.HipHeight - 2) * ScaleDampeningPercent.Value / 2
			end
			heightScale = hipScale
		else
			heightScale = 1
		end
		local syncTimePos = 0
		local adjustedSpeed = speedScale / heightScale
		for k, v in pairs(activeLocomotionSet) do
			if v.track.IsPlaying then
				syncTimePos = v.track.TimePosition
				break
			end
		end
		for k, v in pairs(activeLocomotionSet) do
			if weights[k] > 0 then
				if not v.track.IsPlaying then
					v.track:Play(0.2)
					v.track.TimePosition = syncTimePos
				end
				v.track:AdjustWeight(math.max(0.0001, weights[k] / weightSum), 0.2)
				v.track:AdjustSpeed(adjustedSpeed)
			else
				v.track:Stop(0.2)
			end
		end
	end
	local function getWalkDirection()
		local WalkToPoint = Humanoid.WalkToPoint
		local WalkToPart = Humanoid.WalkToPart
		if Humanoid.MoveDirection == Vector3.new(0, 0, 0) and (WalkToPart or WalkToPoint ~= Vector3.new(0, 0, 0)) then
			local targetPos = if WalkToPart then WalkToPart.CFrame:PointToWorldSpace(WalkToPoint) else WalkToPoint
			local walkDir
			if Humanoid.RootPart then
				local diff = targetPos - Humanoid.RootPart.CFrame.Position
				local flatDiff = Vector3.new(diff.x, 0, diff.z)
				local flatMag = flatDiff.Magnitude
				walkDir = if flatMag > 0.01 then flatDiff / flatMag else flatDiff
			else
				walkDir = Vector3.new(0, 0, 0)
			end
			return walkDir
		else
			return Humanoid.MoveDirection
		end
	end
	local function updateVelocity(clockTime)
		if activeLocomotionSet == strafeAnimations then
			local walkDir = getWalkDirection()
			if Humanoid.RootPart then
				local rootCFrame = Humanoid.RootPart.CFrame
				if math.abs(rootCFrame.UpVector.Y) < 0.0001 or (currentState ~= "Running" or currentSpeed < 0.001) then
					for k, v in pairs(activeLocomotionSet) do
						if v.track then
							v.track:AdjustWeight(0.0001, 0.2)
						end
					end
				else
					local LookVector = rootCFrame.LookVector
					local lookFlat = Vector3.new(LookVector.X, 0, LookVector.Z)
					local lookNorm = lookFlat / lookFlat.Magnitude
					local forwardDot = walkDir:Dot(lookNorm)
					if forwardDot <= 0 and forwardDot > -0.05 then
						forwardDot = 0.0001
					end
					local blendDir = Vector2.new(lookNorm.X * walkDir.Z - lookNorm.Z * walkDir.X, forwardDot)
					local dirDelta = Vector2.new(blendDir.x - lastBlendDirection.x, blendDir.y - lastBlendDirection.y)
					if dirDelta:Dot(dirDelta) > 0.001 then
						lastBlendDirection = blendDir
						lastBlendSpeed = currentSpeed
						lastBlendTime = clockTime
						blend2D(blendDir, currentSpeed)
						return
					end
					if math.abs(currentSpeed - lastBlendSpeed) > 0.01 or clockTime - lastBlendTime > 1 then
						lastBlendDirection = blendDir
						lastBlendSpeed = currentSpeed
						lastBlendTime = clockTime
						blend2D(blendDir, currentSpeed)
					end
				end
			end
		else
			if math.abs(currentSpeed - lastBlendSpeed) > 0.01 or clockTime - lastBlendTime > 1 then
				lastBlendSpeed = currentSpeed
				lastBlendTime = clockTime
				blend2D(Vector2.yAxis, currentSpeed)
			end
		end
	end
	local function setAnimationSpeed(speed)
		if currentAnimName ~= "walk" and speed ~= currentAnimSpeed then
			currentAnimSpeed = speed
			currentTrack:AdjustSpeed(speed)
		end
	end
	local playAnimation = nil
	local function keyFrameReachedFunc(keyframeName)
		if keyframeName == "End" then
			local animName = currentAnimName
			if emoteLoops[animName] ~= nil and emoteLoops[animName] == false then
				animName = "idle"
			end
			if isEmoting then
				if currentTrack.Looped then
					return
				end
				animName = "idle"
				isEmoting = false
			end
			local savedSpeed = currentAnimSpeed
			playAnimation(animName, 0.15, Humanoid)
			if currentAnimName ~= "walk" and savedSpeed ~= currentAnimSpeed then
				currentAnimSpeed = savedSpeed
				currentTrack:AdjustSpeed(savedSpeed)
			end
		end
	end
	local function rollAnimation(animName)
		local roll = math.random(1, animationSets[animName].totalWeight)
		local index = 1
		while animationSets[animName][index].weight < roll do
			roll = roll - animationSets[animName][index].weight
			index = index + 1
		end
		return index
	end
	local function switchToAnim(animObject, animName, fadeTime, animatorObj)
		if animObject ~= currentAnimObject then
			if currentTrack ~= nil then
				currentTrack:Stop(fadeTime)
				currentTrack:Destroy()
			end
			if keyframeConnection ~= nil then
				keyframeConnection:disconnect()
			end
			currentAnimSpeed = 1
			currentAnimName = animName
			currentAnimObject = animObject
			if animName == "walk" then
				setupWalkAnimations()
				return
			end
			destroyWalkAnimations()
			currentTrack = animatorObj:LoadAnimation(animObject)
			currentTrack.Priority = Enum.AnimationPriority.Core
			currentTrack:Play(fadeTime)
			keyframeConnection = currentTrack.KeyframeReached:connect(keyFrameReachedFunc)
		end
	end
	playAnimation = function(animName, fadeTime, animatorObj)
		switchToAnim(animationSets[animName][rollAnimation(animName)].anim, animName, fadeTime, animatorObj)
		isEmoting = false
	end
	local currentToolAnimName = ""
	local currentToolTrack = nil
	local currentToolAnimObject = nil
	local toolKeyframeConnection = nil
	local playToolAnimation = nil
	local function toolKeyFrameReachedFunc(keyframeName)
		if keyframeName == "End" then
			playToolAnimation(currentToolAnimName, 0, Humanoid)
		end
	end
	playToolAnimation = function(animName, fadeTime, animatorObj, priority)
		local anim = animationSets[animName][rollAnimation(animName)].anim
		if currentToolAnimObject ~= anim then
			if currentToolTrack ~= nil then
				currentToolTrack:Stop()
				currentToolTrack:Destroy()
				fadeTime = 0
			end
			currentToolTrack = animatorObj:LoadAnimation(anim)
			if priority then
				currentToolTrack.Priority = priority
			end
			currentToolTrack:Play(fadeTime)
			currentToolAnimName = animName
			currentToolAnimObject = anim
			toolKeyframeConnection = currentToolTrack.KeyframeReached:connect(toolKeyFrameReachedFunc)
		end
	end
	local function stopToolAnimations()
		local prevToolAnimName = currentToolAnimName
		if toolKeyframeConnection ~= nil then
			toolKeyframeConnection:disconnect()
		end
		currentToolAnimName = ""
		currentToolAnimObject = nil
		if currentToolTrack ~= nil then
			currentToolTrack:Stop()
			currentToolTrack:Destroy()
			currentToolTrack = nil
		end
		return prevToolAnimName
	end
	local function onRunning(speed)
		currentSpeed = speed
		if (isEmoting and Humanoid.MoveDirection == Vector3.new(0, 0, 0) and Humanoid.WalkSpeed or 0.75) < speed then
			playAnimation("walk", 0.2, Humanoid)
			if currentState ~= "Running" then
				currentState = "Running"
				updateVelocity(0)
			end
		elseif emoteLoops[currentAnimName] == nil and not isEmoting then
			playAnimation("idle", 0.2, Humanoid)
			currentState = "Standing"
		end
	end
	local function onDied()
		currentState = "Dead"
	end
	local function onJumping()
		playAnimation("jump", 0.1, Humanoid)
		jumpFallTimer = 0.31
		currentState = "Jumping"
	end
	local function onClimbing(speed)
		playAnimation("climb", 0.1, Humanoid)
		local climbSpeed = speed / 5
		if currentAnimName ~= "walk" and climbSpeed ~= currentAnimSpeed then
			currentAnimSpeed = climbSpeed
			currentTrack:AdjustSpeed(climbSpeed)
		end
		currentState = "Climbing"
	end
	local function onGettingUp()
		currentState = "GettingUp"
	end
	local function onFreeFall()
		if jumpFallTimer <= 0 then
			playAnimation("fall", 0.2, Humanoid)
		end
		currentState = "FreeFall"
	end
	local function onFallingDown()
		currentState = "FallingDown"
	end
	local function onSeated()
		currentState = "Seated"
	end
	local function onPlatformStanding()
		currentState = "PlatformStanding"
	end
	local function onSwimming(speed)
		if speed > 1 then
			playAnimation("swim", 0.4, Humanoid)
			local swimSpeed = speed / 10
			if currentAnimName ~= "walk" and swimSpeed ~= currentAnimSpeed then
				currentAnimSpeed = swimSpeed
				currentTrack:AdjustSpeed(swimSpeed)
			end
			currentState = "Swimming"
		else
			playAnimation("swimidle", 0.4, Humanoid)
			currentState = "Standing"
		end
	end
	local function animateTool()
		if currentToolAnim == "None" then
			playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle)
		elseif currentToolAnim == "Slash" then
			playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action)
		elseif currentToolAnim == "Lunge" then
			playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action)
		end
	end
	local function getToolAnim(tool)
		for i, v in ipairs(tool:GetChildren()) do
			if v.Name == "toolanim" and v.className == "StringValue" then
				return v
			end
		end
		return nil
	end
	local lastStepTime = 0
	local function stepAnimate(clockTime)
		local dt = clockTime - lastStepTime
		lastStepTime = clockTime
		if jumpFallTimer > 0 then
			jumpFallTimer = jumpFallTimer - dt
		end
		if currentState == "FreeFall" and jumpFallTimer <= 0 then
			playAnimation("fall", 0.2, Humanoid)
		elseif currentState == "Seated" then
			playAnimation("sit", 0.5, Humanoid)
			return
		elseif currentState == "Running" then
			playAnimation("walk", 0.2, Humanoid)
			updateVelocity(clockTime)
		elseif currentState == "Dead" or (currentState == "GettingUp" or (currentState == "FallingDown" or (currentState == "Seated" or currentState == "PlatformStanding"))) then
			stopAllAnimations()
		end
		local Tool = character:FindFirstChildOfClass("Tool")
		if Tool and Tool:FindFirstChild("Handle") then
			local toolAnimValue = getToolAnim(Tool)
			if toolAnimValue then
				currentToolAnim = toolAnimValue.Value
				toolAnimValue.Parent = nil
				toolAnimExpiry = clockTime + 0.3
			end
			if toolAnimExpiry < clockTime then
				toolAnimExpiry = 0
				currentToolAnim = "None"
			end
			animateTool()
		else
			if toolKeyframeConnection ~= nil then
				toolKeyframeConnection:disconnect()
			end
			currentToolAnimName = ""
			currentToolAnimObject = nil
			if currentToolTrack ~= nil then
				currentToolTrack:Stop()
				currentToolTrack:Destroy()
				currentToolTrack = nil
			end
			currentToolAnim = "None"
			currentToolAnimObject = nil
			toolAnimExpiry = 0
		end
	end
	maid:GiveTask(Humanoid.Died:connect(onDied))
	maid:GiveTask(Humanoid.Running:connect(onRunning))
	maid:GiveTask(Humanoid.Jumping:connect(onJumping))
	maid:GiveTask(Humanoid.Climbing:connect(onClimbing))
	maid:GiveTask(Humanoid.GettingUp:connect(onGettingUp))
	maid:GiveTask(Humanoid.FreeFalling:connect(onFreeFall))
	maid:GiveTask(Humanoid.FallingDown:connect(onFallingDown))
	maid:GiveTask(Humanoid.Seated:connect(onSeated))
	maid:GiveTask(Humanoid.PlatformStanding:connect(onPlatformStanding))
	maid:GiveTask(Humanoid.Swimming:connect(onSwimming))
	if character.Parent ~= nil then
		playAnimation("idle", 0.1, Humanoid)
	end
	maid:GiveTask(RunService.Heartbeat:Connect(function()
		if character.Parent == nil then
			maid:DoCleaning()
		else
			stepAnimate(os.clock())
		end
	end))
	maid:GiveTask(function()
		task.defer(function()
			if animator then
				for _, track in animator:GetPlayingAnimationTracks() do
					track:Stop(0)
					track:Destroy()
				end
			end
		end)
	end)
	return {
		Destroy = function(_)
			maid:DoCleaning()
		end
	}
end
