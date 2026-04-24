-- Reviewed by Claude
-- variables reassigned
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
function tradeService.init(p1)
	eventManager = p1.em
	if RunUtils.isTradingEnabled() then
		store.changed:connect(function(p1, p2)
			tradeService._tradingWithUserId = p1.traderThem.userId
			if p1.traderThem.userId ~= p2.traderThem.userId then
				store:dispatch({
					type = "clearTradeChatMessages"
				})
			end
			local newOfferingMap = {}
			for currentIndex, currentItem in p1.traderThem.offerItems do
				newOfferingMap[currentItem.id] = true
			end
			for previousIndex, previousItem in p2.traderThem.offerItems do
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
		waitForChild(ReplicatedStorage, TradeConsts.ARE_TRADE_REQUESTS_ENABLED_REMOTE_NAME):andThen(function(p1)
			local settingConfig = {
				name = "areTradeRequestsEnabled",
				title = "Allow Trade Requests",
				type = gameSettingType.Checkbox,
				defaultValue = true,
				order = 41
			}
			GameSettingsService.add(settingConfig)
			local function handleTradeRequestsEnabled(p12)
				p1:FireServer(p12)
			end
			p1:FireServer((settingConfig:getValue()))
			settingConfig.onChanged:Connect(handleTradeRequestsEnabled)
		end)
		ChatService.onMessageIncoming:Connect(function(p1, p2)
			if p1.Status == Enum.TextChatMessageStatus.Success and p1.TextSource then
				local Text = p2.Text
				local UserId = p1.TextSource.UserId
				local player = Players:GetPlayerByUserId(UserId)
				if player and p1.TextChannel.Name == "RBXGeneral" then
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
		waitForChild(ReplicatedStorage, TradeConsts.UPDATE_OWNED_REMOTE_NAME):andThen(function(p1)
			p1.OnClientEvent:Connect(function(p1)
				store:dispatch({
					type = "tradeInventorySetItemsOwned",
					itemsOwned = p1,
					sortId = EnumSort.Newest
				})
			end)
		end)
		waitForChild(ReplicatedStorage, TradeConsts.UPDATE_OFFERING_REMOTE_NAME):andThen(function(p1)
			p1.OnClientEvent:Connect(function(p1, p2)
				if p1 then
					store:dispatch({
						type = "updateTraderMe",
						itemsOwnedOffering = p2
					})
				else
					store:dispatch({
						type = "updateTraderThem",
						itemsOwnedOffering = p2
					})
				end
			end)
		end)
		waitForChild(Players.LocalPlayer, TradeConsts.ACTIVE_TRADE_OBJ_NAME):andThen(function(p1)
			RxInstanceUtils.observeAttribute(p1, TradeConsts.IS_READY_ATTR_NAME, function(readyStatus)
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
			RxInstanceUtils.observeAttribute(p1, TradeConsts.IS_ACCEPTED_ATTR_NAME, function(acceptedStatus)
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
			p1.Changed:Connect(function(p1)
				if p1 then
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
					value = p1
				})
			end)
			RxInstanceUtils.observeAttribute(p1, TradeConsts.WITH_USER_ID_ATTR_NAME, function(traderUserId, maid)
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
		waitForChild(Players.LocalPlayer, TradeConsts.INITIATIONS_FOLDER_NAME):andThen(function(p1)
			local function updateInitiations()
				local initiationsList = {}
				for i, v in ipairs(p1:GetChildren()) do
					local userId = tonumber(v.Name)
					if userId then
						local player = Players:GetPlayerByUserId(userId)
						if player then
							table.insert(initiationsList, {
								userId = player.UserId,
								name = player.DisplayName,
								obj = v,
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
			p1.ChildAdded:Connect(updateInitiations)
			p1.ChildRemoved:Connect(updateInitiations)
		end)
		waitForChild(ReplicatedStorage, TradeConsts.OFFERING_RESULT_REMOTE_NAME):andThen(function(p1)
			p1.OnClientEvent:Connect(function(p1)
				local isSuccess = false
				local resultTitle, resultBody
				if p1.accepted then
					isSuccess = true
					resultTitle = "Trade Accepted!"
					resultBody = "Items have been exchanged between both parties. Enjoy!"
				elseif p1.meDecline then
					resultTitle = "Trade Declined!"
					resultBody = "You backed out of the trade. No items were exchanged."
				elseif p1.themDecline then
					resultTitle = "Trade Declined!"
					resultBody = "The other party backed out of the trade. No items were exchanged."
				elseif p1.imbalanced then
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
		waitForChild(ReplicatedStorage, TradeConsts.UPDATE_OFFERING_INFO_REMOTE_NAME):andThen(function(p1)
			p1.OnClientEvent:Connect(function(p1)
				store:dispatch({
					type = "setTradeInfo",
					info = p1
				})
			end)
		end)
		waitForChild(ReplicatedStorage, TradeConsts.POPULAR_TRADE_ITEM_DATA_REMOTE_NAME):andThen(function(p1)
			p1.OnClientEvent:Connect(function(p1)
				TradePopularSortData.setPopularTradeItemData(p1)
			end)
		end)
		waitForChild(ReplicatedStorage, TradeConsts.OTHER_TRADE_SERVER_DATA_REMOTE_NAME):andThen(function(p1)
			p1.OnClientEvent:Connect(function(p1)
				store:dispatch({
					type = "setOtherTradeServerInfo",
					value = p1
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
function tradeService.checkAlreadyInitiated(p1, p2)
	local initiationsFolder = p2:FindFirstChild(TradeConsts.INITIATIONS_FOLDER_NAME)
	return initiationsFolder:FindFirstChild((tostring(p1.UserId))) and true or false
end
function tradeService.acceptInitiation(p1)
	ReplicatedStorage:FindFirstChild(TradeConsts.ACCEPT_TRADE_INITIATION_REMOTE_NAME):FireServer(p1)
end
function tradeService.sendInitiation(p1)
	ReplicatedStorage:WaitForChild(TradeConsts.SEND_TRADE_INITIATION_REMOTE_NAME):FireServer(p1)
end
function tradeService.getTradingWithUserId()
	return tradeService._tradingWithUserId
end
return tradeService
