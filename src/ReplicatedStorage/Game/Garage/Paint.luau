-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings = require(ReplicatedStorage.Resource.Settings)
local HyperChromeUtils = require(ReplicatedStorage.HyperChrome.HyperChromeUtils)
local HyperChromeConsts = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local COLORS = {
	Chrome = {
		Color = Color3.fromRGB(248, 248, 248),
		Reflectance = 1,
		Material = Enum.Material.SmoothPlastic
	},
	FallChrome = {
		Color = Color3.fromRGB(207, 96, 36),
		Reflectance = 0.4,
		Material = Enum.Material.SmoothPlastic
	},
	Gold = {
		Color = Color3.fromRGB(188, 155, 93),
		Reflectance = 0.3
	},
	RadiantYellow = {
		Color = Color3.fromRGB(112, 168, 38),
		Material = Enum.Material.Neon
	},
	RadiantOrange = {
		Color = Color3.fromRGB(174, 108, 34),
		Material = Enum.Material.Neon
	},
	RadiantIce = {
		Color = Color3.fromRGB(20, 104, 175),
		Material = Enum.Material.Neon
	},
	Vantablack = {
		Color = Color3.fromRGB(0, 0, 0),
		Material = Enum.Material.Neon
	},
	RadiantGreen = {
		Color = Color3.fromRGB(51, 171, 78),
		Material = Enum.Material.Neon
	},
	MilitaryGreen = {
		Color = Color3.fromRGB(74, 83, 60)
	},
	Black = {
		Color = Color3.fromRGB(0, 0, 0),
		Reflectance = 0.02
	},
	NavyBlue = {
		Color = Color3.fromRGB(0, 42, 75)
	},
	HottestPink = {
		Color = Color3.fromRGB(255, 91, 236)
	},
	Maroon = {
		Color = Color3.fromRGB(92, 0, 23)
	},
	RealGreen = {
		Color = Color3.fromRGB(26, 124, 0)
	},
	DarkestPurple = {
		Color = Color3.fromRGB(30, 4, 41),
		Reflectance = 0.02
	},
	DarkestBlue = {
		Color = Color3.fromRGB(1, 12, 46),
		Reflectance = 0.02
	},
	DarkestGreen = {
		Color = Color3.fromRGB(0, 40, 14),
		Reflectance = 0.02
	},
	DarkestMarine = {
		Color = Color3.fromRGB(0, 45, 44),
		Reflectance = 0.02
	},
	DarkestRed = {
		Color = Color3.fromRGB(41, 0, 2),
		Reflectance = 0.02
	},
	DarkestBrown = {
		Color = Color3.fromRGB(46, 22, 0),
		Reflectance = 0.02
	},
	RadiantPurple = {
		Color = Color3.fromRGB(74, 58, 171),
		Material = Enum.Material.Neon
	},
	SakuraPink = {
		Color = Color3.fromRGB(255, 118, 125)
	},
	RadiantRed = {
		Color = Color3.fromRGB(163, 23, 2),
		Material = Enum.Material.Neon
	},
	RadiantPink = {
		Color = Color3.fromRGB(181, 86, 158),
		Material = Enum.Material.Neon
	},
	RadiantSun = {
		Color = Color3.fromRGB(182, 129, 99),
		Material = Enum.Material.Neon
	},
	RadiantPolarBlue = {
		Color = Color3.fromRGB(0, 0, 165),
		Material = Enum.Material.Neon
	},
	Mud = {
		Color = Color3.fromRGB(102, 86, 68)
	},
	RadiantWhite = {
		Color = Color3.fromRGB(160, 160, 165),
		Material = Enum.Material.Neon
	},
	SnowWhite = {
		Color = Color3.fromRGB(255, 255, 255)
	}
}
for v1, hyperchromeNames in HyperChromeUtils.getListOfHyperChromeNames() do
	local chromeColor = HyperChromeUtils.getColorFromName(hyperchromeNames)
	local colorLevelInfo = HyperChromeConsts.COLOR_TO_INFO_MAP[chromeColor].LevelToColor[HyperChromeUtils.getLevelFromName(hyperchromeNames)]
	local hue, saturation, value = Color3.new(math.clamp(colorLevelInfo.r, 0, 1), math.clamp(colorLevelInfo.g, 0, 1), (math.clamp(colorLevelInfo.b, 0, 1))):ToHSV()
	COLORS[hyperchromeNames] = {
		Color = Color3.fromHSV(hue, saturation, (math.clamp(value * 2 / 3, 0, 1))),
		Reflectance = 0.1
	}
end
COLORS[HyperChromeConsts.COLOR_SHIFT_NAME] = {
	Color = Color3.fromRGB(1, 1, 1),
	Reflectance = 0.1
}
return {
	GetColor = function(colorName)
		if COLORS[colorName] then
			return COLORS[colorName].Color
		elseif Settings.Colors[colorName] then
			return Settings.Colors[colorName]
		else
			return nil
		end
	end,
	Part = function(part, colorName, paintOptions)
		assert(part ~= nil)
		assert(colorName ~= nil)
		assert(paintOptions ~= nil)
		assert(paintOptions.DefaultReflectance ~= nil)
		assert(if paintOptions.DefaultMaterial == nil then paintOptions.DisableMaterial == true else true)
		if COLORS[colorName] then
			local paintColorInfo = COLORS[colorName]
			part.Color = paintColorInfo.Color
			if not paintOptions.DisableReflectance then
				if paintColorInfo.Reflectance == nil then
					part.Reflectance = paintOptions.DefaultReflectance
				else
					part.Reflectance = paintOptions.OverrideReflectance or paintColorInfo.Reflectance
				end
			end
			if paintOptions.DisableMaterial then
			elseif paintColorInfo.Material == nil then
				part.Material = paintOptions.DefaultMaterial
			else
				part.Material = paintOptions.OverrideMaterial or paintColorInfo.Material
			end
		elseif Settings.Colors[colorName] then
			part.Color = Settings.Colors[colorName]
			part.Reflectance = paintOptions.DefaultReflectance
			if not paintOptions.DisableMaterial then
				part.Material = paintOptions.DefaultMaterial
			end
		else
			error(("No color exists named: %s"):format(colorName))
		end
	end
}
