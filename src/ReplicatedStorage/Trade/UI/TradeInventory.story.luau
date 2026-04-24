-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local TradeReducerUtils = require(ReplicatedStorage.Trade.TradeReducerUtils)
local TradeUtils = require(ReplicatedStorage.Trade.TradeUtils)
game:GetService("Players")
local EnumSort = require(ReplicatedStorage.Garage.EnumSort)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local TradeInventory = require(script.Parent.TradeInventory)
	function v1.init(p1)
		local v1 = TradeReducerUtils.buildItemProps({
			Id = "a4",
			ItemType = "ItemSkin",
			SkinName = "WhiteMarble"
		})
		v1.isOriginalOwner = true
		p1.traderMeOfferItems = {
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
			v1
		}
		p1.categories = TradeUtils.getCategories()
		p1.category = p1.categories[1]
		p1:setState({
			sortId = EnumSort.Newest
		})
	end
	local t = {}
	for i = 1, 10 do
		table.insert(t, {
			DisplayName = tostring(i)
		})
	end
	function v1.render(p1)
		return Roact.createElement(TradeInventory, {
			size = UDim2.new(0.75, 0, 0.75, 0),
			position = UDim2.new(0.1, 0, 0, 0),
			showChat = true,
			items = p1.traderMeOfferItems,
			categories = p1.categories,
			category = p1.category,
			inventoryPlayers = {
				allPlayers = t,
				selectedPlayer = {
					DisplayName = "badcc"
				}
			},
			onCardFlipped = function()
				print("card flipped!")
			end,
			sortId = p1.state.sortId,
			onSelectSort = function(p12)
				p1:setState({
					sortId = if p12 == EnumSort.Newest then EnumSort.Alphabetical else EnumSort.Newest
				})
			end
		})
	end
	function v1.willUnmount(p1)  end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end
