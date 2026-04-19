-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMNBlVzZXJJZAhpc0JhZGltbwR3YXJuKFBsYXllciBtaXNzaW5nIGZyb20gYWRtaW4gcGVybSBmdW5jdGlvbi4IaXNTdHVkaW8GZ2V0RW52B1FBX05BTUUIaGFzUGVybXMHcmVxdWlyZQZzY3JpcHQGUGFyZW50CVJ1bkNvbnN0cwhSdW5VdGlscwADAwEAAAAGAwAABQEHDU0BAOYAAAAAqQIBAA0BCAABAAAAqQIBAA0BBQACAAAADQECAAMAAACpAgABqQIBAIICAgAEAwECAAAAAJbmPkECAAAAgGumRUECAAAAQ+8UwkEABwIBGAAAAQAAAAAAAAAAAAAIAAAAAAMBAwAABgMAAAUBByIrAAQApAEBAAAAAEBvAgIAnwECAfsBAABNAQHqAwAAAJ8BAQIOAQIAqQEBAIIBAgAOAAgA+wEBAE0BATEEAAAAUgIAAJ8BAgIOAQIAqQEBAIIBAgD7AQAATQEBjgUAAACfAQEC+wICAE0CApwGAAAAmgEDAAIAAACpAQEAggECAKkBAACCAQIABwMDBAAAAEADBAMFAwIDBgMHAAwIARgAAQAAAAIAAAAAAQACAAAAAAAAAQACAAAAAAAAAAABAAIADQAAAAAEAAABAgAfowAAAKQAAQAAAABApAEDAAAAIEBNAQEkBAAAAE0BAW8FAAAAnwACAqQBAQAAAABApAIDAAAAIEBNAgIkBAAAAE0CAkIGAAAAnwECAv8CAgAAAAAAwAMHADADAjEIAAAAwAMJABIAAQASAAIAEgAAADADAhUKAAAAggICAAsDCQQAAABAAwoEAAAgQAMLAwwDDQYAAwIGAQMIAgABAQABGAAAAAAAAAAAAAABAAAAAAAAAAADAAIAAAUAAAAAABABAAAAAAIfOhO84HpKXqQKR0j9HhWUbyIEyC3+eb0=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:12
-- Luau version 6, Types version 3
-- Time taken: 0.002457 seconds

local module_upvr = {
    isBadimo = function(arg1) -- Line 7, Named "isBadimo"
        local UserId = arg1.UserId
        local var5 = true
        if UserId ~= 2025110 then
            var5 = true
            if UserId ~= 2837719 then
                if UserId ~= 606723718 then
                    var5 = false
                else
                    var5 = true
                end
            end
        end
        return var5
    end;
}
local RunUtils_upvr = require(script.Parent.RunUtils)
local RunConsts_upvr = require(script.Parent.RunConsts)
function module_upvr.hasPerms(arg1) -- Line 12
    --[[ Upvalues[3]:
        [1]: RunUtils_upvr (readonly)
        [2]: module_upvr (readonly)
        [3]: RunConsts_upvr (readonly)
    ]]
    if not arg1 then
        warn("Player missing from admin perm function.")
    end
    if RunUtils_upvr.isStudio() then
        return true
    end
    if arg1 and module_upvr.isBadimo(arg1) then
        return true
    end
    if RunUtils_upvr.getEnv() == RunConsts_upvr.QA_NAME then
        return true
    end
    return false
end
return module_upvr