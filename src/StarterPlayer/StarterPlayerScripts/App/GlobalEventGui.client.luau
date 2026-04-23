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
local function ThumbnailBust(p1) --[[ Line: 21 ]]
	return ("https://www.roblox.com/bust-thumbnail/image?width=420&height=420&format=png&userId=%d"):format(p1)
end
local v1 = false
local t = {}
local function ProcessQueue() --[[ Line: 27 | Upvalues: t (copy), v1 (ref), GlobalEventGui (copy) ]]
	if #t > 0 then
		v1 = true
		local v12 = table.remove(t, 1)
		GlobalEventGui.Enabled = true
		Hook(v12)
	else
		v1 = false
		GlobalEventGui.Enabled = false
	end
end
function Hook(p1) --[[ Line: 39 | Upvalues: Audio (copy), GlobalEventGui (copy), DialogueContainer (copy), TypeWriteLabel (copy), Bio (copy), Sound (copy), t (copy), v1 (ref) ]]
	Audio.ObjectLocal(GlobalEventGui, 4838933194, {
		Volume = 0.3,
		TimePosition = 0.15
	})
	DialogueContainer.Icon.Icon.Image = ("https://www.roblox.com/bust-thumbnail/image?width=420&height=420&format=png&userId=%d"):format(p1.UserId)
	TypeWriteLabel(p1.Text, Bio, 18, function(p1) --[[ Line: 43 | Upvalues: Sound (ref) ]]
		if p1 % 2 == 0 then
			Sound:Play()
		end
	end)
	task.wait(utf8.len(p1.Text) / 18)
	task.wait(p1.Duration)
	if #t > 0 then
		v1 = true
		local v12 = table.remove(t, 1)
		GlobalEventGui.Enabled = true
		Hook(v12)
	else
		v1 = false
		GlobalEventGui.Enabled = false
	end
end
RxInstanceUtils.observeOneChildNamed(ReplicatedStorage, "GlobalEventRemote", function(p1) --[[ Line: 53 | Upvalues: t (copy), v1 (ref), GlobalEventGui (copy) ]]
	p1.OnClientEvent:Connect(function(p1, p2, p3) --[[ Line: 54 | Upvalues: t (ref), v1 (ref), GlobalEventGui (ref) ]]
		table.insert(t, {
			UserId = p1,
			Text = p2,
			Duration = p3
		})
		if v1 == false then
			if #t > 0 then
				v1 = true
				local v2 = table.remove(t, 1)
				GlobalEventGui.Enabled = true
				Hook(v2)
				return
			end
			v1 = false
			GlobalEventGui.Enabled = false
		end
	end)
end)