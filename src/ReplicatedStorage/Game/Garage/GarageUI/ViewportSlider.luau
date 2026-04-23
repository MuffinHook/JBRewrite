local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local Maid = require(ReplicatedStorage.Std.Maid)
local ScrollingFrame = require(ReplicatedStorage.Module.ScrollingFrame)
local CurrentCamera = workspace.CurrentCamera
local t = {}
t.__index = t
function t.new(p1, p2, p3, p4) --[[ Line: 18 | Upvalues: t (copy), Maid (copy), Signal (copy), ScrollingFrame (copy) ]]
	local v2 = setmetatable({}, t)
	v2.Alpha = 0
	v2.Maid = Maid.new()
	v2.ListItem = p1
	v2.ViewportUpdate = p4
	v2.OnMouseEnter = Signal.new()
	v2.Maid:GiveTask(v2.OnMouseEnter)
	v2.OnMouseLeave = Signal.new()
	v2.Maid:GiveTask(v2.OnMouseLeave)
	v2.OnMouseClick = Signal.new()
	v2.Maid:GiveTask(v2.OnMouseClick)
	local ImageLabel = Instance.new("ImageLabel")
	ImageLabel.Size = UDim2.new(0.6, 0, 1, 0)
	ImageLabel.LayoutOrder = 1
	ImageLabel.Image = "rbxassetid://5925879669"
	ImageLabel.ScaleType = Enum.ScaleType.Slice
	ImageLabel.SliceCenter = Rect.new(30, 30, 100, 100)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.BackgroundColor3 = Color3.new(255/255, 255/255, 255/255)
	v2.Container = ImageLabel
	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint.AspectRatio = 3.825
	UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
	UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width
	UIAspectRatioConstraint.Parent = ImageLabel
	local Frame = Instance.new("Frame")
	Frame.BackgroundTransparency = 1
	Frame.Size = UDim2.new(1, 0, 0.85, 0)
	Frame.Active = true
	Frame.ClipsDescendants = true
	Frame.Parent = ImageLabel
	local Frame_2 = Instance.new("Frame")
	Frame_2.BackgroundTransparency = 1
	Frame_2.Size = UDim2.new(1, 0, 0.15, 0)
	Frame_2.Position = UDim2.new(0, 0, 0.85, 0)
	Frame_2.ClipsDescendants = false
	Frame_2.Parent = ImageLabel
	v2._containerBottom = Frame_2
	local Frame_3 = Instance.new("Frame")
	Frame_3.Size = UDim2.new(1, 0, 1, 0)
	Frame_3.BackgroundTransparency = 1
	Frame_3.Parent = Frame
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.Parent = Frame_3
	v2.UIListLayout = UIListLayout
	local v3 = ScrollingFrame.new(Frame_3, true)
	v2.mScrollingFrame = v3
	local t2 = {}
	for i = 1, #p1 do
		local v4 = p1[i]
		local Frame_4 = Instance.new("Frame")
		Frame_4.LayoutOrder = i
		Frame_4.Size = UDim2.new(1, 0, 1, 0)
		Frame_4.BackgroundTransparency = 1
		Frame_4.Parent = Frame_3
		local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
		UIAspectRatioConstraint_2.AspectRatio = 0.75
		UIAspectRatioConstraint_2.AspectType = Enum.AspectType.ScaleWithParentSize
		UIAspectRatioConstraint_2.DominantAxis = Enum.DominantAxis.Width
		UIAspectRatioConstraint_2.Parent = Frame_4
		local ImageLabel_2 = Instance.new("ImageLabel")
		ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel_2.Size = UDim2.new(v2.Alpha, 0, v2.Alpha)
		ImageLabel_2.Position = UDim2.new(0.5, 0, 0.5, 0)
		ImageLabel_2.BackgroundTransparency = 1
		ImageLabel_2.Image = "rbxassetid://5834299976"
		ImageLabel_2.Selectable = true
		ImageLabel_2.Parent = Frame_4
		local ViewportFrame = Instance.new("ViewportFrame")
		ViewportFrame.LightDirection = Vector3.new(1, -1, 1)
		ViewportFrame.LightColor = Color3.new(255/255, 255/255, 255/255)
		ViewportFrame.Ambient = Color3.new(255/255, 255/255, 255/255)
		ViewportFrame.BackgroundTransparency = 1
		ViewportFrame.BorderSizePixel = 0
		ViewportFrame.Position = UDim2.new(0.05, 0, 0.037500000000000006, 0)
		ViewportFrame.Size = UDim2.new(0.9, 0, 0.925, 0)
		ViewportFrame.Parent = ImageLabel_2
		local Camera = Instance.new("Camera")
		Camera.Parent = ViewportFrame
		ViewportFrame.CurrentCamera = Camera
		local v5 = p3(v4)
		assert(v5)
		v5.Parent = ViewportFrame
		local t3 = {
			Frame = ImageLabel_2,
			Inst = v5,
			Camera = Camera
		}
		p2(v4, t3)
		table.insert(t2, t3)
		p4(Camera, v5)
		local function OnMouseEnter() --[[ Line: 157 | Upvalues: v2 (copy), v4 (copy), t3 (copy) ]]
			v2.OnMouseEnter:Fire(v4, t3)
		end
		v2.Maid:GiveTask(Frame_4.MouseEnter:Connect(OnMouseEnter))
		local function OnMouseLeave() --[[ Line: 161 | Upvalues: v2 (copy), v4 (copy), t3 (copy) ]]
			v2.OnMouseLeave:Fire(v4, t3)
		end
		v2.Maid:GiveTask(Frame_4.MouseLeave:Connect(OnMouseLeave))
		local function OnMouseClick() --[[ Line: 166 | Upvalues: v2 (copy), v4 (copy), t3 (copy) ]]
			v2.OnMouseClick:Fire(v4, t3)
		end
		v2.Maid:GiveTask(v3:BindInput(Frame_4, {
			OnClick = OnMouseClick
		}))
	end
	v2.Viewports = t2
	return v2
end
local function Ease_OutQuad(p1) --[[ Line: 175 ]]
	return -(p1 - 2) * p1
end
function t.GetContainerBottom(p1) --[[ Line: 178 ]]
	return p1._containerBottom
end
function t.SetParent(p1, p2) --[[ Line: 182 ]]
	p1.Container.Parent = p2
	p1.UIListLayout.Parent.Size = UDim2.new(0, p1.UIListLayout.AbsoluteContentSize.X, 1, 0)
end
function t.AddBackButton(p1) --[[ Line: 187 ]]
	local ImageButton = Instance.new("ImageButton")
	ImageButton.BackgroundTransparency = 1
	ImageButton.Image = "rbxassetid://4933143781"
	ImageButton.Size = UDim2.new(0, 20, 0, 20)
	ImageButton.Position = UDim2.new(0, -6, 0, -6)
	ImageButton.Parent = p1.Container
	p1.OnMouseClickBack = ImageButton.MouseButton1Down
end
function t.Update(p1) --[[ Line: 197 ]]
	local v1 = tick()
	local v2 = v1 - (p1.LastUpdate or v1)
	p1.LastUpdate = v1
	local Viewports = p1.Viewports
	if p1.Alpha < 1 then
		p1.Alpha = p1.Alpha + v2 * (1 / (#Viewports * 0.1))
	else
		p1.Alpha = 1
	end
	local X = p1.Container.AbsolutePosition.X
	local v3 = X + p1.Container.AbsoluteSize.X
	local v4 = 1 / #Viewports
	for i = 1, #Viewports do
		local v5
		local v6 = Viewports[i]
		local v7 = p1.Alpha - (i - 1) / (#Viewports * (v4 + 1))
		v5 = v7 > 0 and math.min(v7 / v4, 1) or 0
		v6.Frame.Size = UDim2.new(0.9 * v5, 0, 0.9 * v5, 0)
		local X_2 = v6.Frame.AbsolutePosition.X
		if X < X_2 + v6.Frame.AbsoluteSize.X and X_2 < v3 then
			p1.ViewportUpdate(v6.Camera, v6.Inst)
		end
	end
end
function t.Destroy(p1) --[[ Line: 228 ]]
	local Viewports = p1.Viewports
	for i = 1, #Viewports do
		Viewports[i].Frame:Destroy()
	end
	p1.mScrollingFrame:Destroy()
	p1.Container:Destroy()
	p1.Maid:Destroy()
	p1.Maid = nil
end
return t