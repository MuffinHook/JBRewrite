-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMjEEZsb29yaW5nTWF0ZXJpYWwORmluZEZpcnN0Q2hpbGQEd2FybhBNaXNzaW5nIHN1Yk1vZGVsC0dldENoaWxkcmVuCEJhc2VQYXJ0A0lzQQROb25lDU9yaWdpbmFsQ29sb3IMR2V0QXR0cmlidXRlBUNvbG9yCE1hdGVyaWFsD0RlZmF1bHRNYXRlcmlhbARQYXJ0BE5hbWUUTm8gcGFydHMgdG8gYXBwbHkgdG8GYXNzZXJ0BWFwcGx5BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBnNjcmlwdAZQYXJlbnQJV2FsbENvbG9yBEdhbWUGR2FyYWdlBVBhaW50EkRlZmF1bHRSZWZsZWN0YW5jZRJEaXNhYmxlUmVmbGVjdGFuY2UERW51bQ1TbW9vdGhQbGFzdGljC2dldEluc3RhbmNlDHVwZGF0ZUNhbWVyYQhnZXRJdGVtcwACDQICAAAHBAAABQIPBztvBAAAvAIBAwEAAACfAgMCKwIFAKQDAwAAACBAbwQEAJ8DAgGCAAEAjAMAALwEAmgFAAAAnwQCBGQEHgBvCwYAvAkI/gcAAACfCQMCDgkZAJUDAwgOAAMATQkAPwkAAAAOCQcAbwsKALwJCBILAAAAnwkDAjAJCKQMAAAAZQANAPsJAABNCggtDQAAADAKCcAOAAAA+wkBAE0JCUQPAAAAUgoIAE0LALoQAAAA+wwAAJ8JBAFuBOH/AgAAAIwGAAC3BgIAAwAAAKkFAAGpBQEAgQEFBBEAAABvBhEApAQTAAAAIEGfBAMBggABABQDAQMCAwMEAAAgQAMEAwUDBgMHAgAAAAAAAPA/AwgDCQMKAwsDDAMNAw4DDwMQAxEEAAAgQQAPEgEYAAAAAAEBAAAAAQIBAAAAAQAAAAADAQAAAAEAAAAAAAACAAAAAAEAAAAAAAAA9wAMAAAAAAAAAAAAAAEQAAAAAAYAAAECADijAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQECkAgcAAABgQE0CAiQIAAAATQICpQkAAACfAQICpAIFAAAAQEBNAwC9CgAAAE0DAygLAAAATQMDUQwAAACfAgIC/wMDAAAAAADiBBAAjAUAADAFBMANAAAApAUUABNIEMEwBQTADgAAAKkFAQAwBQQZDwAAAE0FATEVAAAAMAUDMRUAAABNBQERFgAAADAFAxEWAAAATQUBhhcAAAAwBQOGFwAAAMAFGAASAAQAEgACADAFA88ZAAAAggMCABoDEwQAAABAAxQDFQMWBAAAQEADFwQAAGBAAxgDGQMaAxsDHAMdAw0DHgUDDQ4PAx8DDAMgBBNIEMEDIQMiAyMGAAMSAQABAAEYAAAAAAAAAAEAAAAAAAAAAAEAAAAAAAAAAAEAAgEAAAEAAAABAAADAAAAAQAAAAEAAAABAAAAABUBAAAAAAFXAm5ui4KVUcdyRfbmP+NuJxp5GmXGBG8=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:50
-- Luau version 6, Types version 3
-- Time taken: 0.003061 seconds

local WallColor = require(script.Parent.WallColor)
local module = {}
local tbl_upvr = {
    DefaultReflectance = 0;
    DefaultMaterial = Enum.Material.SmoothPlastic;
    DisableReflectance = true;
}
module.getInstance = WallColor.getInstance
module.updateCamera = WallColor.updateCamera
module.getItems = WallColor.getItems
local Paint_upvr = require(game:GetService("ReplicatedStorage").Game.Garage.Paint)
function module.apply(arg1, arg2) -- Line 15
    --[[ Upvalues[2]:
        [1]: tbl_upvr (readonly)
        [2]: Paint_upvr (readonly)
    ]]
    -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
    local FlooringMaterial = arg2:FindFirstChild("FlooringMaterial")
    local var14
    if not FlooringMaterial then
        var14 = warn
        var14("Missing subModel")
    else
        var14 = 0
        for _, v in FlooringMaterial:GetChildren() do
            if v:IsA("BasePart") then
                var14 += 1
                if not arg1 or arg1.None then
                    v.Color = v:GetAttribute("OriginalColor")
                else
                    tbl_upvr.DefaultMaterial = v.Material
                    Paint_upvr.Part(v, arg1.Name, tbl_upvr)
                end
            end
        end
        if 0 >= var14 then
        else
        end
        assert(true, "No parts to apply to")
    end
end
return module