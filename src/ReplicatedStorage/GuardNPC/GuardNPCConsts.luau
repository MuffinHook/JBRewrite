local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "GuardNPC",
	BULLET_SPREAD_ATTR_NAME = "GuardBulletSpread",
	TRIGGER_PRESS_FREQ_ATTR_NAME = "GuardTriggerPressFreq",
	ITEM_NAME_ATTR_NAME = "GuardItemNameAttribute",
	DEFENSE_TARGET_TYPE_ATTR_NAME = "DefenseTargetType",
	DEFENSE_OBJ_VALUE_NAME = "DefenseObjValueName",
	PLAYERS_FOLDER_NAME = "GuardNPCPlayers",
	CHARCTER_TO_PLAYER_OBJ_NAME = "GuardCharacterToPlayer",
	MAX_SHOOT_DIST_ATTR_NAME = "MaxShootDist",
	MAX_SHOOT_DIST = 1000,
	DAMAGE_ALLOWED_BEFORE_TARGETING_PLAYER = 10,
	MAX_DIST_ALLOWED_TO_TARGET_PLAYER_WITHOUT_INVOLVEMENT = 300,
	MAX_ALLOWED_SHOOT_DIST_FROM_DEFENSE_TARGET_ATTR_NAME = "MaxAllowedShootFromDefenseTarget",
	DAMAGERS_FOLDER_NAME = "DamagersOfThisNPC",
	TARGETING_INVOLVED_PLAYER_ATTR_NAME = "TargetingInvolvedPlayer",
	TIME_BETWEEN_PUSHES = 3,
	DIST_TO_PUSH_WITHIN = 7,
	PUSH_IMPULSE_MULTIPLIER = 3000,
	IS_DOCILE_ATTR_NAME = "IsDocile"
})