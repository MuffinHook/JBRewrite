-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Enumer = require(ReplicatedStorage.Std.Enumer)
return TableUtils.requireValidIndexAndFreeze({
	TAG_NAME = "Home",
	HOME_ITEM_NEW_REMOTE_NAME = "HomeItemNew",
	HOME_PURCHASE_REMOTE_NAME = "HomePurchase",
	HOME_CLAIM_REMOTE_NAME = "HomeClaim",
	DOOR_INTERACT_REMOTE_NAME = "InteractDoor",
	UPDATE_CUSTOMIZING_REMOTE_NAME = "UpdateCustomizing",
	HOME_UNCLAIM_REMOTE_NAME = "HomeUnclaimRemote",
	PERMISSIONS_FOLDER_NAME = "HomePermissions",
	PERMISSION_CAN_EDIT_ATTR_NAME = "HomePermissionCanEdit",
	PERMISSION_CAN_ENTER_ATTR_NAME = "HomePermissionCanEnter",
	SETTINGS_FOLDER_NAME = "HomeSettings",
	SET_SAVED_SETTING_REMOTE_NAME = "SetSavedSettingRemote",
	HOMES_OWNED_FOLDER_NAME = "PlayerHomesOwned",
	MAX_HOMES_CLAIMED = 3,
	PRICE_VALUE_NAME = "Price",
	OWNER_ID_ATTR_NAME = "HomeOwnerId",
	CLAN_ID_ATTR_NAME = "HomeClanId",
	BEING_BROKEN_INTO_VALUE_NAME = "BeingBrokenInto",
	MIN_LEVEL_VALUE_NAME = "MinLevel",
	INSIDE_TELEPORT_PART_NAME = "InsideTeleport",
	OUTSIDE_TELEPORT_PART_NAME = "OutsideTeleport",
	MAX_HOME_ITEMS = 128,
	POLICE_BUST_DOOR_DURATION = 5,
	BREAK_IN_EXPIRE_TIME = 180,
	MIN_SECONDS_BETWEEN_RAIDS = 90,
	ENUM_HOME_ITEM_NEW_RESULT = Enumer({ "SUCCESS", "TOO_MANY", "ALL_OWNED_PLACED", "MAX_PLACED" }),
	CONFETTI_ENABLED_ATTR_NAME = "ConfettiEnabled"
})
