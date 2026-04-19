-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMeBF9vYmoLUHJpbWFyeVBhcnQIQW5jaG9yZWQGQ0ZyYW1lA25ldxRTZXRQcmltYXJ5UGFydENGcmFtZQRoaWRlCkdldENyZWF0b3IQeWllbGRGb3JQcm9wZXJ0eQNvYmoFX21haWQPX2NyZWF0b3JJZFZhbHVlBVZhbHVlGEdldFByb3BlcnR5Q2hhbmdlZFNpZ25hbAdDb25uZWN0CEdpdmVUYXNrBVN0YXJ0E0dldENsYXNzQWRkZWRTaWduYWwEaW5pdARnYW1lB1BsYXllcnMKR2V0U2VydmljZRFSZXBsaWNhdGVkU3RvcmFnZQtMb2NhbFBsYXllcgdyZXF1aXJlA1N0ZA9SeEluc3RhbmNlVXRpbHMSU21va2VHcmVuYWRlQmluZGVyBnNjcmlwdAZQYXJlbnQABQcBAAAAABNNAQBuAAAAAE0BAZsBAAAAqQIBADACAUUCAAAATQEAbgAAAACkAwUAABAwgIwEAACMBZz/jAYAAJ8DBAC8AQFmBgAAAJ8BAAGCAAEABwMBAwIDAwMEAwUEABAwgAMGAAsHARgAAAAAAAAAAQAAAAAAAAAAAAABDAAAAAAHAAIAAAAb+wAAALwAAP0AAAAAnwACAvsBAQCaABQAAQAAAPsAAABNAQBuAQAAAE0BAZsCAAAAqQIBADACAUUDAAAATQEAbgEAAACkAwYAABRAgIwEAACMBZz/jAYAAJ8DBAC8AQFmBwAAAJ8BAAGCAAEACAMIAwEDAgMDAwQDBQQAFECAAwYAFAABGAkAAAAAAAAB9gAAAAAAAAEAAAAAAAAAAAAACwwAAAAABwECAAAAMfsBAABNAQEPAAAAAE0CABMBAAAAbwMCAJ8BAwG8AQD9AwAAAJ8BAgL7AgEAmgETAAIAAABNAQBuBAAAAE0BAZsCAAAAqQIBADACAUUFAAAATQEAbgQAAACkAwgAABxggIwEAACMBZz/jAYAAJ8DBAC8AQFmCQAAAJ8BAAFNAQDBCgAAAE0DAN0LAAAAbwUMALwDA5QNAAAAnwMDAtkFAAASAAAAEgIBALwDA8cOAAAAnwMDALwBAf0PAAAAnwEAAYIAAQAQAwkDCgMCAwgDAQMDAwQDBQQAHGCAAwYDCwMMAw0DDgMPAxABAQ8AARgEAAAAAAAAAQAAAAAA+wAAAAAAAAEAAAAAAAAAAAAABwAAAAAAAAAAAAAAAAAAAAAFDAAAAAAEAAMAAAAQ+wAAALwAABwAAAAAnwACAcAAAQD7AQAAvAEBBwIAAACfAQICwAMDABICAQASAgIAvAEBxwQAAACfAQMBggABAAUDEQYAAxIGAgMPAgACCBMBGAAAAAACBAAAAAAAAAAAAAsJAAAAAAcAAAECACijAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMCTQIAMQUAAACkAwcAAABgQE0EAaEIAAAATQQEUgkAAACfAwICpAQHAAAAYECkBgwAAACwQE0GBiQNAAAATQUGqAoAAACfBAIC/wUBAAAAAADABg4AEgAEABIAAwASAAIAMAYFEw8AAACCBQIAEAMUBAAAAEADFQMWAxcDGAMZBAAAYEADGgMbAxwDHQQAALBAAx4GAwMTAQMBAAEYAAAAAAAAAAEAAAAAAAEAAQAAAAAAAAEAAAAAAAAAAAIAAQAAAAAAEwEAAAAABP9X+LKCiGNChHflcyUwvhqPT+/GzZOSsw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:07
-- Luau version 6, Types version 3
-- Time taken: 0.002127 seconds

local module = {}
local SmokeGrenadeBinder_upvr = require(script.Parent.SmokeGrenadeBinder)
local RxInstanceUtils_upvr = require(game:GetService("ReplicatedStorage").Std.RxInstanceUtils)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function module.init() -- Line 8
    --[[ Upvalues[3]:
        [1]: SmokeGrenadeBinder_upvr (readonly)
        [2]: RxInstanceUtils_upvr (readonly)
        [3]: LocalPlayer_upvr (readonly)
    ]]
    SmokeGrenadeBinder_upvr:Start()
    local function _(arg1) -- Line 11, Named "hide"
        arg1._obj.PrimaryPart.Anchored = true
        arg1._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
    end
    SmokeGrenadeBinder_upvr:GetClassAddedSignal():Connect(function(arg1) -- Line 15
        --[[ Upvalues[2]:
            [1]: RxInstanceUtils_upvr (copied, readonly)
            [2]: LocalPlayer_upvr (copied, readonly)
        ]]
        RxInstanceUtils_upvr.yieldForProperty(arg1.obj, "PrimaryPart")
        if arg1:GetCreator() == LocalPlayer_upvr then
            arg1._obj.PrimaryPart.Anchored = true
            arg1._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
        end
        arg1._maid:GiveTask(arg1._creatorIdValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line 20
            --[[ Upvalues[2]:
                [1]: arg1 (readonly)
                [2]: LocalPlayer_upvr (copied, readonly)
            ]]
            if arg1:GetCreator() == LocalPlayer_upvr then
                local var7 = arg1
                var7._obj.PrimaryPart.Anchored = true
                var7._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
            end
        end))
    end)
end
return module