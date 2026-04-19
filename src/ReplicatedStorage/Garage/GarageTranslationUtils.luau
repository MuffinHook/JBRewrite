-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKGEdhcmFnZVZlaGljbGUuQ2F0ZWdvcnklcwZmb3JtYXQLRm9ybWF0QnlLZXkQZ2V0Q2F0ZWdvcnlUaXRsZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQxMb2NhbGl6YXRpb24GTW9kdWxlAAIGAQEAAAcAAAEDAwMCCvsBAABvAwAAUgUAALwDA40BAAAAnwMDALwBAZsCAAAAnwEAAIIBAAADAwEDAgMDAAUEARgAAAAAAAAAAAAABgAAAAAEAAABAgAVowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQMAQAcAAABNAgN8BgAAAJ8BAgL/AgEAAAAAAMADCAASAAEAMAMCngkAAACCAgIACgMFBAAAAEADBgMHAwgEAABAQAMJAwoGAAMEAQABAAEYAAAAAAAAAAEAAAAAAAACAAEAAAADAQAAAAABOJJegitw2mArwVwI/dh8U0iKSfYKVjSD

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:13
-- Luau version 6, Types version 3
-- Time taken: 0.000631 seconds

local module = {}
local Localization_upvr = require(game:GetService("ReplicatedStorage").Module.Localization)
function module.getCategoryTitle(arg1) -- Line 5
    --[[ Upvalues[1]:
        [1]: Localization_upvr (readonly)
    ]]
    return Localization_upvr:FormatByKey(string.format("GarageVehicle.Category%s", arg1))
end
return module