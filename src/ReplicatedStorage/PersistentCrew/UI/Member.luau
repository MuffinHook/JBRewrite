local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("Member")
function any_extend_result1.init(arg1) -- Line 7
    arg1:setState({
        settingsOpen = false;
    })
    function arg1.toggleSettings() -- Line 12
        arg1:setState({
            settingsOpen = not arg1.state.settingsOpen;
        })
    end
end
local createElement_upvr = Roact_upvr.createElement
local PersistentCrewBattleUtils_upvr = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleUtils)
function any_extend_result1.render(arg1) -- Line 18
    local index = arg1.props.index
    local aspectRatio = arg1.props.aspectRatio
    local paddingRatio = arg1.props.paddingRatio
    local module = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
    }
    local tbl_15 = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(1, 0);
        });
    }
    local tbl_6 = {
        Transparency = 0.5;
        Thickness = 2;
    }
    local var19
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var19 = Color3.fromRGB(80, 163, 97)
        return var19
    end
    if not arg1.props.isOnline or not decompInlinedCondition() then
        var19 = Color3.new(1, 1, 1)
    end
    tbl_6.Color = var19
    tbl_15.UIStroke = createElement_upvr("UIStroke", tbl_6)
    local isAdmin = arg1.props.isAdmin
    if isAdmin then
        isAdmin = createElement_upvr
        local tbl_10 = {}
        var19 = 1
        tbl_10.BackgroundTransparency = var19
        var19 = UDim2.fromScale(0.5, 0.5)
        tbl_10.Size = var19
        var19 = UDim2.fromScale(0.8, 0.8)
        tbl_10.Position = var19
        var19 = Vector2.new(0.5, 0.5)
        tbl_10.AnchorPoint = var19
        var19 = "rbxassetid://12385263946"
        tbl_10.Image = var19
        isAdmin = isAdmin("ImageButton", tbl_10)
    end
    tbl_15.AdminBadge = isAdmin
    module.Avatar = createElement_upvr("ImageLabel", {
        BorderSizePixel = 0;
        BackgroundColor3 = Color3.new(0, 1, 0);
        BackgroundTransparency = 1;
        Image = "rbxthumb://type=AvatarHeadShot&w=150&h=150&id="..tostring(arg1.props.userId);
        Size = UDim2.fromScale(1 / aspectRatio - 2 * paddingRatio / aspectRatio, 1 - 2 * paddingRatio);
        Position = UDim2.fromScale(paddingRatio / aspectRatio, 1 * paddingRatio);
        AnchorPoint = Vector2.new(0, 0);
    }, tbl_15)
    local tbl_8 = {
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        BackgroundColor3 = Color3.new(1, 0, 0);
    }
    var19 = 1 * paddingRatio
    var19 = 0
    tbl_8.Size = UDim2.new(0.7 - 1 / aspectRatio - var19 / aspectRatio, 0, 1, var19)
    var19 = 1 * paddingRatio
    var19 = 0
    tbl_8.Position = UDim2.new(1 / aspectRatio + var19 / aspectRatio, 0, 0, var19)
    local tbl_9 = {}
    local tbl_22 = {}
    var19 = 1
    tbl_22.BackgroundTransparency = var19
    var19 = UDim2.new(1, 0, 0.8, 0)
    tbl_22.Size = var19
    var19 = UDim2.new(0.5, 0, 0.5, 0)
    tbl_22.Position = var19
    var19 = Vector2.new(0.5, 0.5)
    tbl_22.AnchorPoint = var19
    var19 = arg1.props
    var19 = var19.displayName
    tbl_22.Text = var19
    var19 = Enum.TextXAlignment.Left
    tbl_22.TextXAlignment = var19
    var19 = Enum.Font.Bangers
    tbl_22.Font = var19
    var19 = 1
    tbl_22.LineHeight = var19
    var19 = true
    tbl_22.TextScaled = var19
    var19 = Color3.new(1, 1, 1)
    tbl_22.TextColor3 = var19
    tbl_9.Text = createElement_upvr("TextLabel", tbl_22)
    module.Title = createElement_upvr("Frame", tbl_8, tbl_9)
    local tbl_16 = {
        BackgroundTransparency = 1;
    }
    var19 = 0
    tbl_16.Size = UDim2.new(2 / aspectRatio, 0, 1, var19)
    var19 = 0
    tbl_16.Position = UDim2.new(1 - 4 / aspectRatio - paddingRatio / aspectRatio, 0, 0, var19)
    local tbl_13 = {}
    local tbl_17 = {}
    var19 = Enum.FillDirection.Horizontal
    tbl_17.FillDirection = var19
    var19 = Enum.HorizontalAlignment.Right
    tbl_17.HorizontalAlignment = var19
    var19 = Enum.SortOrder.LayoutOrder
    tbl_17.SortOrder = var19
    tbl_13.UIListLayout = createElement_upvr("UIListLayout", tbl_17)
    local showRequestAccept = arg1.props.showRequestAccept
    if showRequestAccept then
        showRequestAccept = createElement_upvr
        local tbl_23 = {}
        var19 = 1
        tbl_23.BackgroundTransparency = var19
        var19 = UDim2.new(0.5, 0, 1, 0)
        tbl_23.Size = var19
        var19 = 5
        tbl_23.LayoutOrder = var19
        var19 = {}
        local tbl_24 = {
            BackgroundTransparency = 1;
            Size = UDim2.fromScale(0.9, 0.9);
            Position = UDim2.fromScale(0.5, 0.5);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Image = "rbxassetid://12385251660";
        }
        local Activated_2 = Roact_upvr.Event.Activated
        tbl_24[Activated_2] = arg1.props.uncurryPropsIndex(arg1.props.onClickJoinRequestAccept, index)
        if arg1.props.networkMutexLocked then
            Activated_2 = Color3.new(0.5, 0.5, 0.5)
        else
            Activated_2 = Color3.new(1, 1, 1)
        end
        tbl_24.ImageColor3 = Activated_2
        var19.Button = createElement_upvr("ImageButton", tbl_24, {
            AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 1;
            });
        })
        showRequestAccept = showRequestAccept("Frame", tbl_23, var19)
    end
    tbl_13.JoinRequestAcceptContainer = showRequestAccept
    local showRequestDeny = arg1.props.showRequestDeny
    if showRequestDeny then
        showRequestDeny = createElement_upvr
        local tbl_4 = {}
        var19 = 1
        tbl_4.BackgroundTransparency = var19
        var19 = UDim2.new(0.5, 0, 1, 0)
        tbl_4.Size = var19
        var19 = 10
        tbl_4.LayoutOrder = var19
        var19 = {}
        local tbl_18 = {
            BackgroundTransparency = 1;
            Size = UDim2.fromScale(0.9, 0.9);
            Position = UDim2.fromScale(0.5, 0.5);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Image = "rbxassetid://12385265200";
        }
        local Activated_3 = Roact_upvr.Event.Activated
        tbl_18[Activated_3] = arg1.props.uncurryPropsIndex(arg1.props.onClickJoinRequestDeny, index)
        if arg1.props.networkMutexLocked then
            Activated_3 = Color3.new(0.5, 0.5, 0.5)
        else
            Activated_3 = Color3.new(1, 1, 1)
        end
        tbl_18.ImageColor3 = Activated_3
        var19.Button = createElement_upvr("ImageButton", tbl_18, {
            AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 1;
            });
        })
        showRequestDeny = showRequestDeny("Frame", tbl_4, var19)
    end
    tbl_13.JoinRequestDenyContainer = showRequestDeny
    local showKick = arg1.props.showKick
    if showKick then
        showKick = createElement_upvr
        local tbl_19 = {}
        var19 = 1
        tbl_19.BackgroundTransparency = var19
        var19 = UDim2.new(0.5, 0, 1, 0)
        tbl_19.Size = var19
        var19 = 10
        tbl_19.LayoutOrder = var19
        var19 = {}
        local tbl_14 = {
            BackgroundTransparency = 1;
            Size = UDim2.fromScale(0.9, 0.9);
            Position = UDim2.fromScale(0.5, 0.5);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Image = "rbxassetid://12385265200";
        }
        local Activated_4 = Roact_upvr.Event.Activated
        tbl_14[Activated_4] = arg1.props.uncurryPropsIndex(arg1.props.onClickKick, index)
        if arg1.props.networkMutexLocked then
            Activated_4 = Color3.new(0.5, 0.5, 0.5)
        else
            Activated_4 = Color3.new(1, 1, 1)
        end
        tbl_14.ImageColor3 = Activated_4
        var19.Button = createElement_upvr("ImageButton", tbl_14, {
            AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 1;
            });
        })
        showKick = showKick("Frame", tbl_19, var19)
    end
    tbl_13.KickContainer = showKick
    local showAdmin = arg1.props.showAdmin
    if showAdmin then
        showAdmin = createElement_upvr
        local tbl_21 = {}
        var19 = 1
        tbl_21.BackgroundTransparency = var19
        var19 = UDim2.new(0.5, 0, 1, 0)
        tbl_21.Size = var19
        var19 = 5
        tbl_21.LayoutOrder = var19
        var19 = {}
        local tbl_11 = {
            BackgroundTransparency = 1;
            Size = UDim2.fromScale(0.9, 0.9);
            Position = UDim2.fromScale(0.5, 0.5);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Image = "rbxassetid://12385263946";
        }
        local Activated = Roact_upvr.Event.Activated
        tbl_11[Activated] = arg1.props.uncurryPropsIndex(arg1.props.onClickAdmin, index)
        if arg1.props.networkMutexLocked then
            Activated = Color3.new(0.5, 0.5, 0.5)
        else
            Activated = Color3.new(1, 1, 1)
        end
        tbl_11.ImageColor3 = Activated
        var19.Button = createElement_upvr("ImageButton", tbl_11, {
            AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 1;
            });
        })
        showAdmin = showAdmin("Frame", tbl_21, var19)
    end
    tbl_13.AdminContainer = showAdmin
    local showUnAdmin = arg1.props.showUnAdmin
    if showUnAdmin then
        showUnAdmin = createElement_upvr
        local tbl_12 = {}
        var19 = 1
        tbl_12.BackgroundTransparency = var19
        var19 = UDim2.new(0.5, 0, 1, 0)
        tbl_12.Size = var19
        var19 = 5
        tbl_12.LayoutOrder = var19
        var19 = {}
        local tbl = {
            BackgroundTransparency = 1;
            Size = UDim2.fromScale(0.9, 0.9);
            Position = UDim2.fromScale(0.5, 0.5);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Image = "rbxassetid://12600006139";
        }
        local Activated_5 = Roact_upvr.Event.Activated
        tbl[Activated_5] = arg1.props.uncurryPropsIndex(arg1.props.onClickUnAdmin, index)
        if arg1.props.networkMutexLocked then
            Activated_5 = Color3.new(0.5, 0.5, 0.5)
        else
            Activated_5 = Color3.new(1, 1, 1)
        end
        tbl.ImageColor3 = Activated_5
        var19.Button = createElement_upvr("ImageButton", tbl, {
            AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 1;
            });
        })
        showUnAdmin = showUnAdmin("Frame", tbl_12, var19)
    end
    tbl_13.UnAdminContainer = showUnAdmin
    module.Middle = createElement_upvr("Frame", tbl_16, tbl_13)
    local var58 = not arg1.props.showRequests
    if var58 then
        var58 = createElement_upvr
        local tbl_7 = {
            BackgroundTransparency = 1;
        }
        var19 = 0
        tbl_7.Size = UDim2.new(2 / aspectRatio, 0, 1, var19)
        var19 = 0
        tbl_7.Position = UDim2.new(1 - 2 / aspectRatio, 0, 0, var19)
        local tbl_5 = {}
        local tbl_20 = {}
        var19 = 0.5
        tbl_20.Transparency = var19
        var19 = 1
        tbl_20.Thickness = var19
        var19 = Color3.new(1, 1, 1)
        tbl_20.Color = var19
        tbl_5.UIStroke = createElement_upvr("UIStroke", tbl_20)
        local tbl_2 = {}
        var19 = UDim.new(0, 4)
        tbl_2.CornerRadius = var19
        tbl_5.UICorner = createElement_upvr("UICorner", tbl_2)
        local tbl_3 = {}
        var19 = 1
        tbl_3.BackgroundTransparency = var19
        var19 = UDim2.new(1, 0, 1, 0)
        tbl_3.Size = var19
        var19 = {}
        var19.Left = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(0.5, 0, 1, 0);
        }, {
            Title = createElement_upvr("Frame", {
                BackgroundTransparency = 1;
                BackgroundColor3 = Color3.new(1, 0, 0);
                Size = UDim2.new(1, 0, 0.4, 0);
                Position = UDim2.new(0, 0, 0, 0);
            }, {
                Text = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(0.9, 0, 0.8, 0);
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Text = "Battles";
                    Font = Enum.Font.FredokaOne;
                    LineHeight = 1;
                    TextScaled = true;
                    TextColor3 = Color3.new(1, 1, 1);
                });
            });
            Value = createElement_upvr("Frame", {
                BackgroundTransparency = 1;
                BackgroundColor3 = Color3.new(1, 0, 0);
                Size = UDim2.new(1, 0, 0.6, 0);
                Position = UDim2.new(0, 0, 0.4, 0);
            }, {
                Text = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(0.9, 0, 0.8, 0);
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Text = tostring(arg1.props.battlesPlayed or 0);
                    Font = Enum.Font.FredokaOne;
                    LineHeight = 1;
                    TextScaled = true;
                    TextColor3 = Color3.new(1, 1, 1);
                });
            });
        })
        var19.Line = createElement_upvr("Frame", {
            BorderSizePixel = 0;
            Size = UDim2.new(0, 1, 1, 0);
            Position = UDim2.new(0.5, 0, 0, 0);
            BackgroundColor3 = Color3.new(1, 1, 1);
            BackgroundTransparency = 0.5;
        })
        var19.Right = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(0.5, 0, 1, 0);
            Position = UDim2.new(0.5, 0, 0, 0);
        }, {
            Title = createElement_upvr("Frame", {
                BackgroundTransparency = 1;
                BackgroundColor3 = Color3.new(1, 0, 0);
                Size = UDim2.new(1, 0, 0.4, 0);
                Position = UDim2.new(0, 0, 0, 0);
            }, {
                Text = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(0.9, 0, 0.8, 0);
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Text = "W/L";
                    Font = Enum.Font.FredokaOne;
                    LineHeight = 1;
                    TextScaled = true;
                    TextColor3 = Color3.new(1, 1, 1);
                });
            });
            Value = createElement_upvr("Frame", {
                BackgroundTransparency = 1;
                BackgroundColor3 = Color3.new(1, 0, 0);
                Size = UDim2.new(1, 0, 0.6, 0);
                Position = UDim2.new(0, 0, 0.4, 0);
            }, {
                Text = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(0.9, 0, 0.8, 0);
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Text = PersistentCrewBattleUtils_upvr.calculateWLRatio(arg1.props.battlesWon, arg1.props.battlesPlayed) or "...";
                    Font = Enum.Font.FredokaOne;
                    LineHeight = 1;
                    TextScaled = true;
                    TextColor3 = Color3.new(1, 1, 1);
                });
            });
        })
        tbl_5.Info = createElement_upvr("Frame", tbl_3, var19)
        var58 = var58("Frame", tbl_7, tbl_5)
    end
    module.Right = var58
    return createElement_upvr("Frame", {
        BackgroundTransparency = 0.5;
        BorderSizePixel = 0;
        BackgroundColor3 = Color3.fromRGB(62, 65, 78);
        Size = arg1.props.size;
        Position = arg1.props.position;
    }, module)
end
return any_extend_result1