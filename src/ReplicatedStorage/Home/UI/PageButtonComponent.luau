-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTCHNlbGVjdGVkD2JhY2tncm91bmRDb2xvcgpicmlnaHRlbkJ5BW1lcmdlDGNvcm5lclJhZGl1cwRVRGltA25ldxNwYWdlQnV0dG9uQ29tcG9uZW50BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBEV6VWkKRGljdGlvbmFyeQNTdGQKQ29sb3JVdGlscwZzY3JpcHQGUGFyZW50D0J1dHRvbkNvbXBvbmVudAACCQEDAAAAH00CAE0AAAAADgIDAE0BAA4BAAAAZQAHAPsBAABNAQGcAgAAAE0CAA4BAAAAbwMDAJ8BAwL7AgEA+wMCAE0DAx8EAAAAUgQAAOIFBgCkBgkAACBwgIwHAQCMCAAAnwYDAjAGBW8FAAAAMAEFDgEAAACfAwMAnwIAAIICAAAKAwEDAgMDAjMzMzMzM9O/AwQDBQUCBQEDBgMHBAAgcIAABggBGAAAAAEAAAEAAAAAAAABAAAAAAABAAAAAAAAAQD+AAAHAAAAAAUAAAECACOjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgAtBgAAAE0CAqkHAAAAnwECAqQCBQAAAEBATQMAoQgAAABNAwMzCQAAAJ8CAgKkAwUAAABAQKQECwAAAKBATQQEJAwAAABNBASjDQAAAJ8DAgLABA4AEgACABIAAwASAAEAggQCAA8DCQQAAABAAwoDCwMMBAAAQEADDQMOAw8DEAMRBAAAoEADEgMTBgABAAEAARgAAAAAAAAAAQAAAAAAAAEAAAAAAAABAAAAAAAAAAACAAAACgEAAAAAAaArd0DKeufj2eNWUVVdqePQM2A0ku8dQQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:26
-- Luau version 6, Types version 3
-- Time taken: 0.001611 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
local ButtonComponent_upvr = require(script.Parent.ButtonComponent)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
return function(arg1) -- Line 6, Named "pageButtonComponent"
    --[[ Upvalues[3]:
        [1]: ColorUtils_upvr (readonly)
        [2]: ButtonComponent_upvr (readonly)
        [3]: Dictionary_upvr (readonly)
    ]]
    local var5
    if arg1.selected then
        var5 = arg1.backgroundColor
    else
        var5 = ColorUtils_upvr
        var5 = var5.brightenBy(arg1.backgroundColor, -0.3)
    end
    return ButtonComponent_upvr(Dictionary_upvr.merge(arg1, {
        cornerRadius = UDim.new(1, 0);
        backgroundColor = var5;
    }))
end