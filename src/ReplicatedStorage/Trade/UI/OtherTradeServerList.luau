local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("OtherTradeServerList")
any_extend_result1.defaultProps = {
    verticalPaddingRatio = 96;
    aspectRatio = 1.7777777777777777;
}
local createElement_upvr = Roact_upvr.createElement
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
local store_upvr = require(ReplicatedStorage.App.store)
local paddedScrollingGrid_upvr = require(ReplicatedStorage.EzUi.paddedScrollingGrid)
local OtherTradeServerItem_upvr = require(script.Parent.OtherTradeServerItem)
function any_extend_result1.render(arg1) -- Line 15
    if not arg1.props.visible then return end
    local tbl = {}
    if not arg1.props.otherTradeServerInfo then return end
    local clone = table.clone(arg1.props.otherTradeServerInfo)
    table.sort(clone, function(arg1_2, arg2) -- Line 28
        local var13
        if #arg1_2.userIds >= #arg2.userIds then
            var13 = false
        else
            var13 = true
        end
        return var13
    end)
    tbl.Header = createElement_upvr(PaddedContainer_upvr, {
        backgroundColor = Color3.fromRGB(57, 58, 65);
        backgroundTransparency = 0;
        size = UDim2.new(1, 0, 0.15, 0);
        paddingTop = 0;
        paddingBottom = 0.5;
        paddingLeft = 0;
        paddingRight = 0;
    }, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 6);
        });
        TitleContainer = createElement_upvr(PaddedContainer_upvr, {
            backgroundTransparency = 1;
            size = UDim2.new(0.7, 0, 1, 0);
        }, {
            Text = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Font = Enum.Font.FredokaOne;
                TextXAlignment = Enum.TextXAlignment.Left;
                Text = "FIND A TRADE SERVER";
                LineHeight = 1;
                TextScaled = true;
                TextColor3 = Color3.fromHex("489ff8");
            });
        });
        CloseContainer = createElement_upvr(PaddedContainer_upvr, {
            backgroundTransparency = 1;
            backgroundColor = Color3.fromHex("eb4d39");
            size = UDim2.new(0.15, 0, 1, 0);
            position = UDim2.new(0.85, 0, 0, 0);
        }, {
            TextButton = createElement_upvr("TextButton", {
                BackgroundTransparency = 0;
                BackgroundColor3 = Color3.fromHex("eb4d39");
                Size = UDim2.new(1, 0, 1, 0);
                Font = Enum.Font.FredokaOne;
                TextXAlignment = Enum.TextXAlignment.Center;
                Text = "CLOSE";
                LineHeight = 1;
                TextScaled = true;
                TextColor3 = Color3.fromHex("ffffff");
                [Roact_upvr.Event.Activated] = function() -- Line 78
                    store_upvr:dispatch({
                        type = "setOtherTradeServerListVisible";
                        value = false;
                    })
                end;
            }, {
                UICorner = createElement_upvr("UICorner", {
                    CornerRadius = UDim.new(0, 6);
                });
            });
        });
    })
    tbl.Body = createElement_upvr(PaddedContainer_upvr, {
        backgroundColor = Color3.new(0.2, 0.2, 0.2);
        backgroundTransparency = 0;
        position = UDim2.new(0, 0, 0.15, 0);
        size = UDim2.new(1, 0, 0.85, 0);
        paddingTop = 0;
        paddingBottom = 0;
        paddingLeft = 0;
        paddingRight = 0;
    }, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 6);
        });
        Scrolling = paddedScrollingGrid_upvr({
            rowsPerPage = 7;
            colsPerRow = 1;
            component = OtherTradeServerItem_upvr;
            items = clone;
            itemDefaults = {
                onJoinOtherTradeServer = arg1.props.onJoinOtherTradeServer;
            };
        });
    })
    return createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = Vector2.new(0.5, 0.5);
    }, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = arg1.props.aspectRatio;
        });
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        Container = createElement_upvr(PaddedContainer_upvr, {
            backgroundTransparency = 1;
            aspectRatio = arg1.props.aspectRatio;
            verticalPaddingRatio = arg1.props.verticalPaddingRatio;
            exposePaddedContainerProps = true;
        }, tbl);
    })
end
return any_extend_result1