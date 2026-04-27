local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local TradeReducerUtils = require(ReplicatedStorage.Trade.TradeReducerUtils)
local TradeUtils = require(ReplicatedStorage.Trade.TradeUtils)
game:GetService("Players")
local EnumSort = require(ReplicatedStorage.Garage.EnumSort)
return function(storybook)
	local TradeApp = Roact.Component:extend("App")
	local TradeInventory = require(script.Parent.TradeInventory)
	function TradeApp.init(state)
		local selectedSkin = TradeReducerUtils.buildItemProps({
			Id = "a4",
			ItemType = "ItemSkin",
			SkinName = "WhiteMarble"
		})
		selectedSkin.isOriginalOwner = true
		state.traderMeOfferItems = {
			TradeReducerUtils.buildItemProps({
				Id = "a1",
				ItemType = "VehicleCustomization",
				CategoryName = "Spoiler",
				ItemName = "Deathtrap"
			}),
			TradeReducerUtils.buildItemProps({
				Id = "a2",
				ItemType = "Vehicle",
				Make = "Chiron"
			}),
			TradeReducerUtils.buildItemProps({
				Id = "a3",
				ItemType = "Vehicle",
				Make = "Sloop"
			}),
			selectedSkin
		}
		state.categories = TradeUtils.getCategories()
		state.category = state.categories[1]
		state:setState({
			sortId = EnumSort.Newest
		})
	end
	local playersList = {}
	for i = 1, 10 do
		table.insert(playersList, {
			DisplayName = tostring(i)
		})
	end
	function TradeApp.render(state)
		return Roact.createElement(TradeInventory, {
			size = UDim2.new(0.75, 0, 0.75, 0),
			position = UDim2.new(0.1, 0, 0, 0),
			showChat = true,
			items = state.traderMeOfferItems,
			categories = state.categories,
			category = state.category,
			inventoryPlayers = {
				allPlayers = playersList,
				selectedPlayer = {
					DisplayName = "badcc"
				}
			},
			onCardFlipped = function()
				print("card flipped!")
			end,
			sortId = state.state.sortId,
			onSelectSort = function(selectedSortId)
				state:setState({
					sortId = if selectedSortId == EnumSort.Newest then EnumSort.Alphabetical else EnumSort.Newest
				})
			end
		})
	end
	function TradeApp.willUnmount(state)  end
	local mountedComponent = Roact.mount(Roact.createElement(TradeApp), storybook)
	return function()
		Roact.unmount(mountedComponent)
	end
end
