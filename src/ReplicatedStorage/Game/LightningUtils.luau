-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMmBk9yaWdpbgZUYXJnZXQISW5zdGFuY2UDbmV3BU1vZGVsC051bVNlZ21lbnRzDE9mZnNldFJhZGl1cwxUcmFuc3BhcmVuY3kJUGFydFdpZHRoBUNvbG9yBkNvbG9yMwdmcm9tUkdCE3JhbmRvbVBvaW50SW5DaXJjbGUBWAFZB1ZlY3RvcjMJTWFnbml0dWRlBFBhcnQIQW5jaG9yZWQKQ2FuQ29sbGlkZQhDYW5Ub3VjaAhDYW5RdWVyeQRFbnVtCE1hdGVyaWFsBE5lb24KVG9wU3VyZmFjZQ1Cb3R0b21TdXJmYWNlBFNpemUGQ0ZyYW1lBlBhcmVudAl3b3Jrc3BhY2UOc3RyaWtlUG9zaXRpb24EZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUDU3RkCUdlb21VdGlscwACGAEBAAAHAAABCBA3AXtNAQBDAAAAAE0CACwBAAAApAMEAAAMIIBvBAUAnwMCAk0FAH4HAAAAkAQFBk0GAGMJAAAAkAUGCE0HANkLAAAAkAYHCk0IAIYNAAAAkAcIDE0IAKQOAAAAKwgGAKQIEQAAQPCAjAmCAIwKlACMC98AnwgEAlIJAQCMDAEAUgoEAIwLAQCoClQA7A0MBPUQDA0JDwEQCRACDUMODxBgDBAABAAAAPsQAABNEBB/EgAAAJ8QAQIJDxAFTREPeRMAAACMEgAATRMPeBQAAABMNgACpBAWAAAMUIGfEAQCQw4OECYPDglNDw+qFwAAAKQQBAAADCCAbxEYAJ8QAgKpEQEAMBEQRRkAAACpEQAAMBEQ0xoAAACpEQAAMBEQ9hsAAACpEQAAMBEQYhwAAACkESAAH3jQwTAREC0eAAAAMAYQ2QsAAAAwCBCkDgAAAIwRAACMEgAAMBEQHyEAAAAwEhASIgAAADQ2BwYHDwAAUhIHAFITBwBSFA8ApBEWAAAMUIGfEQQCMBEQLyMAAACkEiUAAAxAglITCQBSFA4AnxIDAqQTJQAADECCjBQAAIwVAAA5Fw8AWxYXJp8TBAIJERITMBEQhSQAAAAwAxAkJwAAAFIJDgCLCqz/pAopAAAAgEIwCgMkJwAAAIIDAgAqAwEDAgMDAwQEAAwggAMFAgAAAAAAADRAAwYCAAAAAAAAMEADBwIzMzMzMzPjPwMIAgAAAAAAAPA/AwkDCgMLAwwEAEDwgAMNAw4DDwMQBAAMUIEDEQMSAxMDFAMVAxYDFwMYAxkEH3jQwQMaAxsDHAMdBAAMQIICAAAAAAAA4D8DHgMfBAAAgEIABSABGAAAAQABAAAAAQAAAQAAAQAAAQAAAQAAAAAAAAAAAgEAAAABAQAAAAEAAQAAAAABAAAAAAAAAAAAAwAAAQAAAAEAAAEAAAEAAAEAAAEAAAABAAEAAQAAAAAAAQAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAEAAuoYAAAAAgYAAAAABAAAAQIAFaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKEGAAAATQICPAcAAACfAQIC/wIBAAAAAADAAwgAEgABADADAqwJAAAAggICAAoDIQQAAABAAyIDIwMkBAAAQEADJQMmBgADIAEAAQABGAAAAAAAAAABAAAAAAAAAgABAAAAKAEAAAAAAUlOPzkOykff3dmBQvOGILY5VihNe4pVOA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:22
-- Luau version 6, Types version 3
-- Time taken: 0.003111 seconds

local module = {}
local GeomUtils_upvr = require(game:GetService("ReplicatedStorage").Std.GeomUtils)
function module.strikePosition(arg1) -- Line 5
    --[[ Upvalues[1]:
        [1]: GeomUtils_upvr (readonly)
    ]]
    local Origin = arg1.Origin
    local Model = Instance.new("Model")
    local var7 = arg1.NumSegments or 20
    local var8 = arg1.PartWidth or 1
    local var9
    if not var9 then
        var9 = Color3.fromRGB(130, 148, 223)
    end
    local var10 = Origin
    for i = 1, var7 do
        local var11 = i / var7
        local var12 = Origin * (1 - var11) + arg1.Target * var11
        if i < var7 then
            local var13 = GeomUtils_upvr.randomPointInCircle() * (arg1.OffsetRadius or 16)
            var12 += Vector3.new(var13.X, 0, var13.Y)
        end
        local Magnitude = (var12 - var10).Magnitude
        local Part = Instance.new("Part")
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanTouch = false
        Part.CanQuery = false
        Part.Material = Enum.Material.Neon
        Part.Transparency = arg1.Transparency or 0.6
        Part.Color = var9
        Part.TopSurface = 0
        Part.BottomSurface = 0
        Part.Size = Vector3.new(var8, var8, Magnitude)
        Part.CFrame = CFrame.new(var10, var12) * CFrame.new(0, 0, -Magnitude * 0.5)
        Part.Parent = Model
    end
    Model.Parent = workspace
    return Model
end
return module