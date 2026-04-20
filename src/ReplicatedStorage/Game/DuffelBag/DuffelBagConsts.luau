local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
    REMOTE_EVENT_NAME = "RemoteEvent";
    AMOUNT_VALUE_NAME = "Amount";
    MAXIMUM_VALUE_NAME = "Maximum";
    MULT_VALUE_NAME = "Mult";
    MULT_ENABLED_VALUE_NAME = "MultEnabled";
    TIME_VALUE_NAME = "Time";
    TIER_VALUE_NAME = "Tier";
    MESSAGE_VALUE_NAME = "Message";
    BAG_VISUAL_VALUE_NAME = "BagVisual";
    FORMATTER_VALUE_NAME = "Formatter";
    OWNER_VALUE_NAME = "Owner";
    AWARDED_VALUE_NAME = "Awarded";
    BAG_VISUAL_INVENTORY_ITEM_ATTR_NAME = "BagVisualInventoryItem";
    ROBBERY_ENUM_VALUE_NAME = "DuffelBagRobberyEnum";
    net = require(ReplicatedStorage.Std.Enumer)({"PLAY_AWARD_SOUND"});
})