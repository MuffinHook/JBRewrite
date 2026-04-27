local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local Maid = require(ReplicatedStorage.Std.Maid)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local createElement = Roact.createElement
local TradeUtils = require(ReplicatedStorage.Trade.TradeUtils)
local TradeConsts = require(ReplicatedStorage.Trade.TradeConsts)
local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
local SortUtils = require(ReplicatedStorage.Garage.SortUtils)
local EnumSort = require(ReplicatedStorage.Garage.EnumSort)
local TradeInventory = require(script.Parent.TradeInventory)
local TradeOffering = require(script.Parent.TradeOffering)
local store = require(ReplicatedStorage.App.store)
local function playTick()
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
			Volume = 0.15
		})
	end
end
local TradeComponent = Roact.PureComponent:extend("Trade")
TradeComponent.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0.5, 0, 0.5, 0),
	anchorPoint = Vector2.new(0.5, 0.5)
}
local function resetInventoryUserEditedValues()
	store:dispatch({
		type = "setTradeInventorySearchText",
		value = ""
	})
	store:dispatch({
		type = "setInventoryPlayer",
		selectedPlayer = Players.LocalPlayer
	})
end
function TradeComponent.init(self)
	self.activeMaid = Maid.new()
	self.categories = TradeUtils.getCategories()
	self:setState({
		inventoryItems = self:_getFilteredInventoryItems(),
		category = self.categories[1]
	})
	function self.onClickExitInventory()
		resetInventoryUserEditedValues()
		self.props.setInventoryOpen(false)
	end
	function self.promptInventory()
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
		self.props.setInventoryOpen(true)
	end
	function self.onClickInventoryItem(itemIndex)
		if self.props.tradeActive and self.props.inventoryPlayers.selectedPlayer == Players.LocalPlayer then
			local selectedItem = self.state.inventoryItems[itemIndex]
			local isItemAlreadyOffered = false
			for i, item in ipairs(self.props.traderMe.offerItems) do
				if item.id == selectedItem.id then
					isItemAlreadyOffered = true
					break
				end
			end
			if isItemAlreadyOffered then
				self.props.removeTraderMeOfferItem(selectedItem)
			else
				self.props.addTraderMeOfferItem(selectedItem)
			end
			self.props.setInventoryOpen(false)
			self:_updateMyOffer()
			if Players.LocalPlayer.PlayerGui then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
					Volume = 0.15
				})
			end
		end
	end
	function self.removeTraderMeOfferItemByIndex(itemIndex)
		self.props.removeTraderMeOfferItemByIndex(itemIndex)
		self:_updateMyOffer(false)
	end
	function self.onClickCategory(selectedCategory)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.25
			})
		end
		self:setState({
			category = selectedCategory
		})
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
	end
	function self.onClickReady()
		self.props.onClickReady()
		self:_updateMyOffer(true)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
	end
	function self.onClickUnready()
		self.props.onClickUnready()
		self:_updateMyOffer(false)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
	end
	function self.onClickAccept()
		ReplicatedStorage:FindFirstChild(TradeConsts.ACCEPT_OFFERING_REMOTE_NAME):FireServer()
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
	end
	function self.onClickDecline()
		ReplicatedStorage:FindFirstChild(TradeConsts.DECLINE_OFFERING_REMOTE_NAME):FireServer()
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
	end
	function self.onClickExit()
		ReplicatedStorage:FindFirstChild(TradeConsts.EXIT_OFFERING_REMOTE_NAME):FireServer()
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
	end
	function self.onCardFlipped()
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9846199217, {
				Volume = 0.15
			})
		end
	end
	function self.onClickInventoryPlayer(selectedPlayer)
		store:dispatch({
			type = "setInventoryPlayer",
			selectedPlayer = selectedPlayer
		})
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
	end
end
function TradeComponent._updateMyOffer(self, isReady)
	if isReady == nil then
		isReady = self.props.traderMe.ready
	end
	local offerIds = self:_getMeOfferIds()
	local updateOfferingRemote = ReplicatedStorage:FindFirstChild(TradeConsts.UPDATE_OFFERING_REMOTE_NAME)
	if updateOfferingRemote then
		updateOfferingRemote:FireServer(isReady, offerIds)
	end
end
function TradeComponent._getMeOfferIds(self)
	return TableUtils.map(self.props.traderMe.offerItems, function(itemId)
		return assert(itemId.id, "missing id itemProp")
	end)
end
function TradeComponent._getFilteredInventoryItems(self)
	local tradeInventorySearchText = self.props.tradeInventorySearchText
	local filteredItems = {}
	for i, item in ipairs(self.props.tradeInventory) do
		if TableUtils.hasDesiredValuesShallow(item, self.state.category.match) and (not tradeInventorySearchText or (tradeInventorySearchText == "" or string.find(item.title:lower(), tradeInventorySearchText:lower(), nil, true))) then
			table.insert(filteredItems, item)
		end
	end
	table.sort(filteredItems, SortUtils.getTradeSortFunc(self.props.tradeSort))
	return filteredItems
end
function TradeComponent._getFilteredInventoryPlayers(self)
	table.sort(self.props.inventoryPlayers.allPlayers, function(player, otherPlayer)
		if player.UserId == Players.LocalPlayer.UserId then
			return true
		elseif otherPlayer.UserId == Players.LocalPlayer.UserId then
			return false
		else
			return player.DisplayName < otherPlayer.DisplayName
		end
	end)
	if self.props.tradeActive then
		local filteredPlayers = {
			allPlayers = {}
		}
		for index, inventoryPlayer in self.props.inventoryPlayers.allPlayers do
			if inventoryPlayer.UserId == self.props.traderThem.userId or inventoryPlayer.UserId == Players.LocalPlayer.UserId then
				table.insert(filteredPlayers.allPlayers, inventoryPlayer)
			end
		end
		filteredPlayers.selectedPlayer = self.props.inventoryPlayers.selectedPlayer
		return filteredPlayers
	else
		return self.props.inventoryPlayers
	end
end
function TradeComponent.render(self)
	local offeredItemIds = {}
	for i, item in ipairs(self.props.traderMe.offerItems) do
		offeredItemIds[item.id] = true
	end
	if self.props.tradeInventoryOpen then
		local itemMetadataList = {}
		for i, item in ipairs(self.state.inventoryItems) do
			local itemMetadata = {}
			if offeredItemIds[item.id] then
				itemMetadata.selected = true
			end
			table.insert(itemMetadataList, itemMetadata)
		end
		return createElement(TradeInventory, {
			size = self.props.size,
			position = self.props.position,
			anchorPoint = self.props.anchorPoint,
			categories = self.categories,
			category = self.state.category,
			items = self.state.inventoryItems,
			itemMetadata = itemMetadataList,
			onClickExit = self.onClickExitInventory,
			onClickItem = self.onClickInventoryItem,
			onClickCategory = self.onClickCategory,
			onCardFlipped = self.onCardFlipped,
			onSelectSort = self.props.onSelectSort,
			inventoryPlayers = self:_getFilteredInventoryPlayers(),
			onClickInventoryPlayer = self.onClickInventoryPlayer,
			sortId = self.props.tradeSort,
			showChat = self.props.tradeActive,
			tradeChatMessages = self.props.tradeChatMessages
		})
	end
	if self.props.tradeActive then
		local infoMessage = ""
		if self.props.tradeInfo then
			if self.props.tradeInfo.msg then
				infoMessage = self.props.tradeInfo.msg
			elseif self.props.tradeInfo.debugProbability then
				infoMessage = ("P(you better) [debug] = %.1f%%"):format(self.props.tradeInfo.debugProbability * 100)
			end
		end
		return createElement(TradeOffering, {
			size = self.props.size,
			position = self.props.position,
			anchorPoint = self.props.anchorPoint,
			traderMe = self.props.traderMe,
			traderThem = self.props.traderThem,
			promptInventory = self.promptInventory,
			removeTraderMeOfferItem = self.removeTraderMeOfferItemByIndex,
			onClickReady = self.onClickReady,
			onClickUnready = self.onClickUnready,
			onClickAccept = self.onClickAccept,
			onClickDecline = self.onClickDecline,
			onClickExit = self.onClickExit,
			onCardFlipped = self.onCardFlipped,
			infoMessage = infoMessage,
			showChat = self.props.tradeActive,
			tradeChatMessages = self.props.tradeChatMessages
		})
	end
end
function TradeComponent.didUpdate(self, previousProps, previousState)
	if self.state.category ~= previousState.category or (self.props.tradeInventory ~= previousProps.tradeInventory or (self.props.tradeInventorySearchText ~= previousProps.tradeInventorySearchText or self.props.tradeSort ~= previousProps.tradeSort)) then
		self:setState({
			inventoryItems = self:_getFilteredInventoryItems()
		})
	end
	if self.props.tradeActive ~= previousProps.tradeActive then
		if not self.props.tradeActive then
			self.activeMaid:DoCleaning()
			self:setState({
				category = self.categories[1]
			})
			self.props.setInventoryOpen(false)
			self.props.resetTradeInfo()
		end
		if self.props.tradeActive then
			self.activeMaid:GiveTask(ActionButtonService.pushHide())
		end
	end
	if self.props.tradeInventoryOpen and self.props.tradeInventoryOpen ~= previousProps.tradeInventoryOpen then
		resetInventoryUserEditedValues()
	end
end
return RoactRodux.connect(function(state, dispatch)
	return {
		traderMe = state.traderMe,
		traderThem = state.traderThem,
		tradeInventory = state.tradeInventory,
		tradeInventorySearchText = state.tradeInventorySearchText,
		tradeCategory = state.tradeCategory,
		tradeActive = state.tradeActive,
		tradeSort = state.tradeSort,
		tradeInventoryOpen = state.tradeInventoryOpen,
		tradeInfo = state.tradeInfo,
		inventoryPlayers = state.inventoryPlayers,
		tradeChatMessages = state.tradeChatMessages
	}
end, function(dispatch)
	return {
		onClickReady = function(sortId)
			dispatch({
				type = "updateTraderMe",
				ready = true
			})
		end,
		onClickUnready = function()
			dispatch({
				type = "updateTraderMe",
				ready = false
			})
		end,
		addTraderMeOfferItem = function(item)
			dispatch({
				type = "addTraderMeOfferItem",
				item = item
			})
		end,
		removeTraderMeOfferItem = function(item)
			dispatch({
				type = "removeTraderMeOfferItem",
				item = item
			})
		end,
		removeTraderMeOfferItemByIndex = function(itemIndex)
			dispatch({
				type = "removeTraderMeOfferItemByIndex",
				index = itemIndex
			})
		end,
		onSelectSort = function(sortId)
			if Players.LocalPlayer.PlayerGui then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
					Volume = 0.15
				})
			end
			local nextSortId = nil
			if sortId == EnumSort.Newest then
				nextSortId = EnumSort.Popular
			elseif sortId == EnumSort.Popular then
				nextSortId = EnumSort.Alphabetical
			elseif sortId == EnumSort.Alphabetical then
				nextSortId = EnumSort.Newest
			end
			dispatch({
				type = "setTradeSortId",
				sortId = nextSortId
			})
		end,
		setInventoryOpen = function(isOpen)
			dispatch({
				type = "setTradeInventoryOpen",
				value = isOpen
			})
		end,
		resetTradeInfo = function()
			dispatch({
				type = "setTradeInfo",
				info = nil
			})
		end
	}
end)(TradeComponent)
