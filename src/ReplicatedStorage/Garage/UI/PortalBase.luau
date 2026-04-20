local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local SaleConsts_upvr = require(ReplicatedStorage.Sale.SaleConsts)
local EnumSort_upvr = require(script.Parent.Parent.EnumSort)
local any_extend_result1 = Roact_upvr.PureComponent:extend("PortalBase")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 19
    local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(arg1.props.title)
    arg1.titleBinding = any_createBinding_result1
    arg1.updateTitleBinding = any_createBinding_result2
    arg1.maid = Maid_upvr.new()
    arg1.searchRef = Roact_upvr.createRef()
    arg1:setState({
        search = "";
        aerialEnabled = false;
    })
end
local RunUtils_upvr = require(ReplicatedStorage.App.RunUtils)
local createElement_upvr = Roact_upvr.createElement
local Checkbox_upvr = require(ReplicatedStorage.EzUi.Checkbox)
local ScrollingGrid_upvr = require(ReplicatedStorage.EzUi.ScrollingGrid)
local CustomizeItem_upvr = require(script.Parent.CustomizeItem)
function any_extend_result1.render(arg1) -- Line 28
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local portalRatio = arg1.props.portalRatio
    local paddingRatio = arg1.props.paddingRatio
    local var21 = portalRatio * 10
    local cornerPixel = arg1.props.cornerPixel
    local var23 = 1 / (1 / portalRatio - 1 / var21 - 1 / paddingRatio)
    local var24 = 0.125 / var21
    local var25 = 4.5 / var21
    local var26
    if arg1.props.sortId == EnumSort_upvr.Alphabetical then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1.props.sortId == EnumSort_upvr.Newest then
    elseif arg1.props.sortId == EnumSort_upvr.Price then
    elseif arg1.props.sortId == EnumSort_upvr.PriceLow then
    elseif arg1.props.sortId == EnumSort_upvr.Popular then
    end
    local items = arg1.props.items
    local tbl_17 = {}
    local aerialEnabled_upvr = arg1.state.aerialEnabled
    for i = 1, #items do
        local var45 = items[i]
        local var46 = arg1.props.metadata[i]
        if (function(arg1_2, arg2, arg3) -- Line 67, Named "shouldShow"
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            local any_gsub_result1_3 = arg3 or "":lower():gsub(' ', "")
            local var41
            if 0 >= #any_gsub_result1_3 then
                var41 = false
            else
                var41 = true
            end
            if var41 then
                if string.find(arg1_2.title or "":lower():gsub(' ', ""), any_gsub_result1_3, 1, true) == nil then
                else
                end
            end
            if not not arg1.props.showFavorited then
                local faved_2 = arg2.faved
            end
            if not arg1.props.showAll or not not arg1_2.hiddenAll or not arg1_2.available then
            end
            if aerialEnabled_upvr or not not arg1_2.aerialOnly or not aerialEnabled_upvr or arg1_2.vehicleType ~= "Heli" or arg1.props.title == "SPAWN" then
            end
            if var41 then
                local var43 = faved_2
                if var43 then
                    var43 = arg2.owned
                    if var43 then
                        var43 = true
                        if var43 then
                            var43 = RunUtils_upvr.isTradeWorld()
                        end
                    end
                end
                return var43
            end
            var43 = faved_2
            local var44 = var43
            if var44 then
                var44 = arg2.owned
                if var44 then
                    var44 = RunUtils_upvr.isTradeWorld()
                end
            end
            return var44
        end)(var45, var46, arg1.state.search) then
            local var47 = #tbl_17 + 1
            tbl_17[var47] = var45
            ;({})[var47] = var46
        end
    end
    arg1:_updateTitle()
    local module = {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = portalRatio;
        });
        ListLayout = createElement_upvr("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            VerticalAlignment = Enum.VerticalAlignment.Center;
            SortOrder = Enum.SortOrder.LayoutOrder;
            FillDirection = Enum.FillDirection.Vertical;
        });
    }
    local tbl_19 = {
        BackgroundTransparency = 0.4;
        BorderSizePixel = 0;
        BackgroundColor3 = Color3.new(0.1, 0.1, 0.1);
    }
    var26 = 0
    tbl_19.Size = UDim2.new(1, 0, 1, var26)
    tbl_19.LayoutOrder = 1
    local tbl_4 = {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = var21;
        });
    }
    local tbl_25 = {}
    var26 = UDim.new(0, cornerPixel)
    tbl_25.CornerRadius = var26
    tbl_4.UICorner = createElement_upvr("UICorner", tbl_25)
    local tbl_11 = {}
    var26 = 1
    tbl_11.BackgroundTransparency = var26
    var26 = 0
    tbl_11.BorderSizePixel = var26
    var26 = UDim2.new(0.5, 0, 0.5, 0)
    tbl_11.Size = var26
    var26 = UDim2.new(0.25 / var21, 0, 0.5, 0)
    tbl_11.Position = var26
    var26 = Vector2.new(0, 0.5)
    tbl_11.AnchorPoint = var26
    var26 = arg1.titleBinding
    tbl_11.Text = var26
    var26 = Enum.Font.LuckiestGuy
    tbl_11.Font = var26
    var26 = 0.7
    tbl_11.LineHeight = var26
    var26 = true
    tbl_11.TextScaled = var26
    var26 = Enum.TextXAlignment.Left
    tbl_11.TextXAlignment = var26
    if arg1.props.title == SaleConsts_upvr.CATEGORY_NAME then
        var26 = Color3.new(1, 0.1, 0.1)
    else
        var26 = Color3.fromRGB(98, 222, 253)
    end
    tbl_11.TextColor3 = var26
    var26 = 4
    tbl_11.ZIndex = var26
    var26 = {}
    var26.UIStroke = createElement_upvr("UIStroke", {
        Color = Color3.new(0, 0, 0);
        Thickness = 1;
    })
    tbl_4.Title = createElement_upvr("TextLabel", tbl_11, var26)
    local sortEnabled_2 = arg1.props.sortEnabled
    if sortEnabled_2 then
        sortEnabled_2 = createElement_upvr
        local tbl_2 = {}
        var26 = 0
        tbl_2.BorderSizePixel = var26
        var26 = 1
        tbl_2.BackgroundTransparency = var26
        var26 = UDim2.new(1, 0, 0.75, 0)
        tbl_2.Size = var26
        var26 = Vector2.new(1, 0.5)
        tbl_2.AnchorPoint = var26
        var26 = UDim2.new(1 - 7 * var24 - 2 * var25 - 0.75 / var21, 0, 0.5, 0)
        tbl_2.Position = var26
        var26 = {}
        var26.AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = 2;
        })
        var26.Left = createElement_upvr("Frame", {
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
            Size = UDim2.new(0.4, 0, 1, 0);
        }, {
            Title = createElement_upvr("TextLabel", {
                BackgroundTransparency = 1;
                BorderSizePixel = 0;
                Size = UDim2.new(1, 0, 0.8, 0);
                Position = UDim2.new(0, 0, 0.5, 0);
                AnchorPoint = Vector2.new(0, 0.5);
                Text = "ALL:";
                Font = Enum.Font.Bangers;
                LineHeight = 0.95;
                TextScaled = true;
                TextXAlignment = Enum.TextXAlignment.Left;
                TextColor3 = Color3.new(1, 1, 1);
                ZIndex = 1;
            });
        })
        var26.Right = createElement_upvr("Frame", {
            BorderSizePixel = 0;
            BackgroundTransparency = 1;
            BackgroundColor3 = Color3.new(1, 1, 0);
            Size = UDim2.new(0.5, 0, 1, 0);
            Position = UDim2.new(0.5, 0, 0, 0);
        }, {
            Checkbox = createElement_upvr(Checkbox_upvr, {
                size = UDim2.new(1, 0, 1, 0);
                value = arg1.props.showAll;
                onChecked = arg1.props.onToggleAll;
            });
        })
        sortEnabled_2 = sortEnabled_2("Frame", tbl_2, var26)
    end
    tbl_4.OwnedCheckbox = sortEnabled_2
    local var67
    if arg1.props.sortEnabled then
        local tbl_23 = {}
        var26 = 0
        tbl_23.BorderSizePixel = var26
        var26 = 1
        tbl_23.BackgroundTransparency = var26
        var26 = UDim2.new
        var67 = 0
        var26 = var26(1, 0, 0.75, var67)
        tbl_23.Size = var26
        var26 = Vector2.new(1, 0.5)
        tbl_23.AnchorPoint = var26
        var26 = UDim2.new
        var67 = 0
        var26 = var26(1 - 5 * var24 - 2 * var25, 0, 0.5, var67)
        tbl_23.Position = var26
        var26 = {}
        local tbl_13 = {}
        var67 = 1
        tbl_13.AspectRatio = var67
        var26.AspectRatio = createElement_upvr("UIAspectRatioConstraint", tbl_13)
        local tbl_5 = {}
        var67 = 1
        tbl_5.BackgroundTransparency = var67
        var67 = 0
        tbl_5.BorderSizePixel = var67
        var67 = UDim2.new(1, 0, 1, 0)
        tbl_5.Size = var67
        var67 = UDim2.new(0.5, 0, 0.5, 0)
        tbl_5.Position = var67
        var67 = Vector2.new(0.5, 0.5)
        tbl_5.AnchorPoint = var67
        local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var67 = Color3.fromRGB(255, 251, 0)
            return var67
        end
        if not arg1.props.showFavorited and not arg1.state.favHover or not decompInlinedCondition() then
            var67 = Color3.new(0.7, 0.7, 0.7)
        end
        tbl_5.ImageColor3 = var67
        var67 = "rbxassetid://8552830996"
        tbl_5.Image = var67
        var67 = 10
        tbl_5.ZIndex = var67
        var67 = Roact_upvr
        var67 = var67.Event
        var67 = var67.MouseEnter
        tbl_5[var67] = function() -- Line 218
            arg1:setState({
                favHover = true;
            })
        end
        var67 = Roact_upvr
        var67 = var67.Event
        var67 = var67.MouseLeave
        tbl_5[var67] = function() -- Line 223
            arg1:setState({
                favHover = false;
            })
        end
        var67 = Roact_upvr
        var67 = var67.Event
        var67 = var67.SelectionGained
        tbl_5[var67] = function() -- Line 228
            arg1:setState({
                favHover = true;
            })
        end
        var67 = Roact_upvr
        var67 = var67.Event
        var67 = var67.SelectionLost
        tbl_5[var67] = function() -- Line 233
            arg1:setState({
                favHover = false;
            })
        end
        var67 = Roact_upvr
        var67 = var67.Event
        var67 = var67.Activated
        tbl_5[var67] = arg1.props.onToggleFavorited
        var26.Star = createElement_upvr("ImageButton", tbl_5)
    end
    tbl_4.FavoritedCheckbox = createElement_upvr("Frame", tbl_23, var26)
    local sortEnabled_3 = arg1.props.sortEnabled
    if sortEnabled_3 then
        sortEnabled_3 = createElement_upvr
        local tbl_18 = {}
        var26 = 0
        tbl_18.BorderSizePixel = var26
        var26 = 1
        tbl_18.BackgroundTransparency = var26
        var26 = UDim2.new
        var67 = 0
        var26 = var26(1, 0, 0.75, var67)
        tbl_18.Size = var26
        var26 = Vector2.new(1, 0.5)
        tbl_18.AnchorPoint = var26
        var26 = UDim2.new
        var67 = 0
        var26 = var26(1 - 3 * var24 - var25, 0, 0.5, var67)
        tbl_18.Position = var26
        var26 = {}
        local tbl_16 = {}
        var67 = 6
        tbl_16.AspectRatio = var67
        var26.AspectRatio = createElement_upvr("UIAspectRatioConstraint", tbl_16)
        local tbl_10 = {}
        var67 = 0
        tbl_10.BorderSizePixel = var67
        var67 = 1
        tbl_10.BackgroundTransparency = var67
        var67 = UDim2.new(0.3, 0, 1, 0)
        tbl_10.Size = var67
        var67 = {}
        var67.Title = createElement_upvr("TextLabel", {
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
        var26.Left = createElement_upvr("Frame", tbl_10, var67)
        local tbl_9 = {}
        var67 = 0
        tbl_9.BorderSizePixel = var67
        var67 = 1
        tbl_9.BackgroundTransparency = var67
        var67 = Color3.new(1, 1, 0)
        tbl_9.BackgroundColor3 = var67
        var67 = UDim2.new(0.7, 0, 1, 0)
        tbl_9.Size = var67
        var67 = UDim2.new(0.3, 0, 0, 0)
        tbl_9.Position = var67
        var67 = {}
        var67.Container = createElement_upvr("TextButton", {
            Text = "";
            BackgroundTransparency = 0;
            BorderSizePixel = 0;
            BackgroundColor3 = Color3.new(1, 1, 1);
            Size = UDim2.new(1, 0, 1, 0);
            Position = UDim2.new(0, 0, 0, 0);
            [Roact_upvr.Event.Activated] = function() -- Line 286
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
                Text = "POPULAR";
                Font = Enum.Font.Bangers;
                LineHeight = 0.95;
                TextScaled = true;
                TextXAlignment = Enum.TextXAlignment.Center;
                TextColor3 = Color3.new(0, 0, 0);
                ZIndex = 1;
            });
        })
        var26.Right = createElement_upvr("Frame", tbl_9, var67)
        sortEnabled_3 = sortEnabled_3("Frame", tbl_18, var26)
    end
    tbl_4.SortContainer = sortEnabled_3
    local sortEnabled = arg1.props.sortEnabled
    if sortEnabled then
        sortEnabled = createElement_upvr
        local tbl_15 = {}
        var26 = 0
        tbl_15.BorderSizePixel = var26
        var26 = 1
        tbl_15.BackgroundTransparency = var26
        var26 = UDim2.new
        var67 = 0
        var26 = var26(1, 0, 0.75, var67)
        tbl_15.Size = var26
        var26 = Vector2.new(1, 0.5)
        tbl_15.AnchorPoint = var26
        var26 = UDim2.new
        var67 = 0
        var26 = var26(1 - var24, 0, 0.5, var67)
        tbl_15.Position = var26
        var26 = {}
        local tbl_12 = {}
        var67 = 6
        tbl_12.AspectRatio = var67
        var26.AspectRatio = createElement_upvr("UIAspectRatioConstraint", tbl_12)
        local tbl_24 = {}
        var67 = 0
        tbl_24.BackgroundTransparency = var67
        var67 = 0
        tbl_24.BorderSizePixel = var67
        var67 = Color3.new(1, 1, 1)
        tbl_24.BackgroundColor3 = var67
        var67 = UDim2.new(1, 0, 1, 0)
        tbl_24.Size = var67
        var67 = UDim2.new(0, 0, 0, 0)
        tbl_24.Position = var67
        var67 = "Search..."
        tbl_24.PlaceholderText = var67
        var67 = ""
        tbl_24.Text = var67
        var67 = Enum.Font.Bangers
        tbl_24.Font = var67
        var67 = true
        tbl_24.TextScaled = var67
        var67 = Enum.TextXAlignment.Center
        tbl_24.TextXAlignment = var67
        var67 = Color3.new(0, 0, 0)
        tbl_24.TextColor3 = var67
        var67 = Color3.new(0.5, 0.5, 0.5)
        tbl_24.PlaceholderColor3 = var67
        var67 = 1
        tbl_24.ZIndex = var67
        var67 = Roact_upvr
        var67 = var67.Ref
        tbl_24[var67] = arg1.searchRef
        var67 = {}
        var67.UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, cornerPixel);
        })
        var26.SearchBox = createElement_upvr("TextBox", tbl_24, var67)
        sortEnabled = sortEnabled("Frame", tbl_15, var26)
    end
    tbl_4.SearchContainer = sortEnabled
    module.Top = createElement_upvr("Frame", tbl_19, tbl_4)
    local tbl_7 = {
        BorderSizePixel = 0;
        BackgroundTransparency = 1;
        BackgroundColor3 = Color3.new(1, 0, 0);
    }
    var26 = 0
    tbl_7.Size = UDim2.new(1, 0, 1, var26)
    tbl_7.LayoutOrder = 2
    module.Padding1 = createElement_upvr("Frame", tbl_7, {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = paddingRatio;
        });
    })
    local tbl = {
        BackgroundTransparency = 0.4;
        BorderSizePixel = 0;
        BackgroundColor3 = Color3.new(0.1, 0.1, 0.1);
    }
    var26 = 0
    tbl.Size = UDim2.new(1, 0, 1, var26)
    tbl.LayoutOrder = 3
    local tbl_21 = {
        AspectRatio = createElement_upvr("UIAspectRatioConstraint", {
            AspectRatio = var23;
        });
    }
    local tbl_3 = {}
    var26 = UDim.new(0, cornerPixel)
    tbl_3.CornerRadius = var26
    tbl_21.UICorner = createElement_upvr("UICorner", tbl_3)
    local tbl_22 = {
        aspectRatio = var23;
        paddingRatio = paddingRatio;
    }
    var26 = CustomizeItem_upvr
    tbl_22.component = var26
    tbl_22.items = tbl_17
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    tbl_22.metadata = {}
    var26 = arg1.props
    var26 = var26.onSelectItem
    tbl_22.onSelectItem = var26
    var26 = arg1.props
    var26 = var26.colsPerRow
    tbl_22.colsPerRow = var26
    var26 = arg1.props
    var26 = var26.rowsPerPage
    tbl_22.rowsPerPage = var26
    tbl_21.ScrollingGrid = createElement_upvr(ScrollingGrid_upvr, tbl_22)
    module.Body = createElement_upvr("Frame", tbl, tbl_21)
    do
        return createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            BackgroundColor3 = Color3.new(1, 1, 1);
            Size = UDim2.new(1, 0, 1, 0);
            LayoutOrder = 3;
        }, module)
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local SaleUtils_upvr = require(ReplicatedStorage.Sale.SaleUtils)
function any_extend_result1._updateTitle(arg1) -- Line 379
    if arg1.props.title == SaleConsts_upvr.CATEGORY_NAME then
        arg1.updateTitleBinding(SaleConsts_upvr.CATEGORY_NAME..": "..SaleUtils_upvr.formatRemaining(SaleUtils_upvr.getTimeToNextSale()))
    else
        arg1.updateTitleBinding(arg1.props.title)
    end
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
local Players_upvr = game:GetService("Players")
local GarageConsts_upvr = require(script.Parent.Parent.GarageConsts)
function any_extend_result1.didMount(arg1) -- Line 388
    arg1.maid.updateTitle = Interval_upvr.every(1):Connect(function() -- Line 389
        arg1:_updateTitle()
    end)
    local any_getValue_result1_upvr_2 = arg1.searchRef:getValue()
    if any_getValue_result1_upvr_2 then
        arg1.maid:GiveTask(any_getValue_result1_upvr_2:GetPropertyChangedSignal("Text"):Connect(function() -- Line 394
            arg1.maid.searchDelay = task.delay(0.1, function() -- Line 395
                arg1:setState({
                    search = any_getValue_result1_upvr_2.Text;
                })
            end)
        end))
    end
    if Players_upvr.LocalPlayer then
        arg1.maid:GiveTask(Players_upvr.LocalPlayer:GetAttributeChangedSignal(GarageConsts_upvr.AERIAL_SPAWN_ATTR_NAME):Connect(function() -- Line 405
            local tbl_8 = {}
            local var124
            if Players_upvr.LocalPlayer:GetAttribute(GarageConsts_upvr.AERIAL_SPAWN_ATTR_NAME) ~= true then
                var124 = false
            else
                var124 = true
            end
            tbl_8.aerialEnabled = var124
            arg1:setState(tbl_8)
        end))
        local AERIAL_SPAWN_ATTR_NAME_2 = GarageConsts_upvr.AERIAL_SPAWN_ATTR_NAME
        if arg1.state.aerialEnabled ~= Players_upvr.LocalPlayer:GetAttribute(AERIAL_SPAWN_ATTR_NAME_2) then
            local tbl_14 = {}
            if Players_upvr.LocalPlayer:GetAttribute(GarageConsts_upvr.AERIAL_SPAWN_ATTR_NAME) ~= true then
                AERIAL_SPAWN_ATTR_NAME_2 = false
            else
                AERIAL_SPAWN_ATTR_NAME_2 = true
            end
            tbl_14.aerialEnabled = AERIAL_SPAWN_ATTR_NAME_2
            arg1:setState(tbl_14)
        end
    end
end
function any_extend_result1.willUnmount(arg1) -- Line 418
    arg1.maid:DoCleaning()
end
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 422
    return {
        sortId = arg1.garageSort;
    }
end, function(arg1) -- Line 430
    return {
        onSelectSort = function(arg1_3) -- Line 432, Named "onSelectSort"
            local var133 = 0
            for _ in EnumSort_upvr:GetEnumItems() do
                var133 += 1
            end
            arg1({
                type = "setSort";
                id = arg1_3 % var133 + 1;
            })
        end;
    }
end)(any_extend_result1)