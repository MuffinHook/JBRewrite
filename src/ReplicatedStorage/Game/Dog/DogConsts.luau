local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Game.PlaceConsts)
local Enumer = require(ReplicatedStorage.Std.Enumer)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Settings = require(ReplicatedStorage.Resource.Settings)
local v1 = Enumer({ "FOLLOW", "ATTACK", "REST", "PET" })
local v2 = Enumer({ "IDLE", "IDLE_PLAY", "WALK", "SPRINT", "BARK", "REST", "PET", "POINT" })
local t = { "GERMAN", "BULLDOG" }
local v3 = Enumer(t)
return TableUtils.requireValidIndexAndFreeze({
	TAG_NAME = "Dog",
	BREED_ID_VALUE_NAME = "BreedId",
	OWNER_ID_VALUE_NAME = "OwnerId",
	TARGET_ID_VALUE_NAME = "TargetId",
	BODY_VELOCITY_NAME = "Move",
	BODY_GYRO_NAME = "Rotate",
	DAMAGE_REMOTE_NAME = "Bite",
	BARK_REMOTE_NAME = "Bark",
	ANIM_REMOTE_NAME = "Anim",
	GIVE_UP_REMOTE_NAME = "GiveUp",
	SEAT_WELD_NAME = "DogSeatWeld",
	IS_MOUNTED_NAME = "IsMounted",
	ATTACK_LEAD_TIME = 0.25,
	BARK_OPP_RADIUS = 192,
	BARK_CONFUSION_RADIUS = 32,
	GIVE_UP_AFTER_DIST = 256,
	GIVE_UP_AFTER_STUCK_FOR = 10,
	TELEPORT_AFTER_STUCK_FOR = 10,
	TELEPORT_AFTER_DIST = 200,
	STATE = v1,
	ATTACK_STATE = Enumer({ "TO", "AWAY" }),
	ANIM_STATE = v2,
	ANIM_SPS = {
		[v3.GERMAN] = {
			[v2.WALK] = 5.3,
			[v2.SPRINT] = 20
		},
		[v3.BULLDOG] = {
			[v2.WALK] = 3.5,
			[v2.SPRINT] = 15
		}
	},
	LIST_BREED = t,
	ENUM_BREED = v3,
	PRICE = {
		[v3.GERMAN] = 50000,
		[v3.BULLDOG] = 80000
	},
	TITLE = {
		[v3.GERMAN] = "German Shepherd",
		[v3.BULLDOG] = "Bulldog"
	},
	IMAGE_ID = {
		[v3.GERMAN] = 6347878911,
		[v3.BULLDOG] = 6347879072
	},
	BARK_SOUND_ID = {
		[v3.GERMAN] = 6293873737,
		[v3.BULLDOG] = 6338502764
	},
	TOP_SPEED = {
		[v3.GERMAN] = 50,
		[v3.BULLDOG] = 40
	},
	OPT_TEAM = {
		[v3.GERMAN] = Settings.EnumTeam.Police,
		[v3.BULLDOG] = Settings.EnumTeam.Criminal
	},
	ANIM_ID = {
		[v3.GERMAN] = {
			[v2.IDLE] = 6252140847,
			[v2.IDLE_PLAY] = 6279995452,
			[v2.WALK] = 6252143393,
			[v2.SPRINT] = 6257288839,
			[v2.BARK] = 6293871070,
			[v2.REST] = 6293999630,
			[v2.POINT] = 6318248236,
			[v2.PET] = 6318247355
		},
		[v3.BULLDOG] = {
			[v2.IDLE] = 6318234238,
			[v2.IDLE_PLAY] = 6318235063,
			[v2.WALK] = 6318231969,
			[v2.SPRINT] = 6318232952,
			[v2.BARK] = 6293871070,
			[v2.REST] = 6318236534,
			[v2.POINT] = 6318237482,
			[v2.PET] = 6318238515
		}
	},
	BODY_VELOCITY_MAX_FORCE = Vector3.new(5000, 0, 5000),
	BODY_GYRO_MAX_TORQUE = Vector3.new(100000, 100000, 100000)
})