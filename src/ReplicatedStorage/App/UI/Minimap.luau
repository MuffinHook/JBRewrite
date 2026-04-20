local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local createElement_upvr = Roact_upvr.createElement
local MinimapUtils_upvr = require(script.Parent.MinimapUtils)
local any_extend_result1 = Roact_upvr.PureComponent:extend("Minimap")
any_extend_result1.defaultProps = {
    visible = true;
    open = true;
    size = UDim2.new(1, 0, 1, 0);
    position = UDim2.new(0, 0, 0, 0);
    mapScale = 1;
    showToggleButton = true;
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 23
    arg1._maid = Maid_upvr.new()
    if arg1.props.containerSize then
        arg1.containerSize = arg1.props.containerSize
        arg1.updateContainerSize = arg1.props.updateContainerSize
    else
        local any_createBinding_result1_2, any_createBinding_result2_2 = Roact_upvr.createBinding(Vector2.new(512, 512))
        arg1.containerSize = any_createBinding_result1_2
        arg1.updateContainerSize = any_createBinding_result2_2
    end
    if arg1.props.containerRef then
        arg1.containerRef = arg1.props.containerRef
    else
        arg1.containerRef = Roact_upvr.createRef()
    end
    arg1:setState({
        trackVisible = false;
    })
end
local function makeMinimap_upvr(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 40, Named "makeMinimap"
    local module = {
        Image = string.format("rbxassetid://%d", arg3);
        ImageColor3 = arg1.props.mapImageColor3;
    }
    module.BackgroundTransparency = arg6
    module.Position = arg2:map(function(arg1_2) -- Line 46
        local any_computeOffsetXY_result1_2, any_computeOffsetXY_result2_2, any_computeOffsetXY_result3 = MinimapUtils_upvr.computeOffsetXY(arg1_2[2], arg1_2[1], arg1.props.mapWorldWidth, arg1.props.mapWorldHeight, arg1.props.mapWorldCenterX, arg1.props.mapWorldCenterY, arg1.props.mapImageWidth * arg5, arg1.props.mapImageHeight * arg5, arg1.props.mapScale)
        if not any_computeOffsetXY_result1_2 then
            return UDim2.new(0, 0, 0, 0)
        end
        return UDim2.new(0, -any_computeOffsetXY_result2_2, 0, -any_computeOffsetXY_result3)
    end)
    module.Size = arg2:map(function(arg1_3) -- Line 63
        local any_computeOffsetXY_result1, _, _, any_computeOffsetXY_result4_5 = MinimapUtils_upvr.computeOffsetXY(arg1_3[2], arg1_3[1], arg1.props.mapWorldWidth, arg1.props.mapWorldHeight, arg1.props.mapWorldCenterX, arg1.props.mapWorldCenterY, arg1.props.mapImageWidth * arg5, arg1.props.mapImageHeight * arg5, arg1.props.mapScale)
        if not any_computeOffsetXY_result1 then
            return UDim2.new(1, 0, 1, 0)
        end
        return UDim2.new(0, arg1.props.mapImageWidth * arg5 * any_computeOffsetXY_result4_5, 0, arg1.props.mapImageHeight * arg5 * any_computeOffsetXY_result4_5)
    end)
    module.ImageRectSize = arg2:map(function(arg1_4) -- Line 84
        local any_computeOffsetXY_result1_4, _, _, any_computeOffsetXY_result4_2 = MinimapUtils_upvr.computeOffsetXY(arg1_4[2], arg1_4[1], arg1.props.mapWorldWidth, arg1.props.mapWorldHeight, arg1.props.mapWorldCenterX, arg1.props.mapWorldCenterY, arg1.props.mapImageWidth * arg5, arg1.props.mapImageHeight * arg5, arg1.props.mapScale)
        if any_computeOffsetXY_result1_4 then
            return nil
        end
        local _1 = arg1_4[1]
        if not _1 then return end
        return _1 / any_computeOffsetXY_result4_2
    end)
    module.ImageRectOffset = arg2:map(function(arg1_5) -- Line 105
        local any_computeOffsetXY_result1_3, any_computeOffsetXY_result2_4, any_computeOffsetXY_result3_4, any_computeOffsetXY_result4_3 = MinimapUtils_upvr.computeOffsetXY(arg1_5[2], arg1_5[1], arg1.props.mapWorldWidth, arg1.props.mapWorldHeight, arg1.props.mapWorldCenterX, arg1.props.mapWorldCenterY, arg1.props.mapImageWidth * arg5, arg1.props.mapImageHeight * arg5, arg1.props.mapScale)
        if any_computeOffsetXY_result1_3 then
            return nil
        end
        return Vector2.new(any_computeOffsetXY_result2_4, any_computeOffsetXY_result3_4) / any_computeOffsetXY_result4_3
    end)
    module.ZIndex = arg4
    return createElement_upvr("ImageLabel", module, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
    })
end
local RunService_upvr = game:GetService("RunService")
local CharacterUtils_upvr = require(ReplicatedStorage.Std.CharacterUtils)
local Players_upvr = game:GetService("Players")
function any_extend_result1.didMount(arg1) -- Line 130
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    arg1._maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 131
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end))
    arg1._maid:GiveTask(workspace:GetAttributeChangedSignal("RaceTrackActive"):Connect(function() -- Line 168
        local tbl_20 = {}
        local var40
        if workspace:GetAttribute("RaceTrackActive") ~= true then
            var40 = false
        else
            var40 = true
        end
        tbl_20.trackVisible = var40
        arg1:setState(tbl_20)
    end))
    local var41
    if arg1.state.trackVisible == workspace:GetAttribute("RaceTrackActive") then
        var41 = false
    else
        var41 = true
    end
    if var41 == true then
        local tbl_15 = {}
        if workspace:GetAttribute("RaceTrackActive") ~= true then
        else
        end
        tbl_15.trackVisible = true
        arg1:setState(tbl_15)
    end
end
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 179
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var177
    if not var177 then return end
    var177 = arg1.props
    var177 = var177.pointsChildren
    if not var177 then
        var177 = {}
    end
    if arg1.props.points then
        for _, v in ipairs(arg1.props.points) do
            if not v._position then
                if not v.worldPosition then
                    if v.part then
                    end
                end
                if not v.part.Position then
                    if typeof(v._debugStr) == "string" then
                        warn("^ debug str: "..v._debugStr)
                    end
                end
                local any_createBinding_result1_4, any_createBinding_result2_5 = Roact_upvr.createBinding(Vector3.new(0, 0, 0))
                v._position = any_createBinding_result1_4
                v._updatePosition = any_createBinding_result2_5
            end
            if not v._visible then
                v.nextVisibleToggle = os.clock()
                local any_createBinding_result1_3, any_createBinding_result2_3 = Roact_upvr.createBinding(not v.flash)
                v._visible = any_createBinding_result1_3
                v._updateVisible = any_createBinding_result2_3
            end
            if not v.size then
                local udim2 = UDim2.new(0, 16, 0, 16)
            end
            if arg1.props.isSmallScreen then
            end
            var177[v.name] = createElement_upvr("ImageLabel", {
                BackgroundTransparency = 1;
                Image = "rbxassetid://4903883144";
                ImageColor3 = v.color;
                Size = UDim2.new(0, udim2.X.Offset / 2, 0, udim2.Y.Offset / 2);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Visible = v._visible;
                ZIndex = 3;
                Position = v._position:map(function(arg1_19) -- Line 212
                    return MinimapUtils_upvr.worldToScale(arg1_19.X, arg1_19.Z, arg1.props.mapWorldCenterX, arg1.props.mapWorldCenterY, arg1.props.mapWorldWidth, arg1.props.mapWorldHeight)
                end);
            })
        end
    end
    if arg1.props.labels then
        for _, v_2 in ipairs(arg1.props.labels) do
            local var191
            if typeof(v_2.position) == "Vector3" then
                local position_2 = v_2.position
                var191 = MinimapUtils_upvr.worldToScale(position_2.X, position_2.Z, arg1.props.mapWorldCenterX, arg1.props.mapWorldCenterY, arg1.props.mapWorldWidth, arg1.props.mapWorldHeight)
            elseif typeof(v_2.position) == "table" and v_2.position.map then
                var191 = v_2.position:map(function(arg1_20) -- Line 240
                    return MinimapUtils_upvr.worldToScale(arg1_20.X, arg1_20.Z, arg1.props.mapWorldCenterX, arg1.props.mapWorldCenterY, arg1.props.mapWorldWidth, arg1.props.mapWorldHeight)
                end)
            end
            local var194
            local tbl_45 = {
                BackgroundTransparency = 1;
                AnchorPoint = Vector2.new(0.5, 0.5);
                Position = var191;
                ZIndex = 1;
            }
            local tbl_28 = {}
            if v_2.imageId then
                var194 = "ImageLabel"
                tbl_45.Image = "rbxassetid://2819326547"
                tbl_45.Size = arg1.containerSize:map(function(arg1_21) -- Line 262
                    return UDim2.new(0, arg1_21.X * 0.03, 0, arg1_21.X * 0.03)
                end)
                tbl_45.ImageColor3 = v_2.markerColor
                local tbl_50 = {
                    Icon = createElement_upvr("ImageLabel", {
                        BackgroundTransparency = 1;
                        Size = UDim2.new(1, 0, 1, 0);
                        ImageColor3 = Color3.fromRGB(0, 0, 0);
                        Image = string.format("rbxassetid://%s", v_2.imageId);
                    });
                }
                local scale = v_2.scale
                if scale then
                    scale = createElement_upvr
                    scale = scale("UIScale", {
                        Scale = v_2.scale;
                    })
                end
                tbl_50.UIScale = scale
                tbl_28 = tbl_50
            elseif v_2.title then
                var194 = "TextLabel"
                tbl_45.Size = arg1.containerSize:map(function(arg1_22) -- Line 279
                    return UDim2.new(0, arg1_22.X * 0.1, 0, arg1_22.X * 0.02)
                end)
                tbl_45.Font = Enum.Font.GothamBlack
                tbl_45.TextColor3 = Color3.new(1, 1, 1)
                tbl_45.Text = v_2.title
                tbl_45.TextScaled = true
                tbl_45.ZIndex = 2
                tbl_28.UIStroke = createElement_upvr("UIStroke", {
                    Color = Color3.new(0, 0, 0);
                    Thickness = 2;
                })
            end
            assert(var194, "missing classname for label")
            var177[string.format("label_%s", v_2.title)] = createElement_upvr(var194, tbl_45, tbl_28)
        end
    end
    var177._you = createElement_upvr("ImageLabel", {
        BackgroundTransparency = 1;
        Image = "rbxassetid://4903882925";
        AnchorPoint = Vector2.new(0.5, 0.5);
        Size = arg1.containerSize:map(function(arg1_23) -- Line 301
            return UDim2.new(0, math.min(20, arg1_23.X * 0.1), 0, math.min(20, arg1_23.X * 0.1))
        end);
        ImageColor3 = arg1.props.color;
        ZIndex = 5;
        Position = arg1.props.worldPosition:map(function(arg1_24) -- Line 307
            return MinimapUtils_upvr.worldToScale(arg1_24.X, arg1_24.Z, arg1.props.mapWorldCenterX, arg1.props.mapWorldCenterY, arg1.props.mapWorldWidth, arg1.props.mapWorldHeight)
        end);
        Rotation = arg1.props.worldDirection:map(function(arg1_25) -- Line 317
            return -math.deg(math.atan2(-arg1_25.Z, arg1_25.X) - (math.pi/2))
        end);
    })
    if arg1.props.waypoint then
        local waypoint_2 = arg1.props.waypoint
        local tbl_48 = {
            BackgroundTransparency = 1;
            Image = "rbxassetid://8971844725";
            ImageColor3 = Color3.new(1, 1, 1);
        }
        if not arg1.props.isSmallScreen or not UDim2.new(0, 24, 0, 24) then
        end
        tbl_48.Size = UDim2.new(0, 48, 0, 48)
        tbl_48.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl_48.ZIndex = 3
        tbl_48.Position = MinimapUtils_upvr.worldToScale(waypoint_2.X, waypoint_2.Z, arg1.props.mapWorldCenterX, arg1.props.mapWorldCenterY, arg1.props.mapWorldWidth, arg1.props.mapWorldHeight)
        var177._waypoint = createElement_upvr("ImageLabel", tbl_48)
    end
    waypoint_2 = arg1.props[Roact_upvr.Children]
    local var210 = waypoint_2
    if not var210 then
        var210 = {}
    end
    if arg1.props.square then
        var210.AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 1;
        })
    end
    local var212
    if arg1.props.time ~= nil then
        local tbl_25 = {}
        var212 = 1
        tbl_25.BackgroundTransparency = var212
        var212 = "rbxassetid://4903944433"
        tbl_25.Image = var212
        var212 = arg1.props
        var212 = var212.color
        tbl_25.ImageColor3 = var212
        var212 = UDim2.new
        local var214 = 1
        var212 = var212(0.5, 0, var214, 0)
        tbl_25.Size = var212
        local function decompInlinedCondition_4() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var212 = Vector2.new(0.9, 0.5)
            return var212
        end
        if not arg1.props.open or not decompInlinedCondition_4() then
            var212 = Vector2.new(0, 0)
        end
        tbl_25.AnchorPoint = var212
        var212 = UDim2.new
        if arg1.props.open then
        elseif arg1.props.isSmallScreen then
        else
        end
        if arg1.props.open then
            var214 = 1
        elseif arg1.props.isSmallScreen then
            var214 = 0.05
        else
            var214 = 0
        end
        var212 = var212(0, 0, var214, 0)
        tbl_25.Position = var212
        var212 = 2
        tbl_25.ZIndex = var212
        var212 = {}
        var212.AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 3;
        })
        var212.SizeConstraint = createElement_upvr("UISizeConstraint", {
            MaxSize = Vector2.new(200, 50);
        })
        var212.Time = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Font = Enum.Font.LuckiestGuy;
            Text = arg1.props.time;
            TextColor3 = Color3.new(1, 1, 1);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Size = UDim2.new(0.7, 0, 0.7, 0);
            Position = UDim2.new(0.5, 0, 0.58, 0);
            TextScaled = true;
        })
        var210.Time = createElement_upvr("ImageLabel", tbl_25, var212)
    end
    if arg1.props.showToggleButton then
        local tbl_47 = {}
        var212 = 1
        tbl_47.BackgroundTransparency = var212
        var212 = "rbxassetid://4933143781"
        tbl_47.Image = var212
        var212 = Vector2.new(0.4, 0.4)
        tbl_47.AnchorPoint = var212
        var212 = 3
        tbl_47.ZIndex = var212
        var212 = UDim2.new(0, 0, 0, 0)
        tbl_47.Position = var212
        local function decompInlinedCondition_5() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var212 = UDim2.new(0.2, 0, 0.2, 0)
            return var212
        end
        if not arg1.props.isSmallScreen or not decompInlinedCondition_5() then
            var212 = UDim2.new(0.1, 0, 0.1, 0)
        end
        tbl_47.Size = var212
        var212 = Roact_upvr
        var212 = var212.Event
        var212 = var212.MouseButton1Down
        tbl_47[var212] = function() -- Line 388
            if arg1.props.onToggle then
                arg1.props.onToggle(not arg1.props.open)
            end
        end
        var212 = {}
        var212.AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 1;
        })
        var212.SizeConstraint = createElement_upvr("UISizeConstraint", {
            MaxSize = Vector2.new(30, 30);
        })
        var210.Toggle = createElement_upvr("ImageButton", tbl_47, var212)
    end
    local tbl_44 = {}
    if arg1.props.circles then
        var212 = nil
        for _, v_3 in arg1.props.circles, var212 do
            local var225
            if not v_3.worldRadiusBinding then
                error("circle missing worldRadiusBinding")
            end
            if not v_3.worldPositionBinding then
                error("circle missing worldPositionBinding")
            end
            if not v_3.name then
                error("circle missing name")
            end
            local formatted = string.format("circle_%s", v_3.name)
            if tbl_44[formatted] then
                error(string.format("duplicate circle name %s", v_3.name))
            end
            function var225(arg1_26) -- Line 419
                return MinimapUtils_upvr.relativeWorldToScale(2 * arg1_26, 2 * arg1_26, arg1.props.mapWorldWidth, arg1.props.mapWorldHeight)
            end
            local function var226(arg1_27) -- Line 426
                return MinimapUtils_upvr.worldToScale(arg1_27.X, arg1_27.Z, arg1.props.mapWorldCenterX, arg1.props.mapWorldCenterY, arg1.props.mapWorldWidth, arg1.props.mapWorldHeight)
            end
            var225 = v_3.color
            if not var225 then
                var225 = Color3.new(1, 1, 1)
            end
            if v_3.invert then
                tbl_44[formatted] = createElement_upvr("Frame", {
                    BackgroundTransparency = v_3.transparency or 0;
                    BackgroundColor3 = var225;
                    BorderSizePixel = 0;
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Position = v_3.worldPositionBinding:map(var226);
                    Size = v_3.worldRadiusBinding:map(var225);
                    ZIndex = 1;
                }, {
                    Corner = createElement_upvr("UICorner", {
                        CornerRadius = UDim.new(1, 0);
                    });
                    StrokeOuter = createElement_upvr("UIStroke", {
                        Color = var225;
                        Thickness = 500;
                        Transparency = 0;
                    });
                    Fake = createElement_upvr("Frame", {
                        Size = UDim2.new(1, 0, 1, 0);
                        BackgroundTransparency = 1;
                    }, {
                        Corner = createElement_upvr("UICorner", {
                            CornerRadius = UDim.new(1, 0);
                        });
                        Stroke = createElement_upvr("UIStroke", {
                            Color = ColorUtils_upvr.brightenBy(var225, -0.2);
                            Thickness = 2;
                        });
                    });
                })
            else
                local tbl_10 = {
                    BackgroundTransparency = v_3.transparency or 0;
                    BackgroundColor3 = var225;
                    BorderSizePixel = 0;
                    AnchorPoint = Vector2.new(0.5, 0.5);
                }
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                tbl_10.Position = v_3.worldPositionBinding:map(var226)
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                tbl_10.Size = v_3.worldRadiusBinding:map(var225)
                tbl_10.ZIndex = 1
                tbl_44[formatted] = createElement_upvr("Frame", tbl_10, {
                    Corner = createElement_upvr("UICorner", {
                        CornerRadius = UDim.new(1, 0);
                    });
                    Stroke = createElement_upvr("UIStroke", {
                        Color = ColorUtils_upvr.brightenBy(var225, -0.2);
                        Thickness = 2;
                    });
                })
            end
        end
    end
    local var239
    if arg1.props.open then
        local tbl = {}
        var212 = arg1.containerSize
        tbl[1] = var212
        tbl[2] = arg1.props.worldPosition
        local any_joinBindings_result1 = Roact_upvr.joinBindings(tbl)
        var212 = "TextButton"
        local tbl_33 = {
            AutoButtonColor = false;
            Text = "";
            BackgroundTransparency = 0;
        }
        var239 = 0
        tbl_33.Size = UDim2.new(1, 0, 1, var239)
        tbl_33.BackgroundColor3 = arg1.props.color
        tbl_33[Roact_upvr.Event.Activated] = arg1.props.onClick
        local tbl_41 = {}
        local tbl_31 = {}
        var239 = UDim.new(0, 4)
        tbl_31.CornerRadius = var239
        tbl_41.UICorner = createElement_upvr("UICorner", tbl_31)
        local tbl_6 = {}
        local function decompInlinedCondition_6() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var239 = var239:map(function(arg1_28) -- Line 508
                return Color3.fromRGB(84 * arg1_28.r, 128 * arg1_28.g, 178 * arg1_28.b)
            end)
            var239 = var239.mapImageColor3
            var239 = arg1.props
            return var239
        end
        if not arg1.props.mapImageColor3 or not decompInlinedCondition_6() then
            var239 = Color3.new(0.1, 0.1, 0.1)
        end
        tbl_6.BackgroundColor3 = var239
        var239 = 0
        tbl_6.BackgroundTransparency = var239
        var239 = Vector2.new(0.5, 0.5)
        tbl_6.AnchorPoint = var239
        var239 = UDim2.new(1, -4, 1, -4)
        tbl_6.Size = var239
        var239 = UDim2.new(0.5, 0, 0.5, 0)
        tbl_6.Position = var239
        var239 = true
        tbl_6.ClipsDescendants = var239
        var239 = Roact_upvr
        var239 = var239.Ref
        tbl_6[var239] = arg1.containerRef
        var239 = Roact_upvr
        var239 = var239.Change
        var239 = var239.AbsoluteSize
        tbl_6[var239] = function(arg1_29) -- Line 519
            if arg1_29 then
                arg1.updateContainerSize(arg1_29.AbsoluteSize)
            end
        end
        var239 = Dictionary_upvr
        var239 = var239.merge
        local tbl_35 = {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0, 4);
            });
            Points = createElement_upvr("Frame", {
                BackgroundTransparency = 1;
                AnchorPoint = Vector2.new(0, 0);
                Position = any_joinBindings_result1:map(function(arg1_30) -- Line 532
                    local _, any_computeOffsetXY_result2_3, any_computeOffsetXY_result3_2 = MinimapUtils_upvr.computeOffsetXY(arg1_30[2], arg1_30[1], arg1.props.mapWorldWidth, arg1.props.mapWorldHeight, arg1.props.mapWorldCenterX, arg1.props.mapWorldCenterY, arg1.props.mapImageWidth, arg1.props.mapImageHeight, arg1.props.mapScale)
                    return UDim2.new(0, -any_computeOffsetXY_result2_3, 0, -any_computeOffsetXY_result3_2)
                end);
                Size = any_joinBindings_result1:map(function(arg1_31) -- Line 546
                    local _, _, _, any_computeOffsetXY_result4_4 = MinimapUtils_upvr.computeOffsetXY(arg1_31[2], arg1_31[1], arg1.props.mapWorldWidth, arg1.props.mapWorldHeight, arg1.props.mapWorldCenterX, arg1.props.mapWorldCenterY, arg1.props.mapImageWidth, arg1.props.mapImageHeight, arg1.props.mapScale)
                    return UDim2.new(0, arg1.props.mapImageWidth * any_computeOffsetXY_result4_4, 0, arg1.props.mapImageHeight * any_computeOffsetXY_result4_4)
                end);
                ZIndex = 2;
            }, Dictionary_upvr.merge(var177, tbl_44));
            Render = makeMinimap_upvr(arg1, any_joinBindings_result1, arg1.props.mapImageId, 0, 1, 0);
        }
        if not arg1.state.trackVisible or not makeMinimap_upvr(arg1, any_joinBindings_result1, 106966740654302, 1, 2, 1) then
        end
        tbl_35.RenderTrack = nil
        var239 = var239(tbl_35, arg1.props.containerChildren)
        tbl_41.Container = createElement_upvr("Frame", tbl_6, var239)
        var210.Map = createElement_upvr(var212, tbl_33, tbl_41)
    end
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
        LayoutOrder = arg1.props.displayOrder;
    }, var210)
end
function any_extend_result1.willUnmount(arg1) -- Line 579
    arg1._maid:DoCleaning()
end
return any_extend_result1
