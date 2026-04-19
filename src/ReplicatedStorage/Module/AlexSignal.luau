-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:20
-- Luau version 6, Types version 3
-- Time taken: 0.006332 seconds

local module_2 = {}
local tbl_upvr = {}
local random_upvr = math.random
local function _() -- Line 8, Named "GUID"
    --[[ Upvalues[1]:
        [1]: random_upvr (readonly)
    ]]
    return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx":gsub("[xy]", function(arg1) -- Line 10
        --[[ Upvalues[1]:
            [1]: random_upvr (copied, readonly)
        ]]
        if arg1 ~= 'x' or not random_upvr(0, 15) then
        end
        return "%x":format(random_upvr(8, 11))
    end)
end
local function _() -- Line 15, Named "MakeListener"
    --[[ Upvalues[1]:
        [1]: random_upvr (readonly)
    ]]
    return {
        g = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx":gsub("[xy]", function(arg1) -- Line 10
            --[[ Upvalues[1]:
                [1]: random_upvr (copied, readonly)
            ]]
            if arg1 ~= 'x' or not random_upvr(0, 15) then
            end
            return "%x":format(random_upvr(8, 11))
        end);
        Callback = nil;
        SignalName = nil;
    }
end
function module_2.Broadcast(arg1, ...) -- Line 22
    --[[ Upvalues[1]:
        [1]: tbl_upvr (readonly)
    ]]
    local args_list_upvr = {...}
    for _, v_upvr in next, tbl_upvr do
        if v_upvr.SignalName == arg1 then
            local pcall_result1, pcall_result2 = pcall(function() -- Line 26
                --[[ Upvalues[2]:
                    [1]: v_upvr (readonly)
                    [2]: args_list_upvr (readonly)
                ]]
                v_upvr:Callback(unpack(args_list_upvr))
            end)
            if not pcall_result1 then
                warn("SIGNAL ERROR: ", pcall_result2)
            end
        end
    end
end
function module_2.Listen(arg1, arg2) -- Line 35
    --[[ Upvalues[2]:
        [1]: random_upvr (readonly)
        [2]: tbl_upvr (readonly)
    ]]
    local module = {
        g = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx":gsub("[xy]", function(arg1_2) -- Line 10
            --[[ Upvalues[1]:
                [1]: random_upvr (copied, readonly)
            ]]
            if arg1_2 ~= 'x' or not random_upvr(0, 15) then
            end
            return "%x":format(random_upvr(8, 11))
        end);
        Callback = nil;
        SignalName = nil;
    }
    module.SignalName = arg1
    module.Callback = arg2
    table.insert(tbl_upvr, module)
    return module
end
function module_2.Close(arg1) -- Line 42
    --[[ Upvalues[1]:
        [1]: tbl_upvr (readonly)
    ]]
    for i_2, v_2 in next, tbl_upvr do
        if v_2.g == arg1.g then
            return table.remove(tbl_upvr, i_2)
        end
    end
    return false
end
function module_2.Closeg(arg1) -- Line 51
    --[[ Upvalues[1]:
        [1]: tbl_upvr (readonly)
    ]]
    for i_3, v_3 in next, tbl_upvr do
        if v_3.g == arg1 then
            return table.remove(tbl_upvr, i_3)
        end
    end
    return false
end
function module_2.Closef(arg1) -- Line 59
    --[[ Upvalues[1]:
        [1]: tbl_upvr (readonly)
    ]]
    for i_4, v_4 in next, tbl_upvr do
        if v_4.Callback == arg1 then
            return table.remove(tbl_upvr, i_4)
        end
    end
    return false
end
return module_2