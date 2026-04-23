-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local RunConsts = require(ReplicatedStorage.App.RunConsts)
local v1 = 20
if RunUtils.getEnv() == RunConsts.QA_NAME then
	v1 = 10
elseif RunUtils.getEnv() == RunConsts.DEV_NAME or RunUtils.getEnv() == RunConsts.STUDIO_NAME then
	v1 = 1
end
return TableUtils.requireValidIndexAndFreeze({
	CLAN_READY_UP_EXPIRATION_TIME = 60,
	CLAN_READY_UP_RETRY_TIME = 5,
	CLAN_IS_READIED_UP_MODEL_NAME = "ClanIsReadiedUp",
	READY_UP_REMOTE_NAME = "ReadyUpRemote",
	UNREADY_UP_REMOTE_NAME = "UnreadyUpRemote",
	CLAN_READY_UP_COOLDOWN_TIME = v1,
	CLAN_IS_READIED_UP_REMOTE_NAME = "ClanIsReadiedUpRemote"
})