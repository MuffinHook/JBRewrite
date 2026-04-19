-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMfA25ldwxzZXRtZXRhdGFibGUFU2V0dXALT2JqZWN0TG9jYWwDVGlwBkNvbmZpZwVTb3VuZB9ndW5fc2VtaV9hdXRvX3JpZmxlX2RyeV9maXJlXzAxBlZvbHVtZQVQaXRjaARtYXRoBnJhbmRvbRtndW5fc2VtaV9hdXRvX3JpZmxlX3Nob3RfMDEKU2hvb3RTb3VuZCZndW5fc2VtaV9hdXRvX3JpZmxlX21hZ2F6aW5lX3VubG9hZF8wMRJSb2xsT2ZmTWF4RGlzdGFuY2UTUmVsb2FkRHJvcEFtbW9Tb3VuZCRndW5fc2VtaV9hdXRvX3JpZmxlX21hZ2F6aW5lX2xvYWRfMDEVUmVsb2FkUmVmaWxsQW1tb1NvdW5kBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlA1N0ZAVBdWRpbwZzY3JpcHQGUGFyZW50A0d1bgRBSzQ3C19fQ2xhc3NOYW1lB19faW5kZXgABQcDAgAAABP7AwAATQMD7wAAAABSBAAAUgUBAFIGAgCfAwQC+wYBAJ49AwQGAAAAUgUDAKQEAgAAABBAnwQDAVIGAgC8BAOZAwAAAJ8EAwGCAwIABAMBAwIEAAAQQAMDAAsBARgAAAAAAAAAAQAAAAAAAAEAAAACDAAAAAALAgEAAAAyDgEaAPsCAABNAgLRAAAAAE0DALEBAAAATQQA2QIAAABNBARuAwAAAE0EBOMEAAAA4gUHAG8GCAAwBgVLBQAAAIwIAQCkCg0AADCwgJ8KAQJbCQoKQwcICXgGBwkwBgUABgAAAJ8CBAGCAAEA+wIAAE0CAtEAAAAATQMAsQEAAABNBADZAgAAAE0EBG4DAAAATQQE7Q4AAADiBQ8AjAgBAKQKDQAAMLCAnwoBAlsJCgpDBwgJeAYHCTAGBQAGAAAAnwIEAYIAAQAQAwQDBQMGAwcDCAMJAwoFAgUGApqZmZmZmdk/ApqZmZmZmak/ApqZmZmZmbk/AwsDDAQAMLCAAw0FAQYAEg4BGAABAAABAAEAAAAAAAEAAAAAAAAAAAAAAAD9AAYAAAEAAQAAAAAAAQAAAAAAAAAAAP0GEwAAAAAGAQEAAAAR+wEAAE0BAdEAAAAATQIAsQEAAABNAwDZAgAAAE0DA24DAAAATQMDHgQAAADiBAYAjAWBADAFBCoFAAAAnwEEAYIAAQAHAwQDBQMGAwcDDwMQBQEFACERARgAAAAAAAAAAAAAAAABAAD/AyIAAAAABgEBAAAAEfsBAABNAQHRAAAAAE0CALEBAAAATQMA2QIAAABNAwNuAwAAAE0DA/8EAAAA4gQGAIwFgQAwBQQqBQAAAJ8BBAGCAAEABwMEAwUDBgMHAxIDEAUBBQAmEwEYAAAAAAAAAAAAAAAAAQAA/wMnAAAAAAgAAAECADejAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgChBgAAAE0CAtIHAAAAnwECAqQCCQAAAIBATQICJAoAAACkAwUAAABAQE0EAg0LAAAAnwMCAv8EBAAAAAAAbwUMADAFBOUNAAAAMAQEbg4AAACePQQFAwAAAFIGBABSBwMApAUQAAAA8ECfBQMBwAURABIAAwASAAQAMAUE7xIAAADABRMAEgABADAFBLkUAAAAwAUVABIAAQAwBQS9FgAAAMAFFwASAAEAMAUEeRgAAACCBAIAGQMUBAAAAEADFQMWAxcEAABAQAMYAxkDGgQAAIBAAxsDHAMdAx4DHwMCBAAA8EAGAAMBBgEDDgYCAxEGAwMTBAABAgMBAAEYAAAAAAAAAAEAAAAAAAACAAAAAQAAAAACAAEAAAEAAQAAAAAAAAEAAAAABwAAAA8AAAAFAAAABgEAAAAABF1QCAJBIfH0tsjVJkC54xktSB92b5RiAw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:02
-- Luau version 6, Types version 3
-- Time taken: 0.002040 seconds

local Audio_upvr = require(game:GetService("ReplicatedStorage").Std.Audio)
local Gun_upvr = require(script.Parent.Gun)
local module_upvr = {
    __ClassName = "AK47";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Gun_upvr)
function module_upvr.new(arg1, arg2, arg3) -- Line 11
    --[[ Upvalues[2]:
        [1]: Gun_upvr (readonly)
        [2]: module_upvr (readonly)
    ]]
    local any_new_result1 = Gun_upvr.new(arg1, arg2, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:Setup(arg3)
    return any_new_result1
end
function module_upvr.ShootSound(arg1, arg2) -- Line 18
    --[[ Upvalues[1]:
        [1]: Audio_upvr (readonly)
    ]]
    if arg2 then
        Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_semi_auto_rifle_dry_fire_01, {
            Volume = 0.4;
            Pitch = 1 + math.random() * 0.1 - 0.05;
        })
    else
        Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_semi_auto_rifle_shot_01, {
            Pitch = 1 + math.random() * 0.1 - 0.05;
        })
    end
end
function module_upvr.ReloadDropAmmoSound(arg1) -- Line 33
    --[[ Upvalues[1]:
        [1]: Audio_upvr (readonly)
    ]]
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_semi_auto_rifle_magazine_unload_01, {
        RollOffMaxDistance = 129;
    })
end
function module_upvr.ReloadRefillAmmoSound(arg1) -- Line 38
    --[[ Upvalues[1]:
        [1]: Audio_upvr (readonly)
    ]]
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_semi_auto_rifle_magazine_load_01, {
        RollOffMaxDistance = 129;
    })
end
return module_upvr