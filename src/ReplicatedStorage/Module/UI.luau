-- Reviewed by Claude
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local Signal = require(ReplicatedStorage.Std.Signal)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local Octree = require(ReplicatedStorage.Std.Octree)
local t = {
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
function t.Push(group, spec)
	t.Cancel(group)
	assert(spec.Duration)
	assert(spec.Start)
	assert(spec.End)
	assert(spec.Update)
	if not spec.Cancel then
		spec.Cancel = spec.End
	end
	group.Running = spec
end
function t.Update(group, deltaTime)
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
local t2 = {
	onVisibilityChanged = Signal.new()
}
local animationGroup = t.MakeGroup()
local specsList = {}
t2.Specs = specsList
local zeroVector = Vector3.new()
local octreeStructure = Octree.new(Vector3.new(0, 50, 0), 8192, 8, 8)
t2.SpecOctree = octreeStructure
local nearbySpecsList = {}
local lastOctreeUpdateTime = 0
function t2.Add(p1, p2)
	assert(p2, "No key found, second param to Add must be nil")
	p1.Tag = p2
	if not p1.Enabled then
		p1.Enabled = true
	end
	if not p1.Priority then
		p1.Priority = 1
	end
	table.insert(t3, p1)
	local WorldPosition = p1.WorldPosition
	if not WorldPosition then
		WorldPosition = p1.Attachment and p1.Attachment.WorldPosition or (p1.Part and p1.Part.Position or v2)
	end
	var3:Insert(p1, WorldPosition)
	return function()
		return t2.Remove(p2)
	end
end
function t2.Remove(p1)
	for i = #t3, 1, -1 do
		local color = t3[i]
		if color.Tag == p1 then
			if t2.Spec == color then
				if color.HideFun then
					color:HideFun()
				end
				t2.Spec = nil
			end
			var3:Remove(color)
			table.remove(t3, i)
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
	local Frame = t2.Frame
	local Image = Frame.OuterFrame.Left.Image
	local Image_2 = Frame.OuterFrame.Right.Image
	local color = math.clamp(p1 * 360, 0, 360)
	Image.UIGradient.Rotation = math.clamp(color, 180, 360)
	Image_2.UIGradient.Rotation = math.clamp(color, 0, 180)
	local v2 = p1 < 0.999
	Image.Visible = v2
	Image_2.Visible = v2
	Frame.OuterFrame.OuterFull.Visible = not v2
end
local function SetCircleColor(p1)
	local Frame = t2.Frame
	Frame.OuterFrame.Left.Image.ImageColor3 = p1
	Frame.OuterFrame.Right.Image.ImageColor3 = p1
	Frame.OuterFrame.OuterFull.ImageColor3 = p1
end
local function SetCircleRadius(p1)
	local Frame = t2.Frame
	Frame.OuterFrame.Size = UDim2.new(1, 2 * p1, 1, 2 * p1)
	Frame.OuterFrame.Position = UDim2.new(0, -p1, 0, -p1)
end
local sin = math.sin
local function afSpin_Start()
	circleProgress = 0
	local Frame = t2.Frame
	local Image = Frame.OuterFrame.Left.Image
	local Image_2 = Frame.OuterFrame.Right.Image
	Image.UIGradient.Rotation = 180
	Image_2.UIGradient.Rotation = 0
	Image.Visible = true
	Image_2.Visible = true
	Frame.OuterFrame.OuterFull.Visible = false
	local Frame_2 = t2.Frame
	Frame_2.OuterFrame.Size = UDim2.new(1, 8, 1, 8)
	Frame_2.OuterFrame.Position = UDim2.new(0, -4, 0, -4)
	local color = Color3.fromRGB(214, 214, 214)
	local Frame_3 = t2.Frame
	Frame_3.OuterFrame.Left.Image.ImageColor3 = color
	Frame_3.OuterFrame.Right.Image.ImageColor3 = color
	Frame_3.OuterFrame.OuterFull.ImageColor3 = color
end
local function afSpin_End()
	circleProgress = 1
	local Frame = t2.Frame
	local Image = Frame.OuterFrame.Left.Image
	local Image_2 = Frame.OuterFrame.Right.Image
	Image.UIGradient.Rotation = 360
	Image_2.UIGradient.Rotation = 180
	Image.Visible = false
	Image_2.Visible = false
	Frame.OuterFrame.OuterFull.Visible = true
	local Frame_2 = t2.Frame
	Frame_2.OuterFrame.Size = UDim2.new(1, 16, 1, 16)
	Frame_2.OuterFrame.Position = UDim2.new(0, -8, 0, -8)
	local color = Color3.fromRGB(214, 214, 214)
	local Frame_3 = t2.Frame
	Frame_3.OuterFrame.Left.Image.ImageColor3 = color
	Frame_3.OuterFrame.Right.Image.ImageColor3 = color
	Frame_3.OuterFrame.OuterFull.ImageColor3 = color
end
local function afSpin_Update(spec, progress, deltaTime)
	local sinValue = sin(progress) / 0.8414709848078965
	SetCirclePct(sinValue)
	local colorValue = 214 - (1 - sinValue) * 64
	local colorRGB = Color3.fromRGB(colorValue, colorValue, colorValue)
	local Frame = t2.Frame
	Frame.OuterFrame.Left.Image.ImageColor3 = colorRGB
	Frame.OuterFrame.Right.Image.ImageColor3 = colorRGB
	Frame.OuterFrame.OuterFull.ImageColor3 = colorRGB
	local radiusSize = sinValue * 4 + 4
	local Frame_2 = t2.Frame
	Frame_2.OuterFrame.Size = UDim2.new(1, 2 * radiusSize, 1, 2 * radiusSize)
	Frame_2.OuterFrame.Position = UDim2.new(0, -radiusSize, 0, -radiusSize)
end
local pulseProgress = 1
local function Ease_outBack(p1, p2, p3, p4, p5)
	p5 = p5 or 1.70158
	local color = p1 / p4 - 1
	return p3 * (color * color * ((p5 + 1) * color + p5) + 1) + p2
end
local function afPulse_Start()
	local color = Color3.fromRGB(214, 214, 214)
	local Frame = t2.Frame
	Frame.OuterFrame.Left.Image.ImageColor3 = color
	Frame.OuterFrame.Right.Image.ImageColor3 = color
	Frame.OuterFrame.OuterFull.ImageColor3 = color
	local Frame_2 = t2.Frame
	Frame_2.OuterFrame.Size = UDim2.new(1, 0, 1, 0)
	Frame_2.OuterFrame.Position = UDim2.new(0, -0, 0, -0)
end
local function afPulse_End()
	circleProgress = 1
	local Frame = t2.Frame
	local Image = Frame.OuterFrame.Left.Image
	local Image_2 = Frame.OuterFrame.Right.Image
	Image.UIGradient.Rotation = 360
	Image_2.UIGradient.Rotation = 180
	Image.Visible = false
	Image_2.Visible = false
	Frame.OuterFrame.OuterFull.Visible = true
	pulseProgress = 1
	local color = Color3.fromRGB(214, 214, 214)
	local Frame_2 = t2.Frame
	Frame_2.OuterFrame.Left.Image.ImageColor3 = color
	Frame_2.OuterFrame.Right.Image.ImageColor3 = color
	Frame_2.OuterFrame.OuterFull.ImageColor3 = color
	local Frame_3 = t2.Frame
	Frame_3.OuterFrame.Size = UDim2.new(1, 16, 1, 16)
	Frame_3.OuterFrame.Position = UDim2.new(0, -8, 0, -8)
end
local function afPulse_Update(spec, progress, deltaTime)
	SetCirclePct(pulseProgress * (1 - progress) + progress)
	local easeOutBackFactor = 6 or 1.70158
	local normalizedProgress = progress / 1 - 1
	local easedRadius = 8 * (1 * (normalizedProgress * normalizedProgress * ((easeOutBackFactor + 1) * normalizedProgress + easeOutBackFactor) + 1) + 0)
	local Frame = t2.Frame
	Frame.OuterFrame.Size = UDim2.new(1, 2 * easedRadius, 1, 2 * easedRadius)
	Frame.OuterFrame.Position = UDim2.new(0, -easedRadius, 0, -easedRadius)
	if spec.Red then
		local redIntensity = 40 - 40 * progress
		local inverseProgress = 1 - progress
		local redColor = Color3.fromRGB(214 * inverseProgress + 214 * progress + redIntensity, 69 * inverseProgress + 214 * progress + redIntensity, 69 * inverseProgress + 214 * progress + redIntensity)
		local Frame_2 = t2.Frame
		Frame_2.OuterFrame.Left.Image.ImageColor3 = redColor
		Frame_2.OuterFrame.Right.Image.ImageColor3 = redColor
		Frame_2.OuterFrame.OuterFull.ImageColor3 = redColor
	end
end
function t2.NotAllowed()
	local notAllowedSpec = t.MakeSpec()
	notAllowedSpec.Duration = 0.3
	notAllowedSpec.Start = afPulse_Start
	notAllowedSpec.End = afPulse_End
	notAllowedSpec.Update = afPulse_Update
	notAllowedSpec.Red = true
	t.Push(animationGroup, notAllowedSpec)
end
local function Press()
	local Spec = t2.Spec
	if Spec then
		Spec:Callback(false)
		if Spec.Timed then
			Spec.Pressed = true
			Spec.PressedAt = os.clock()
			local spinSpec = t.MakeSpec()
			spinSpec.Duration = Spec.Duration
			spinSpec.Start = afSpin_Start
			spinSpec.End = afSpin_End
			spinSpec.Update = afSpin_Update
			if Spec.GetAccumulation then
			spinSpec.Elapsed = Spec.GetAccumulation()
			end
			t.Push(animationGroup, spinSpec)
			Spec.Animation = var12
		elseif Spec:Callback(true) then
			local pulseSpec = t.MakeSpec()
			pulseSpec.Duration = 0.3
			pulseSpec.Start = afPulse_Start
			pulseSpec.End = afPulse_End
			pulseSpec.Update = afPulse_Update
			t.Push(animationGroup, pulseSpec)
		else
			local failSpec = t.MakeSpec()
			failSpec.Duration = 0.3
			failSpec.Start = afPulse_Start
			failSpec.End = afPulse_End
			failSpec.Update = afPulse_Update
			failSpec.Red = true
			t.Push(animationGroup, failSpec)
		end
	end
end
local function Release()
	local Spec = t2.Spec
	if Spec then
		Spec.Pressed = false
		Spec.PressedAt = nil
		if color.Running ~= nil and color.Running == Spec.Animation then
			var6 = var5
			t.Cancel(color)
			local var12 = t.MakeSpec()
			var12.Duration = 0.3
			var12.Start = afPulse_Start
			var12.End = afPulse_End
			var12.Update = afPulse_Update
			var12.Red = true
			t.Push(color, var12)
		end
		Spec.Animation = nil
		Spec.ScreenPosition = nil
		t2.Spec = nil
		if Spec.ReleaseCallback then
			Spec:ReleaseCallback(false)
		end
	end
end
t2.Press = Press
t2.Release = Release
local function UpdateUI()
	local color = 999
	local var22 = 1
	local var32 = nil
	for i = #t3, 1, -1 do
		local var42 = t3[i]
		if not var42.Kill and (var42.Part and not var42.Part:IsDescendantOf(workspace)) then
			var42.Kill = true
		end
		if var42.Kill then
			if t2.Spec == var42 then
				if var42.HideFun then
					var42:HideFun()
				end
				t2.Spec = nil
			end
			var3:Remove(var42)
			table.remove(t3, i)
		end
	end
	local Character = LocalPlayer.Character
	if Character then
		local PrimaryPart = Character.PrimaryPart
		if PrimaryPart then
			local Position = PrimaryPart.Position
			local var5 = os.clock()
			for i, v in ipairs(t4) do
				if not (v.Kill or v.WorldPosition) then
					local var6 = v.Attachment and v.Attachment.WorldPosition or v.Part and v.Part.Position
					if var6 then
						var3:Update(v, var6)
					end
				end
			end
			if var5 - var4 >= 0.25 then
				var4 = var5
				for j = 1, #t3 do
					local var8 = t3[j]
					if not var8.Kill then
						if var8.PreUpdateFun and (not var8.Part and (not var8.Attachment and not var8.WorldPosition)) then
							var8:PreUpdateFun()
						end
						local var10 = var8.WorldPosition or (var8.Attachment and var8.Attachment.WorldPosition or var8.Part and var8.Part.Position)
						if var10 then
							var3:Update(var8, var10)
						end
					end
				end
			end
			local var11 = var3:QueryRadius(Position, 256)
			t4 = var11
			local t = { Character }
			for i, v in ipairs(var11) do
				local var12, v13, v14, v15
				local Part = v.Part
				local Attachment = v.Attachment
				local var16 = v.WorldPosition or (Attachment == nil and (Part == nil and v2 or Part.Position) or Attachment.WorldPosition)
				local var17 = var16 - Position
				local vector18 = Vector3.new(var17.X, 0, var17.Z)
				local vector19 = Vector3.new(0, var17.Y, 0)
				local Magnitude = var17.Magnitude
				local Magnitude_2 = vector18.Magnitude
				local Magnitude_3 = vector19.Magnitude
				local Dist = v.Dist
				local HorizontalDist = v.HorizontalDist
				local VerticalDist = v.VerticalDist
				local IgnoreOverride = v.IgnoreOverride
				if v.PreUpdateFun and (not Part or Magnitude <= Dist) and (not v.LastPreUpdate or (v.PreUpdatePeriod or 0.2) <= var5 - v.LastPreUpdate) then
					v.LastPreUpdate = var5
					v:PreUpdateFun()
				end
				if v.Enabled and (not t2.Spec or (v == t2.Spec or not t2.Spec.Pressed)) then
					var12 = if HorizontalDist == nil then false else Magnitude_2 <= HorizontalDist
					v13 = if VerticalDist == nil then false else Magnitude_3 <= VerticalDist
					v14 = if Dist == nil then var12 and v13 else Magnitude <= Dist
					if v14 then
						local var21 = false
						if v.NoRay then
							var21 = true
						else
							local instance222 = RaycastParams.new()
							instance222.FilterDescendantsInstances = IgnoreOverride or t
							local var23 = Raycast.collidable(Position, var17.Unit, Magnitude, instance222)
							local var24 = nil
							if var23 then
								var24 = var23.Instance
								v15 = var23.Position
							else
								v15 = Position + var17.Unit * Magnitude
							end
							if (v15 - var16).Magnitude <= 1 or var24 and (var24 == v.Part or v.ValidRoot and var24:IsDescendantOf(v.ValidRoot)) then
								var21 = true
							end
						end
						if var21 then
							local Priority = v.Priority
							if Magnitude <= color or var22 < Priority then
								color = Magnitude
								var22 = Priority
								var32 = v
							end
						end
					end
				end
			end
			local Spec = t2.Spec
			if not Spec or (var32 == Spec or not Spec.Pressed) then
				if Spec and (Spec.HideFun and var32 ~= Spec) then
					Spec:HideFun()
				end
				t2.Spec = var32
				if var32 then
					if var32.ShowFun and var32 ~= Spec then
						var32:ShowFun()
					end
					if var32.Update then
						var32:Update()
					end
					return true
				end
			end
		end
	end
end
local function ProcessSpec()
	local Spec = t2.Spec
	if Spec and Spec.Pressed then
		local sum = os.clock() - Spec.PressedAt
		if Spec.GetAccumulation then
			sum = sum + Spec.GetAccumulation()
		end
		local var12 = sum / Spec.Duration
		if var12 >= 1 then
			var12 = 1
		end
		if Spec.WhilePressedUpdate then
			Spec.WhilePressedUpdate(var12)
		end
		if Spec.ForceRelease then
			Spec.ForceRelease = false
			Release()
		elseif var12 == 1 then
			Spec.Pressed = false
			Spec.PressedAt = nil
			local v2 = Spec:Callback(true)
			if Spec.ReleaseCallback then
				Spec:ReleaseCallback(true)
			end
			if v2 then
				local var3 = t.MakeSpec()
				var3.Duration = 0.5
				var3.Start = afPulse_Start
				var3.End = afPulse_End
				var3.Update = afPulse_Update
				t.Push(color, var3)
				return
			end
			local var4 = t.MakeSpec()
			var4.Duration = 0.3
			var4.Start = afPulse_Start
			var4.End = afPulse_End
			var4.Update = afPulse_Update
			var4.Red = true
			t.Push(color, var4)
		end
	end
end
local function UpdatePlatform()
	local Frame = t2.Frame
	local color = UserInputService:GetLastInputType()
	local v2
	if InputUtils.isTouch() then
		v2 = nil
	elseif color == Enum.UserInputType.Gamepad1 then
		local var3 = UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonY)
		v2 = if var3 == "ButtonTriangle" then "\226\150\179" elseif var3 == "ButtonY" then "Y" else var3
	else
		v2 = "E"
	end
	Frame.TextLabel.Visible = v2 ~= nil
	Frame.PointLabel.Visible = v2 == nil
	if v2 then
		Frame.TextLabel.Text = v2
	end
	local Spec = t2.Spec
	Frame.Hold.Visible = Spec and Spec.Timed
end
local lastSpecState = nil
function t2.UpdateLogic(deltaTime)
	if not UpdateUI() and t2.Spec then
		if t2.Spec.HideFun then
			t2.Spec:HideFun()
		end
		Release()
	end
	UpdatePlatform()
	ProcessSpec()
	if t2.Spec ~= lastSpecState then
		t2.onVisibilityChanged:Fire(t2.Spec ~= nil)
	end
	lastSpecState = t2.Spec
end
function t2.UpdateVisual(deltaTime)
	local Spec = t2.Spec
	local Frame = t2.Frame
	if Spec then
		local Attachment = Spec.Attachment
		local Part = Spec.Part
		local WorldPosition = Spec.WorldPosition
		if not WorldPosition and Attachment == nil then
			WorldPosition = if Part == nil then v2 else Part.Position or v2
		elseif not WorldPosition then
			WorldPosition = Attachment.WorldPosition
			if not WorldPosition then
				WorldPosition = if Part == nil then v2 else Part.Position or v2
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
	t.Update(animationGroup, deltaTime)
end
local var8 = false
local function TouchStarted(p1)
	local Spec = t2.Spec
	if Spec then
		local ScreenPosition = Spec.ScreenPosition
		if ScreenPosition and (p1.Position - ScreenPosition).Magnitude < t2.Frame.AbsoluteSize.X * 0.5 then
			var8 = true
			Press()
			return true
		else
			return false
		end
	end
end
local function TouchEnded(p1)
	if var8 then
		var8 = false
		Release()
	end
end
local var9 = nil
local function InputBegan(p1, p2)
	if not p2 and p1.UserInputType == Enum.UserInputType.MouseButton1 then
		local Spec = t2.Spec
		local color
		if Spec then
			local ScreenPosition = Spec.ScreenPosition
			if ScreenPosition and (p1.Position - ScreenPosition).Magnitude < t2.Frame.AbsoluteSize.X * 0.5 then
				var8 = true
				Press()
				color = true
			else
				color = false
			end
		else
			color = nil
		end
		if color then
			var9 = Enum.UserInputType.MouseButton1
		end
	end
end
local function InputEnded(p1, p2)
	if not p2 and (p1.UserInputType == Enum.UserInputType.MouseButton1 and var9 == Enum.UserInputType.MouseButton1 and var8) then
		var8 = false
		Release()
	end
end
UserInputService.InputBegan:connect(InputBegan)
UserInputService.InputEnded:connect(InputEnded)
UserInputService.TouchStarted:connect(TouchStarted)
UserInputService.TouchEnded:connect(TouchEnded)
return {
	CircleAction = t2,
	Animation = t
}
