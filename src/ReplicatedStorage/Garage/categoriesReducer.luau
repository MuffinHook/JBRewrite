local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_2 = {}
local VehicleConf_upvr = require(ReplicatedStorage.Game.Garage.VehicleConf)
local TableUtils_upvr = require(ReplicatedStorage.Std.TableUtils)
local GarageTranslationUtils_upvr = require(ReplicatedStorage.Garage.GarageTranslationUtils)
function module_2.setLocalVehiclePacket(arg1, arg2) -- Line 9
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
        local module = {}
        module.name = arg1_2
        module.title = GarageTranslationUtils_upvr.getCategoryTitle(arg1_2)
        return module
    end)
    return var6
end
return require(ReplicatedStorage.Rodux).createReducer({}, module_2)