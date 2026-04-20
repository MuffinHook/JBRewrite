local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local ScrollingFrame_upvr = require(ReplicatedStorage.Module.ScrollingFrame)
function module_upvr.new(arg1, arg2, arg3, arg4) -- Line 18
    local setmetatable_result1_upvr = setmetatable({}, module_upvr)
    setmetatable_result1_upvr.Alpha = 0
    setmetatable_result1_upvr.Maid = Maid_upvr.new()
    setmetatable_result1_upvr.ListItem = arg1
    setmetatable_result1_upvr.ViewportUpdate = arg4
    setmetatable_result1_upvr.OnMouseEnter = Signal_upvr.new()
    setmetatable_result1_upvr.Maid:GiveTask(setmetatable_result1_upvr.OnMouseEnter)
    setmetatable_result1_upvr.OnMouseLeave = Signal_upvr.new()
    setmetatable_result1_upvr.Maid:GiveTask(setmetatable_result1_upvr.OnMouseLeave)
    setmetatable_result1_upvr.OnMouseClick = Signal_upvr.new()
    setmetatable_result1_upvr.Maid:GiveTask(setmetatable_result1_upvr.OnMouseClick)
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Size = UDim2.new(0.6, 0, 1, 0)
    ImageLabel.LayoutOrder = 1
    ImageLabel.Image = "rbxassetid://5925879669"
    ImageLabel.ScaleType = Enum.ScaleType.Slice
    ImageLabel.SliceCenter = Rect.new(30, 30, 100, 100)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
    setmetatable_result1_upvr.Container = ImageLabel
    local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint_2.AspectRatio = 3.825
    UIAspectRatioConstraint_2.AspectType = Enum.AspectType.ScaleWithParentSize
    UIAspectRatioConstraint_2.DominantAxis = Enum.DominantAxis.Width
    UIAspectRatioConstraint_2.Parent = ImageLabel
    local Frame_3 = Instance.new("Frame")
    Frame_3.BackgroundTransparency = 1
    Frame_3.Size = UDim2.new(1, 0, 0.85, 0)
    Frame_3.Active = true
    Frame_3.ClipsDescendants = true
    Frame_3.Parent = ImageLabel
    local Frame_2 = Instance.new("Frame")
    Frame_2.BackgroundTransparency = 1
    Frame_2.Size = UDim2.new(1, 0, 0.15, 0)
    Frame_2.Position = UDim2.new(0, 0, 0.85, 0)
    Frame_2.ClipsDescendants = false
    Frame_2.Parent = ImageLabel
    setmetatable_result1_upvr._containerBottom = Frame_2
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.BackgroundTransparency = 1
    Frame.Parent = Frame_3
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.Parent = Frame
    setmetatable_result1_upvr.UIListLayout = UIListLayout
    local any_new_result1 = ScrollingFrame_upvr.new(Frame, true)
    setmetatable_result1_upvr.mScrollingFrame = any_new_result1
    local tbl = {}
    for i = 1, #arg1 do
        local var17_upvr = arg1[i]
        local Frame_4 = Instance.new("Frame")
        Frame_4.LayoutOrder = i
        Frame_4.Size = UDim2.new(1, 0, 1, 0)
        Frame_4.BackgroundTransparency = 1
        Frame_4.Parent = Frame
        local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
        UIAspectRatioConstraint.AspectRatio = 0.75
        UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
        UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width
        UIAspectRatioConstraint.Parent = Frame_4
        local ImageLabel_2 = Instance.new("ImageLabel")
        ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
        ImageLabel_2.Size = UDim2.new(setmetatable_result1_upvr.Alpha, 0, setmetatable_result1_upvr.Alpha)
        ImageLabel_2.Position = UDim2.new(0.5, 0, 0.5, 0)
        ImageLabel_2.BackgroundTransparency = 1
        ImageLabel_2.Image = "rbxassetid://5834299976"
        ImageLabel_2.Selectable = true
        ImageLabel_2.Parent = Frame_4
        local ViewportFrame = Instance.new("ViewportFrame")
        ViewportFrame.LightDirection = Vector3.new(1, -1, 1)
        ViewportFrame.LightColor = Color3.new(1, 1, 1)
        ViewportFrame.Ambient = Color3.new(1, 1, 1)
        ViewportFrame.BackgroundTransparency = 1
        ViewportFrame.BorderSizePixel = 0
        ViewportFrame.Position = UDim2.new(0.05, 0, 0.037500000000000006, 0)
        ViewportFrame.Size = UDim2.new(0.9, 0, 0.925, 0)
        ViewportFrame.Parent = ImageLabel_2
        local Camera = Instance.new("Camera")
        Camera.Parent = ViewportFrame
        ViewportFrame.CurrentCamera = Camera
        local arg3_result1 = arg3(var17_upvr)
        assert(arg3_result1)
        arg3_result1.Parent = ViewportFrame
        local tbl_2_upvr = {
            Frame = ImageLabel_2;
            Inst = arg3_result1;
            Camera = Camera;
        }
        arg2(var17_upvr, tbl_2_upvr)
        table.insert(tbl, tbl_2_upvr)
        arg4(Camera, arg3_result1)
        setmetatable_result1_upvr.Maid:GiveTask(Frame_4.MouseEnter:Connect(function() -- Line 157, Named "OnMouseEnter"
            setmetatable_result1_upvr.OnMouseEnter:Fire(var17_upvr, tbl_2_upvr)
        end))
        setmetatable_result1_upvr.Maid:GiveTask(Frame_4.MouseLeave:Connect(function() -- Line 161, Named "OnMouseLeave"
            setmetatable_result1_upvr.OnMouseLeave:Fire(var17_upvr, tbl_2_upvr)
        end))
        setmetatable_result1_upvr.Maid:GiveTask(any_new_result1:BindInput(Frame_4, {
            OnClick = function() -- Line 166, Named "OnMouseClick"
                setmetatable_result1_upvr.OnMouseClick:Fire(var17_upvr, tbl_2_upvr)
            end;
        }))
    end
    setmetatable_result1_upvr.Viewports = tbl
    return setmetatable_result1_upvr
end
local function _(arg1) -- Line 175, Named "Ease_OutQuad"
    return -(arg1 - 2) * arg1
end
function module_upvr.GetContainerBottom(arg1) -- Line 178
    return arg1._containerBottom
end
function module_upvr.SetParent(arg1, arg2) -- Line 182
    arg1.Container.Parent = arg2
    arg1.UIListLayout.Parent.Size = UDim2.new(0, arg1.UIListLayout.AbsoluteContentSize.X, 1, 0)
end
function module_upvr.AddBackButton(arg1) -- Line 187
    local ImageButton = Instance.new("ImageButton")
    ImageButton.BackgroundTransparency = 1
    ImageButton.Image = "rbxassetid://4933143781"
    ImageButton.Size = UDim2.new(0, 20, 0, 20)
    ImageButton.Position = UDim2.new(0, -6, 0, -6)
    ImageButton.Parent = arg1.Container
    arg1.OnMouseClickBack = ImageButton.MouseButton1Down
end
function module_upvr.Update(arg1) -- Line 197
    local tick_result1 = tick()
    arg1.LastUpdate = tick_result1
    local Viewports_2 = arg1.Viewports
    if arg1.Alpha < 1 then
        arg1.Alpha += (tick_result1 - (arg1.LastUpdate or tick_result1)) * ((1) / (#Viewports_2 * 0.1))
    else
        arg1.Alpha = 1
    end
    local var31 = 1 / #Viewports_2
    local X_2 = arg1.Container.AbsolutePosition.X
    for i_2 = 1, #Viewports_2 do
        local var33 = Viewports_2[i_2]
        local var34 = arg1.Alpha - (i_2 - 1) / (#Viewports_2 * (var31 + 1))
        local var35
        local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var35 = math.min(var34 / var31, 1)
            return var35
        end
        if 0 >= var34 or not decompInlinedCondition() then
            var35 = 0
        end
        var33.Frame.Size = UDim2.new(0.9 * var35, 0, 0.9 * var35, 0)
        local X = var33.Frame.AbsolutePosition.X
        if X_2 < X + var33.Frame.AbsoluteSize.X and X < X_2 + arg1.Container.AbsoluteSize.X then
            arg1.ViewportUpdate(var33.Camera, var33.Inst)
        end
    end
end
function module_upvr.Destroy(arg1) -- Line 228
    local Viewports = arg1.Viewports
    for i_3 = 1, #Viewports do
        Viewports[i_3].Frame:Destroy()
    end
    arg1.mScrollingFrame:Destroy()
    arg1.Container:Destroy()
    arg1.Maid:Destroy()
    arg1.Maid = nil
end
return module_upvr