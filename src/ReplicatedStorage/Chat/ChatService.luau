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
local t = {}
local v1 = Color3.fromRGB(110, 197, 59)
local v2 = Color3.fromRGB(255, 192, 203)
local v3 = Color3.fromRGB(255, 191, 5)
local v4 = Color3.fromRGB(235, 88, 88)
local v5 = Color3.fromHex("f1da10")
t.onMessageIncoming = Signal.new()
function t.init() --[[ Line: 22 | Upvalues: TextChatService (copy), Maid (copy), RunUtils (copy), GamepassSystem (copy), GamepassUtils (copy), v3 (copy), v2 (copy), v1 (copy), AdminPermUtils (copy), v4 (copy), Players (copy), v5 (copy), RichTextUtils (copy), t (copy) ]]
	local ChatWindowConfiguration = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
	if ChatWindowConfiguration then
		ChatWindowConfiguration.TextStrokeTransparency = 0.7
	else
		warn("ChatWindowConfiguration not found")
	end
	local v12 = Maid.new()
	local t2 = {}
	local function playerRemoving(p1) --[[ Line: 32 | Upvalues: v12 (copy), t2 (copy) ]]
		v12[p1] = nil
		t2[p1] = nil
	end
	local function setPlayerChatData(p1) --[[ Line: 36 | Upvalues: RunUtils (ref), GamepassSystem (ref), GamepassUtils (ref), v3 (ref), v2 (ref), v1 (ref), AdminPermUtils (ref), v4 (ref), t2 (copy) ]]
		local t = {
			Tags = {}
		}
		if RunUtils.isMainWorld() and GamepassSystem.doesPlayerOwnCached(p1, GamepassUtils.EnumGamepass.VIP) then
			t.ChatColor = v3
			table.insert(t.Tags, {
				TagText = "[VIP] ",
				TagColor = v3
			})
		end
		if RunUtils.isTradeWorld() and GamepassSystem.doesPlayerOwnCached(p1, GamepassUtils.EnumGamepass.TradingVIP) then
			t.ChatColor = v2
			table.insert(t.Tags, {
				TagText = "[TradingVIP] ",
				TagColor = v2
			})
		end
		if p1:GetAttribute("IsPartner") then
			table.insert(t.Tags, {
				TagText = "[Star] ",
				TagColor = v1
			})
		end
		if AdminPermUtils.isBadimo(p1) then
			t.ChatColor = v4
			table.clear(t.Tags)
			table.insert(t.Tags, {
				TagText = "[Badimo] ",
				TagColor = v4
			})
		end
		t2[p1] = t
	end
	local function playerAdded(p1) --[[ Line: 73 | Upvalues: Maid (ref), v12 (copy), setPlayerChatData (copy), GamepassSystem (ref) ]]
		local v1 = Maid.new()
		v12[p1] = v1
		setPlayerChatData(p1)
		v1:GiveTask(GamepassSystem.OnAnyPlayerAnyOwned:Connect(function(p12, p2) --[[ Line: 77 | Upvalues: p1 (copy), setPlayerChatData (ref) ]]
			if p12 == p1 then
				setPlayerChatData(p1)
			end
		end))
		v1:GiveTask(p1:GetAttributeChangedSignal("IsPartner"):Connect(function() --[[ Line: 83 | Upvalues: setPlayerChatData (ref), p1 (copy) ]]
			setPlayerChatData(p1)
		end))
	end
	for v22, v32 in Players:GetPlayers() do
		playerAdded(v32)
	end
	Players.PlayerAdded:Connect(playerAdded)
	Players.PlayerRemoving:Connect(playerRemoving)
	function TextChatService.OnIncomingMessage(p1) --[[ Line: 92 | Upvalues: v5 (ref), RichTextUtils (ref), Players (ref), t2 (copy), t (ref) ]]
		local TextChatMessageProperties = Instance.new("TextChatMessageProperties")
		local TextChannel = p1.TextChannel
		local v1 = if TextChannel then string.find(TextChannel.Name, "RBXTeam") else nil
		if p1.TextSource == nil and p1.Metadata == "BadimoSystemMessage" then
			local v3 = v5
			if RichTextUtils.doesTextHaveColor(p1.Text) then
				v3 = RichTextUtils.extractColorFromText(p1.Text)
			else
				TextChatMessageProperties.Text = RichTextUtils.addColorToText(p1.Text, v5)
			end
			TextChatMessageProperties.PrefixText = RichTextUtils.addColorToText("[System]", v3) .. p1.PrefixText
		elseif v1 then
			TextChatMessageProperties.Text = RichTextUtils.addColorToText(p1.Text, BrickColor.new((string.sub(TextChannel.Name, v1 + 7))).Color)
		elseif p1.TextSource then
			local UserId = p1.TextSource.UserId
			local v7 = Players:GetPlayerByUserId(UserId)
			if v7 then
				if v7:GetAttribute("ChatLoaded") == true or v7 == Players.LocalPlayer then
					local v8 = t2[v7]
					if v8 then
						local PrefixText = p1.PrefixText
						for v9, v10 in v8.Tags do
							local v11 = v10.TagColor or Color3.new(255/255, 255/255, 255/255)
							local v12 = v10.TagText or ""
							if #v12 > 0 then
								PrefixText = RichTextUtils.addColorToText(v12, v11) .. PrefixText
							end
						end
						TextChatMessageProperties.PrefixText = PrefixText
						local Text = p1.Text
						local v13 = v8.ChatColor or Color3.new(255/255, 255/255, 255/255)
						TextChatMessageProperties.Text = if UserId == 1 then RichTextUtils.addColorToText(Text, Color3.fromHSV(math.random(), 1, 1)) else RichTextUtils.addColorToText(Text, v13)
					else
						return
					end
				else
					p1.Status = Enum.TextChatMessageStatus.InvalidTextChannelPermissions
					return nil
				end
			else
				return
			end
		end
		t.onMessageIncoming:Fire(p1, TextChatMessageProperties)
		return TextChatMessageProperties
	end
	function TextChatService.OnBubbleAdded(p1, p2) --[[ Line: 147 ]]
		if p1.TextSource then
			local BubbleChatMessageProperties = Instance.new("BubbleChatMessageProperties")
			BubbleChatMessageProperties.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
			return BubbleChatMessageProperties
		end
	end
end
return t