local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
    TAG_NAME = "NPC";
    DEST_TYPE = require(ReplicatedStorage.Std.Enumer)({"POS", "OBJ", "IDLE"});
    DEST_TYPE_ATTR_NAME = "NPCDestType";
    DEST_POS_ATTR_NAME = "NPCDestPos";
    DEST_OBJ_VALUE_NAME = "NPCDestObj";
    LOOK_AT_TYPE_ATTR_NAME = "NPCLookAtType";
    LOOK_AT_POS_ATTR_NAME = "NPCLookAtPos";
    LOOK_AT_OBJ_VALUE_NAME = "NPCLookAtObj";
    LOOK_AT_CONSTRAINT_NAME = "NPCLookAtConstraint";
    NETWORK_OWNER_ID_ATTR_NAME = "NPCNetworkOwnerId";
    ALLOWED_PRISMS_FOLDER_NAME = "NPCAllowedPrisms";
    HOME_POSITION_OBJ_NAME = "NPCHomePosition";
    MIN_DIST_TO_TARGET_ATTR_NAME = "NPCTargetMinDist";
    SIDE_STRAFE_MULT_ATTR_NAME = "NPCSideStrafeMult";
    JUMPING_DISABLED_ATTR_NAME = "NPCJumpingDisabled";
    FREQ_OFFSET_ATTR_NAME = "NPCFreqOffset";
    EXTRAPOLATE_TARGET_MOVEMENT_ATTR_NAME = "NPCExtrapolateTargetMovement";
    CUSTOM_NETWORK_OWNERSHIP_ATTR_NAME = "NPCCustomNetworkOwnership";
})