return require(game:GetService("ReplicatedStorage").Std.TableUtils).requireValidIndexAndFreeze({
    TAG_NAME = "SeekingMissile";
    ALIGN_ORIENTATION_NAME = "SeekingMissileAlignOrientation";
    VECTOR_FORCE_NAME = "SeekingMissileVectorForce";
    PHYSICS_ATTACHMENT_NAME = "SeekingMissilePhysicsAttachment";
    TARGET_PART_OBJ_NAME = "SeekingMissileTargetPart";
    TARGET_POS_ATTR_NAME = "SeekingMissileTargetPos";
    ACCEL_ATTR_NAME = "SeekingMissileAccel";
    LIFE_SPAN_ATTR_NAME = "SeekingMissileLifeSpan";
    SEEK_AFTER_DURATION_ATTR_NAME = "SeekingMissileSeekAfterDuration";
    NO_IMPROVEMENT_EXPLODE_DURATION_ATTR_NAME = "SeekingMissileNoImprovementDuration";
    CONNECT_HIT_AFTER_DURATION_ATTR_NAME = "SeekingMissileConnetHitAfterDuration";
    DROP_DURATION_ATTR_NAME = "SeekingMissileDropDuration";
    FORWARD_DRAG_ATTR_NAME = "SeekingMissileForwardDrag";
    LATERAL_DRAG_ATTR_NAME = "SeekingMissileLateralDrag";
    ALIGN_RESPONSIVENESS_ATTR_NAME = "SeekingMissileAlignResponsiveness";
    APPLYING_THRUST_ATTR_NAME = "SeekingMissileApplyingThrust";
    APPLYING_THRUST_REMOTE_NAME = "SeekingMissileApplyingThrust";
    EXPLODE_REMOTE_NAME = "SeekingMissileExplode";
})