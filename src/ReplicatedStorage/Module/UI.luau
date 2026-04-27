local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local Signal = require(ReplicatedStorage.Std.Signal)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local Octree = require(ReplicatedStorage.Std.Octree)
local AnimationController = {
	MakeGroup = function()
		return {
			Running = nil
		}
	end,
	MakeSpec = function()
		return {
			Duration = nil,
			Start = nil,
			End = nil,
			Cancel = nil,
			Update = nil
		}
	end,
	Cancel = function(group)
		local Running = group.Running
		if Running then
			Running:Cancel()
			group.Running = nil
		end
	end
}
function AnimationController.Push(group, spec)
	AnimationController.Cancel(group)
	assert(spec.Duration)
	assert(spec.Start)
	assert(spec.End)
	assert(spec.Update)
	if not spec.Cancel then
		spec.Cancel = spec.End
	end
	group.Running = spec
end
function AnimationController.Update(group, deltaTime)
	local Running = group.Running
	if Running then
		local currentTime = os.clock()
		if not Running.Started then
			Running.Started = currentTime
			Running:Start()
		end
		local elapsedTime = currentTime - Running.Started
		if Running.Elapsed then
			elapsedTime = elapsedTime + Running.Elapsed
		end
		local progress = elapsedTime / Running.Duration
		if progress >= 1 then
			progress = 1
		end
		Running:Update(progress, deltaTime)
		if progress >= 1 then
			Running:End()
			group.Running = nil
		end
	end
end
local CircleActionModule = {
	onVisibilityChanged = Signal.new()
}
local animationGroup = AnimationController.MakeGroup()
local specsList = {}
CircleActionModule.Specs = specsList
local zeroVector = Vector3.new()
local octreeStructure = Octree.new(Vector3.new(0, 50, 0), 8192, 8, 8)
CircleActionModule.SpecOctree = octreeStructure
local nearbySpecsList = {}
local lastOctreeUpdateTime = 0
function CircleActionModule.Add(spec, tag)
	assert(tag, "No key found, second param to Add must be nil")
	spec.Tag = tag
	if not spec.Enabled then
		spec.Enabled = true
	end
	if not spec.Priority then
		spec.Priority = 1
	end
	table.insert(specsList, spec)
	local WorldPosition = spec.WorldPosition
	if not WorldPosition then
		WorldPosition = spec.Attachment and spec.Attachment.WorldPosition or (spec.Part and spec.Part.Position or zeroVector)
	end
	octreeStructure:Insert(spec, WorldPosition)
	return function()
		return CircleActionModule.Remove(tag)
	end
end
function CircleActionModule.Remove(tag)
	for i = #specsList, 1, -1 do
		local spec = specsList[i]
		if spec.Tag == tag then
			if CircleActionModule.Spec == spec then
				if spec.HideFun then
					spec:HideFun()
				end
				CircleActionModule.Spec = nil
			end
			octreeStructure:Remove(spec)
			table.remove(specsList, i)
			return true
		end
	end
	return false
end
local circleProgress = 1
local function GetCirclePct()
	return circleProgress
end
local function SetCirclePct(percentage)
	circleProgress = percentage
	local Frame = CircleActionModule.Frame
	local Image = Frame.OuterFrame.Left.Image
	local Image_2 = Frame.OuterFrame.Right.Image
	local color = math.clamp(percentage * 360, 0, 360)
	Image.UIGradient.Rotation = math.clamp(color, 180, 360)
	Image_2.UIGradient.Rotation = math.clamp(color, 0, 180)
	local isPartiallyVisible = percentage < 0.999
	Image.Visible = isPartiallyVisible
	Image_2.Visible = isPartiallyVisible
	Frame.OuterFrame.OuterFull.Visible = not isPartiallyVisible
end
local function SetCircleColor(color)
	local Frame = CircleActionModule.Frame
	Frame.OuterFrame.Left.Image.ImageColor3 = color
	Frame.OuterFrame.Right.Image.ImageColor3 = color
	Frame.OuterFrame.OuterFull.ImageColor3 = color
end
local function SetCircleRadius(radius)
	local Frame = CircleActionModule.Frame
	Frame.OuterFrame.Size = UDim2.new(1, 2 * radius, 1, 2 * radius)
	Frame.OuterFrame.Position = UDim2.new(0, -radius, 0, -radius)
end
local sin = math.sin
local function afSpin_Start()
	circleProgress = 0
	local Frame = CircleActionModule.Frame
	local Image = Frame.OuterFrame.Left.Image
	local Image_2 = Frame.OuterFrame.Right.Image
	Image.UIGradient.Rotation = 180
	Image_2.UIGradient.Rotation = 0
	Image.Visible = true
	Image_2.Visible = true
	Frame.OuterFrame.OuterFull.Visible = false
	local Frame_2 = CircleActionModule.Frame
	Frame_2.OuterFrame.Size = UDim2.new(1, 8, 1, 8)
	Frame_2.OuterFrame.Position = UDim2.new(0, -4, 0, -4)
	local color = Color3.fromRGB(214, 214, 214)
	local Frame_3 = CircleActionModule.Frame
	Frame_3.OuterFrame.Left.Image.ImageColor3 = color
	Frame_3.OuterFrame.Right.Image.ImageColor3 = color
	Frame_3.OuterFrame.OuterFull.ImageColor3 = color
end
local function afSpin_End()
	circleProgress = 1
	local Frame = CircleActionModule.Frame
	local Image = Frame.OuterFrame.Left.Image
	local Image_2 = Frame.OuterFrame.Right.Image
	Image.UIGradient.Rotation = 360
	Image_2.UIGradient.Rotation = 180
	Image.Visible = false
	Image_2.Visible = false
	Frame.OuterFrame.OuterFull.Visible = true
	local Frame_2 = CircleActionModule.Frame
	Frame_2.OuterFrame.Size = UDim2.new(1, 16, 1, 16)
	Frame_2.OuterFrame.Position = UDim2.new(0, -8, 0, -8)
	local color = Color3.fromRGB(214, 214, 214)
	local Frame_3 = CircleActionModule.Frame
	Frame_3.OuterFrame.Left.Image.ImageColor3 = color
	Frame_3.OuterFrame.Right.Image.ImageColor3 = color
	Frame_3.OuterFrame.OuterFull.ImageColor3 = color
end
local function afSpin_Update(spec, progress, deltaTime)
	local sinValue = sin(progress) / 0.8414709848078965
	SetCirclePct(sinValue)
	local colorValue = 214 - (1 - sinValue) * 64
	local colorRGB = Color3.fromRGB(colorValue, colorValue, colorValue)
	local Frame = CircleActionModule.Frame
	Frame.OuterFrame.Left.Image.ImageColor3 = colorRGB
	Frame.OuterFrame.Right.Image.ImageColor3 = colorRGB
	Frame.OuterFrame.OuterFull.ImageColor3 = colorRGB
	local radiusSize = sinValue * 4 + 4
	local Frame_2 = CircleActionModule.Frame
	Frame_2.OuterFrame.Size = UDim2.new(1, 2 * radiusSize, 1, 2 * radiusSize)
	Frame_2.OuterFrame.Position = UDim2.new(0, -radiusSize, 0, -radiusSize)
end
local pulseProgress = 1
local function Ease_outBack(value, startValue, changeAmount, duration, elasticity)
	elasticity = elasticity or 1.70158
	local normalizedValue = value / duration - 1
	return changeAmount * (normalizedValue * normalizedValue * ((elasticity + 1) * normalizedValue + elasticity) + 1) + startValue
end
local function afPulse_Start()
	local color = Color3.fromRGB(214, 214, 214)
	local Frame = CircleActionModule.Frame
	Frame.OuterFrame.Left.Image.ImageColor3 = color
	Frame.OuterFrame.Right.Image.ImageColor3 = color
	Frame.OuterFrame.OuterFull.ImageColor3 = color
	local Frame_2 = CircleActionModule.Frame
	Frame_2.OuterFrame.Size = UDim2.new(1, 0, 1, 0)
	Frame_2.OuterFrame.Position = UDim2.new(0, -0, 0, -0)
end
local function afPulse_End()
	circleProgress = 1
	local Frame = CircleActionModule.Frame
	local Image = Frame.OuterFrame.Left.Image
	local Image_2 = Frame.OuterFrame.Right.Image
	Image.UIGradient.Rotation = 360
	Image_2.UIGradient.Rotation = 180
	Image.Visible = false
	Image_2.Visible = false
	Frame.OuterFrame.OuterFull.Visible = true
	pulseProgress = 1
	local color = Color3.fromRGB(214, 214, 214)
	local Frame_2 = CircleActionModule.Frame
	Frame_2.OuterFrame.Left.Image.ImageColor3 = color
	Frame_2.OuterFrame.Right.Image.ImageColor3 = color
	Frame_2.OuterFrame.OuterFull.ImageColor3 = color
	local Frame_3 = CircleActionModule.Frame
	Frame_3.OuterFrame.Size = UDim2.new(1, 16, 1, 16)
	Frame_3.OuterFrame.Position = UDim2.new(0, -8, 0, -8)
end
local function afPulse_Update(spec, progress, deltaTime)
	SetCirclePct(pulseProgress * (1 - progress) + progress)
	local easeOutBackFactor = 6 or 1.70158
	local normalizedProgress = progress / 1 - 1
	local easedRadius = 8 * (1 * (normalizedProgress * normalizedProgress * ((easeOutBackFactor + 1) * normalizedProgress + easeOutBackFactor) + 1) + 0)
	local Frame = CircleActionModule.Frame
	Frame.OuterFrame.Size = UDim2.new(1, 2 * easedRadius, 1, 2 * easedRadius)
	Frame.OuterFrame.Position = UDim2.new(0, -easedRadius, 0, -easedRadius)
	if spec.Red then
		local redIntensity = 40 - 40 * progress
		local inverseProgress = 1 - progress
		local redColor = Color3.fromRGB(214 * inverseProgress + 214 * progress + redIntensity, 69 * inverseProgress + 214 * progress + redIntensity, 69 * inverseProgress + 214 * progress + redIntensity)
		local Frame_2 = CircleActionModule.Frame
		Frame_2.OuterFrame.Left.Image.ImageColor3 = redColor
		Frame_2.OuterFrame.Right.Image.ImageColor3 = redColor
		Frame_2.OuterFrame.OuterFull.ImageColor3 = redColor
	end
end
function CircleActionModule.NotAllowed()
	local notAllowedSpec = AnimationController.MakeSpec()
	notAllowedSpec.Duration = 0.3
	notAllowedSpec.Start = afPulse_Start
	notAllowedSpec.End = afPulse_End
	notAllowedSpec.Update = afPulse_Update
	notAllowedSpec.Red = true
	AnimationController.Push(animationGroup, notAllowedSpec)
end
local function Press()
	local Spec = CircleActionModule.Spec
	if Spec then
		Spec:Callback(false)
		if Spec.Timed then
			Spec.Pressed = true
			Spec.PressedAt = os.clock()
			local spinSpec = AnimationController.MakeSpec()
			spinSpec.Duration = Spec.Duration
			spinSpec.Start = afSpin_Start
			spinSpec.End = afSpin_End
			spinSpec.Update = afSpin_Update
			if Spec.GetAccumulation then
			spinSpec.Elapsed = Spec.GetAccumulation()
			end
			AnimationController.Push(animationGroup, spinSpec)
			Spec.Animation = spinSpec
		elseif Spec:Callback(true) then
			local pulseSpec = AnimationController.MakeSpec()
			pulseSpec.Duration = 0.3
			pulseSpec.Start = afPulse_Start
			pulseSpec.End = afPulse_End
			pulseSpec.Update = afPulse_Update
			AnimationController.Push(animationGroup, pulseSpec)
		else
			local failSpec = AnimationController.MakeSpec()
			failSpec.Duration = 0.3
			failSpec.Start = afPulse_Start
			failSpec.End = afPulse_End
			failSpec.Update = afPulse_Update
			failSpec.Red = true
			AnimationController.Push(animationGroup, failSpec)
		end
	end
end
local function Release()
	local Spec = CircleActionModule.Spec
	if Spec then
		Spec.Pressed = false
		Spec.PressedAt = nil
		if animationGroup.Running ~= nil and animationGroup.Running == Spec.Animation then
			local releaseSpec = AnimationController.MakeSpec()
			AnimationController.Cancel(animationGroup)
			releaseSpec.Duration = 0.3
			releaseSpec.Start = afPulse_Start
			releaseSpec.End = afPulse_End
			releaseSpec.Update = afPulse_Update
			releaseSpec.Red = true
			AnimationController.Push(animationGroup, releaseSpec)
		end
		Spec.Animation = nil
		Spec.ScreenPosition = nil
		CircleActionModule.Spec = nil
		if Spec.ReleaseCallback then
			Spec:ReleaseCallback(false)
		end
	end
end
CircleActionModule.Press = Press
CircleActionModule.Release = Release
local function UpdateUI()
	local closestDistance = 999
	local highestPriority = 1
	local selectedSpec = nil
	for i = #specsList, 1, -1 do
		local currentSpec = specsList[i]
		if not currentSpec.Kill and (currentSpec.Part and not currentSpec.Part:IsDescendantOf(workspace)) then
			currentSpec.Kill = true
		end
		if currentSpec.Kill then
			if CircleActionModule.Spec == currentSpec then
				if currentSpec.HideFun then
					currentSpec:HideFun()
				end
				CircleActionModule.Spec = nil
			end
			octreeStructure:Remove(currentSpec)
			table.remove(specsList, i)
		end
	end
	local Character = LocalPlayer.Character
	if Character then
		local PrimaryPart = Character.PrimaryPart
		if PrimaryPart then
			local Position = PrimaryPart.Position
			local currentTime = os.clock()
			for i, v in ipairs(nearbySpecsList) do
				if not (v.Kill or v.WorldPosition) then
					local positionOffset = v.Attachment and v.Attachment.WorldPosition or v.Part and v.Part.Position
					if positionOffset then
						octreeStructure:Update(v, positionOffset)
					end
				end
			end
			if currentTime - lastOctreeUpdateTime >= 0.25 then
				lastOctreeUpdateTime = currentTime
				for j = 1, #specsList do
					local spec = specsList[j]
					if not spec.Kill then
						if spec.PreUpdateFun and (not spec.Part and (not spec.Attachment and not spec.WorldPosition)) then
							spec:PreUpdateFun()
						end
						local specPosition = spec.WorldPosition or (spec.Attachment and spec.Attachment.WorldPosition or spec.Part and spec.Part.Position)
						if specPosition then
							octreeStructure:Update(spec, specPosition)
						end
					end
				end
			end
			local queryResult = octreeStructure:QueryRadius(Position, 256)
			nearbySpecsList = queryResult
			local t = { Character }
			for i, v in ipairs(queryResult) do
				local isHorizontalInRange, isVerticalInRange, isDistanceInRange, hitPosition
				local Part = v.Part
				local Attachment = v.Attachment
				local targetPosition = v.WorldPosition or (Attachment == nil and (Part == nil and zeroVector or Part.Position) or Attachment.WorldPosition)
				local positionDelta = targetPosition - Position
				local horizontalVector = Vector3.new(positionDelta.X, 0, positionDelta.Z)
				local verticalVector = Vector3.new(0, positionDelta.Y, 0)
				local Magnitude = positionDelta.Magnitude
				local Magnitude_2 = horizontalVector.Magnitude
				local Magnitude_3 = verticalVector.Magnitude
				local Dist = v.Dist
				local HorizontalDist = v.HorizontalDist
				local VerticalDist = v.VerticalDist
				local IgnoreOverride = v.IgnoreOverride
				if v.PreUpdateFun and (not Part or Magnitude <= Dist) and (not v.LastPreUpdate or (v.PreUpdatePeriod or 0.2) <= currentTime - v.LastPreUpdate) then
					v.LastPreUpdate = currentTime
					v:PreUpdateFun()
				end
				if v.Enabled and (not CircleActionModule.Spec or (v == CircleActionModule.Spec or not CircleActionModule.Spec.Pressed)) then
					isHorizontalInRange = if HorizontalDist == nil then false else Magnitude_2 <= HorizontalDist
					isVerticalInRange = if VerticalDist == nil then false else Magnitude_3 <= VerticalDist
					isDistanceInRange = if Dist == nil then isHorizontalInRange and isVerticalInRange else Magnitude <= Dist
					if isDistanceInRange then
						local isRaycastClear = false
						if v.NoRay then
							isRaycastClear = true
						else
							local raycastParams = RaycastParams.new()
							raycastParams.FilterDescendantsInstances = IgnoreOverride or t
							local raycastResult = Raycast.collidable(Position, positionDelta.Unit, Magnitude, raycastParams)
							local hitInstance = nil
							if raycastResult then
								hitInstance = raycastResult.Instance
								hitPosition = raycastResult.Position
							else
								hitPosition = Position + positionDelta.Unit * Magnitude
							end
							if (hitPosition - targetPosition).Magnitude <= 1 or hitInstance and (hitInstance == v.Part or v.ValidRoot and hitInstance:IsDescendantOf(v.ValidRoot)) then
								isRaycastClear = true
							end
						end
						if isRaycastClear then
							local Priority = v.Priority
							if Magnitude <= closestDistance or highestPriority < Priority then
								closestDistance = Magnitude
								highestPriority = Priority
								selectedSpec = v
							end
						end
					end
				end
			end
			local Spec = CircleActionModule.Spec
			if not Spec or (selectedSpec == Spec or not Spec.Pressed) then
				if Spec and (Spec.HideFun and selectedSpec ~= Spec) then
					Spec:HideFun()
				end
				CircleActionModule.Spec = selectedSpec
				if selectedSpec then
					if selectedSpec.ShowFun and selectedSpec ~= Spec then
						selectedSpec:ShowFun()
					end
					if selectedSpec.Update then
						selectedSpec:Update()
					end
					return true
				end
			end
		end
	end
end
local function ProcessSpec()
	local Spec = CircleActionModule.Spec
	if Spec and Spec.Pressed then
		local sum = os.clock() - Spec.PressedAt
		if Spec.GetAccumulation then
			sum = sum + Spec.GetAccumulation()
		end
		local progressFraction = sum / Spec.Duration
		if progressFraction >= 1 then
			progressFraction = 1
		end
		if Spec.WhilePressedUpdate then
			Spec.WhilePressedUpdate(progressFraction)
		end
		if Spec.ForceRelease then
			Spec.ForceRelease = false
			Release()
		elseif progressFraction == 1 then
			Spec.Pressed = false
			Spec.PressedAt = nil
			local callbackResult = Spec:Callback(true)
			if Spec.ReleaseCallback then
				Spec:ReleaseCallback(true)
			end
			if callbackResult then
				local successSpec = AnimationController.MakeSpec()
				successSpec.Duration = 0.5
				successSpec.Start = afPulse_Start
				successSpec.End = afPulse_End
				successSpec.Update = afPulse_Update
				AnimationController.Push(animationGroup, successSpec)
				return
			end
			local failureSpec = AnimationController.MakeSpec()
			failureSpec.Duration = 0.3
			failureSpec.Start = afPulse_Start
			failureSpec.End = afPulse_End
			failureSpec.Update = afPulse_Update
			failureSpec.Red = true
			AnimationController.Push(animationGroup, failureSpec)
		end
	end
end
local function UpdatePlatform()
	local Frame = CircleActionModule.Frame
	local lastInputType = UserInputService:GetLastInputType()
	local inputDisplay
	if InputUtils.isTouch() then
		inputDisplay = nil
	elseif lastInputType == Enum.UserInputType.Gamepad1 then
		local keyString = UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonY)
		inputDisplay = if keyString == "ButtonTriangle" then "\226\150\179" elseif keyString == "ButtonY" then "Y" else keyString
	else
		inputDisplay = "E"
	end
	Frame.TextLabel.Visible = inputDisplay ~= nil
	Frame.PointLabel.Visible = inputDisplay == nil
	if inputDisplay then
		Frame.TextLabel.Text = inputDisplay
	end
	local Spec = CircleActionModule.Spec
	Frame.Hold.Visible = Spec and Spec.Timed
end
local lastSpecState = nil
function CircleActionModule.UpdateLogic(deltaTime)
	if not UpdateUI() and CircleActionModule.Spec then
		if CircleActionModule.Spec.HideFun then
			CircleActionModule.Spec:HideFun()
		end
		Release()
	end
	UpdatePlatform()
	ProcessSpec()
	if CircleActionModule.Spec ~= lastSpecState then
		CircleActionModule.onVisibilityChanged:Fire(CircleActionModule.Spec ~= nil)
	end
	lastSpecState = CircleActionModule.Spec
end
function CircleActionModule.UpdateVisual(deltaTime)
	local Spec = CircleActionModule.Spec
	local Frame = CircleActionModule.Frame
	if Spec then
		local Attachment = Spec.Attachment
		local Part = Spec.Part
		local WorldPosition = Spec.WorldPosition
		if not WorldPosition and Attachment == nil then
			WorldPosition = if Part == nil then zeroVector else Part.Position or zeroVector
		elseif not WorldPosition then
			WorldPosition = Attachment.WorldPosition
			if not WorldPosition then
				WorldPosition = if Part == nil then zeroVector else Part.Position or zeroVector
			end
		end
		local screenPos, isOnScreen = CurrentCamera:WorldToScreenPoint(WorldPosition)
		Frame.Visible = isOnScreen
		if isOnScreen then
			Spec.ScreenPosition = Vector3.new(screenPos.X, screenPos.Y, 0)
			Frame.Position = UDim2.new(0, screenPos.X, 0, screenPos.Y) - UDim2.new(0, Frame.AbsoluteSize.X * 0.5, 0, Frame.AbsoluteSize.Y * 0.5)
			Frame.Help.Text = Spec.Name or ""
			Frame.Help.Visible = Spec.Name and true or false
		end
	else
		Frame.Visible = false
	end
	AnimationController.Update(animationGroup, deltaTime)
end
local isCurrentlyTouching = false
local function TouchStarted(touchInput)
	local Spec = CircleActionModule.Spec
	if Spec then
		local ScreenPosition = Spec.ScreenPosition
		if ScreenPosition and (touchInput.Position - ScreenPosition).Magnitude < CircleActionModule.Frame.AbsoluteSize.X * 0.5 then
			isCurrentlyTouching = true
			Press()
			return true
		else
			return false
		end
	end
end
local function TouchEnded(touchInput)
	if isCurrentlyTouching then
		isCurrentlyTouching = false
		Release()
	end
end
local lastInputType = nil
local function InputBegan(inputEvent, gameProcessed)
	if not gameProcessed and inputEvent.UserInputType == Enum.UserInputType.MouseButton1 then
		local Spec = CircleActionModule.Spec
		local inputHandled
		if Spec then
			local ScreenPosition = Spec.ScreenPosition
			if ScreenPosition and (inputEvent.Position - ScreenPosition).Magnitude < CircleActionModule.Frame.AbsoluteSize.X * 0.5 then
				isCurrentlyTouching = true
				Press()
				inputHandled = true
			else
				inputHandled = false
			end
		else
			inputHandled = nil
		end
		if inputHandled then
			lastInputType = Enum.UserInputType.MouseButton1
		end
	end
end
local function InputEnded(inputEvent, gameProcessed)
	if not gameProcessed and (inputEvent.UserInputType == Enum.UserInputType.MouseButton1 and lastInputType == Enum.UserInputType.MouseButton1 and isCurrentlyTouching) then
		isCurrentlyTouching = false
		Release()
	end
end
UserInputService.InputBegan:connect(InputBegan)
UserInputService.InputEnded:connect(InputEnded)
UserInputService.TouchStarted:connect(TouchStarted)
UserInputService.TouchEnded:connect(TouchEnded)
return {
	CircleAction = CircleActionModule,
	Animation = AnimationController
}
