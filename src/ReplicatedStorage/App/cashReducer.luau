-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKBGNhc2gSbWlzc2luZyBjYXNoIHZhbHVlBmFzc2VydAdzZXRDYXNoBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4DWNyZWF0ZVJlZHVjZXIAAgUCAAAAAAtNAwGfAAAAAIEBAwQBAAAAbwQBAKQCAwAAACBAnwIDAU0CAZ8AAAAAggICAAQDAQMCAwMEAAAgQAAFBAEYAAAAAAAAAAABAAAGAAAAAAYAAAECABWjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgJNAgHWBwAAAIwDAADiBAkAwAUKADAFBOkIAAAAnwIDAIICAAALAwUEAAAAQAMGAwcDCAQAAEBAAwkDCgMEBQEIBgABAAEAARgAAAAAAAAAAQAAAAACAAAAAQAA/wABAAAAAAEBORIqMtICAVoLImx0fJcJcSEFXjP9eCs=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:32
-- Luau version 6, Types version 3
-- Time taken: 0.000756 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer(0, {
    setCash = function(arg1, arg2) -- Line 5, Named "setCash"
        assert(arg2.cash, "missing cash value")
        return arg2.cash
    end;
})