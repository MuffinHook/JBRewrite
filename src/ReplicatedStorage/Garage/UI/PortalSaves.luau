local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local createElement = Roact.createElement
local PortalBase = require(script.Parent.PortalBase)
local PortalSavesComponent = Roact.PureComponent:extend("PortalSaves")
function PortalSavesComponent.render(self)
	local receiptLookup = {}
	local itemMetadata = {}
	for i, receiptItem in ipairs(self.props.receipt) do
		receiptLookup[receiptItem.name] = true
	end
	for i = 1, #self.props.items do
		local isFilled, getInstFunction
		local currentItem = self.props.items[i]
		local saveData = self.props.saves[currentItem.name]
		local itemEntry = {
			selected = receiptLookup[currentItem.name]
		}
		isFilled = saveData ~= nil
		itemEntry.filled = isFilled
		itemEntry.getInstCompare = saveData
		getInstFunction = saveData and function()
			return currentItem.getInstForSelection(saveData)
		end
		itemEntry.getInst = getInstFunction
		function itemEntry.onSelect()
			if currentItem.available then
				self.props.onSelectItem(currentItem)
			end
		end
		itemMetadata[i] = itemEntry
	end
	return createElement(PortalBase, {
		title = "SAVES",
		items = self.props.items,
		metadata = itemMetadata,
		sortId = self.props.sortId,
		colsPerRow = 5,
		rowsPerPage = 2,
		cornerPixel = self.props.cornerPixel,
		portalRatio = self.props.portalRatio,
		paddingRatio = self.props.paddingRatio,
		onSelectSort = self.props.onSelectSort
	})
end
return RoactRodux.connect(function(state, dispatch)
	return {
		receipt = state.garageReceipt
	}
end, function(dispatch)
	return {
		onSelectItem = function(selectedItem)
			if Players.LocalPlayer.PlayerGui then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
					Volume = 0.25
				})
			end
			dispatch({
				type = "addReceiptItem",
				category = "Saves",
				categoryTitle = "Save",
				name = selectedItem.name,
				title = selectedItem.title,
				filled = selectedItem.filled
			})
		end
	}
end)(PortalSavesComponent)
