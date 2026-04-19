-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLBnN0cmluZwZmb3JtYXQdQ2Fubm90IHJlYXNzaWduICVzIGluIGNvbnRleHQIdG9zdHJpbmcGYXNzZXJ0Cl9fbmV3aW5kZXgHX19pbmRleAVwYWlycwxnZXRtZXRhdGFibGUMc2V0bWV0YXRhYmxlA25ldwADCQMBAAAAFvsGAACHBQYBRwUCAAAAAACpBAABqQQBAKQFAgAABACAbwYDALs/AQNSCAEApAcFAAAAQECfBwICnwUDAEwBAAKkAwcAAABgQJ8DAAH7AwAAagIDAYIAAQAIAwEDAgQABACAAwMDBAQAAEBAAwUEAABgQAASBgEYAAAAAAAAAAAAAAAAAAAAAAAAAAEAARMAAAAACAEAAAAAI/8BAgAAAAAA/wIAAAAAAAAwAgFuAAAAAA4ADwCkAwIAAAAQQLs8AANSBwAApAYEAAAAMECfBgICUgQGAE0EBG4AAAAAnwMCBBcDAQBqBwIGbgP+/wIAAADZAwAAEgACADADAc4FAAAA/wQAAAAAAACePQQEAQAAAFIFAQCkAwcAAABgQJ8DAwKCAwIACAMHAwgEAAAQQAMJBAAAMEADBgMKBAAAYEABAAcLARgAAAEAAQACAQAAAAAAAAAAAAAAAf8ABQAAAAUAAAAAAAAAAAgAAAAAAgAAAQIAB6MAAAD/AAEAAAAAAMABAAAwAQDvAQAAAIIAAgACBgEDCwEBAQABGAAEAAIAABMBAAAAAAIK7Ti8RFL2NDGo3VTZ6DvtevUvyDgpUr0=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:31:59
-- Luau version 6, Types version 3
-- Time taken: 0.001993 seconds

return {
    new = function(arg1) -- Line 7, Named "new"
        local module = {}
        local tbl_upvr = {}
        module.__index = tbl_upvr
        if arg1 then
            for i, v in pairs(getmetatable(arg1).__index) do
                tbl_upvr[i] = v
            end
        end
        function module.__newindex(arg1_2, arg2, arg3) -- Line 18
            --[[ Upvalues[1]:
                [1]: tbl_upvr (readonly)
            ]]
            local var11
            if tbl_upvr[arg2] ~= nil then
                var11 = false
            else
                var11 = true
            end
            assert(var11, string.format("Cannot reassign %s in context", tostring(arg2)))
            tbl_upvr[arg2] = arg3
        end
        return setmetatable({}, module)
    end;
}