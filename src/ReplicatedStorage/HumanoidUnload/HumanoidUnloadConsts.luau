return require(game:GetService("ReplicatedStorage").Std.TableUtils).requireValidIndexAndFreeze({
    MAX_DIST_TO_LOAD = 768;
    HUMANOID_EXISTS_OBJ_NAME = "HumanoidUnloadExists";
    NETWORK_OWNER_ID_OBJ_NAME = "HumanoidUnloadNetworkOwnerId";
    SERVER_POSITION_OBJ_NAME = "HumanoidUnloadServerPosition";
    MAX_DIST_TO_LOAD_ATTR_NAME = "MaxDistToLoad";
})