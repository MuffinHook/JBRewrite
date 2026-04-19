-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMZD19kb2dzT3duZWRWYWx1ZQdyZXF1aXJlE0Fkb3B0aW9uU3RhbmRCaW5kZXIGc2NyaXB0BlBhcmVudAVTdGFydAlQbGF5ZXJHdWkVRE9HU19PV05FRF9WQUxVRV9OQU1FB2FuZFRoZW4Ed2FybgVjYXRjaARpbml0DkZpbmRGaXJzdENoaWxkE0RPR19OQU1FX1ZBTFVFX05BTUUFVmFsdWUKZ2V0RG9nTmFtZQdkb2VzT3duBGdhbWUHUGxheWVycwpHZXRTZXJ2aWNlC0xvY2FsUGxheWVyEVJlcGxpY2F0ZWRTdG9yYWdlA1N0ZAx3YWl0Rm9yQ2hpbGQTQWRvcHRpb25TdGFuZENvbnN0cwAFAgEBAAAABPsBAAAwAAGVAAAAAIIAAQABAwEADwABGAAAAAEVAAAAAAMABQAAACGkAAEAAAAAQKQCBAAAADBATQICJAUAAABNAQLGAgAAAJ8AAgLeAAAA+wAAALwAABwGAAAAnwACAfsAAQD7AQIATQEBmQcAAAD7AgMATQIChggAAACfAAMCwAIJABICBAC8AAC1CgAAAJ8AAwKkAgwAAACwQLwAABkNAAAAnwADAYIAAQAOAwIEAAAAQAMDAwQEAAAwQAMFAwYDBwMIBgADCQMKBAAAsEADCwEACgwBGAAAAAAAAAAAAAABAAAAAgAAAAAAAAABAAAAAAgAAAAAAQsAAAAABQECAAAAF/sBAABNAQGVAAAAACsBAQCCAAEA+wEAAE0BAZUAAAAAUgMAALwBAQMBAAAAnwEDAisBAQCCAAEA+wQBAE0EBHACAAAAvAIBAwEAAACfAgMCTQMC7AMAAACCAwIABAMBAw0DDgMPABkQARgAAAAAAQIAAAAAAAABAQIAAAAAAAEAABoAAAAABQEBAAAAEfsBAABNAQGVAAAAACsBAQCCAAEA+wIAAE0CApUAAAAAUgQAALwCAgMBAAAAnwIDAkcCAgAAAACAqQEAAakBAQCCAQIAAgMBAw0AJBEBGAAAAAABAgAAAAAAAAAAAAAAJQAAAAAIAAABAgA1owAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAk0BADEEAAAApAIBAAAAAEBvBAUAvAICFgMAAACfAgMCpAMHAAAAYEBNBAKhCAAAAE0EBPMJAAAAnwMCAsYEAACkBQcAAABgQKQHDAAAALBATQcHJA0AAABNBgf/CgAAAJ8FAgL/BgMAAAAAANkHAAASAQT/EgADABIAAQASAAUAEgAGADAHBhMOAAAAwAcPABIABgASAAUAMAcGhRAAAADABxEAEgAGADAHBjISAAAAwQQAAIIGAgATAxIEAAAAQAMTAxQDFQMWAwIEAABgQAMXAxgDGQMEBAAAsEADBQMMBgIDEAYDAxEDAQIDAQABGAAAAAAAAAABAAEAAAAAAAEAAAAAAAACAQAAAAAAAAAAAgABAAAAAAAAAA8AAAAACwAAAAYAAQAAAAAE52U6RJZ9uG/uqgfP9lCt8pd9LTDVoVBF

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:00
-- Luau version 6, Types version 3
-- Time taken: 0.002565 seconds

local AdoptionStandConsts_upvr = require(script.Parent.AdoptionStandConsts)
local module_upvr = {}
local var3_upvw
local waitForChild_upvr = require(game:GetService("ReplicatedStorage").Std.waitForChild)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function module_upvr.init() -- Line 10
    --[[ Upvalues[5]:
        [1]: var3_upvw (read and write)
        [2]: waitForChild_upvr (readonly)
        [3]: LocalPlayer_upvr (readonly)
        [4]: AdoptionStandConsts_upvr (readonly)
        [5]: module_upvr (readonly)
    ]]
    var3_upvw = require(script.Parent.AdoptionStandBinder)
    var3_upvw:Start()
    waitForChild_upvr(LocalPlayer_upvr.PlayerGui, AdoptionStandConsts_upvr.DOGS_OWNED_VALUE_NAME):andThen(function(arg1) -- Line 15
        --[[ Upvalues[1]:
            [1]: module_upvr (copied, readonly)
        ]]
        module_upvr._dogsOwnedValue = arg1
    end):catch(warn)
end
function module_upvr.getDogName(arg1) -- Line 25
    --[[ Upvalues[2]:
        [1]: module_upvr (readonly)
        [2]: AdoptionStandConsts_upvr (readonly)
    ]]
    if not module_upvr._dogsOwnedValue then return end
    local SOME = module_upvr._dogsOwnedValue:FindFirstChild(arg1)
    if not SOME then return end
    return SOME:FindFirstChild(AdoptionStandConsts_upvr.DOG_NAME_VALUE_NAME).Value
end
function module_upvr.doesOwn(arg1) -- Line 36
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    local var8
    if not var8 then return end
    if module_upvr._dogsOwnedValue:FindFirstChild(arg1) == nil then
        var8 = false
    else
        var8 = true
    end
    return var8
end
return module_upvr