-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMNBnNvcnRJZA5taXNzaW5nIHNvcnRJZAZhc3NlcnQOc2V0VHJhZGVTb3J0SWQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9kdXgGR2FyYWdlCEVudW1Tb3J0DWNyZWF0ZVJlZHVjZXIGTmV3ZXN0AAIFAgAAAAAPTQQBpgAAAABHBAIAAAAAgKkDAAGpAwEAgQEDBAEAAABvBAEApAIDAAAAIECfAgMBTQIBpgAAAACCAgIABAMBAwIDAwQAACBAAAcEARgAAAAAAAAAAAAAAAABAAAIAAAAAAcAAAECAB2jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgKkAgUAAABAQE0DACgHAAAATQMDHAgAAACfAgICTQMB1gkAAABNBAJ3CgAAAOIFDADABg0AMAYF2AsAAACfAwMAggMAAA4DBQQAAABAAwYDBwMIBAAAQEADCQMKAwsDDAMNAwQFAQsGAAEAAQABGAAAAAAAAAABAAAAAAIAAAAAAAACAAAAAAEAAP8AAQAAAAABzlV8TmnA3xz3vE6fBEZP0L5Nazr8kRZP

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:25
-- Luau version 6, Types version 3
-- Time taken: 0.000941 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(require(ReplicatedStorage.Garage.EnumSort).Newest, {
    setTradeSortId = function(arg1, arg2) -- Line 7, Named "setTradeSortId"
        local var3
        if arg2.sortId == nil then
            var3 = false
        else
            var3 = true
        end
        assert(var3, "missing sortId")
        return arg2.sortId
    end;
})