local GuiService = game:GetService("GuiService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
game:GetService("TextChatService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local inputTypes = { Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.Touch }
local interface = {
	Valid = true,
	AutoComplete = nil,
	ProcessEntry = nil,
	OnTextChanged = nil,
	Cmdr = nil,
	HistoryState = nil
}
local cmdrFrame = LocalPlayer:WaitForChild("CmdrFrameValue").Value
local Line = cmdrFrame:WaitForChild("Line")
local Entry = cmdrFrame:WaitForChild("Entry")
Line.Parent = nil
function interface.UpdateLabel(cmdrInterface)
	Entry.TextLabel.Text = ("%*%*$"):format(LocalPlayer.Name, if cmdrInterface.Cmdr.PlaceName and cmdrInterface.Cmdr.PlaceName ~= "" then ("@%*"):format(cmdrInterface.Cmdr.PlaceName) else "")
end
function interface.GetLabel(cmdrInterface)
	return Entry.TextLabel.Text
end
function interface.UpdateWindowHeight(cmdrInterface)
	cmdrFrame.CanvasPosition = Vector2.new(0, (math.max(cmdrFrame.UIListLayout.AbsoluteContentSize.Y + 20 - cmdrFrame.AbsoluteWindowSize.Y, 0)))
end
function interface.AddLine(cmdrInterface, message, options)
	local colorOptions = options or {}
	local textString = tostring(message)
	local colorOptions = if typeof(colorOptions) == "Color3" then {
		Color = colorOptions
	} else colorOptions
	if #textString == 0 then
		interface:UpdateWindowHeight()
	else
		local formattedText = cmdrInterface.Cmdr.Util.EmulateTabstops(textString or "nil", 8)
		local lineClone = Line:Clone()
		lineClone.Text = formattedText
		lineClone.TextColor3 = colorOptions.Color or lineClone.TextColor3
		lineClone.RichText = colorOptions.RichText or false
		lineClone.TextWrapped = #textString < 150
		lineClone.Parent = cmdrFrame
	end
end
function interface.IsVisible(cmdrInterface)
	return cmdrFrame.Visible
end
local function SafeGetCore(coreKey)
	local success, result = pcall(function()
		return StarterGui:GetCore(coreKey)
	end)
	if success then
		return result
	else
		return true
	end
end
local function SafeSetCore(coreKey, coreValue)
	local _, _2 = pcall(function()
		return StarterGui:SetCore(coreKey, coreValue)
	end)
end
function interface.SetVisible(cmdrInterface, isVisible)
	cmdrFrame.Visible = isVisible
	if isVisible then
		local chatActiveKey = "ChatActive"
		local success, wasActive = pcall(function()
			return StarterGui:GetCore(chatActiveKey)
		end)
		cmdrInterface.PreviousChatActive = if success then wasActive else true
		local chatActiveKey2 = "ChatActive"
		local shouldDisableChat = false
		local _, _2 = pcall(function()
			return StarterGui:SetCore(chatActiveKey2, shouldDisableChat)
		end)
		Entry.TextBox:CaptureFocus()
		task.wait()
		cmdrInterface:SetEntryText("")
		if cmdrInterface.Cmdr.ActivationUnlocksMouse then
			cmdrInterface.PreviousMouseBehavior = UserInputService.MouseBehavior
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		end
	else
		local chatActiveKey3 = "ChatActive"
		local success, chatActiveState = pcall(function()
			return StarterGui:GetCore(chatActiveKey3)
		end)
		if not if success then chatActiveState else true then
			local PreviousChatActive = cmdrInterface.PreviousChatActive
			local chatActiveKey4 = "ChatActive"
			local _, _2 = pcall(function()
				return StarterGui:SetCore(chatActiveKey4, PreviousChatActive)
			end)
		end
		Entry.TextBox:ReleaseFocus()
		cmdrInterface.AutoComplete:Hide()
		if cmdrInterface.PreviousMouseBehavior then
			UserInputService.MouseBehavior = cmdrInterface.PreviousMouseBehavior
			cmdrInterface.PreviousMouseBehavior = nil
		end
	end
end
function interface.Hide(cmdrInterface)
	return cmdrInterface:SetVisible(false)
end
function interface.Show(cmdrInterface)
	return cmdrInterface:SetVisible(true)
end
function interface.SetEntryText(cmdrInterface, text)
	Entry.TextBox.Text = text
	if cmdrInterface:IsVisible() then
		Entry.TextBox:CaptureFocus()
		Entry.TextBox.CursorPosition = #text + 1
		interface:UpdateWindowHeight()
	end
end
function interface.GetEntryText(cmdrInterface)
	return Entry.TextBox.Text:gsub("\t", "")
end
function interface.SetIsValidInput(cmdrInterface, isValid, errorText)
	Entry.TextBox.TextColor3 = isValid and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 73, 73)
	cmdrInterface.Valid = isValid
	cmdrInterface._errorText = errorText
end
function interface.HideInvalidState(cmdrInterface)
	Entry.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
end
function interface.LoseFocus(cmdrInterface, focusState)
	local Text = Entry.TextBox.Text
	cmdrInterface:ClearHistoryState()
	if cmdrFrame.Visible and not (GuiService.MenuIsOpen or UserInputService.TouchEnabled) then
		Entry.TextBox:CaptureFocus()
	elseif GuiService.MenuIsOpen and cmdrFrame.Visible then
		cmdrInterface:Hide()
	end
	if focusState and cmdrInterface.Valid then
		task.wait()
		cmdrInterface:SetEntryText("")
		cmdrInterface.ProcessEntry(Text)
	elseif focusState then
		cmdrInterface:AddLine(cmdrInterface._errorText, Color3.fromRGB(255, 153, 153))
	end
end
function interface.TraverseHistory(cmdrInterface, direction)
	local history = cmdrInterface.Cmdr.Dispatcher:GetHistory()
	if cmdrInterface.HistoryState == nil then
		cmdrInterface.HistoryState = {
			Position = #history + 1,
			InitialText = cmdrInterface:GetEntryText()
		}
	end
	cmdrInterface.HistoryState.Position = math.clamp(cmdrInterface.HistoryState.Position + direction, 1, #history + 1)
	cmdrInterface:SetEntryText(cmdrInterface.HistoryState.Position == #history + 1 and cmdrInterface.HistoryState.InitialText or history[cmdrInterface.HistoryState.Position])
end
function interface.ClearHistoryState(cmdrInterface)
	cmdrInterface.HistoryState = nil
end
function interface.SelectVertical(cmdrInterface, direction)
	if cmdrInterface.AutoComplete:IsVisible() and not cmdrInterface.HistoryState then
		cmdrInterface.AutoComplete:Select(direction)
	else
		cmdrInterface:TraverseHistory(direction)
	end
end
local lastActivationTick = 0
local mashCount = 0
function interface.BeginInput(cmdrInterface, input, isGameProcessed)
	if GuiService.MenuIsOpen then
		cmdrInterface:Hide()
	end
	if not isGameProcessed or cmdrInterface:IsVisible() ~= false then
		if cmdrInterface.Cmdr.ActivationKeys[input.KeyCode] then
			if cmdrInterface.Cmdr.MashToEnable and not cmdrInterface.Cmdr.Enabled then
				if tick() - lastActivationTick < 1 then
					if mashCount >= 5 then
						return cmdrInterface.Cmdr:SetEnabled(true)
					end
					mashCount = mashCount + 1
				else
					mashCount = 1
				end
				lastActivationTick = tick()
			elseif cmdrInterface.Cmdr.Enabled then
				cmdrInterface:SetVisible(not cmdrInterface:IsVisible())
				task.wait()
				cmdrInterface:SetEntryText("")
				if GuiService.MenuIsOpen then
					cmdrInterface:Hide()
				end
			end
		elseif cmdrInterface.Cmdr.Enabled == false or not cmdrInterface:IsVisible() then
			if cmdrInterface:IsVisible() then
				cmdrInterface:Hide()
			end
		elseif cmdrInterface.Cmdr.HideOnLostFocus and table.find(inputTypes, input.UserInputType) then
			local Position = input.Position
			local AbsolutePosition = cmdrFrame.AbsolutePosition
			local AbsoluteSize = cmdrFrame.AbsoluteSize
			if Position.X < AbsolutePosition.X or (Position.X > AbsolutePosition.X + AbsoluteSize.X or (Position.Y < AbsolutePosition.Y or Position.Y > AbsolutePosition.Y + AbsoluteSize.Y)) then
				cmdrInterface:Hide()
			end
		elseif input.KeyCode == Enum.KeyCode.Down then
			cmdrInterface:SelectVertical(1)
		elseif input.KeyCode == Enum.KeyCode.Up then
			cmdrInterface:SelectVertical(-1)
		elseif input.KeyCode == Enum.KeyCode.Return then
			task.wait()
			cmdrInterface:SetEntryText(cmdrInterface:GetEntryText():gsub("\n", ""):gsub("\r", ""))
		elseif input.KeyCode == Enum.KeyCode.Tab then
			local selectedItem = cmdrInterface.AutoComplete:GetSelectedItem()
			local entryText = cmdrInterface:GetEntryText()
			if selectedItem and not (entryText:sub(#entryText, #entryText):match("%s") and cmdrInterface.AutoComplete.LastItem) then
				local itemName = selectedItem[2]
				local Command = cmdrInterface.AutoComplete.Command
				local commandText, needsSpace
				if Command then
					local Arg = cmdrInterface.AutoComplete.Arg
					commandText = Command.Alias
					local isPartial = if cmdrInterface.AutoComplete.NumArgs == #Command.ArgumentDefinitions then false else cmdrInterface.AutoComplete.IsPartial == false
					local Arguments = Command.Arguments
					needsSpace = isPartial
					for i = 1, #Arguments do
						local currentArg = Arguments[i]
						local RawSegments = currentArg.RawSegments
						if currentArg == Arg then
							RawSegments[#RawSegments] = itemName
						end
						local formattedArg = currentArg.Prefix .. table.concat(RawSegments, ",")
						if formattedArg:find(" ") or formattedArg == "" then
							formattedArg = ("%q"):format(formattedArg)
						end
						local commandWithArg = ("%s %s"):format(commandText, formattedArg)
						if currentArg == Arg then
							commandText = commandWithArg
							break
						end
						commandText = commandWithArg
					end
				else
					commandText = itemName
					needsSpace = true
				end
				task.wait()
				cmdrInterface:SetEntryText(commandText .. if needsSpace then " " else "")
			else
				task.wait()
				cmdrInterface:SetEntryText(cmdrInterface:GetEntryText())
			end
		else
			cmdrInterface:ClearHistoryState()
		end
	end
end
Entry.TextBox.FocusLost:Connect(function(focusState)
	return interface:LoseFocus(focusState)
end)
UserInputService.InputBegan:Connect(function(input, isGameProcessed)
	return interface:BeginInput(input, isGameProcessed)
end)
Entry.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
	cmdrFrame.CanvasPosition = Vector2.new(0, cmdrFrame.AbsoluteCanvasSize.Y)
	if Entry.TextBox.Text:match("\t") then
		Entry.TextBox.Text = Entry.TextBox.Text:gsub("\t", "")
	elseif interface.OnTextChanged then
		return interface.OnTextChanged(Entry.TextBox.Text)
	end
end)
cmdrFrame.ChildAdded:Connect(function()
	task.defer(interface.UpdateWindowHeight)
end)
return interface
