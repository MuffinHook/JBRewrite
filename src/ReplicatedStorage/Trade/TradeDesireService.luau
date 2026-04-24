-- Reviewed by Claude
-- variables reassigned
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local TradeDesireConsts = require(ReplicatedStorage.Trade.TradeDesireConsts)
local RunService = game:GetService("RunService")
local TradeConsts = require(ReplicatedStorage.Trade.TradeConsts)
return {
	init = function()
		local function onCharacterAdded(character)
			local player = Players:GetPlayerFromCharacter(character)
			local Head = character:WaitForChild("Head", 3)
			local characterMaid = Maid.new()
			local desireGui = ReplicatedStorage.Trade.Res.TradeDesireGui:Clone()
			desireGui.Parent = Players.LocalPlayer.PlayerGui
			desireGui.Adornee = Head
			desireGui.Enabled = true
			characterMaid:GiveTask(desireGui)
			local rainbowConnectionMaid = Maid.new()
			characterMaid:GiveTask(rainbowConnectionMaid)
			local function updateDesireText()
				rainbowConnectionMaid:DoCleaning()
				local desireText = character:GetAttribute("TradeDesireText")
				desireGui.Bar.Visible = desireText ~= nil
				desireGui.Blank.Visible = if desireText == nil then player == Players.LocalPlayer else false
				if desireText then
					desireGui.Bar.TextLabel.Text = desireText
					if player:GetAttribute(TradeConsts.TRADING_VIP_ATTRIBUTE_NAME) then
						rainbowConnectionMaid:GiveTask(RunService.Heartbeat:Connect(function()
							desireGui.Bar.TextLabel.TextColor3 = Color3.fromHSV(os.clock() % TradeDesireConsts.RAINBOW_ANIMATION_CYCLE_TIME / TradeDesireConsts.RAINBOW_ANIMATION_CYCLE_TIME, 1, 1)
						end))
					end
				end
			end
			updateDesireText()
			characterMaid:GiveTask(character:GetAttributeChangedSignal("TradeDesireText"):Connect(updateDesireText))
			if player == Players.LocalPlayer then
				local editGui = ReplicatedStorage.Trade.Res.TradeDesireEditGui:Clone()
				editGui.Parent = Players.LocalPlayer.PlayerGui
				editGui.Enabled = false
				characterMaid:GiveTask(editGui)
				local TextBox = editGui.Bar.TextBox
				characterMaid:GiveTask(TextBox:GetPropertyChangedSignal("Text"):Connect(function()
					local Text = TextBox.Text
					if #Text > TradeDesireConsts.MAX_TEXT_LENGTH then
						Text = Text:sub(1, TradeDesireConsts.MAX_TEXT_LENGTH)
					end
					TextBox.Text = Text
				end))
				local function attemptSetDesire()
					editGui.Enabled = false
					ReplicatedStorage:FindFirstChild("SetTradeDesireRemote"):FireServer(TextBox.Text)
				end
				characterMaid:GiveTask(editGui.Bar.Submit.MouseButton1Down:Connect(attemptSetDesire))
				characterMaid:GiveTask(editGui.Bar.TextBox.FocusLost:Connect(function(p1)
					if p1 then
						editGui.Enabled = false
						ReplicatedStorage:FindFirstChild("SetTradeDesireRemote"):FireServer(TextBox.Text)
					end
				end))
				local function toggleDesireEdit()
					editGui.Enabled = not editGui.Enabled
					if editGui.Enabled then
						editGui.Bar.TextBox:CaptureFocus()
					end
				end
				characterMaid:GiveTask(desireGui.Bar.MouseButton1Down:Connect(toggleDesireEdit))
				characterMaid:GiveTask(desireGui.Blank.MouseButton1Down:Connect(toggleDesireEdit))
			end
			characterMaid:GiveTask(Head.AncestryChanged:Connect(function(p1, p2)
				if not p2 then
					characterMaid:DoCleaning()
				end
			end))
		end
		local function onPlayerAdded(player)
			if player.Character then
				task.spawn(onCharacterAdded, player.Character)
			end
			player.CharacterAdded:Connect(onCharacterAdded)
		end
		for i, player in ipairs(Players:GetPlayers()) do
			if player.Character then
				task.spawn(onCharacterAdded, player.Character)
			end
			player.CharacterAdded:Connect(onCharacterAdded)
		end
		Players.PlayerAdded:Connect(onPlayerAdded)
	end
}
