local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local Binder_upvr = require(ReplicatedStorage_upvr.Std.Binder)
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local GameModeConsts_upvr = require(ReplicatedStorage_upvr.GameMode.GameModeConsts)
local Players_upvr = game:GetService("Players")
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local Confirmation_upvr = require(ReplicatedStorage_upvr.Module.Confirmation)
function module.init(arg1) -- Line 10
    local em_upvr = arg1.em
    Binder_upvr.new("GameMode", function(arg1_2) -- Line 13
        local any_new_result1 = Maid_upvr.new()
        local Name = arg1_2.Name
        local var13 = Name
        local SOME_2 = script.Parent.Mode:FindFirstChild(var13)
        if SOME_2 == nil then
            var13 = false
        else
            var13 = true
        end
        assert(var13, "No Client ModuleScript found for game mode "..Name)
        require(SOME_2).launch(any_new_result1, arg1_2)
        return any_new_result1
    end):Start()
    local SOME = ReplicatedStorage_upvr:FindFirstChild(GameModeConsts_upvr.GAME_MODE_WINNER_REMOTE_NAME)
    if SOME then
        SOME.OnClientEvent:Connect(function(arg1_3, arg2) -- Line 27
            if arg1_3 == "BattleRoyale" or arg1_3 == "TankRoyale" then
                local clone = ReplicatedStorage_upvr.GameMode.Res:FindFirstChild("BRGui"):Clone()
                clone.Parent = Players_upvr.LocalPlayer.PlayerGui
                clone.Enabled = true
                clone.Winner.Player.Text = string.upper(arg2 or "Player")
                if arg1_3 == "BattleRoyale" then
                    clone.Winner.Title.Text = "JAILBREAK: BATTLE ROYALE"
                elseif arg1_3 == "TankRoyale" then
                    clone.Winner.Title.Text = "JAILBREAK: TANK ROYALE"
                    clone.Winner.ImageLabel.ImageColor3 = Color3.fromRGB(78, 189, 72)
                    clone.Winner.Player.TextColor3 = Color3.fromRGB(0, 255, 51)
                    clone.Winner.Title.TextColor3 = Color3.fromRGB(0, 255, 51)
                end
                clone.Winner.Visible = true
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 2820822548)
                em_upvr.at2y4lws(5)
                task.wait(6)
                clone:Destroy()
            end
        end)
    end
    function em_upvr.bmgqmlak(arg1_4, arg2, arg3) -- Line 55
        local any_new_result1_2_upvr = Confirmation_upvr.new(arg1_4)
        any_new_result1_2_upvr.Maid:GiveTask(any_new_result1_2_upvr.OnYes:Connect(function() -- Line 57
            print("YES")
            if arg3 then
                arg3:FireServer()
            end
        end))
        any_new_result1_2_upvr.Maid:GiveTask(function() -- Line 63
            print("no close!")
        end)
        task.delay(arg2, function() -- Line 66
            any_new_result1_2_upvr:Destroy()
        end)
    end
end
return module