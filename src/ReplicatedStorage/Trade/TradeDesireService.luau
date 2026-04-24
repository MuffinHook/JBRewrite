-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local TradeDesireConsts = require(ReplicatedStorage.Trade.TradeDesireConsts)
local RunService = game:GetService("RunService")
local TradeConsts = require(ReplicatedStorage.Trade.TradeConsts)
return {
	init = function()
		local function onCharacterAdded(p1)
			local v1 = Players:GetPlayerFromCharacter(p1)
			local Head = p1:WaitForChild("Head", 3)
			local v2 = Maid.new()
			local v3 = ReplicatedStorage.Trade.Res.TradeDesireGui:Clone()
			v3.Parent = Players.LocalPlayer.PlayerGui
			v3.Adornee = Head
			v3.Enabled = true
			v2:GiveTask(v3)
			local v4 = Maid.new()
			v2:GiveTask(v4)
			local function updateDesireText()
				v4:DoCleaning()
				local v12 = p1:GetAttribute("TradeDesireText")
				v3.Bar.Visible = v12 ~= nil
				v3.Blank.Visible = if v12 == nil then v1 == Players.LocalPlayer else false
				if v12 then
					v3.Bar.TextLabel.Text = v12
					if v1:GetAttribute(TradeConsts.TRADING_VIP_ATTRIBUTE_NAME) then
						v4:GiveTask(RunService.Heartbeat:Connect(function()
							v3.Bar.TextLabel.TextColor3 = Color3.fromHSV(os.clock() % TradeDesireConsts.RAINBOW_ANIMATION_CYCLE_TIME / TradeDesireConsts.RAINBOW_ANIMATION_CYCLE_TIME, 1, 1)
						end))
					end
				end
			end
			updateDesireText()
			v2:GiveTask(p1:GetAttributeChangedSignal("TradeDesireText"):Connect(updateDesireText))
			if v1 == Players.LocalPlayer then
				local v5 = ReplicatedStorage.Trade.Res.TradeDesireEditGui:Clone()
				v5.Parent = Players.LocalPlayer.PlayerGui
				v5.Enabled = false
				v2:GiveTask(v5)
				local TextBox = v5.Bar.TextBox
				v2:GiveTask(TextBox:GetPropertyChangedSignal("Text"):Connect(function()
					local Text = TextBox.Text
					if #Text > TradeDesireConsts.MAX_TEXT_LENGTH then
						Text = Text:sub(1, TradeDesireConsts.MAX_TEXT_LENGTH)
					end
					TextBox.Text = Text
				end))
				local function attemptSetDesire()
					v5.Enabled = false
					ReplicatedStorage:FindFirstChild("SetTradeDesireRemote"):FireServer(TextBox.Text)
				end
				v2:GiveTask(v5.Bar.Submit.MouseButton1Down:Connect(attemptSetDesire))
				v2:GiveTask(v5.Bar.TextBox.FocusLost:Connect(function(p1)
					if p1 then
						v5.Enabled = false
						ReplicatedStorage:FindFirstChild("SetTradeDesireRemote"):FireServer(TextBox.Text)
					end
				end))
				local function toggleDesireEdit()
					v5.Enabled = not v5.Enabled
					if v5.Enabled then
						v5.Bar.TextBox:CaptureFocus()
					end
				end
				v2:GiveTask(v3.Bar.MouseButton1Down:Connect(toggleDesireEdit))
				v2:GiveTask(v3.Blank.MouseButton1Down:Connect(toggleDesireEdit))
			end
			v2:GiveTask(Head.AncestryChanged:Connect(function(p1, p2)
				if not p2 then
					v2:DoCleaning()
				end
			end))
		end
		local function onPlayerAdded(p1)
			if p1.Character then
				task.spawn(onCharacterAdded, p1.Character)
			end
			p1.CharacterAdded:Connect(onCharacterAdded)
		end
		for i, v in ipairs(Players:GetPlayers()) do
			if v.Character then
				task.spawn(onCharacterAdded, v.Character)
			end
			v.CharacterAdded:Connect(onCharacterAdded)
		end
		Players.PlayerAdded:Connect(onPlayerAdded)
	end
}
