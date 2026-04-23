require(script.Parent.Parent.Types)
return function(p1, p2) --[[ Line: 3 ]]
	p1.WidgetConstructor("Separator", {
		hasState = false,
		hasChildren = false,
		Args = {},
		Events = {},
		Generate = function(p12) --[[ Name: Generate | Line: 10 | Upvalues: p1 (copy), p2 (copy) ]]
			local Iris_Separator = Instance.new("Frame")
			Iris_Separator.Name = "Iris_Separator"
			if p12.parentWidget.type == "SameLine" then
				Iris_Separator.Size = UDim2.new(0, 1, p1._config.ItemWidth.Scale, p1._config.ItemWidth.Offset)
			else
				Iris_Separator.Size = UDim2.new(p1._config.ItemWidth.Scale, p1._config.ItemWidth.Offset, 0, 1)
			end
			Iris_Separator.BackgroundColor3 = p1._config.SeparatorColor
			Iris_Separator.BackgroundTransparency = p1._config.SeparatorTransparency
			Iris_Separator.BorderSizePixel = 0
			p2.UIListLayout(Iris_Separator, Enum.FillDirection.Vertical, UDim.new(0, 0))
			return Iris_Separator
		end,
		Update = function(p1) --[[ Name: Update | Line: 27 ]] end,
		Discard = function(p1) --[[ Name: Discard | Line: 28 ]]
			p1.Instance:Destroy()
		end
	})
	p1.WidgetConstructor("Indent", {
		hasState = false,
		hasChildren = true,
		Args = {
			Width = 1
		},
		Events = {},
		Generate = function(p12) --[[ Name: Generate | Line: 41 | Upvalues: p1 (copy), p2 (copy) ]]
			local Iris_Indent = Instance.new("Frame")
			Iris_Indent.Name = "Iris_Indent"
			Iris_Indent.AutomaticSize = Enum.AutomaticSize.Y
			Iris_Indent.Size = UDim2.new(p1._config.ItemWidth, UDim.new())
			Iris_Indent.BackgroundTransparency = 1
			Iris_Indent.BorderSizePixel = 0
			p2.UIListLayout(Iris_Indent, Enum.FillDirection.Vertical, UDim.new(0, p1._config.ItemSpacing.Y))
			p2.UIPadding(Iris_Indent, Vector2.zero)
			return Iris_Indent
		end,
		Update = function(p12) --[[ Name: Update | Line: 54 | Upvalues: p1 (copy) ]]
			p12.Instance.UIPadding.PaddingLeft = UDim.new(0, p12.arguments.Width or p1._config.IndentSpacing)
		end,
		ChildAdded = function(p1, p2) --[[ Name: ChildAdded | Line: 59 ]]
			return p1.Instance
		end,
		Discard = function(p1) --[[ Name: Discard | Line: 62 ]]
			p1.Instance:Destroy()
		end
	})
	p1.WidgetConstructor("SameLine", {
		hasState = false,
		hasChildren = true,
		Args = {
			Width = 1,
			VerticalAlignment = 2,
			HorizontalAlignment = 3
		},
		Events = {},
		Generate = function(p12) --[[ Name: Generate | Line: 77 | Upvalues: p1 (copy), p2 (copy) ]]
			local Iris_SameLine = Instance.new("Frame")
			Iris_SameLine.Name = "Iris_SameLine"
			Iris_SameLine.AutomaticSize = Enum.AutomaticSize.Y
			Iris_SameLine.Size = UDim2.new(p1._config.ItemWidth, UDim.new())
			Iris_SameLine.BackgroundTransparency = 1
			Iris_SameLine.BorderSizePixel = 0
			p2.UIListLayout(Iris_SameLine, Enum.FillDirection.Horizontal, UDim.new(0, 0))
			return Iris_SameLine
		end,
		Update = function(p12) --[[ Name: Update | Line: 89 | Upvalues: p1 (copy) ]]
			local UIListLayout = p12.Instance.UIListLayout
			UIListLayout.Padding = UDim.new(0, p12.arguments.Width or p1._config.ItemSpacing.X)
			if p12.arguments.VerticalAlignment then
				UIListLayout.VerticalAlignment = p12.arguments.VerticalAlignment
			else
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
			end
			if p12.arguments.HorizontalAlignment then
				UIListLayout.HorizontalAlignment = p12.arguments.HorizontalAlignment
			else
				UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
			end
		end,
		ChildAdded = function(p1, p2) --[[ Name: ChildAdded | Line: 105 ]]
			return p1.Instance
		end,
		Discard = function(p1) --[[ Name: Discard | Line: 108 ]]
			p1.Instance:Destroy()
		end
	})
	p1.WidgetConstructor("Group", {
		hasState = false,
		hasChildren = true,
		Args = {},
		Events = {},
		Generate = function(p12) --[[ Name: Generate | Line: 119 | Upvalues: p2 (copy), p1 (copy) ]]
			local Iris_Group = Instance.new("Frame")
			Iris_Group.Name = "Iris_Group"
			Iris_Group.AutomaticSize = Enum.AutomaticSize.XY
			Iris_Group.Size = UDim2.fromOffset(0, 0)
			Iris_Group.BackgroundTransparency = 1
			Iris_Group.BorderSizePixel = 0
			Iris_Group.ClipsDescendants = false
			p2.UIListLayout(Iris_Group, Enum.FillDirection.Vertical, UDim.new(0, p1._config.ItemSpacing.Y))
			return Iris_Group
		end,
		Update = function(p1) --[[ Name: Update | Line: 132 ]] end,
		ChildAdded = function(p1, p2) --[[ Name: ChildAdded | Line: 133 ]]
			return p1.Instance
		end,
		Discard = function(p1) --[[ Name: Discard | Line: 136 ]]
			p1.Instance:Destroy()
		end
	})
end