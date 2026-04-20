local module_upvr = {}
module_upvr.__index = module_upvr
module_upvr.ClassName = "RoundedBackingBuilder"
function module_upvr.new() -- Line 8
    return setmetatable({}, module_upvr)
end
function module_upvr.CreateBacking(arg1, arg2) -- Line 14
    local ImageLabel_2 = Instance.new("ImageLabel")
    ImageLabel_2.Name = "Backing"
    ImageLabel_2.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel_2.Image = "rbxassetid://735637144"
    ImageLabel_2.SliceCenter = Rect.new(4, 4, 16, 16)
    ImageLabel_2.ImageColor3 = arg2.BackgroundColor3
    ImageLabel_2.ScaleType = Enum.ScaleType.Slice
    ImageLabel_2.BackgroundTransparency = 1
    ImageLabel_2.ZIndex = arg2.ZIndex - 1
    ImageLabel_2.Parent = arg2
    arg2.BackgroundTransparency = 1
    return ImageLabel_2
end
function module_upvr.CreateTopBacking(arg1, arg2) -- Line 32
    local any_CreateBacking_result1 = arg1:CreateBacking(arg2)
    any_CreateBacking_result1.ImageRectSize = Vector2.new(20, 16)
    any_CreateBacking_result1.SliceCenter = Rect.new(4, 4, 16, 16)
    return any_CreateBacking_result1
end
function module_upvr.CreateShadow(arg1, arg2) -- Line 42
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "Shadow"
    ImageLabel.Size = UDim2.new(1, 6, 1, 6)
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 1)
    ImageLabel.Image = "rbxassetid://735644155"
    ImageLabel.SliceCenter = Rect.new(16, 16, 64, 64)
    ImageLabel.ImageColor3 = Color3.new(0, 0, 0)
    ImageLabel.ScaleType = Enum.ScaleType.Slice
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.ImageTransparency = 0.7
    ImageLabel.ZIndex = arg2.ZIndex - 1
    ImageLabel.Parent = arg2.Parent
    return ImageLabel
end
function module_upvr.Create(arg1, arg2) -- Line 61
    return arg1:CreateBacking(arg2)
end
return module_upvr