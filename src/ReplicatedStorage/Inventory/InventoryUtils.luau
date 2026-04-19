-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMGFm1pc3NpbmcgaW52ZW50b3J5VmFsdWUGYXNzZXJ0EG1pc3NpbmcgaXRlbU5hbWUORmluZEZpcnN0Q2hpbGQWZG9lc0ludmVudG9yeVZhbHVlSGF2ZRVnZXRJbnZlbnRvcnlJdGVtVmFsdWUAAwYCAAAAABeBAQAFAAAAAFIDAABvBAAApAICAAAAEECfAgMBgQEBBQMAAABSAwEAbwQDAKQCAgAAABBAnwIDAVIFAQC8AwADBAAAAJ8DAwJHAwIAAAAAgKkCAAGpAgEAggICAAUDAQMCBAAAEEADAwMEAAIFARgAAAAAAAAAAQAAAAAAAAIAAAAAAAAAAAMAAAAABQIAAAAAE4EBAAUAAAAAUgMAAG8EAACkAgIAAAAQQJ8CAwGBAQEFAwAAAFIDAQBvBAMApAICAAAAEECfAgMBUgQBALwCAAMEAAAAnwIDAIICAAAFAwEDAgQAABBAAwMDBAAIBgEYAAAAAAAAAAEAAAAAAAACAAAAAAkAAAAAAgAAAQIACqMAAAD/AAIAAAAAAMABAAAwAQDJAQAAAMABAgAwAQAAAwAAAIIAAgAEBgADBQYBAwYCAAEBAAEYAAAAAQAABgAABwEAAAAAAuVh1O5aScaVk47e76UoybKVecOa16W+7w==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:46
-- Luau version 6, Types version 3
-- Time taken: 0.001102 seconds

return {
    doesInventoryValueHave = function(arg1, arg2) -- Line 2, Named "doesInventoryValueHave"
        assert(arg1, "missing inventoryValue")
        local assert = assert
        assert(arg2, "missing itemName")
        if arg1:FindFirstChild(arg2) == nil then
            assert = false
        else
            assert = true
        end
        return assert
    end;
    getInventoryItemValue = function(arg1, arg2) -- Line 8, Named "getInventoryItemValue"
        assert(arg1, "missing inventoryValue")
        assert(arg2, "missing itemName")
        return arg1:FindFirstChild(arg2)
    end;
}