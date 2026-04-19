-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMjD1NlY29uZFdhbGxDb2xvcg5GaW5kRmlyc3RDaGlsZAR3YXJuEE1pc3Npbmcgc3ViTW9kZWwLR2V0Q2hpbGRyZW4IQmFzZVBhcnQDSXNBBE5vbmUNT3JpZ2luYWxDb2xvcgxHZXRBdHRyaWJ1dGUFQ29sb3IITWF0ZXJpYWwPRGVmYXVsdE1hdGVyaWFsBFBhcnQETmFtZRRObyBwYXJ0cyB0byBhcHBseSB0bwZhc3NlcnQFYXBwbHkEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUGc2NyaXB0BlBhcmVudAlXYWxsQ29sb3IER2FtZQZHYXJhZ2UFUGFpbnQSRGVmYXVsdFJlZmxlY3RhbmNlEkRpc2FibGVSZWZsZWN0YW5jZQRFbnVtDVNtb290aFBsYXN0aWMLZ2V0SW5zdGFuY2UMdXBkYXRlQ2FtZXJhCGdldEl0ZW1zAAINAgIAAAcEAAAFAg8HO28EAAC8AgEDAQAAAJ8CAwIrAgUApAMDAAAAIEBvBAQAnwMCAYIAAQCMAwAAvAQCaAUAAACfBAIEZAQeAG8LBgC8CQj+BwAAAJ8JAwIOCRkAlQMDCA4AAwBNCQA/CQAAAA4JBwBvCwoAvAkIEgsAAACfCQMCMAkIpAwAAABlAA0A+wkAAE0KCC0NAAAAMAoJwA4AAAD7CQEATQkJRA8AAABSCggATQsAuhAAAAD7DAAAnwkEAW4E4f8CAAAAjAYAALcGAgADAAAAqQUAAakFAQCBAQUEEQAAAG8GEQCkBBMAAAAgQZ8EAwGCAAEAFAMBAwIDAwQAACBAAwQDBQMGAwcCAAAAAAAA8D8DCAMJAwoDCwMMAw0DDgMPAxADEQQAACBBAA8SARgAAAAAAQEAAAABAgEAAAABAAAAAAMBAAAAAQAAAAAAAAIAAAAAAQAAAAAAAAD3AAwAAAAAAAAAAAAAARAAAAAABgAAAQIAOKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQKQCBwAAAGBATQICJAgAAABNAgKlCQAAAJ8BAgKkAgUAAABAQE0DAL0KAAAATQMDKAsAAABNAwNRDAAAAJ8CAgL/AwMAAAAAAOIEEACMBQAAMAUEwA0AAACkBRQAE0gQwTAFBMAOAAAAqQUBADAFBBkPAAAATQUBMRUAAAAwBQMxFQAAAE0FAREWAAAAMAUDERYAAABNBQGGFwAAADAFA4YXAAAAwAUYABIABAASAAIAMAUDzxkAAACCAwIAGgMTBAAAAEADFAMVAxYEAABAQAMXBAAAYEADGAMZAxoDGwMcAx0DDQMeBQMNDg8DHwMMAyAEE0gQwQMhAyIDIwYAAxIBAAEAARgAAAAAAAAAAQAAAAAAAAAAAQAAAAAAAAAAAQACAQAAAQAAAAEAAAMAAAABAAAAAQAAAAEAAAAAFQEAAAAAARAToYXX8XmZfST9q3MPZs5gC7bxItfLhA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:52
-- Luau version 6, Types version 3
-- Time taken: 0.002545 seconds

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
    local SecondWallColor = arg2:FindFirstChild("SecondWallColor")
    local var14
    if not SecondWallColor then
        var14 = warn
        var14("Missing subModel")
    else
        var14 = 0
        for _, v in SecondWallColor:GetChildren() do
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