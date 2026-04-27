local LocalPlayer = game:GetService("Players").LocalPlayer
return function(utilities)
	local autocomplete = {
		Items = {},
		ItemOptions = {},
		SelectedItem = 0
	}
	local Util = utilities.Util
	local cmdrFrame = LocalPlayer:WaitForChild("CmdrFrameValue").Value
	local Autocomplete = LocalPlayer:WaitForChild("CmdrAutocompleteGuiValue").Value:WaitForChild("Autocomplete")
	local TextButton = Autocomplete:WaitForChild("TextButton")
	local Title = Autocomplete:WaitForChild("Title")
	local Description = Autocomplete:WaitForChild("Description")
	local Entry = cmdrFrame:WaitForChild("Entry")
	TextButton.Parent = nil
	local function SetText(container, textLabel, textContent, shouldResize)
		container.Visible = textContent ~= nil
		textLabel.Text = textContent or ""
		if shouldResize then
			textLabel.Size = UDim2.new(0, Util.GetTextSize(textContent or "", textLabel, Vector2.new(1000, 1000), 1, 0).X, container.Size.Y.Scale, container.Size.Y.Offset)
		end
	end
	local function UpdateContainerSize()
		Autocomplete.Size = UDim2.new(0, math.max(Title.Field.TextBounds.X + Title.Field.Type.TextBounds.X, Autocomplete.Size.X.Offset), 0, (math.min(Autocomplete.UIListLayout.AbsoluteContentSize.Y, Autocomplete.Parent.AbsoluteSize.Y - Autocomplete.AbsolutePosition.Y - 10)))
	end
	local function UpdateInfoDisplay(itemData)
		SetText(Title, Title.Field, itemData.name, true)
		local typeStr = itemData.type and ": " .. itemData.type:sub(1, 1):upper() .. itemData.type:sub(2)
		Title.Field.Type.Visible = typeStr ~= nil
		Title.Field.Type.Text = typeStr or ""
		local Label = Description.Label
		local description = itemData.description
		Description.Visible = description ~= nil
		Label.Text = description or ""
		Description.Label.TextColor3 = itemData.invalid and Color3.fromRGB(255, 73, 73) or Color3.fromRGB(255, 255, 255)
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
	function autocomplete.Show(self, itemsList, options)
		local options = options or {}
		for k, v in pairs(self.Items) do
			if v.gui then
				v.gui:Destroy()
			end
		end
		self.SelectedItem = 1
		self.Items = itemsList
		self.Prefix = options.prefix or ""
		self.LastItem = options.isLast or false
		self.Command = options.command
		self.Arg = options.arg
		self.NumArgs = options.numArgs
		self.IsPartial = options.isPartial
		local maxWidth = 200
		for k, v in pairs(self.Items) do
			local itemTransparency
			local itemName = v[1]
			local itemDesc = v[2]
			local itemButton = TextButton:Clone()
			itemButton.Name = itemName .. itemDesc
			itemTransparency = if k == self.SelectedItem then 0.5 else 1
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
		UpdateInfoDisplay(self.Items[1] and self.Items[1].options or options)
	end
	function autocomplete.GetSelectedItem(self)
		if Autocomplete.Visible == false then
			return nil
		else
			return autocomplete.Items[autocomplete.SelectedItem]
		end
	end
	function autocomplete.Hide(self)
		Autocomplete.Visible = false
	end
	function autocomplete.IsVisible(self)
		return Autocomplete.Visible
	end
	function autocomplete.Select(self, direction)
		if Autocomplete.Visible then
			self.SelectedItem = self.SelectedItem + direction
			if self.SelectedItem > #self.Items then
				self.SelectedItem = 1
			elseif self.SelectedItem < 1 then
				self.SelectedItem = #self.Items
			end
			for k, v in pairs(self.Items) do
				local itemTransparency
				itemTransparency = if k == self.SelectedItem then 0.5 else 1
				v.gui.BackgroundTransparency = itemTransparency
			end
			local Vec2New = Vector2.new
			Autocomplete.CanvasPosition = Vec2New(0, (math.max(0, Title.Size.Y.Offset + Description.Size.Y.Offset + self.SelectedItem * TextButton.Size.Y.Offset - Autocomplete.Size.Y.Offset)))
			if self.Items[self.SelectedItem] and self.Items[self.SelectedItem].options then
				UpdateInfoDisplay(self.Items[self.SelectedItem].options or {})
			end
		end
	end
	Autocomplete.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateContainerSize)
	return autocomplete
end
