return require(game:GetService("ReplicatedStorage").Std.TableUtils).requireValidIndexAndFreeze({
    TAG_NAME = "InventoryItem";
    EQUIP_REMOTE_NAME = "InventoryEquipRemote";
    EQUIPPED_ATTR_NAME = "InventoryItemEquipped";
    EQUIPPED_LOCAL_ATTR_NAME = "InventoryItemLocalEquipped";
    LOCKED_ATTR_NAME = "InventoryItemLocked";
    PRIORITY_ATTR_NAME = "InventoryItemPriority";
})