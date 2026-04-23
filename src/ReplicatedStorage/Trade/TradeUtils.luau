local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local OwnershipConsts = require(ReplicatedStorage.Ownership.OwnershipConsts)
local Players = game:GetService("Players")
local TradeConsts = require(ReplicatedStorage.Trade.TradeConsts)
local TradeTranslationUtils = require(script.Parent.TradeTranslationUtils)
return {
	setPlayerTradeRequestsEnabled = function(p1, p2) --[[ Name: setPlayerTradeRequestsEnabled | Line: 9 | Upvalues: Players (copy), TradeConsts (copy) ]]
		assert(p1.Parent == Players, "Incorrect player passed")
		assert(typeof(p2) == "boolean", "Incorrect value passed")
		p1:SetAttribute(TradeConsts.ARE_TRADE_REQUESTS_ENABLED_ATTR_NAME, p2)
		return true
	end,
	getPlayerTradeRequestsEnabled = function(p1) --[[ Name: getPlayerTradeRequestsEnabled | Line: 15 | Upvalues: Players (copy), TradeConsts (copy) ]]
		assert(p1.Parent == Players, "Incorrect player passed")
		return p1:GetAttribute(TradeConsts.ARE_TRADE_REQUESTS_ENABLED_ATTR_NAME)
	end,
	getCategories = function() --[[ Name: getCategories | Line: 19 | Upvalues: PlayerDataConsts (copy), OwnershipConsts (copy), TradeConsts (copy), TradeTranslationUtils (copy) ]]
		local t = {}
		for k in pairs(PlayerDataConsts.ITEM_TYPE_SET) do
			local count = (1 / 0)
			if k == PlayerDataConsts.VEHICLE_ITEM_TYPE then
				count = 100
			elseif k == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then
				count = 200
			elseif k == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE then
				count = 300
			elseif k == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
				count = 400
			end
			if k == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then
				for i, v in ipairs(OwnershipConsts.VEHICLE_CUSTOMIZATION_CATEGORY_NAMES) do
					if not TradeConsts.MAP_CATEGORY_IGNORE[v] then
						table.insert(t, {
							categoryName = v,
							categoryTitle = TradeTranslationUtils.getCategoryTitle(v),
							match = {
								itemType = k,
								categoryName = v
							},
							sortOrder = count
						})
						count = count + 1
					end
				end
			elseif not TradeConsts.MAP_CATEGORY_IGNORE[k] then
				table.insert(t, {
					categoryName = k,
					categoryTitle = TradeTranslationUtils.getCategoryTitle(k),
					match = {
						itemType = k
					},
					sortOrder = count
				})
			end
		end
		table.sort(t, function(p1, p2) --[[ Line: 67 ]]
			return p1.sortOrder < p2.sortOrder
		end)
		return t
	end
}