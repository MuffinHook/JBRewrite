require(script.Parent.Parent.Types)
return function(iris, irisUtils)
	iris.WidgetConstructor("Separator", {
		hasState = false,
		hasChildren = false,
		Args = {},
		Events = {},
		Generate = function(widgetContext)
			local Iris_Separator = Instance.new("Frame")
			Iris_Separator.Name = "Iris_Separator"
			if widgetContext.parentWidget.type == "SameLine" then
				Iris_Separator.Size = UDim2.new(0, 1, iris._config.ItemWidth.Scale, iris._config.ItemWidth.Offset)
			else
				Iris_Separator.Size = UDim2.new(iris._config.ItemWidth.Scale, iris._config.ItemWidth.Offset, 0, 1)
			end
			Iris_Separator.BackgroundColor3 = iris._config.SeparatorColor
			Iris_Separator.BackgroundTransparency = iris._config.SeparatorTransparency
			Iris_Separator.BorderSizePixel = 0
			irisUtils.UIListLayout(Iris_Separator, Enum.FillDirection.Vertical, UDim.new(0, 0))
			return Iris_Separator
		end,
		Update = function(iris) end,
		Discard = function(iris)
			iris.Instance:Destroy()
		end
	})
	iris.WidgetConstructor("Indent", {
		hasState = false,
		hasChildren = true,
		Args = {
			Width = 1
		},
		Events = {},
		Generate = function(widgetContext)
			local Iris_Indent = Instance.new("Frame")
			Iris_Indent.Name = "Iris_Indent"
			Iris_Indent.AutomaticSize = Enum.AutomaticSize.Y
			Iris_Indent.Size = UDim2.new(iris._config.ItemWidth, UDim.new())
			Iris_Indent.BackgroundTransparency = 1
			Iris_Indent.BorderSizePixel = 0
			irisUtils.UIListLayout(Iris_Indent, Enum.FillDirection.Vertical, UDim.new(0, iris._config.ItemSpacing.Y))
			irisUtils.UIPadding(Iris_Indent, Vector2.zero)
			return Iris_Indent
		end,
		Update = function(widgetContext)
			widgetContext.Instance.UIPadding.PaddingLeft = UDim.new(0, widgetContext.arguments.Width or iris._config.IndentSpacing)
		end,
		ChildAdded = function(iris, irisUtils)
			return iris.Instance
		end,
		Discard = function(iris)
			iris.Instance:Destroy()
		end
	})
	iris.WidgetConstructor("SameLine", {
		hasState = false,
		hasChildren = true,
		Args = {
			Width = 1,
			VerticalAlignment = 2,
			HorizontalAlignment = 3
		},
		Events = {},
		Generate = function(widgetContext)
			local Iris_SameLine = Instance.new("Frame")
			Iris_SameLine.Name = "Iris_SameLine"
			Iris_SameLine.AutomaticSize = Enum.AutomaticSize.Y
			Iris_SameLine.Size = UDim2.new(iris._config.ItemWidth, UDim.new())
			Iris_SameLine.BackgroundTransparency = 1
			Iris_SameLine.BorderSizePixel = 0
			irisUtils.UIListLayout(Iris_SameLine, Enum.FillDirection.Horizontal, UDim.new(0, 0))
			return Iris_SameLine
		end,
		Update = function(widgetContext)
			local UIListLayout = widgetContext.Instance.UIListLayout
			UIListLayout.Padding = UDim.new(0, widgetContext.arguments.Width or iris._config.ItemSpacing.X)
			if widgetContext.arguments.VerticalAlignment then
				UIListLayout.VerticalAlignment = widgetContext.arguments.VerticalAlignment
			else
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
			end
			if widgetContext.arguments.HorizontalAlignment then
				UIListLayout.HorizontalAlignment = widgetContext.arguments.HorizontalAlignment
			else
				UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
			end
		end,
		ChildAdded = function(iris, irisUtils)
			return iris.Instance
		end,
		Discard = function(iris)
			iris.Instance:Destroy()
		end
	})
	iris.WidgetConstructor("Group", {
		hasState = false,
		hasChildren = true,
		Args = {},
		Events = {},
		Generate = function(widgetContext)
			local Iris_Group = Instance.new("Frame")
			Iris_Group.Name = "Iris_Group"
			Iris_Group.AutomaticSize = Enum.AutomaticSize.XY
			Iris_Group.Size = UDim2.fromOffset(0, 0)
			Iris_Group.BackgroundTransparency = 1
			Iris_Group.BorderSizePixel = 0
			Iris_Group.ClipsDescendants = false
			irisUtils.UIListLayout(Iris_Group, Enum.FillDirection.Vertical, UDim.new(0, iris._config.ItemSpacing.Y))
			return Iris_Group
		end,
		Update = function(iris) end,
		ChildAdded = function(iris, irisUtils)
			return iris.Instance
		end,
		Discard = function(iris)
			iris.Instance:Destroy()
		end
	})
end
