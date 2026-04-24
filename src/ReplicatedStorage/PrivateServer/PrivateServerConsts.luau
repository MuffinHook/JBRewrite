-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	BATTLE_SERVER_SERVER_TYPE = "BattleServer",
	SERVER_TYPE_ATTR_NAME = "PrivateServerType"
})
