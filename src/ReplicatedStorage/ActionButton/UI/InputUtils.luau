-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMNBE5hbWUGQnV0dG9uBGZpbmQKVGh1bWJzdGljawREUGFkEGlzR2FtZXBhZEtleUNvZGUERW51bQ1Vc2VySW5wdXRUeXBlBVRvdWNoBmlwYWlycwhHYW1lcGFkMQhLZXlib2FyZA5nZXRCZXN0S2V5Q29kZQADBQEAAAAAFU0BALoAAAAAbwQBALwCAVYCAAAAnwIDAisCCgBvBAMAvAIBVgIAAACfAgMCKwIFAG8EBAC8AgFWAgAAAJ8CAwIOAgIAqQIBAIICAgCpAgAAggICAAUDAQMCAwMDBAMFAAIGARgAAAEAAAAAAAAAAAAAAAAAAAEAAgADAAAAAAkCAQAAACIrAAEAggABACsBAQCCAAEApAIDAAIEAMCaAQIAAgAAAIIAAQCkAgUAAABAQFIDAACfAgIEUQIRAPsHAABNBwffBgAAAFIIBgCfBwICpAgIAAcEAMCaAQMACAAAAA4HAQCCBgIApAgKAAkEAMCaAQMACAAAACsHAQCCBgIAbgLu/wIAAICCAAEACwMHAwgDCQQCBADAAwoEAABAQAMGAwsEBwQAwAMMBAkEAMAACQ0BGAABAgECAAAAAQIAAAAAAQAAAAABAAAAAAEBAAAAAAH7AAgKAAAAAAIAAAECAAujAAAA/wACAAAAAADAAQAAMAEA3wEAAADAAQIAEgAAADABAOADAAAAggACAAQGAAMGBgEDDQIAAQEAARgAAAABAAAHAAAAEwEAAAAAAuGcQsCtIdntumjRl9MsZVaRhFW001gowQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:59
-- Luau version 6, Types version 3
-- Time taken: 0.002384 seconds

local module_upvr = {
    isGamepadKeyCode = function(arg1) -- Line 2, Named "isGamepadKeyCode"
        local Name = arg1.Name
        if Name:find("Button") or Name:find("Thumbstick") or Name:find("DPad") then
            return true
        end
        return false
    end;
}
function module_upvr.getBestKeyCode(arg1, arg2) -- Line 9
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    if not arg1 then
    else
        if not arg2 then return end
        if arg2 == Enum.UserInputType.Touch then return end
        for _, v in ipairs(arg1) do
            if arg2 == Enum.UserInputType.Gamepad1 and module_upvr.isGamepadKeyCode(v) then
                return v
            end
            if arg2 == Enum.UserInputType.Keyboard then
                -- KONSTANTERROR: Expression was reused, decompilation is incorrect
                if not module_upvr.isGamepadKeyCode(v) then
                    return v
                end
            end
        end
    end
end
return module_upvr