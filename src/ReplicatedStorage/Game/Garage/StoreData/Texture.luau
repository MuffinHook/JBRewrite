-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.App.RunUtils)
local TextureData = require(ReplicatedStorage.Game.Garage.TextureData)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local Texture = require(ReplicatedStorage.Game.Garage.Customize.Texture)
local SpecialTextureData = require(ReplicatedStorage.Game.Garage.SpecialTextureData)
require(ReplicatedStorage.Resource.Settings)
local getDefaultVehicleModel = require(ReplicatedStorage.Game.getDefaultVehicleModel)
return {
	Items = {
		{
			Name = "None",
			None = true,
			Price = 0
		},
		{
			Name = "JBX0031",
			Hidden = true,
			NoTrade = true,
			Makes = {
				JBX0031 = true
			}
		},
		{
			Name = "Bluebird",
			Hidden = true,
			NoTrade = true,
			Makes = {
				Bluebird = true
			}
		},
		{
			Name = "DigitalRGB",
			Season = 31,
			Level = 8,
			SeasonIconId = 72190265450888
		},
		{
			Name = "Chilling",
			Hidden = true,
			Season = 30,
			Level = 8,
			SeasonIconId = 73238407176601
		},
		{
			Name = "BlackWidow",
			Hidden = true,
			NoTrade = true,
			Makes = {
				BlackWidow = true
			}
		},
		{
			Name = "PolaireCamo",
			Hidden = true,
			NoTrade = true,
			Makes = {
				Polaire = true
			}
		},
		{
			Name = "RunNGun",
			Hidden = true,
			NoTrade = true,
			Makes = {
				Polaire = true
			}
		},
		{
			Name = "RobloxStud",
			Season = 29,
			SeasonIconId = 78147167881070,
			Level = 8
		},
		{
			Name = "Cracky4JB",
			Hidden = true,
			NoTrade = true
		},
		{
			Name = "Katana",
			Hidden = true,
			NoTrade = true,
			Makes = {
				Katana = true
			}
		},
		{
			Name = "WYNDR",
			Hidden = true,
			NoTrade = true,
			Makes = {
				WYNDR = true
			}
		},
		{
			Hidden = true,
			Name = "VibrantHologram",
			Season = 28,
			Level = 8,
			SeasonIconId = 111938569755837
		},
		{
			Name = "Buccaneer",
			SeasonIconId = 109276018269508,
			Season = 27,
			Level = 8
		},
		{
			Name = "Snakeskin",
			SeasonIconId = 132978225438864,
			Season = 26,
			Level = 8
		},
		{
			Name = "Prehistoric",
			Hidden = true
		},
		{
			Name = "BluePixelRacer",
			Level = 8,
			Season = 25,
			SeasonIconId = 129784635817884
		},
		{
			Name = "AlpineRacer",
			Level = 6,
			Season = 24,
			SeasonIconId = 89109097938987
		},
		{
			Name = "Retrowave",
			Level = 8,
			Season = 23,
			SeasonIconId = 139221938818815
		},
		{
			Name = "Electronic",
			Hidden = true
		},
		{
			Name = "SWATGraffiti",
			Hidden = true,
			Makes = {
				SWATVan = true
			},
			Tags = { "Event" },
			NoTrade = true
		},
		{
			Name = "ComicConvict",
			Hidden = true
		},
		{
			Name = "StarSpangled",
			Level = 8,
			Season = 22,
			SeasonIconId = 18128197813
		},
		{
			Name = "Ogre2017",
			Level = 8,
			Season = 21,
			SeasonIconId = 17124573099
		},
		{
			Name = "CamoShark"
		},
		{
			Name = "Striker",
			Hidden = true,
			NoTrade = true,
			Makes = {
				Striker = true
			}
		},
		{
			Name = "RoadHazard",
			Season = 20,
			Level = 8,
			SeasonIconId = 16176421396
		},
		{
			Name = "Aurora",
			Season = 19,
			Level = 8,
			SeasonIconId = 15624647247
		},
		{
			Name = "Bandana",
			Season = 18,
			Level = 8,
			SeasonIconId = 14952758595
		},
		{
			Name = "LeEclair",
			Price = 21000
		},
		{
			Name = "BerlinGraffiti",
			Season = 17,
			Level = 8,
			SeasonIconId = 14279338463
		},
		{
			Name = "Aquatic",
			Season = 16,
			Level = 6,
			SeasonIconId = 13686304004
		},
		{
			Name = "DragonScales",
			Price = 100000
		},
		{
			Name = "Watermelon",
			Price = 50000
		},
		{
			Name = "NuclearWaste",
			Price = 50000
		},
		{
			Name = "DeepPurpleFlame",
			Price = 120000
		},
		{
			Name = "PatchyJeans",
			Price = 30000
		},
		{
			Name = "DesertCamo",
			Price = 80000
		},
		{
			Name = "Shogun",
			Hidden = true,
			NoTrade = true,
			Makes = {
				Shogun = true
			}
		},
		{
			Name = "Manga",
			Season = 15,
			Level = 8,
			SeasonIconId = 12995658765
		},
		{
			Name = "NASCAR75th",
			Hidden = true,
			NoTrade = true,
			Makes = {
				NASCAR75th = true
			}
		},
		{
			Name = "NASCARHauler",
			Hidden = true,
			NoTrade = true,
			Makes = {
				Semi = true
			}
		},
		{
			Name = "Touchdown",
			Season = 14,
			Level = 4,
			SeasonIconId = 12424993338
		},
		{
			Name = "Lava",
			Season = 13,
			Level = 8,
			SeasonIconId = 11811058968
		},
		{
			Name = "CamoRadar",
			Season = 12,
			Level = 8,
			SeasonIconId = 11183661970
		},
		{
			Name = "CarbonFire",
			Price = 325000
		},
		{
			Name = "WoodenToy",
			Season = 11,
			Level = 6,
			SeasonIconId = 10529385461
		},
		{
			Name = "RoadWarrior",
			Price = 100000
		},
		{
			Name = "WhiteMarble",
			Season = 10,
			Level = 8
		},
		{
			Name = "Superstar",
			Season = 10,
			TopPct = 2
		},
		{
			Name = "DirtRally",
			Season = 9,
			Level = 10
		},
		{
			Name = "MCL36",
			Hidden = true,
			Makes = {
				MCL36 = true,
				MCL36FREE = true
			},
			Tags = { "Event" },
			NoTrade = true
		},
		{
			Name = "CircuitBoard",
			Season = 8,
			Level = 8
		},
		{
			Name = "IceCamo",
			Hidden = true,
			Season = 7,
			TopPct = 1
		},
		{
			Name = "BlackIce",
			Season = 7,
			Level = 8
		},
		{
			Name = "NASCAR1",
			Hidden = true,
			Makes = {
				NASCAR1 = true
			},
			Tags = { "Event" },
			NoTrade = true
		},
		{
			Name = "NASCAR2",
			Hidden = true,
			Makes = {
				NASCAR2 = true
			},
			Tags = { "Event" },
			NoTrade = true
		},
		{
			Name = "Gulf",
			Hidden = true,
			Season = 6,
			TopPct = 10
		},
		{
			Name = "Flaming",
			Hidden = true,
			Season = 6,
			TopPct = 5
		},
		{
			Name = "Drip",
			Season = 5,
			Level = 8
		},
		{
			Name = "CrimsonRacer",
			Season = 6,
			Level = 8
		},
		{
			Name = "Earthquake",
			Season = 4,
			Level = 5
		},
		{
			Name = "DigitalConfetti",
			Hidden = true,
			Season = 3,
			Level = 4
		},
		{
			Name = "GalacticCarbon",
			Season = 2,
			Level = 8
		},
		{
			Name = "Snowstorm",
			Season = 1,
			Level = 5
		},
		{
			Name = "Fire",
			Season = 1,
			Level = 8
		},
		{
			Name = "GalaxyWave",
			Price = 20000
		},
		{
			Name = "Ball",
			Price = 20000
		},
		{
			Name = "Rainbow",
			Price = 4000
		},
		{
			Price = 5000,
			Name = "Bacon",
			Hidden = true
		},
		{
			Name = "Frost",
			Price = 10000
		},
		{
			Price = 5000,
			Name = "Money",
			Hidden = true
		},
		{
			Price = 5000,
			Name = "Wavy",
			Hidden = true
		},
		{
			Name = "Galaxy",
			Price = 40000
		},
		{
			Price = 5000,
			Name = "Tiger",
			Hidden = true
		},
		{
			Name = "Field",
			Price = 20000,
			Hidden = true
		},
		{
			Name = "Scorch",
			Price = 40000
		},
		{
			Name = "Lines",
			Price = 35000
		},
		{
			Price = 5000,
			Name = "Hotdog",
			Hidden = true
		},
		{
			Name = "TwoSided",
			Price = 20000
		},
		{
			Name = "Volcano",
			Price = 39000
		},
		{
			Price = 5000,
			Name = "GlowingYellow",
			Hidden = true
		},
		{
			Name = "Frit",
			Price = 20000
		},
		{
			Price = 5000,
			Name = "OrangePixel",
			Hidden = true
		},
		{
			Name = "Ice",
			Price = 20000
		},
		{
			Name = "Police",
			Price = 2000
		},
		{
			Name = "Paint",
			Price = 10000
		},
		{
			Name = "Camo",
			Price = 50000
		},
		{
			Name = "Ladybug",
			Price = 10000,
			Hidden = true
		},
		{
			Name = "Diamond",
			Price = 40000
		},
		{
			Name = "Taxi",
			Price = 15000
		},
		{
			Price = 5000,
			Name = "BluePixel",
			Hidden = true
		},
		{
			Name = "Wireframe",
			Price = 45000
		},
		{
			Name = "Racer",
			Price = 10000
		},
		{
			Name = "Cow",
			Price = 4000
		},
		{
			Price = 5000,
			Name = "Earth",
			Hidden = true
		},
		{
			Price = 5000,
			Name = "Lightning",
			Hidden = true
		},
		{
			Name = "CandyCane",
			Price = 40000
		},
		{
			Name = "Donut",
			Price = 40000
		},
		{
			Name = "Swirl",
			Price = 20000
		},
		{
			Name = "Zebra",
			Price = 40000
		},
		{
			Name = "Peach",
			Price = 10000,
			Hidden = true
		},
		{
			Name = "ClassicVar3",
			Price = 10000,
			Hidden = true
		},
		{
			Name = "ClassicVar2",
			Price = 4000
		},
		{
			Name = "ClassicVar1",
			Price = 4000,
			Hidden = true
		},
		{
			Name = "Armor",
			Hidden = true,
			Tags = { "Code" }
		},
		{
			Name = "Speed",
			Hidden = true
		},
		{
			Price = 35000,
			Name = "Volt"
		},
		{
			Price = 1000,
			Name = "Pixel",
			Hidden = true,
			Tags = { "Beta" }
		},
		{
			Price = 1000,
			Name = "Checker",
			Hidden = true
		}
	},
	GetInstance = function(textureData)
		local vehiclePacket = VehicleUtils.GetLocalVehiclePacketForCustomize()
		local vehicleModel = getDefaultVehicleModel(vehiclePacket.Make, vehiclePacket.Type)
		local context = {
			Model = vehicleModel,
			Make = vehiclePacket.Make,
			Type = vehiclePacket.Type
		}
		if textureData.None then
			Texture(nil, context)
		else
			Texture(textureData, context)
		end
		return vehicleModel
	end,
	Update = function(model, extents)
		local elapsedTime = os.clock() / 2
		model.CFrame = CFrame.Angles(0, elapsedTime % 6.283185307179586, 0) * CFrame.Angles(math.sin(elapsedTime) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, extents:GetExtentsSize().Magnitude * 0.6)
	end,
	IsValidForMake = function(textureData)
		local vehicleMake = VehicleUtils.GetLocalVehiclePacket().Make
		if vehicleMake == "TinyToy" then
			vehicleMake = "Camaro"
		end
		return TextureData[textureData.Name] and TextureData[textureData.Name][vehicleMake] or (SpecialTextureData[textureData.Name] or textureData.Name == "None")
	end
}