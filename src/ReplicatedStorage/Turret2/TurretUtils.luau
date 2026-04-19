-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMYBmFzc2VydAVQYXJ0MQRCYXNlDkZpbmRGaXJzdENoaWxkA0FybQZDRnJhbWUCQzAHSW52ZXJzZRJQb2ludFRvT2JqZWN0U3BhY2UEUm9vdANUaXAIUG9zaXRpb24BeAF6BG1hdGgEc3FydAVhdGFuMgRhc2luFmNvbXB1dGVIb3Jpem9udGFsQW5nbGUBeRRjb21wdXRlVmVydGljYWxBbmdsZQZBbmdsZXMCQzELdXBkYXRlTW9kZWwABA0DAAAACAUAAAUDBwcIabsBAgNSBAIApAMBAAAAAECfAwIBuwEBA1IEAQCkAwEAAAAAQJ8DAgFNBAGxAgAAALsBBAKkAwEAAAAAQJ8DAgFvBQMAvAMAAwQAAACfAwMCuwEDA1IFAwCkBAEAAAAAQJ8EAgFvBgUAvAQAAwQAAACfBAMCuwEEA1IGBACkBQEAAAAAQJ8FAgFNBgGxAgAAAE0GBoUGAAAATQcB7QcAAAC8BwfaCAAAAJ8HAgIJBQYHUgcCALwFBcYJAAAAnwUDAk0GA3QKAAAATQYGhQYAAABNCASxCwAAAE0ICDsMAAAAvAYGxgkAAACfBgMCTQoFmQ0AAABNCwWZDQAAAAkJCgtNCwWbDgAAAE0MBZsOAAAACQoLDEMICQq7GQgCpAcRAABA8ICfBwICTQsFmw4AAAA5CgsATQsFmQ0AAACeBQoDCwAAAKQJEwAASPCAnwkDAk0LBpkNAAAAYAsJAAcAAABNDAaZDQAAAOwLDAe7BAsCpAoVAABQ8ICfCgICKwoHAE0MBpkNAAAA7AsHDLsECwKkChUAAFDwgJ8KAgJDCAkKgggCABYDAQQAAABAAwIDAwMEAwUDBgMHAwgDCQMKAwsDDAMNAw4DDwMQBABA8IADEQQASPCAAxIEAFDwgAACEwEYAAAAAAABAAAAAAEAAAAAAAEAAAABAAAAAAEAAAABAAAAAAEAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAABAwAAAAAJAwAAAAgFAAAFAwcHCC27AQIDUgQCAKQDAQAAAABAnwMCAW8FAgC8AwADAwAAAJ8DAwK7AQMDUgUDAKQEAQAAAABAnwQCAU0FAbEEAAAAuwEFAqQEAQAAAABAnwQCAU0FAbEEAAAATQUFhQUAAABNBgHtBgAAALwGBtoHAAAAnwYCAgkEBQZSBgIAvAQExggAAACfBAMCTQYEmAkAAABNCASbCgAAADkHCACeBQYDBwAAAKQFDQAAMLCAnwUDAoIFAgAOAwEEAAAAQAMFAwQDAgMGAwcDCAMJAxQDDgMPAxEEADCwgAARFQEYAAAAAAABAAAAAQAAAAABAAAAAAABAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAABEgAAAAALBAAAAAkGAAAFBAcHAgIjTQYA7QAAAAC8BgbaAQAAAJ8GAgKkBwQAAAwggIwIAAB4CQIFjAoAAJ8HBAIJBQYHTQYA7QAAAAAJBAUGMAQAzAYAAABNBgHtAAAAALwGBtoBAAAAnwYCAqQHBAAADCCAUggDAIwJAACMCgAAnwcEAgkFBgdNBgHtAAAAAAkEBQYwBAHMBgAAAIIAAQAHAwcDCAMGAxYEAAwggAIYLURU+yH5PwMXABoYARgAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAARsAAAAAAgAAAQIADaMAAAD/AAMAAAAAAMABAAAwAQBFAQAAAMABAgAwAQDVAwAAAMABBAAwAQDlBQAAAIIAAgAGBgADEwYBAxUGAgMYAwABAgEAARgAAAABAAAPAAAJAAAEAQAAAAADSitY3FnSNJrjF5tbkHUOdTozT6h47zLd

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:53
-- Luau version 6, Types version 3
-- Time taken: 0.002943 seconds

return {
    computeHorizontalAngle = function(arg1, arg2, arg3) -- Line 2, Named "computeHorizontalAngle"
        assert(arg3)
        assert(arg2)
        assert(arg2.Part1)
        local Base = arg1:FindFirstChild("Base")
        assert(Base)
        local Arm = arg1:FindFirstChild("Arm")
        assert(Arm)
        local any_PointToObjectSpace_result1_2 = arg2.Part1.CFrame * arg2.C0:Inverse():PointToObjectSpace(arg3)
        local any_PointToObjectSpace_result1_3 = Base.Root.CFrame:PointToObjectSpace(Arm.Tip.Position)
        local squareroot = math.sqrt(any_PointToObjectSpace_result1_2.x * any_PointToObjectSpace_result1_2.x + any_PointToObjectSpace_result1_2.z * any_PointToObjectSpace_result1_2.z)
        local var7
        local function INLINED() -- Internal function, doesn't exist in bytecode
            var7 = math.asin(any_PointToObjectSpace_result1_3.x / squareroot)
            return var7
        end
        if any_PointToObjectSpace_result1_3.x >= squareroot or not INLINED() then
            var7 = math.asin(squareroot / any_PointToObjectSpace_result1_3.x)
        end
        return math.atan2(-any_PointToObjectSpace_result1_2.z, any_PointToObjectSpace_result1_2.x) + var7
    end;
    computeVerticalAngle = function(arg1, arg2, arg3) -- Line 17, Named "computeVerticalAngle"
        assert(arg3)
        assert(arg1:FindFirstChild("Arm"))
        assert(arg2.Part1)
        local any_PointToObjectSpace_result1 = arg2.Part1.CFrame * arg2.C0:Inverse():PointToObjectSpace(arg3)
        return math.atan2(any_PointToObjectSpace_result1.y, -any_PointToObjectSpace_result1.z)
    end;
    updateModel = function(arg1, arg2, arg3, arg4) -- Line 26, Named "updateModel"
        arg1.C1 = arg1.C0:Inverse() * CFrame.Angles(0, arg3 - (math.pi/2), 0) * arg1.C0
        arg2.C1 = arg2.C0:Inverse() * CFrame.Angles(arg4, 0, 0) * arg2.C0
    end;
}