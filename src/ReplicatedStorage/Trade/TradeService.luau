local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TradePopularSortData = require(script.Parent.TradePopularSortData)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local Audio = require(ReplicatedStorage.Std.Audio)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local TradeConsts = require(ReplicatedStorage.Trade.TradeConsts)
local EnumSort = require(ReplicatedStorage.Garage.EnumSort)
local GameSettingsService = require(ReplicatedStorage.GameSettings.GameSettingsService)
local gameSettingType = require(ReplicatedStorage.GameSettings.gameSettingType)
local store = require(ReplicatedStorage.App.store)
local ChatService = require(ReplicatedStorage.Chat.ChatService)
require(ReplicatedStorage.Std.Debug.table2Lua)
local function playReadyDing()
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9856727426, {
			Volume = 0.2
		})
	end
end
local tradeService = {
	_tradingWithUserId = nil
}
local eventManager = nil
function tradeService.init(config)
	eventManager = config.em
	if RunUtils.isTradingEnabled() then
		store.changed:connect(function(newState, oldState)
			tradeService._tradingWithUserId = newState.traderThem.userId
			if newState.traderThem.userId ~= oldState.traderThem.userId then
				store:dispatch({
					type = "clearTradeChatMessages"
				})
			end
			local newOfferingMap = {}
			for currentIndex, currentItem in newState.traderThem.offerItems do
				newOfferingMap[currentItem.id] = true
			end
			for previousIndex, previousItem in oldState.traderThem.offerItems do
				if not newOfferingMap[previousItem.id] then
					store:dispatch({
						type = "addTradeChatMessage",
						displayName = "SERVER",
						text = previousItem.title .. " removed from trade!",
						me = false,
						color = Color3.new(255/255, 0/255, 0/255)
					})
				end
			end
		end)
		waitForChild(ReplicatedStorage, TradeConsts.ARE_TRADE_REQUESTS_ENABLED_REMOTE_NAME):andThen(function(tradeRequestsRemote)
			local settingConfig = {
				name = "areTradeRequestsEnabled",
				title = "Allow Trade Requests",
				type = gameSettingType.Checkbox,
				defaultValue = true,
				order = 41
			}
			GameSettingsService.add(settingConfig)
			local function handleTradeRequestsEnabled(isEnabled)
				tradeRequestsRemote:FireServer(isEnabled)
			end
			tradeRequestsRemote:FireServer((settingConfig:getValue()))
			settingConfig.onChanged:Connect(handleTradeRequestsEnabled)
		end)
		ChatService.onMessageIncoming:Connect(function(message, formattedMessage)
			if message.Status == Enum.TextChatMessageStatus.Success and message.TextSource then
				local Text = formattedMessage.Text
				local UserId = message.TextSource.UserId
				local player = Players:GetPlayerByUserId(UserId)
				if player and message.TextChannel.Name == "RBXGeneral" then
					local tradingUserId = tradeService.getTradingWithUserId()
					if tradingUserId then
						local isLocalPlayer = player == Players.LocalPlayer
						if isLocalPlayer or UserId == tradingUserId then
							store:dispatch({
								type = "addTradeChatMessage",
								displayName = player.DisplayName,
								text = Text,
								me = isLocalPlayer
							})
						end
					end
				end
			end
		end)
		waitForChild(ReplicatedStorage, TradeConsts.UPDATE_OWNED_REMOTE_NAME):andThen(function(updateOwnedRemote)
			updateOwnedRemote.OnClientEvent:Connect(function(itemsOwned)
				store:dispatch({
					type = "tradeInventorySetItemsOwned",
					itemsOwned = itemsOwned,
					sortId = EnumSort.Newest
				})
			end)
		end)
		waitForChild(ReplicatedStorage, TradeConsts.UPDATE_OFFERING_REMOTE_NAME):andThen(function(updateOfferingRemote)
			updateOfferingRemote.OnClientEvent:Connect(function(isMeOffering, itemsOffering)
				if isMeOffering then
					store:dispatch({
						type = "updateTraderMe",
						itemsOwnedOffering = itemsOffering
					})
				else
					store:dispatch({
						type = "updateTraderThem",
						itemsOwnedOffering = itemsOffering
					})
				end
			end)
		end)
		waitForChild(Players.LocalPlayer, TradeConsts.ACTIVE_TRADE_OBJ_NAME):andThen(function(activeTrade)
			RxInstanceUtils.observeAttribute(activeTrade, TradeConsts.IS_READY_ATTR_NAME, function(readyStatus)
				store:dispatch({
					type = "updateTraderMe",
					ready = readyStatus
				})
				if readyStatus and Players.LocalPlayer.PlayerGui then
					Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9856727426, {
						Volume = 0.2
					})
				end
			end)
			RxInstanceUtils.observeAttribute(activeTrade, TradeConsts.IS_ACCEPTED_ATTR_NAME, function(acceptedStatus)
				store:dispatch({
					type = "updateTraderMe",
					accepted = acceptedStatus
				})
				if acceptedStatus and Players.LocalPlayer.PlayerGui then
					Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9856727426, {
						Volume = 0.2
					})
				end
			end)
			activeTrade.Changed:Connect(function(parent)
				if parent then
					store:dispatch({
						type = "updateTraderMe",
						userId = Players.LocalPlayer.UserId,
						displayName = Players.LocalPlayer.DisplayName
					})
				else
					store:dispatch({
						type = "updateTraderMe",
						reset = true
					})
				end
				store:dispatch({
					type = "setTradeActive",
					value = parent
				})
			end)
			RxInstanceUtils.observeAttribute(activeTrade, TradeConsts.WITH_USER_ID_ATTR_NAME, function(traderUserId, maid)
				if traderUserId then
					local traderPlayer = Players:GetPlayerByUserId(traderUserId)
					if traderPlayer then
						local activeTrade = traderPlayer:FindFirstChild(TradeConsts.ACTIVE_TRADE_OBJ_NAME)
						if activeTrade then
							maid:GiveTask(RxInstanceUtils.observeAttribute(activeTrade, TradeConsts.IS_READY_ATTR_NAME, function(readyStatus)
								store:dispatch({
									type = "updateTraderThem",
									ready = readyStatus
								})
								if readyStatus and Players.LocalPlayer.PlayerGui then
									Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9856727426, {
										Volume = 0.2
									})
								end
							end))
							maid:GiveTask(RxInstanceUtils.observeAttribute(activeTrade, TradeConsts.IS_ACCEPTED_ATTR_NAME, function(acceptedStatus)
								store:dispatch({
									type = "updateTraderThem",
									accepted = acceptedStatus
								})
								if acceptedStatus and Players.LocalPlayer.PlayerGui then
									Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9856727426, {
										Volume = 0.2
									})
								end
							end))
						end
						store:dispatch({
							type = "updateTraderThem",
							userId = traderUserId,
							displayName = traderPlayer.DisplayName
						})
					end
				end
				maid:GiveTask(function()
					store:dispatch({
						type = "updateTraderThem",
						reset = true
					})
				end)
			end)
		end)
		waitForChild(Players.LocalPlayer, TradeConsts.INITIATIONS_FOLDER_NAME):andThen(function(initiationsFolder)
			local function updateInitiations()
				local initiationsList = {}
				for index, initiationChild in ipairs(initiationsFolder:GetChildren()) do
					local userId = tonumber(initiationChild.Name)
					if userId then
						local player = Players:GetPlayerByUserId(userId)
						if player then
							table.insert(initiationsList, {
								userId = player.UserId,
								name = player.DisplayName,
								obj = initiationChild,
								isTradingVIP = player:GetAttribute(TradeConsts.TRADING_VIP_ATTRIBUTE_NAME)
							})
							if Players.LocalPlayer.PlayerGui then
								Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9781039157, {
									Volume = 0.2
								})
							end
						end
					end
				end
				store:dispatch({
					type = "tradeInitiationsSet",
					list = initiationsList
				})
			end
			updateInitiations()
			initiationsFolder.ChildAdded:Connect(updateInitiations)
			initiationsFolder.ChildRemoved:Connect(updateInitiations)
		end)
		waitForChild(ReplicatedStorage, TradeConsts.OFFERING_RESULT_REMOTE_NAME):andThen(function(offeringResultRemote)
			offeringResultRemote.OnClientEvent:Connect(function(tradeResult)
				local isSuccess = false
				local resultTitle, resultBody
				if tradeResult.accepted then
					isSuccess = true
					resultTitle = "Trade Accepted!"
					resultBody = "Items have been exchanged between both parties. Enjoy!"
				elseif tradeResult.meDecline then
					resultTitle = "Trade Declined!"
					resultBody = "You backed out of the trade. No items were exchanged."
				elseif tradeResult.themDecline then
					resultTitle = "Trade Declined!"
					resultBody = "The other party backed out of the trade. No items were exchanged."
				elseif tradeResult.imbalanced then
					resultTitle = "Trade Denied!"
					resultBody = "Trades with an unfair balance are denied. No items were exchanged."
				else
					resultTitle = "Trade Failed"
					resultBody = "Try again?"
				end
				if isSuccess then
					if Players.LocalPlayer.PlayerGui then
						Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9781040308, {
							Volume = 0.3
						})
					end
					eventManager.l2atqdos(12)
				elseif Players.LocalPlayer.PlayerGui then
					Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9781041170, {
						Volume = 0.3
					})
				end
				store:dispatch({
					type = "setTradeResult",
					value = {
						success = isSuccess,
						title = resultTitle,
						body = resultBody
					}
				})
				task.delay(6, function()
					store:dispatch({
						type = "setTradeResult",
						value = nil
					})
				end)
			end)
		end)
		waitForChild(ReplicatedStorage, TradeConsts.UPDATE_OFFERING_INFO_REMOTE_NAME):andThen(function(updateOfferingInfoRemote)
			updateOfferingInfoRemote.OnClientEvent:Connect(function(tradeInfo)
				store:dispatch({
					type = "setTradeInfo",
					info = tradeInfo
				})
			end)
		end)
		waitForChild(ReplicatedStorage, TradeConsts.POPULAR_TRADE_ITEM_DATA_REMOTE_NAME):andThen(function(popularTradeRemote)
			popularTradeRemote.OnClientEvent:Connect(function(popularTradeData)
				TradePopularSortData.setPopularTradeItemData(popularTradeData)
			end)
		end)
		waitForChild(ReplicatedStorage, TradeConsts.OTHER_TRADE_SERVER_DATA_REMOTE_NAME):andThen(function(otherTradeServerRemote)
			otherTradeServerRemote.OnClientEvent:Connect(function(serverTradeData)
				store:dispatch({
					type = "setOtherTradeServerInfo",
					value = serverTradeData
				})
			end)
		end)
		local function updatePlayers()
			store:dispatch({
				type = "setInventoryPlayers",
				allPlayers = Players:GetPlayers()
			})
		end
		store:dispatch({
			type = "setInventoryPlayers",
			allPlayers = Players:GetPlayers()
		})
		Players.PlayerAdded:Connect(updatePlayers)
		Players.ChildRemoved:Connect(updatePlayers)
	end
end
function tradeService.checkAlreadyInitiated(targetPlayer, localPlayer)
	local initiationsFolder = localPlayer:FindFirstChild(TradeConsts.INITIATIONS_FOLDER_NAME)
	return initiationsFolder:FindFirstChild((tostring(targetPlayer.UserId))) and true or false
end
function tradeService.acceptInitiation(targetPlayer)
	ReplicatedStorage:FindFirstChild(TradeConsts.ACCEPT_TRADE_INITIATION_REMOTE_NAME):FireServer(targetPlayer)
end
function tradeService.sendInitiation(targetPlayer)
	ReplicatedStorage:WaitForChild(TradeConsts.SEND_TRADE_INITIATION_REMOTE_NAME):FireServer(targetPlayer)
end
function tradeService.getTradingWithUserId()
	return tradeService._tradingWithUserId
end
return tradeService
