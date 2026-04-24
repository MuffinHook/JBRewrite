-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local createElement = Roact.createElement
local PortalBase = require(script.Parent.PortalBase)
local v1 = Roact.PureComponent:extend("PortalCustomize")
function v1.render(p1)
	local category = p1.props.category
	local v1 = nil
	for i, v in ipairs(p1.props.categories) do
		if v.name == category then
			v1 = v.title
			break
		end
	end
	local t = {}
	local t2 = {}
	for i, v in ipairs(p1.props.receipt) do
		t[v.category .. v.name] = true
	end
	for i = 1, #p1.props.items do
		local v2, v3, v4
		local v5 = p1.props.items[i]
		local categoryName = v5.categoryName
		local v6 = nil
		for i2, v in ipairs(p1.props.categories) do
			if v.name == categoryName then
				v6 = v.title
				break
			end
		end
		if not v6 then
			error("missing category title for " .. categoryName)
		end
		v2 = if p1.props.favorited[categoryName] then p1.props.favorited[categoryName][v5.name] == true else false
		v3 = if p1.props.owned[categoryName] then p1.props.owned[categoryName][v5.name] == true else false
		local t3 = {
			selected = t[v5.categoryName .. v5.name]
		}
		v4 = v5.name == (p1.props.equipped[categoryName] or "None")
		t3.equipped = v4
		t3.owned = v3
		t3.faved = v2
		function t3.onSelect()
			if p1.props.attemptEquipItem then
				p1.props.attemptEquipItem(categoryName, v5.name)
			end
			p1.props.onSelectItem(categoryName, v6, v5, t3)
		end
		function t3.onFavorite(p12)
			if p1.props.attemptFavoriteItem then
				p1.props.attemptFavoriteItem(categoryName, v5.name, p12)
			end
			p1.props.onFavoriteItem(categoryName, v5.name, p12)
		end
		t2[i] = t3
	end
	return createElement(PortalBase, {
		title = v1,
		items = p1.props.items,
		metadata = t2,
		cornerPixel = p1.props.cornerPixel,
		portalRatio = p1.props.portalRatio,
		paddingRatio = p1.props.paddingRatio,
		sortEnabled = true,
		onSelectSort = p1.props.onSelectSort,
		showFavorited = p1.props.showFavorited,
		onToggleFavorited = p1.props.onToggleFavorited,
		showAll = p1.props.showAll,
		onToggleAll = p1.props.onToggleAll,
		colsPerRow = p1.props.colsPerRow,
		rowsPerPage = p1.props.rowsPerPage
	})
end
return RoactRodux.connect(function(p1, p2)
	return {
		category = p1.garageCategory,
		categories = p1.garageCategories,
		receipt = p1.garageReceipt,
		favorited = p1.garageFavorited
	}
end, function(p1)
	return {
		onSelectItem = function(p12, p2, p3, p4)
			if Players.LocalPlayer and Players.LocalPlayer.PlayerGui then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
					Volume = 0.25
				})
			end
			if p3.onItemSelected then
				p3.onItemSelected()
			end
			p1({
				type = "addReceiptItem",
				category = p12,
				categoryTitle = p2,
				name = p3.name,
				title = p3.title,
				price = p3.price,
				limited = p3.limited
			})
			if p4.owned then
				p1({
					type = "setCategoryEquipped",
					category = p12,
					name = p3.name
				})
			end
		end,
		onFavoriteItem = function(p12, p2, p3)
			p1({
				type = "setCategoryItemFavorited",
				category = p12,
				name = p2,
				favorited = p3
			})
		end
	}
end)(v1)
