local GuiService_upvr = game:GetService("GuiService")
local UserInputService_upvr = game:GetService("UserInputService")
local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("BigMinimap")
any_extend_result1.defaultProps = {
    visible = true;
    mapScale = 1;
}
function any_extend_result1.init(arg1) -- Line 22
    arg1.horizontalRef = Roact_upvr.createRef()
    arg1.verticalRef = Roact_upvr.createRef()
    arg1.maid = Maid_upvr.new()
    if arg1.props.containerSize then
        arg1.containerSize = arg1.props.containerSize
        arg1.updateContainerSize = arg1.props.updateContainerSize
    else
        local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(Vector2.new(512, 512))
        arg1.containerSize = any_createBinding_result1
        arg1.updateContainerSize = any_createBinding_result2
    end
    if arg1.props.containerRef then
        arg1.containerRef = arg1.props.containerRef
    else
        arg1.containerRef = Roact_upvr.createRef()
    end
    arg1:setState({
        crossHairEnabled = false;
        inputType = Enum.UserInputType.Keyboard;
    })
    arg1.x = 0
    arg1.y = 0
end
local createElement_upvr = Roact_upvr.createElement
local Minimap_upvr = require(script.Parent.Minimap)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 42
    if not arg1.props.visible then return end
    local module = {}
    local tbl = {
        ListLayout = createElement_upvr("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Left;
            VerticalAlignment = Enum.VerticalAlignment.Center;
            SortOrder = Enum.SortOrder.LayoutOrder;
            FillDirection = Enum.FillDirection.Horizontal;
            Padding = UDim.new(0, 4);
        });
    }
    local tbl_2 = {}
    local tbl_3 = {
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        Size = UDim2.new(0.9, 0, 0.9, 0);
        Position = UDim2.new(0.5, 0, 0.5, 0);
    }
    local vector2 = Vector2.new(0.5, 0.5)
    tbl_3.AnchorPoint = vector2
    if #arg1.props.waypoints == 0 then
        vector2 = "Add Waypoint"
    else
        vector2 = "Remove Waypoint"
    end
    tbl_3.Text = vector2
    tbl_3.Font = Enum.Font.LuckiestGuy
    tbl_3.LineHeight = 0.7
    tbl_3.TextScaled = true
    tbl_3.TextXAlignment = Enum.TextXAlignment.Center
    tbl_3.TextYAlignment = Enum.TextYAlignment.Center
    tbl_3.TextColor3 = Color3.fromRGB(255, 255, 255)
    tbl_3.ZIndex = 10
    tbl_2.Title = createElement_upvr("TextLabel", tbl_3)
    tbl_2.AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
        AspectRatio = 8;
    })
    tbl_2.UICorner = createElement_upvr("UICorner", {
        CornerRadius = UDim.new(0.25, 0);
    })
    tbl.Waypoint = createElement_upvr("TextButton", {
        BackgroundColor3 = arg1.props.color;
        Size = UDim2.new(1, 0, 1, 0);
        Text = "";
        LayoutOrder = 1;
        Selectable = true;
        [Roact_upvr.Event.Activated] = function() -- Line 98
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            GuiService_upvr.SelectedObject = nil
            local AbsoluteSize_3 = arg1.containerRef:getValue().AbsoluteSize
            arg1:_setXY(AbsoluteSize_3.X * 0.5, AbsoluteSize_3.Y * 0.5)
            do
                return
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            arg1.props.onSetWaypoint(nil)
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end;
    }, tbl_2)
    module.Buttons = createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        Size = UDim2.new(1, 0, 0.05, 0);
        Position = UDim2.new(0, 0, 1, 4);
    }, tbl)
    return createElement_upvr(Minimap_upvr, Dictionary_upvr.merge(arg1.props, {
        containerSize = arg1.containerSize;
        updateContainerSize = arg1.updateContainerSize;
        containerRef = arg1.containerRef;
        containerChildren = {
            LineHorizontal = createElement_upvr("Frame", {
                BackgroundTransparency = 0;
                Size = UDim2.new(1, 0, 0, 2);
                AnchorPoint = Vector2.new(0, 0.5);
                BackgroundColor3 = Color3.new(1, 1, 1);
                BorderSizePixel = 1;
                BorderColor3 = Color3.new(0.4, 0.4, 0.4);
                ZIndex = 4;
                Visible = arg1.state.crossHairEnabled;
                [Roact_upvr.Ref] = arg1.horizontalRef;
            });
            LineVertical = createElement_upvr("Frame", {
                BackgroundTransparency = 0;
                Size = UDim2.new(0, 2, 1, 0);
                AnchorPoint = Vector2.new(0.5, 0);
                BackgroundColor3 = Color3.new(1, 1, 1);
                BorderSizePixel = 1;
                BorderColor3 = Color3.new(0.4, 0.4, 0.4);
                ZIndex = 4;
                Visible = arg1.state.crossHairEnabled;
                [Roact_upvr.Ref] = arg1.verticalRef;
            });
        };
    }), module)
end
function any_extend_result1._setXY(arg1, arg2, arg3) -- Line 140
    local AbsoluteSize = arg1.containerRef:getValue().AbsoluteSize
    arg1.x = math.clamp(arg2, 0, AbsoluteSize.X)
    arg1.y = math.clamp(arg3, 0, AbsoluteSize.Y)
    if arg1.state.crossHairEnabled then
        arg1.horizontalRef:getValue().Position = UDim2.new(0, 0, 0, arg1.y)
        arg1.verticalRef:getValue().Position = UDim2.new(0, arg1.x, 0, 0)
    end
end
local MinimapUtils_upvr = require(script.Parent.MinimapUtils)
function any_extend_result1._hookVisible(arg1, arg2) -- Line 154
    if arg2 then
        local any_new_result1 = Maid_upvr.new()
        arg1.maid.visibleMaid = any_new_result1
        local any_GetGuiInset_result1_upvr = GuiService_upvr:GetGuiInset()
        any_new_result1:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 161
            if arg1.state.inputType == Enum.UserInputType.Keyboard then
                local var36 = UserInputService_upvr:GetMouseLocation() - any_GetGuiInset_result1_upvr
                local AbsolutePosition = arg1.containerRef:getValue().AbsolutePosition
                arg1:_setXY(var36.X - AbsolutePosition.X, var36.Y - AbsolutePosition.Y)
            end
        end))
        any_new_result1:GiveTask(UserInputService_upvr.InputBegan:Connect(function(arg1_2) -- Line 180
            if not arg1.state.crossHairEnabled then
            elseif arg1_2.UserInputType == Enum.UserInputType.MouseButton1 or arg1_2.UserInputType == Enum.UserInputType.Touch or arg1_2.UserInputType == Enum.UserInputType.Gamepad1 and arg1_2.KeyCode == Enum.KeyCode.ButtonA then
                local any_getValue_result1 = arg1.containerRef:getValue()
                local AbsoluteSize_2 = any_getValue_result1.AbsoluteSize
                if arg1_2.UserInputType == Enum.UserInputType.Touch then
                    local AbsolutePosition_2 = any_getValue_result1.AbsolutePosition
                    arg1.x = arg1_2.Position.X - AbsolutePosition_2.X
                    arg1.y = arg1_2.Position.Y - AbsolutePosition_2.Y
                end
                local x = arg1.x
                local y = arg1.y
                if x < 0 or y < 0 or AbsoluteSize_2.X < x or AbsoluteSize_2.Y < y then return end
                local any_computeWorldXY_result1, any_computeWorldXY_result2 = MinimapUtils_upvr.computeWorldXY(x, y, arg1.props.worldPosition:getValue(), arg1.containerSize:getValue(), arg1.props.mapWorldWidth, arg1.props.mapWorldHeight, arg1.props.mapWorldCenterX, arg1.props.mapWorldCenterY, arg1.props.mapImageWidth, arg1.props.mapImageHeight, arg1.props.mapScale)
                if arg1.props.onSetWaypoint then
                    arg1.props.onSetWaypoint(Vector3.new(any_computeWorldXY_result1, 50, any_computeWorldXY_result2))
                end
                if arg1.props.onToggle then
                    arg1.props.onToggle(false)
                end
                arg1:setState({
                    crossHairEnabled = false;
                })
            end
        end))
    else
        any_GetGuiInset_result1_upvr = nil
        arg1.maid.visibleMaid = any_GetGuiInset_result1_upvr
    end
end
function any_extend_result1.didMount(arg1) -- Line 236
    local function updateInputType() -- Line 237
        local any_GetLastInputType_result1 = UserInputService_upvr:GetLastInputType()
        if any_GetLastInputType_result1 == Enum.UserInputType.Gamepad1 or any_GetLastInputType_result1 == Enum.UserInputType.Keyboard or any_GetLastInputType_result1 == Enum.UserInputType.Touch then
            if arg1.state.inputType ~= any_GetLastInputType_result1 then
                arg1:setState({
                    inputType = any_GetLastInputType_result1;
                })
            end
        end
    end
    updateInputType()
    arg1.maid:GiveTask(UserInputService_upvr.LastInputTypeChanged:Connect(updateInputType))
end
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 254
    if arg1.state.crossHairEnabled ~= arg3.crossHairEnabled then
        arg1:_hookGamepad(arg1.state.crossHairEnabled)
    end
    if arg1.props.visible ~= arg2.visible then
        arg1:_hookVisible(arg1.props.visible)
    end
end
local ContextActionService_upvr = game:GetService("ContextActionService")
function any_extend_result1._hookGamepad(arg1, arg2) -- Line 262
    if arg2 then
        ContextActionService_upvr:BindActionAtPriority("sinkThumb1", function() -- Line 264
            return Enum.ContextActionResult.Sink
        end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Thumbstick1)
        ContextActionService_upvr:BindActionAtPriority("sinkJump", function() -- Line 267
            return Enum.ContextActionResult.Sink
        end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonA)
        local var52_upvw
        arg1.maid.selectionDragListen = UserInputService_upvr.InputChanged:Connect(function(arg1_3) -- Line 272
            if arg1_3.UserInputType == Enum.UserInputType.Gamepad1 and arg1_3.KeyCode == Enum.KeyCode.Thumbstick1 then
                var52_upvw = arg1_3
            end
        end)
        arg1.maid.dragHeartbeat = RunService_upvr.Heartbeat:Connect(function(arg1_4) -- Line 280
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            local var55
            local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                local Y = var52_upvw.Position.Y
                var55 = var55.X
                var55 = var55.Position
                var55 = var52_upvw
                return 0.1 < math.abs(var55)
            end
            if var55 and (decompInlinedCondition() or 0.1 < math.abs(Y)) then
                arg1:_setXY(arg1.x + var55 * 10, arg1.y - Y * 10, true)
            end
        end)
    else
        ContextActionService_upvr:UnbindAction("sinkThumb1")
        ContextActionService_upvr:UnbindAction("sinkJump")
        arg1.maid.selectionDragListen = nil
        arg1.maid.dragHeartbeat = nil
    end
end
function any_extend_result1.willUnmount(arg1) -- Line 297
    arg1:_hookGamepad(false)
    arg1.maid:DoCleaning()
end
local MinimapService_upvr = require(ReplicatedStorage.App.MinimapService)
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 302
    return {
        labels = arg1.minimapLabels;
        waypoints = arg1.minimapWaypoints;
        points = arg1.minimapPoints;
        circles = arg1.minimapCircles;
    }
end, function(arg1) -- Line 309
    return {
        onSetWaypoint = function(arg1_5) -- Line 311, Named "onSetWaypoint"
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            MinimapService_upvr._addWaypointRemote:FireServer(arg1_5.X, arg1_5.Z)
            do
                return
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            arg1({
                type = "removeWaypointCurrent";
            })
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end;
    }
end)(any_extend_result1)