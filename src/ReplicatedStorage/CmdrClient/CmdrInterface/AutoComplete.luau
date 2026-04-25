-- Reviewed by Claude
-- variables reassigned
local LocalPlayer = game:GetService("Players").LocalPlayer
return function(p1)
	local autocomplete = {
		Items = {},
		ItemOptions = {},
		SelectedItem = 0
	}
	local Util = p1.Util
	local cmdrFrame = LocalPlayer:WaitForChild("CmdrFrameValue").Value
	local Autocomplete = LocalPlayer:WaitForChild("CmdrAutocompleteGuiValue").Value:WaitForChild("Autocomplete")
	local TextButton = Autocomplete:WaitForChild("TextButton")
	local Title = Autocomplete:WaitForChild("Title")
	local Description = Autocomplete:WaitForChild("Description")
	local Entry = cmdrFrame:WaitForChild("Entry")
	TextButton.Parent = nil
	local function SetText(p1, p2, p3, p4)
		p1.Visible = p3 ~= nil
		p2.Text = p3 or ""
		if p4 then
			p2.Size = UDim2.new(0, Util.GetTextSize(p3 or "", p2, Vector2.new(1000, 1000), 1, 0).X, p1.Size.Y.Scale, p1.Size.Y.Offset)
		end
	end
	local function UpdateContainerSize()
		Autocomplete.Size = UDim2.new(0, math.max(Title.Field.TextBounds.X + Title.Field.Type.TextBounds.X, Autocomplete.Size.X.Offset), 0, (math.min(Autocomplete.UIListLayout.AbsoluteContentSize.Y, Autocomplete.Parent.AbsoluteSize.Y - Autocomplete.AbsolutePosition.Y - 10)))
	end
	local function UpdateInfoDisplay(p1)
		SetText(Title, Title.Field, p1.name, true)
		local typeStr = p1.type and ": " .. p1.type:sub(1, 1):upper() .. p1.type:sub(2)
		Title.Field.Type.Visible = typeStr ~= nil
		Title.Field.Type.Text = typeStr or ""
		local Label = Description.Label
		local description = p1.description
		Description.Visible = description ~= nil
		Label.Text = description or ""
		Description.Label.TextColor3 = p1.invalid and Color3.fromRGB(255, 73, 73) or Color3.fromRGB(255, 255, 255)
		Description.Size = UDim2.new(1, 0, 0, 40)
		while not Description.Label.TextFits do
			Description.Size = Description.Size + UDim2.new(0, 0, 0, 2)
			if Description.Size.Y.Offset > 500 then
				break
			end
		end
		task.wait()
		Autocomplete.UIListLayout:ApplyLayout()
		UpdateContainerSize()
	end
	function autocomplete.Show(p1, p2, p3)
		local options = p3 or {}
		for k, v in pairs(p1.Items) do
			if v.gui then
				v.gui:Destroy()
			end
		end
		p1.SelectedItem = 1
		p1.Items = p2
		p1.Prefix = options.prefix or ""
		p1.LastItem = options.isLast or false
		p1.Command = options.command
		p1.Arg = options.arg
		p1.NumArgs = options.numArgs
		p1.IsPartial = options.isPartial
		local maxWidth = 200
		for k, v in pairs(p1.Items) do
			local itemTransparency
			local itemName = v[1]
			local itemDesc = v[2]
			local itemButton = TextButton:Clone()
			itemButton.Name = itemName .. itemDesc
			itemTransparency = if k == p1.SelectedItem then 0.5 else 1
			itemButton.BackgroundTransparency = itemTransparency
			local startIdx, endIdx = string.find(itemDesc:lower(), itemName:lower(), 1, true)
			if startIdx == nil and endIdx == nil then
				startIdx, endIdx = 1, string.len(itemDesc)
			end
			itemButton.Typed.Text = string.rep(" ", startIdx - 1) .. itemName
			itemButton.Suggest.Text = string.sub(itemDesc, 0, startIdx - 1) .. string.rep(" ", #itemName) .. string.sub(itemDesc, endIdx + 1)
			itemButton.Parent = Autocomplete
			itemButton.LayoutOrder = k
			local itemWidth = math.max(itemButton.Typed.TextBounds.X, itemButton.Suggest.TextBounds.X) + 20
			if maxWidth < itemWidth then
				maxWidth = itemWidth
			end
			v.gui = itemButton
		end
		Autocomplete.UIListLayout:ApplyLayout()
		local Text = Entry.TextBox.Text
		local textParts = Util.SplitString(Text)
		if Text:sub(#Text, #Text) == " " and not options.at then
			textParts[#textParts + 1] = "e"
		end
		table.remove(textParts, #textParts)
		local cursorPos = options.at and options.at or #table.concat(textParts, " ") + 1
		Autocomplete.Position = UDim2.new(0, Entry.TextBox.AbsolutePosition.X - 10 + cursorPos * 7, 0, Entry.TextBox.AbsolutePosition.Y + 30) - UDim2.new(0, Autocomplete.Parent.AbsolutePosition.X, 0, Autocomplete.Parent.AbsolutePosition.Y)
		Autocomplete.Size = UDim2.new(0, maxWidth, 0, Autocomplete.UIListLayout.AbsoluteContentSize.Y)
		Autocomplete.Visible = true
		UpdateInfoDisplay(p1.Items[1] and p1.Items[1].options or options)
	end
	function autocomplete.GetSelectedItem(p1)
		if Autocomplete.Visible == false then
			return nil
		else
			return autocomplete.Items[autocomplete.SelectedItem]
		end
	end
	function autocomplete.Hide(p1)
		Autocomplete.Visible = false
	end
	function autocomplete.IsVisible(p1)
		return Autocomplete.Visible
	end
	function autocomplete.Select(p1, p2)
		if Autocomplete.Visible then
			p1.SelectedItem = p1.SelectedItem + p2
			if p1.SelectedItem > #p1.Items then
				p1.SelectedItem = 1
			elseif p1.SelectedItem < 1 then
				p1.SelectedItem = #p1.Items
			end
			for k, v in pairs(p1.Items) do
				local itemTransparency
				itemTransparency = if k == p1.SelectedItem then 0.5 else 1
				v.gui.BackgroundTransparency = itemTransparency
			end
			local Vec2New = Vector2.new
			Autocomplete.CanvasPosition = Vec2New(0, (math.max(0, Title.Size.Y.Offset + Description.Size.Y.Offset + p1.SelectedItem * TextButton.Size.Y.Offset - Autocomplete.Size.Y.Offset)))
			if p1.Items[p1.SelectedItem] and p1.Items[p1.SelectedItem].options then
				UpdateInfoDisplay(p1.Items[p1.SelectedItem].options or {})
			end
		end
	end
	Autocomplete.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateContainerSize)
	return autocomplete
end
