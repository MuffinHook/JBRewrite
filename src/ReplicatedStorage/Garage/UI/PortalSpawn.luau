local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local createElement = Roact.createElement
local PortalBase = require(script.Parent.PortalBase)
local GarageConsts = require(script.Parent.Parent.GarageConsts)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local PortalSpawnComponent = Roact.PureComponent:extend("PortalSpawn")
function PortalSpawnComponent.render(props)
	local receiptItems = {}
	local vehicleMetadata = {}
	for i, receiptItem in ipairs(props.props.receipt) do
		receiptItems[receiptItem.name] = true
	end
	local ownedVehicles = {}
	local Vehicles = props.props.owned.Vehicles
	if Vehicles then
		for k, isOwned in pairs(Vehicles) do
			if isOwned == true then
				ownedVehicles[k] = true
			end
		end
	end
	local favoritedVehicles = {}
	local favoritedVehiclesTable = props.props.favorited.Vehicles
	if favoritedVehiclesTable then
		for k, isFavorited in pairs(favoritedVehiclesTable) do
			if isFavorited == true then
				favoritedVehicles[k] = true
			end
		end
	end
	for i = 1, #props.props.items do
		local isUnlocked, isAvailable
		local currentVehicle = props.props.items[i]
		local isOwned = ownedVehicles[currentVehicle.name] or false
		isUnlocked = isOwned or (not currentVehicle.price or currentVehicle.price == 0)
		local premium = props.props.premium
		if not premium then
			premium = props.props.inPhysical
			if not premium then
				premium = currentVehicle.lite
				if not premium then
					premium = Players.LocalPlayer
					if premium then
						premium = Players.LocalPlayer:GetAttribute(GarageConsts.AERIAL_SPAWN_ATTR_NAME) == true
					end
				end
			end
		end
		local isAccessible = premium
		if not isAccessible then
			isAccessible = props.props.gamepassOwned[GamepassUtils.EnumGamepass.BOSS]
			if isAccessible then
				isAccessible = currentVehicle.name == "Wraith"
			end
		end
		if not isAccessible then
			isAccessible = props.props.gamepassOwned[GamepassUtils.EnumGamepass.SWAT]
			if isAccessible then
				isAccessible = currentVehicle.name == "SWATVan"
			end
		end
		local vehicleEntry = {
			selected = receiptItems[currentVehicle.name],
			owned = isOwned,
			faved = favoritedVehicles[currentVehicle.name] or false
		}
		isAvailable = isOwned or isUnlocked and currentVehicle.available
		vehicleEntry.masked = not isAvailable
		vehicleEntry.locked = not isAccessible
		function vehicleEntry.onSelect()
			if vehicleEntry.masked then
				props.props.onAttemptPurchaseVehicle(currentVehicle, vehicleEntry)
			else
				props.props.onClickSpawnVehicle(currentVehicle)
			end
		end
		function vehicleEntry.onFavorite(category)
			if props.props.attemptFavoriteItem then
				props.props.attemptFavoriteItem("Vehicles", currentVehicle.name, category)
			end
			props.props.onFavoriteItem("Vehicles", currentVehicle.name, category)
		end
		vehicleMetadata[i] = vehicleEntry
	end
	return createElement(PortalBase, {
		title = "SPAWN",
		items = props.props.items,
		metadata = vehicleMetadata,
		sortId = props.props.sortId,
		cornerPixel = props.props.cornerPixel,
		portalRatio = props.props.portalRatio,
		paddingRatio = props.props.paddingRatio,
		onSelectSort = props.props.onSelectSort,
		sortEnabled = true,
		showFavorited = props.props.showFavorited,
		onToggleFavorited = props.props.onToggleFavorited,
		showAll = props.props.showAll,
		onToggleAll = props.props.onToggleAll,
		colsPerRow = props.props.colsPerRow,
		rowsPerPage = props.props.rowsPerPage
	})
end
return RoactRodux.connect(function(state, dispatch)
	return {
		receipt = state.garageReceipt,
		inPhysical = state.garageInPhysical,
		favorited = state.garageFavorited,
		gamepassOwned = state.gamepassOwned,
		premium = state.garagePremium
	}
end, function(dispatch)
	return {
		onFavoriteItem = function(category, itemName, isFavorited)
			dispatch({
				type = "setCategoryItemFavorited",
				category = category,
				name = itemName,
				favorited = isFavorited
			})
		end
	}
end)(PortalSpawnComponent)
