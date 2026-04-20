local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact.PureComponent:extend("PortalSpawn")
local Players_upvr = game:GetService("Players")
local GarageConsts_upvr = require(script.Parent.Parent.GarageConsts)
local GamepassUtils_upvr = require(ReplicatedStorage.Gamepass.GamepassUtils)
local createElement_upvr = Roact.createElement
local PortalBase_upvr = require(script.Parent.PortalBase)
function any_extend_result1.render(arg1) -- Line 12
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local tbl_5 = {}
    local tbl_6 = {}
    for i, v in ipairs(arg1.props.receipt) do
        tbl_6[v.name] = true
    end
    local Vehicles_4 = arg1.props.owned.Vehicles
    if Vehicles_4 then
        i = Vehicles_4
        for i_2, v_2 in pairs(i) do
            if v_2 == true then
                ({})[i_2] = true
            end
        end
    end
    local Vehicles_3 = arg1.props.favorited.Vehicles
    if Vehicles_3 then
        for i_3, v_3 in pairs(Vehicles_3) do
            if v_3 == true then
                ({})[i_3] = true
            end
        end
    end
    for i_4 = 1, #arg1.props.items do
        local var160_upvr = arg1.props.items[i_4]
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        local var161 = ({})[var160_upvr.name] or false
        local var162
        if not var161 then
            var162 = var160_upvr.price
            if not not var162 then
                var162 = var160_upvr.price
                if var162 ~= 0 then
                else
                end
            end
        end
        var162 = arg1.props
        var162 = var162.premium
        if not var162 then
            var162 = arg1.props
            var162 = var162.inPhysical
            if not var162 then
                var162 = var160_upvr.lite
                if not var162 then
                    var162 = Players_upvr
                    var162 = var162.LocalPlayer
                    if var162 then
                        if Players_upvr.LocalPlayer:GetAttribute(GarageConsts_upvr.AERIAL_SPAWN_ATTR_NAME) ~= true then
                            var162 = false
                        else
                            var162 = true
                        end
                    end
                end
            end
        end
        if not var162 then
            if arg1.props.gamepassOwned[GamepassUtils_upvr.EnumGamepass.BOSS] then
                if var160_upvr.name ~= "Wraith" then
                else
                end
            end
        end
        var162 = true
        if not var162 then
            if arg1.props.gamepassOwned[GamepassUtils_upvr.EnumGamepass.SWAT] then
                if var160_upvr.name ~= "SWATVan" then
                else
                end
            end
        end
        var162 = true
        local tbl_9_upvr = {
            selected = tbl_6[var160_upvr.name];
            owned = var161;
        }
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        tbl_9_upvr.faved = ({})[var160_upvr.name] or false
        local var164 = var161
        if not var164 then
            var164 = true
            if var164 then
                var164 = var160_upvr.available
            end
        end
        tbl_9_upvr.masked = not var164
        tbl_9_upvr.locked = not var162
        function tbl_9_upvr.onSelect() -- Line 61
            if not tbl_9_upvr.masked then
                arg1.props.onClickSpawnVehicle(var160_upvr)
            else
                arg1.props.onAttemptPurchaseVehicle(var160_upvr, tbl_9_upvr)
            end
        end
        function tbl_9_upvr.onFavorite(arg1_5) -- Line 68
            if arg1.props.attemptFavoriteItem then
                arg1.props.attemptFavoriteItem("Vehicles", var160_upvr.name, arg1_5)
            end
            arg1.props.onFavoriteItem("Vehicles", var160_upvr.name, arg1_5)
        end
        tbl_5[i_4] = tbl_9_upvr
    end
    local module_3 = {}
    var160_upvr = "SPAWN"
    module_3.title = var160_upvr
    var160_upvr = arg1.props
    var160_upvr = var160_upvr.items
    module_3.items = var160_upvr
    module_3.metadata = tbl_5
    var160_upvr = arg1.props
    var160_upvr = var160_upvr.sortId
    module_3.sortId = var160_upvr
    var160_upvr = arg1.props
    var160_upvr = var160_upvr.cornerPixel
    module_3.cornerPixel = var160_upvr
    var160_upvr = arg1.props
    var160_upvr = var160_upvr.portalRatio
    module_3.portalRatio = var160_upvr
    var160_upvr = arg1.props
    var160_upvr = var160_upvr.paddingRatio
    module_3.paddingRatio = var160_upvr
    var160_upvr = arg1.props
    var160_upvr = var160_upvr.onSelectSort
    module_3.onSelectSort = var160_upvr
    var160_upvr = true
    module_3.sortEnabled = var160_upvr
    var160_upvr = arg1.props
    var160_upvr = var160_upvr.showFavorited
    module_3.showFavorited = var160_upvr
    var160_upvr = arg1.props
    var160_upvr = var160_upvr.onToggleFavorited
    module_3.onToggleFavorited = var160_upvr
    var160_upvr = arg1.props
    var160_upvr = var160_upvr.showAll
    module_3.showAll = var160_upvr
    var160_upvr = arg1.props
    var160_upvr = var160_upvr.onToggleAll
    module_3.onToggleAll = var160_upvr
    var160_upvr = arg1.props
    var160_upvr = var160_upvr.colsPerRow
    module_3.colsPerRow = var160_upvr
    var160_upvr = arg1.props
    var160_upvr = var160_upvr.rowsPerPage
    module_3.rowsPerPage = var160_upvr
    return createElement_upvr(PortalBase_upvr, module_3)
end
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 96
    return {
        receipt = arg1.garageReceipt;
        inPhysical = arg1.garageInPhysical;
        favorited = arg1.garageFavorited;
        gamepassOwned = arg1.gamepassOwned;
        premium = arg1.garagePremium;
    }
end, function(arg1) -- Line 105
    return {
        onFavoriteItem = function(arg1_6, arg2, arg3) -- Line 107, Named "onFavoriteItem"
            local tbl_7 = {
                type = "setCategoryItemFavorited";
            }
            tbl_7.category = arg1_6
            tbl_7.name = arg2
            tbl_7.favorited = arg3
            arg1(tbl_7)
        end;
    }
end)(any_extend_result1)