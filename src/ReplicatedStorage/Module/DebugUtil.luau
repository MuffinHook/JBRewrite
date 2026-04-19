-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMMCEluc3RhbmNlA25ldwRQYXJ0CEFuY2hvcmVkB1ZlY3RvcjMEU2l6ZQZDRnJhbWUJd29ya3NwYWNlBlBhcmVudAlEcmF3UG9pbnQJTWFnbml0dWRlCERyYXdMaW5lAAMHAgAAAAAckAEBAKQCAwAACBCAbwMEAJ8CAgKpAwEAMAMCRQUAAABbBAEGWwUBBlsGAQZMNgACpAMIAAAIcICfAwQCMAMCLwkAAACkAwsAAAiggFIEAACfAwICMAMChQoAAACkAw0AAADAQDADAiQOAAAAggICAA8CAAAAAAAA4D8DAQMCBAAIEIADAwMEAgAAAAAAAABAAwUEAAhwgAMGAwcEAAiggAMIBAAAwEADCQADCgEYAAEAAAABAAABAAAAAAAAAAABAAAAAAABAAAAAQQAAAAACwIAAAAAKCYCAQBNAgKqAAAAAKQDAwAACBCAbwQEAJ8DAgKpBAEAMAQDRQUAAACMBQEAjAYBADQ2BQQGAgAAUgcCAKQEBwAACGCAnwQEAjAEAy8IAAAApAUKAAAIkIBSBgAAUgcBAJ8FAwKkBgoAAAiQgIwHAACMCAAAOQoCAFsJCgufBgQCCQQFBjAEA4UJAAAApAQNAAAAwEAwBAMkDgAAAIIDAgAPAwsDAQMCBAAIEIADAwMEAwUEAAhggAMGAwcEAAiQgAIAAAAAAADgPwMIBAAAwEADCQAQDAEYAAAAAQAAAAEAAAEAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAABAAAAAREAAAAAAwAAAQIACaMAAADAAAAAwAEBAOICBAAwAALQAgAAADABApIDAAAAggICAAUGAAYBAwoDDAUCAgMCAAEBAAEYAAINDAEAAQAAAQAAAAAC3i8NXUe3Qa8O0h77p00jvq43Gins62dc

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:28
-- Luau version 6, Types version 3
-- Time taken: 0.001557 seconds

return {
    DrawPoint = function(arg1, arg2) -- Line 3, Named "DrawPoint"
        local var1 = arg2 or 0.5
        local Part_2 = Instance.new("Part")
        Part_2.Anchored = true
        Part_2.Size = Vector3.new(var1 * 2, var1 * 2, var1 * 2)
        Part_2.CFrame = CFrame.new(arg1)
        Part_2.Parent = workspace
        return Part_2
    end;
    DrawLine = function(arg1, arg2) -- Line 16, Named "DrawLine"
        local Magnitude = (arg2 - arg1).Magnitude
        local Part = Instance.new("Part")
        Part.Anchored = true
        Part.Size = Vector3.new(1, 1, Magnitude)
        Part.CFrame = CFrame.new(arg1, arg2) * CFrame.new(0, 0, -Magnitude * 0.5)
        Part.Parent = workspace
        return Part
    end;
}