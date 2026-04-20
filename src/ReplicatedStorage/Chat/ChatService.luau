local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {
    onMessageIncoming = require(ReplicatedStorage.Std.Signal).new();
}
local TextChatService_upvr = game:GetService("TextChatService")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local RunUtils_upvr = require(ReplicatedStorage.App.RunUtils)
local GamepassSystem_upvr = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils_upvr = require(ReplicatedStorage.Gamepass.GamepassUtils)
local Color3_fromRGB_result1_upvr_2 = Color3.fromRGB(255, 191, 5)
local Color3_fromRGB_result1_upvr_3 = Color3.fromRGB(255, 192, 203)
local Color3_fromRGB_result1_upvr_4 = Color3.fromRGB(110, 197, 59)
local AdminPermUtils_upvr = require(ReplicatedStorage.App.AdminPermUtils)
local Color3_fromRGB_result1_upvr = Color3.fromRGB(235, 88, 88)
local Players_upvr = game:GetService("Players")
local Color3_fromHex_result1_upvr = Color3.fromHex("f1da10")
local RichTextUtils_upvr = require(ReplicatedStorage.Std.RichTextUtils)
function module_upvr.init() -- Line 22
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local class_ChatWindowConfiguration = TextChatService_upvr:FindFirstChildOfClass("ChatWindowConfiguration")
    if class_ChatWindowConfiguration then
        class_ChatWindowConfiguration.TextStrokeTransparency = 0.7
    else
        warn("ChatWindowConfiguration not found")
    end
    local any_new_result1_upvr = Maid_upvr.new()
    local tbl_2_upvr = {}
    local function setPlayerChatData_upvr(arg1) -- Line 36, Named "setPlayerChatData"
        local tbl = {
            Tags = {};
        }
        if RunUtils_upvr.isMainWorld() and GamepassSystem_upvr.doesPlayerOwnCached(arg1, GamepassUtils_upvr.EnumGamepass.VIP) then
            tbl.ChatColor = Color3_fromRGB_result1_upvr_2
            table.insert(tbl.Tags, {
                TagText = "[VIP] ";
                TagColor = Color3_fromRGB_result1_upvr_2;
            })
        end
        if RunUtils_upvr.isTradeWorld() and GamepassSystem_upvr.doesPlayerOwnCached(arg1, GamepassUtils_upvr.EnumGamepass.TradingVIP) then
            tbl.ChatColor = Color3_fromRGB_result1_upvr_3
            table.insert(tbl.Tags, {
                TagText = "[TradingVIP] ";
                TagColor = Color3_fromRGB_result1_upvr_3;
            })
        end
        if arg1:GetAttribute("IsPartner") then
            table.insert(tbl.Tags, {
                TagText = "[Star] ";
                TagColor = Color3_fromRGB_result1_upvr_4;
            })
        end
        if AdminPermUtils_upvr.isBadimo(arg1) then
            tbl.ChatColor = Color3_fromRGB_result1_upvr
            table.clear(tbl.Tags)
            table.insert(tbl.Tags, {
                TagText = "[Badimo] ";
                TagColor = Color3_fromRGB_result1_upvr;
            })
        end
        tbl_2_upvr[arg1] = tbl
    end
    for _, v in Players_upvr:GetPlayers() do
        (function(arg1) -- Line 73, Named "playerAdded"
            local any_new_result1 = Maid_upvr.new()
            any_new_result1_upvr[arg1] = any_new_result1
            setPlayerChatData_upvr(arg1)
            any_new_result1:GiveTask(GamepassSystem_upvr.OnAnyPlayerAnyOwned:Connect(function(arg1_2, arg2) -- Line 77
                if arg1_2 ~= arg1 then
                else
                    setPlayerChatData_upvr(arg1)
                end
            end))
            any_new_result1:GiveTask(arg1:GetAttributeChangedSignal("IsPartner"):Connect(function() -- Line 83
                setPlayerChatData_upvr(arg1)
            end))
        end)(v)
        local var38
    end
    Players_upvr.PlayerAdded:Connect(var38)
    Players_upvr.PlayerRemoving:Connect(function(arg1) -- Line 32, Named "playerRemoving"
        any_new_result1_upvr[arg1] = nil
        tbl_2_upvr[arg1] = nil
    end)
    function TextChatService_upvr.OnIncomingMessage(arg1) -- Line 92
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local TextChatMessageProperties = Instance.new("TextChatMessageProperties")
        local TextChannel = arg1.TextChannel
        local var46
        if TextChannel then
            var46 = string.find(TextChannel.Name, "RBXTeam")
        end
        if arg1.TextSource == nil and arg1.Metadata == "BadimoSystemMessage" then
            local var47 = Color3_fromHex_result1_upvr
            if RichTextUtils_upvr.doesTextHaveColor(arg1.Text) then
                var47 = RichTextUtils_upvr.extractColorFromText(arg1.Text)
            else
                TextChatMessageProperties.Text = RichTextUtils_upvr.addColorToText(arg1.Text, Color3_fromHex_result1_upvr)
            end
            TextChatMessageProperties.PrefixText = RichTextUtils_upvr.addColorToText("[System]", var47)..arg1.PrefixText
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if var46 then
            TextChatMessageProperties.Text = RichTextUtils_upvr.addColorToText(arg1.Text, BrickColor.new(string.sub(TextChannel.Name, var46 + 7)).Color)
        else
            local var48
            if arg1.TextSource then
                local UserId = arg1.TextSource.UserId
                local any_GetPlayerByUserId_result1 = Players_upvr:GetPlayerByUserId(UserId)
                if not any_GetPlayerByUserId_result1 then return end
                local var51
                if any_GetPlayerByUserId_result1:GetAttribute("ChatLoaded") ~= true and any_GetPlayerByUserId_result1 ~= Players_upvr.LocalPlayer then
                    arg1.Status = Enum.TextChatMessageStatus.InvalidTextChannelPermissions
                    return nil
                end
                local var52 = tbl_2_upvr[any_GetPlayerByUserId_result1]
                if not var52 then return end
                var51 = arg1.PrefixText
                var48 = nil
                for _, v_2 in var52.Tags, var48 do
                    local var53
                    if not var53 then
                        var53 = Color3.new(1, 1, 1)
                    end
                    local var54 = v_2.TagText or ""
                    if 0 < #var54 then
                        var51 = RichTextUtils_upvr.addColorToText(var54, var53)..var51
                    end
                end
                TextChatMessageProperties.PrefixText = var51
                var48 = var52.ChatColor
                if not var48 then
                    var48 = Color3.new(1, 1, 1)
                end
                local var55
                if UserId == 1 then
                    var53 = Color3.fromHSV(math.random(), 1, 1)
                    var55 = RichTextUtils_upvr.addColorToText(arg1.Text, var53)
                else
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    var55 = RichTextUtils_upvr.addColorToText(arg1.Text, var48)
                end
                TextChatMessageProperties.Text = var55
            end
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    function TextChatService_upvr.OnBubbleAdded(arg1, arg2) -- Line 147
        if arg1.TextSource then
            local BubbleChatMessageProperties = Instance.new("BubbleChatMessageProperties")
            BubbleChatMessageProperties.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
            return BubbleChatMessageProperties
        end
    end
end
return module_upvr