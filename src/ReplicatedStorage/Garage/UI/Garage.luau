local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("Garage")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
}
function any_extend_result1.init(arg1) -- Line 23
    arg1:setState({
        showAll = false;
        showFavorited = false;
    })
    function arg1.toggleAll() -- Line 28
        arg1:setState({
            showAll = not arg1.state.showAll;
        })
    end
    function arg1.toggleFavorited() -- Line 33
        arg1:setState({
            showFavorited = not arg1.state.showFavorited;
        })
    end
end
local PortalSpawn_upvr = require(script.Parent.PortalSpawn)
local PortalCustomize_upvr = require(script.Parent.PortalCustomize)
local SaleConsts_upvr = require(ReplicatedStorage.Sale.SaleConsts)
local PortalSaves_upvr = require(script.Parent.PortalSaves)
local createElement_upvr = Roact.createElement
local Categories_upvr = require(script.Parent.Categories)
local Lite_upvr = require(script.Parent.Lite)
local RoundButton_upvr = require(script.Parent.RoundButton)
local CashBar_upvr = require(script.Parent.CashBar)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
local Receipt_upvr = require(script.Parent.Receipt)
function any_extend_result1.render(arg1) -- Line 39
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var30
    if arg1.props.disabled then return end
    local var31 = false
    var30 = arg1.props
    var30 = var30.page
    if var30 == "Saves" then
        var30 = arg1.props.receipt[1]
        if var30 then
            var31 = arg1.props.saves[var30.name]
        end
    end
    if var31 then
        var30 = 3
    else
        var30 = 2
    end
    local tbl_8 = {}
    if arg1.props.page == "Spawn" then
        tbl_8.onClickSpawnVehicle = arg1.props.onClickSpawnVehicle
        tbl_8.onAttemptPurchaseVehicle = arg1.props.onAttemptPurchaseVehicle
        tbl_8.colsPerRow = arg1.props.colsPerRow
        tbl_8.rowsPerPage = arg1.props.rowsPerPage
    elseif arg1.props.page == "Customize" then
        tbl_8.attemptEquipItem = arg1.props.attemptEquipItem
        tbl_8.colsPerRow = arg1.props.colsPerRow
        tbl_8.rowsPerPage = arg1.props.rowsPerPage
        if arg1.props.category == SaleConsts_upvr.CATEGORY_NAME then
            tbl_8.colsPerRow = 6
            tbl_8.rowsPerPage = 1.5
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
    elseif arg1.props.page == "Saves" then
    end
    tbl_8.attemptFavoriteItem = arg1.props.attemptFavoriteItem
    tbl_8.showAll = arg1.state.showAll
    tbl_8.onToggleFavorited = arg1.toggleFavorited
    tbl_8.showFavorited = arg1.state.showFavorited
    tbl_8.onToggleAll = arg1.toggleAll
    if PortalSaves_upvr == nil then
    else
    end
    assert(true, "missing Portal for this page")
    if arg1.props.page == "Customize" then
        local _ = {
            mainRatio = 0.6346339890357949;
            layoutOrder = 5;
            cornerPixel = 4;
            paddingRatio = 78.72;
            categoriesPerPage = arg1.props.categoriesPerPage;
        }
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1.props.page == "Spawn" then
        local tbl_7 = {
            mainRatio = 0.6346339890357949;
            layoutOrder = 5;
            cornerPixel = 4;
            paddingRatio = 39.36;
            upgraded = arg1.props.premium;
            inPhysical = arg1.props.inPhysical;
            getRemainingDebounce = arg1.props.getRemainingDebounce;
            onRequestPremiumUpgrade = arg1.props.onRequestPremiumUpgrade;
        }
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function any_extend_result1.didMount(arg1) -- Line 567
end
function any_extend_result1.willUnmount(arg1) -- Line 568
end
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 569
    if arg1.props.disabled ~= arg2.disabled and arg1.props.disabled then
        arg1:setState({
            showAll = false;
            showFavorited = false;
        })
    end
end
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 592
    return {
        cash = arg1.cash;
        items = arg1.garageItems;
        owned = arg1.garageOwned;
        equipped = arg1.garageEquipped;
        page = arg1.garagePage;
        categories = arg1.garageCategories;
        category = arg1.garageCategory;
        sortId = arg1.garageSort;
        receipt = arg1.garageReceipt;
        saves = arg1.garageSaves;
        premium = arg1.garagePremium;
        inPhysical = arg1.garageInPhysical;
        inVehicle = arg1.garageInVehicle;
    }
end, function(arg1) -- Line 608
    return {
        onSelectPage = function(arg1_2) -- Line 610, Named "onSelectPage"
            local var40
            if arg1_2.pageName == nil then
                var40 = false
            else
                var40 = true
            end
            assert(var40, "pageName is required")
            if Players_upvr.LocalPlayer then
                var40 = Players_upvr
                var40 = var40.LocalPlayer
                var40 = var40.PlayerGui
                Audio_upvr.ObjectLocal(var40, 6105461542, {
                    Volume = 0.25;
                })
            end
            local tbl_2 = {}
            var40 = "setPage"
            tbl_2.type = var40
            var40 = arg1_2.pageName
            tbl_2.pageName = var40
            var40 = arg1_2.sortId
            tbl_2.sortId = var40
            var40 = arg1_2.categoryName
            tbl_2.categoryName = var40
            var40 = arg1_2.saves
            tbl_2.garageSaves = var40
            var40 = arg1_2.garageOwned
            tbl_2.garageOwned = var40
            var40 = arg1
            var40(tbl_2)
        end;
        onClickSaveSlot = function(arg1_3, arg2) -- Line 628, Named "onClickSaveSlot"
            local tbl_4 = {
                type = "setSaveSlot";
            }
            tbl_4.name = arg1_3
            tbl_4.equipped = arg2
            arg1(tbl_4)
        end;
        onClickLoadSlot = function(arg1_4, arg2) -- Line 636, Named "onClickLoadSlot"
            local tbl_3 = {
                type = "loadSaveSlot";
            }
            tbl_3.name = arg1_4
            arg1(tbl_3)
        end;
    }
end)(any_extend_result1)