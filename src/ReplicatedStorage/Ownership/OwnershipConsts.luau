local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local t = {
	COLOR_CATEGORY_TYPES = {
		WheelColor = true,
		BodyColor = true,
		SecondBodyColor = true,
		WindowColor = true,
		HeadlightsColor = true,
		SpoilerColor = true,
		Glow = true,
		InteriorMainColor = true,
		InteriorDetailColor = true,
		SeatColor = true
	},
	TEXTURE_CATEGORY_TYPES = {
		SecondTexture = true
	},
	VEHICLE_CUSTOMIZATION_CATEGORY_NAMES = {
		"Texture",
		"Engine",
		"Rim",
		"SuspensionHeight",
		"Brakes",
		"Spoiler",
		"TireSticker",
		"TireMesh",
		"WindowTint",
		"Horn",
		"Color",
		"Drift"
	},
	VEHICLE_CUSTOMIZATION_CATEGORY_NAME_SET = {}
}
for i, v in ipairs(t.VEHICLE_CUSTOMIZATION_CATEGORY_NAMES) do
	t.VEHICLE_CUSTOMIZATION_CATEGORY_NAME_SET[v] = true
end
return TableUtils.requireValidIndexAndFreeze(t)