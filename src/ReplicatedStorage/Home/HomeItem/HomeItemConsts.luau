local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "HomeItem",
	PLACE_REMOTE_NAME = "Place",
	DELETE_REMOTE_NAME = "Delete",
	OWNER_ID_VALUE_NAME = "OwnerId",
	DAMAGE_REMOTE_NAME = "DamageRemote",
	HEALTH_VALUE_NAME = "Health",
	MAX_HEALTH_VALUE_NAME = "MaxHealth",
	UP_DOT_VALUE_NAME = "UpDot",
	IS_PLACED_VALUE_NAME = "IsPlaced",
	IS_GHOST_VALUE_NAME = "IsGhost",
	TEAM_ONLY_VALUE_NAME = "TeamOnly",
	MAX_PLACED_VALUE_NAME = "MaxPlaced",
	UPDATE_INVENTORY_REMOTE_NAME = "UpdateHomeItemInventory",
	UPDATE_EQUIPPED_REMOTE_NAME = "UpdateHomeItemEquipped",
	PURCHASE_HOME_ITEM_REMOTE_NAME = "PurchaseHomeItem",
	EQUIP_HOME_ITEM_REMOTE_NAME = "EquipHomeItem",
	MAX_HOME_ITEM_OWNED = 16,
	GHOST_TAG_NAME = "GhostItem",
	GHOST_BOUNDING_BOX_NAME = "GhostBoundingBox"
})