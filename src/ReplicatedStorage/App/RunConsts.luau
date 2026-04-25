-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local ENV_TO_WORLD_TO_PLACE_IDS = TableUtils.requireValidIndexAndFreeze({
	PROD = TableUtils.requireValidIndexAndFreeze({
		MAIN_WORLD = {
			Default = 606849621,
			VoiceChat = 17190407811,
			Hang = 17190408132,
			Pro = 108098425719662
		},
		TRADE_WORLD = {
			Default = 9780994092
		}
	}),
	QA = TableUtils.requireValidIndexAndFreeze({
		MAIN_WORLD = {
			Default = 5141682374,
			VoiceChat = 17190473751,
			Hang = 17190314798,
			Pro = 90182288573226
		},
		TRADE_WORLD = {
			Default = 9780997332
		}
	}),
	DEV = TableUtils.requireValidIndexAndFreeze({
		MAIN_WORLD = {
			Default = 6898041828,
			VoiceChat = 1,
			Hang = 17190557047,
			Pro = 7
		},
		TRADE_WORLD = {
			Default = 9781001160
		}
	}),
	STUDIO = TableUtils.requireValidIndexAndFreeze({
		MAIN_WORLD = {
			Default = 708709673,
			VoiceChat = 2,
			Hang = 3,
			Pro = 6
		},
		TRADE_WORLD = {
			Default = 4
		}
	})
})
local localTable = {}
local PLACE_ID_TO_WORLD_MAP = {}
local PLACE_ID_TO_PLACE_TYPE_MAP = {}
for environmentName, worldData in ENV_TO_WORLD_TO_PLACE_IDS do
	for worldName, placeData in worldData do
		for placeType, placeId in placeData do
			local isNotPopulated
			isNotPopulated = localTable[placeId] == nil
			assert(isNotPopulated, "env was already populated for this placeId.. duplicate?")
			localTable[placeId] = environmentName
			PLACE_ID_TO_WORLD_MAP[placeId] = worldName
			PLACE_ID_TO_PLACE_TYPE_MAP[placeId] = placeType
		end
	end
end
return TableUtils.requireValidIndexAndFreeze({
	ENV_TO_WORLD_TO_PLACE_IDS_MAP = ENV_TO_WORLD_TO_PLACE_IDS,
	PLACE_ID_TO_ENV_MAP = TableUtils.requireValidIndexAndFreeze(localTable),
	PLACE_ID_TO_WORLD_MAP = TableUtils.requireValidIndexAndFreeze(PLACE_ID_TO_WORLD_MAP),
	PLACE_ID_TO_PLACE_TYPE_MAP = TableUtils.requireValidIndexAndFreeze(PLACE_ID_TO_PLACE_TYPE_MAP),
	MAIN_WORLD_NAME = "MAIN_WORLD",
	TRADE_WORLD_NAME = "TRADE_WORLD",
	PROD_NAME = "PROD",
	QA_NAME = "QA",
	DEV_NAME = "DEV",
	STUDIO_NAME = "STUDIO"
})
