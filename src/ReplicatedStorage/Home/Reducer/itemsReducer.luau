local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local function _(arg1) -- Line 6, Named "defaultSort"
    table.sort(arg1, function(arg1_2, arg2) -- Line 8
        local var3
        if var3 ~= arg2.limited then
            var3 = arg2.limited
            return var3
        end
        var3 = arg1_2.season
        if var3 ~= arg2.season then
            if (arg2.season or math.huge) >= (arg1_2.season or math.huge) then
                var3 = false
            else
                var3 = true
            end
            return var3
        end
        if arg1_2.name >= arg2.name then
            var3 = false
        else
            var3 = true
        end
        return var3
    end)
end
local module = {}
local HomeItemUIUtils_upvr = require(ReplicatedStorage_upvr.Home.HomeItem.HomeItemUIUtils)
function module.setFurnitureCategory(arg1, arg2) -- Line 20
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local children_2, NONE_2, NONE = ReplicatedStorage_upvr.Resource.HomeItem:GetChildren()
    local var17
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [66.7]
    local MaxPlaced_2 = nil:FindFirstChild("MaxPlaced")
    if MaxPlaced_2 then
        var17 = MaxPlaced_2.Value
    else
        var17 = nil
    end
    local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [86.17]
        return nil == nil
    end
    local function decompInlinedCondition_4() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return 0.01 >= math.abs(arg2.upDot - nil)
    end
    if arg2.use == nil or arg2.use == 1 or arg2.upDot == nil or decompInlinedCondition_3() or decompInlinedCondition_4() then
        local Name_upvr_2 = nil.Name
        local tbl_4 = {
            module = "HomeItem";
            name = Name_upvr_2;
            title = Name_upvr_2;
        }
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [108.9]
        tbl_4.price = nil
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [110.11]
        tbl_4.level = nil
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [112.13]
        tbl_4.season = nil
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [114.15]
        tbl_4.topPct = nil
        local var21 = true
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        if nil == nil then
            var21 = true
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            if nil == nil then
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                var21 = not nil
            end
        end
        tbl_4.limited = var21
        tbl_4.maxPlaced = var17
        local function getInst() -- Line 57
            return HomeItemUIUtils_upvr.getModel(Name_upvr_2)
        end
        tbl_4.getInst = getInst
        tbl_4.updateCamera = HomeItemUIUtils_upvr.getUpdateCamera()
        tbl_4.getInstCompare = "HomeItem"..Name_upvr_2
        tbl_4.available = not tbl_4.limited
        table.insert({}, tbl_4)
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [155.8]
    if nil then
    else
    end
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [155.10]
    if nil then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
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
    table.sort(module_2, function(arg1_4, arg2_3) -- Line 8
        local var43
        if var43 ~= arg2_3.limited then
            var43 = arg2_3.limited
            return var43
        end
        var43 = arg1_4.season
        if var43 ~= arg2_3.season then
            if (arg2_3.season or math.huge) >= (arg1_4.season or math.huge) then
                var43 = false
            else
                var43 = true
            end
            return var43
        end
        if arg1_4.name >= arg2_3.name then
            var43 = false
        else
            var43 = true
        end
        return var43
    end)
    return module_2
end
return require(ReplicatedStorage_upvr.Rodux).createReducer({}, module)