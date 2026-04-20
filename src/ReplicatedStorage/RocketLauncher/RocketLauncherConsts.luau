return require(game:GetService("ReplicatedStorage").Std.TableUtils).requireValidIndexAndFreeze({
    MISSILE_OBJ_POOL_NAME = "RocketLauncherHolderMissilePool";
    ROCKET_TAG_NAME = "RocketLauncherRocket";
    SEEKING_LOCK_MIN_DURATION = 2;
})