local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local GameModeConsts = require(ReplicatedStorage.GameMode.GameModeConsts)
local Confirmation = require(ReplicatedStorage.Module.Confirmation)
return {
	init = function(p1) --[[ Name: init | Line: 10 | Upvalues: Binder (copy), Maid (copy), ReplicatedStorage (copy), GameModeConsts (copy), Players (copy), Audio (copy), Confirmation (copy) ]]
		local em = p1.em
		Binder.new("GameMode", function(p1) --[[ Line: 13 | Upvalues: Maid (ref) ]]
			local v1 = Maid.new()
			local v2 = p1.Name
			local v3 = script.Parent.Mode:FindFirstChild(v2)
			assert(v3 ~= nil, "No Client ModuleScript found for game mode " .. v2)
			require(v3).launch(v1, p1)
			return v1
		end):Start()
		local v1 = ReplicatedStorage:FindFirstChild(GameModeConsts.GAME_MODE_WINNER_REMOTE_NAME)
		if v1 then
			v1.OnClientEvent:Connect(function(p1, p2) --[[ Line: 27 | Upvalues: ReplicatedStorage (ref), Players (ref), Audio (ref), em (copy) ]]
				if p1 == "BattleRoyale" or p1 == "TankRoyale" then
					local v1 = ReplicatedStorage.GameMode.Res:FindFirstChild("BRGui"):Clone()
					v1.Parent = Players.LocalPlayer.PlayerGui
					v1.Enabled = true
					v1.Winner.Player.Text = string.upper(p2 or "Player")
					if p1 == "BattleRoyale" then
						v1.Winner.Title.Text = "JAILBREAK: BATTLE ROYALE"
					elseif p1 == "TankRoyale" then
						v1.Winner.Title.Text = "JAILBREAK: TANK ROYALE"
						v1.Winner.ImageLabel.ImageColor3 = Color3.fromRGB(78, 189, 72)
						v1.Winner.Player.TextColor3 = Color3.fromRGB(0, 255, 51)
						v1.Winner.Title.TextColor3 = Color3.fromRGB(0, 255, 51)
					end
					v1.Winner.Visible = true
					Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 2820822548)
					em.l2atqdos(5)
					task.wait(6)
					v1:Destroy()
				end
			end)
		end
		function em.a52k0ijd(p1, p2, p3) --[[ Line: 55 | Upvalues: Confirmation (ref) ]]
			local v1 = Confirmation.new(p1)
			v1.Maid:GiveTask(v1.OnYes:Connect(function() --[[ Line: 57 | Upvalues: p3 (copy) ]]
				print("YES")
				if p3 then
					p3:FireServer()
				end
			end))
			v1.Maid:GiveTask(function() --[[ Line: 63 ]]
				print("no close!")
			end)
			task.delay(p2, function() --[[ Line: 66 | Upvalues: v1 (copy) ]]
				v1:Destroy()
			end)
		end
	end
}