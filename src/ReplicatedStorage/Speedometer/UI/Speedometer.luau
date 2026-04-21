local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService_upvr = game:GetService("RunService")
local Roact_upvr = require(ReplicatedStorage.Roact)
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local function _(arg1) -- Line 10, Named "comma"
    local string_match_result1, string_match_result2_2, string_match_result3_2 = string.match(arg1, "^([^%d]*%d)(%d*)(.-)$")
    return string_match_result1..string_match_result2_2:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3_2
end
local any_extend_result1 = Roact_upvr.PureComponent:extend("Speedometer")
any_extend_result1.defaultProps = {
    metric = "MPH";
    hasLicensePlate = true;
    licensePlate = "JAILBRK!";
    locked = false;
    lockEnabled = true;
    ejectEnabled = true;
    missilesEnabled = false;
    missileCount = 0;
    missileMax = 10;
    size = UDim2.new(1, 0, 1, 0);
    position = UDim2.new(0, 0, 0, 0);
    enabled = true;
}
function any_extend_result1.init(arg1) -- Line 30
    arg1:setState({
        ejectOpen = false;
    })
    arg1.color_strokeRef = Roact_upvr.createRef()
    arg1.color_frameRef = Roact_upvr.createRef()
    arg1.color_frame2Ref = Roact_upvr.createRef()
end
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local HyperChromeConsts_upvr = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
function any_extend_result1.didMount(arg1) -- Line 38
    arg1.maid = Maid_upvr.new()
    local any_GetLocalVehicleModel_result1_2_upvr = VehicleUtils_upvr.GetLocalVehicleModel()
    assert(any_GetLocalVehicleModel_result1_2_upvr, "No local vehicle model")
    arg1.maid:GiveTask(VehicleUtils_upvr.getTireHealthChangedSignal(any_GetLocalVehicleModel_result1_2_upvr):Connect(function() -- Line 42
        arg1:setState({
            _c = math.random();
        })
    end))
    arg1.maid:GiveTask(VehicleUtils_upvr.getTireMaxHealthChangedSignal(any_GetLocalVehicleModel_result1_2_upvr):Connect(function() -- Line 48
        arg1:setState({
            _c = math.random();
        })
    end))
    local function _(arg1_2) -- Line 55, Named "setColor"
        local any_getValue_result1 = arg1.color_strokeRef:getValue()
        local any_getValue_result1_7 = arg1.color_frameRef:getValue()
        local any_getValue_result1_4 = arg1.color_frame2Ref:getValue()
        if any_getValue_result1 then
            any_getValue_result1.Color = arg1_2
        end
        if any_getValue_result1_7 then
            any_getValue_result1_7.BackgroundColor3 = arg1_2
        end
        if any_getValue_result1_4 then
            any_getValue_result1_4.BackgroundColor3 = arg1_2
        end
    end
    local function hyperChromeUpdated() -- Line 69
        if any_GetLocalVehicleModel_result1_2_upvr:GetAttribute(HyperChromeConsts_upvr.HYPERCHROME_NAME_ATTRIBUTE_NAME) == HyperChromeConsts_upvr.COLOR_SHIFT_NAME then
            arg1.maid.hyperShiftParticleRainbowHeartbeat = RunService_upvr.Heartbeat:Connect(function() -- Line 72
                local Color3_fromHSV_result1 = Color3.fromHSV(os.clock() % HyperChromeConsts_upvr.RAINBOW_ANIMATION_CYCLE_TIME / HyperChromeConsts_upvr.RAINBOW_ANIMATION_CYCLE_TIME, 1, 1)
                local any_getValue_result1_2 = arg1.color_strokeRef:getValue()
                local any_getValue_result1_8 = arg1.color_frameRef:getValue()
                local any_getValue_result1_3 = arg1.color_frame2Ref:getValue()
                if any_getValue_result1_2 then
                    any_getValue_result1_2.Color = Color3_fromHSV_result1
                end
                if any_getValue_result1_8 then
                    any_getValue_result1_8.BackgroundColor3 = Color3_fromHSV_result1
                end
                if any_getValue_result1_3 then
                    any_getValue_result1_3.BackgroundColor3 = Color3_fromHSV_result1
                end
            end)
        else
            arg1.maid.hyperShiftParticleRainbowHeartbeat = nil
            local color = arg1.props.color
            local any_getValue_result1_9 = arg1.color_strokeRef:getValue()
            local any_getValue_result1_5 = arg1.color_frameRef:getValue()
            local any_getValue_result1_6 = arg1.color_frame2Ref:getValue()
            if any_getValue_result1_9 then
                any_getValue_result1_9.Color = color
            end
            if any_getValue_result1_5 then
                any_getValue_result1_5.BackgroundColor3 = color
            end
            if any_getValue_result1_6 then
                any_getValue_result1_6.BackgroundColor3 = color
            end
        end
    end
    task.spawn(hyperChromeUpdated)
    arg1.maid:GiveTask(any_GetLocalVehicleModel_result1_2_upvr:GetAttributeChangedSignal(HyperChromeConsts_upvr.HYPERCHROME_NAME_ATTRIBUTE_NAME):Connect(hyperChromeUpdated))
end
local createElement_upvr = Roact_upvr.createElement
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 89
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var44
    if not arg1.props.enabled then return end
    local smallUI = arg1.props.smallUI
    local any_GetLocalVehicleModel_result1 = VehicleUtils_upvr.GetLocalVehicleModel()
    if not any_GetLocalVehicleModel_result1 then return end
    var44 = VehicleUtils_upvr
    var44 = var44.getTireHealth(any_GetLocalVehicleModel_result1)
    if RunService_upvr:IsRunning() then
        assert(var44 and VehicleUtils_upvr.getTireMaxHealth(any_GetLocalVehicleModel_result1), "No health or maxHealth")
    else
        var44 = 75
    end
    local var47 = var44 / 150
    local tbl_3 = {}
    local var49
    if arg1.state.ejectOpen and arg1.props.passengers then
        for i, v in ipairs(arg1.props.passengers) do
            local Name_upvr = v.Name
            local tbl_13 = {}
            local tbl_8 = {}
            var49 = 0
            tbl_8.CornerRadius = UDim.new(0.25, var49)
            tbl_13.UICorner = createElement_upvr("UICorner", tbl_8)
            local tbl = {
                BackgroundTransparency = 1;
                Text = Name_upvr;
                Font = Enum.Font.LuckiestGuy;
            }
            var49 = 0.2
            tbl.TextColor3 = Color3.new(0.2, var49, 0.2)
            tbl.TextScaled = true
            var49 = 0
            tbl.Size = UDim2.new(1, var49, 0.9, 0)
            var49 = 0.5
            tbl.AnchorPoint = Vector2.new(0.5, var49)
            var49 = 0
            tbl.Position = UDim2.new(0.5, var49, 0.6, 0)
            tbl_13.Title = createElement_upvr("TextLabel", tbl)
            tbl_3[Name_upvr] = createElement_upvr("TextButton", {
                BackgroundTransparency = 0;
                BorderSizePixel = 0;
                BackgroundColor3 = Color3.new(1, 1, 1);
                Size = UDim2.new(1, 0, 1, 0);
                AnchorPoint = Vector2.new(0, 0);
                Text = "";
                LayoutOrder = 10 - i;
                [Roact_upvr.Event.MouseButton1Down] = function() -- Line 121
                    arg1:setState({
                        ejectOpen = false;
                    })
                    if arg1.props.onClickEjectName then
                        arg1.props.onClickEjectName(Name_upvr)
                    end
                end;
            }, tbl_13)
        end
    end
    for i_2_upvr = 1, 9 do
        Name_upvr = "ImageLabel"
        ;({})[i_2_upvr] = createElement_upvr(Name_upvr, {
            BackgroundTransparency = 1;
            ImageTransparency = 0;
            Image = "rbxassetid://8208058512";
            Size = UDim2.new(1, 0, 1, 0);
            ImageColor3 = arg1.props.accelRatio:map(function(arg1_3) -- Line 156
                local var62 = i_2_upvr / 10
                local var63 = (i_2_upvr + 1) / 10
                local var64
                if arg1_3 < var62 then
                    var64 = Color3.new(0, 0, 0)
                    return var64
                end
                if arg1_3 < var63 then
                    var64 = Color3.new(0, 0, 0):lerp(var64, ((arg1_3 - var62) / (var63 - var62)) ^ 2)
                end
                return var64
            end);
            LayoutOrder = i_2_upvr;
        }, {
            AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 1.34375;
            });
        })
        local var67
    end
    local module_2 = {
        BackgroundTransparency = 0.6666666666666666;
    }
    Name_upvr = 0.2
    module_2.BackgroundColor3 = Color3.new(Name_upvr, 0.2, 0.2)
    module_2.Size = arg1.props.size
    module_2.Position = arg1.props.position
    module_2.AnchorPoint = arg1.props.anchorPoint
    local module = {}
    Name_upvr = createElement_upvr
    local tbl_4 = {}
    if smallUI then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    tbl_4.AspectRatio = 3
    Name_upvr = Name_upvr("UIAspectRatioConstraint", tbl_4)
    module.AspectRatio = Name_upvr
    Name_upvr = createElement_upvr
    Name_upvr = Name_upvr("UICorner", {
        CornerRadius = UDim.new(0.25, 0);
    })
    module.UICorner = Name_upvr
    Name_upvr = createElement_upvr
    Name_upvr = Name_upvr("UIStroke", {
        Color = arg1.props.color;
        Thickness = 3;
        [Roact_upvr.Ref] = arg1.color_strokeRef;
    })
    module.UIStroke = Name_upvr
    Name_upvr = createElement_upvr
    local tbl_2 = {
        BackgroundTransparency = 1;
    }
    if smallUI then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    tbl_2.Size = UDim2.new(1, 0, 0.5714285714285714, 0)
    tbl_2.Position = UDim2.new(0, 0, 0, 0)
    tbl_2.ZIndex = 2
    local tbl_11 = {}
    local tbl_17 = {
        BackgroundTransparency = 1;
    }
    if smallUI then
        var49 = 0.75
    else
        var49 = 1
    end
    tbl_17.Size = UDim2.new(0.4, 0, var49, 0)
    tbl_17.AnchorPoint = Vector2.new(0.5, 0)
    var49 = 0
    tbl_17.Position = UDim2.new(0.5, 0, var49, 0)
    var49 = 1
    tbl_17.TextColor3 = Color3.new(1, 1, var49)
    tbl_17.TextScaled = true
    tbl_17.Text = arg1.props.speed:map(function(arg1_4) -- Line 208
        return string.format(("%03d"), arg1_4);
    end)
    tbl_17.Font = Enum.Font.Bangers
    tbl_11.Speed = createElement_upvr("TextLabel", tbl_17)
    local tbl_9 = {
        BackgroundTransparency = 1;
    }
    var49 = 0.5
    tbl_9.Size = UDim2.new(0.1, 0, var49, 0)
    tbl_9.AnchorPoint = Vector2.new(0.5, 0)
    var49 = 0.1
    tbl_9.Position = UDim2.new(0.7124999999999999, 0, var49, 0)
    var49 = 1
    tbl_9.TextColor3 = Color3.new(1, 1, var49)
    tbl_9.TextScaled = true
    tbl_9.Text = arg1.props.metric
    tbl_9.Font = Enum.Font.Bangers
    tbl_11.Metric = createElement_upvr("TextLabel", tbl_9)
    if smallUI then
        local tbl_16 = {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
        }
        var49 = 0
        tbl_16.BackgroundColor3 = Color3.new(0, 0, var49)
        var49 = 0.2
        tbl_16.Size = UDim2.new(0.2, 0, var49, 0)
        tbl_16.AnchorPoint = Vector2.new(1, 1)
        var49 = 0.72
        tbl_16.Position = UDim2.new(1, 0, var49, 0)
        var49 = 1
        tbl_16.TextColor3 = Color3.new(1, 1, var49)
        tbl_16.TextScaled = true
        tbl_16.Text = arg1.props.distance:map(function(arg1_5) -- Line 232
            local string_match_result1_3, string_match_result2_3, string_match_result3 = string.match(math.floor(arg1_5 + 0.5), "^([^%d]*%d)(%d*)(.-)$")
            return string.format(("%s mi"), string_match_result1_3..string_match_result2_3:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3)
        end)
        tbl_16.Font = Enum.Font.LuckiestGuy
        tbl_16.TextYAlignment = Enum.TextYAlignment.Bottom
    end
    tbl_11.Amount = createElement_upvr("TextLabel", tbl_16)
    local var83 = not smallUI
    if var83 then
        var83 = createElement_upvr
        local tbl_5 = {
            BackgroundTransparency = 0;
            BorderSizePixel = 0;
        }
        var49 = 0
        tbl_5.BackgroundColor3 = Color3.new(0, 0, var49)
        var49 = 1
        tbl_5.Size = UDim2.new(0.3, 0, var49, 0)
        tbl_5.AnchorPoint = Vector2.new(1, 1)
        var49 = 1
        tbl_5.Position = UDim2.new(1, 0, var49, -6)
        tbl_5.Text = ""
        tbl_5.Visible = arg1.props.hasLicensePlate
        tbl_5[Roact_upvr.Event.MouseButton1Down] = arg1.props.onClickPlate
        local tbl_14 = {}
        var49 = {}
        var49.AspectRatio = 4
        tbl_14.AspectRatio = createElement_upvr("UIAspectRatioConstraint", var49)
        var49 = {}
        var49.BackgroundTransparency = 1
        var49.Size = UDim2.new(0.8, 0, 1, 0)
        var49.AnchorPoint = Vector2.new(0.5, 0)
        var49.Position = UDim2.new(0.5, 0, 0.2, 0)
        var49.TextColor3 = Color3.new(1, 1, 1)
        var49.TextScaled = true
        var49.Text = arg1.props.licensePlate
        var49.Font = Enum.Font.LuckiestGuy
        tbl_14.Title = createElement_upvr("TextLabel", var49)
        var83 = var83("TextButton", tbl_5, tbl_14)
    end
    tbl_11.Plate = var83
    local tbl_6 = {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 1;
        });
    }
    local tbl_10 = {
        BackgroundTransparency = 1;
    }
    local Color3_new_result1 = Color3.new(1, 1, 1)
    tbl_10.ImageColor3 = Color3_new_result1
    if arg1.props.locked then
        Color3_new_result1 = "rbxassetid://5928936980"
    else
        Color3_new_result1 = "rbxassetid://5928936296"
    end
    tbl_10.Image = Color3_new_result1
    tbl_10.Size = UDim2.new(0.6, 0, 0.6, 0)
    tbl_10.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl_10.Position = UDim2.new(0.5, 0, 0.5, 0)
    tbl_6.Icon = createElement_upvr("ImageLabel", tbl_10)
    tbl_11.Lock = createElement_upvr("ImageButton", {
        BackgroundTransparency = 1;
        ImageColor3 = Color3.new(1, 1, 1);
        Image = "rbxassetid://8208059198";
        Size = UDim2.new(0.5, 0, 0.5, 0);
        Position = UDim2.new(0.04, 0, 0.14, 0);
        Visible = arg1.props.lockEnabled;
        [Roact_upvr.Event.MouseButton1Down] = arg1.props.onClickLock;
    }, tbl_6)
    tbl_11.Eject = createElement_upvr("ImageButton", {
        BackgroundTransparency = 1;
        ImageColor3 = Color3.new(1, 1, 1);
        Image = "rbxassetid://8208059198";
        Size = UDim2.new(0.5, 0, 0.5, 0);
        Position = UDim2.new(0.16, 0, 0.14, 0);
        Visible = arg1.props.ejectEnabled;
        [Roact_upvr.Event.MouseButton1Down] = function() -- Line 291
            local var93 = not arg1.state.ejectOpen
            arg1:setState({
                ejectOpen = var93;
            })
            if arg1.props.onClickEject then
                arg1.props.onClickEject(var93)
            end
        end;
    }, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 1;
        });
        Icon = createElement_upvr("ImageLabel", {
            BackgroundTransparency = 1;
            Image = "rbxassetid://8208059624";
            ImageColor3 = Color3.new(1, 1, 1);
            Size = UDim2.new(0.6, 0, 0.6, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Position = UDim2.new(0.5, 0, 0.5, 0);
        });
        List = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            BackgroundColor3 = Color3.new(1, 0, 0);
            Size = UDim2.new(4, 0, 0.8, 0);
            Position = UDim2.new(0.5, 0, -0.8, 0);
            AnchorPoint = Vector2.new(0.5, 1);
            Visible = arg1.props.ejectOpen;
        }, Dictionary_upvr.merge({
            ListLayout = createElement_upvr("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Center;
                VerticalAlignment = Enum.VerticalAlignment.Bottom;
                SortOrder = Enum.SortOrder.LayoutOrder;
                FillDirection = Enum.FillDirection.Vertical;
                Padding = UDim.new(0.2, 0);
            });
        }, tbl_3));
    })
    tbl_11.Missiles = createElement_upvr("TextLabel", {
        BackgroundTransparency = 1;
        Size = UDim2.new(0.25, 0, 0.3, 0);
        AnchorPoint = Vector2.new(0, 1);
        Position = UDim2.new(0.04, 0, 0.96, 0);
        TextColor3 = Color3.new(1, 1, 1);
        TextScaled = true;
        Text = string.format(("%d/%d MISSILES"), arg1.props.missileCount, arg1.props.missileMax);
        Font = Enum.Font.LuckiestGuy;
        Visible = arg1.props.missilesEnabled;
    })
    tbl_11.MissileBuy = createElement_upvr("TextButton", {
        BorderSizePixel = 0;
        BackgroundColor3 = Color3.new(1, 1, 1);
        Size = UDim2.new(1, 0, 0.18, 0);
        AnchorPoint = Vector2.new(0.5, 1);
        Position = UDim2.new(0.15, 0, 1.07, 0);
        ZIndex = 4;
        Text = "";
        Visible = arg1.props.missilesEnabled;
        [Roact_upvr.Event.MouseButton1Down] = arg1.props.onClickMissileBuy;
    }, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 3;
        });
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0.25, 0);
        });
        Title = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Position = UDim2.new(0.5, 0, 0.6, 0);
            TextColor3 = Color3.new(0.2, 0.2, 0.2);
            TextScaled = true;
            Text = "Buy";
            Font = Enum.Font.LuckiestGuy;
            ZIndex = 5;
        });
    })
    Name_upvr = Name_upvr("Frame", tbl_2, tbl_11)
    module.Top = Name_upvr
    Name_upvr = createElement_upvr
    local tbl_7 = {
        BackgroundTransparency = 1;
    }
    if smallUI then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    tbl_7.Size = UDim2.new(1, 0, 0.5714285714285714, 0)
    if smallUI then
    else
    end
    tbl_7.Position = UDim2.new(0, 0, 0.5714285714285714, 0)
    local tbl_12 = {
        Line0 = createElement_upvr("Frame", {
            BorderSizePixel = 0;
            BackgroundColor3 = arg1.props.color;
            Size = UDim2.new(1, 0, 0, 2);
            [Roact_upvr.Ref] = arg1.color_frameRef;
        });
    }
    if not smallUI then
    end
    tbl_12.Line1 = createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundColor3 = arg1.props.color;
        Size = UDim2.new(1, 0, 0, 2);
        Position = UDim2.new(0, 0, 0, -6);
        [Roact_upvr.Ref] = arg1.color_frame2Ref;
    })
    local tbl_15 = {
        BackgroundTransparency = 0;
        BackgroundColor3 = Color3.fromHex("cb342a");
    }
    local var112 = 0.1
    tbl_15.Size = UDim2.new(0.85, 0, var112, 0)
    if smallUI then
        var112 = 0.15
    else
        var112 = 0.47
    end
    tbl_15.Position = UDim2.new(0.5, 0, var112, 0)
    tbl_15.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl_15.Text = ""
    tbl_15.TextScaled = true
    tbl_15.TextColor3 = Color3.new(1, 1, 1)
    tbl_15.TextXAlignment = Enum.TextXAlignment.Right
    tbl_12.HealthBar = createElement_upvr("TextLabel", tbl_15, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(1, 0);
        });
        Inner = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(var47, 0, 1, 0);
            ClipsDescendants = true;
        }, {
            Value = createElement_upvr("Frame", {
                BackgroundTransparency = 0;
                BackgroundColor3 = Color3.new(1, 1, 1);
                Size = UDim2.new(math.min(1 / var47, 2), 0, 1, 0);
            }, {
                UICorner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(1, 0);
                });
                UIGradient = createElement_upvr("UIGradient", {
                    Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(101, 216, 99)), ColorSequenceKeypoint.new(1, Color3.fromRGB(89, 201, 113))});
                    Rotation = 90;
                    Offset = Vector2.new(0, 0);
                });
            });
        });
    })
    local var122 = not smallUI
    if var122 then
        var122 = createElement_upvr
        var122 = var122("TextButton", {
            BackgroundTransparency = 0;
            BackgroundColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(0.85, 0, 0.1, 0);
            Position = UDim2.new(0.5, 0, 0.62, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Text = "";
            [Roact_upvr.Event.MouseButton1Down] = arg1.props.onClickBar;
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(1, 0);
            });
            Inner = createElement_upvr("Frame", {
                BackgroundTransparency = 1;
                Size = arg1.props.barRatio:map(function(arg1_6) -- Line 447
                    return UDim2.new(arg1_6, 0, 1, 0)
                end);
                ClipsDescendants = true;
            }, {
                Value = createElement_upvr("Frame", {
                    BackgroundTransparency = 0;
                    BackgroundColor3 = Color3.new(1, 1, 1);
                    Size = arg1.props.barRatio:map(function(arg1_7) -- Line 455
                        return UDim2.new(math.min(1 / arg1_7, 2), 0, 1, 0)
                    end);
                }, {
                    UICorner = createElement_upvr("UICorner", {
                        CornerRadius = UDim.new(1, 0);
                    });
                    UIGradient = createElement_upvr("UIGradient", {
                        Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(204, 105, 207)), ColorSequenceKeypoint.new(1, Color3.fromRGB(164, 65, 167))});
                        Rotation = 90;
                        Offset = Vector2.new(0, 0);
                    });
                });
            });
        })
    end
    tbl_12.NitroBar = var122
    var122 = not smallUI
    local var135 = var122
    if var135 then
        var135 = createElement_upvr
        var135 = var135("Frame", {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 0.31, 0);
            AnchorPoint = Vector2.new(0, 0.5);
            Position = UDim2.new(0, 0, 0.23, 0);
            ClipsDescendants = true;
        }, Dictionary_upvr.merge({
            ListLayout = createElement_upvr("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Center;
                VerticalAlignment = Enum.VerticalAlignment.Center;
                SortOrder = Enum.SortOrder.LayoutOrder;
                FillDirection = Enum.FillDirection.Horizontal;
                Padding = UDim.new(0, 0);
            });
            Odometer = createElement_upvr("ImageLabel", {
                BackgroundTransparency = 1;
                Image = "rbxassetid://8247002133";
                Size = UDim2.new(1, 0, 1, 0);
                LayoutOrder = 100;
            }, {
                AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                    AspectRatio = 5.875;
                });
                Amount = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(0.8, 0, 0.8, 0);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Position = UDim2.new(0.5, 0, 0.6, 0);
                    TextColor3 = Color3.new(1, 1, 1);
                    TextScaled = true;
                    Text = arg1.props.distance:map(function(arg1_8) -- Line 509
                        local string_match_result1_2, string_match_result2, string_match_result3_3 = string.match(math.floor(arg1_8 + 0.5), "^([^%d]*%d)(%d*)(.-)$")
                        return string.format(("%s mi"), string_match_result1_2..string_match_result2:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3_3)
                    end);
                    Font = Enum.Font.LuckiestGuy;
                });
            });
        }, var67))
    end
    tbl_12.Meter = var135
    Name_upvr = Name_upvr("Frame", tbl_7, tbl_12)
    module.Bottom = Name_upvr
    return createElement_upvr("Frame", module_2, module)
end
function any_extend_result1.willUnmount(arg1) -- Line 520
    arg1.maid:Destroy()
end
return any_extend_result1
