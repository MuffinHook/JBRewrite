-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local CameraBinder = require(script.Parent.CameraBinder)
local CCTVService = {
	onRequestPrompt = Signal.new()
}
function CCTVService.init()
	CameraBinder:Start()
	Binder.new("CCTVPrompt", function(promptPart)
		local promptMaid = Maid.new()
		CircleAction.Add({
			Part = promptPart,
			Name = "Open Security Cameras",
			Timed = false,
			Dist = 8,
			Callback = function(player, isCompleted)
				if isCompleted then
					CCTVService.onRequestPrompt:Fire()
				end
				return true
			end
		}, promptPart)
		promptMaid:GiveTask(function()
			CircleAction.Remove(promptPart)
		end)
		return promptMaid
	end):Start()
end
return CCTVService
