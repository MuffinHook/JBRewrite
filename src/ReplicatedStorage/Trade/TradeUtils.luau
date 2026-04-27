local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local OwnershipConsts = require(ReplicatedStorage.Ownership.OwnershipConsts)
local Players = game:GetService("Players")
local TradeConsts = require(ReplicatedStorage.Trade.TradeConsts)
local TradeTranslationUtils = require(script.Parent.TradeTranslationUtils)
return {
	setPlayerTradeRequestsEnabled = function(player, enabled)
		assert(player.Parent == Players, "Incorrect player passed")
		assert(typeof(enabled) == "boolean", "Incorrect value passed")
		player:SetAttribute(TradeConsts.ARE_TRADE_REQUESTS_ENABLED_ATTR_NAME, enabled)
		return true
	end,
	getPlayerTradeRequestsEnabled = function(player)
		assert(player.Parent == Players, "Incorrect player passed")
		return player:GetAttribute(TradeConsts.ARE_TRADE_REQUESTS_ENABLED_ATTR_NAME)
	end,
	getCategories = function()
		local categoriesList = {}
		for itemType in pairs(PlayerDataConsts.ITEM_TYPE_SET) do
			local count = (1 / 0)
			if itemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then
				count = 100
			elseif itemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then
				count = 200
			elseif itemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE then
				count = 300
			elseif itemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
				count = 400
			end
			if itemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
				for i, categoryName in ipairs(OwnershipConsts.VEHICLE_CUSTOMIZATION_CATEGORY_NAMES) do
					if not TradeConsts.MAP_CATEGORY_IGNORE[categoryName] then
						table.insert(categoriesList, {
							categoryName = categoryName,
							categoryTitle = TradeTranslationUtils.getCategoryTitle(categoryName),
							match = {
								itemType = itemType,
								categoryName = categoryName
							},
							sortOrder = count
						})
						count = count + 1
					end
				end
			elseif not TradeConsts.MAP_CATEGORY_IGNORE[itemType] then
				table.insert(categoriesList, {
					categoryName = itemType,
					categoryTitle = TradeTranslationUtils.getCategoryTitle(itemType),
					match = {
						itemType = itemType
					},
					sortOrder = count
				})
			end
		end
		table.sort(categoriesList, function(categoryA, categoryB)
			return categoryA.sortOrder < categoryB.sortOrder
		end)
		return categoriesList
	end
}
