-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local v1 = TableUtils.requireValidIndexAndFreeze({
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
local t = {}
local t2 = {}
local t3 = {}
for v2, v3 in v1 do
	for v4, v5 in v3 do
		for v7, v8 in v5 do
			local v6
			v6 = t[v8] == nil
			assert(v6, "env was already populated for this placeId.. duplicate?")
			t[v8] = v2
			t2[v8] = v4
			t3[v8] = v7
		end
	end
end
return TableUtils.requireValidIndexAndFreeze({
	ENV_TO_WORLD_TO_PLACE_IDS_MAP = v1,
	PLACE_ID_TO_ENV_MAP = TableUtils.requireValidIndexAndFreeze(t),
	PLACE_ID_TO_WORLD_MAP = TableUtils.requireValidIndexAndFreeze(t2),
	PLACE_ID_TO_PLACE_TYPE_MAP = TableUtils.requireValidIndexAndFreeze(t3),
	MAIN_WORLD_NAME = "MAIN_WORLD",
	TRADE_WORLD_NAME = "TRADE_WORLD",
	PROD_NAME = "PROD",
	QA_NAME = "QA",
	DEV_NAME = "DEV",
	STUDIO_NAME = "STUDIO"
})