-- Reviewed by Claude
local LocalPlayer = game:GetService("Players").LocalPlayer
return function(p1)
	local t = {
		Items = {},
		ItemOptions = {},
		SelectedItem = 0
	}
	local Util = p1.Util
	local v1 = LocalPlayer:WaitForChild("CmdrFrameValue").Value
	local Autocomplete = LocalPlayer:WaitForChild("CmdrAutocompleteGuiValue").Value:WaitForChild("Autocomplete")
	local TextButton = Autocomplete:WaitForChild("TextButton")
	local Title = Autocomplete:WaitForChild("Title")
	local Description = Autocomplete:WaitForChild("Description")
	local Entry = v1:WaitForChild("Entry")
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
		local v1 = p1.type and ": " .. p1.type:sub(1, 1):upper() .. p1.type:sub(2)
		Title.Field.Type.Visible = v1 ~= nil
		Title.Field.Type.Text = v1 or ""
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
	function t.Show(p1, p2, p3)
		local v2 = p3 or {}
		for k, v in pairs(p1.Items) do
			if v.gui then
				v.gui:Destroy()
			end
		end
		p1.SelectedItem = 1
		p1.Items = p2
		p1.Prefix = v2.prefix or ""
		p1.LastItem = v2.isLast or false
		p1.Command = v2.command
		p1.Arg = v2.arg
		p1.NumArgs = v2.numArgs
		p1.IsPartial = v2.isPartial
		local v3 = 200
		for k, v in pairs(p1.Items) do
			local v4
			local v5 = v[1]
			local v6 = v[2]
			local v7 = TextButton:Clone()
			v7.Name = v5 .. v6
			v4 = if k == p1.SelectedItem then 0.5 else 1
			v7.BackgroundTransparency = v4
			local v8, v9 = string.find(v6:lower(), v5:lower(), 1, true)
			if v8 == nil and v9 == nil then
				v8, v9 = 1, string.len(v6)
			end
			v7.Typed.Text = string.rep(" ", v8 - 1) .. v5
			v7.Suggest.Text = string.sub(v6, 0, v8 - 1) .. string.rep(" ", #v5) .. string.sub(v6, v9 + 1)
			v7.Parent = Autocomplete
			v7.LayoutOrder = k
			local v11 = math.max(v7.Typed.TextBounds.X, v7.Suggest.TextBounds.X) + 20
			if v3 < v11 then
				v3 = v11
			end
			v.gui = v7
		end
		Autocomplete.UIListLayout:ApplyLayout()
		local Text = Entry.TextBox.Text
		local v12 = Util.SplitString(Text)
		if Text:sub(#Text, #Text) == " " and not v2.at then
			v12[#v12 + 1] = "e"
		end
		table.remove(v12, #v12)
		local v13 = v2.at and v2.at or #table.concat(v12, " ") + 1
		Autocomplete.Position = UDim2.new(0, Entry.TextBox.AbsolutePosition.X - 10 + v13 * 7, 0, Entry.TextBox.AbsolutePosition.Y + 30) - UDim2.new(0, Autocomplete.Parent.AbsolutePosition.X, 0, Autocomplete.Parent.AbsolutePosition.Y)
		Autocomplete.Size = UDim2.new(0, v3, 0, Autocomplete.UIListLayout.AbsoluteContentSize.Y)
		Autocomplete.Visible = true
		UpdateInfoDisplay(p1.Items[1] and p1.Items[1].options or v2)
	end
	function t.GetSelectedItem(p1)
		if Autocomplete.Visible == false then
			return nil
		else
			return t.Items[t.SelectedItem]
		end
	end
	function t.Hide(p1)
		Autocomplete.Visible = false
	end
	function t.IsVisible(p1)
		return Autocomplete.Visible
	end
	function t.Select(p1, p2)
		if Autocomplete.Visible then
			p1.SelectedItem = p1.SelectedItem + p2
			if p1.SelectedItem > #p1.Items then
				p1.SelectedItem = 1
			elseif p1.SelectedItem < 1 then
				p1.SelectedItem = #p1.Items
			end
			for k, v in pairs(p1.Items) do
				local v1
				v1 = if k == p1.SelectedItem then 0.5 else 1
				v.gui.BackgroundTransparency = v1
			end
			local v3 = Vector2.new
			Autocomplete.CanvasPosition = v3(0, (math.max(0, Title.Size.Y.Offset + Description.Size.Y.Offset + p1.SelectedItem * TextButton.Size.Y.Offset - Autocomplete.Size.Y.Offset)))
			if p1.Items[p1.SelectedItem] and p1.Items[p1.SelectedItem].options then
				UpdateInfoDisplay(p1.Items[p1.SelectedItem].options or {})
			end
		end
	end
	Autocomplete.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateContainerSize)
	return t
end
