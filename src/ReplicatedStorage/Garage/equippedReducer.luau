-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTCGNhdGVnb3J5EG1pc3NpbmcgY2F0ZWdvcnkGYXNzZXJ0BG5hbWUMbWlzc2luZyBuYW1lBXBhaXJzE3NldENhdGVnb3J5RXF1aXBwZWQIZXF1aXBwZWQQbWlzc2luZyBlcXVpcHBlZA5zZXRFcXVpcHBlZFJhdwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQVSb2R1eAZHYXJhZ2UMR2FyYWdlQ29uc3RzDWNyZWF0ZVJlZHVjZXIUc2V0Q2F0ZWdvcnlJdGVtT3duZWQAAwgCAAAAAChNBAFrAAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwFNBAFaBAAAAEcEAgAAAACAqQMAAakDAQCBAQMEBQAAAG8EBQCkAgMAAAAgQJ8CAwH/AgAAAAAAAKQDBwAAAGBAUgQAAJ8DAgQXAwEAagcCBm4D/v8CAAAATQMBawAAAABNBAFaBAAAAGoEAgOCAgIACAMBAwIDAwQAACBAAwQDBQMGBAAAYEAABgcBGAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAEAAQAAAAAB/wADAAAAAAEHAAAAAAUCAAAAAAtNAwEuAAAAAIEBAwQBAAAAbwQBAKQCAwAAACBAnwIDAU0CAS4AAAAAggICAAQDCAMJAwMEAAAgQAAUCgEYAAAAAAAAAAABAAAVAAAAAAgAAAECACKjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgKkAgUAAABAQE0DACgHAAAATQMDuQgAAACfAgICwAMJAE0EAdYKAAAA/wUAAAAAAADiBg4AMAMGPwsAAAAwAwY4DAAAAMAHDwAwBwbfDQAAAJ8EAwCCBAAAEAMLBAAAAEADDAMNAw4EAABAQAMPAxADEQYAAxIDBwMTAwoFAwsMDQYBAgABAQABGAAAAAAAAAABAAAAAAIAAAAAAAACCgAAAAABAAIAAQAA/AABAAAAAAJxz/uGOpTUTtIyhsQaseZ4Adfs8kMLkYc=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:18
-- Luau version 6, Types version 3
-- Time taken: 0.001772 seconds

local function setCategoryEquipped(arg1, arg2) -- Line 6
    local var6
    if arg2.category == nil then
        var6 = false
    else
        var6 = true
    end
    assert(var6, "missing category")
    if arg2.name == nil then
        var6 = false
    else
        var6 = true
    end
    assert(var6, "missing name")
    var6 = pairs(arg1)
    local pairs_result1, pairs_result2, pairs_result3 = pairs(arg1)
    for i, v in pairs_result1, pairs_result2, pairs_result3 do
        ({})[i] = v
        local var11
    end
    pairs_result1 = arg2.category
    var11[pairs_result1] = arg2.name
    return var11
end
return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setCategoryEquipped = setCategoryEquipped;
    setCategoryItemOwned = setCategoryEquipped;
    setEquippedRaw = function(arg1, arg2) -- Line 20, Named "setEquippedRaw"
        assert(arg2.equipped, "missing equipped")
        return arg2.equipped
    end;
})