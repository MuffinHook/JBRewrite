-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMcCFJlc291cmNlBkJyYWtlcwROYW1lDkZpbmRGaXJzdENoaWxkBWVycm9yEU5vIEJyYWtlcyBuYW1lZDogBUNsb25lBkNlbnRlcgtQcmltYXJ5UGFydAZDRnJhbWUDbmV3BkFuZ2xlcxRTZXRQcmltYXJ5UGFydENGcmFtZQtHZXRJbnN0YW5jZQJvcwVjbG9jawRtYXRoA3NpbgZVcGRhdGUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlBVByaWNlBkFtb3VudAdMZXZlbCAxB0xldmVsIDIHTGV2ZWwgMwVJdGVtcwADCgEBAAAAKPsBAABNAQFiAAAAAE0BAQcBAAAATQMAugIAAAC8AQEDAwAAAJ8BAwIrAQcApAIFAAAAQEBvBAYATQUAugIAAABzAwQFnwICAbwCAToHAAAAnwICAlIBAgBNAgHqCAAAADACAZsJAAAApAUMAAAsoICfBQECpAYOAAA0oIBvBw8AjAgAAIwJAACfBgQCCQQFBrwCAWYQAAAAnwIDAYIBAgARAwEDAgMDAwQDBQQAAEBAAwYDBwMIAwkDCgMLBAAsoIADDAQANKCAAhgtRFT7Ifk/Aw0AEw4BGAAAAAAAAAAAAAABAQAAAAAAAAIAAAABAAAAAQAAAAAAAAAAAAAAAAEUAAAAAA0CAAAAACKkAgIAAAQAgJ8CAQI+AwIDIQQDBKQHBwAAGFCAjAgAAFIJBACMCgAAnwcEAqQIBwAAGFCAuxgDA1IMAwCkCwwAACyggJ8LAgJbCgsJeAkKCIwKAACMCwAAnwgEAgkGBwikBw4AADRQgIwIAACMCQAAjAoKAJ8HBAIJBQYHMAUAhQUAAACCAAEADwMPAxAEAAQAgAIAAAAAAAAAQAIYLURU+yEZQAMKAwwEABhQgAKamZmZmZnJPwIAAAAAAADgPwMRAxIEACyggAMLBAA0UIAAHhMBGAAAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEfAAAAAAYAAAECADSjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMC/wEAAAMAAADiAgcAbwMIADADAroEAAAAjAMAADADAiQFAAAAjAMAADADAisGAAAA4gMHAG8ECQAwBAO6BAAAAIwE0AcwBAMkBQAAAG8ECgAwBAMrBgAAAOIEBwBvBQsAMAUEugQAAACMBZQRMAUEJAUAAACMBQUAMAUEKwYAAADFAQIEAQAAAMACDAASAAAAwAMNAOIEEQAwAQQ4DgAAADACBFEPAAAAMAMEJhAAAACCBAIAEgMUBAAAAEADFQMWAwMDFwMYBQMEBQYDGQMaAgAAAAAAAARAAxsGAAYBAxwDDgMTBQMODxACAAEBAAEYAAAAAAAAAAEAAQEAAAEAAAEAAAIBAAABAAABAAACAQAAAQAAAQAAAAADAAsGAQABAAEAAAEAAAAAAmFkCO7OSAyyk2OGLo1KSrARfB+aU6Bi7w==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:19
-- Luau version 6, Types version 3
-- Time taken: 0.001798 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
return {
    Items = {{
        Name = "Level 1";
        Price = 0;
        Amount = 0;
    }, {
        Name = "Level 2";
        Price = 2000;
        Amount = 2.5;
    }, {
        Name = "Level 3";
        Price = 4500;
        Amount = 5;
    }};
    GetInstance = function(arg1) -- Line 19, Named "GetInstance"
        --[[ Upvalues[1]:
            [1]: ReplicatedStorage_upvr (readonly)
        ]]
        local SOME = ReplicatedStorage_upvr.Resource.Brakes:FindFirstChild(arg1.Name)
        if not SOME then
            error("No Brakes named: "..arg1.Name)
        end
        local clone = SOME:Clone()
        clone.PrimaryPart = clone.Center
        clone:SetPrimaryPartCFrame(CFrame.new() * CFrame.Angles((math.pi/2), 0, 0))
        return clone
    end;
    Update = function(arg1, arg2) -- Line 30, Named "Update"
        local var8 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, var8 % (-math.pi*2), 0) * CFrame.Angles(math.sin(var8) * 0.5 - 0.2, 0, 0) * CFrame.new(0, 0, 10)
    end;
}