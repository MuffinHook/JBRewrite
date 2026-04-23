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
local function playReadyDing() --[[ Line: 16 | Upvalues: Players (copy), Audio (copy) ]]
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9856727426, {
			Volume = 0.2
		})
	end
end
local t = {
	_tradingWithUserId = nil
}
local v1 = nil
function t.init(p1) --[[ Line: 26 | Upvalues: v1 (ref), RunUtils (copy), store (copy), t (copy), waitForChild (copy), ReplicatedStorage (copy), TradeConsts (copy), gameSettingType (copy), GameSettingsService (copy), ChatService (copy), Players (copy), EnumSort (copy), RxInstanceUtils (copy), Audio (copy), TradePopularSortData (copy) ]]
	v1 = p1.em
	if RunUtils.isTradingEnabled() then
		store.changed:connect(function(p1, p2) --[[ Line: 33 | Upvalues: t (ref), store (ref) ]]
			t._tradingWithUserId = p1.traderThem.userId
			if p1.traderThem.userId ~= p2.traderThem.userId then
				store:dispatch({
					type = "clearTradeChatMessages"
				})
			end
			local t2 = {}
			for v1, v2 in p1.traderThem.offerItems do
				t2[v2.id] = true
			end
			for v3, v4 in p2.traderThem.offerItems do
				if not t2[v4.id] then
					store:dispatch({
						type = "addTradeChatMessage",
						displayName = "SERVER",
						text = v4.title .. " removed from trade!",
						me = false,
						color = Color3.new(255/255, 0/255, 0/255)
					})
				end
			end
		end)
		waitForChild(ReplicatedStorage, TradeConsts.ARE_TRADE_REQUESTS_ENABLED_REMOTE_NAME):andThen(function(p1) --[[ Line: 62 | Upvalues: gameSettingType (ref), GameSettingsService (ref) ]]
			local t = {
				name = "areTradeRequestsEnabled",
				title = "Allow Trade Requests",
				type = gameSettingType.Checkbox,
				defaultValue = true,
				order = 41
			}
			GameSettingsService.add(t)
			local function handleTradeRequestsEnabled(p12) --[[ Line: 71 | Upvalues: p1 (copy) ]]
				p1:FireServer(p12)
			end
			p1:FireServer((t:getValue()))
			t.onChanged:Connect(handleTradeRequestsEnabled)
		end)
		ChatService.onMessageIncoming:Connect(function(p1, p2) --[[ Line: 80 | Upvalues: Players (ref), t (ref), store (ref) ]]
			if p1.Status == Enum.TextChatMessageStatus.Success and p1.TextSource then
				local Text = p2.Text
				local UserId = p1.TextSource.UserId
				local v1 = Players:GetPlayerByUserId(UserId)
				if v1 and p1.TextChannel.Name == "RBXGeneral" then
					local v2 = t.getTradingWithUserId()
					if v2 then
						local isLocalPlayer = v1 == Players.LocalPlayer
						if isLocalPlayer or UserId == v2 then
							store:dispatch({
								type = "addTradeChatMessage",
								displayName = v1.DisplayName,
								text = Text,
								me = isLocalPlayer
							})
						end
					end
				end
			end
		end)
		waitForChild(ReplicatedStorage, TradeConsts.UPDATE_OWNED_REMOTE_NAME):andThen(function(p1) --[[ Line: 115 | Upvalues: store (ref), EnumSort (ref) ]]
			p1.OnClientEvent:Connect(function(p1) --[[ Line: 116 | Upvalues: store (ref), EnumSort (ref) ]]
				store:dispatch({
					type = "tradeInventorySetItemsOwned",
					itemsOwned = p1,
					sortId = EnumSort.Newest
				})
			end)
		end)
		waitForChild(ReplicatedStorage, TradeConsts.UPDATE_OFFERING_REMOTE_NAME):andThen(function(p1) --[[ Line: 126 | Upvalues: store (ref) ]]
			p1.OnClientEvent:Connect(function(p1, p2) --[[ Line: 127 | Upvalues: store (ref) ]]
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
		waitForChild(Players.LocalPlayer, TradeConsts.ACTIVE_TRADE_OBJ_NAME):andThen(function(p1) --[[ Line: 142 | Upvalues: RxInstanceUtils (ref), TradeConsts (ref), store (ref), Players (ref), Audio (ref) ]]
			RxInstanceUtils.observeAttribute(p1, TradeConsts.IS_READY_ATTR_NAME, function(p1) --[[ Line: 143 | Upvalues: store (ref), Players (ref), Audio (ref) ]]
				store:dispatch({
					type = "updateTraderMe",
					ready = p1
				})
				if p1 and Players.LocalPlayer.PlayerGui then
					Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9856727426, {
						Volume = 0.2
					})
				end
			end)
			RxInstanceUtils.observeAttribute(p1, TradeConsts.IS_ACCEPTED_ATTR_NAME, function(p1) --[[ Line: 152 | Upvalues: store (ref), Players (ref), Audio (ref) ]]
				store:dispatch({
					type = "updateTraderMe",
					accepted = p1
				})
				if p1 and Players.LocalPlayer.PlayerGui then
					Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9856727426, {
						Volume = 0.2
					})
				end
			end)
			p1.Changed:Connect(function(p1) --[[ Line: 161 | Upvalues: store (ref), Players (ref) ]]
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
			RxInstanceUtils.observeAttribute(p1, TradeConsts.WITH_USER_ID_ATTR_NAME, function(p1, p2) --[[ Line: 182 | Upvalues: Players (ref), TradeConsts (ref), RxInstanceUtils (ref), store (ref), Audio (ref) ]]
				if p1 then
					local v1 = Players:GetPlayerByUserId(p1)
					if v1 then
						local v2 = v1:FindFirstChild(TradeConsts.ACTIVE_TRADE_OBJ_NAME)
						if v2 then
							p2:GiveTask(RxInstanceUtils.observeAttribute(v2, TradeConsts.IS_READY_ATTR_NAME, function(p1) --[[ Line: 192 | Upvalues: store (ref), Players (ref), Audio (ref) ]]
								store:dispatch({
									type = "updateTraderThem",
									ready = p1
								})
								if p1 and Players.LocalPlayer.PlayerGui then
									Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9856727426, {
										Volume = 0.2
									})
								end
							end))
							p2:GiveTask(RxInstanceUtils.observeAttribute(v2, TradeConsts.IS_ACCEPTED_ATTR_NAME, function(p1) --[[ Line: 207 | Upvalues: store (ref), Players (ref), Audio (ref) ]]
								store:dispatch({
									type = "updateTraderThem",
									accepted = p1
								})
								if p1 and Players.LocalPlayer.PlayerGui then
									Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9856727426, {
										Volume = 0.2
									})
								end
							end))
						end
						store:dispatch({
							type = "updateTraderThem",
							userId = p1,
							displayName = v1.DisplayName
						})
					end
				end
				p2:GiveTask(function() --[[ Line: 226 | Upvalues: store (ref) ]]
					store:dispatch({
						type = "updateTraderThem",
						reset = true
					})
				end)
			end)
		end)
		waitForChild(Players.LocalPlayer, TradeConsts.INITIATIONS_FOLDER_NAME):andThen(function(p1) --[[ Line: 236 | Upvalues: Players (ref), TradeConsts (ref), Audio (ref), store (ref) ]]
			local function updateInitiations() --[[ Line: 237 | Upvalues: p1 (copy), Players (ref), TradeConsts (ref), Audio (ref), store (ref) ]]
				local t = {}
				for i, v in ipairs(p1:GetChildren()) do
					local v2 = tonumber(v.Name)
					if v2 then
						local v3 = Players:GetPlayerByUserId(v2)
						if v3 then
							table.insert(t, {
								userId = v3.UserId,
								name = v3.DisplayName,
								obj = v,
								isTradingVIP = v3:GetAttribute(TradeConsts.TRADING_VIP_ATTRIBUTE_NAME)
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
					list = t
				})
			end
			updateInitiations()
			p1.ChildAdded:Connect(updateInitiations)
			p1.ChildRemoved:Connect(updateInitiations)
		end)
		waitForChild(ReplicatedStorage, TradeConsts.OFFERING_RESULT_REMOTE_NAME):andThen(function(p1) --[[ Line: 267 | Upvalues: Players (ref), Audio (ref), v1 (ref), store (ref) ]]
			p1.OnClientEvent:Connect(function(p1) --[[ Line: 268 | Upvalues: Players (ref), Audio (ref), v1 (ref), store (ref) ]]
				local v12 = false
				local v2, v3
				if p1.accepted then
					v12 = true
					v2 = "Trade Accepted!"
					v3 = "Items have been exchanged between both parties. Enjoy!"
				elseif p1.meDecline then
					v2 = "Trade Declined!"
					v3 = "You backed out of the trade. No items were exchanged."
				elseif p1.themDecline then
					v2 = "Trade Declined!"
					v3 = "The other party backed out of the trade. No items were exchanged."
				elseif p1.imbalanced then
					v2 = "Trade Denied!"
					v3 = "Trades with an unfair balance are denied. No items were exchanged."
				else
					v2 = "Trade Failed"
					v3 = "Try again?"
				end
				if v12 then
					if Players.LocalPlayer.PlayerGui then
						Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9781040308, {
							Volume = 0.3
						})
					end
					v1.l2atqdos(12)
				elseif Players.LocalPlayer.PlayerGui then
					Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9781041170, {
						Volume = 0.3
					})
				end
				store:dispatch({
					type = "setTradeResult",
					value = {
						success = v12,
						title = v2,
						body = v3
					}
				})
				task.delay(6, function() --[[ Line: 309 | Upvalues: store (ref) ]]
					store:dispatch({
						type = "setTradeResult",
						value = nil
					})
				end)
			end)
		end)
		waitForChild(ReplicatedStorage, TradeConsts.UPDATE_OFFERING_INFO_REMOTE_NAME):andThen(function(p1) --[[ Line: 319 | Upvalues: store (ref) ]]
			p1.OnClientEvent:Connect(function(p1) --[[ Line: 320 | Upvalues: store (ref) ]]
				store:dispatch({
					type = "setTradeInfo",
					info = p1
				})
			end)
		end)
		waitForChild(ReplicatedStorage, TradeConsts.POPULAR_TRADE_ITEM_DATA_REMOTE_NAME):andThen(function(p1) --[[ Line: 329 | Upvalues: TradePopularSortData (ref) ]]
			p1.OnClientEvent:Connect(function(p1) --[[ Line: 330 | Upvalues: TradePopularSortData (ref) ]]
				TradePopularSortData.setPopularTradeItemData(p1)
			end)
		end)
		waitForChild(ReplicatedStorage, TradeConsts.OTHER_TRADE_SERVER_DATA_REMOTE_NAME):andThen(function(p1) --[[ Line: 337 | Upvalues: store (ref) ]]
			p1.OnClientEvent:Connect(function(p1) --[[ Line: 338 | Upvalues: store (ref) ]]
				store:dispatch({
					type = "setOtherTradeServerInfo",
					value = p1
				})
			end)
		end)
		local function updatePlayers() --[[ Line: 348 | Upvalues: store (ref), Players (ref) ]]
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
function t.checkAlreadyInitiated(p1, p2) --[[ Line: 359 | Upvalues: TradeConsts (copy) ]]
	local v1 = p2:FindFirstChild(TradeConsts.INITIATIONS_FOLDER_NAME)
	return v1:FindFirstChild((tostring(p1.UserId))) and true or false
end
function t.acceptInitiation(p1) --[[ Line: 367 | Upvalues: ReplicatedStorage (copy), TradeConsts (copy) ]]
	ReplicatedStorage:FindFirstChild(TradeConsts.ACCEPT_TRADE_INITIATION_REMOTE_NAME):FireServer(p1)
end
function t.sendInitiation(p1) --[[ Line: 371 | Upvalues: ReplicatedStorage (copy), TradeConsts (copy) ]]
	ReplicatedStorage:WaitForChild(TradeConsts.SEND_TRADE_INITIATION_REMOTE_NAME):FireServer(p1)
end
function t.getTradingWithUserId() --[[ Line: 375 | Upvalues: t (copy) ]]
	return t._tradingWithUserId
end
return t