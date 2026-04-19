-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMuCEluc3RhbmNlA25ldwRQYXJ0BEVudW0IUGFydFR5cGUEQmFsbAVTaGFwZQRTaXplClRvcFN1cmZhY2UNQm90dG9tU3VyZmFjZQZDb2xvcjMFVmFsdWUFQ29sb3IIQW5jaG9yZWQGQ0ZyYW1lC2dldEluc3RhbmNlAm9zBWNsb2NrBkFuZ2xlcwRtYXRoA3Npbgx1cGRhdGVDYW1lcmEFSXRlbXMIZ2V0SXRlbXMHV2luZG93cw5GaW5kRmlyc3RDaGlsZAR3YXJuEE1pc3Npbmcgc3ViTW9kZWwLR2V0Q2hpbGRyZW4IQmFzZVBhcnQDSXNBBE5vbmUUT3JpZ2luYWxUcmFuc3BhcmVuY3kMR2V0QXR0cmlidXRlDFRyYW5zcGFyZW5jeRRObyBwYXJ0cyB0byBhcHBseSB0bwZhc3NlcnQFYXBwbHkEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUER2FtZQZHYXJhZ2UJU3RvcmVEYXRhCldpbmRvd1RpbnQABQYBAAAAACWkAQIAAAQAgG8CAwCfAQICpAIHAAYUQMAwAgF+CAAAAG8CCQAwAgEvCgAAAIwCAACMAwAAMAIBHwsAAAAwAwESDAAAAKQCDgAABNCATQMA7A8AAABNBADsDwAAAE0FAOwPAAAAnwIEAjACAaQQAAAAqQIBADACAUURAAAApAITAAAEIIGfAgECMAIBhRIAAACCAQIAFAMBAwIEAAQAgAMDAwQDBQMGBAYUQMADBwcAAIBAAACAQAAAgEAAAAAAAwgDCQMKAwsEAATQgAMMAw0DDgMPBAAEIIEABRABGAAAAAABAAAAAQAAAQAAAAAAAQAAAAAAAAAAAAABAAABAAAAAAEGAAAAAA0CAAAAACKkAgIAAAQAgJ8CAQI+AwIDIQQDBKQHBwAAGFCAjAgAAFIJBACMCgAAnwcEAqQIBwAAGFCAuxgDA1IMAwCkCwwAACyggJ8LAgJbCgsJeAkKCIwKAACMCwAAnwgEAgkGBwikBw4AADRQgIwIAACMCQAAjAoIAJ8HBAIJBQYHMAUAhQUAAACCAAEADwMRAxIEAAQAgAIAAAAAAAAAQAIYLURU+yEZQAMPAxMEABhQgAIzMzMzMzPTPwIAAAAAAADQPwMUAxUEACyggAMCBAA0UIAAEBYBGAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAERAAAAAAEAAQAAAAT7AAAATQAAOAAAAACCAAIAAQMXABYYARgAAAAAFwAAAAAMAgAAAAcEAAAFAg8HMm8EAAC8AgEDAQAAAJ8CAwIrAgUApAMDAAAAIEBvBAQAnwMCAYIAAQCMAwAAvAQCaAUAAACfBAIEZAQVAG8LBgC8CQj+BwAAAJ8JAwIOCRAAlQMDCA4AAwBNCQA/CQAAAA4JBwBvCwoAvAkIEgsAAACfCQMCMAkI2QwAAABlAAQATQkA7A0AAAAwCQjZDAAAAG4E6v8CAAAAjAYAALcGAgADAAAAqQUAAakFAQCBAQUEDgAAAG8GDgCkBBAAAADwQJ8EAwGCAAEAEQMZAxoDGwQAACBAAxwDHQMeAx8CAAAAAAAA8D8DIAMhAyIDIwMMAyQDJQQAAPBAABkmARgAAAAAAQEAAAABAgEAAAABAAAAAAMBAAAAAQAAAAAAAAIAAAD4AAsAAAAAAAAAAAAAARoAAAAABAAAAQIAIqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAL0GAAAATQICKAcAAABNAgIwCAAAAE0CAoYJAAAAnwECAv8CAwAAAAAAwAMKADADAjELAAAAwAMMADADAhENAAAAwAMOABIAAQAwAwKGDwAAAMADEAAwAwLPEQAAAIICAgASAycEAAAAQAMoAykDKgQAAEBAAysDLAMtAy4GAAMQBgEDFgYCAxgGAwMmBAABAgMBAAEYAAAAAAAAAAEAAAAAAAAAAAAAAQACAAALAAAGAAAAAwAAFAEAAAAABP03hxU9EGhiMampQOL3VvONL5Bhz/PtFA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:54
-- Luau version 6, Types version 3
-- Time taken: 0.003777 seconds

local module = {
    getInstance = function(arg1) -- Line 5, Named "getInstance"
        local Part = Instance.new("Part")
        Part.Shape = Enum.PartType.Ball
        Part.Size = Vector3.new(4, 4, 4)
        Part.TopSurface = 0
        Part.BottomSurface = 0
        Part.Color = Color3.new(arg1.Value, arg1.Value, arg1.Value)
        Part.Anchored = true
        Part.CFrame = CFrame.new()
        return Part
    end;
    updateCamera = function(arg1, arg2) -- Line 16, Named "updateCamera"
        local var3 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, var3 % (-math.pi*2), 0) * CFrame.Angles(math.sin(var3) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, 8)
    end;
}
local WindowTint_upvr = require(game:GetService("ReplicatedStorage").Game.Garage.StoreData.WindowTint)
function module.getItems() -- Line 22
    --[[ Upvalues[1]:
        [1]: WindowTint_upvr (readonly)
    ]]
    return WindowTint_upvr.Items
end
function module.apply(arg1, arg2) -- Line 25
    -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
    local Windows = arg2:FindFirstChild("Windows")
    local var14
    if not Windows then
        var14 = warn
        var14("Missing subModel")
    else
        var14 = 0
        for _, v in Windows:GetChildren() do
            if v:IsA("BasePart") then
                var14 += 1
                if not arg1 or arg1.None then
                    v.Transparency = v:GetAttribute("OriginalTransparency")
                else
                    v.Transparency = arg1.Value
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