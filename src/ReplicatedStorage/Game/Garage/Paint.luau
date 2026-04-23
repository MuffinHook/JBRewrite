-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings = require(ReplicatedStorage.Resource.Settings)
local HyperChromeUtils = require(ReplicatedStorage.HyperChrome.HyperChromeUtils)
local HyperChromeConsts = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local t = {
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
for v1, v2 in HyperChromeUtils.getListOfHyperChromeNames() do
	local v3 = HyperChromeUtils.getColorFromName(v2)
	local v4 = HyperChromeConsts.COLOR_TO_INFO_MAP[v3].LevelToColor[HyperChromeUtils.getLevelFromName(v2)]
	local v8, v9, v10 = Color3.new(math.clamp(v4.r, 0, 1), math.clamp(v4.g, 0, 1), (math.clamp(v4.b, 0, 1))):ToHSV()
	t[v2] = {
		Color = Color3.fromHSV(v8, v9, (math.clamp(v10 * 2 / 3, 0, 1))),
		Reflectance = 0.1
	}
end
t[HyperChromeConsts.COLOR_SHIFT_NAME] = {
	Color = Color3.fromRGB(1, 1, 1),
	Reflectance = 0.1
}
return {
	GetColor = function(p1)
		if t[p1] then
			return t[p1].Color
		elseif Settings.Colors[p1] then
			return Settings.Colors[p1]
		else
			return nil
		end
	end,
	Part = function(p1, p2, p3)
		assert(p1 ~= nil)
		assert(p2 ~= nil)
		assert(p3 ~= nil)
		assert(p3.DefaultReflectance ~= nil)
		assert(if p3.DefaultMaterial == nil then p3.DisableMaterial == true else true)
		if t[p2] then
			local v6 = t[p2]
			p1.Color = v6.Color
			if not p3.DisableReflectance then
				if v6.Reflectance == nil then
					p1.Reflectance = p3.DefaultReflectance
				else
					p1.Reflectance = p3.OverrideReflectance or v6.Reflectance
				end
			end
			if p3.DisableMaterial then
			elseif v6.Material == nil then
				p1.Material = p3.DefaultMaterial
			else
				p1.Material = p3.OverrideMaterial or v6.Material
			end
		elseif Settings.Colors[p2] then
			p1.Color = Settings.Colors[p2]
			p1.Reflectance = p3.DefaultReflectance
			if not p3.DisableMaterial then
				p1.Material = p3.DefaultMaterial
			end
		else
			error(("No color exists named: %s"):format(p2))
		end
	end
}