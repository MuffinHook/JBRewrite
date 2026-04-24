-- Reviewed by Claude
local t = {}
t.__index = t
t.ClassName = "RoundedBackingBuilder"
function t.new()
	return setmetatable({}, t)
end
function t.CreateBacking(p1, p2)
	local Backing = Instance.new("ImageLabel")
	Backing.Name = "Backing"
	Backing.Size = UDim2.new(1, 0, 1, 0)
	Backing.Image = "rbxassetid://735637144"
	Backing.SliceCenter = Rect.new(4, 4, 16, 16)
	Backing.ImageColor3 = p2.BackgroundColor3
	Backing.ScaleType = Enum.ScaleType.Slice
	Backing.BackgroundTransparency = 1
	Backing.ZIndex = p2.ZIndex - 1
	Backing.Parent = p2
	p2.BackgroundTransparency = 1
	return Backing
end
function t.CreateTopBacking(p1, p2)
	local v1 = p1:CreateBacking(p2)
	v1.ImageRectSize = Vector2.new(20, 16)
	v1.SliceCenter = Rect.new(4, 4, 16, 16)
	return v1
end
function t.CreateShadow(p1, p2)
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
	Shadow.ZIndex = p2.ZIndex - 1
	Shadow.Parent = p2.Parent
	return Shadow
end
function t.Create(p1, p2)
	local v1 = p1:CreateBacking(p2)
	p1:CreateShadow(v1)
	return v1
end
return t
