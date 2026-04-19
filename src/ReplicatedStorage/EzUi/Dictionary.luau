-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMIBE5vbmUBIwZzZWxlY3QFcGFpcnMFbWVyZ2UIbmV3cHJveHkMZ2V0bWV0YXRhYmxlCl9fdG9zdHJpbmcAAwEAAAAAAAJvAAAAggACAAEDAQAHAAEYAAAIAAAAAAsAAQEAACWjAAAA/wAAAAAAAACMAwEAbwUAALs5BQOkBAIAAAAQQN0GAACfBAACUgEEAIwCAQCoARcAuzkDBKQEAgAAABBAUgUDAN0GAACfBAACRwQPAAAAAACkBQQAAAAwQFIGBACfBQIEFwUHAPsKAACaCQQACgAAAMYKAABqCgAIZQABAGoJAAhuBfj/AgAAAIsB6f+CAAIABQMCAwMEAAAQQAMEBAAAMEAACwUBGAABAAIAAAAAAAAAAAABAAAAAAACAAEAAAAAAQAAAQAAAvwA/A4LAAAAAAMAAAECABWjAAAApAABAAAAAECpAQEAnwACArs8AANSAgAApAEDAAAAIECfAQICwAIEADACAQYFAAAAwAEGABIAAADiAgkAMAACPwcAAAAwAQIfCAAAAIICAgAKAwYEAAAAQAMHBAAAIEAGAAMIBgEDAQMFBQIHCAIAAQEAARgABQAAAAEAAAAAAAAABAAUAQABAAABAAAAAAKvXrNrraL/oWHOi87DfKLq30akH52a2Wo=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:39
-- Luau version 6, Types version 3
-- Time taken: 0.001605 seconds

local newproxy_result1_upvr = newproxy(true)
getmetatable(newproxy_result1_upvr).__tostring = function() -- Line 7
    return "None"
end
return {
    None = newproxy_result1_upvr;
    merge = function(...) -- Line 11, Named "merge"
        --[[ Upvalues[1]:
            [1]: newproxy_result1_upvr (readonly)
        ]]
        for i = 1, select('#', ...) do
            local selected_arg = select(i, ...)
            if selected_arg ~= nil then
                for i_2, v in pairs(selected_arg) do
                    if v == newproxy_result1_upvr then
                        ({})[i_2] = nil
                    else
                        -- KONSTANTERROR: Expression was reused, decompilation is incorrect
                        ;({})[i_2] = v
                    end
                end
            end
        end
        -- KONSTANTERROR: Expression was reused, decompilation is incorrect
        return {}
    end;
}