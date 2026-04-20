local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("SafesShop")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Players_upvr = game:GetService("Players")
local PolicyService_upvr = require(ReplicatedStorage.Policy.PolicyService)
function any_extend_result1.init(arg1) -- Line 20
    arg1.maid = Maid_upvr.new()
    arg1:setState({
        canPurchase = true;
    })
    if Players_upvr.LocalPlayer then
        local LocalPlayer_upvr = Players_upvr.LocalPlayer
        PolicyService_upvr.promiseCachedPlayerPolicyInfo(LocalPlayer_upvr):andThen(function(arg1_2) -- Line 27
            if arg1_2.ArePaidRandomItemsRestricted == true then
                arg1:setState({
                    canPurchase = true;
                    policyCashAvailable = LocalPlayer_upvr:GetAttribute("NoPaidCash") or 0;
                })
                arg1.maid:GiveTask(LocalPlayer_upvr:GetAttributeChangedSignal("NoPaidCash"):Connect(function() -- Line 38
                    arg1:setState({
                        policyCashAvailable = LocalPlayer_upvr:GetAttribute("NoPaidCash") or 0;
                    })
                end))
            end
        end)
    end
end
local createElement_upvr = Roact_upvr.createElement
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
local topBarButtonsComponent_upvr = require(script.Parent.topBarButtonsComponent)
local paddedScrollingGrid_upvr = require(script.Parent.paddedScrollingGrid)
local SafeComponent_upvr = require(script.Parent.SafeComponent)
local bodyTopBarComponent_upvr = require(script.Parent.bodyTopBarComponent)
local rewardCardComponent_upvr = require(ReplicatedStorage.RewardSpinner.UI.rewardCardComponent)
local safeInfoComponent_upvr = require(script.Parent.safeInfoComponent)
local Dictionary_upvr = require(ReplicatedStorage.Std.Dictionary)
local String_upvr = require(ReplicatedStorage.Std.String)
function any_extend_result1.render(arg1) -- Line 48
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local Color3_new_result1 = Color3.new(0.2, 0.2, 0.2)
    local module = {}
    local tbl_3 = {}
    local var28
    if arg1.state.policyCashAvailable or arg1.props.policyCashAvailable then
        var28 = createElement_upvr
        var28 = var28(PaddedContainer_upvr, {
            backgroundColor = Color3.new(0.2, 0.2, 0.2);
            size = UDim2.new(1, 0, 0.05, 0);
            position = UDim2.new(0, 0, -0.05, 0);
            paddingTop = 0;
            paddingBottom = 1;
            paddingLeft = 0;
            paddingRight = 0;
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0, 4);
            });
            Text = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0.9, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Text = "Hey! Due to local laws, you may only spend the cash you've earned, not paid for. Below is your available cash for safes.";
                TextXAlignment = Enum.TextXAlignment.Center;
                Font = Enum.Font.Bangers;
                TextScaled = true;
                TextColor3 = Color3.new(1, 1, 1);
            });
        })
    else
        var28 = nil
    end
    tbl_3.PolicyCashAvailableBar = var28
    var28 = createElement_upvr
    local tbl = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
    }
    local tbl_4 = {
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
                Text = "SAFE STORE";
                TextXAlignment = Enum.TextXAlignment.Left;
                Font = Enum.Font.Bangers;
                LineHeight = 1;
                TextScaled = true;
                TextColor3 = Color3.new(1, 1, 1);
            });
        });
    }
    local tbl_5 = {
        exposePaddedContainerProps = true;
        nextPageTitle = "OPEN SAFES";
        onSelectToggle = arg1.props.onSelectOpenSafes;
        onSelectExit = arg1.props.onSelectExit;
    }
    if not arg1.state.policyCashAvailable then
    end
    tbl_5.policyCashAvailable = arg1.props.policyCashAvailable
    tbl_4.Buttons = createElement_upvr(topBarButtonsComponent_upvr, tbl_5)
    tbl.Inner = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
    }, tbl_4)
    var28 = var28(PaddedContainer_upvr, {
        backgroundColor = Color3_new_result1;
        paddingTop = 0;
        paddingLeft = 0;
        paddingRight = 0;
        paddingBottom = 0.5;
        size = UDim2.new(1, 0, 0.1, 0);
    }, tbl)
    tbl_3.TopBar = var28
    var28 = createElement_upvr
    var28 = var28(PaddedContainer_upvr, {
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
    })
    tbl_3.Left = var28
    var28 = createElement_upvr
    var28 = var28(PaddedContainer_upvr, {
        backgroundColor = Color3_new_result1;
        paddingTop = 0.5;
        paddingLeft = 0.5;
        paddingRight = 0.5;
        paddingBottom = 0;
        size = UDim2.new(0.7050000000000001, 0, 0.9, 0);
        position = UDim2.new(0.12, 0, 0.1, 0);
    }, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        Top = createElement_upvr(bodyTopBarComponent_upvr, {
            exposePaddedContainerProps = true;
        });
        Body = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 0.9, 0);
            Position = UDim2.new(0, 0, 0.1, 0);
        }, {
            Icons = createElement_upvr(paddedScrollingGrid_upvr, {
                exposePaddedContainerProps = true;
                paddingRatio = 32;
                rowsPerPage = 2.25;
                colsPerRow = 5;
                component = rewardCardComponent_upvr;
                items = arg1.props.items;
            });
        });
    })
    tbl_3.Body = var28
    var28 = createElement_upvr
    var28 = var28(PaddedContainer_upvr, {
        backgroundColor = Color3_new_result1;
        paddingTop = 0.5;
        paddingLeft = 0.5;
        paddingRight = 0;
        paddingBottom = 0.5;
        size = UDim2.new(0.175, 0, 0.75, 0);
        position = UDim2.new(0.825, 0, 0.1, 0);
    }, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 4);
        });
        Inner = createElement_upvr(PaddedContainer_upvr, {
            backgroundTransparency = 1;
        }, {createElement_upvr(safeInfoComponent_upvr, Dictionary_upvr.merge({
            exposePaddedContainerProps = true;
        }, arg1.props.selectedSafeTierData))});
    })
    tbl_3.Right = var28
    var28 = createElement_upvr
    local tbl_2 = {}
    local var13_result1 = createElement_upvr("UICorner", {
        CornerRadius = UDim.new(0, 4);
    })
    tbl_2.UICorner = var13_result1
    if arg1.state.canPurchase then
        var13_result1 = createElement_upvr
        var13_result1 = var13_result1(PaddedContainer_upvr, {
            backgroundTransparency = 1;
            size = UDim2.new(1, 0, 0.5, 0);
            paddingBottom = 0.5;
        }, {
            Title = createElement_upvr("Frame", {
                BorderSizePixel = 0;
                BackgroundTransparency = 1;
                BackgroundColor3 = Color3.new(1, 0, 0);
                Size = UDim2.new(1, 0, 1, 0);
                Position = UDim2.new(0, 0, 0, 0);
            }, {
                Text = createElement_upvr("TextLabel", {
                    BackgroundTransparency = 1;
                    Size = UDim2.new(1, 0, 1, 0);
                    Position = UDim2.new(0.5, 0, 0.5, 0);
                    AnchorPoint = Vector2.new(0.5, 0.5);
                    Text = '$'..String_upvr.comma(arg1.props.selectedSafeTierData.Price);
                    TextXAlignment = Enum.TextXAlignment.Center;
                    Font = Enum.Font.Bangers;
                    LineHeight = 1;
                    TextScaled = true;
                    TextColor3 = Color3.new(1, 1, 1);
                });
            });
        })
    else
        var13_result1 = nil
    end
    tbl_2.Top = var13_result1
    if arg1.state.canPurchase then
        local tbl_7 = {
            size = UDim2.new(1, 0, 0.5, 0);
            position = UDim2.new(0, 0, 0.5, 0);
            paddingTop = 0.5;
            backgroundTransparency = 1;
        }
        ;({}).Button = createElement_upvr("TextButton", {
            Size = UDim2.new(1, 0, 1, 0);
            BackgroundColor3 = Color3.fromRGB(115, 250, 121);
            Text = "";
            [Roact_upvr.Event.Activated] = arg1.props.onSelectPurchase;
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0, 4);
            });
            Text = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Text = "PURCHASE";
                TextXAlignment = Enum.TextXAlignment.Center;
                Font = Enum.Font.Bangers;
                LineHeight = 1;
                TextScaled = true;
                TextColor3 = Color3.new(0, 0, 0);
            });
        })
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    tbl_2.Bottom = nil
    if not arg1.state.canPurchase then
        local _ = {
            size = UDim2.new(1, 0, 1, 0);
            position = UDim2.new(0, 0, 0, 0);
            paddingTop = 0.5;
            backgroundTransparency = 1;
        }
        ;({}).Text = createElement_upvr("TextLabel", {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
            Text = "Paid random items are restricted for this account.";
            TextScaled = true;
            Font = Enum.Font.Bangers;
            LineHeight = 1;
            TextColor3 = Color3.new(1, 1, 1);
        })
    else
    end
    tbl_2.Warning = nil
    var28 = var28(PaddedContainer_upvr, {
        backgroundColor = Color3_new_result1;
        paddingTop = 0.5;
        paddingLeft = 0.5;
        paddingRight = 0;
        paddingBottom = 0;
        size = UDim2.new(0.175, 0, 0.15, 0);
        position = UDim2.new(0.825, 0, 0.85, 0);
    }, tbl_2)
    tbl_3.RightBottom = var28
    module.Container = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        aspectRatio = 1.8;
        verticalPaddingRatio = 128;
    }, tbl_3)
    module.AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
        AspectRatio = 1.8;
    })
    local tbl_6 = {}
    var28 = 0
    tbl_6.CornerRadius = UDim.new(var28, 4)
    module.UICorner = createElement_upvr("UICorner", tbl_6)
    return createElement_upvr("Frame", {
        BackgroundTransparency = 0.8;
        BackgroundColor3 = Color3.new(0, 0, 0);
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
    }, module)
end
function any_extend_result1.didMount(arg1) -- Line 317
end
return any_extend_result1