-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMVBG5hbWUFdGl0bGUQZ2V0Q2F0ZWdvcnlUaXRsZQZwYWNrZXQObWlzc2luZyBQYWNrZXQGYXNzZXJ0FEdldENhdGVnb3JpZXNCeU1vZGVsA21hcBVzZXRMb2NhbFZlaGljbGVQYWNrZXQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUDU3RkClRhYmxlVXRpbHMGR2FyYWdlFkdhcmFnZVRyYW5zbGF0aW9uVXRpbHMFUm9kdXgER2FtZQtWZWhpY2xlQ29uZg1jcmVhdGVSZWR1Y2VyAAMEAQEAAAAL4gECADAAAVoAAAAA+wIAAE0CAp4DAAAAUgMAAJ8CAgIwAgGaAQAAAIIBAgAEAwEDAgUCAAEDAwAMAAEYAAEAAQAAAAAAAAANAAAAAAYCAwAAABpNBAF0AAAAAEcEAgAAAACAqQMAAakDAQCBAQMEAQAAAG8EAQCkAgMAAAAgQJ8CAwH7AgAATQICNwQAAABNAwF0AAAAAJ8CAgL7AwEATQMDkAUAAABSBAIAwAUGABICAgCfAwMAggMAAAcDBAMFAwYEAAAgQAMHAwgGAAEACQkBGAAAAAAAAAAAAAAAAAEAAAAAAAEAAAAAAAAACgAAAAAJAAABAgAwowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAoQYAAABNAgIYBwAAAJ8BAgKkAgUAAABAQE0DACgIAAAATQMDlgkAAACfAgICpAMFAAAAQEBNBACnCgAAAJ8DAgKkBAUAAABAQE0FAL0LAAAATQUFKAgAAABNBQVnDAAAAJ8EAgJNBQPWDQAAAP8GAAAAAAAA4gcPAMAIEAASAAQAEgABABIAAgAwCAezDgAAAJ8FAwCCBQAAEQMKBAAAAEADCwMMAw0EAABAQAMOAw8DEAMRAxIDEwMUAxUDCQUBDgYBAQEBAAEYAAAAAAAAAAEAAAAAAAABAAAAAAAAAQAAAAACAAAAAAAAAAACAAAAAAEAAAAAAP8AAQAAAAAC6AhZEQul8dexRHtE0yzUQJgQTmXazDMQ

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:16
-- Luau version 6, Types version 3
-- Time taken: 0.001753 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_2 = {}
local VehicleConf_upvr = require(ReplicatedStorage.Game.Garage.VehicleConf)
local TableUtils_upvr = require(ReplicatedStorage.Std.TableUtils)
local GarageTranslationUtils_upvr = require(ReplicatedStorage.Garage.GarageTranslationUtils)
function module_2.setLocalVehiclePacket(arg1, arg2) -- Line 9
    --[[ Upvalues[3]:
        [1]: VehicleConf_upvr (readonly)
        [2]: TableUtils_upvr (readonly)
        [3]: GarageTranslationUtils_upvr (readonly)
    ]]
    local var6
    if arg2.packet == nil then
        var6 = false
    else
        var6 = true
    end
    assert(var6, "missing Packet")
    var6 = arg2.packet
    var6 = TableUtils_upvr
    var6 = var6.map
    var6 = var6(VehicleConf_upvr.GetCategoriesByModel(var6), function(arg1_2) -- Line 12
        --[[ Upvalues[1]:
            [1]: GarageTranslationUtils_upvr (copied, readonly)
        ]]
        local module = {}
        module.name = arg1_2
        module.title = GarageTranslationUtils_upvr.getCategoryTitle(arg1_2)
        return module
    end)
    return var6
end
return require(ReplicatedStorage.Rodux).createReducer({}, module_2)