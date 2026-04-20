local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local RunConsts = require(ReplicatedStorage.App.RunConsts)
local var4 = 20
if RunUtils.getEnv() == RunConsts.QA_NAME then
    var4 = 10
elseif RunUtils.getEnv() == RunConsts.DEV_NAME or RunUtils.getEnv() == RunConsts.STUDIO_NAME then
    var4 = 1
end
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
    CLAN_READY_UP_EXPIRATION_TIME = 60;
    CLAN_READY_UP_RETRY_TIME = 5;
    CLAN_IS_READIED_UP_MODEL_NAME = "ClanIsReadiedUp";
    READY_UP_REMOTE_NAME = "ReadyUpRemote";
    UNREADY_UP_REMOTE_NAME = "UnreadyUpRemote";
    CLAN_READY_UP_COOLDOWN_TIME = var4;
    CLAN_IS_READIED_UP_REMOTE_NAME = "ClanIsReadiedUpRemote";
})