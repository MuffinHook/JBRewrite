-- Reviewed by Claude
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
local v1 = Roact.PureComponent:extend("Trade")
v1.defaultProps = {
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
function v1.init(p1)
	p1.activeMaid = Maid.new()
	p1.categories = TradeUtils.getCategories()
	p1:setState({
		inventoryItems = p1:_getFilteredInventoryItems(),
		category = p1.categories[1]
	})
	function p1.onClickExitInventory()
		resetInventoryUserEditedValues()
		p1.props.setInventoryOpen(false)
	end
	function p1.promptInventory()
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
		p1.props.setInventoryOpen(true)
	end
	function p1.onClickInventoryItem(p12)
		if p1.props.tradeActive and p1.props.inventoryPlayers.selectedPlayer == Players.LocalPlayer then
			local v1 = p1.state.inventoryItems[p12]
			local v2 = false
			for i, v in ipairs(p1.props.traderMe.offerItems) do
				if v.id == v1.id then
					v2 = true
					break
				end
			end
			if v2 then
				p1.props.removeTraderMeOfferItem(v1)
			else
				p1.props.addTraderMeOfferItem(v1)
			end
			p1.props.setInventoryOpen(false)
			p1:_updateMyOffer()
			if Players.LocalPlayer.PlayerGui then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
					Volume = 0.15
				})
			end
		end
	end
	function p1.removeTraderMeOfferItemByIndex(p12)
		p1.props.removeTraderMeOfferItemByIndex(p12)
		p1:_updateMyOffer(false)
	end
	function p1.onClickCategory(p12)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.25
			})
		end
		p1:setState({
			category = p12
		})
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
	end
	function p1.onClickReady()
		p1.props.onClickReady()
		p1:_updateMyOffer(true)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
	end
	function p1.onClickUnready()
		p1.props.onClickUnready()
		p1:_updateMyOffer(false)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
	end
	function p1.onClickAccept()
		ReplicatedStorage:FindFirstChild(TradeConsts.ACCEPT_OFFERING_REMOTE_NAME):FireServer()
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
	end
	function p1.onClickDecline()
		ReplicatedStorage:FindFirstChild(TradeConsts.DECLINE_OFFERING_REMOTE_NAME):FireServer()
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
	end
	function p1.onClickExit()
		ReplicatedStorage:FindFirstChild(TradeConsts.EXIT_OFFERING_REMOTE_NAME):FireServer()
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
	end
	function p1.onCardFlipped()
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9846199217, {
				Volume = 0.15
			})
		end
	end
	function p1.onClickInventoryPlayer(p1)
		store:dispatch({
			type = "setInventoryPlayer",
			selectedPlayer = p1
		})
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
	end
end
function v1._updateMyOffer(p1, p2)
	if p2 == nil then
		p2 = p1.props.traderMe.ready
	end
	local v1 = p1:_getMeOfferIds()
	local v2 = ReplicatedStorage:FindFirstChild(TradeConsts.UPDATE_OFFERING_REMOTE_NAME)
	if v2 then
		v2:FireServer(p2, v1)
	end
end
function v1._getMeOfferIds(p1)
	return TableUtils.map(p1.props.traderMe.offerItems, function(p1)
		return assert(p1.id, "missing id itemProp")
	end)
end
function v1._getFilteredInventoryItems(p1)
	local tradeInventorySearchText = p1.props.tradeInventorySearchText
	local t = {}
	for i, v in ipairs(p1.props.tradeInventory) do
		if TableUtils.hasDesiredValuesShallow(v, p1.state.category.match) and (not tradeInventorySearchText or (tradeInventorySearchText == "" or string.find(v.title:lower(), tradeInventorySearchText:lower(), nil, true))) then
			table.insert(t, v)
		end
	end
	table.sort(t, SortUtils.getTradeSortFunc(p1.props.tradeSort))
	return t
end
function v1._getFilteredInventoryPlayers(p1)
	table.sort(p1.props.inventoryPlayers.allPlayers, function(p1, p2)
		if p1.UserId == Players.LocalPlayer.UserId then
			return true
		elseif p2.UserId == Players.LocalPlayer.UserId then
			return false
		else
			return p1.DisplayName < p2.DisplayName
		end
	end)
	if p1.props.tradeActive then
		local t = {
			allPlayers = {}
		}
		for v1, v2 in p1.props.inventoryPlayers.allPlayers do
			if v2.UserId == p1.props.traderThem.userId or v2.UserId == Players.LocalPlayer.UserId then
				table.insert(t.allPlayers, v2)
			end
		end
		t.selectedPlayer = p1.props.inventoryPlayers.selectedPlayer
		return t
	else
		return p1.props.inventoryPlayers
	end
end
function v1.render(p1)
	local t = {}
	for i, v in ipairs(p1.props.traderMe.offerItems) do
		t[v.id] = true
	end
	if p1.props.tradeInventoryOpen then
		local t2 = {}
		for i, v in ipairs(p1.state.inventoryItems) do
			local t3 = {}
			if t[v.id] then
				t3.selected = true
			end
			table.insert(t2, t3)
		end
		return createElement(TradeInventory, {
			size = p1.props.size,
			position = p1.props.position,
			anchorPoint = p1.props.anchorPoint,
			categories = p1.categories,
			category = p1.state.category,
			items = p1.state.inventoryItems,
			itemMetadata = t2,
			onClickExit = p1.onClickExitInventory,
			onClickItem = p1.onClickInventoryItem,
			onClickCategory = p1.onClickCategory,
			onCardFlipped = p1.onCardFlipped,
			onSelectSort = p1.props.onSelectSort,
			inventoryPlayers = p1:_getFilteredInventoryPlayers(),
			onClickInventoryPlayer = p1.onClickInventoryPlayer,
			sortId = p1.props.tradeSort,
			showChat = p1.props.tradeActive,
			tradeChatMessages = p1.props.tradeChatMessages
		})
	end
	if p1.props.tradeActive then
		local v1 = ""
		if p1.props.tradeInfo then
			if p1.props.tradeInfo.msg then
				v1 = p1.props.tradeInfo.msg
			elseif p1.props.tradeInfo.debugProbability then
				v1 = ("P(you better) [debug] = %.1f%%"):format(p1.props.tradeInfo.debugProbability * 100)
			end
		end
		return createElement(TradeOffering, {
			size = p1.props.size,
			position = p1.props.position,
			anchorPoint = p1.props.anchorPoint,
			traderMe = p1.props.traderMe,
			traderThem = p1.props.traderThem,
			promptInventory = p1.promptInventory,
			removeTraderMeOfferItem = p1.removeTraderMeOfferItemByIndex,
			onClickReady = p1.onClickReady,
			onClickUnready = p1.onClickUnready,
			onClickAccept = p1.onClickAccept,
			onClickDecline = p1.onClickDecline,
			onClickExit = p1.onClickExit,
			onCardFlipped = p1.onCardFlipped,
			infoMessage = v1,
			showChat = p1.props.tradeActive,
			tradeChatMessages = p1.props.tradeChatMessages
		})
	end
end
function v1.didUpdate(p1, p2, p3)
	if p1.state.category ~= p3.category or (p1.props.tradeInventory ~= p2.tradeInventory or (p1.props.tradeInventorySearchText ~= p2.tradeInventorySearchText or p1.props.tradeSort ~= p2.tradeSort)) then
		p1:setState({
			inventoryItems = p1:_getFilteredInventoryItems()
		})
	end
	if p1.props.tradeActive ~= p2.tradeActive then
		if not p1.props.tradeActive then
			p1.activeMaid:DoCleaning()
			p1:setState({
				category = p1.categories[1]
			})
			p1.props.setInventoryOpen(false)
			p1.props.resetTradeInfo()
		end
		if p1.props.tradeActive then
			p1.activeMaid:GiveTask(ActionButtonService.pushHide())
		end
	end
	if p1.props.tradeInventoryOpen and p1.props.tradeInventoryOpen ~= p2.tradeInventoryOpen then
		resetInventoryUserEditedValues()
	end
end
return RoactRodux.connect(function(p1, p2)
	return {
		traderMe = p1.traderMe,
		traderThem = p1.traderThem,
		tradeInventory = p1.tradeInventory,
		tradeInventorySearchText = p1.tradeInventorySearchText,
		tradeCategory = p1.tradeCategory,
		tradeActive = p1.tradeActive,
		tradeSort = p1.tradeSort,
		tradeInventoryOpen = p1.tradeInventoryOpen,
		tradeInfo = p1.tradeInfo,
		inventoryPlayers = p1.inventoryPlayers,
		tradeChatMessages = p1.tradeChatMessages
	}
end, function(p1)
	return {
		onClickReady = function(p12)
			p1({
				type = "updateTraderMe",
				ready = true
			})
		end,
		onClickUnready = function()
			p1({
				type = "updateTraderMe",
				ready = false
			})
		end,
		addTraderMeOfferItem = function(p12)
			p1({
				type = "addTraderMeOfferItem",
				item = p12
			})
		end,
		removeTraderMeOfferItem = function(p12)
			p1({
				type = "removeTraderMeOfferItem",
				item = p12
			})
		end,
		removeTraderMeOfferItemByIndex = function(p12)
			p1({
				type = "removeTraderMeOfferItemByIndex",
				index = p12
			})
		end,
		onSelectSort = function(p12)
			if Players.LocalPlayer.PlayerGui then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
					Volume = 0.15
				})
			end
			local v1 = nil
			if p12 == EnumSort.Newest then
				v1 = EnumSort.Popular
			elseif p12 == EnumSort.Popular then
				v1 = EnumSort.Alphabetical
			elseif p12 == EnumSort.Alphabetical then
				v1 = EnumSort.Newest
			end
			p1({
				type = "setTradeSortId",
				sortId = v1
			})
		end,
		setInventoryOpen = function(p12)
			p1({
				type = "setTradeInventoryOpen",
				value = p12
			})
		end,
		resetTradeInfo = function()
			p1({
				type = "setTradeInfo",
				info = nil
			})
		end
	}
end)(v1)
