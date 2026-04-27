local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local TextChatService = game:GetService("TextChatService")
local AdminPermUtils = require(ReplicatedStorage.App.AdminPermUtils)
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local RichTextUtils = require(ReplicatedStorage.Std.RichTextUtils)
local Signal = require(ReplicatedStorage.Std.Signal)
local ChatService = {}
local partnerColor = Color3.fromRGB(110, 197, 59)
local tradingVIPColor = Color3.fromRGB(255, 192, 203)
local vipColor = Color3.fromRGB(255, 191, 5)
local badimoColor = Color3.fromRGB(235, 88, 88)
local systemMessageColor = Color3.fromHex("f1da10")
ChatService.onMessageIncoming = Signal.new()
function ChatService.init()
	local ChatWindowConfiguration = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
	if ChatWindowConfiguration then
		ChatWindowConfiguration.TextStrokeTransparency = 0.7
	else
		warn("ChatWindowConfiguration not found")
	end
	local playerMaids = Maid.new()
	local playerChatDataMap = {}
	local function playerRemoving(player)
		playerMaids[player] = nil
		playerChatDataMap[player] = nil
	end
	local function setPlayerChatData(player)
		local playerChatData = {
			Tags = {}
		}
		if RunUtils.isMainWorld() and GamepassSystem.doesPlayerOwnCached(player, GamepassUtils.EnumGamepass.VIP) then
			playerChatData.ChatColor = vipColor
			table.insert(playerChatData.Tags, {
				TagText = "[VIP] ",
				TagColor = vipColor
			})
		end
		if RunUtils.isTradeWorld() and GamepassSystem.doesPlayerOwnCached(player, GamepassUtils.EnumGamepass.TradingVIP) then
			playerChatData.ChatColor = tradingVIPColor
			table.insert(playerChatData.Tags, {
				TagText = "[TradingVIP] ",
				TagColor = tradingVIPColor
			})
		end
		if player:GetAttribute("IsPartner") then
			table.insert(playerChatData.Tags, {
				TagText = "[Star] ",
				TagColor = partnerColor
			})
		end
		if AdminPermUtils.isBadimo(player) then
			playerChatData.ChatColor = badimoColor
			table.clear(playerChatData.Tags)
			table.insert(playerChatData.Tags, {
				TagText = "[Badimo] ",
				TagColor = badimoColor
			})
		end
		playerChatDataMap[player] = playerChatData
	end
	local function playerAdded(player)
		local playerMaid = Maid.new()
		playerMaids[player] = playerMaid
		setPlayerChatData(player)
		playerMaid:GiveTask(GamepassSystem.OnAnyPlayerAnyOwned:Connect(function(ownerPlayer, gamepass)
			if ownerPlayer == player then
				setPlayerChatData(player)
			end
		end))
		playerMaid:GiveTask(player:GetAttributeChangedSignal("IsPartner"):Connect(function()
			setPlayerChatData(player)
		end))
	end
	for _, player in Players:GetPlayers() do
		playerAdded(player)
	end
	Players.PlayerAdded:Connect(playerAdded)
	Players.PlayerRemoving:Connect(playerRemoving)
	function TextChatService.OnIncomingMessage(message)
		local TextChatMessageProperties = Instance.new("TextChatMessageProperties")
		local TextChannel = message.TextChannel
		local isTeamChannel = if TextChannel then string.find(TextChannel.Name, "RBXTeam") else nil
		if message.TextSource == nil and message.Metadata == "BadimoSystemMessage" then
			local messageColor = systemMessageColor
			if RichTextUtils.doesTextHaveColor(message.Text) then
				messageColor = RichTextUtils.extractColorFromText(message.Text)
			else
				TextChatMessageProperties.Text = RichTextUtils.addColorToText(message.Text, systemMessageColor)
			end
			TextChatMessageProperties.PrefixText = RichTextUtils.addColorToText("[System]", messageColor) .. message.PrefixText
		elseif isTeamChannel then
			TextChatMessageProperties.Text = RichTextUtils.addColorToText(message.Text, BrickColor.new((string.sub(TextChannel.Name, isTeamChannel + 7))).Color)
		elseif message.TextSource then
			local UserId = message.TextSource.UserId
			local sourcePlayer = Players:GetPlayerByUserId(UserId)
			if sourcePlayer then
				if sourcePlayer:GetAttribute("ChatLoaded") == true or sourcePlayer == Players.LocalPlayer then
					local sourcePlayerChatData = playerChatDataMap[sourcePlayer]
					if sourcePlayerChatData then
						local PrefixText = message.PrefixText
						for _, tag in sourcePlayerChatData.Tags do
							local tagColor = tag.TagColor or Color3.new(255/255, 255/255, 255/255)
							local tagText = tag.TagText or ""
							if #tagText > 0 then
								PrefixText = RichTextUtils.addColorToText(tagText, tagColor) .. PrefixText
							end
						end
						TextChatMessageProperties.PrefixText = PrefixText
						local Text = message.Text
						local chatColor = sourcePlayerChatData.ChatColor or Color3.new(255/255, 255/255, 255/255)
						TextChatMessageProperties.Text = if UserId == 1 then RichTextUtils.addColorToText(Text, Color3.fromHSV(math.random(), 1, 1)) else RichTextUtils.addColorToText(Text, chatColor)
					else
						return
					end
				else
					message.Status = Enum.TextChatMessageStatus.InvalidTextChannelPermissions
					return nil
				end
			else
				return
			end
		end
		ChatService.onMessageIncoming:Fire(message, TextChatMessageProperties)
		return TextChatMessageProperties
	end
	function TextChatService.OnBubbleAdded(message, bubbleInstance)
		if message.TextSource then
			local BubbleChatMessageProperties = Instance.new("BubbleChatMessageProperties")
			BubbleChatMessageProperties.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
			return BubbleChatMessageProperties
		end
	end
end
return ChatService
