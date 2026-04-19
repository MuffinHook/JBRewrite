local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EnvironmentConsts = require(ReplicatedStorage.Environment.EnvironmentConsts)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Enumer = require(ReplicatedStorage.Std.Enumer)
local RunUtils = require(ReplicatedStorage.App.RunUtils)

local Config = {}

--// ENUMS

Config.EnumTeam = Enumer({ "Prisoner", "Criminal", "Police" })

--// TEAM

local TeamMeta = {
	__index = function(self, key)
		local valid = {}
		for k in pairs(self) do
			table.insert(valid, k)
		end
		error(`Invalid team "{key}" [{table.concat(valid, ", ")}]`)
	end
}

Config.Team = setmetatable({
	Prisoner = "Prisoner",
	Police = "Police",
}, TeamMeta)

Config.TeamColor = {
	[Config.EnumTeam.Prisoner] = Color3.fromRGB(253, 123, 49),
	[Config.EnumTeam.Criminal] = Color3.fromRGB(252, 40, 47),
	[Config.EnumTeam.Police] = Color3.fromRGB(42, 204, 255),
}

--// TEST SETTINGS

Config.Test = {
	NoStudioDataLoading = true,
	NoStudioDataSaving = true,
	NoVehicleTeamRestrict = true,
	GiveGarageItems = true,
	PopulateTestHome = true,
	Cash = 1_000_000,
	EnterVehicleWithoutOwning = true,
}

--// PERMISSIONS

Config.Permissions = {
	Dev = {
		Group = 3059674,
		Rank = 100,
		Ids = {
			["319758610"] = true,
			["25881764"] = true,
		},
	},
}

--// CASH VALUES

Config.Cash = TableUtils.requireValidIndex({
	CorrectArrest = 400,
	SmallStoreRob = 750,
	MorningPolice = 1200,
})

--// VEHICLE DATA

local VehicleData = require(ReplicatedStorage.Game.Garage.VehicleData)

Config.VehiclePrices = {}
Config.VehicleLevels = {}

for _, vehicle in ipairs(VehicleData) do
	Config.VehiclePrices[vehicle.Make] = vehicle.Price

	if vehicle.Level then
		Config.VehicleLevels[vehicle.Make] = {
			Level = vehicle.Level,
			Team = Config.Team.Prisoner,
		}
	end
end

--// TIME SETTINGS

Config.Time = {
	Respawn = 4,
	RobberyCooldown = 300,
	TeamChangeCooldown = RunUtils.isStudio() and 1 or 24,
}

--// COLORS

Config.Colors = {
	Black = Color3.fromRGB(0, 0, 0),
	White = Color3.fromRGB(183, 184, 192),
	Red = Color3.fromRGB(150, 0, 2),
	Blue = Color3.fromRGB(9, 79, 172),
	Green = Color3.fromRGB(136, 190, 60),
}

--// TEXTURES

Config.Textures = {
	Blade = 739216272,
	Arachnid = 739216225,
	Spinner = 839445173,
	Money = 1077086727,
}

--// IMAGES

Config.Images = {
	Pistol = "rbxassetid://16647913398",
	Rifle = "rbxassetid://16647917663",
	Shotgun = "rbxassetid://16647919326",
	Sniper = "rbxassetid://16647920120",
}

--// SOUNDS

Config.Sounds = {
	Equip = 690572276,
	Horn = 9058828003,
	Punch = 690530166,
}

--// DEV PRODUCTS

Config.DevProducts = {
	{
		Id = 1894552543,
		Type = "Cash",
		Amount = 10000,
	},
	{
		Id = 980194938,
		Type = "Nuke",
	},
}

--// UTIL

function Config.getFirstProductByType(productType)
	assert(productType, "Missing product type")

	for _, product in ipairs(Config.DevProducts) do
		if product.Type == productType then
			return product
		end
	end
end

--// MARKETPLACE FETCH (CLEANED)

local MarketplaceService = game:GetService("MarketplaceService")
Config.OnProductsFetched = require(ReplicatedStorage.Std.Signal).new()

function Config.FetchProducts()
	task.spawn(function()
		local pending = 0

		for _, product in ipairs(Config.DevProducts) do
			pending += 1

			task.spawn(function()
				local info = MarketplaceService:GetProductInfo(product.Id, Enum.InfoType.Product)
				product.Price = info.PriceInRobux
				product.ImageId = info.IconImageAssetId
				pending -= 1
			end)
		end

		while pending > 0 do
			task.wait()
		end

		Config.OnProductsFetched:Fire()
	end)
end

return Config