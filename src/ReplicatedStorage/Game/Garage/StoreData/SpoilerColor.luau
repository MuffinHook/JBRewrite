-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMkFEdldExvY2FsVmVoaWNsZU1vZGVsBmFzc2VydAVDbG9uZRFDbGVhblZlaGljbGVNb2RlbAtCb3VuZGluZ0JveAtQcmltYXJ5UGFydAZDRnJhbWUDbmV3FFNldFByaW1hcnlQYXJ0Q0ZyYW1lC1Nwb2lsZXJQYXJ0DkZpbmRGaXJzdENoaWxkCEdldENvbG9yBE5hbWUFQ29sb3ILR2V0SW5zdGFuY2UCb3MFY2xvY2sGQW5nbGVzBG1hdGgDY29zA3NpbgRTaXplCU1hZ25pdHVkZQZVcGRhdGUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUHVmVoaWNsZQxWZWhpY2xlVXRpbHMGc2NyaXB0BlBhcmVudAVQYWludARHYW1lBkdhcmFnZQVJdGVtcwADCAECAAAALfsBAABNAQFWAAAAAJ8BAQK7AQEDUgMBAKQCAgAAABBAnwICAbwCAToDAAAAnwICAlIBAgD7AgAATQICaAQAAABSAwEAnwICAU0CAW8FAAAAMAIBmwYAAACkBAkAACBwgIwFAACMBgAAjAcAAJ8EBAC8AgFmCgAAAJ8CAAFvBAsAvAIBAwwAAACfAgMCDgIIAPsDAQBNAwMLDQAAAE0EALoOAAAAnwMCAjADAqQPAAAAggECABADAQMCBAAAEEADAwMEAwUDBgMHAwgEACBwgAMJAwoDCwMMAw0DDgAHDwEYAAAAAAEAAAAAAQAAAAEAAAAAAQAAAAEAAAAAAAAAAAEAAAABAQAAAAAAAAACCAAAAAANAgAAAAAtpAICAAAEAICfAgECPgMCAyEEAwSkBwcAABhQgIwIAAC7CQQDUgsEAKQKCwAAKJCAnwoCAlsJCgiMCgAAnwcEAqQIBwAAGFCAuxgDA1IMAwCkCw0AADCQgJ8LAgJbCgsIeAkKCIwKAACMCwAAnwgEAgkGBwikBw8AADhQgIwIAACMCQAATQsBmxEAAABNCwsvEgAAAE0LC6oTAAAAWwoLEJ8HBAIJBQYHMAUAhQUAAACCAAEAFAMQAxEEAAQAgAIAAAAAAAAAQAIYLURU+yEZQAMHAxIEABhQgAKamZmZmZm5PwMTAxQEACiQgAMVBAAwkIADCAQAOFCAAmZmZmZmZuY/AwYDFgMXABUYARgAAAABAQEAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAD+AAMWAAAAAAgAAAECAC6jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCNBgAAAE0CAm0HAAAAnwECAqQCBQAAAEBApAQKAAAAkEBNBAQkCwAAAE0DBKQIAAAAnwICAqQDBQAAAEBATQUAvQ0AAABNBQUoDgAAAE0EBVEMAAAAnwMCAsAEDwASAAEAEgADAMAFEABNBgI4EQAAAOIHFAAwBgc4EQAAADAEB1ESAAAAMAUHJhMAAACCBwIAFQMZBAAAAEADGgMbAxwEAABAQAMdAx4DDgMfBAAAkEADIAMhAyIDIwYABgEDJAMPAxgFAxESEwIAAQEAARgAAAAAAAAAAQAAAAAAAAEAAAAAAAAAAAEAAAAAAAAAAAMAAA4IAAEBAAEAAQAAAQAAAAACDBDs10aJuqo+y4TULQxxcHwI+6M+1IbW

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:30
-- Luau version 6, Types version 3
-- Time taken: 0.002122 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local Paint_upvr = require(ReplicatedStorage.Game.Garage.Paint)
return {
    Items = require(script.Parent.Color).Items;
    GetInstance = function(arg1) -- Line 7, Named "GetInstance"
        --[[ Upvalues[2]:
            [1]: VehicleUtils_upvr (readonly)
            [2]: Paint_upvr (readonly)
        ]]
        local any_GetLocalVehicleModel_result1 = VehicleUtils_upvr.GetLocalVehicleModel()
        assert(any_GetLocalVehicleModel_result1)
        local clone = any_GetLocalVehicleModel_result1:Clone()
        VehicleUtils_upvr.CleanVehicleModel(clone)
        clone.PrimaryPart = clone.BoundingBox
        clone:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
        local SpoilerPart = clone:FindFirstChild("SpoilerPart")
        if SpoilerPart then
            SpoilerPart.Color = Paint_upvr.GetColor(arg1.Name)
        end
        return clone
    end;
    Update = function(arg1, arg2) -- Line 21, Named "Update"
        local var7 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, math.cos(var7 % (-math.pi*2)) * 0.1, 0) * CFrame.Angles(math.sin(var7) * 0.1 - 0.1, 0, 0) * CFrame.new(0, 0, arg2.PrimaryPart.Size.Magnitude * 0.7)
    end;
}