-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMfA25ldwxzZXRtZXRhdGFibGUFU2V0dXALT2JqZWN0TG9jYWwDVGlwBkNvbmZpZwVTb3VuZApkcnlfZmlyZTAxBlZvbHVtZQVQaXRjaARtYXRoBnJhbmRvbQdzaG90XzAxClNob290U291bmQmZ3VuX3NlbWlfYXV0b19yaWZsZV9tYWdhemluZV91bmxvYWRfMDESUm9sbE9mZk1heERpc3RhbmNlE1JlbG9hZERyb3BBbW1vU291bmQkZ3VuX3NlbWlfYXV0b19yaWZsZV9tYWdhemluZV9sb2FkXzAxFVJlbG9hZFJlZmlsbEFtbW9Tb3VuZARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQNTdGQFQXVkaW8Gc2NyaXB0BlBhcmVudANHdW4DVXppC19fQ2xhc3NOYW1lB19faW5kZXgABQcDAgAAABP7AwAATQMD7wAAAABSBAAAUgUBAFIGAgCfAwQC+wYBAJ49AwQGAAAAUgUDAKQEAgAAABBAnwQDAVIGAgC8BAOZAwAAAJ8EAwGCAwIABAMBAwIEAAAQQAMDAAsBARgAAAAAAAAAAQAAAAAAAAEAAAACDAAAAAALAgEAAAAyDgEaAPsCAABNAgLRAAAAAE0DALEBAAAATQQA2QIAAABNBARuAwAAAE0EBOkEAAAA4gUHAG8GCAAwBgVLBQAAAIwIAQCkCg0AADCwgJ8KAQJbCQoKQwcICXgGBwkwBgUABgAAAJ8CBAGCAAEA+wIAAE0CAtEAAAAATQMAsQEAAABNBADZAgAAAE0EBG4DAAAATQQEiA4AAADiBQ8AjAgBAKQKDQAAMLCAnwoBAlsJCgpDBwgJeAYHCTAGBQAGAAAAnwIEAYIAAQAQAwQDBQMGAwcDCAMJAwoFAgUGApqZmZmZmdk/ApqZmZmZmak/ApqZmZmZmbk/AwsDDAQAMLCAAw0FAQYAEg4BGAABAAABAAEAAAAAAAEAAAAAAAAAAAAAAAD9AAYAAAAAAAAAAAAAAAAAAAAAAAAAAAACEwAAAAAGAQEAAAAR+wEAAE0BAdEAAAAATQIAsQEAAABNAwDZAgAAAE0DA24DAAAATQMDHgQAAADiBAYAjAWBADAFBCoFAAAAnwEEAYIAAQAHAwQDBQMGAwcDDwMQBQEFAB0RARgAAAAAAAAAAAAAAAABAAD/Ax4AAAAABgEBAAAAEfsBAABNAQHRAAAAAE0CALEBAAAATQMA2QIAAABNAwNuAwAAAE0DA/8EAAAA4gQGAIwFgQAwBQQqBQAAAJ8BBAGCAAEABwMEAwUDBgMHAxIDEAUBBQAiEwEYAAAAAAAAAAAAAAAAAQAA/wMjAAAAAAgAAAECADejAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgChBgAAAE0CAtIHAAAAnwECAqQCCQAAAIBATQICJAoAAACkAwUAAABAQE0EAg0LAAAAnwMCAv8EBAAAAAAAbwUMADAFBOUNAAAAMAQEbg4AAACePQQFAwAAAFIGBABSBwMApAUQAAAA8ECfBQMBwAURABIAAwASAAQAMAUE7xIAAADABRMAEgABADAFBLkUAAAAwAUVABIAAQAwBQS9FgAAAMAFFwASAAEAMAUEeRgAAACCBAIAGQMUBAAAAEADFQMWAxcEAABAQAMYAxkDGgQAAIBAAxsDHAMdAx4DHwMCBAAA8EAGAAMBBgEDDgYCAxEGAwMTBAABAgMBAAEYAAAAAAAAAAEAAAAAAAACAAAAAQAAAAACAAEAAAEAAQAAAAAAAAEAAAAABwAAAAsAAAAFAAAABgEAAAAABLnOOhdh/icKZB/KYIR/GC3J1i1jiwpQFg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:37
-- Luau version 6, Types version 3
-- Time taken: 0.002047 seconds

local Audio_upvr = require(game:GetService("ReplicatedStorage").Std.Audio)
local Gun_upvr = require(script.Parent.Gun)
local module_upvr = {
    __ClassName = "Uzi";
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
        Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.dry_fire01, {
            Volume = 0.4;
            Pitch = 1 + math.random() * 0.1 - 0.05;
        })
    else
        Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.shot_01, {
            Pitch = 1 + math.random() * 0.1 - 0.05;
        })
    end
end
function module_upvr.ReloadDropAmmoSound(arg1) -- Line 29
    --[[ Upvalues[1]:
        [1]: Audio_upvr (readonly)
    ]]
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_semi_auto_rifle_magazine_unload_01, {
        RollOffMaxDistance = 129;
    })
end
function module_upvr.ReloadRefillAmmoSound(arg1) -- Line 34
    --[[ Upvalues[1]:
        [1]: Audio_upvr (readonly)
    ]]
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_semi_auto_rifle_magazine_load_01, {
        RollOffMaxDistance = 129;
    })
end
return module_upvr