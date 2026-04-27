local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Enumer = require(ReplicatedStorage.Std.Enumer)
local RunConsts = require(ReplicatedStorage.App.RunConsts)
local animationTable = {
	Idle = {
		[RunConsts.QA_NAME] = "rbxassetid://11695577214",
		[RunConsts.PROD_NAME] = "rbxassetid://11815296654"
	},
	Walk = {
		[RunConsts.QA_NAME] = "rbxassetid://11827475619",
		[RunConsts.PROD_NAME] = "rbxassetid://11827471643"
	},
	Run = {
		[RunConsts.QA_NAME] = "rbxassetid://11827475619",
		[RunConsts.PROD_NAME] = "rbxassetid://11827471643"
	},
	Aim = {
		[RunConsts.QA_NAME] = "rbxassetid://11753607758",
		[RunConsts.PROD_NAME] = "rbxassetid://11815301824"
	},
	Lunge = {
		[RunConsts.QA_NAME] = "rbxassetid://11702729199",
		[RunConsts.PROD_NAME] = "rbxassetid://11815307897"
	},
	WaveLeft = {
		[RunConsts.QA_NAME] = "rbxassetid://11815391271",
		[RunConsts.PROD_NAME] = "rbxassetid://11815385198"
	},
	WaveRight = {
		[RunConsts.QA_NAME] = "rbxassetid://11815394623",
		[RunConsts.PROD_NAME] = "rbxassetid://11815402638"
	}
}
for animationName, animationData in animationTable do
	animationData[RunConsts.DEV_NAME] = animationData[RunConsts.PROD_NAME]
	animationData[RunConsts.STUDIO_NAME] = animationData[RunConsts.DEV_NAME]
end
return TableUtils.requireValidIndexAndFreeze({
	TAG_NAME = "MansionBossNPC",
	MOVEMENT_STATE = Enumer({ "None", "StrafeTarget", "GoToTarget" }),
	MOVEMENT_STATE_ATTR_NAME = "BossMovementState",
	ATTACK_STATE = Enumer({ "None", "LockedNone", "ExtendoWhack", "LaserSweep", "AuraBlast", "MansionCameras", "MansionLasers", "CallInGuards" }),
	ATTACK_STATE_ATTR_NAME = "BossAttackState",
	EXTENDO_WHACK_WARM_UP_DURATION = 2,
	EXTENDO_WHACK_DURATION = 3.8,
	LASER_SWEEP_WARM_UP_DURATION = 2,
	LASER_SWEEP_TIME_BTWN_TARAGETS = 0.5,
	AURA_BLAST_ATTACK_DATA = {
		{
			MaxTimeToActivate = 200,
			PercentHealthToTriggerAt = 10
		}
	},
	AURA_BLAST_DURATION = 1.5,
	AURA_BLAST_MAX_SIZE = 200,
	AURA_BLAST_PERCENT_HEALTH_TO_RECOVER = 20,
	WALK_TO_DEST_DURATION = 2,
	DAMAGE_SELF_REMOTE_NAME = "MansionBossNPCDamage",
	ANIMATION = animationTable,
	ANIMATION_LINEAR_VELOCITY = {
		Walk = Vector2.new(0, 32),
		Run = Vector2.new(0, 32)
	}
})
