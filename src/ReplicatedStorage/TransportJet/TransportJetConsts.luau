local ReplicatedStorage = game:GetService("ReplicatedStorage")
local any_isStudio_result1 = require(ReplicatedStorage.App.RunUtils).isStudio()
local module = {
    TAG_NAME = "TransportJet";
    LAUNCHED_AT_ATTR_NAME = "TransportJetLaunchedAt";
    PATH_POINTS_OBJ_NAME = "TransportJetPathPoints";
    REQUEST_LAUNCH_REMOTE_NAME = "TransportJetRequestLaunch";
    DOOR_OPEN_ATTR_NAME = "TransportJetDoorOpen";
    NODE_OFFSET_START_ATTR_NAME = "TransportJetOffsetStart";
    NODE_OFFSET_END_ATTR_NAME = "TransportJetOffsetEnd";
}
local var4 = 5000
module.LAUNCH_COST_CASH = var4
if any_isStudio_result1 then
    var4 = 30
else
    var4 = 4000
end
module.RUNWAY_LENGTH = var4
if any_isStudio_result1 then
    var4 = 50
else
    var4 = 700
end
module.TOP_SPEED = var4
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze(module)