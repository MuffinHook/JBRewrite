local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Settings = require(ReplicatedStorage.Resource.Settings)
local Notification = require(ReplicatedStorage.Game.Notification)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local Audio = require(ReplicatedStorage.Std.Audio)
local SeasonUtils = require(ReplicatedStorage.Game.Season.SeasonUtils)
local SeasonConsts = require(ReplicatedStorage.Game.Season.SeasonConsts)
return {
	hookGiftContainer = function(p1, p2) --[[ Name: hookGiftContainer | Line: 13 | Upvalues: LocalPlayer (copy), SeasonConsts (copy), RunUtils (copy), SeasonUtils (copy), Notification (copy), Audio (copy), Settings (copy), ReplicatedStorage (copy), Players (copy) ]]
		local function clearInputs() --[[ Line: 14 | Upvalues: p1 (copy) ]]
			p1.ContainerIcon.Icon.Image = ""
			p1.ContainerPlayerName.Text = ""
		end
		p1.ContainerIcon.Icon.Image = ""
		p1.ContainerPlayerName.Text = ""
		p2:GiveTask(LocalPlayer:FindFirstChild(SeasonConsts.PLAYER_SEASON_PASS_GIFT_VALUES_FOLDER_NAME):FindFirstChild(SeasonConsts.PLAYER_ALLOWED_TO_ATTEMPT_SEASON_PASS_GIFT_FLAG_NAME).Changed:Connect(function(p12) --[[ Line: 25 | Upvalues: p1 (copy) ]]
			p1.Visible = p12
			return true
		end))
		p2:GiveTask(p1.PurchaseButton.MouseButton1Down:Connect(function() --[[ Line: 30 | Upvalues: RunUtils (ref), SeasonUtils (ref), Notification (ref), Audio (ref), LocalPlayer (ref), Settings (ref), ReplicatedStorage (ref), SeasonConsts (ref), p1 (copy), Players (ref) ]]
			if RunUtils.isStudio() or not (SeasonUtils.getRemainingTime() < 0) then
				Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105461542)
				assert(Settings.getFirstProductByType("SeasonPass") ~= nil)
				local v2 = ReplicatedStorage:FindFirstChild(SeasonConsts.SEASON_PASS_GIFT_ATTEMPT_REMOTE_NAME)
				local Text = p1.ContainerPlayerName.Text
				if #Text ~= 0 then
					v2:FireServer((Players:GetUserIdFromNameAsync(Text)))
					p1.ContainerIcon.Icon.Image = ""
					p1.ContainerPlayerName.Text = ""
				end
			else
				Notification.new({
					Text = "Season is over! Wait until next season."
				})
			end
		end))
		local v1 = 0
		p2:GiveTask(p1.ContainerPlayerName:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 50 | Upvalues: v1 (ref), p1 (copy), Players (ref) ]]
			v1 = v1 + 1
			local Text = p1.ContainerPlayerName.Text
			local v2 = nil
			local v3 = pcall(function() --[[ Line: 55 | Upvalues: v2 (ref), Players (ref), Text (copy) ]]
				v2 = Players:GetUserIdFromNameAsync(Text)
			end)
			local v4
			if v3 then
				local v5, v6 = Players:GetUserThumbnailAsync(v2, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size180x180)
				v3 = v6
				v4 = v5
			else
				v4 = nil
			end
			if v1 ~= v1 then
				return false
			end
			p1.ContainerIcon.Icon.Image = if v3 and v4 then v4 else ""
		end))
	end
}