-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKCmxhc3REaWVkQXQSbWlzc2luZyBsYXN0RGllZEF0BmFzc2VydA1zZXRMYXN0RGllZEF0BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4DWNyZWF0ZVJlZHVjZXIAAgUCAAAAAAtNAwG+AAAAAIEBAwQBAAAAbwQBAKQCAwAAACBAnwIDAU0CAb4AAAAAggICAAQDAQMCAwMEAAAgQAAFBAEYAAAAAAAAAAABAAAGAAAAAAYAAAECABWjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgJNAgHWBwAAAIwDAADiBAkAwAUKADAFBIYIAAAAnwIDAIICAAALAwUEAAAAQAMGAwcDCAQAAEBAAwkDCgMEBQEIBgABAAEAARgAAAAAAAAAAQAAAAACAAAAAQAA/wABAAAAAAE82XTeteZmm4Jk78IVPRaKTMFjqg4dHt8=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:33
-- Luau version 6, Types version 3
-- Time taken: 0.000643 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer(0, {
    setLastDiedAt = function(arg1, arg2) -- Line 5, Named "setLastDiedAt"
        assert(arg2.lastDiedAt, "missing lastDiedAt")
        return arg2.lastDiedAt
    end;
})