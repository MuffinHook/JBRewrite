local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage_upvr.Roact)
local SafesConsts_upvr = require(ReplicatedStorage_upvr.Safes.SafesConsts)
local SAFE_DATA_upvr = SafesConsts_upvr.SAFE_DATA
local any_extend_result1 = Roact.PureComponent:extend("Safes")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
    position = UDim2.new(0, 0, 0, 0);
    anchorPoint = Vector2.new(0, 0);
}
function any_extend_result1.init(arg1) -- Line 24
    arg1:_computeShopItems()
    arg1:_computeShopSidebarItems()
    function arg1.onSelectBuySafes() -- Line 29
        arg1.props.setSafesInventoryOpen(false)
    end
    function arg1.onSelectOpenSafes() -- Line 33
        arg1.props.setSafesInventoryOpen(true)
    end
    function arg1.onSelectExit() -- Line 36
        arg1.props.setSafesOpen(false)
    end
    function arg1.onSelectPurchase() -- Line 41
        local typeEnum = arg1.state.shopSidebarItems[arg1.props.safesSelectedTypeEnum].typeEnum
        local var12
        if typeEnum == nil then
            var12 = false
        else
            var12 = true
        end
        assert(var12, "missing typeEnum")
        ReplicatedStorage_upvr:FindFirstChild(SafesConsts_upvr.SAFE_PURCHASE_REMOTE_NAME):FireServer(typeEnum)
    end
    function arg1.onSafeOpen(arg1_2) -- Line 49
        ReplicatedStorage_upvr:FindFirstChild(SafesConsts_upvr.SAFE_OPEN_REMOTE_NAME):FireServer(arg1_2)
    end
end
local PlayerDataConsts_upvr = require(ReplicatedStorage_upvr.PlayerData.PlayerDataConsts)
local ItemOwnershipUtils_upvr = require(ReplicatedStorage_upvr.App.ItemOwnershipUtils)
function any_extend_result1._isRewardOwned(arg1, arg2) -- Line 54
    if arg2.Type ~= "UniqueItem" then
        return false
    end
    if arg2.ItemType == PlayerDataConsts_upvr.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
        local CategoryName = arg2.CategoryName
        local ItemName_2 = arg2.ItemName
        if not CategoryName or not ItemName_2 then
            return false
        end
        return ItemOwnershipUtils_upvr.isVehicleCustomizationOwned(CategoryName, ItemName_2)
    end
    if arg2.ItemType == PlayerDataConsts_upvr.VEHICLE_ITEM_TYPE then
        local Make = arg2.Make
        if not Make then
            return false
        end
        return ItemOwnershipUtils_upvr.isVehicleOwned(Make)
    end
    if arg2.ItemType == PlayerDataConsts_upvr.HOME_ITEM_ITEM_TYPE then
        local ItemName = arg2.ItemName
        if not ItemName then
            return false
        end
        return ItemOwnershipUtils_upvr.isHomeItemOwned(ItemName)
    end
    return false
end
local getItemPropsFromRewardData_upvr = require(ReplicatedStorage_upvr.RewardSpinner.getItemPropsFromRewardData)
function any_extend_result1._computeShopItems(arg1) -- Line 82
    local tbl_8 = {}
    for _, v in SAFE_DATA_upvr[arg1.props.safesSelectedTypeEnum].RewardData do
        local var20_result1 = getItemPropsFromRewardData_upvr(v)
        var20_result1.owned = arg1:_isRewardOwned(v)
        table.insert(tbl_8, var20_result1)
    end
    table.sort(tbl_8, function(arg1_3, arg2) -- Line 93
        local rarityIndex = arg1_3.rarityIndex
        if rarityIndex == arg2.rarityIndex then
            if arg1_3.title >= arg2.title then
                rarityIndex = false
            else
                rarityIndex = true
            end
            return rarityIndex
        end
        if arg2.rarityIndex >= arg1_3.rarityIndex then
            rarityIndex = false
        else
            rarityIndex = true
        end
        return rarityIndex
    end)
    arg1:setState({
        shopItems = tbl_8;
    })
end
function any_extend_result1._computeShopSidebarItems(arg1) -- Line 103
    local tbl_2 = {}
    for i_2, v_2 in SAFE_DATA_upvr do
        table.insert(tbl_2, {
            typeEnum = i_2;
            imageId = v_2.ImageId;
        })
    end
    arg1:setState({
        shopSidebarItems = tbl_2;
    })
end
local TableUtils_upvr = require(ReplicatedStorage_upvr.Std.TableUtils)
local createElement_upvr = Roact.createElement
local SafesInventory_upvr = require(script.Parent.SafesInventory)
local SafesShop_upvr = require(script.Parent.SafesShop)
function any_extend_result1.render(arg1) -- Line 116
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    if not arg1.props.open then return end
    local tbl_7 = {}
    for i_3 = 1, #arg1.state.shopSidebarItems do
        local typeEnum_upvr = arg1.state.shopSidebarItems[i_3].typeEnum
        local tbl_3 = {
            count = 0;
        }
        if typeEnum_upvr == arg1.props.safesSelectedTypeEnum then
            tbl_3.selected = true
        end
        function tbl_3.onSelect() -- Line 131
            arg1.props.setSafesSelectedSafeTypeEnum(typeEnum_upvr)
        end
        tbl_7[typeEnum_upvr] = tbl_3
    end
    for i_4, v_3 in arg1.props.safesInventoryItems do
        local var61 = tbl_7[v_3.typeEnum]
        var61.count += 1
        local var62
    end
    if arg1.props.inventoryOpen then
        local any_filter_result1 = TableUtils_upvr.filter(arg1.props.safesInventoryItems, function(arg1_4) -- Line 141
            local var64
            if arg1_4.typeEnum ~= arg1.props.safesSelectedTypeEnum then
                var64 = false
            else
                var64 = true
            end
            return var64
        end)
        local tbl_6 = {}
        v_3 = 1
        i_4 = 1
        for i_5 = v_3, #any_filter_result1, i_4 do
            local tbl_4 = {}
            local var69_upvr = any_filter_result1[i_5]
            function tbl_4.onSelect() -- Line 149
                arg1.onSafeOpen(var69_upvr.itemOwnedId)
            end
            table.insert(tbl_6, tbl_4)
            local var70
        end
        i_4 = SafesInventory_upvr
        var69_upvr = arg1.props
        var69_upvr = var69_upvr.size
        ;({}).size = var69_upvr
        var69_upvr = arg1.props
        var69_upvr = var69_upvr.position
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        ;({}).position = var69_upvr
        var69_upvr = arg1.props
        var69_upvr = var69_upvr.anchorPoint
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        ;({}).anchorPoint = var69_upvr
        var69_upvr = arg1.state
        var69_upvr = var69_upvr.shopSidebarItems
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        ;({}).sidebarItems = var69_upvr
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        ;({}).sidebarItemMetadata = var62
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        ;({}).items = var70
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        ;({}).itemMetadata = tbl_6
        var69_upvr = arg1.onSelectBuySafes
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        ;({}).onSelectBuySafes = var69_upvr
        var69_upvr = arg1.onSelectExit
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        ;({}).onSelectExit = var69_upvr
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return createElement_upvr(i_4, {})
    end
    local module = {
        size = arg1.props.size;
        position = arg1.props.position;
        anchorPoint = arg1.props.anchorPoint;
        items = arg1.state.shopItems;
        sidebarItems = arg1.state.shopSidebarItems;
        sidebarItemMetadata = var62;
    }
    var69_upvr = arg1.props
    var69_upvr = var69_upvr.safesSelectedTypeEnum
    module.selectedSafeTierData = SAFE_DATA_upvr[var69_upvr]
    module.onSelectOpenSafes = arg1.onSelectOpenSafes
    module.onSelectExit = arg1.onSelectExit
    module.onSelectPurchase = arg1.onSelectPurchase
    module.policyCashAvailable = arg1.props.policyCashAvailable
    return createElement_upvr(SafesShop_upvr, module)
end
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 184
    if arg1.props.safesSelectedTypeEnum ~= arg2.safesSelectedTypeEnum or arg1.props.garageOwned ~= arg2.garageOwned then
        arg1:_computeShopItems()
    end
end
return require(ReplicatedStorage_upvr.RoactRodux).connect(function(arg1, arg2) -- Line 192
    return {
        safesSelectedTypeEnum = arg1.safesSelectedTypeEnum;
        safesInventoryItems = arg1.safesInventoryItems;
        inventoryOpen = arg1.safesInventoryOpen;
        open = arg1.safesOpen;
        garageOwned = arg1.garageOwned;
    }
end, function(arg1) -- Line 200
    return {
        setSafesSelectedSafeTypeEnum = function(arg1_5) -- Line 202, Named "setSafesSelectedSafeTypeEnum"
            local tbl_5 = {
                type = "setSafesSelectedSafeTypeEnum";
            }
            tbl_5.typeEnum = arg1_5
            arg1(tbl_5)
        end;
        setSafesInventoryOpen = function(arg1_6) -- Line 208, Named "setSafesInventoryOpen"
            local tbl = {
                type = "setSafesInventoryOpen";
            }
            tbl.value = arg1_6
            arg1(tbl)
        end;
        setSafesOpen = function(arg1_7) -- Line 214, Named "setSafesOpen"
            local tbl_9 = {
                type = "setSafesOpen";
            }
            tbl_9.value = arg1_7
            arg1(tbl_9)
        end;
    }
end)(any_extend_result1)
