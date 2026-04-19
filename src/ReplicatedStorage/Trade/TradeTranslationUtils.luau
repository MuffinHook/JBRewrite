-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKEHRyYWRlY2F0ZWdvcnkuJXMGZm9ybWF0C0Zvcm1hdEJ5S2V5EGdldENhdGVnb3J5VGl0bGUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUMTG9jYWxpemF0aW9uBk1vZHVsZQACBgEBAAAHAAABAwMDAgr7AQAAbwMAAFIFAAC8AwONAQAAAJ8DAwC8AQGbAgAAAJ8BAACCAQAAAwMBAwIDAwAFBAEYAAAAAAAAAAAAAAYAAAAABAAAAQIAFaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0DAEAHAAAATQIDfAYAAACfAQIC/wIBAAAAAADAAwgAEgABADADAp4JAAAAggICAAoDBQQAAABAAwYDBwMIBAAAQEADCQMKBgADBAEAAQABGAAAAAAAAAABAAAAAAAAAgABAAAAAwEAAAAAAepYILrRbfzoSB+sO0jmUXWaQDfO2JxKuw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:17
-- Luau version 6, Types version 3
-- Time taken: 0.000756 seconds

local module = {}
local Localization_upvr = require(game:GetService("ReplicatedStorage").Module.Localization)
function module.getCategoryTitle(arg1) -- Line 5
    --[[ Upvalues[1]:
        [1]: Localization_upvr (readonly)
    ]]
    return Localization_upvr:FormatByKey("tradecategory.%s":format(arg1))
end
return module