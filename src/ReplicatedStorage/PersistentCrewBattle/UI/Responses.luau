local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement_upvr = Roact.createElement
local function avatarComponent_upvr(arg1) -- Line 12, Named "avatarComponent"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var4
    if var4 then
        var4 = arg1.UserId or 1
        local module_2 = {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(1, 0);
            });
            UIStroke = createElement_upvr("UIStroke", {
                Transparency = 0.5;
                Thickness = 1;
                Color = Color3.new(0, 0, 0);
            });
        }
        local IsAdmin = arg1.IsAdmin
        if IsAdmin then
            IsAdmin = createElement_upvr
            IsAdmin = IsAdmin("ImageButton", {
                BackgroundTransparency = 1;
                ZIndex = 3;
                Size = UDim2.fromScale(0.4, 0.4);
                Position = UDim2.fromScale(0.8, 0.8);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Image = "rbxassetid://12385263946";
            })
        end
        module_2.AdminBadge = IsAdmin
        return createElement_upvr("ImageLabel", {
            BorderSizePixel = 0;
            BackgroundTransparency = 0;
            BackgroundColor3 = Color3.new(0.9, 0.9, 0.9);
            Image = "rbxthumb://type=AvatarHeadShot&w=150&h=150&id="..tostring(var4);
            Size = arg1.size;
            Position = arg1.position;
            AnchorPoint = Vector2.new(0, 0);
        }, module_2)
    end
    if arg1.RespondedAt == nil then
        var4 = false
    else
        var4 = true
    end
    local module = {
        BorderSizePixel = 0;
        BackgroundTransparency = 0;
    }
    if var4 then
        local Color3_new_result1_2 = Color3.new(1, 1, 1)
    else
    end
    module.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
    module.Size = arg1.size
    module.Position = arg1.position
    module.ZIndex = arg1.zIndex
    return createElement_upvr("Frame", module, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(1, 0);
        });
        UIStroke = createElement_upvr("UIStroke", {
            Transparency = 0.5;
            Thickness = 1;
            Color = Color3.new(0, 0, 0);
        });
        Q = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Text = '?';
            Font = Enum.Font.FredokaOne;
            TextScaled = true;
            Size = UDim2.fromScale(1, 1);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Position = UDim2.fromScale(0.5, 0.5);
            TextColor3 = Color3.new(0.2, 0.2, 0.2);
        });
    })
end
local any_extend_result1 = Roact.PureComponent:extend("Responses")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 0.3, 0);
    anchorPoint = Vector2.new(0.5, 0.5);
    position = UDim2.new(0.5, 0, 0.5, 0);
    numPlayersPerTeam = 5;
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 81
    arg1.maid = Maid_upvr.new()
    arg1:setState({
        dots = 0;
    })
end
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
local Flag_upvr = require(ReplicatedStorage.PersistentCrew.UI.Flag)
local horizontalSquareGrid_upvr = require(ReplicatedStorage.PersistentCrew.UI.horizontalSquareGrid)
local TextButton_upvr = require(ReplicatedStorage.PersistentCrew.UI.TextButton)
function any_extend_result1.render(arg1) -- Line 87
    local var25 = 0.385 / arg1.props.aspectRatio * 1.5
    local Color3_new_result1 = Color3.new(0.2, 0.2, 0.2)
    local clanColorOurs = arg1.props.clanColorOurs
    local clanColorTheirs = arg1.props.clanColorTheirs
    local var29
    if clanColorTheirs then
        var29 = "rgb(%d, %d, %d)":format(clanColorTheirs.r * 255, clanColorTheirs.g * 255, clanColorTheirs.b * 255)
    else
        var29 = "rgb(255, 255, 255)"
    end
    return createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundTransparency = 0.8;
        BackgroundColor3 = Color3.new(0, 0, 0);
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
    }, {
        UICorners = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = arg1.props.aspectRatio;
        });
        Container = createElement_upvr(PaddedContainer_upvr, {
            backgroundTransparency = 1;
            aspectRatio = arg1.props.aspectRatio;
            verticalPaddingRatio = arg1.props.verticalPaddingRatio;
        }, {
            TitleContainer = createElement_upvr(PaddedContainer_upvr, {
                backgroundTransparency = 0;
                backgroundColor = Color3.new(0.2, 0.2, 0.2);
                size = UDim2.new(1, 0, 0.13, 0);
                paddingTop = 0;
                paddingBottom = 1;
                paddingLeft = 0;
                paddingRight = 0;
            }, {
                UICorner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 4);
                });
                TextContainer = createElement_upvr(PaddedContainer_upvr, {
                    size = UDim2.fromScale(0.5, 1);
                    position = UDim2.fromScale(0.25, 0);
                    backgroundTransparency = 1;
                    paddingTop = 1;
                    paddingBottom = 1;
                    paddingLeft = 1;
                    paddingRight = 1;
                }, {
                    UICorner = createElement_upvr("UICorner", {
                        CornerRadius = UDim.new(0, 4);
                    });
                    Text = createElement_upvr("TextLabel", {
                        BackgroundTransparency = 1;
                        Text = '.':rep(arg1.state.dots - 1).."ASSEMBLING %dv%d BATTLE":format(arg1.props.numPlayersPerTeam, arg1.props.numPlayersPerTeam)..'.':rep(arg1.state.dots - 1);
                        TextColor3 = Color3.new(1, 1, 1);
                        TextScaled = true;
                        Size = UDim2.new(1, 0, 1, 0);
                        Font = Enum.Font.Bangers;
                        TextXAlignment = Enum.TextXAlignment.Center;
                    });
                });
                CrewTitleAContainer = createElement_upvr(PaddedContainer_upvr, {
                    size = UDim2.fromScale(0.5, 1);
                    position = UDim2.fromScale(0, 0);
                    backgroundTransparency = 1;
                    paddingTop = 1;
                    paddingBottom = 1;
                    paddingLeft = 1;
                    paddingRight = 1;
                }, {
                    UICorner = createElement_upvr("UICorner", {
                        CornerRadius = UDim.new(0, 4);
                    });
                    Text = createElement_upvr("TextLabel", {
                        BackgroundTransparency = 1;
                        Text = "<font color=\"".."rgb(%d, %d, %d)":format(clanColorOurs.r * 255, clanColorOurs.g * 255, clanColorOurs.b * 255).."\">%s</font>":format(arg1.props.clanNameOurs);
                        RichText = true;
                        TextColor3 = Color3.new(1, 1, 1);
                        TextScaled = true;
                        Size = UDim2.new(1, 0, 1, 0);
                        Font = Enum.Font.Bangers;
                        TextXAlignment = Enum.TextXAlignment.Left;
                    });
                });
                CrewTitleBContainer = createElement_upvr(PaddedContainer_upvr, {
                    size = UDim2.fromScale(0.5, 1);
                    position = UDim2.fromScale(0.5, 0);
                    backgroundTransparency = 1;
                    paddingTop = 1;
                    paddingBottom = 1;
                    paddingLeft = 1;
                    paddingRight = 1;
                }, {
                    UICorner = createElement_upvr("UICorner", {
                        CornerRadius = UDim.new(0, 4);
                    });
                    Text = createElement_upvr("TextLabel", {
                        BackgroundTransparency = 1;
                        Text = "<font color=\""..var29.."\">%s</font>":format(arg1.props.clanNameTheirs or "");
                        RichText = true;
                        TextColor3 = Color3.new(1, 1, 1);
                        TextScaled = true;
                        Size = UDim2.new(1, 0, 1, 0);
                        Font = Enum.Font.Bangers;
                        TextXAlignment = Enum.TextXAlignment.Right;
                    });
                });
            });
            ClanAFlag = createElement_upvr(PaddedContainer_upvr, {
                backgroundTransparency = 0;
                backgroundColor = Color3_new_result1;
                size = UDim2.new(var25, 0, 0.385, 0);
                position = UDim2.new(0, 0, 0.13, 0);
                paddingTop = 0;
                paddingBottom = 0.5;
                paddingLeft = 0;
                paddingRight = 0.5;
            }, {
                UICorner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 4);
                });
                Inner = createElement_upvr(PaddedContainer_upvr, {
                    backgroundTransparency = 1;
                }, {
                    Flag = createElement_upvr(Flag_upvr, {
                        flagColor = clanColorOurs;
                        userId = arg1.props.clanOwnerOurs;
                    });
                });
            });
            ClanA = createElement_upvr(PaddedContainer_upvr, {
                backgroundColor = Color3_new_result1;
                size = UDim2.new(1 - var25, 0, 0.385, 0);
                position = UDim2.new(var25, 0, 0.13, 0);
                paddingTop = 0;
                paddingBottom = 0.5;
                paddingLeft = 0.5;
                paddingRight = 0;
            }, {
                UICorner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 4);
                });
                Grid = createElement_upvr(horizontalSquareGrid_upvr, {
                    exposePaddedContainerProps = true;
                    component = avatarComponent_upvr;
                    items = arg1.props.clanMembersOurs;
                    numItems = arg1.props.numPlayersPerTeam;
                });
            });
            ClanBFlag = createElement_upvr(PaddedContainer_upvr, {
                backgroundColor = Color3_new_result1;
                size = UDim2.new(var25, 0, 0.385, 0);
                position = UDim2.new(0, 0, 0.515, 0);
                paddingTop = 0.5;
                paddingBottom = 0;
                paddingLeft = 0;
                paddingRight = 0.5;
            }, {
                UICorner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 4);
                });
                Inner = createElement_upvr(PaddedContainer_upvr, {
                    backgroundTransparency = 1;
                }, {
                    Flag = createElement_upvr(Flag_upvr, {
                        flagColor = clanColorTheirs;
                        userId = arg1.props.clanOwnerTheirs;
                    });
                });
            });
            ClanB = createElement_upvr(PaddedContainer_upvr, {
                backgroundColor = Color3_new_result1;
                size = UDim2.new(1 - var25, 0, 0.385, 0);
                position = UDim2.new(var25, 0, 0.515, 0);
                paddingTop = 0.5;
                paddingBottom = 0;
                paddingLeft = 0.5;
                paddingRight = 0;
            }, {
                UICorner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 4);
                });
                Grid = createElement_upvr(horizontalSquareGrid_upvr, {
                    exposePaddedContainerProps = true;
                    component = avatarComponent_upvr;
                    items = arg1.props.clanMembersTheirs;
                    numItems = arg1.props.numPlayersPerTeam;
                });
            });
            FooterContainer = createElement_upvr(PaddedContainer_upvr, {
                backgroundTransparency = 1;
                backgroundColor = Color3.new(0.2, 0.2, 0.2);
                size = UDim2.new(1, 0, 0.1, 0);
                position = UDim2.fromScale(0, 0.9);
                paddingTop = 1;
                paddingBottom = 0;
                paddingLeft = 0;
                paddingRight = 0;
            }, {
                UICorner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 4);
                });
                UnacceptMatchmaking = createElement_upvr(TextButton_upvr, {
                    text = "UNACCEPT BATTLE";
                    backgroundColor = Color3.fromRGB(255, 58, 43);
                    size = UDim2.fromScale(1, 1);
                    cornerRadius = 4;
                    onClick = arg1.props.onUnAcceptBattleInvite;
                });
            });
        });
    })
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function any_extend_result1.didMount(arg1) -- Line 349
    arg1.maid:GiveTask(Interval_upvr.every(0.5):Connect(function() -- Line 350
        arg1:setState({
            dots = arg1.state.dots % 4 + 1;
        })
    end))
end
function any_extend_result1.willUnmount(arg1) -- Line 356
    arg1.maid:DoCleaning()
end
return any_extend_result1