local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local createElement = Roact.createElement
local PortalBase = require(script.Parent.PortalBase)
local PortalCustomizeComponent = Roact.PureComponent:extend("PortalCustomize")
function PortalCustomizeComponent.render(self)
	local category = self.props.category
	local categoryTitle = nil
	for i, v in ipairs(self.props.categories) do
		if v.name == category then
			categoryTitle = v.title
			break
		end
	end
	local selectedItems = {}
	local itemMetadata = {}
	for i, v in ipairs(self.props.receipt) do
		selectedItems[v.category .. v.name] = true
	end
	for i = 1, #self.props.items do
		local isFavorited, isOwned, isEquipped
		local currentItem = self.props.items[i]
		local categoryName = currentItem.categoryName
		local itemCategoryTitle = nil
		for i2, v in ipairs(self.props.categories) do
			if v.name == categoryName then
				itemCategoryTitle = v.title
				break
			end
		end
		if not itemCategoryTitle then
			error("missing category title for " .. categoryName)
		end
		isFavorited = if self.props.favorited[categoryName] then self.props.favorited[categoryName][currentItem.name] == true else false
		isOwned = if self.props.owned[categoryName] then self.props.owned[categoryName][currentItem.name] == true else false
		local itemProperties = {
			selected = selectedItems[currentItem.categoryName .. currentItem.name]
		}
		isEquipped = currentItem.name == (self.props.equipped[categoryName] or "None")
		itemProperties.equipped = isEquipped
		itemProperties.owned = isOwned
		itemProperties.faved = isFavorited
		function itemProperties.onSelect()
			if self.props.attemptEquipItem then
				self.props.attemptEquipItem(categoryName, currentItem.name)
			end
			self.props.onSelectItem(categoryName, itemCategoryTitle, currentItem, itemProperties)
		end
		function itemProperties.onFavorite(favorited)
			if self.props.attemptFavoriteItem then
				self.props.attemptFavoriteItem(categoryName, currentItem.name, favorited)
			end
			self.props.onFavoriteItem(categoryName, currentItem.name, favorited)
		end
		itemMetadata[i] = itemProperties
	end
	return createElement(PortalBase, {
		title = categoryTitle,
		items = self.props.items,
		metadata = itemMetadata,
		cornerPixel = self.props.cornerPixel,
		portalRatio = self.props.portalRatio,
		paddingRatio = self.props.paddingRatio,
		sortEnabled = true,
		onSelectSort = self.props.onSelectSort,
		showFavorited = self.props.showFavorited,
		onToggleFavorited = self.props.onToggleFavorited,
		showAll = self.props.showAll,
		onToggleAll = self.props.onToggleAll,
		colsPerRow = self.props.colsPerRow,
		rowsPerPage = self.props.rowsPerPage
	})
end
return RoactRodux.connect(function(state, dispatch)
	return {
		category = state.garageCategory,
		categories = state.garageCategories,
		receipt = state.garageReceipt,
		favorited = state.garageFavorited
	}
end, function(dispatch)
	return {
		onSelectItem = function(category, categoryTitle, item, itemProperties)
			if Players.LocalPlayer and Players.LocalPlayer.PlayerGui then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
					Volume = 0.25
				})
			end
			if item.onItemSelected then
				item.onItemSelected()
			end
			dispatch({
				type = "addReceiptItem",
				category = category,
				categoryTitle = categoryTitle,
				name = item.name,
				title = item.title,
				price = item.price,
				limited = item.limited
			})
			if itemProperties.owned then
				dispatch({
					type = "setCategoryEquipped",
					category = category,
					name = item.name
				})
			end
		end,
		onFavoriteItem = function(category, itemName, favorited)
			dispatch({
				type = "setCategoryItemFavorited",
				category = category,
				name = itemName,
				favorited = favorited
			})
		end
	}
end)(PortalCustomizeComponent)
