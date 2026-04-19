-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPBmFzc2VydAR0eXBlBXRhYmxlBWNsb25lCXdvcmtzcGFjZQlNYWduaXR1ZGUKQ2FuQ29sbGlkZQZpbnNlcnQaUmF5SWdub3JlTm9uQ29sbGlkZVNwZWNpYWwhUmF5SWdub3JlTm9uQ29sbGlkZVdpdGhJZ25vcmVMaXN0E1JheUlnbm9yZU5vbkNvbGxpZGUDUmF5A25ldw1GaW5kUGFydE9uUmF5G0ZpbmRQYXJ0T25SYXlXaXRoSWdub3JlTGlzdAAEFAgDAAAAaA4FBQBWCQcAuwEJAqQIAQAAAABAnwgCAQ4EFAC7KAQDUgkEAKQIAwAAACBAnwgCAvAIBwAEAACApAgGAAAUQIBSCQQAnwgCAlIECABlAAkA/wgAAAEAAABSCQQAxQgJAgEAAABSBAgAZQACAP8EAAAAAAAAqQMBAIwIAADGCQAAUgoAADkLAQDGDAAAbw0HAGANQgACAAAAjA0FAH0NBgAIAAAAxg0AAFIOCgBSDwsAUhAMAIINBQD7DQAAUg4AAAkPAQKfDQMCDgMNAPsOAQCkDwkAAACAQFIQDQBSEQQAqRIAAFYTBgCfDgYFUgkOAFIKDwBSCxAAUgwRAGUADAD7DgIApA8JAAAAgEBSEA0AUhEEAKkSAABWEwYAnw4GBVIJDgBSCg8AUgsQAFIMEQAmDgAKTQ4OqgoAAAAOCRMAKwUJACsHAwBNDwnTCwAAACsPBQAOBwUAUg8HAFIQCQCfDwICDg8BAIIJBQCeNAQFCQAAAFIQBABSEQkApA8NAAAwQICfDwMBZQACAFIACgAmAgIOlQgIDkgAvP+CCQUADwMBBAAAAEADAgQAACBAAwMDBAQAFECAAnsUrkfheoQ/AwUEAACAQAMGAwcDCAQAMECAAgAAAAAAAPA/AAUJARgAAQAAAAACAQAAAAAAAAEAAAAAAAIAAAAAAAADAAIDAQAAAAEAAAEAAAEAAAAAAgAAAAECAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAgAAAQEAAgAAAAEAAAACAgAAAAAAAAADAQLmHA8AAAAAEAcBAAAAC/sHAABSCAAAUgkBAFIKAgCpCwEAUgwDAFINBABSDgUAUg8GAJ8HCQCCBwAAAAA+CgEYAAEBAQEBAQEB+ABHAAAAABAHAQAAAAv7BwAAUggAAFIJAQBSCgIAqQsAAFIMAwBSDQQAUg4FAFIPBgCfBwkAggcAAAAAUgsBGAABAQEBAQEBAfgAWwAAAAAHAAABAgAZowAAAKQAAgAABACApAEEAAAAMEBNAQHtBQAAAKQCBAAAADBATQICRwYAAADAAwcAEgAAABIAAgASAAEAwAQIABIAAwDABQkAEgADAOIGDAAwBQZXCgAAADAEBsgLAAAAggYCAA0DDAMNBAAEAIADBQQAADBAAw4DDwYABgEGAgMLAwoFAgoLAwABAgEAARgAAQABAAAAAQAAAAEAAAA5ABQAFAEAAQAAAQAAAAAD9HbKbYnCxRXxxD1ZC5Ug8IRu3RnGsqBs

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:37
-- Luau version 6, Types version 3
-- Time taken: 0.003258 seconds

local new_upvr = Ray.new
local FindPartOnRayWithIgnoreList_upvr = workspace.FindPartOnRayWithIgnoreList
local FindPartOnRay_upvr = workspace.FindPartOnRay
local function RayIgnoreNonCollideSpecial_upvr(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) -- Line 5, Named "RayIgnoreNonCollideSpecial"
    --[[ Upvalues[3]:
        [1]: new_upvr (readonly)
        [2]: FindPartOnRayWithIgnoreList_upvr (readonly)
        [3]: FindPartOnRay_upvr (readonly)
    ]]
    if arg6 then
        assert(not arg8)
    end
    if arg5 then
        if type(arg5) == "table" then
        else
            local _ = {table.clone(arg5)}
        end
    else
    end
    while true do
        local var6
        if 0.01 >= arg3 then break end
        if 5 <= 0 then
            return nil, var6, -arg2, nil
        end
        if true then
            local FindPartOnRayWithIgnoreList_upvr_result1, FindPartOnRayWithIgnoreList_upvr_result2, FindPartOnRayWithIgnoreList_upvr_result3, _ = FindPartOnRayWithIgnoreList_upvr(workspace, new_upvr(arg1, arg2 * arg3), {}, false, not arg7)
            local _ = FindPartOnRayWithIgnoreList_upvr_result1
            var6 = FindPartOnRayWithIgnoreList_upvr_result2
            local var12 = var6
        else
            -- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
            local var3_result1, FindPartOnRay_upvr_result2, var3_result3, var3_result4 = FindPartOnRay_upvr(workspace, new_upvr(arg1, arg2 * arg3), {}, false, not arg7)
            var12 = FindPartOnRay_upvr_result2
        end
        if var3_result1 then
            local function INLINED() -- Internal function, doesn't exist in bytecode
                -- KONSTANTERROR: Expression was reused, decompilation is incorrect
                return var3_result1.CanCollide
            end
            local function INLINED_2() -- Internal function, doesn't exist in bytecode
                -- KONSTANTERROR: Expression was reused, decompilation is incorrect
                return arg8(var3_result1)
            end
            if arg6 or not arg8 and INLINED() or arg8 and INLINED_2() then
                -- KONSTANTERROR: Expression was reused, decompilation is incorrect
                return var3_result1, var12, var3_result3, var3_result4
            end
            -- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
            table.insert({}, var3_result1)
        else
        end
    end
    -- KONSTANTERROR: Expression was reused, decompilation is incorrect (x3)
    return var3_result1, var12, var3_result3, var3_result4
end
return {
    RayIgnoreNonCollide = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 82, Named "RayIgnoreNonCollide"
        --[[ Upvalues[1]:
            [1]: RayIgnoreNonCollideSpecial_upvr (readonly)
        ]]
        return RayIgnoreNonCollideSpecial_upvr(arg1, arg2, arg3, false, arg4, arg5, arg6, arg7)
    end;
    RayIgnoreNonCollideWithIgnoreList = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 62, Named "RayIgnoreNonCollideWithIgnoreList"
        --[[ Upvalues[1]:
            [1]: RayIgnoreNonCollideSpecial_upvr (readonly)
        ]]
        return RayIgnoreNonCollideSpecial_upvr(arg1, arg2, arg3, true, arg4, arg5, arg6, arg7)
    end;
}