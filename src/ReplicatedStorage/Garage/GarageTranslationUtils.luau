local module = {}
local Localization_upvr = require(game:GetService("ReplicatedStorage").Module.Localization)
function module.getCategoryTitle(arg1) -- Line 5
    return Localization_upvr:FormatByKey(string.format("GarageVehicle.Category%s", arg1))
end
return module