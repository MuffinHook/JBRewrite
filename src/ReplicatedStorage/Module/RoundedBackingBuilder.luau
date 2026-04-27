local RoundedBackingBuilder = {}
RoundedBackingBuilder.__index = RoundedBackingBuilder
RoundedBackingBuilder.ClassName = "RoundedBackingBuilder"
function RoundedBackingBuilder.new()
	return setmetatable({}, RoundedBackingBuilder)
end
function RoundedBackingBuilder.CreateBacking(self, parentFrame)
	local Backing = Instance.new("ImageLabel")
	Backing.Name = "Backing"
	Backing.Size = UDim2.new(1, 0, 1, 0)
	Backing.Image = "rbxassetid://735637144"
	Backing.SliceCenter = Rect.new(4, 4, 16, 16)
	Backing.ImageColor3 = parentFrame.BackgroundColor3
	Backing.ScaleType = Enum.ScaleType.Slice
	Backing.BackgroundTransparency = 1
	Backing.ZIndex = parentFrame.ZIndex - 1
	Backing.Parent = parentFrame
	parentFrame.BackgroundTransparency = 1
	return Backing
end
function RoundedBackingBuilder.CreateTopBacking(self, parentFrame)
	local backingImage = self:CreateBacking(parentFrame)
	backingImage.ImageRectSize = Vector2.new(20, 16)
	backingImage.SliceCenter = Rect.new(4, 4, 16, 16)
	return backingImage
end
function RoundedBackingBuilder.CreateShadow(self, parentFrame)
	local Shadow = Instance.new("ImageLabel")
	Shadow.Name = "Shadow"
	Shadow.Size = UDim2.new(1, 6, 1, 6)
	Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow.Position = UDim2.new(0.5, 0, 0.5, 1)
	Shadow.Image = "rbxassetid://735644155"
	Shadow.SliceCenter = Rect.new(16, 16, 64, 64)
	Shadow.ImageColor3 = Color3.new(0/255, 0/255, 0/255)
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.BackgroundTransparency = 1
	Shadow.ImageTransparency = 0.7
	Shadow.ZIndex = parentFrame.ZIndex - 1
	Shadow.Parent = parentFrame.Parent
	return Shadow
end
function RoundedBackingBuilder.Create(self, parentFrame)
	local backingImage = self:CreateBacking(parentFrame)
	self:CreateShadow(backingImage)
	return backingImage
end
return RoundedBackingBuilder
