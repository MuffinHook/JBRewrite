local UserInputService_upvr = game:GetService("UserInputService")
local MakeMaid_upvr = require(script.ScrollingFrameMaid).MakeMaid
local tbl_upvr = {
    ClassName = "Scroller";
}
tbl_upvr.__index = tbl_upvr
tbl_upvr._Position = 0
tbl_upvr._Min = 0
tbl_upvr._Max = 100
tbl_upvr._ViewSize = 50
local SpringPhysics_upvr = require(script.SpringPhysics)
local function new() -- Line 25
    local setmetatable_result1_2 = setmetatable({}, tbl_upvr)
    setmetatable_result1_2.Spring = SpringPhysics_upvr.Spring.New(0)
    setmetatable_result1_2.Spring.Speed = 20
    return setmetatable_result1_2
end
tbl_upvr.new = new
function tbl_upvr.GetTimesOverBounds(arg1, arg2) -- Line 34
    return arg1:GetDisplacementPastBounds(arg2) / arg1.BackBounceInputRange
end
function tbl_upvr.GetDisplacementPastBounds(arg1, arg2) -- Line 38
    if arg1.ContentMax < arg2 then
        return arg2 - arg1.ContentMax
    end
    if arg2 < arg1.ContentMin then
        return arg2
    end
    return 0
end
function tbl_upvr.GetScale(arg1, arg2) -- Line 48
    return 1 - 0.5 ^ math.abs(arg2)
end
function tbl_upvr.__index(arg1, arg2) -- Line 52
    if arg2 == "TotalContentLength" then
        return arg1._Max - arg1._Min
    end
    if arg2 == "ViewSize" then
        return arg1._ViewSize
    end
    if arg2 == "Max" then
        return arg1._Max
    end
    if arg2 == "ContentMax" then
        if arg1._Max <= arg1.ContentMin + arg1._ViewSize then
            return arg1.ContentMin
        end
        return arg1._Max - arg1._ViewSize
    end
    if arg2 == "Min" or arg2 == "ContentMin" then
        return arg1._Min
    end
    if arg2 == "Position" then
        return arg1.Spring.Position
    end
    if arg2 == "BackBounceInputRange" then
        return arg1._ViewSize
    end
    if arg2 == "BackBounceRenderRange" then
        return arg1._ViewSize
    end
    if arg2 == "ContentScrollPercentSize" then
        if arg1.TotalContentLength == 0 then
            return 0
        end
        return arg1._ViewSize / arg1.TotalContentLength
    end
    if arg2 == "RenderedContentScrollPercentSize" then
        return arg1.ContentScrollPercentSize * (1 - arg1:GetScale(arg1:GetTimesOverBounds(arg1.Position)))
    end
    if arg2 == "ContentScrollPercent" then
        return (arg1.Position - arg1._Min) / (arg1.TotalContentLength - arg1._ViewSize)
    end
    if arg2 == "RenderedContentScrollPercent" then
        local ContentScrollPercent = arg1.ContentScrollPercent
        if ContentScrollPercent < 0 then
            return 0
        end
        if 1 < ContentScrollPercent then
            return 1
        end
        return ContentScrollPercent
    end
    if arg2 == "BoundedRenderPosition" then
        local Position_4 = arg1.Position
        local any_GetTimesOverBounds_result1 = arg1:GetTimesOverBounds(Position_4)
        local any_GetScale_result1 = arg1:GetScale(any_GetTimesOverBounds_result1)
        if 0 < any_GetTimesOverBounds_result1 then
            return -arg1.ContentMax - any_GetScale_result1 * arg1.BackBounceRenderRange
        end
        if any_GetTimesOverBounds_result1 < 0 then
            return arg1.ContentMin + any_GetScale_result1 * arg1.BackBounceRenderRange
        end
        return -Position_4
    end
    if arg2 == "Velocity" then
        return arg1.Spring.Velocity
    end
    if arg2 == "Target" then
        return arg1.Spring.Target
    end
    if arg2 == "AtRest" then
        local var10 = false
        if math.abs(arg1.Spring.Target - arg1.Spring.Position) < 0.00001 then
            if math.abs(arg1.Spring.Velocity) >= 0.00001 then
                var10 = false
            else
                var10 = true
            end
        end
        return var10
    end
    if tbl_upvr[arg2] then
        return tbl_upvr[arg2]
    end
    error("[Scroller] - '%s' is not a valid member":format(tostring(arg2)))
end
function tbl_upvr.__newindex(arg1, arg2, arg3) -- Line 117
    local var11
    if tbl_upvr[arg2] or arg2 == "Spring" then
        rawset(arg1, arg2, var11)
    else
        if arg2 == "Min" or arg2 == "ContentMin" then
            arg1._Min = var11
            return
        end
        if arg2 == "Max" then
            arg1._Max = var11
            arg1.Target = arg1.Target
            return
        end
        if arg2 == "TotalContentLength" then
            arg1.Max = arg1._Min + var11
            return
        end
        if arg2 == "ViewSize" then
            arg1._ViewSize = var11
            return
        end
        if arg2 == "Position" then
            arg1.Spring.Position = var11
            return
        end
        if arg2 == "TargetContentScrollPercent" then
            arg1.Target = arg1._Min + var11 * (arg1.TotalContentLength - arg1._ViewSize)
            return
        end
        if arg2 == "ContentScrollPercent" then
            arg1.Position = arg1._Min + var11 * (arg1.TotalContentLength - arg1._ViewSize)
            return
        end
        if arg2 == "Target" then
            if arg1.ContentMax < var11 then
                var11 = arg1.ContentMax
            elseif var11 < arg1.ContentMin then
                var11 = arg1.ContentMin
            end
            arg1.Spring.Target = var11
            return
        end
        if arg2 == "Velocity" then
            arg1.Spring.Velocity = var11
            return
        end
        error("[Scroller] - '%s' is not a valid member":format(tostring(arg2)))
    end
end
local tbl_upvr_2 = {
    ClassName = "Base";
}
tbl_upvr_2.__index = tbl_upvr_2
local function new(arg1) -- Line 153
    local setmetatable_result1 = setmetatable({}, tbl_upvr_2)
    setmetatable_result1.Maid = MakeMaid_upvr()
    local var14 = arg1
    if not var14 then
        var14 = error("No Gui")
    end
    setmetatable_result1.Gui = var14
    local Parent = setmetatable_result1.Gui.Parent
    if not Parent then
        Parent = error("No container")
    end
    setmetatable_result1.Container = Parent
    return setmetatable_result1
end
tbl_upvr_2.new = new
function tbl_upvr_2.Destroy(arg1) -- Line 163
    arg1.Maid:DoCleaning()
    arg1.Maid = nil
    setmetatable(arg1, nil)
end
local setmetatable_result1_4_upvr = setmetatable({}, tbl_upvr_2)
setmetatable_result1_4_upvr.ClassName = "Scrollbar"
setmetatable_result1_4_upvr.__index = setmetatable_result1_4_upvr
local Signal_upvr = require(script.Signal)
local function new(arg1, arg2) -- Line 174
    local setmetatable_result1_upvr = setmetatable(tbl_upvr_2.new(arg1), setmetatable_result1_4_upvr)
    local var19 = arg2
    if not var19 then
        var19 = error("No ScrollingFrame")
    end
    setmetatable_result1_upvr.ScrollingFrame = var19
    setmetatable_result1_upvr.ParentScroller = setmetatable_result1_upvr.ScrollingFrame:GetScroller()
    setmetatable_result1_upvr:UpdateRender()
    setmetatable_result1_upvr.DraggingBegan = Signal_upvr.new()
    setmetatable_result1_upvr.Maid.InputBeganGui = setmetatable_result1_upvr.Gui.InputBegan:connect(function(arg1_2) -- Line 183
        if arg1_2.UserInputType == Enum.UserInputType.MouseButton1 then
            setmetatable_result1_upvr:InputBegan(arg1_2)
        end
    end)
    setmetatable_result1_upvr.Maid.InputBeganContainer = setmetatable_result1_upvr.Container.InputBegan:connect(function(arg1_3) -- Line 189
        if arg1_3.UserInputType == Enum.UserInputType.MouseButton1 then
            setmetatable_result1_upvr.LastContainerInputObject = arg1_3
        end
    end)
    setmetatable_result1_upvr.Maid.InputEndedContainer = setmetatable_result1_upvr.Container.InputEnded:connect(function(arg1_4) -- Line 195
        if arg1_4 == setmetatable_result1_upvr.LastContainerInputObject then
            setmetatable_result1_upvr.ParentScroller.TargetContentScrollPercent = (arg1_4.Position.Y - setmetatable_result1_upvr.Container.AbsolutePosition.Y - setmetatable_result1_upvr.Container.AbsoluteSize.Y * setmetatable_result1_upvr.ParentScroller.ContentScrollPercentSize / 2) / (setmetatable_result1_upvr.Container.AbsoluteSize.Y * (1 - setmetatable_result1_upvr.ParentScroller.ContentScrollPercentSize))
            setmetatable_result1_upvr.ParentScroller.Velocity = 0
            setmetatable_result1_upvr.ScrollingFrame:FreeScroll()
        end
    end)
    return setmetatable_result1_upvr
end
setmetatable_result1_4_upvr.new = new
local function StopDrag(arg1) -- Line 211
    arg1.ScrollingFrame:StopDrag()
end
setmetatable_result1_4_upvr.StopDrag = StopDrag
local function InputBegan(arg1, arg2) -- Line 215
    local var2_result1 = MakeMaid_upvr()
    local Position_5_upvr = arg2.Position
    local ContentScrollPercent_upvr = arg1.ParentScroller.ContentScrollPercent
    local any_GetVelocityTracker_result1_upvr = arg1.ScrollingFrame:GetVelocityTracker(0.25)
    var2_result1.InputChanged = UserInputService_upvr.InputChanged:connect(function(arg1_5) -- Line 222
        if arg1_5.UserInputType == Enum.UserInputType.MouseMovement then
            arg1.ParentScroller.ContentScrollPercent = ContentScrollPercent_upvr + ((arg1_5.Position - Position_5_upvr).y) / (arg1.Container.AbsoluteSize.Y * (1 - arg1.ParentScroller.ContentScrollPercentSize))
            arg1.ParentScroller.TargetContentScrollPercent = arg1.ParentScroller.ContentScrollPercent
            arg1.ScrollingFrame:UpdateRender()
            any_GetVelocityTracker_result1_upvr()
        end
    end)
    var2_result1.InputEnded = UserInputService_upvr.InputEnded:connect(function(arg1_6) -- Line 235
        if arg1_6 == arg2 then
            arg1:StopDrag()
        end
    end)
    arg1.Maid.UpdateMaid = var2_result1
    arg1.ScrollingFrame.Maid.UpdateMaid = var2_result1
end
setmetatable_result1_4_upvr.InputBegan = InputBegan
local function UpdateRender(arg1) -- Line 245
    if arg1.ParentScroller.ViewSize < arg1.ParentScroller.TotalContentLength then
        local RenderedContentScrollPercentSize = arg1.ParentScroller.RenderedContentScrollPercentSize
        arg1.Gui.Size = UDim2.new(UDim.new(RenderedContentScrollPercentSize, 0), arg1.Gui.Size.Y)
        arg1.Gui.Position = UDim2.new(UDim.new((1 - RenderedContentScrollPercentSize) * arg1.ParentScroller.RenderedContentScrollPercent, 0), arg1.Gui.Position.Y)
        arg1.Gui.Visible = true
    else
        arg1.Gui.Visible = false
    end
end
setmetatable_result1_4_upvr.UpdateRender = UpdateRender
local setmetatable_result1_3_upvr = setmetatable({}, tbl_upvr_2)
setmetatable_result1_3_upvr.ClassName = "ScrollingFrame"
setmetatable_result1_3_upvr.__index = setmetatable_result1_3_upvr
function setmetatable_result1_3_upvr.new(arg1, arg2) -- Line 265
    local setmetatable_result1_upvr_2 = setmetatable(tbl_upvr_2.new(arg1), setmetatable_result1_3_upvr)
    setmetatable_result1_upvr_2.Scrollbars = {}
    setmetatable_result1_upvr_2.Scroller = tbl_upvr.new()
    setmetatable_result1_upvr_2.Horizontal = arg2
    setmetatable_result1_upvr_2.Maid:GiveTask(setmetatable_result1_upvr_2:BindInput(setmetatable_result1_upvr_2.Container))
    setmetatable_result1_upvr_2.Maid.ContainerChanged = setmetatable_result1_upvr_2.Container.Changed:connect(function(arg1_7) -- Line 275
        if arg1_7 == "AbsoluteSize" then
            setmetatable_result1_upvr_2:UpdateScroller()
            setmetatable_result1_upvr_2:FreeScroll()
        end
    end)
    setmetatable_result1_upvr_2.Maid.GuiChanged = setmetatable_result1_upvr_2.Gui.Changed:connect(function(arg1_8) -- Line 282
        if arg1_8 == "AbsoluteSize" then
            setmetatable_result1_upvr_2:UpdateScroller()
            setmetatable_result1_upvr_2:FreeScroll()
        end
    end)
    setmetatable_result1_upvr_2:UpdateScroller()
    setmetatable_result1_upvr_2:UpdateRender()
    return setmetatable_result1_upvr_2
end
function setmetatable_result1_3_upvr.GetScroller(arg1) -- Line 296
    return arg1.Scroller
end
function setmetatable_result1_3_upvr.AddScrollbar(arg1, arg2) -- Line 300
    local any_new_result1 = setmetatable_result1_4_upvr.new(arg2, arg1)
    table.insert(arg1.Scrollbars, any_new_result1)
    arg1.Maid[arg2] = any_new_result1
end
function setmetatable_result1_3_upvr.AddScrollbarFromContainer(arg1, arg2) -- Line 307
    local ImageButton = Instance.new("ImageButton")
    ImageButton.Size = UDim2.new(1, 0, 0, 100)
    ImageButton.Name = "ScrollBar"
    ImageButton.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)
    ImageButton.BorderSizePixel = 0
    ImageButton.Image = ""
    ImageButton.Parent = arg2
    ImageButton.AutoButtonColor = false
    ImageButton.ZIndex = arg2.ZIndex
    ImageButton.Parent = arg2
    return arg1:AddScrollbar(ImageButton)
end
function setmetatable_result1_3_upvr.UpdateScroller(arg1) -- Line 322
    if arg1.Horizontal then
        arg1.Scroller.TotalContentLength = arg1.Gui.AbsoluteSize.x
        arg1.Scroller.ViewSize = arg1.Container.AbsoluteSize.x
    else
        arg1.Scroller.TotalContentLength = arg1.Gui.AbsoluteSize.y
        arg1.Scroller.ViewSize = arg1.Container.AbsoluteSize.y
    end
end
function setmetatable_result1_3_upvr.UpdateRender(arg1) -- Line 332
    if arg1.Horizontal then
        arg1.Gui.Position = UDim2.new(UDim.new(0, arg1.Scroller.BoundedRenderPosition), arg1.Gui.Position.Y)
    else
        arg1.Gui.Position = UDim2.new(arg1.Gui.Position.X, UDim.new(0, arg1.Scroller.BoundedRenderPosition))
    end
    for _, v in pairs(arg1.Scrollbars) do
        v:UpdateRender()
    end
end
function setmetatable_result1_3_upvr.StopUpdate(arg1) -- Line 343
    arg1.Maid.UpdateMaid = nil
end
function setmetatable_result1_3_upvr.StopDrag(arg1) -- Line 347
    if arg1.Scroller:GetDisplacementPastBounds(arg1.Scroller.Position) == 0 then
        if 0 < arg1.Scroller.Velocity then
            arg1.Scroller.Target = math.max(arg1.Scroller.Target, arg1.Scroller.Position + arg1.Scroller.Velocity * 0.5)
        else
            arg1.Scroller.Target = math.min(arg1.Scroller.Target, arg1.Scroller.Position + arg1.Scroller.Velocity * 0.5)
        end
    end
    arg1:FreeScroll()
end
local RunService_upvr = game:GetService("RunService")
function setmetatable_result1_3_upvr.FreeScroll(arg1) -- Line 361
    local var2_result1_4 = MakeMaid_upvr()
    arg1:UpdateRender()
    var2_result1_4.RenderStepped = RunService_upvr.RenderStepped:connect(function() -- Line 365
        arg1:UpdateRender()
        if arg1.Scroller.AtRest then
            arg1:StopUpdate()
        end
    end)
    arg1.Maid.UpdateMaid = var2_result1_4
end
function setmetatable_result1_3_upvr.GetVelocityTracker(arg1, arg2) -- Line 375
    arg1.Scroller.Velocity = 0
    local tick_result1_3_upvw = tick()
    local Position_2_upvw = arg1.Scroller.Position
    local var47_upvw = arg2 or 1
    return function() -- Line 382
        local Position = arg1.Scroller.Position
        tick_result1_3_upvw = tick()
        Position_2_upvw = Position
        arg1.Scroller.Velocity = arg1.Scroller.Velocity - (Position_2_upvw - Position) / ((0.0001) + (tick() - tick_result1_3_upvw)) * var47_upvw
    end
end
function setmetatable_result1_3_upvr.GetProcessInput(arg1, arg2) -- Line 393
    local Position_3_upvr = arg2.Position
    local Position_upvr = arg1.Scroller.Position
    local any_GetVelocityTracker_result1_upvr_2 = arg1:GetVelocityTracker(0.25)
    return function(arg1_9) -- Line 398
        local var53
        if arg1.Horizontal then
            var53 = (arg1_9.Position - Position_3_upvr).x
        else
            var53 = (arg1_9.Position - Position_3_upvr).y
        end
        local var54 = Position_upvr - var53
        arg1.Scroller.Position = var54
        arg1.Scroller.Target = var54
        arg1:UpdateRender()
        any_GetVelocityTracker_result1_upvr_2()
        return var53
    end
end
function setmetatable_result1_3_upvr.ScrollTo(arg1, arg2, arg3) -- Line 416
    arg1.Scroller.Target = arg2
    if arg3 then
        arg1.Scroller.Position = arg1.Scroller.Target
        arg1.Scroller.Velocity = 0
    end
end
function setmetatable_result1_3_upvr.ScrollToTop(arg1, arg2) -- Line 424
    arg1:ScrollTo(arg1.Scroller.Min, arg2)
end
function setmetatable_result1_3_upvr.ScrollToBottom(arg1, arg2) -- Line 428
    arg1:ScrollTo(arg1.Scroller.Max, arg2)
end
local GuiService_upvr = game:GetService("GuiService")
function setmetatable_result1_3_upvr.BindInput(arg1, arg2, arg3) -- Line 432
    local var2_result1_3 = MakeMaid_upvr()
    local var58_upvw = 0
    var2_result1_3.GuiInputBegan = arg2.InputBegan:connect(function(arg1_10) -- Line 436
        if arg1_10.UserInputType == Enum.UserInputType.MouseMovement then
            local SelectedObject_3 = GuiService_upvr.SelectedObject
            if SelectedObject_3 then
                local tick_result1 = tick()
                if 0.1 < tick_result1 - var58_upvw then
                    var58_upvw = tick_result1
                    if arg1.Horizontal then
                        arg1.Scroller.Target = SelectedObject_3.AbsolutePosition.X - arg1.Gui.AbsolutePosition.X - 100
                    end
                    arg1:FreeScroll()
                end
            end
        end
        arg1:InputBegan(arg1_10, arg3)
    end)
    var2_result1_3.GuiInputChanged = arg2.InputChanged:connect(function(arg1_11) -- Line 453
        if arg2.Active then
            if arg1_11.UserInputType == Enum.UserInputType.MouseWheel then
                arg1.Scroller.Target = arg1.Scroller.Target + -arg1_11.Position.z * 80
                arg1:FreeScroll()
            end
        end
    end)
    var2_result1_3.AllInputBegan = UserInputService_upvr.InputBegan:Connect(function(arg1_12) -- Line 474
        if arg1_12.UserInputType == Enum.UserInputType.Gamepad1 then
            local SelectedObject_4 = GuiService_upvr.SelectedObject
            if SelectedObject_4 then
                if SelectedObject_4:IsDescendantOf(arg2) then
                    arg1:InputBegan(arg1_12, arg3)
                end
            end
        end
    end)
    local tick_result1_upvw = tick()
    var2_result1_3.AllInputChanged = UserInputService_upvr.InputChanged:Connect(function(arg1_13) -- Line 484
        if arg1_13.UserInputType == Enum.UserInputType.Gamepad1 then
            if tick() - tick_result1_upvw < 0.01 then
                return false
            end
            tick_result1_upvw = tick()
            local SelectedObject_2 = GuiService_upvr.SelectedObject
            if SelectedObject_2 and SelectedObject_2:IsDescendantOf(arg2) then
                if arg1.Horizontal then
                    arg1.Scroller.Target = SelectedObject_2.AbsolutePosition.X - arg1.Gui.AbsolutePosition.X - 200
                end
                arg1:FreeScroll()
            end
        end
    end)
    return var2_result1_3
end
function setmetatable_result1_3_upvr.InputBegan(arg1, arg2, arg3) -- Line 518
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var2_result1_2 = MakeMaid_upvr()
    local var71_upvw = 0
    if arg2.UserInputType == Enum.UserInputType.MouseButton1 then
        local any_GetProcessInput_result1_upvr = arg1:GetProcessInput(arg2)
        var2_result1_2.InputChanged = UserInputService_upvr.InputChanged:connect(function(arg1_14, arg2_2) -- Line 534
            if arg1_14.UserInputType == Enum.UserInputType.MouseMovement then
                var71_upvw += math.abs(any_GetProcessInput_result1_upvr(arg1_14))
            end
        end)
    elseif arg2.UserInputType == Enum.UserInputType.Touch then
        var2_result1_2.InputChanged = UserInputService_upvr.InputChanged:connect(function(arg1_15, arg2_3) -- Line 540, Named "Update"
            if arg1_15.UserInputType == Enum.UserInputType.Touch then
                var71_upvw += math.abs(any_GetProcessInput_result1_upvr(arg1_15))
            end
        end)
    end
    local tick_result1_4_upvr = tick()
    function var2_result1_2.Cleanup() -- Line 549
        arg1:UpdateRender()
        if arg3 and arg3.OnClick then
            local var76 = true
            if tick() - tick_result1_4_upvr > 0.1 then
                if var71_upvw >= 1 then
                    var76 = false
                else
                    var76 = true
                end
            end
            if var76 then
                arg3.OnClick(arg2)
            end
        end
    end
    var2_result1_2.InputEnded = UserInputService_upvr.InputEnded:connect(function(arg1_16, arg2_4) -- Line 560
        if arg1_16 == arg2 then
            arg1:StopDrag()
        end
    end)
    var2_result1_2.WindowFocusReleased = UserInputService_upvr.WindowFocusReleased:connect(function() -- Line 566
        arg1:StopDrag()
    end)
    arg1.Maid.UpdateMaid = var2_result1_2
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
return setmetatable_result1_3_upvr