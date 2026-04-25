-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local Maid = require(ReplicatedStorage.Std.Maid)
local ScrollingFrame = require(ReplicatedStorage.Module.ScrollingFrame)
local CurrentCamera = workspace.CurrentCamera
local ViewportSlider = {}
ViewportSlider.__index = ViewportSlider
function ViewportSlider.new(listItem, onViewportSetup, createModel, onViewportUpdate)
	local self = setmetatable({}, ViewportSlider)
	self.Alpha = 0
	self.Maid = Maid.new()
	self.ListItem = listItem
	self.ViewportUpdate = onViewportUpdate
	self.OnMouseEnter = Signal.new()
	self.Maid:GiveTask(self.OnMouseEnter)
	self.OnMouseLeave = Signal.new()
	self.Maid:GiveTask(self.OnMouseLeave)
	self.OnMouseClick = Signal.new()
	self.Maid:GiveTask(self.OnMouseClick)
	local ImageLabel = Instance.new("ImageLabel")
	ImageLabel.Size = UDim2.new(0.6, 0, 1, 0)
	ImageLabel.LayoutOrder = 1
	ImageLabel.Image = "rbxassetid://5925879669"
	ImageLabel.ScaleType = Enum.ScaleType.Slice
	ImageLabel.SliceCenter = Rect.new(30, 30, 100, 100)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.BackgroundColor3 = Color3.new(255/255, 255/255, 255/255)
	self.Container = ImageLabel
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
	self._containerBottom = Frame_2
	local Frame_3 = Instance.new("Frame")
	Frame_3.Size = UDim2.new(1, 0, 1, 0)
	Frame_3.BackgroundTransparency = 1
	Frame_3.Parent = Frame
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.Parent = Frame_3
	self.UIListLayout = UIListLayout
	local scrollingFrame = ScrollingFrame.new(Frame_3, true)
	self.mScrollingFrame = scrollingFrame
	local viewports = {}
	for i = 1, #listItem do
		local item = listItem[i]
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
		ImageLabel_2.Size = UDim2.new(self.Alpha, 0, self.Alpha)
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
		local instance = createModel(item)
		assert(instance)
		instance.Parent = ViewportFrame
		local viewportData = {
			Frame = ImageLabel_2,
			Inst = instance,
			Camera = Camera
		}
		onViewportSetup(item, viewportData)
		table.insert(viewports, viewportData)
		onViewportUpdate(Camera, instance)
		local function OnMouseEnter()
			self.OnMouseEnter:Fire(item, viewportData)
		end
		self.Maid:GiveTask(Frame_4.MouseEnter:Connect(OnMouseEnter))
		local function OnMouseLeave()
			self.OnMouseLeave:Fire(item, viewportData)
		end
		self.Maid:GiveTask(Frame_4.MouseLeave:Connect(OnMouseLeave))
		local function OnMouseClick()
			self.OnMouseClick:Fire(item, viewportData)
		end
		self.Maid:GiveTask(scrollingFrame:BindInput(Frame_4, {
			OnClick = OnMouseClick
		}))
	end
	self.Viewports = viewports
	return self
end
local function Ease_OutQuad(p1)
	return -(p1 - 2) * p1
end
function ViewportSlider.GetContainerBottom(self)
	return self._containerBottom
end
function ViewportSlider.SetParent(self, parent)
	self.Container.Parent = parent
	self.UIListLayout.Parent.Size = UDim2.new(0, self.UIListLayout.AbsoluteContentSize.X, 1, 0)
end
function ViewportSlider.AddBackButton(self)
	local ImageButton = Instance.new("ImageButton")
	ImageButton.BackgroundTransparency = 1
	ImageButton.Image = "rbxassetid://4933143781"
	ImageButton.Size = UDim2.new(0, 20, 0, 20)
	ImageButton.Position = UDim2.new(0, -6, 0, -6)
	ImageButton.Parent = self.Container
	self.OnMouseClickBack = ImageButton.MouseButton1Down
end
function ViewportSlider.Update(self)
	local currentTime = tick()
	local deltaTime = currentTime - (self.LastUpdate or currentTime)
	self.LastUpdate = currentTime
	local Viewports = self.Viewports
	if self.Alpha < 1 then
		self.Alpha = self.Alpha + deltaTime * (1 / (#Viewports * 0.1))
	else
		self.Alpha = 1
	end
	local X = self.Container.AbsolutePosition.X
	local containerRight = X + self.Container.AbsoluteSize.X
	local itemAlphaStep = 1 / #Viewports
	for i = 1, #Viewports do
		local itemAlpha
		local viewport = Viewports[i]
		local offsetAlpha = self.Alpha - (i - 1) / (#Viewports * (itemAlphaStep + 1))
		itemAlpha = offsetAlpha > 0 and math.min(offsetAlpha / itemAlphaStep, 1) or 0
		viewport.Frame.Size = UDim2.new(0.9 * itemAlpha, 0, 0.9 * itemAlpha, 0)
		local frameX = viewport.Frame.AbsolutePosition.X
		if X < frameX + viewport.Frame.AbsoluteSize.X and frameX < containerRight then
			self.ViewportUpdate(viewport.Camera, viewport.Inst)
		end
	end
end
function ViewportSlider.Destroy(self)
	local Viewports = self.Viewports
	for i = 1, #Viewports do
		Viewports[i].Frame:Destroy()
	end
	self.mScrollingFrame:Destroy()
	self.Container:Destroy()
	self.Maid:Destroy()
	self.Maid = nil
end
return ViewportSlider
