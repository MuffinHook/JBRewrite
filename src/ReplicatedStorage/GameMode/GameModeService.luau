-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local GameModeConsts = require(ReplicatedStorage.GameMode.GameModeConsts)
local Confirmation = require(ReplicatedStorage.Module.Confirmation)
return {
	init = function(eventManager)
		local eventMgr = eventManager.eventMgr
		Binder.new("GameMode", function(gameModeInstance)
			local maid = Maid.new()
			local modeName = gameModeInstance.Name
			local modeModule = script.Parent.Mode:FindFirstChild(modeName)
			assert(modeModule ~= nil, "No Client ModuleScript found for game mode " .. modeName)
			require(modeModule).launch(maid, gameModeInstance)
			return maid
		end):Start()
		local winnerRemote = ReplicatedStorage:FindFirstChild(GameModeConsts.GAME_MODE_WINNER_REMOTE_NAME)
		if winnerRemote then
			winnerRemote.OnClientEvent:Connect(function(gameModeName, winnerPlayerName)
				if gameModeName == "BattleRoyale" or gameModeName == "TankRoyale" then
					local winnerGui = ReplicatedStorage.GameMode.Res:FindFirstChild("BRGui"):Clone()
					winnerGui.Parent = Players.LocalPlayer.PlayerGui
					winnerGui.Enabled = true
					winnerGui.Winner.Player.Text = string.upper(winnerPlayerName or "Player")
					if gameModeName == "BattleRoyale" then
						winnerGui.Winner.Title.Text = "JAILBREAK: BATTLE ROYALE"
					elseif gameModeName == "TankRoyale" then
						winnerGui.Winner.Title.Text = "JAILBREAK: TANK ROYALE"
						winnerGui.Winner.ImageLabel.ImageColor3 = Color3.fromRGB(78, 189, 72)
						winnerGui.Winner.Player.TextColor3 = Color3.fromRGB(0, 255, 51)
						winnerGui.Winner.Title.TextColor3 = Color3.fromRGB(0, 255, 51)
					end
					winnerGui.Winner.Visible = true
					Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 2820822548)
					eventMgr.playVictorySound(5)
					task.wait(6)
					winnerGui:Destroy()
				end
			end)
		end
		function eventMgr.showConfirmation(prompt, delaySeconds, remoteToFire)
			local confirmation = Confirmation.new(prompt)
			confirmation.Maid:GiveTask(confirmation.OnYes:Connect(function()
				print("YES")
				if remoteToFire then
					remoteToFire:FireServer()
				end
			end))
			confirmation.Maid:GiveTask(function()
				print("no close!")
			end)
			task.delay(delaySeconds, function()
				confirmation:Destroy()
			end)
		end
	end
}
