local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("SafesInventory")
local createElement_upvr = Roact.createElement
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
local topBarButtonsComponent_upvr = require(script.Parent.topBarButtonsComponent)
local paddedScrollingGrid_upvr = require(script.Parent.paddedScrollingGrid)
local SafeComponent_upvr = require(script.Parent.SafeComponent)
function any_extend_result1.render(arg1) -- Line 12
    local Color3_new_result1 = Color3.new(0.2, 0.2, 0.2)
    return createElement_upvr("Frame", {
        BackgroundTransparency = 0.8;
        BackgroundColor3 = Color3.new(0, 0, 0);
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
    }, {
        Container = createElement_upvr(PaddedContainer_upvr, {
            backgroundTransparency = 1;
            aspectRatio = 1.8;
            verticalPaddingRatio = 128;
        }, {
            TopBar = createElement_upvr(PaddedContainer_upvr, {
                backgroundColor = Color3_new_result1;
                paddingTop = 0;
                paddingLeft = 0;
                paddingRight = 0;
                paddingBottom = 0.5;
                size = UDim2.new(1, 0, 0.1, 0);
            }, {
                UICorner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 4);
                });
                Inner = createElement_upvr(PaddedContainer_upvr, {
                    backgroundTransparency = 1;
                }, {
                    Title = createElement_upvr("Frame", {
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        BackgroundColor3 = Color3.new(1, 0, 0);
                        Size = UDim2.new(0.5, 0, 1, 0);
                        Position = UDim2.new(0, 0, 0, 0);
                    }, {
                        Text = createElement_upvr("TextLabel", {
                            BackgroundTransparency = 1;
                            Size = UDim2.new(1, 0, 1.25, 0);
                            Position = UDim2.new(0.5, 0, 0.5, 0);
                            AnchorPoint = Vector2.new(0.5, 0.5);
                            Text = "MY SAFES";
                            TextXAlignment = Enum.TextXAlignment.Left;
                            Font = Enum.Font.Bangers;
                            LineHeight = 1;
                            TextScaled = true;
                            TextColor3 = Color3.new(1, 1, 1);
                        });
                    });
                    Buttons = createElement_upvr(topBarButtonsComponent_upvr, {
                        exposePaddedContainerProps = true;
                        nextPageTitle = "BUY SAFES";
                        onSelectToggle = arg1.props.onSelectBuySafes;
                        onSelectExit = arg1.props.onSelectExit;
                    });
                });
            });
            Left = createElement_upvr(PaddedContainer_upvr, {
                backgroundColor = Color3_new_result1;
                paddingTop = 0.5;
                paddingLeft = 0;
                paddingRight = 0.5;
                paddingBottom = 0;
                size = UDim2.new(0.12, 0, 0.9, 0);
                position = UDim2.new(0, 0, 0.1, 0);
            }, {
                UICorner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 4);
                });
                Icons = createElement_upvr(paddedScrollingGrid_upvr, {
                    exposePaddedContainerProps = true;
                    paddingRatio = 32;
                    rowsPerPage = 4.5;
                    colsPerRow = 1;
                    component = SafeComponent_upvr;
                    items = arg1.props.sidebarItems;
                    metadata = arg1.props.sidebarItemMetadata;
                });
            });
            Body = createElement_upvr(PaddedContainer_upvr, {
                backgroundColor = Color3_new_result1;
                paddingTop = 0.5;
                paddingLeft = 0.5;
                paddingRight = 0.5;
                paddingBottom = 0;
                size = UDim2.new(0.88, 0, 0.9, 0);
                position = UDim2.new(0.12, 0, 0.1, 0);
            }, {
                UICorner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 4);
                });
                Icons = createElement_upvr(paddedScrollingGrid_upvr, {
                    exposePaddedContainerProps = true;
                    paddingRatio = 32;
                    rowsPerPage = 3.5;
                    colsPerRow = 6;
                    component = SafeComponent_upvr;
                    items = arg1.props.items;
                    metadata = arg1.props.itemMetadata;
                });
            });
        });
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 1.8;
        });
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
    })
end
return any_extend_result1