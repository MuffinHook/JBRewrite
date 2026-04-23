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
	MakeGroup = function() --[[ Name: MakeGroup | Line: 14 ]]
		return {
			Running = nil
		}
	end,
	MakeSpec = function() --[[ Name: MakeSpec | Line: 19 ]]
		return {
			Duration = nil,
			Start = nil,
			End = nil,
			Cancel = nil,
			Update = nil
		}
	end,
	Cancel = function(p1) --[[ Name: Cancel | Line: 28 ]]
		local Running = p1.Running
		if Running then
			Running:Cancel()
			p1.Running = nil
		end
	end
}
function t.Push(p1, p2) --[[ Line: 35 | Upvalues: t (ref) ]]
	t.Cancel(p1)
	assert(p2.Duration)
	assert(p2.Start)
	assert(p2.End)
	assert(p2.Update)
	if not p2.Cancel then
		p2.Cancel = p2.End
	end
	p1.Running = p2
end
function t.Update(p1, p2) --[[ Line: 46 ]]
	local Running = p1.Running
	if Running then
		local v1 = os.clock()
		if not Running.Started then
			Running.Started = v1
			Running:Start()
		end
		local sum = v1 - Running.Started
		if Running.Elapsed then
			sum = sum + Running.Elapsed
		end
		local v2 = sum / Running.Duration
		if v2 >= 1 then
			v2 = 1
		end
		Running:Update(v2, p2)
		if v2 >= 1 then
			Running:End()
			p1.Running = nil
		end
	end
end
local t2 = {
	onVisibilityChanged = Signal.new()
}
local v1 = t.MakeGroup()
local t3 = {}
t2.Specs = t3
local v2 = Vector3.new()
local v3 = Octree.new(Vector3.new(0, 50, 0), 8192, 8, 8)
t2.SpecOctree = v3
local t4 = {}
local v4 = 0
function t2.Add(p1, p2) --[[ Line: 89 | Upvalues: t3 (copy), v2 (copy), v3 (copy), t2 (ref) ]]
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
	v3:Insert(p1, WorldPosition)
	return function() --[[ Line: 104 | Upvalues: t2 (ref), p2 (copy) ]]
		return t2.Remove(p2)
	end
end
function t2.Remove(p1) --[[ Line: 108 | Upvalues: t3 (copy), t2 (ref), v3 (copy) ]]
	for i = #t3, 1, -1 do
		local v1 = t3[i]
		if v1.Tag == p1 then
			if t2.Spec == v1 then
				if v1.HideFun then
					v1:HideFun()
				end
				t2.Spec = nil
			end
			v3:Remove(v1)
			table.remove(t3, i)
			return true
		end
	end
	return false
end
local v5 = 1
local function GetCirclePct() --[[ Line: 126 | Upvalues: v5 (ref) ]]
	return v5
end
local function SetCirclePct(p1) --[[ Line: 129 | Upvalues: v5 (ref), t2 (ref) ]]
	v5 = p1
	local Frame = t2.Frame
	local Image = Frame.OuterFrame.Left.Image
	local Image_2 = Frame.OuterFrame.Right.Image
	local v1 = math.clamp(p1 * 360, 0, 360)
	Image.UIGradient.Rotation = math.clamp(v1, 180, 360)
	Image_2.UIGradient.Rotation = math.clamp(v1, 0, 180)
	local v2 = p1 < 0.999
	Image.Visible = v2
	Image_2.Visible = v2
	Frame.OuterFrame.OuterFull.Visible = not v2
end
local function SetCircleColor(p1) --[[ Line: 144 | Upvalues: t2 (ref) ]]
	local Frame = t2.Frame
	Frame.OuterFrame.Left.Image.ImageColor3 = p1
	Frame.OuterFrame.Right.Image.ImageColor3 = p1
	Frame.OuterFrame.OuterFull.ImageColor3 = p1
end
local function SetCircleRadius(p1) --[[ Line: 152 | Upvalues: t2 (ref) ]]
	local Frame = t2.Frame
	Frame.OuterFrame.Size = UDim2.new(1, 2 * p1, 1, 2 * p1)
	Frame.OuterFrame.Position = UDim2.new(0, -p1, 0, -p1)
end
local sin = math.sin
local function afSpin_Start() --[[ Line: 160 | Upvalues: v5 (ref), t2 (ref) ]]
	v5 = 0
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
	local v1 = Color3.fromRGB(214, 214, 214)
	local Frame_3 = t2.Frame
	Frame_3.OuterFrame.Left.Image.ImageColor3 = v1
	Frame_3.OuterFrame.Right.Image.ImageColor3 = v1
	Frame_3.OuterFrame.OuterFull.ImageColor3 = v1
end
local function afSpin_End() --[[ Line: 165 | Upvalues: v5 (ref), t2 (ref) ]]
	v5 = 1
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
	local v1 = Color3.fromRGB(214, 214, 214)
	local Frame_3 = t2.Frame
	Frame_3.OuterFrame.Left.Image.ImageColor3 = v1
	Frame_3.OuterFrame.Right.Image.ImageColor3 = v1
	Frame_3.OuterFrame.OuterFull.ImageColor3 = v1
end
local function afSpin_Update(p1, p2, p3) --[[ Line: 170 | Upvalues: sin (copy), SetCirclePct (copy), t2 (ref) ]]
	local v1 = sin(p2) / 0.8414709848078965
	SetCirclePct(v1)
	local v2 = 214 - (1 - v1) * 64
	local v3 = Color3.fromRGB(v2, v2, v2)
	local Frame = t2.Frame
	Frame.OuterFrame.Left.Image.ImageColor3 = v3
	Frame.OuterFrame.Right.Image.ImageColor3 = v3
	Frame.OuterFrame.OuterFull.ImageColor3 = v3
	local v4 = v1 * 4 + 4
	local Frame_2 = t2.Frame
	Frame_2.OuterFrame.Size = UDim2.new(1, 2 * v4, 1, 2 * v4)
	Frame_2.OuterFrame.Position = UDim2.new(0, -v4, 0, -v4)
end
local v6 = 1
local function Ease_outBack(p1, p2, p3, p4, p5) --[[ Line: 184 ]]
	p5 = p5 or 1.70158
	local v1 = p1 / p4 - 1
	return p3 * (v1 * v1 * ((p5 + 1) * v1 + p5) + 1) + p2
end
local function afPulse_Start() --[[ Line: 191 | Upvalues: t2 (ref) ]]
	local v1 = Color3.fromRGB(214, 214, 214)
	local Frame = t2.Frame
	Frame.OuterFrame.Left.Image.ImageColor3 = v1
	Frame.OuterFrame.Right.Image.ImageColor3 = v1
	Frame.OuterFrame.OuterFull.ImageColor3 = v1
	local Frame_2 = t2.Frame
	Frame_2.OuterFrame.Size = UDim2.new(1, 0, 1, 0)
	Frame_2.OuterFrame.Position = UDim2.new(0, -0, 0, -0)
end
local function afPulse_End() --[[ Line: 196 | Upvalues: v5 (ref), t2 (ref), v6 (ref) ]]
	v5 = 1
	local Frame = t2.Frame
	local Image = Frame.OuterFrame.Left.Image
	local Image_2 = Frame.OuterFrame.Right.Image
	Image.UIGradient.Rotation = 360
	Image_2.UIGradient.Rotation = 180
	Image.Visible = false
	Image_2.Visible = false
	Frame.OuterFrame.OuterFull.Visible = true
	v6 = 1
	local v1 = Color3.fromRGB(214, 214, 214)
	local Frame_2 = t2.Frame
	Frame_2.OuterFrame.Left.Image.ImageColor3 = v1
	Frame_2.OuterFrame.Right.Image.ImageColor3 = v1
	Frame_2.OuterFrame.OuterFull.ImageColor3 = v1
	local Frame_3 = t2.Frame
	Frame_3.OuterFrame.Size = UDim2.new(1, 16, 1, 16)
	Frame_3.OuterFrame.Position = UDim2.new(0, -8, 0, -8)
end
local function afPulse_Update(p1, p2, p3) --[[ Line: 203 | Upvalues: SetCirclePct (copy), v6 (ref), t2 (ref) ]]
	SetCirclePct(v6 * (1 - p2) + p2)
	local v2 = 6 or 1.70158
	local v3 = p2 / 1 - 1
	local v4 = 8 * (1 * (v3 * v3 * ((v2 + 1) * v3 + v2) + 1) + 0)
	local Frame = t2.Frame
	Frame.OuterFrame.Size = UDim2.new(1, 2 * v4, 1, 2 * v4)
	Frame.OuterFrame.Position = UDim2.new(0, -v4, 0, -v4)
	if p1.Red then
		local v5 = 40 - 40 * p2
		local v62 = 1 - p2
		local v7 = Color3.fromRGB(214 * v62 + 214 * p2 + v5, 69 * v62 + 214 * p2 + v5, 69 * v62 + 214 * p2 + v5)
		local Frame_2 = t2.Frame
		Frame_2.OuterFrame.Left.Image.ImageColor3 = v7
		Frame_2.OuterFrame.Right.Image.ImageColor3 = v7
		Frame_2.OuterFrame.OuterFull.ImageColor3 = v7
	end
end
function t2.NotAllowed() --[[ Line: 216 | Upvalues: t (ref), afPulse_Start (ref), afPulse_End (ref), afPulse_Update (ref), v1 (copy) ]]
	local v12 = t.MakeSpec()
	v12.Duration = 0.3
	v12.Start = afPulse_Start
	v12.End = afPulse_End
	v12.Update = afPulse_Update
	v12.Red = true
	t.Push(v1, v12)
end
local function Press() --[[ Line: 226 | Upvalues: t2 (ref), t (ref), afSpin_Start (ref), afSpin_End (ref), afSpin_Update (ref), v1 (copy), afPulse_Start (ref), afPulse_End (ref), afPulse_Update (ref) ]]
	local Spec = t2.Spec
	if Spec then
		Spec:Callback(false)
		if Spec.Timed then
			Spec.Pressed = true
			Spec.PressedAt = os.clock()
			local v12 = t.MakeSpec()
			v12.Duration = Spec.Duration
			v12.Start = afSpin_Start
			v12.End = afSpin_End
			v12.Update = afSpin_Update
			if Spec.GetAccumulation then
				v12.Elapsed = Spec.GetAccumulation()
			end
			t.Push(v1, v12)
			Spec.Animation = v12
		elseif Spec:Callback(true) then
			local v2 = t.MakeSpec()
			v2.Duration = 0.3
			v2.Start = afPulse_Start
			v2.End = afPulse_End
			v2.Update = afPulse_Update
			t.Push(v1, v2)
		else
			local v3 = t.MakeSpec()
			v3.Duration = 0.3
			v3.Start = afPulse_Start
			v3.End = afPulse_End
			v3.Update = afPulse_Update
			v3.Red = true
			t.Push(v1, v3)
		end
	end
end
local function Release() --[[ Line: 261 | Upvalues: t2 (ref), v1 (copy), v6 (ref), v5 (ref), t (ref), afPulse_Start (ref), afPulse_End (ref), afPulse_Update (ref) ]]
	local Spec = t2.Spec
	if Spec then
		Spec.Pressed = false
		Spec.PressedAt = nil
		if v1.Running ~= nil and v1.Running == Spec.Animation then
			v6 = v5
			t.Cancel(v1)
			local v12 = t.MakeSpec()
			v12.Duration = 0.3
			v12.Start = afPulse_Start
			v12.End = afPulse_End
			v12.Update = afPulse_Update
			v12.Red = true
			t.Push(v1, v12)
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
local function UpdateUI() --[[ Line: 289 | Upvalues: t3 (copy), t2 (ref), v3 (copy), LocalPlayer (copy), t4 (ref), v4 (ref), v2 (copy), Raycast (copy) ]]
	local v1 = 999
	local v22 = 1
	local v32 = nil
	for i = #t3, 1, -1 do
		local v42 = t3[i]
		if not v42.Kill and (v42.Part and not v42.Part:IsDescendantOf(workspace)) then
			v42.Kill = true
		end
		if v42.Kill then
			if t2.Spec == v42 then
				if v42.HideFun then
					v42:HideFun()
				end
				t2.Spec = nil
			end
			v3:Remove(v42)
			table.remove(t3, i)
		end
	end
	local Character = LocalPlayer.Character
	if Character then
		local PrimaryPart = Character.PrimaryPart
		if PrimaryPart then
			local Position = PrimaryPart.Position
			local v5 = os.clock()
			for i, v in ipairs(t4) do
				if not (v.Kill or v.WorldPosition) then
					local v6 = v.Attachment and v.Attachment.WorldPosition or v.Part and v.Part.Position
					if v6 then
						v3:Update(v, v6)
					end
				end
			end
			if v5 - v4 >= 0.25 then
				v4 = v5
				for j = 1, #t3 do
					local v8 = t3[j]
					if not v8.Kill then
						if v8.PreUpdateFun and (not v8.Part and (not v8.Attachment and not v8.WorldPosition)) then
							v8:PreUpdateFun()
						end
						local v10 = v8.WorldPosition or (v8.Attachment and v8.Attachment.WorldPosition or v8.Part and v8.Part.Position)
						if v10 then
							v3:Update(v8, v10)
						end
					end
				end
			end
			local v11 = v3:QueryRadius(Position, 256)
			t4 = v11
			local t = { Character }
			for i, v in ipairs(v11) do
				local v12, v13, v14, v15
				local Part = v.Part
				local Attachment = v.Attachment
				local v16 = v.WorldPosition or (Attachment == nil and (Part == nil and v2 or Part.Position) or Attachment.WorldPosition)
				local v17 = v16 - Position
				local v18 = Vector3.new(v17.X, 0, v17.Z)
				local v19 = Vector3.new(0, v17.Y, 0)
				local Magnitude = v17.Magnitude
				local Magnitude_2 = v18.Magnitude
				local Magnitude_3 = v19.Magnitude
				local Dist = v.Dist
				local HorizontalDist = v.HorizontalDist
				local VerticalDist = v.VerticalDist
				local IgnoreOverride = v.IgnoreOverride
				if v.PreUpdateFun and (not Part or Magnitude <= Dist) and (not v.LastPreUpdate or (v.PreUpdatePeriod or 0.2) <= v5 - v.LastPreUpdate) then
					v.LastPreUpdate = v5
					v:PreUpdateFun()
				end
				if v.Enabled and (not t2.Spec or (v == t2.Spec or not t2.Spec.Pressed)) then
					v12 = if HorizontalDist == nil then false else Magnitude_2 <= HorizontalDist
					v13 = if VerticalDist == nil then false else Magnitude_3 <= VerticalDist
					v14 = if Dist == nil then v12 and v13 else Magnitude <= Dist
					if v14 then
						local v21 = false
						if v.NoRay then
							v21 = true
						else
							local v222 = RaycastParams.new()
							v222.FilterDescendantsInstances = IgnoreOverride or t
							local v23 = Raycast.collidable(Position, v17.Unit, Magnitude, v222)
							local v24 = nil
							if v23 then
								v24 = v23.Instance
								v15 = v23.Position
							else
								v15 = Position + v17.Unit * Magnitude
							end
							if (v15 - v16).Magnitude <= 1 or v24 and (v24 == v.Part or v.ValidRoot and v24:IsDescendantOf(v.ValidRoot)) then
								v21 = true
							end
						end
						if v21 then
							local Priority = v.Priority
							if Magnitude <= v1 or v22 < Priority then
								v1 = Magnitude
								v22 = Priority
								v32 = v
							end
						end
					end
				end
			end
			local Spec = t2.Spec
			if not Spec or (v32 == Spec or not Spec.Pressed) then
				if Spec and (Spec.HideFun and v32 ~= Spec) then
					Spec:HideFun()
				end
				t2.Spec = v32
				if v32 then
					if v32.ShowFun and v32 ~= Spec then
						v32:ShowFun()
					end
					if v32.Update then
						v32:Update()
					end
					return true
				end
			end
		end
	end
end
local function ProcessSpec() --[[ Line: 459 | Upvalues: t2 (ref), Release (copy), t (ref), afPulse_Start (ref), afPulse_End (ref), afPulse_Update (ref), v1 (copy) ]]
	local Spec = t2.Spec
	if Spec and Spec.Pressed then
		local sum = os.clock() - Spec.PressedAt
		if Spec.GetAccumulation then
			sum = sum + Spec.GetAccumulation()
		end
		local v12 = sum / Spec.Duration
		if v12 >= 1 then
			v12 = 1
		end
		if Spec.WhilePressedUpdate then
			Spec.WhilePressedUpdate(v12)
		end
		if Spec.ForceRelease then
			Spec.ForceRelease = false
			Release()
		elseif v12 == 1 then
			Spec.Pressed = false
			Spec.PressedAt = nil
			local v2 = Spec:Callback(true)
			if Spec.ReleaseCallback then
				Spec:ReleaseCallback(true)
			end
			if v2 then
				local v3 = t.MakeSpec()
				v3.Duration = 0.5
				v3.Start = afPulse_Start
				v3.End = afPulse_End
				v3.Update = afPulse_Update
				t.Push(v1, v3)
				return
			end
			local v4 = t.MakeSpec()
			v4.Duration = 0.3
			v4.Start = afPulse_Start
			v4.End = afPulse_End
			v4.Update = afPulse_Update
			v4.Red = true
			t.Push(v1, v4)
		end
	end
end
local function UpdatePlatform() --[[ Line: 504 | Upvalues: t2 (ref), UserInputService (copy), InputUtils (copy) ]]
	local Frame = t2.Frame
	local v1 = UserInputService:GetLastInputType()
	local v2
	if InputUtils.isTouch() then
		v2 = nil
	elseif v1 == Enum.UserInputType.Gamepad1 then
		local v3 = UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonY)
		v2 = if v3 == "ButtonTriangle" then "\226\150\179" elseif v3 == "ButtonY" then "Y" else v3
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
local v7 = nil
function t2.UpdateLogic(p1) --[[ Line: 530 | Upvalues: UpdateUI (copy), t2 (ref), Release (copy), UpdatePlatform (copy), ProcessSpec (copy), v7 (ref) ]]
	if not UpdateUI() and t2.Spec then
		if t2.Spec.HideFun then
			t2.Spec:HideFun()
		end
		Release()
	end
	UpdatePlatform()
	ProcessSpec()
	if t2.Spec ~= v7 then
		t2.onVisibilityChanged:Fire(t2.Spec ~= nil)
	end
	v7 = t2.Spec
end
function t2.UpdateVisual(p1) --[[ Line: 551 | Upvalues: t2 (ref), t (ref), v1 (copy), v2 (copy), CurrentCamera (copy) ]]
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
		local v12, v22 = CurrentCamera:WorldToScreenPoint(WorldPosition)
		Frame.Visible = v22
		if v22 then
			Spec.ScreenPosition = Vector3.new(v12.X, v12.Y, 0)
			Frame.Position = UDim2.new(0, v12.X, 0, v12.Y) - UDim2.new(0, Frame.AbsoluteSize.X * 0.5, 0, Frame.AbsoluteSize.Y * 0.5)
			Frame.Help.Text = Spec.Name or ""
			Frame.Help.Visible = Spec.Name and true or false
		end
	else
		Frame.Visible = false
	end
	t.Update(v1, p1)
end
local v8 = false
local function TouchStarted(p1) --[[ Line: 577 | Upvalues: t2 (ref), v8 (ref), Press (copy) ]]
	local Spec = t2.Spec
	if Spec then
		local ScreenPosition = Spec.ScreenPosition
		if ScreenPosition and (p1.Position - ScreenPosition).Magnitude < t2.Frame.AbsoluteSize.X * 0.5 then
			v8 = true
			Press()
			return true
		else
			return false
		end
	end
end
local function TouchEnded(p1) --[[ Line: 594 | Upvalues: v8 (ref), Release (copy) ]]
	if v8 then
		v8 = false
		Release()
	end
end
local v9 = nil
local function InputBegan(p1, p2) --[[ Line: 602 | Upvalues: t2 (ref), v8 (ref), Press (copy), v9 (ref) ]]
	if not p2 and p1.UserInputType == Enum.UserInputType.MouseButton1 then
		local Spec = t2.Spec
		local v1
		if Spec then
			local ScreenPosition = Spec.ScreenPosition
			if ScreenPosition and (p1.Position - ScreenPosition).Magnitude < t2.Frame.AbsoluteSize.X * 0.5 then
				v8 = true
				Press()
				v1 = true
			else
				v1 = false
			end
		else
			v1 = nil
		end
		if v1 then
			v9 = Enum.UserInputType.MouseButton1
		end
	end
end
local function InputEnded(p1, p2) --[[ Line: 613 | Upvalues: v9 (ref), v8 (ref), Release (copy) ]]
	if not p2 and (p1.UserInputType == Enum.UserInputType.MouseButton1 and v9 == Enum.UserInputType.MouseButton1 and v8) then
		v8 = false
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