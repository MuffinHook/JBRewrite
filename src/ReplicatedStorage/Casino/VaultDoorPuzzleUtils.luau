-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTDVZhdWx0SGFja2VySWQMR2V0QXR0cmlidXRlEUdldFBsYXllckJ5VXNlcklkCWdldEhhY2tlcgZVc2VySWQMU2V0QXR0cmlidXRlCXNldEhhY2tlchlHZXRBdHRyaWJ1dGVDaGFuZ2VkU2lnbmFsFmdldEhhY2tlckNoYW5nZWRTaWduYWwOVmF1bHREaXJlY3Rpb24MZ2V0RGlyZWN0aW9uDHNldERpcmVjdGlvbhlnZXREaXJlY3Rpb25DaGFuZ2VkU2lnbmFsDVZhdWx0RGlzYWJsZWQLZ2V0RGlzYWJsZWQLc2V0RGlzYWJsZWQEZ2FtZQdQbGF5ZXJzCkdldFNlcnZpY2UACQUBAQAAAA1vAwAAvAEAEgEAAACfAQMCDgEGAPsCAABSBAEAvAICYQIAAACfAgMCggICAMYCAACCAgIAAwMBAwIDAwAEBAEYAAAAAAEBAAAAAAECAAUAAAAABwIAAAAACsYCAAAOAQIATQIB5gAAAABvBQEAUgYCALwDAC4CAAAAnwMEAYIAAQADAwUDAQMGAAwHARgAAQEAAgAAAAABDQAAAAAEAQAAAAAFbwMAALwBABYBAAAAnwEDAIIBAAACAwEDCAATCQEYAAAAAAAUAAAAAAQBAAAAAAVvAwAAvAEAEgEAAACfAQMAggEAAAIDCgMCABYLARgAAAAAABcAAAAABgIAAAAABm8EAABSBQEAvAIALgEAAACfAgQBggABAAIDCgMGABkMARgAAAAAAAEaAAAAAAQBAAAAAAVvAwAAvAEAFgEAAACfAQMAggEAAAIDCgMIABwNARgAAAAAAB0AAAAABAEAAAAABW8DAAC8AQASAQAAAJ8BAwCCAQAAAgMOAwIAHw8BGAAAAAAAIAAAAAAGAgAAAAAGbwQAAFIFAQC8AgAuAQAAAJ8CBAGCAAEAAgMOAwYAIhABGAAAAAAAASMAAAAAAwAAAQIAI6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwL/AQQAAAAAAMACBAASAAAAMAIB+gUAAADAAgYAMAIB7gcAAADAAggAMAIBvgkAAADAAgoAMAIBFgsAAADAAgwAMAIBGg0AAADAAg4AMAIB7A8AAADAAhAAMAIB3REAAADAAhIAMAIBqRMAAACCAQIAFAMRBAAAAEADEgMTBgADBAYBAwcGAgMJBgMDCwYEAwwGBQMNBgYDDwYHAxAIAAECAwQFBgcBAAEYAAAAAAAAAAIAAQAAAAgAAAcAAAMAAAMAAAMAAAMAAAMAAAMBAAAAAAil+EW49lU/qeRlgqMebj/Z1eBSzJc8L7k=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:05
-- Luau version 6, Types version 3
-- Time taken: 0.002074 seconds

local module = {}
local Players_upvr = game:GetService("Players")
function module.getHacker(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: Players_upvr (readonly)
    ]]
    local VaultHackerId = arg1:GetAttribute("VaultHackerId")
    if VaultHackerId then
        return Players_upvr:GetPlayerByUserId(VaultHackerId)
    end
    return nil
end
function module.setHacker(arg1, arg2) -- Line 12
    local var4
    if arg2 then
        var4 = arg2.UserId
    end
    arg1:SetAttribute("VaultHackerId", var4)
end
function module.getHackerChangedSignal(arg1) -- Line 19
    return arg1:GetAttributeChangedSignal("VaultHackerId")
end
function module.getDirection(arg1) -- Line 22
    return arg1:GetAttribute("VaultDirection")
end
function module.setDirection(arg1, arg2) -- Line 25
    arg1:SetAttribute("VaultDirection", arg2)
end
function module.getDirectionChangedSignal(arg1) -- Line 28
    return arg1:GetAttributeChangedSignal("VaultDirection")
end
function module.getDisabled(arg1) -- Line 31
    return arg1:GetAttribute("VaultDisabled")
end
function module.setDisabled(arg1, arg2) -- Line 34
    arg1:SetAttribute("VaultDisabled", arg2)
end
return module