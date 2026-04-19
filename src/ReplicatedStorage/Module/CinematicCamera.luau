-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMODVN0YXJ0UG9zaXRpb24IUG9zaXRpb24OVGFyZ2V0UG9zaXRpb24KTG9va1ZlY3RvcgtUYXJnZXRGb2N1cxNNYWtlQ2luZW1hdGljQ2FtZXJhBHVuaXQPQ29vcmRpbmF0ZUZyYW1lE1N0ZXBDaW5lbWF0aWNDYW1lcmEJd29ya3NwYWNlDUN1cnJlbnRDYW1lcmEGQ0ZyYW1lA25ldwdWZWN0b3IzAAMCAAEAAAAR4gAFAMYBAAAwAQAzAAAAAPsBAAAwAQA7AQAAAMYBAAAwAQCpAgAAAPsBAAAwAQBoAwAAAMYBAAAwAQDnBAAAAIIAAgAGAwEDAgMDAwQDBQUFAAECAwQABwYBGAABAAABAAABAAABAAABAAAACAAAAAALBAMAAAA9TQQBqQAAAAAOBBoATQQBMwEAAAAOBAsATQYBMwEAAAD1BwIDCQUGB00HAakAAAAACQYHA0MEBQYwBAE7AwAAAGUADABNBQE7AwAAAE0JAakAAAAATQoBOwMAAAAmCAkKCQcIAAkGBwNDBAUGMAQBOwMAAABNBAHnBAAAAA4EEQBNBQHnBAAAAE0GATsDAAAAJgQFBk0EBCcFAAAATQYBaAYAAABNCgFoBgAAACYJBAoJCAkACQcIAkMFBgcwBQFoBgAAAPsEAAD7BgEA+wcCAE0IAWgGAAAAnwYDAk0HATsDAAAAQwUGBzAFBKoHAAAAggABAAgDAwMBAgAAAAAAAPA/AwIDBQMHAwQDCAAQCQEYAAAAAQAAAQAAAAAAAAAAAAACAAAAAAAAAAAAAAADAAABAAAAAAAAAQAAAAAAAAAAAAIAAAAAAAAAAAAAAREAAAAACAAAAQIAHaMAAACkAAEAAAAAQE0AAEgCAAAApAEFAAAQMICkAgcAABBggFIFAQCfBQECUgMFAEw2AAFSBAIAnwQBAsYFAADGBgAAwAUIABIABADABgkAEgAAABIAAQASAAQA4gcMADAFB0MKAAAAMAYHNwsAAACCBwIADQMKBAAAAEADCwMMAw0EABAwgAMOBAAQYIAGAAYBAwYDCQUCCgsCAAEBAAEYAAAAAAACAAAAAQAAAAAAAQACAAkAAAAQAQABAAABAAAAAAKh+1dysJ7Q35B2X/Tm4qEz0eNABpM/PXM=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:26
-- Luau version 6, Types version 3
-- Time taken: 0.002055 seconds

local new_upvr = CFrame.new
local zero_vector3_upvr = Vector3.new()
local CurrentCamera_upvr = workspace.CurrentCamera
return {
    MakeCinematicCamera = function() -- Line 7, Named "MakeCinematicCamera"
        --[[ Upvalues[1]:
            [1]: zero_vector3_upvr (readonly)
        ]]
        return {
            StartPosition = nil;
            Position = zero_vector3_upvr;
            TargetPosition = nil;
            LookVector = zero_vector3_upvr;
            TargetFocus = nil;
        }
    end;
    StepCinematicCamera = function(arg1, arg2, arg3, arg4) -- Line 16, Named "StepCinematicCamera"
        --[[ Upvalues[3]:
            [1]: CurrentCamera_upvr (readonly)
            [2]: new_upvr (readonly)
            [3]: zero_vector3_upvr (readonly)
        ]]
        if arg2.TargetPosition then
            if arg2.StartPosition then
                arg2.Position = arg2.StartPosition * (1 - arg4) + arg2.TargetPosition * arg4
            else
                arg2.Position += (arg2.TargetPosition - arg2.Position) * arg1 * arg4
            end
        end
        if arg2.TargetFocus then
            arg2.LookVector += ((arg2.TargetFocus - arg2.Position).unit - arg2.LookVector) * arg1 * arg3
        end
        CurrentCamera_upvr.CoordinateFrame = new_upvr(zero_vector3_upvr, arg2.LookVector) + arg2.Position
    end;
}