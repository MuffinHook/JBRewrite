local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local function defaultSort(arg1) -- Line 6, Named "defaultSort"
    table.sort(arg1, function(arg1_2, arg2) -- Line 8
        if arg1_2.limited ~= arg2.limited then
            return arg2.limited
        end
        if arg1_2.season ~= arg2.season then
            return (arg1_2.season or math.huge) < (arg2.season or math.huge)
        end
        return arg1_2.name < arg2.name
    end)
end
local module = {}
local HomeItemUIUtils_upvr = require(ReplicatedStorage_upvr.Home.HomeItem.HomeItemUIUtils)
function module.setFurnitureCategory(arg1, arg2) -- Line 20
    local items = {}

    for _, homeItem in ReplicatedStorage_upvr.Resource.HomeItem:GetChildren() do
        local values = {}
        for _, child in homeItem:GetChildren() do
            if child:IsA("ValueBase") then
                values[child.Name] = child.Value
            end
        end

        local itemUse = values.Use or 1
        local itemUpDot = values.UpDot or 1
        local useMatches = arg2.use == nil or itemUse == arg2.use
        local upDotMatches = arg2.upDot == nil or math.abs(itemUpDot - arg2.upDot) <= 0.01

        if useMatches and upDotMatches and not values.HiddenAll and not values.Hidden and not values.VIP then
            local itemName = homeItem.Name
            local tbl_4 = {
                module = "HomeItem";
                name = itemName;
                title = itemName;
                price = values.Price;
                level = values.Level;
                season = values.Season;
                topPct = values.TopPct;
                maxPlaced = values.MaxPlaced;
            }

            tbl_4.limited = tbl_4.level ~= nil or tbl_4.season ~= nil or (not tbl_4.price and not values.None)
            tbl_4.available = not tbl_4.limited

            function tbl_4.getInst() -- Line 57
                return HomeItemUIUtils_upvr.getModel(itemName)
            end

            tbl_4.updateCamera = HomeItemUIUtils_upvr.getUpdateCamera()
            tbl_4.getInstCompare = "HomeItem"..itemName
            table.insert(items, tbl_4)
        end
    end

    defaultSort(items)
    return items
end
function module.setCategory(arg1, arg2) -- Line 69
    local var37_upvr
    if arg2.module == nil then
        var37_upvr = false
    else
        var37_upvr = true
    end
    assert(var37_upvr, "setCategory requires a module name")
    local SOME_2 = ReplicatedStorage_upvr.Home.HomeData:FindFirstChild(arg2.module)
    var37_upvr = assert
    var37_upvr(SOME_2, "setCategory requires a valid module name")
    var37_upvr = require(SOME_2)
    local module_2 = {}
    for _, v_upvr in var37_upvr.getItems(), nil do
        if not v_upvr.HiddenAll and not v_upvr.Hidden then
            local getInst
            if not v_upvr.VIP then
                local tbl = {}
                getInst = arg2.module
                tbl.module = getInst
                getInst = v_upvr.Name
                tbl.name = getInst
                getInst = v_upvr.Name
                tbl.title = getInst
                getInst = v_upvr.Price
                tbl.price = getInst
                getInst = v_upvr.Level
                tbl.level = getInst
                getInst = v_upvr.Season
                tbl.season = getInst
                getInst = v_upvr.TopPct
                tbl.topPct = getInst
                function getInst() -- Line 95
                    return var37_upvr.getInstance(v_upvr)
                end
                tbl.getInst = getInst
                getInst = var37_upvr.updateCamera
                tbl.updateCamera = getInst
                getInst = arg2.module..v_upvr.Name
                tbl.getInstCompare = getInst
                local function decompInlinedCondition_6() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    getInst = not tbl.price
                    return getInst
                end
                if tbl.level ~= nil or tbl.season ~= nil or decompInlinedCondition_6() then
                    getInst = not v_upvr.None
                end
                tbl.limited = getInst
                getInst = not tbl.limited
                tbl.available = getInst
                getInst = table.insert
                getInst(module_2, tbl)
            end
        end
    end
    defaultSort(module_2)
    return module_2
end
return require(ReplicatedStorage_upvr.Rodux).createReducer({}, module)
