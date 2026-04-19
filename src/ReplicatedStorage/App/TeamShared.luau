-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMkC2lzTWFpbldvcmxkB3Jlc29sdmUYcHJvbWlzZUdldElzQmF0dGxlU2VydmVyB2FuZFRoZW4dcHJvbWlzZUlzVGVhbVN3aXRjaGluZ0VuYWJsZWQFYXdhaXQWaXNUZWFtU3dpdGNoaW5nRW5hYmxlZApHZXRQbGF5ZXJzDENob29zaW5nVGVhbQ5GaW5kRmlyc3RDaGlsZAVWYWx1ZQRUZWFtBE5hbWUGUG9saWNlCFByaXNvbmVyCENyaW1pbmFsClZpcE93bmVySWQIaXNTdHVkaW8IRW51bVRlYW0EbWF0aARjZWlsA21heAppc1RlYW1GdWxsBGdhbWUHUGxheWVycwpHZXRTZXJ2aWNlEVJlcGxpY2F0ZWRTdG9yYWdlB3JlcXVpcmUDU3RkB1Byb21pc2UDQXBwCFJ1blV0aWxzDVByaXZhdGVTZXJ2ZXISUHJpdmF0ZVNlcnZlclV0aWxzCFJlc291cmNlCFNldHRpbmdzAAUCAQAAAAACVgEAAIIBAgAAAA0AARgAAA4AAAAAAwADAAAAFPsAAABNAABQAAAAAJ8AAQIrAAYA+wABAE0AAB0BAAAAqQEAAJ8AAgCCAAAA+wACAE0AAOICAAAAnwABAsACAwC8AAC1BAAAAJ8AAwCCAAAABQMBAwIDAwYAAwQBAAkFARgAAAAAAAEAAAAAAAIAAAAAAAAAAAoAAAAAAwABAAAACfsAAABNAAD0AAAAAJ8AAQK8AAANAQAAAJ8AAgPnAgABggICAAIDBQMGABIHARgAAAAAAAAAAQATAAAAAAwBBAAAAFCMAQAAjAIAAPsDAAC8AwOrAAAAAJ8DAgJSBAMAxgUAAMYGAABkBBkAbwsBALwJCAMCAAAAnwkDAg4JFAAOCQMATQoJ7AMAAAArChAATQoIbAQAAAAOCgQATQoIbAQAAABNCgq6BQAAAPAKAwAGAACAlQICB2UABQDwCgMACAAAAPAKAgAJAACAlQEBB24E5v8CAAAA+wQBAG8GCgC8BAQDAgAAAJ8EAwL7BQIATQUF6gsAAACfBQECKwUfACsEHgD7BQMATQUFTAwAAABNBQWeCAAAAPEACAAFAAAA+wUDAE0FBUwMAAAATQUFdQkAAACaABEABQAAABwFAwBbCAUNuwcIAqQHEAAAPOCAnwcCAoESBwQHAAAAbwgHAKQGEgAAROCAnwYDAn0GAwABAAAAqQcBAIIHAgCpBQAAggUCABMDCAMJAwoDCwMMAw0DDgIAAAAAAADwPwMPAxADEQMSAxMCmpmZmZmZ6T8DFAMVBAA84IADFgQAROCAABkXARgAAQEAAAABAAAAAgAAAAEAAAAAAwAAAAAAAAEAAQABAAAAAfYADgAAAAABAAAAAAABAAAAAAAAAAAAAAAAAAEBAAAAAAAAAAAAAAEAAQAEABoAAAAACAAAAQIAPaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQEAAAAAQG8DBAC8AQEWAwAAAJ8BAwKkAgYAAABQQE0DAaEHAAAATQMDcggAAACfAgICpAMGAAAAUEBNBAHBCQAAAE0EBEIKAAAAnwMCAqQEBgAAAFBATQUB1gsAAABNBQXODAAAAJ8EAgKkBQYAAABQQE0GAWINAAAATQYGyg4AAACfBQIC/wYDAAAAAADABw8AEgADABIAAgASAAQAMAcG9BAAAADABxEAEgAGADAHBkASAAAAwAcTABIAAAASAAEAEgADABIABQAwBwYCFAAAAIIGAgAVAxgEAAAAQAMZAxoDGwMcBAAAUEADHQMeAx8DIAMhAyIDIwMkBgEDBQYCAwcGAwMXAwECAwEAARgAAAAAAAAAAQAAAAAAAQAAAAAAAAEAAAAAAAABAAAAAAAAAQAAAAAAAAIAAQAAAAAACQAAAAcAAAAAAAAeAQAAAAAEoN6gxndY9Kerm1MtvTpgbtDGt7KSGsrH

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:29
-- Luau version 6, Types version 3
-- Time taken: 0.004445 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local RunUtils_upvr = require(ReplicatedStorage_upvr.App.RunUtils)
local module_upvr = {}
local Promise_upvr = require(ReplicatedStorage_upvr.Std.Promise)
local PrivateServerUtils_upvr = require(ReplicatedStorage_upvr.PrivateServer.PrivateServerUtils)
function module_upvr.promiseIsTeamSwitchingEnabled() -- Line 9
    --[[ Upvalues[3]:
        [1]: RunUtils_upvr (readonly)
        [2]: Promise_upvr (readonly)
        [3]: PrivateServerUtils_upvr (readonly)
    ]]
    if not RunUtils_upvr.isMainWorld() then
        return Promise_upvr.resolve(false)
    end
    return PrivateServerUtils_upvr.promiseGetIsBattleServer():andThen(function(arg1) -- Line 13
        return not arg1
    end)
end
function module_upvr.isTeamSwitchingEnabled() -- Line 18
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    local any_await_result1, any_await_result2 = module_upvr.promiseIsTeamSwitchingEnabled():await()
    return any_await_result1 and any_await_result2
end
local Players_upvr = game:GetService("Players")
local Settings_upvr = require(ReplicatedStorage_upvr.Resource.Settings)
function module_upvr.isTeamFull(arg1) -- Line 25
    --[[ Upvalues[4]:
        [1]: Players_upvr (readonly)
        [2]: ReplicatedStorage_upvr (readonly)
        [3]: RunUtils_upvr (readonly)
        [4]: Settings_upvr (readonly)
    ]]
    -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
    local players = Players_upvr:GetPlayers()
    local var20
    for i, v in players do
        local ChoosingTeam = v:FindFirstChild("ChoosingTeam")
        local var22
        if ChoosingTeam and (not ChoosingTeam or not ChoosingTeam.Value) then
            local Team = v.Team
            if Team then
            end
            if v.Team.Name == "Police" then
            else
                -- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
                if v.Team.Name == "Prisoner" or v.Team.Name == "Criminal" then
                    var20 += 1
                end
            end
        end
    end
    if not RunUtils_upvr.isStudio() and not ReplicatedStorage_upvr:FindFirstChild("VipOwnerId") and (arg1 == Settings_upvr.EnumTeam.Prisoner or arg1 == Settings_upvr.EnumTeam.Criminal) then
        v = #players * 0.8
        i = math.ceil(v)
        v = 1
        if math.max(i, v) <= var20 then
            i = true
            return i
        end
    end
    return false
end
return module_upvr