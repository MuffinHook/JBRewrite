local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TypeWriteLabel = require(ReplicatedStorage.Game.TypeWriteLabel)
local Audio = require(ReplicatedStorage.Std.Audio)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
require(ReplicatedStorage.Std.Signal)
local GlobalEventGui = ReplicatedStorage.App.Res:FindFirstChild("GlobalEventGui")
GlobalEventGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
local Bio = GlobalEventGui:WaitForChild("DialogueContainer"):WaitForChild("Bio")
local DialogueContainer = GlobalEventGui:FindFirstChild("DialogueContainer")
local Sound = Instance.new("Sound")
Sound.SoundId = "rbxassetid://215658476"
Sound.Parent = DialogueContainer
local function ThumbnailBust(userId)
	return ("https://www.roblox.com/bust-thumbnail/image?width=420&height=420&format=png&userId=%d"):format(userId)
end
local isEnabled = false
local configTable = {}
local function ProcessQueue()
	if #configTable > 0 then
		isEnabled = true
		local queuedEvent = table.remove(configTable, 1)
		GlobalEventGui.Enabled = true
		Hook(queuedEvent)
	else
		isEnabled = false
		GlobalEventGui.Enabled = false
	end
end
function Hook(eventData)
	Audio.ObjectLocal(GlobalEventGui, 4838933194, {
		Volume = 0.3,
		TimePosition = 0.15
	})
	DialogueContainer.Icon.Icon.Image = ("https://www.roblox.com/bust-thumbnail/image?width=420&height=420&format=png&userId=%d"):format(eventData.UserId)
	TypeWriteLabel(eventData.Text, Bio, 18, function(characterIndex)
		if characterIndex % 2 == 0 then
			Sound:Play()
		end
	end)
	task.wait(utf8.len(eventData.Text) / 18)
	task.wait(eventData.Duration)
	if #configTable > 0 then
		isEnabled = true
		local queuedEvent = table.remove(configTable, 1)
		GlobalEventGui.Enabled = true
		Hook(queuedEvent)
	else
		isEnabled = false
		GlobalEventGui.Enabled = false
	end
end
RxInstanceUtils.observeOneChildNamed(ReplicatedStorage, "GlobalEventRemote", function(globalEventRemote)
	globalEventRemote.OnClientEvent:Connect(function(userId, messageText, displayDuration)
		table.insert(configTable, {
			UserId = userId,
			Text = messageText,
			Duration = displayDuration
		})
		if isEnabled == false then
			if #configTable > 0 then
				isEnabled = true
				local queuedEvent = table.remove(configTable, 1)
				GlobalEventGui.Enabled = true
				Hook(queuedEvent)
				return
			end
			isEnabled = false
			GlobalEventGui.Enabled = false
		end
	end)
end)
