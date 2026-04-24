-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = {
	require(ReplicatedStorage.Sale.SaleConsts).CATEGORY_NAME,
	"Texture",
	"SecondTexture",
	"BodyColor",
	"SecondBodyColor",
	"Engine",
	"Glow",
	"Horn",
	"Rim",
	"WheelColor",
	"Drift",
	"TireSticker",
	"TireMesh",
	"SuspensionHeight",
	"Brakes",
	"WindowColor",
	"WindowTint",
	"InteriorMainColor",
	"InteriorDetailColor",
	"SeatColor",
	"Spoiler",
	"SpoilerColor",
	"HeadlightsColor"
}
local t2 = {
	Texture = require(script.Parent.Category.Texture),
	SecondTexture = require(script.Parent.Category.SecondTexture),
	BodyColor = require(script.Parent.Category.BodyColor),
	SecondBodyColor = require(script.Parent.Category.SecondBodyColor),
	Engine = require(script.Parent.Category.Engine),
	Glow = require(script.Parent.Category.Glow),
	Horn = require(script.Parent.Category.Horn),
	Rim = require(script.Parent.Category.Rim),
	WheelColor = require(script.Parent.Category.WheelColor),
	Drift = require(script.Parent.Category.Drift),
	TireSticker = require(script.Parent.Category.TireSticker),
	TireMesh = require(script.Parent.Category.TireMesh),
	SuspensionHeight = require(script.Parent.Category.SuspensionHeight),
	Brakes = require(script.Parent.Category.Brakes),
	WindowColor = require(script.Parent.Category.WindowColor),
	WindowTint = require(script.Parent.Category.WindowTint),
	InteriorMainColor = require(script.Parent.Category.InteriorMainColor),
	InteriorDetailColor = require(script.Parent.Category.InteriorDetailColor),
	SeatColor = require(script.Parent.Category.SeatColor),
	Spoiler = require(script.Parent.Category.Spoiler),
	SpoilerColor = require(script.Parent.Category.SpoilerColor),
	HeadlightsColor = require(script.Parent.Category.HeadlightsColor)
}
return {
	GetCategoriesByModel = function(p1)
		local t3 = {}
		for v1, v2 in t do
			local var3 = t2[v2]
			if not var3 or var3(p1) then
				table.insert(t3, v2)
			end
		end
		return t3
	end,
	CATEGORIES = t,
	MAP_CATEGORY_TO_FUNC = t2
}