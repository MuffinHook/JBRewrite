-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUDHNldG1ldGF0YWJsZRBfbGlzdFdvcmxkTWFya2VyCF9lbmFibGVkA25ldwpTZXRFbmFibGVkBXRhYmxlBmluc2VydANBZGQEZmluZDtSZW1vdmluZyB3b3JsZE1hcmtlciB0aGF0IGRvZXNuJ3QgZXhpc3QgaW4gX2xpc3RXb3JsZE1hcmtlcgZhc3NlcnQGcmVtb3ZlBlJlbW92ZQZVcGRhdGUqZGVzdHJveWVkL25pbCB3b3JsZE1hcmtlciBpcyBiZWluZyBVcGRhdGVkBmlwYWlycwZHZXRBbGwHX19pbmRleBBXb3JsZE1hcmtlckdyb3VwC19fQ2xhc3NOYW1lAAcEAAEAAAAR/wACAAAAAAD7AwAAnj0ABAMAAABSAgAApAEBAAAAAECfAQMB/wEAAAAAAAAwAQDUAgAAAKkBAQAwAQCrAwAAAIIAAgAEAwEEAAAAQAMCAwMABAQBGAAAAQAAAAAAAAIAAAABAAACBQAAAAAFAgAAAAAOTQQAqwAAAAC8AgGeAQAAAJ8CAwFNAwDUAgAAAJ40AwQBAAAAUgQBAKQCBQAAEDCAnwIDAYIAAQAGAwMDBQMCAwYDBwQAEDCAAA0IARgAAAAAAAEAAAAAAAAAAQ4AAAAABgIAAAAAFKQCAgAABACATQMA1AMAAABSBAEAnwIDAoEBAgUEAAAAUgQCAG8FBACkAwYAAABQQJ8DAwGkAwgAABwAgE0EANQDAAAAUgUCAJ8DAwGCAAEACQMGAwkEAAQAgAMCAwoDCwQAAFBAAwwEABwAgAARDQEYAAAAAAAAAQAAAAAAAAEAAAAAAAESAAAAAAgBAAAAABpNAQCrAAAAACsBAQCCAAEATQQA1AEAAAAcAwQAjAEBAIwC//+oAQ8ATQUA1AEAAACHBAUDTQYEJgIAAACBAQYEAwAAAG8HAwCkBQUAAABAQJ8FAwG8BQQmAgAAAJ8FAgGLAfH/ggABAAYDAwMCAw4DDwMLBAAAQEAAFg4BGAAAAAECAAAAAAABAAABAAAAAAAAAAEAAP0FFwAAAAAKAgAAAAAPMAEAqwAAAACkAgIAAAAQQE0DANQDAAAAnwICBFECBABSCQEAvAcGngQAAACfBwMBbgL7/wIAAICCAAEABQMDAxAEAAAQQAMCAwUAIAUBGAAAAQAAAAAAAQAAAP8AAyEAAAAAAgEAAAAAA00BANQAAAAAggECAAEDAgAmEQEYAAAAJwAAAAACAAABAgAcowAAAP8ABAAAAAAAMAAAbgAAAABvAQEAMAEA5QIAAADAAQMAEgAAADABAO8EAAAAwAEFADABAF8GAAAAwAEHADABAGkIAAAAwAEJADABACYKAAAAwAELADABAJ4MAAAAwAENADABANAOAAAAggACAA8DEgMTAxQGAAMEBgEDCAYCAw0GAwMOBgQDBQYFAxEGAAECAwQFAQABGAAAAAEAAQAAAQAAAAkAAAQAAAUAAAoAAAYAAAQBAAAAAAaMadWqE7H9ewa44Dkbe+R0/HHC3r6tv6s=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:15
-- Luau version 6, Types version 3
-- Time taken: 0.003093 seconds

local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
module_2_upvr.__ClassName = "WorldMarkerGroup"
function module_2_upvr.new() -- Line 4
    --[[ Upvalues[1]:
        [1]: module_2_upvr (readonly)
    ]]
    local module = {}
    setmetatable(module, module_2_upvr)
    module._listWorldMarker = {}
    module._enabled = true
    return module
end
function module_2_upvr.Add(arg1, arg2) -- Line 13
    arg2:SetEnabled(arg1._enabled)
    table.insert(arg1._listWorldMarker, arg2)
end
function module_2_upvr.Remove(arg1, arg2) -- Line 17
    local table_find_result1 = table.find(arg1._listWorldMarker, arg2)
    assert(table_find_result1, "Removing worldMarker that doesn't exist in _listWorldMarker")
    table.remove(arg1._listWorldMarker, table_find_result1)
end
function module_2_upvr.Update(arg1) -- Line 22
    if not arg1._enabled then
    else
        for var4 = #arg1._listWorldMarker, 1, -1 do
            local var5 = arg1._listWorldMarker[var4]
            assert(var5.Update, "destroyed/nil worldMarker is being Updated")
            var5:Update()
        end
    end
end
function module_2_upvr.SetEnabled(arg1, arg2) -- Line 32
    arg1._enabled = arg2
    for _, v in ipairs(arg1._listWorldMarker) do
        v:SetEnabled(arg2)
    end
end
function module_2_upvr.GetAll(arg1) -- Line 38
    return arg1._listWorldMarker
end
return module_2_upvr