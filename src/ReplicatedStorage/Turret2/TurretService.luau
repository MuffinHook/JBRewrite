-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMhBVZhbHVlCEJhc2VQYXJ0A0lzQQZhc3NlcnQIUG9zaXRpb24HUG9pbnRBdAZVcGRhdGUFTW9kZWwWUkVQT1JUX0hJVF9SRU1PVEVfTkFNRQ5GaW5kRmlyc3RDaGlsZApGaXJlU2VydmVyD1RBUkdFVF9QVFJfTkFNRQRNYWlkCUhlYXJ0YmVhdAdDb25uZWN0CEdpdmVUYXNrEG9uTG9jYWxQbGF5ZXJIaXQDbmV3B1R1cnJldDITR2V0Q2xhc3NBZGRlZFNpZ25hbAVTdGFydARpbml0BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQpSdW5TZXJ2aWNlB3JlcXVpcmUGc2NyaXB0BlBhcmVudAZUdXJyZXQMVHVycmV0Q29uc3RzA1N0ZAZCaW5kZXIABQUAAgAAAB/7AAAATQAA7AAAAAAOABIA+wAAAE0AAOwAAAAAbwQBALwCAP4CAAAAnwIDAEwBAAKkAQQAAAAwQJ8BAAH7AQEATQMAOwUAAAC8AQE9BgAAAJ8BAwFlAAQA+wABALwAAD0GAAAAnwACAfsAAQC8AAAmBwAAAJ8AAgGCAAEACAMBAwIDAwMEBAAAMEADBQMGAwcACwABGAAAAAABAAABAAAAAAAAAAEAAAAAAAACAAAAAgAAAAEMAAAAAAMAAgAAABL7AAAATQAAOwAAAAD7AgEATQICQgEAAAC8AAADAgAAAJ8AAwK7AQADUgIAAKQBBAAAADBAnwECAbwBAGsFAAAAnwECAYIAAQAGAwgDCQMKAwQEAAAwQAMLABUAARgAAAAAAAAAAAABAAAAAAEAAAEWAAAAAAcBAgAAACRNAQA7AAAAAPsDAABNAwP6AQAAALwBAQMCAAAAnwEDAk0CAHYDAAAA+wQBAE0EBP0EAAAA2QYAABIAAQASAAAAvAQExwUAAACfBAMAvAIC/QYAAACfAgABTQIAdgMAAABNBADFBwAAANkGAQASAAAAEgIAALwEBMcFAAAAnwQDALwCAv0GAAAAnwIAAYIAAQAIAwgDDAMKAw0DDgMPAxADEQIAAQkAARgAAAAAAAAAAAEAAAAAAAAAAAAAAAAACgAAAAAAAAAAAAAAAAUKAAAAAAQABAAAABP7AAAATQAA7wAAAABvAQEA+wIBAJ8AAwK8AQAHAgAAAJ8BAgLAAwMAEgICABICAwC8AQHHBAAAAJ8BAwG8AQAcBQAAAJ8BAgGCAAEABgMSAxMDFAYCAw8DFQECBxYBGAAAAAAAAAEAAAAAAAAAABIAAAEIAAAAAAcAAAECADCjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMCpAIGAAAAUECkAwgAAABwQE0DAyQJAAAATQMDsgoAAACfAgICpAMGAAAAUECkBAgAAABwQE0EBCQJAAAATQQEvwsAAACfAwICpAQGAAAAUEBNBQChDAAAAE0FBX8NAAAAnwQCAv8FAQAAAAAAwAYOABIABAASAAIAEgADABIAAQAwBgUTDwAAAIIFAgAQAxcEAAAAQAMYAxkDGgMbBAAAUEADHAQAAHBAAx0DHgMfAyADIQYDAxYBAwEAARgAAAAAAAAAAQAAAAAAAQAAAAAAAAAAAQAAAAAAAAAAAQAAAAAAAAEAAQAAAAAAABYBAAAAAARKGiAzjv96XxrI5L4iekpnOgI3R3jeSjI=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:52
-- Luau version 6, Types version 3
-- Time taken: 0.002063 seconds

local module = {}
local Binder_upvr = require(game:GetService("ReplicatedStorage").Std.Binder)
local Turret_upvr = require(script.Parent.Turret)
local TurretConsts_upvr = require(script.Parent.TurretConsts)
local RunService_upvr = game:GetService("RunService")
function module.init() -- Line 7
    --[[ Upvalues[4]:
        [1]: Binder_upvr (readonly)
        [2]: Turret_upvr (readonly)
        [3]: TurretConsts_upvr (readonly)
        [4]: RunService_upvr (readonly)
    ]]
    local any_new_result1 = Binder_upvr.new("Turret2", Turret_upvr)
    any_new_result1:GetClassAddedSignal():Connect(function(arg1) -- Line 9
        --[[ Upvalues[2]:
            [1]: TurretConsts_upvr (copied, readonly)
            [2]: RunService_upvr (copied, readonly)
        ]]
        local SOME_2_upvr = arg1.Model:FindFirstChild(TurretConsts_upvr.TARGET_PTR_NAME)
        arg1.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 11
            --[[ Upvalues[2]:
                [1]: SOME_2_upvr (readonly)
                [2]: arg1 (readonly)
            ]]
            if SOME_2_upvr.Value then
                local Value = SOME_2_upvr.Value
                assert(Value:IsA("BasePart"))
                arg1:PointAt(Value.Position)
            else
                arg1:PointAt()
            end
            arg1:Update()
        end))
        arg1.Maid:GiveTask(arg1.onLocalPlayerHit:Connect(function() -- Line 21
            --[[ Upvalues[2]:
                [1]: arg1 (readonly)
                [2]: TurretConsts_upvr (copied, readonly)
            ]]
            local SOME = arg1.Model:FindFirstChild(TurretConsts_upvr.REPORT_HIT_REMOTE_NAME)
            assert(SOME)
            SOME:FireServer()
        end))
    end)
    any_new_result1:Start()
end
return module