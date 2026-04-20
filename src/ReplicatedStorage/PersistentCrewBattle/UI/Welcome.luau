local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("Welcome")
local createElement_upvr = Roact.createElement
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
local PersistentCrewBattleConsts_upvr = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local TextButton_upvr = require(ReplicatedStorage.PersistentCrew.UI.TextButton)
function any_extend_result1.render(arg1) -- Line 11
    return createElement_upvr("Frame", {
        BackgroundTransparency = 0.8;
        BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Size = UDim2.new(0.36363636363636365, 0, 1, 0);
        Position = UDim2.fromScale(0.5, 0.5);
        AnchorPoint = Vector2.new(0.5, 0.5);
    }, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 1.7777777777777777;
        });
        UICorners = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        ContainerMessage = createElement_upvr(PaddedContainer_upvr, {
            backgroundTransparency = 1;
            verticalPaddingRatio = 96;
            aspectRatio = 1.7777777777777777;
        }, {
            Topbar = createElement_upvr(PaddedContainer_upvr, {
                backgroundTransparency = 0;
                backgroundColor = Color3.new(0.2, 0.2, 0.2);
                size = UDim2.new(1, 0, 0.25, 0);
                paddingTop = 0;
                paddingLeft = 0;
                paddingRight = 0;
                paddingBottom = 0.5;
                zIndex = 2;
            }, {
                UICorners = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 4);
                });
                Icon = createElement_upvr("ImageLabel", {
                    BackgroundTransparency = 1;
                    Image = "rbxassetid://12598895668";
                    Size = UDim2.new(1, 0, 1.3, 0);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Position = UDim2.fromScale(0, 0.5);
                    ZIndex = 3;
                }, {
                    UIAspectRatioConstraint = createElement_upvr("UIAspectRatioConstraint", {
                        AspectRatio = 2;
                    });
                });
                TitleContainer = createElement_upvr(PaddedContainer_upvr, {
                    backgroundTransparency = 1;
                    size = UDim2.new(0.5, 0, 1, 0);
                    position = UDim2.new(0.15, 0, 0, 0);
                    paddingLeft = 2;
                    paddingRight = 2;
                    paddingTop = 2;
                    paddingBottom = 2;
                }, {
                    Text = createElement_upvr("TextLabel", {
                        BackgroundTransparency = 1;
                        Size = UDim2.new(1, 0, 1, 0);
                        Position = UDim2.new(0.5, 0, 0.5, 0);
                        AnchorPoint = Vector2.new(0.5, 0.5);
                        Font = Enum.Font.FredokaOne;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        Text = "Welcome!";
                        LineHeight = 1;
                        TextScaled = true;
                        TextColor3 = Color3.new(1, 1, 1);
                    });
                });
            });
            Body = createElement_upvr(PaddedContainer_upvr, {
                backgroundTransparency = 0;
                backgroundColor = Color3.new(0.2, 0.2, 0.2);
                size = UDim2.new(1, 0, 0.6, 0);
                position = UDim2.new(0, 0, 0.25, 0);
                paddingTop = 0.5;
                paddingLeft = 0;
                paddingRight = 0;
                paddingBottom = 0.5;
            }, {
                UICorners = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 4);
                });
                BodyContainer = createElement_upvr(PaddedContainer_upvr, {
                    backgroundTransparency = 1;
                    size = UDim2.new(1, 0, 1, 0);
                    position = UDim2.new(0, 0, 0, 0);
                    paddingLeft = 2;
                    paddingRight = 2;
                    paddingTop = 2;
                    paddingBottom = 2;
                }, {
                    Text = createElement_upvr("TextLabel", {
                        BackgroundTransparency = 1;
                        Size = UDim2.new(1, 0, 1, 0);
                        Position = UDim2.new(0.5, 0, 0.5, 0);
                        AnchorPoint = Vector2.new(0.5, 0.5);
                        Font = Enum.Font.FredokaOne;
                        TextYAlignment = Enum.TextYAlignment.Top;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        RichText = true;
                        Text = " - One crew becomes <font color=\"rgb(252, 40, 47)\">CRIMINALS</font>, the other <font color=\"rgb(42, 204, 255)\">POLICE</font>.\n- <font color=\"rgb(252, 40, 47)\">CRIMINALS</font>, rob <u>%d</u> of the <u>%d</u> locations listed!\n- <font color=\"rgb(42, 204, 255)\">POLICE</font>, slow them down!\n- Arrests & deaths count as <u>time penalties</u>.\n- Teams switch next round.\n- The quickest crew to speedrun will claim victory & climb the ranks!":format(PersistentCrewBattleConsts_upvr.NUM_ROBBERIES_TO_FINISH_ROUND, PersistentCrewBattleConsts_upvr.NUM_ROBBERIES_AVAILABLE);
                        LineHeight = 1;
                        TextScaled = true;
                        TextColor3 = Color3.new(1, 1, 1);
                    });
                });
            });
            Footer = createElement_upvr(PaddedContainer_upvr, {
                backgroundTransparency = 0;
                backgroundColor = Color3.new(0.2, 0.2, 0.2);
                position = UDim2.new(0, 0, 0.85, 0);
                size = UDim2.new(1, 0, 0.15, 0);
                paddingTop = 0.5;
                paddingLeft = 0;
                paddingRight = 0;
                paddingBottom = 0;
            }, {
                UICorners = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 4);
                });
                UIListLayout = createElement_upvr("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalAlignment = Enum.HorizontalAlignment.Right;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                });
                CloseContainer = createElement_upvr("Frame", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(0.2, 0, 1, 0);
                    LayoutOrder = 10;
                }, {
                    Container = createElement_upvr(PaddedContainer_upvr, {
                        backgroundTransparency = 1;
                    }, {
                        Button = createElement_upvr(TextButton_upvr, {
                            size = UDim2.new(1, 0, 1, 0);
                            position = UDim2.new(1, 0, 0, 0);
                            anchorPoint = Vector2.new(1, 0);
                            text = "READY";
                            backgroundColor = Color3.fromRGB(88, 172, 246);
                            onClick = arg1.props.onClickClose;
                        });
                    });
                });
            });
        });
    })
end
return any_extend_result1