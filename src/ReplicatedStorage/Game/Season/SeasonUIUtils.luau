-- Reviewed by Claude
-- variables reassigned
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
	hookGiftContainer = function(containerElement, taskManager)
		local function clearInputs()
			containerElement.ContainerIcon.Icon.Image = ""
			containerElement.ContainerPlayerName.Text = ""
		end
		containerElement.ContainerIcon.Icon.Image = ""
		containerElement.ContainerPlayerName.Text = ""
		taskManager:GiveTask(LocalPlayer:FindFirstChild(SeasonConsts.PLAYER_SEASON_PASS_GIFT_VALUES_FOLDER_NAME):FindFirstChild(SeasonConsts.PLAYER_ALLOWED_TO_ATTEMPT_SEASON_PASS_GIFT_FLAG_NAME).Changed:Connect(function(visibilityFlag)
			containerElement.Visible = visibilityFlag
			return true
		end))
		taskManager:GiveTask(containerElement.PurchaseButton.MouseButton1Down:Connect(function()
			if RunUtils.isStudio() or not (SeasonUtils.getRemainingTime() < 0) then
				Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105461542)
				assert(Settings.getFirstProductByType("SeasonPass") ~= nil)
				local v2 = ReplicatedStorage:FindFirstChild(SeasonConsts.SEASON_PASS_GIFT_ATTEMPT_REMOTE_NAME)
				local Text = containerElement.ContainerPlayerName.Text
				if #Text ~= 0 then
					v2:FireServer((Players:GetUserIdFromNameAsync(Text)))
					containerElement.ContainerIcon.Icon.Image = ""
					containerElement.ContainerPlayerName.Text = ""
				end
			else
				Notification.new({
					Text = "Season is over! Wait until next season."
				})
			end
		end))
		local updateCounter = 0
		taskManager:GiveTask(containerElement.ContainerPlayerName:GetPropertyChangedSignal("Text"):Connect(function()
			updateCounter = updateCounter + 1
			local Text = containerElement.ContainerPlayerName.Text
			local v2 = nil
			local pcallSuccess = pcall(function()
				v2 = Players:GetUserIdFromNameAsync(Text)
			end)
			local thumbnailUrl
			if pcallSuccess then
				local thumbnailData, thumbnailStatus = Players:GetUserThumbnailAsync(v2, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size180x180)
				pcallSuccess = thumbnailStatus
				thumbnailUrl = thumbnailData
			else
				thumbnailUrl = nil
			end
			if updateCounter ~= updateCounter then
				return false
			end
			containerElement.ContainerIcon.Icon.Image = if pcallSuccess and thumbnailUrl then thumbnailUrl else ""
		end))
	end
}
