local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
local t = {
	COLOR_TO_INFO_MAP = {
		Green = {
			LevelToColor = {
				Color3.fromRGB(26, 101, 13),
				Color3.fromRGB(32, 124, 16),
				Color3.fromRGB(41, 157, 20),
				Color3.fromRGB(53, 208, 25),
				Color3.fromRGB(105, 305, 25)
			},
			ImageId = 10078557998,
			Robberies = { RobberyConsts.ENUM_ROBBERY.BANK, RobberyConsts.ENUM_ROBBERY.BANK2 }
		},
		Yellow = {
			LevelToColor = {
				Color3.fromRGB(116, 96, 3),
				Color3.fromRGB(159, 129, 4),
				Color3.fromRGB(220, 174, 7),
				Color3.fromRGB(239, 239, 10),
				Color3.fromRGB(320, 325, 0)
			},
			ImageId = 10078558710,
			Robberies = { RobberyConsts.ENUM_ROBBERY.TRAIN_PASSENGER, RobberyConsts.ENUM_ROBBERY.TRAIN_CARGO }
		},
		Orange = {
			LevelToColor = {
				Color3.fromRGB(118, 67, 3),
				Color3.fromRGB(139, 78, 3),
				Color3.fromRGB(190, 108, 33),
				Color3.fromRGB(253, 130, 8),
				Color3.fromRGB(553, 155, 40)
			},
			ImageId = 10078559365,
			Robberies = { RobberyConsts.ENUM_ROBBERY.MUSEUM }
		},
		Red = {
			LevelToColor = {
				Color3.fromRGB(104, 20, 4),
				Color3.fromRGB(131, 22, 4),
				Color3.fromRGB(181, 30, 5),
				Color3.fromRGB(255, 40, 0),
				Color3.fromRGB(400, 40, 0)
			},
			ImageId = 10078562858,
			Robberies = { RobberyConsts.ENUM_ROBBERY.TOMB }
		},
		Pink = {
			LevelToColor = {
				Color3.fromRGB(108, 8, 73),
				Color3.fromRGB(130, 6, 86),
				Color3.fromRGB(157, 7, 101),
				Color3.fromRGB(216, 6, 136),
				Color3.fromRGB(452, 0, 157)
			},
			ImageId = 10078560425,
			Robberies = { RobberyConsts.ENUM_ROBBERY.CROWN_JEWEL }
		},
		Purple = {
			LevelToColor = {
				Color3.fromRGB(62, 5, 118),
				Color3.fromRGB(84, 0, 149),
				Color3.fromRGB(99, 0, 185),
				Color3.fromRGB(119, 0, 213),
				Color3.fromRGB(130, 50, 450)
			},
			ImageId = 10078561175,
			Robberies = { RobberyConsts.ENUM_ROBBERY.POWER_PLANT }
		},
		Blue = {
			LevelToColor = {
				Color3.fromRGB(1, 34, 101),
				Color3.fromRGB(2, 38, 116),
				Color3.fromRGB(3, 52, 160),
				Color3.fromRGB(7, 80, 255),
				Color3.fromRGB(34, 60, 600)
			},
			ImageId = 10078561718,
			Robberies = { RobberyConsts.ENUM_ROBBERY.CARGO_PLANE }
		},
		Diamond = {
			LevelToColor = {
				Color3.fromRGB(9, 76, 104),
				Color3.fromRGB(12, 96, 131),
				Color3.fromRGB(15, 120, 160),
				Color3.fromRGB(19, 156, 212),
				Color3.fromRGB(68, 218, 455)
			},
			ImageId = 10078562310,
			Robberies = { RobberyConsts.ENUM_ROBBERY.JEWELRY }
		}
	},
	LEVEL_TO_INFO_MAP = {
		{
			NumberImageId = "rbxassetid://10080075007"
		},
		{
			NumberImageId = "rbxassetid://10080074657"
		},
		{
			NumberImageId = "rbxassetid://10080074328"
		},
		{
			NumberImageId = "rbxassetid://10080048511"
		},
		{
			NumberImageId = "rbxassetid://10080075909"
		}
	},
	HYPERCHROME_PREFIX = "Hyper",
	LEVEL_PREFIX = "Lvl",
	HYPERCHROME_NAME_ATTRIBUTE_NAME = "HyperChromeAppliedName",
	MAX_LEVEL_HYPERCHROME_PARTICLE_RESOURCE_NAME = "HyperChromeLevel5Particles",
	HYPERCHROME_NUMBER_PARTICLE_RESOURCE_NAME = "HyperChromeNumberParticleEmitter",
	HYPERSHIFT_PARTICLE_RESOURCE_NAME = "HyperShiftAuraParticles",
	RAINBOW_ANIMATION_CYCLE_TIME = 5,
	WILDCARD_HYPERCHROME_IMAGE_ID = 11815685831
}
t.MAX_LEVEL = #t.LEVEL_TO_INFO_MAP
t.COLOR_SHIFT_NAME = t.HYPERCHROME_PREFIX .. "Shift"
t.ROBBERY_TO_HYPERCHROME_COLOR_MAP = {}
t.HYPERSHIFT_REFLECTANCE = t.LEVEL_TO_INFO_MAP[4].Reflectance
for v1, v2 in t.COLOR_TO_INFO_MAP do
	for v3, v4 in v2.Robberies do
		t.ROBBERY_TO_HYPERCHROME_COLOR_MAP[v4] = v1
	end
end
return TableUtils.requireValidIndexAndFreeze(t)