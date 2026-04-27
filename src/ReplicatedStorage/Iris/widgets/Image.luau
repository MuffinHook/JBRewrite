require(script.Parent.Parent.Types)
return function(iris, utils)
	local imageWidgetConfig = {
		hasState = false,
		hasChildren = false,
		Args = {
			Image = 1,
			Size = 2,
			Rect = 3,
			ScaleType = 4,
			ResampleMode = 5,
			TileSize = 6,
			SliceCenter = 7,
			SliceScale = 8
		},
		Discard = function(widgetContext)
			widgetContext.Instance:Destroy()
		end
	}
	iris.WidgetConstructor("Image", utils.extend(imageWidgetConfig, {
		Events = {
			hovered = utils.EVENTS.hover(function(eventContext)
				return eventContext.Instance
			end)
		},
		Generate = function(widgetContext)
			local Iris_Image = Instance.new("ImageLabel")
			Iris_Image.Name = "Iris_Image"
			Iris_Image.BackgroundTransparency = 1
			Iris_Image.BorderSizePixel = 0
			Iris_Image.ImageColor3 = iris._config.ImageColor
			Iris_Image.ImageTransparency = iris._config.ImageTransparency
			utils.applyFrameStyle(Iris_Image, true)
			return Iris_Image
		end,
		Update = function(widgetContext)
			local instance = widgetContext.Instance
			instance.Image = widgetContext.arguments.Image or utils.ICONS.UNKNOWN_TEXTURE
			instance.Size = widgetContext.arguments.Size
			if widgetContext.arguments.ScaleType then
				instance.ScaleType = widgetContext.arguments.ScaleType
				if widgetContext.arguments.ScaleType == Enum.ScaleType.Tile and widgetContext.arguments.TileSize then
					instance.TileSize = widgetContext.arguments.TileSize
				elseif widgetContext.arguments.ScaleType == Enum.ScaleType.Slice then
					if widgetContext.arguments.SliceCenter then
						instance.SliceCenter = widgetContext.arguments.SliceCenter
					end
					if widgetContext.arguments.SliceScale then
						instance.SliceScale = widgetContext.arguments.SliceScale
					end
				end
			end
			if widgetContext.arguments.Rect then
				instance.ImageRectOffset = widgetContext.arguments.Rect.Min
				instance.ImageRectSize = Vector2.new(widgetContext.arguments.Rect.Width, widgetContext.arguments.Rect.Height)
			end
			if widgetContext.arguments.ResampleMode then
				instance.ResampleMode = widgetContext.arguments.ResampleMode
			end
		end
	}))
	iris.WidgetConstructor("ImageButton", utils.extend(imageWidgetConfig, {
		Events = {
			clicked = utils.EVENTS.click(function(eventContext)
				return eventContext.Instance
			end),
			rightClicked = utils.EVENTS.rightClick(function(eventContext)
				return eventContext.Instance
			end),
			doubleClicked = utils.EVENTS.doubleClick(function(eventContext)
				return eventContext.Instance
			end),
			ctrlClicked = utils.EVENTS.ctrlClick(function(eventContext)
				return eventContext.Instance
			end),
			hovered = utils.EVENTS.hover(function(eventContext)
				return eventContext.Instance
			end)
		},
		Generate = function(widgetContext)
			local Iris_ImageButton = Instance.new("ImageButton")
			Iris_ImageButton.Name = "Iris_ImageButton"
			Iris_ImageButton.AutomaticSize = Enum.AutomaticSize.XY
			Iris_ImageButton.BackgroundColor3 = iris._config.FrameBgColor
			Iris_ImageButton.BackgroundTransparency = iris._config.FrameBgTransparency
			Iris_ImageButton.BorderSizePixel = 0
			Iris_ImageButton.Image = ""
			Iris_ImageButton.ImageTransparency = 1
			Iris_ImageButton.AutoButtonColor = false
			utils.applyFrameStyle(Iris_ImageButton, true)
			utils.UIPadding(Iris_ImageButton, Vector2.new(iris._config.ImageBorderSize, iris._config.ImageBorderSize))
			local ImageLabel = Instance.new("ImageLabel")
			ImageLabel.Name = "ImageLabel"
			ImageLabel.BackgroundTransparency = 1
			ImageLabel.BorderSizePixel = 0
			ImageLabel.ImageColor3 = iris._config.ImageColor
			ImageLabel.ImageTransparency = iris._config.ImageTransparency
			ImageLabel.Parent = Iris_ImageButton
			utils.applyInteractionHighlights("Background", Iris_ImageButton, Iris_ImageButton, {
				Color = iris._config.FrameBgColor,
				Transparency = iris._config.FrameBgTransparency,
				HoveredColor = iris._config.FrameBgHoveredColor,
				HoveredTransparency = iris._config.FrameBgHoveredTransparency,
				ActiveColor = iris._config.FrameBgActiveColor,
				ActiveTransparency = iris._config.FrameBgActiveTransparency
			})
			return Iris_ImageButton
		end,
		Update = function(widgetContext)
			local ImageLabel = widgetContext.Instance.ImageLabel
			ImageLabel.Image = widgetContext.arguments.Image or utils.ICONS.UNKNOWN_TEXTURE
			ImageLabel.Size = widgetContext.arguments.Size
			if widgetContext.arguments.ScaleType then
				ImageLabel.ScaleType = widgetContext.arguments.ScaleType
				if widgetContext.arguments.ScaleType == Enum.ScaleType.Tile and widgetContext.arguments.TileSize then
					ImageLabel.TileSize = widgetContext.arguments.TileSize
				elseif widgetContext.arguments.ScaleType == Enum.ScaleType.Slice then
					if widgetContext.arguments.SliceCenter then
						ImageLabel.SliceCenter = widgetContext.arguments.SliceCenter
					end
					if widgetContext.arguments.SliceScale then
						ImageLabel.SliceScale = widgetContext.arguments.SliceScale
					end
				end
			end
			if widgetContext.arguments.Rect then
				ImageLabel.ImageRectOffset = widgetContext.arguments.Rect.Min
				ImageLabel.ImageRectSize = Vector2.new(widgetContext.arguments.Rect.Width, widgetContext.arguments.Rect.Height)
			end
			if widgetContext.arguments.ResampleMode then
				ImageLabel.ResampleMode = widgetContext.arguments.ResampleMode
			end
		end
	}))
end
