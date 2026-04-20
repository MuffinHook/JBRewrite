local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local Players_upvr = game:GetService("Players")
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local TradeConsts_upvr = require(ReplicatedStorage_upvr.Trade.TradeConsts)
local RunService_upvr = game:GetService("RunService")
local TradeDesireConsts_upvr = require(ReplicatedStorage_upvr.Trade.TradeDesireConsts)
function module.init() -- Line 9
    local function onCharacterAdded_upvr(arg1) -- Line 10, Named "onCharacterAdded"
        local any_GetPlayerFromCharacter_result1_upvr = Players_upvr:GetPlayerFromCharacter(arg1)
        local Head = arg1:WaitForChild("Head", 3)
        local any_new_result1_upvr_2 = Maid_upvr.new()
        local clone_upvr = ReplicatedStorage_upvr.Trade.Res.TradeDesireGui:Clone()
        clone_upvr.Parent = Players_upvr.LocalPlayer.PlayerGui
        clone_upvr.Adornee = Head
        clone_upvr.Enabled = true
        any_new_result1_upvr_2:GiveTask(clone_upvr)
        local any_new_result1_upvr = Maid_upvr.new()
        any_new_result1_upvr_2:GiveTask(any_new_result1_upvr)
        local function updateDesireText() -- Line 25
            any_new_result1_upvr:DoCleaning()
            local var18 = "TradeDesireText"
            local attribute_2 = arg1:GetAttribute(var18)
            if attribute_2 == nil then
                var18 = false
            else
                var18 = true
            end
            clone_upvr.Bar.Visible = var18
            var18 = false
            if attribute_2 == nil then
                if any_GetPlayerFromCharacter_result1_upvr ~= Players_upvr.LocalPlayer then
                    var18 = false
                else
                    var18 = true
                end
            end
            clone_upvr.Blank.Visible = var18
            if attribute_2 then
                clone_upvr.Bar.TextLabel.Text = attribute_2
                if any_GetPlayerFromCharacter_result1_upvr:GetAttribute(TradeConsts_upvr.TRADING_VIP_ATTRIBUTE_NAME) then
                    any_new_result1_upvr:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 34
                        clone_upvr.Bar.TextLabel.TextColor3 = Color3.fromHSV(os.clock() % TradeDesireConsts_upvr.RAINBOW_ANIMATION_CYCLE_TIME / TradeDesireConsts_upvr.RAINBOW_ANIMATION_CYCLE_TIME, 1, 1)
                    end))
                end
            end
        end
        updateDesireText()
        any_new_result1_upvr_2:GiveTask(arg1:GetAttributeChangedSignal("TradeDesireText"):Connect(updateDesireText))
        if any_GetPlayerFromCharacter_result1_upvr == Players_upvr.LocalPlayer then
            local clone_upvr_2 = ReplicatedStorage_upvr.Trade.Res.TradeDesireEditGui:Clone()
            clone_upvr_2.Parent = Players_upvr.LocalPlayer.PlayerGui
            clone_upvr_2.Enabled = false
            any_new_result1_upvr_2:GiveTask(clone_upvr_2)
            local TextBox_upvr = clone_upvr_2.Bar.TextBox
            any_new_result1_upvr_2:GiveTask(TextBox_upvr:GetPropertyChangedSignal("Text"):Connect(function() -- Line 53
                local Text = TextBox_upvr.Text
                if TradeDesireConsts_upvr.MAX_TEXT_LENGTH < #Text then
                    Text = Text:sub(1, TradeDesireConsts_upvr.MAX_TEXT_LENGTH)
                end
                TextBox_upvr.Text = Text
            end))
            any_new_result1_upvr_2:GiveTask(clone_upvr_2.Bar.Submit.MouseButton1Down:Connect(function() -- Line 60, Named "attemptSetDesire"
                clone_upvr_2.Enabled = false
                ReplicatedStorage_upvr:FindFirstChild("SetTradeDesireRemote"):FireServer(TextBox_upvr.Text)
            end))
            any_new_result1_upvr_2:GiveTask(clone_upvr_2.Bar.TextBox.FocusLost:Connect(function(arg1_2) -- Line 67
                if arg1_2 then
                    clone_upvr_2.Enabled = false
                    ReplicatedStorage_upvr:FindFirstChild("SetTradeDesireRemote"):FireServer(TextBox_upvr.Text)
                end
            end))
            local function toggleDesireEdit() -- Line 73
                clone_upvr_2.Enabled = not clone_upvr_2.Enabled
                if clone_upvr_2.Enabled then
                    clone_upvr_2.Bar.TextBox:CaptureFocus()
                end
            end
            any_new_result1_upvr_2:GiveTask(clone_upvr.Bar.MouseButton1Down:Connect(toggleDesireEdit))
            any_new_result1_upvr_2:GiveTask(clone_upvr.Blank.MouseButton1Down:Connect(toggleDesireEdit))
        end
        clone_upvr_2 = any_new_result1_upvr_2:GiveTask
        clone_upvr_2(Head.AncestryChanged:Connect(function(arg1_3, arg2) -- Line 83
            if not arg2 then
                any_new_result1_upvr_2:DoCleaning()
            end
        end))
    end
    for _, v in ipairs(Players_upvr:GetPlayers()) do
        if v.Character then
            task.spawn(onCharacterAdded_upvr, v.Character)
        end
        v.CharacterAdded:Connect(onCharacterAdded_upvr)
    end
    Players_upvr.PlayerAdded:Connect(function(arg1) -- Line 89, Named "onPlayerAdded"
        if arg1.Character then
            task.spawn(onCharacterAdded_upvr, arg1.Character)
        end
        arg1.CharacterAdded:Connect(onCharacterAdded_upvr)
    end)
end
return module