-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMMAm9zBWNsb2NrCkRpc2Nvbm5lY3QTTWF4VmlzaWJsZUdyYXBoZW1lcwRUZXh0BHV0ZjgDbGVuCUhlYXJ0YmVhdAdDb25uZWN0BGdhbWUKUnVuU2VydmljZQpHZXRTZXJ2aWNlAAMGAAYAAAAapAACAAAEAICfAAEC+wIAACYBAAL7AwEA7AIBA4wDAQBgAwYAAgAAAIwCAQD7AwIAvAMDGgMAAACfAwIB+wQDAAkDAgT7BAQAMAMEvQQAAAD7BAUADgQDAPsEBQBSBQMAnwQCAYIAAQAFAwEDAgQABACAAwMDBAATAAEYAAAAAQABAAEAAAEBAAAAAgABAAABAAEAAAIUAAAAAAsEAQAACQYAAAUEAw+ChR+QAgIAMAAB9QEAAACMBAAAMAQBvQIAAACkBAUAABAwgJ8EAQKkBQgAABxggFIGAACfBQIC7AYFAsYHAAD7CAAATQgI/QkAAADZCgAAEgAEABIABgASAQf/EgAFABIAAQASAAMAvAgIxwoAAACfCAMCUgcIAMEHAACCBwIACwIAAAAAAAA5QAMFAwQDAQMCBAAQMIADBgMHBAAcYIADCAMJAQADAAEYAAIAAQAABwAAAQAAAAECAQAAAAAAAAAAAAAAAAAOAAQAAAAAAwAAAQIACqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwLAAQQAEgAAAIIBAgAFAwoEAAAAQAMLAwwGAQEBAQABGAAAAAAAAAACAAABAAAAAAIyPh8qeIexEEv7Ga5ba4rxQiYIXgD6dSs=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:52
-- Luau version 6, Types version 3
-- Time taken: 0.001791 seconds

local RunService_upvr = game:GetService("RunService")
return function(arg1, arg2, arg3, arg4) -- Line 3
    --[[ Upvalues[1]:
        [1]: RunService_upvr (readonly)
    ]]
    arg2.Text = arg1
    arg2.MaxVisibleGraphemes = 0
    local utf8_len_result1_upvr = utf8.len(arg1)
    local os_clock_result1_upvr = os.clock()
    local var6_upvr = utf8_len_result1_upvr / (arg3 or 25)
    local var7_upvw
    var7_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 19
        --[[ Upvalues[6]:
            [1]: os_clock_result1_upvr (readonly)
            [2]: var6_upvr (readonly)
            [3]: var7_upvw (read and write)
            [4]: utf8_len_result1_upvr (readonly)
            [5]: arg2 (readonly)
            [6]: arg4 (readonly)
        ]]
        local var8 = (os.clock() - os_clock_result1_upvr) / var6_upvr
        if 1 < var8 then
            var8 = 1
            var7_upvw:Disconnect()
        end
        local var9 = var8 * utf8_len_result1_upvr
        arg2.MaxVisibleGraphemes = var9
        if arg4 then
            arg4(var9)
        end
    end)
    return var7_upvw
end