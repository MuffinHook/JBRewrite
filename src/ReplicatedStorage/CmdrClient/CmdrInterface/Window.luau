local GuiService = game:GetService("GuiService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
game:GetService("TextChatService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local t = { Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.Touch }
local t2 = {
	Valid = true,
	AutoComplete = nil,
	ProcessEntry = nil,
	OnTextChanged = nil,
	Cmdr = nil,
	HistoryState = nil
}
local v1 = LocalPlayer:WaitForChild("CmdrFrameValue").Value
local Line = v1:WaitForChild("Line")
local Entry = v1:WaitForChild("Entry")
Line.Parent = nil
function t2.UpdateLabel(p1) --[[ Line: 29 | Upvalues: Entry (copy), LocalPlayer (copy) ]]
	Entry.TextLabel.Text = ("%*%*$"):format(LocalPlayer.Name, if p1.Cmdr.PlaceName and p1.Cmdr.PlaceName ~= "" then ("@%*"):format(p1.Cmdr.PlaceName) else "")
end
function t2.GetLabel(p1) --[[ Line: 35 | Upvalues: Entry (copy) ]]
	return Entry.TextLabel.Text
end
function t2.UpdateWindowHeight(p1) --[[ Line: 40 | Upvalues: v1 (copy) ]]
	v1.CanvasPosition = Vector2.new(0, (math.max(v1.UIListLayout.AbsoluteContentSize.Y + 20 - v1.AbsoluteWindowSize.Y, 0)))
end
function t2.AddLine(p1, p2, p3) --[[ Line: 48 | Upvalues: t2 (copy), Line (copy), v1 (copy) ]]
	local v12 = p3 or {}
	local v2 = tostring(p2)
	local v3 = if typeof(v12) == "Color3" then {
	Color = v12
} else v12
	if #v2 == 0 then
		t2:UpdateWindowHeight()
	else
		local v4 = p1.Cmdr.Util.EmulateTabstops(v2 or "nil", 8)
		local v5 = Line:Clone()
		v5.Text = v4
		v5.TextColor3 = v3.Color or v5.TextColor3
		v5.RichText = v3.RichText or false
		v5.TextWrapped = #v2 < 150
		v5.Parent = v1
	end
end
function t2.IsVisible(p1) --[[ Line: 72 | Upvalues: v1 (copy) ]]
	return v1.Visible
end
local function SafeGetCore(p1) --[[ Line: 78 | Upvalues: StarterGui (copy) ]]
	local v1, v2 = pcall(function() --[[ Line: 79 | Upvalues: StarterGui (ref), p1 (copy) ]]
		return StarterGui:GetCore(p1)
	end)
	if v1 then
		return v2
	else
		return true
	end
end
local function SafeSetCore(p1, p2) --[[ Line: 84 | Upvalues: StarterGui (copy) ]]
	local _, _2 = pcall(function() --[[ Line: 85 | Upvalues: StarterGui (ref), p1 (copy), p2 (copy) ]]
		return StarterGui:SetCore(p1, p2)
	end)
end
function t2.SetVisible(p1, p2) --[[ Line: 90 | Upvalues: v1 (copy), StarterGui (copy), Entry (copy), UserInputService (copy) ]]
	v1.Visible = p2
	if p2 then
		local v12 = "ChatActive"
		local v2, v3 = pcall(function() --[[ Line: 79 | Upvalues: StarterGui (ref), v12 (copy) ]]
			return StarterGui:GetCore(v12)
		end)
		p1.PreviousChatActive = if v2 then v3 else true
		local v5 = "ChatActive"
		local v6 = false
		local _, _2 = pcall(function() --[[ Line: 85 | Upvalues: StarterGui (ref), v5 (copy), v6 (copy) ]]
			return StarterGui:SetCore(v5, v6)
		end)
		Entry.TextBox:CaptureFocus()
		task.wait()
		p1:SetEntryText("")
		if p1.Cmdr.ActivationUnlocksMouse then
			p1.PreviousMouseBehavior = UserInputService.MouseBehavior
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		end
	else
		local v7 = "ChatActive"
		local v8, v9 = pcall(function() --[[ Line: 79 | Upvalues: StarterGui (ref), v7 (copy) ]]
			return StarterGui:GetCore(v7)
		end)
		if not if v8 then v9 else true then
			local PreviousChatActive = p1.PreviousChatActive
			local v11 = "ChatActive"
			local _, _2 = pcall(function() --[[ Line: 85 | Upvalues: StarterGui (ref), v11 (copy), PreviousChatActive (copy) ]]
				return StarterGui:SetCore(v11, PreviousChatActive)
			end)
		end
		Entry.TextBox:ReleaseFocus()
		p1.AutoComplete:Hide()
		if p1.PreviousMouseBehavior then
			UserInputService.MouseBehavior = p1.PreviousMouseBehavior
			p1.PreviousMouseBehavior = nil
		end
	end
end
function t2.Hide(p1) --[[ Line: 121 ]]
	return p1:SetVisible(false)
end
function t2.Show(p1) --[[ Line: 126 ]]
	return p1:SetVisible(true)
end
function t2.SetEntryText(p1, p2) --[[ Line: 131 | Upvalues: Entry (copy), t2 (copy) ]]
	Entry.TextBox.Text = p2
	if p1:IsVisible() then
		Entry.TextBox:CaptureFocus()
		Entry.TextBox.CursorPosition = #p2 + 1
		t2:UpdateWindowHeight()
	end
end
function t2.GetEntryText(p1) --[[ Line: 142 | Upvalues: Entry (copy) ]]
	return Entry.TextBox.Text:gsub("\t", "")
end
function t2.SetIsValidInput(p1, p2, p3) --[[ Line: 148 | Upvalues: Entry (copy) ]]
	Entry.TextBox.TextColor3 = p2 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 73, 73)
	p1.Valid = p2
	p1._errorText = p3
end
function t2.HideInvalidState(p1) --[[ Line: 154 | Upvalues: Entry (copy) ]]
	Entry.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
end
function t2.LoseFocus(p1, p2) --[[ Line: 159 | Upvalues: Entry (copy), v1 (copy), GuiService (copy), UserInputService (copy) ]]
	local Text = Entry.TextBox.Text
	p1:ClearHistoryState()
	if v1.Visible and not (GuiService.MenuIsOpen or UserInputService.TouchEnabled) then
		Entry.TextBox:CaptureFocus()
	elseif GuiService.MenuIsOpen and v1.Visible then
		p1:Hide()
	end
	if p2 and p1.Valid then
		wait()
		p1:SetEntryText("")
		p1.ProcessEntry(Text)
	elseif p2 then
		p1:AddLine(p1._errorText, Color3.fromRGB(255, 153, 153))
	end
end
function t2.TraverseHistory(p1, p2) --[[ Line: 180 ]]
	local v1 = p1.Cmdr.Dispatcher:GetHistory()
	if p1.HistoryState == nil then
		p1.HistoryState = {
			Position = #v1 + 1,
			InitialText = p1:GetEntryText()
		}
	end
	p1.HistoryState.Position = math.clamp(p1.HistoryState.Position + p2, 1, #v1 + 1)
	p1:SetEntryText(p1.HistoryState.Position == #v1 + 1 and p1.HistoryState.InitialText or v1[p1.HistoryState.Position])
end
function t2.ClearHistoryState(p1) --[[ Line: 198 ]]
	p1.HistoryState = nil
end
function t2.SelectVertical(p1, p2) --[[ Line: 202 ]]
	if p1.AutoComplete:IsVisible() and not p1.HistoryState then
		p1.AutoComplete:Select(p2)
	else
		p1:TraverseHistory(p2)
	end
end
local v2 = 0
local v3 = 0
function t2.BeginInput(p1, p2, p3) --[[ Line: 213 | Upvalues: GuiService (copy), v2 (ref), v3 (ref), t (copy), v1 (copy) ]]
	if GuiService.MenuIsOpen then
		p1:Hide()
	end
	if not p3 or p1:IsVisible() ~= false then
		if p1.Cmdr.ActivationKeys[p2.KeyCode] then
			if p1.Cmdr.MashToEnable and not p1.Cmdr.Enabled then
				if tick() - v2 < 1 then
					if v3 >= 5 then
						return p1.Cmdr:SetEnabled(true)
					end
					v3 = v3 + 1
				else
					v3 = 1
				end
				v2 = tick()
			elseif p1.Cmdr.Enabled then
				p1:SetVisible(not p1:IsVisible())
				wait()
				p1:SetEntryText("")
				if GuiService.MenuIsOpen then
					p1:Hide()
				end
			end
		elseif p1.Cmdr.Enabled == false or not p1:IsVisible() then
			if p1:IsVisible() then
				p1:Hide()
			end
		elseif p1.Cmdr.HideOnLostFocus and table.find(t, p2.UserInputType) then
			local Position = p2.Position
			local AbsolutePosition = v1.AbsolutePosition
			local AbsoluteSize = v1.AbsoluteSize
			if Position.X < AbsolutePosition.X or (Position.X > AbsolutePosition.X + AbsoluteSize.X or (Position.Y < AbsolutePosition.Y or Position.Y > AbsolutePosition.Y + AbsoluteSize.Y)) then
				p1:Hide()
			end
		elseif p2.KeyCode == Enum.KeyCode.Down then
			p1:SelectVertical(1)
		elseif p2.KeyCode == Enum.KeyCode.Up then
			p1:SelectVertical(-1)
		elseif p2.KeyCode == Enum.KeyCode.Return then
			wait()
			p1:SetEntryText(p1:GetEntryText():gsub("\n", ""):gsub("\r", ""))
		elseif p2.KeyCode == Enum.KeyCode.Tab then
			local v12 = p1.AutoComplete:GetSelectedItem()
			local v22 = p1:GetEntryText()
			if v12 and not (v22:sub(#v22, #v22):match("%s") and p1.AutoComplete.LastItem) then
				local v32 = v12[2]
				local Command = p1.AutoComplete.Command
				local v4, v5
				if Command then
					local Arg = p1.AutoComplete.Arg
					v4 = Command.Alias
					local v6 = if p1.AutoComplete.NumArgs == #Command.ArgumentDefinitions then false else p1.AutoComplete.IsPartial == false
					local Arguments = Command.Arguments
					v5 = v6
					for i = 1, #Arguments do
						local v7 = Arguments[i]
						local RawSegments = v7.RawSegments
						if v7 == Arg then
							RawSegments[#RawSegments] = v32
						end
						local v8 = v7.Prefix .. table.concat(RawSegments, ",")
						if v8:find(" ") or v8 == "" then
							v8 = ("%q"):format(v8)
						end
						local v10 = ("%s %s"):format(v4, v8)
						if v7 == Arg then
							v4 = v10
							break
						end
						v4 = v10
					end
				else
					v4 = v32
					v5 = true
				end
				wait()
				p1:SetEntryText(v4 .. if v5 then " " else "")
			else
				wait()
				p1:SetEntryText(p1:GetEntryText())
			end
		else
			p1:ClearHistoryState()
		end
	end
end
Entry.TextBox.FocusLost:Connect(function(p1) --[[ Line: 324 | Upvalues: t2 (copy) ]]
	return t2:LoseFocus(p1)
end)
UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 328 | Upvalues: t2 (copy) ]]
	return t2:BeginInput(p1, p2)
end)
Entry.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 332 | Upvalues: v1 (copy), Entry (copy), t2 (copy) ]]
	v1.CanvasPosition = Vector2.new(0, v1.AbsoluteCanvasSize.Y)
	if Entry.TextBox.Text:match("\t") then
		Entry.TextBox.Text = Entry.TextBox.Text:gsub("\t", "")
	elseif t2.OnTextChanged then
		return t2.OnTextChanged(Entry.TextBox.Text)
	end
end)
v1.ChildAdded:Connect(function() --[[ Line: 344 | Upvalues: t2 (copy) ]]
	task.defer(t2.UpdateWindowHeight)
end)
return t2