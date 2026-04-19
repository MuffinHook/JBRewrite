-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:15
-- Luau version 6, Types version 3
-- Time taken: 0.012292 seconds

local EnumSort_upvr = require(script.Parent.EnumSort)
local module_upvr = {
    getSortFunc = function(arg1) -- Line 6, Named "getSortFunc"
        --[[ Upvalues[1]:
            [1]: EnumSort_upvr (readonly)
        ]]
        if arg1 == EnumSort_upvr.Alphabetical then
            return function(arg1_2, arg2) -- Line 8
                -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
                local title = arg1_2.title
                local var5
                if arg1_2.isNone then
                    title = '\x00'
                end
                if arg2.isNone then
                    var5 = '\x00'
                end
                if title >= var5 then
                else
                end
                return true
            end
        end
        if arg1 == EnumSort_upvr.Price then
            return function(arg1_3, arg2) -- Line 20
                -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
                local var8
                if not arg1_3.priceSortMetric and not arg1_3.price then
                end
                var8 = arg1_3.hidden
                if var8 then
                end
                var8 = arg2.priceSortMetric
                if not var8 then
                    var8 = arg2.price
                    if not var8 then
                        var8 = 0
                    end
                end
                if arg2.hidden then
                    var8 = 0
                end
                if arg1_3.isNone or arg1_3.limited then
                end
                if arg2.isNone or arg2.limited then
                    var8 = -1
                end
                if var8 >= -1 then
                else
                end
                return true
            end
        end
        if arg1 == EnumSort_upvr.PriceLow then
            return function(arg1_4, arg2) -- Line 38
                -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
                local var11
                if not var11 then
                    var11 = arg1_4.price
                    if not var11 then
                        var11 = 0
                    end
                end
                if arg1_4.hidden then
                    var11 = 0
                end
                if not arg2.priceSortMetric then
                    if not arg2.price then
                    end
                end
                if arg2.hidden then
                end
                if arg1_4.isNone or arg1_4.limited then
                    var11 = math.huge
                end
                if arg2.isNone or arg2.limited then
                end
                if var11 >= math.huge then
                else
                end
                return true
            end
        end
        if arg1 == EnumSort_upvr.Newest then
            return function(arg1_5, arg2) -- Line 56
                -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
                local var13
                if not var13 then
                    var13 = arg1_5.primaryIndex
                end
                if not arg2.timeSortMetric then
                end
                if arg1_5.isNone then
                    var13 = (-math.huge)
                end
                if arg2.isNone then
                end
                if var13 >= (-math.huge) then
                else
                end
                return true
            end
        end
        if arg1 == EnumSort_upvr.Popular then
            return function(arg1_6, arg2) -- Line 68
                -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
                local var15
                if not var15 then
                    var15 = arg1_6.primaryIndex + 9999
                end
                if not arg2.salesIndex then
                end
                if arg1_6.isNone then
                    var15 = 0
                end
                if arg2.isNone then
                end
                if var15 >= 0 then
                else
                end
                return true
            end
        end
        error("invalid sort enum passed", arg1)
    end;
}
function module_upvr.getTradeSortFunc(arg1) -- Line 83
    --[[ Upvalues[2]:
        [1]: EnumSort_upvr (readonly)
        [2]: module_upvr (readonly)
    ]]
    if arg1 == EnumSort_upvr.Popular then
        return function(arg1_7, arg2) -- Line 85
            -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
            local var17 = arg1_7.tradePopularMetric or 0
            local var18
            if arg1_7.isNone then
                var17 = (-math.huge)
            end
            if arg2.isNone then
                var18 = (-math.huge)
            end
            if var18 >= var17 then
            else
            end
            return true
        end
    end
    return module_upvr.getSortFunc(arg1)
end
return module_upvr