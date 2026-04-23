-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Enumer = require(ReplicatedStorage.Std.Enumer)
local v1 = TableUtils.requireValidIndexAndFreeze({ "Easy", "Medium", "Hard" })
local t = {
	FORCEFIELD_DISALLOWED_PART_SIZE = Vector3.new(30, 1, 30),
	IN_AMBULANCE_STRETCHER_OBJ_NAME = "InAmbulanceStretcher",
	FIREWORK_FX_REMOTE_NAME = "AirDropFireworks",
	ALLOWED_PART_TAG_NAME = "AirDropAllowedPart",
	MAX_NUM_LAUNCH_RETRIES = 1000,
	NPC_GUARD_MINIMUM_SPACE = 50,
	NPC_GUARD_WEAPON_GRACE_PERIOD = 2,
	GUARD_ALLOWED_REGION_RADIUS = 125,
	GUARD_ITEM_TO_DATA_MAP = {
		Sniper = {
			AllowedRegionSizeMultiplier = 0.3,
			MaxShootDistanceMultiplier = 2,
			HealthMultiplier = 0.5,
			BulletSpreadMultiplier = 0,
			TriggerPressFreqMultiplier = 0.5
		},
		Shotgun = {
			AllowedRegionSizeMultiplier = 2,
			WalkSpeedMultiplier = 2,
			HealthMultiplier = 0.5,
			SideStrafeMultMult = 0.5
		},
		Rifle = {
			AllowedRegionSizeMultiplier = 1.5,
			WalkSpeedMultiplier = 1.5,
			HealthMultiplier = 1.1,
			TriggerPressFreqMultiplier = 1.5,
			BulletSpreadMultiplier = 0.9
		},
		Uzi = {
			WalkSpeedMultiplier = 1,
			HealthMultiplier = 0.6,
			TriggerPressFreqMultiplier = 1.5
		},
		Pistol = {
			AllowedRegionSizeMultiplier = 0.5,
			WalkSpeedMultiplier = 1.25,
			HealthMultiplier = 0.8,
			TriggerPressFreqMultiplier = 1,
			BulletSpreadMultiplier = 0.4
		},
		PlasmaPistol = {
			AllowedRegionSizeMultiplier = 0.5,
			WalkSpeedMultiplier = 1.25,
			HealthMultiplier = 0.8,
			TriggerPressFreqMultiplier = 1,
			BulletSpreadMultiplier = 0.4
		},
		PlasmaShotgun = {
			AllowedRegionSizeMultiplier = 2,
			WalkSpeedMultiplier = 2,
			HealthMultiplier = 0.5,
			SideStrafeMultMult = 0.5
		}
	},
	GUARD_BUFFER_LENGTH_FROM_AIRDROP = 4,
	MONEY_DROP_MINIMUM_SPACE = 20,
	TYPE_ENUM_TO_NAME = v1,
	TYPE_ENUM = Enumer(v1),
	AIR_DROP_TYPE_ENUM_ATTRIBUTE_NAME = "AirDropTypeEnum",
	AIR_DROP_OPEN_DURATION = 4,
	SPINNER_TOTAL_NUM_CARDS = 30,
	CASH_REPLACEMENT_REWARD_AMOUNT = 5000,
	AIR_DROP_REWARD_SPINNER_CONTEXT = "AirDropOpen",
	NPC_FOLDER_NAME = "NPCs",
	MAX_MANSION_INVITES = 5,
	PLAYER_ROB_COOLDOWN = 360
}
t.GUARD_ITEM_TO_DATA_MAP.Revolver = TableUtils.deepCopy(t.GUARD_ITEM_TO_DATA_MAP.Pistol)
t.SPINNER_STOP_INDEX = t.SPINNER_TOTAL_NUM_CARDS - 4
return TableUtils.requireValidIndexAndFreeze(t)