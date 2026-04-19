-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPFG9uQ29uc3VtYWJsZXNVcGRhdGVkBEZpcmUeVVBEQVRFX0NPTlNVTUFCTEVTX1JFTU9URV9OQU1FB2FuZFRoZW4EaW5pdARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQNTdGQMd2FpdEZvckNoaWxkC0NvbnN1bWFibGVzEUNvbnN1bWFibGVzQ29uc3RzBlNpZ25hbANuZXcAAwIAAQAAAAf7AAAATQAAagAAAAC8AADdAQAAAJ8AAgGCAAEAAgMBAwIACgABGAAAAAAAAAELAAAAAAMABAAAAAz7AAAA+wEBAPsCAgBNAgIBAAAAAJ8AAwLAAgEAEgIDALwAALUCAAAAnwADAYIAAQADAwMGAAMEAQAJBQEYAAAAAAAAAAAAAAADCgAAAAAGAAABAgArowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAoQYAAABNAgLzBwAAAJ8BAgKkAgUAAABAQE0DAMgIAAAATQMDPAkAAACfAgICpAMFAAAAQEBNBAChBgAAAE0EBB8KAAAAnwMCAv8EAgAAAAAATQUD7wsAAACfBQECMAUEagwAAADABQ0AEgABABIAAAASAAIAEgAEADAFBBMOAAAAggQCAA8DBgQAAABAAwcDCAMJBAAAQEADCgMLAwwDDQMOAw8DAQYBAwUBAQEAARgAAAAAAAAAAQAAAAAAAAEAAAAAAAABAAAAAAAAAgABAAAAAAIAAAAAAAAFAQAAAAAC2Jd0ira+TnIKo8x4/ethiKiPY/7qUx6L

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:19
-- Luau version 6, Types version 3
-- Time taken: 0.001002 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_upvr = {
    onConsumablesUpdated = require(ReplicatedStorage_upvr.Std.Signal).new();
}
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
local ConsumablesConsts_upvr = require(ReplicatedStorage_upvr.Consumables.ConsumablesConsts)
function module_upvr.init() -- Line 9
    --[[ Upvalues[4]:
        [1]: waitForChild_upvr (readonly)
        [2]: ReplicatedStorage_upvr (readonly)
        [3]: ConsumablesConsts_upvr (readonly)
        [4]: module_upvr (readonly)
    ]]
    waitForChild_upvr(ReplicatedStorage_upvr, ConsumablesConsts_upvr.UPDATE_CONSUMABLES_REMOTE_NAME):andThen(function() -- Line 10
        --[[ Upvalues[1]:
            [1]: module_upvr (copied, readonly)
        ]]
        module_upvr.onConsumablesUpdated:Fire()
    end)
end
return module_upvr