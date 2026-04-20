local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local createElement_upvr = Roact_upvr.createElement
local ClanConsts_upvr = require(ReplicatedStorage.Clan.ClanConsts)
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
local function colorComponent_upvr(arg1) -- Line 15, Named "colorComponent"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var6
    if arg1.selectedColorName ~= arg1.name then
        var6 = false
    else
        var6 = true
    end
    local module = {
        Corner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(1, 0);
        });
    }
    local tbl_2 = {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    }
    if var6 then
    else
    end
    tbl_2.Thickness = 1
    tbl_2.Color = ColorUtils_upvr.brightenBy(arg1.color, -0.3)
    module.Stroke = createElement_upvr("UIStroke", tbl_2)
    local var12 = var6
    if var12 then
        var12 = createElement_upvr
        var12 = var12("TextLabel", {
            BackgroundTransparency = 1;
            Text = "✓";
            Font = Enum.Font.SourceSansBold;
            TextScaled = true;
            TextColor3 = Color3.new(1, 1, 1);
            Size = UDim2.fromScale(1.2, 1.2);
            Position = UDim2.fromScale(0.5, 0.5);
            AnchorPoint = Vector2.new(0.5, 0.5);
        })
    end
    module.Selected = var12
    return createElement_upvr("TextButton", {
        BorderSizePixel = 0;
        BackgroundColor3 = arg1.color;
        Size = arg1.size;
        Position = arg1.position;
        Text = "";
        [Roact_upvr.Event.Activated] = function() -- Line 23
            arg1.setSelectedColorName(arg1.name)
        end;
    }, module)
end
local any_extend_result1 = Roact_upvr.PureComponent:extend("JoinOrCreate")
local PlayerUtils_upvr = require(ReplicatedStorage.Std.PlayerUtils)
function any_extend_result1.init(arg1) -- Line 50
    arg1.playerTextBoxRef = Roact_upvr.createRef()
    function arg1.onClickView() -- Line 53
        local any_getValue_result1 = arg1.playerTextBoxRef:getValue()
        any_getValue_result1.Text = ""
        PlayerUtils_upvr.promiseUserIdFromName(any_getValue_result1.Text):andThen(function(arg1_2) -- Line 57
            arg1.props.attemptViewUserIdClan(arg1_2)
        end)
    end
    function arg1.playerTextBoxFocusLost(arg1_3, arg2) -- Line 61
        if arg2 then
            arg1.onClickView()
        end
    end
    local var21_upvw
    function arg1.playerTextBoxTextChanged(arg1_4) -- Line 67
        if var21_upvw then
            task.cancel(var21_upvw)
            var21_upvw = nil
        end
        local var23_upvw
        var23_upvw = task.delay(0.5, function() -- Line 73
            PlayerUtils_upvr.promiseUserIdFromName(arg1_4.Text):andThen(function(arg1_5) -- Line 76
                if var21_upvw ~= var23_upvw then
                else
                    local tbl = {}
                    tbl.avatarUserId = arg1_5
                    arg1:setState(tbl)
                end
            end):catch(function() -- Line 84
                if var21_upvw ~= var23_upvw then
                else
                    arg1:setState({
                        avatarUserId = Roact_upvr.None;
                    })
                end
            end)
        end)
        var21_upvw = var23_upvw
    end
    arg1.crewNameRef = Roact_upvr.createRef()
    function arg1.onClickCreate() -- Line 98
        local any_getValue_result1_2 = arg1.crewNameRef:getValue()
        any_getValue_result1_2.Text = ""
        arg1.props.attemptCreate(any_getValue_result1_2.Text, arg1.state.selectedColorName)
    end
    function arg1.crewNameTextBoxFocusLost(arg1_6, arg2) -- Line 104
        if arg2 then
            arg1.onClickCreate()
        end
    end
    function arg1.setSelectedColorName(arg1_7) -- Line 109
        local tbl_4 = {}
        tbl_4.selectedColorName = arg1_7
        arg1:setState(tbl_4)
    end
    arg1:setState({
        selectedColorName = ClanConsts_upvr.CLAN_COLORS[math.random(1, #ClanConsts_upvr.CLAN_COLORS)].name;
    })
end
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
local TextButton_upvr = require(script.Parent.TextButton)
local horizontalSquareGrid_upvr = require(ReplicatedStorage.PersistentCrew.UI.horizontalSquareGrid)
local String_upvr = require(ReplicatedStorage.Std.String)
local Dictionary_upvr = require(ReplicatedStorage.Std.Dictionary)
function any_extend_result1.render(arg1) -- Line 119
    local tbl_3 = {}
    for _, v in ClanConsts_upvr.CLAN_COLORS do
        table.insert(tbl_3, v)
    end
    return createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        backgroundColor = Color3.new(1, 1, 1);
        aspectRatio = arg1.props.aspectRatio;
        verticalPaddingRatio = arg1.props.verticalPaddingRatio;
    }, Dictionary_upvr.merge(arg1.props[Roact_upvr.Children], {
        Title = createElement_upvr(PaddedContainer_upvr, {
            backgroundColor = Color3.new(0.2, 0.2, 0.2);
            backgroundTransparency = 0;
            size = UDim2.new(1, 0, 0.16666666666666666, 0);
            paddingLeft = 0;
            paddingRight = 0;
            paddingTop = 0;
            paddingBottom = 0.5;
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0, 8);
            });
            Title = createElement_upvr("Frame", {
                BackgroundTransparency = 1;
                BackgroundColor3 = Color3.new(1, 0, 0);
                Size = UDim2.new(1, 0, 1, 0);
                Position = UDim2.new(0, 0, 0, 0);
            }, {
                Text = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(0.9, 0, 0.9, 0);
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Font = Enum.Font.FredokaOne;
                    Text = "Welcome to CREWS!";
                    LineHeight = 1;
                    TextScaled = true;
                    TextColor3 = Color3.fromRGB(0, 162, 255);
                });
            });
        });
        Body = createElement_upvr(PaddedContainer_upvr, {
            backgroundColor = Color3.new(0.2, 0.2, 0.2);
            backgroundTransparency = 1;
            size = UDim2.new(1, 0, 0.7222222222222223, 0);
            position = UDim2.new(0, 0, 0.16666666666666666, 0);
            paddingLeft = 0;
            paddingRight = 0;
            paddingTop = 0.5;
            paddingBottom = 0.5;
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0, 8);
            });
            Left = createElement_upvr("Frame", {
                BorderSizePixel = 0;
                BackgroundTransparency = 0;
                BackgroundColor3 = Color3.new(0.2, 0.2, 0.2);
                Size = UDim2.new(0.4625, 0, 1, 0);
                Position = UDim2.new(0, 0, 0, 0);
            }, {
                UICorner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 8);
                });
                Container = createElement_upvr(PaddedContainer_upvr, {
                    backgroundTransparency = 1;
                }, {
                    ContainerTitle = createElement_upvr(PaddedContainer_upvr, {
                        backgroundTransparency = 1;
                        size = UDim2.new(1, 0, 0.25, 0);
                        paddingTop = 0;
                        paddingLeft = 0;
                        paddingRight = 0;
                        paddingBottom = 0.5;
                    }, {
                        Title = createElement_upvr("Frame", {
                            BackgroundTransparency = 1;
                            BackgroundColor3 = Color3.new(1, 0, 0);
                            Size = UDim2.new(1, 0, 0.75, 0);
                            Position = UDim2.new(0.5, 0, 1, 0);
                            AnchorPoint = Vector2.new(0.5, 1);
                        }, {
                            Text = createElement_upvr("TextLabel", {
                                BackgroundTransparency = 1;
                                Size = UDim2.new(1, 0, 1, 0);
                                Position = UDim2.new(0.5, 0, 0.5, 0);
                                AnchorPoint = Vector2.new(0.5, 0.5);
                                Font = Enum.Font.Bangers;
                                Text = "VIEW A CREW";
                                LineHeight = 1;
                                TextScaled = true;
                                TextColor3 = Color3.new(1, 1, 1);
                            });
                        });
                    });
                    ContainerBody = createElement_upvr(PaddedContainer_upvr, {
                        backgroundColor = Color3.new(1, 0, 0);
                        backgroundTransparency = 1;
                        size = UDim2.new(1, 0, 0.75, 0);
                        position = UDim2.new(0, 0, 0.25, 0);
                        paddingTop = 0.5;
                        paddingLeft = 0;
                        paddingRight = 0;
                        paddingBottom = 0;
                    }, {
                        UserIdContainer = createElement_upvr("Frame", {
                            BorderSizePixel = 0;
                            BackgroundColor3 = Color3.new(1, 1, 1);
                            Size = UDim2.new(1, 0, 0.15, 0);
                            AnchorPoint = Vector2.new(0.5, 0);
                            Position = UDim2.new(0.5, 0, 0, 0);
                        }, {
                            UICorner = createElement_upvr("UICorner", {
                                CornerRadius = UDim.new(1, 0);
                            });
                            UIAspectRatioConstraint = createElement_upvr("UIAspectRatioConstraint", {
                                AspectRatio = 10;
                            });
                            Input = createElement_upvr("TextBox", {
                                BackgroundTransparency = 1;
                                BackgroundColor3 = Color3.new(1, 0, 1);
                                BorderSizePixel = 0;
                                Size = UDim2.new(0.8, 0, 1, 0);
                                AnchorPoint = Vector2.new(0.5, 0.5);
                                Position = UDim2.new(0.5, 0, 0.5, 0);
                                PlaceholderText = "Username of crew member...";
                                TextColor3 = Color3.new(0, 0, 0);
                                Text = "";
                                Font = Enum.Font.Bangers;
                                TextScaled = true;
                                [Roact_upvr.Ref] = arg1.playerTextBoxRef;
                                [Roact_upvr.Event.FocusLost] = arg1.playerTextBoxFocusLost;
                                [Roact_upvr.Change.Text] = arg1.playerTextBoxTextChanged;
                            });
                        });
                        Center = createElement_upvr("Frame", {
                            BackgroundTransparency = 1;
                            Size = UDim2.new(1, 0, 0.65, 0);
                            Position = UDim2.new(0, 0, 0.15, 0);
                        }, {
                            Avatar = createElement_upvr("ImageLabel", {
                                BorderSizePixel = 0;
                                BackgroundColor3 = Color3.new(1, 0, 0);
                                BackgroundTransparency = 1;
                                Image = "rbxthumb://type=AvatarHeadShot&w=150&h=150&id="..tostring(arg1.state.avatarUserId or 1);
                                Size = UDim2.fromScale(0.9, 0.9);
                                Position = UDim2.new(0.5, 0, 0.5, 0);
                                AnchorPoint = Vector2.new(0.5, 0.5);
                            }, {
                                UIAspectRatioConstraint = createElement_upvr("UIAspectRatioConstraint", {
                                    AspectRatio = 1;
                                    AspectType = Enum.AspectType.FitWithinMaxSize;
                                    DominantAxis = Enum.DominantAxis.Height;
                                });
                                UICorner = createElement_upvr("UICorner", {
                                    CornerRadius = UDim.new(1, 0);
                                });
                            });
                        });
                        RequestButton = createElement_upvr(TextButton_upvr, {
                            size = UDim2.new(1, 0, 0.2, 0);
                            position = UDim2.new(0.5, 0, 1, 0);
                            anchorPoint = Vector2.new(0.5, 1);
                            text = "VIEW";
                            backgroundColor = Color3.fromRGB(88, 172, 246);
                            onClick = arg1.onClickView;
                            disabled = arg1.props.networkMutexLocked;
                        });
                    });
                });
            });
            LineTop = createElement_upvr("Frame", {
                BackgroundColor3 = Color3.new(0.3, 0.3, 0.3);
                BorderSizePixel = 0;
                Size = UDim2.new(0, 1, 0.4375, 0);
                Position = UDim2.new(0.5, 0, 0, 0);
            });
            LineBottom = createElement_upvr("Frame", {
                BackgroundColor3 = Color3.new(0.3, 0.3, 0.3);
                BorderSizePixel = 0;
                Size = UDim2.new(0, 1, 0.4375, 0);
                Position = UDim2.new(0.5, 0, 0.5625, 0);
            });
            OrText = createElement_upvr("TextLabel", {
                Font = Enum.Font.Bangers;
                TextScaled = true;
                BackgroundTransparency = 1;
                Text = "OR";
                TextColor3 = Color3.new(0.3, 0.3, 0.3);
                Size = UDim2.fromScale(0.1125, 0.1125);
                Position = UDim2.fromScale(0.5, 0.5);
                AnchorPoint = Vector2.new(0.5, 0.5);
            });
            Right = createElement_upvr("Frame", {
                BorderSizePixel = 0;
                BackgroundTransparency = 0;
                BackgroundColor3 = Color3.new(0.2, 0.2, 0.2);
                Size = UDim2.new(0.4625, 0, 1, 0);
                Position = UDim2.new(0.5375, 0, 0, 0);
            }, {
                UICorner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 8);
                });
                Container = createElement_upvr(PaddedContainer_upvr, {
                    backgroundTransparency = 1;
                }, {
                    ContainerTitle = createElement_upvr(PaddedContainer_upvr, {
                        backgroundTransparency = 1;
                        size = UDim2.new(1, 0, 0.25, 0);
                        paddingTop = 0;
                        paddingLeft = 0;
                        paddingRight = 0;
                        paddingBottom = 0.5;
                    }, {
                        Title = createElement_upvr("Frame", {
                            BackgroundTransparency = 1;
                            BackgroundColor3 = Color3.new(1, 0, 0);
                            Size = UDim2.new(1, 0, 0.75, 0);
                            Position = UDim2.new(0.5, 0, 1, 0);
                            AnchorPoint = Vector2.new(0.5, 1);
                        }, {
                            Text = createElement_upvr("TextLabel", {
                                BackgroundTransparency = 1;
                                Size = UDim2.new(1, 0, 1, 0);
                                Position = UDim2.new(0.5, 0, 0.5, 0);
                                AnchorPoint = Vector2.new(0.5, 0.5);
                                Font = Enum.Font.Bangers;
                                Text = "CREATE YOUR OWN";
                                LineHeight = 1;
                                TextScaled = true;
                                TextColor3 = Color3.new(1, 1, 1);
                            });
                        });
                    });
                    ContainerBody = createElement_upvr(PaddedContainer_upvr, {
                        backgroundColor = Color3.new(1, 0, 0);
                        backgroundTransparency = 1;
                        size = UDim2.new(1, 0, 0.75, 0);
                        position = UDim2.new(0, 0, 0.25, 0);
                        paddingTop = 0.5;
                        paddingLeft = 0;
                        paddingRight = 0;
                        paddingBottom = 0;
                    }, {
                        Center = createElement_upvr("Frame", {
                            BackgroundColor3 = Color3.new(1, 0, 0);
                            BackgroundTransparency = 1;
                            Size = UDim2.new(1, 0, 0.8, 0);
                        }, {
                            Container = createElement_upvr("Frame", {
                                BackgroundTransparency = 1;
                                Size = UDim2.new(1, 0, 0.2, 0);
                            }, {
                                UserIdContainer = createElement_upvr("Frame", {
                                    BorderSizePixel = 0;
                                    BackgroundColor3 = Color3.new(1, 1, 1);
                                    Size = UDim2.new(1, 0, 1, 0);
                                    AnchorPoint = Vector2.new(0.5, 1);
                                    Position = UDim2.new(0.5, 0, 1, 0);
                                }, {
                                    UICorner = createElement_upvr("UICorner", {
                                        CornerRadius = UDim.new(1, 0);
                                    });
                                    UIAspectRatioConstraint = createElement_upvr("UIAspectRatioConstraint", {
                                        AspectRatio = 10;
                                    });
                                    Input = createElement_upvr("TextBox", {
                                        BackgroundTransparency = 1;
                                        BackgroundColor3 = Color3.new(1, 0, 1);
                                        BorderSizePixel = 0;
                                        Size = UDim2.new(0.8, 0, 1, 0);
                                        AnchorPoint = Vector2.new(0.5, 0.5);
                                        Position = UDim2.new(0.5, 0, 0.5, 0);
                                        PlaceholderText = "Name your crew...";
                                        Text = "";
                                        Font = Enum.Font.Bangers;
                                        TextScaled = true;
                                        TextColor3 = Color3.new(0, 0, 0);
                                        [Roact_upvr.Ref] = arg1.crewNameRef;
                                        [Roact_upvr.Event.FocusLost] = arg1.crewNameTextBoxFocusLost;
                                    });
                                });
                            });
                            Colors = createElement_upvr("Frame", {
                                BackgroundTransparency = 1;
                                Size = UDim2.new(1, 0, 0.5, 0);
                                Position = UDim2.new(0, 0, 0.2, 0);
                            }, {
                                Title = createElement_upvr("Frame", {
                                    BackgroundTransparency = 1;
                                    BackgroundColor3 = Color3.new(1, 0, 0);
                                    Size = UDim2.new(1, 0, 0.5, 0);
                                    Position = UDim2.new(0.5, 0, 0, 0);
                                    AnchorPoint = Vector2.new(0.5, 0);
                                }, {
                                    Text = createElement_upvr("TextLabel", {
                                        BackgroundTransparency = 1;
                                        Size = UDim2.new(1, 0, 0.5, 0);
                                        Position = UDim2.new(0.5, 0, 1, 0);
                                        AnchorPoint = Vector2.new(0.5, 1);
                                        Font = Enum.Font.Bangers;
                                        Text = "CREW COLOR";
                                        LineHeight = 1;
                                        TextScaled = true;
                                        TextColor3 = Color3.new(0.7, 0.7, 0.7);
                                    });
                                });
                                ColorsContainer = createElement_upvr(PaddedContainer_upvr, {
                                    backgroundColor = Color3.new(1, 1, 1);
                                    size = UDim2.fromScale(1, 0.5);
                                    position = UDim2.fromScale(0, 0.5);
                                    paddingLeft = 0;
                                    paddingRight = 0;
                                }, {
                                    Corner = createElement_upvr("UICorner", {
                                        CornerRadius = UDim.new(1, 0);
                                    });
                                    Grid = createElement_upvr(horizontalSquareGrid_upvr, {
                                        exposePaddedContainerProps = true;
                                        component = colorComponent_upvr;
                                        items = tbl_3;
                                        itemMetadata = {
                                            selectedColorName = arg1.state.selectedColorName;
                                            setSelectedColorName = arg1.setSelectedColorName;
                                        };
                                    });
                                });
                            });
                        });
                        CreateButton = createElement_upvr(TextButton_upvr, {
                            size = UDim2.new(1, 0, 0.2, 0);
                            position = UDim2.new(0.5, 0, 1, 0);
                            anchorPoint = Vector2.new(0.5, 1);
                            text = "CREATE for $"..String_upvr.comma(ClanConsts_upvr.CLAN_CREATION_COST);
                            backgroundColor = Color3.fromRGB(116, 229, 156);
                            onClick = arg1.onClickCreate;
                            disabled = arg1.props.networkMutexLocked;
                        });
                    });
                });
            });
        });
        Bottom = createElement_upvr(PaddedContainer_upvr, {
            backgroundColor = Color3.new(0.2, 0.2, 0.2);
            backgroundTransparency = 0;
            size = UDim2.new(1, 0, 0.1111111111111111, 0);
            position = UDim2.new(0, 0, 0.8888888888888888, 0);
            paddingLeft = 0;
            paddingRight = 0;
            paddingTop = 0.5;
            paddingBottom = 0;
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0, 4);
            });
            UIListLayout = createElement_upvr("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal;
                HorizontalAlignment = Enum.HorizontalAlignment.Right;
                SortOrder = Enum.SortOrder.LayoutOrder;
            });
            CloseContainer = createElement_upvr("Frame", {
                BackgroundTransparency = 1;
                Size = UDim2.new(0.15, 0, 1, 0);
                LayoutOrder = 2;
            }, {
                Container = createElement_upvr(PaddedContainer_upvr, {
                    backgroundTransparency = 1;
                    paddingLeft = 0.5;
                    paddingRight = 1;
                }, {
                    Button = createElement_upvr(TextButton_upvr, {
                        size = UDim2.new(1, 0, 1, 0);
                        position = UDim2.new(1, 0, 0, 0);
                        anchorPoint = Vector2.new(1, 0);
                        text = "CLOSE";
                        backgroundColor = Color3.fromRGB(233, 76, 64);
                        onClick = arg1.props.onClickClose;
                    });
                });
            });
        });
    }))
end
return any_extend_result1