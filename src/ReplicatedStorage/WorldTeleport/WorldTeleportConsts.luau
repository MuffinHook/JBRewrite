local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local RunConsts = require(ReplicatedStorage.App.RunConsts)
return TableUtils.requireValidIndexAndFreeze({
    TELEPORT_REGION_TAG = "TeleportRegion";
    TELEPORT_REMOTE_NAME = "TeleportRemoteFromPoint";
    TELEPORT_WORLD_ATTRIBUTE_NAME = "worldName";
    WORLD_TO_CONFIRMATION_MESSAGE = TableUtils.requireValidIndexAndFreeze({
        [RunConsts.MAIN_WORLD_NAME] = "Are you sure you want to teleport back to the main world?";
        [RunConsts.TRADE_WORLD_NAME] = "Are you sure you want to teleport to the trading world?\n"..require(ReplicatedStorage.Trade.TradeConsts).TRADE_WARNING_MESSAGE;
    });
    TELEPORT_REGION_COUNTDOWN_SECONDS = 5;
    TELEPORT_FOLDER_NAME = "TeleportRegions";
    TELEPORT_COUNTDOWN_INSTANCE_NAME = "TeleportCountdown";
    TELEPORT_HAPPENING_REMOTE = "TeleportingNow";
    TELEPORT_TO_WORLD_FROM_TEAM_SWITCH_NAME = "TeleportToWorldFromTeamSwitchRemote";
    TELEPORT_DEBOUNCE_TIME = 30;
})