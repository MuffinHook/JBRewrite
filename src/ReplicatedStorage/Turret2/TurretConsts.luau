-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	SHOOT_HZ_ATTR_NAME = "TurretShootHz",
	TARGET_PTR_NAME = "TurretTargetPtr",
	REPORT_HIT_REMOTE_NAME = "TurretReportHit",
	USE_LASER_ATTR_NAME = "TurretUseLaser"
})
