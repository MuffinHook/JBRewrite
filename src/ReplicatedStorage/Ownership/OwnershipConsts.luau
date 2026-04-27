local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local ownershipConstants = {
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
for index, categoryName in ipairs(ownershipConstants.VEHICLE_CUSTOMIZATION_CATEGORY_NAMES) do
	ownershipConstants.VEHICLE_CUSTOMIZATION_CATEGORY_NAME_SET[categoryName] = true
end
return TableUtils.requireValidIndexAndFreeze(ownershipConstants)
