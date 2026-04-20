local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("TradeInventory")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
    position = UDim2.new(0, 0, 0, 0);
    cornerPixel = 4;
    sortEnabled = true;
    displayName = "";
}
function any_extend_result1.init(arg1) -- Line 22
    arg1.itemDefaults = {
        cornerPixel = arg1.props.cornerPixel;
        onClick = arg1.props.onClickItem;
        onCardFlipped = arg1.props.onCardFlipped;
    }
end
local EnumSort_upvr = require(ReplicatedStorage.Garage.EnumSort)
local createElement_upvr = Roact_upvr.createElement
local store_upvr = require(ReplicatedStorage.App.store)
local ScrollingGrid_upvr = require(ReplicatedStorage.EzUi.ScrollingGrid)
local TradeCategory_upvr = require(script.Parent.TradeCategory)
local TradeCard_upvr = require(script.Parent.TradeCard)
local TradeButton_upvr = require(script.Parent.TradeButton)
local TradeChat_upvr = require(script.Parent.TradeChat)
function any_extend_result1.render(arg1) -- Line 29
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local cornerPixel = arg1.props.cornerPixel
    local Color3_new_result1 = Color3.new(0.2, 0.2, 0.2)
    local var32
    if arg1.props.sortId == EnumSort_upvr.Alphabetical then
    elseif arg1.props.sortId == EnumSort_upvr.Newest then
    elseif arg1.props.sortId == EnumSort_upvr.Price then
    elseif arg1.props.sortId == EnumSort_upvr.Popular then
    end
    for i, v_upvr in ipairs(arg1.props.categories) do
        local tbl_16 = {
            itemType = v_upvr.match.itemType;
            title = v_upvr.categoryTitle;
        }
        local function onClick() -- Line 64
            if arg1.props.onClickCategory then
                arg1.props.onClickCategory(v_upvr)
            end
        end
        tbl_16.onClick = onClick
        if v_upvr ~= arg1.props.category then
            onClick = false
        else
            onClick = true
        end
        tbl_16.selected = onClick
        table.insert({}, tbl_16)
    end
    if arg1.props.inventoryPlayers then
        i = nil
        for _, v_2_upvr in arg1.props.inventoryPlayers.allPlayers, nil, i do
            local tbl_15 = {
                title = v_2_upvr.DisplayName;
            }
            local function onClick() -- Line 78
                if arg1.props.onClickInventoryPlayer and v_2_upvr ~= arg1.props.inventoryPlayers.selectedPlayer then
                    arg1.props.onClickInventoryPlayer(v_2_upvr)
                end
            end
            tbl_15.onClick = onClick
            if v_2_upvr ~= arg1.props.inventoryPlayers.selectedPlayer then
                onClick = false
            else
                onClick = true
            end
            tbl_15.selected = onClick
            table.insert({}, tbl_15)
        end
    end
    local module = {}
    local _ = {}
    ;({}).AspectRatio = 1.6
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    module.AspectRatio = createElement_upvr("UIAspectRatioConstraint", {})
    module.UICorner = createElement_upvr("UICorner", {
        CornerRadius = UDim.new(0, cornerPixel);
    })
    local tbl_14 = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, cornerPixel);
        });
    }
    local tbl_12 = {}
    local tbl_9 = {
        BackgroundTransparency = 1;
    }
    var32 = 0
    tbl_9.Size = UDim2.new(1, var32, 1, 0)
    var32 = 0
    tbl_9.Position = UDim2.new(0.5, var32, 0.5, 0)
    var32 = 0.5
    tbl_9.AnchorPoint = Vector2.new(0.5, var32)
    var32 = 1
    tbl_9.TextColor3 = Color3.new(1, var32, 1)
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var32 = var32.DisplayName
        var32 = var32.selectedPlayer
        var32 = var32.inventoryPlayers
        var32 = arg1.props
        return var32
    end
    if not arg1.props.inventoryPlayers or not arg1.props.inventoryPlayers.selectedPlayer or not decompInlinedCondition() then
        var32 = "Player"
    end
    tbl_9.Text = "%s's Inventory":format(var32)
    tbl_9.TextXAlignment = Enum.TextXAlignment.Left
    tbl_9.Font = Enum.Font.Bangers
    tbl_9.LineHeight = 1
    tbl_9.TextScaled = true
    tbl_12.Text = createElement_upvr("TextLabel", tbl_9)
    tbl_14.Title = createElement_upvr("Frame", {
        BackgroundTransparency = 1;
        BackgroundColor3 = Color3.new(1, 0, 0);
        Size = UDim2.new(0.4875, 0, 1, 0);
        Position = UDim2.new(0.0125, 0, 0, 0);
    }, tbl_12)
    local tbl_8 = {}
    local tbl_3 = {}
    var32 = 0
    tbl_3.CornerRadius = UDim.new(0.125, var32)
    tbl_8.UICorner = createElement_upvr("UICorner", tbl_3)
    local tbl_13 = {}
    var32 = 1
    tbl_13.Color = Color3.new(1, var32, 1)
    tbl_13.Thickness = 3
    tbl_8.UIStroke = createElement_upvr("UIStroke", tbl_13)
    local tbl_6 = {}
    var32 = 0
    tbl_6.Size = UDim2.new(0.9, var32, 0.8, 0)
    var32 = 0.5
    tbl_6.AnchorPoint = Vector2.new(0.5, var32)
    var32 = 0
    tbl_6.Position = UDim2.new(0.5, var32, 0.6, 0)
    tbl_6.BackgroundTransparency = 1
    tbl_6.TextScaled = true
    tbl_6.Font = Enum.Font.LuckiestGuy
    var32 = 1
    tbl_6.TextColor3 = Color3.new(1, var32, 1)
    tbl_6.PlaceholderText = "SEARCH ITEMS..."
    tbl_6.Text = ""
    tbl_6[Roact_upvr.Ref] = arg1.boxRef
    tbl_6[Roact_upvr.Change.Text] = function(arg1_2) -- Line 154
        local any_gsub_result1 = arg1_2.Text:upper():gsub("[^%w%s]", "")
        arg1_2.Text = any_gsub_result1
        store_upvr:dispatch({
            type = "setTradeInventorySearchText";
            value = any_gsub_result1;
        })
    end
    tbl_8.Box = createElement_upvr("TextBox", tbl_6)
    tbl_14.Input = createElement_upvr("Frame", {
        BackgroundTransparency = 0.6666666666666666;
        BackgroundColor3 = Color3.new(0.1, 0.1, 0.1);
        Size = UDim2.new(0.2, 0, 0.7, 0);
        Position = UDim2.new(0.65, 0, 0.5, 0);
        AnchorPoint = Vector2.new(0.5, 0.5);
    }, tbl_8)
    local sortEnabled = arg1.props.sortEnabled
    if sortEnabled then
        sortEnabled = createElement_upvr
        local tbl_17 = {
            AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 6;
            });
        }
        local tbl_7 = {
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
        }
        var32 = 0
        tbl_7.Size = UDim2.new(0.3, var32, 1, 0)
        local tbl_5 = {}
        var32 = "TextLabel"
        tbl_5.Title = createElement_upvr(var32, {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 0.8, 0);
            Position = UDim2.new(0, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0, 0.5);
            Text = "SORT:";
            Font = Enum.Font.Bangers;
            LineHeight = 0.95;
            TextScaled = true;
            TextXAlignment = Enum.TextXAlignment.Left;
            TextColor3 = Color3.new(1, 1, 1);
            ZIndex = 1;
        })
        tbl_17.Left = createElement_upvr("Frame", tbl_7, tbl_5)
        local tbl = {
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
        }
        var32 = 1
        tbl.BackgroundColor3 = Color3.new(1, var32, 0)
        var32 = 0
        tbl.Size = UDim2.new(0.7, var32, 1, 0)
        var32 = 0
        tbl.Position = UDim2.new(0.3, var32, 0, 0)
        local tbl_2 = {}
        var32 = "TextButton"
        tbl_2.Container = createElement_upvr(var32, {
            Text = "";
            BackgroundTransparency = 0;
            BorderSizePixel = 0;
            BackgroundColor3 = Color3.new(1, 1, 1);
            Size = UDim2.new(1, 0, 1, 0);
            Position = UDim2.new(0, 0, 0, 0);
            [Roact_upvr.Event.Activated] = function() -- Line 211
                arg1.props.onSelectSort(arg1.props.sortId)
            end;
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(0, cornerPixel);
            });
            Title = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                BorderSizePixel = 0;
                Size = UDim2.new(0.9, 0, 0.8, 0);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0.5, 0.5);
                Text = "HIGH DEMAND";
                Font = Enum.Font.Bangers;
                LineHeight = 0.95;
                TextScaled = true;
                TextXAlignment = Enum.TextXAlignment.Center;
                TextColor3 = Color3.new(0, 0, 0);
                ZIndex = 1;
            });
        })
        tbl_17.Right = createElement_upvr("Frame", tbl, tbl_2)
        sortEnabled = sortEnabled("Frame", {
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 0.75, 0);
            AnchorPoint = Vector2.new(1, 0.5);
            Position = UDim2.new(0.99, 0, 0.5, 0);
        }, tbl_17)
    end
    tbl_14.SortContainer = sortEnabled
    module.Header = createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundColor3 = Color3_new_result1;
        Size = UDim2.new(0.984375, 0, 0.08, 0);
        Position = UDim2.new(0.0078125, 0, 0.0125, 0);
    }, tbl_14)
    local tbl_10 = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, cornerPixel);
        });
    }
    local tbl_11 = {
        aspectRatio = 0.2800632911392405;
        paddingRatio = 17.700000000000003;
        rowsPerPage = 14;
        colsPerRow = 1;
        component = TradeCategory_upvr;
        itemDefaults = {
            cornerPixel = cornerPixel;
        };
    }
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    tbl_11.items = {}
    tbl_10.ScrollingGrid = createElement_upvr(ScrollingGrid_upvr, tbl_11)
    module.OtherPlayerInventoryContainers = createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundColor3 = Color3_new_result1;
        BackgroundTransparency = 0;
        Size = UDim2.new(0.13828125, 0, 1, 0);
        AnchorPoint = Vector2.new(1, 0);
        Position = UDim2.new(-0.0078125, 0, 0, 0);
        Visible = not arg1.props.tradeActive;
    }, tbl_10)
    local tbl_18 = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, cornerPixel);
        });
    }
    local tbl_4 = {
        aspectRatio = 0.2800632911392405;
        paddingRatio = 17.700000000000003;
        rowsPerPage = 12;
        colsPerRow = 1;
        component = TradeCategory_upvr;
        itemDefaults = {
            cornerPixel = cornerPixel;
        };
    }
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    tbl_4.items = {}
    tbl_18.ScrollingGrid = createElement_upvr(ScrollingGrid_upvr, tbl_4)
    module.ItemTypesContainer = createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundColor3 = Color3_new_result1;
        Size = UDim2.new(0.13828125, 0, 0.79, 0);
        Position = UDim2.new(0.0078125, 0, 0.10500000000000001, 0);
    }, tbl_18)
    module.ItemsContainer = createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundColor3 = Color3_new_result1;
        Size = UDim2.new(0.83828125, 0, 0.79, 0);
        Position = UDim2.new(0.15390625, 0, 0.10500000000000001, 0);
    }, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, cornerPixel);
        });
        ScrollingGrid = createElement_upvr(ScrollingGrid_upvr, {
            aspectRatio = 1.6977848101265822;
            paddingRatio = 107.30000000000001;
            rowsPerPage = 3;
            colsPerRow = 7;
            component = TradeCard_upvr;
            itemDefaults = arg1.itemDefaults;
            items = arg1.props.items;
            metadata = arg1.props.itemMetadata;
        });
    })
    module.Footer = createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundColor3 = Color3_new_result1;
        Size = UDim2.new(0.984375, 0, 0.08, 0);
        Position = UDim2.new(0.0078125, 0, 0.9075, 0);
    }, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, cornerPixel);
        });
        ListLayout = createElement_upvr("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Right;
            VerticalAlignment = Enum.VerticalAlignment.Center;
            SortOrder = Enum.SortOrder.LayoutOrder;
            FillDirection = Enum.FillDirection.Horizontal;
            Padding = UDim.new(0.0078125, 0);
        });
        Padding = createElement_upvr("UIPadding", {
            PaddingLeft = UDim.new(0.0078125, 0);
            PaddingRight = UDim.new(0.0078125, 0);
            PaddingTop = UDim.new(0.15625, 0);
            PaddingBottom = UDim.new(0.15625, 0);
        });
        Button1 = createElement_upvr(TradeButton_upvr, {
            layoutOrder = 1;
            backgroundColor = Color3.fromRGB(255, 58, 43);
            text = "Back";
            onClick = arg1.props.onClickExit;
        });
    })
    if arg1.props.showChat then
        module.Chat = createElement_upvr(TradeChat_upvr, {
            size = UDim2.new(0.25, 0, 1, 0);
            position = UDim2.new(1.0078125, 0, 0, 0);
            aspectRatio = 0.4;
            verticalPaddingRatio = 80;
            messages = arg1.props.tradeChatMessages;
        })
    end
    return createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundColor3 = Color3.new(0, 0, 0);
        BackgroundTransparency = 0.8;
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
    }, module)
end
return any_extend_result1