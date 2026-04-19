-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMMBmFzc2VydAZQYXJlbnQGaXBhaXJzBkdldEFsbAhHZXRPd25lcgZnZXRCYWcEZ2FtZQdQbGF5ZXJzCkdldFNlcnZpY2UHcmVxdWlyZQZzY3JpcHQPRHVmZmVsQmFnQmluZGVyAAIIAQIAAAAhuwEAA1ICAACkAQEAAAAAQJ8BAgFNAwAkAgAAAPsEAADxAwIABAAAAKkCAAGpAgEAuwECAqQBAQAAAABAnwECAaQBBAAAADBA+wIBALwCAtAFAAAAnwICAJ8BAARRAQYAvAYFwwYAAACfBgICmgYCAAAAAACCBQIAbgH5/wIAAICCAAEABwMBBAAAAEADAgMDBAAAMEADBAMFAAYGARgAAAAAAAEAAAAAAAAAAAAAAQAAAAAAAAABAAAAAAH+AAUHAAAAAAQAAAECABijAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQECkAgcAAABgQE0CAiQIAAAATQICCAkAAACfAQIC/wIBAAAAAADAAwoAEgAAABIAAQAwAwLXCwAAAIICAgAMAwcEAAAAQAMIAwkDCgQAAEBAAwsEAABgQAMCAwwGAAMGAQABAAEYAAAAAAAAAAEAAAAAAAAAAAIAAgAAAAAKAQAAAAABT0f9UKACiJYJxNR2A5ae7j9f6iR9g5dR

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:55
-- Luau version 6, Types version 3
-- Time taken: 0.001225 seconds

local module = {}
local Players_upvr = game:GetService("Players")
local DuffelBagBinder_upvr = require(script.Parent.DuffelBagBinder)
function module.getBag(arg1) -- Line 6
    --[[ Upvalues[2]:
        [1]: Players_upvr (readonly)
        [2]: DuffelBagBinder_upvr (readonly)
    ]]
    local var8 = arg1
    assert(var8)
    if arg1.Parent ~= Players_upvr then
        var8 = false
    else
        var8 = true
    end
    assert(var8)
    for _, v in ipairs(DuffelBagBinder_upvr:GetAll()) do
        if v:GetOwner() == arg1 then
            return v
        end
    end
end
return module