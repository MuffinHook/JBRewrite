-- Reviewed by Claude
require(script.Parent.Parent.Types)
return function(p1, p2)
	local t = {
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
		Discard = function(p1)
			p1.Instance:Destroy()
		end
	}
	p1.WidgetConstructor("Image", p2.extend(t, {
		Events = {
			hovered = p2.EVENTS.hover(function(p1)
				return p1.Instance
			end)
		},
		Generate = function(p12)
			local Iris_Image = Instance.new("ImageLabel")
			Iris_Image.Name = "Iris_Image"
			Iris_Image.BackgroundTransparency = 1
			Iris_Image.BorderSizePixel = 0
			Iris_Image.ImageColor3 = p1._config.ImageColor
			Iris_Image.ImageTransparency = p1._config.ImageTransparency
			p2.applyFrameStyle(Iris_Image, true)
			return Iris_Image
		end,
		Update = function(p1)
			local v1 = p1.Instance
			v1.Image = p1.arguments.Image or p2.ICONS.UNKNOWN_TEXTURE
			v1.Size = p1.arguments.Size
			if p1.arguments.ScaleType then
				v1.ScaleType = p1.arguments.ScaleType
				if p1.arguments.ScaleType == Enum.ScaleType.Tile and p1.arguments.TileSize then
					v1.TileSize = p1.arguments.TileSize
				elseif p1.arguments.ScaleType == Enum.ScaleType.Slice then
					if p1.arguments.SliceCenter then
						v1.SliceCenter = p1.arguments.SliceCenter
					end
					if p1.arguments.SliceScale then
						v1.SliceScale = p1.arguments.SliceScale
					end
				end
			end
			if p1.arguments.Rect then
				v1.ImageRectOffset = p1.arguments.Rect.Min
				v1.ImageRectSize = Vector2.new(p1.arguments.Rect.Width, p1.arguments.Rect.Height)
			end
			if p1.arguments.ResampleMode then
				v1.ResampleMode = p1.arguments.ResampleMode
			end
		end
	}))
	p1.WidgetConstructor("ImageButton", p2.extend(t, {
		Events = {
			clicked = p2.EVENTS.click(function(p1)
				return p1.Instance
			end),
			rightClicked = p2.EVENTS.rightClick(function(p1)
				return p1.Instance
			end),
			doubleClicked = p2.EVENTS.doubleClick(function(p1)
				return p1.Instance
			end),
			ctrlClicked = p2.EVENTS.ctrlClick(function(p1)
				return p1.Instance
			end),
			hovered = p2.EVENTS.hover(function(p1)
				return p1.Instance
			end)
		},
		Generate = function(p12)
			local Iris_ImageButton = Instance.new("ImageButton")
			Iris_ImageButton.Name = "Iris_ImageButton"
			Iris_ImageButton.AutomaticSize = Enum.AutomaticSize.XY
			Iris_ImageButton.BackgroundColor3 = p1._config.FrameBgColor
			Iris_ImageButton.BackgroundTransparency = p1._config.FrameBgTransparency
			Iris_ImageButton.BorderSizePixel = 0
			Iris_ImageButton.Image = ""
			Iris_ImageButton.ImageTransparency = 1
			Iris_ImageButton.AutoButtonColor = false
			p2.applyFrameStyle(Iris_ImageButton, true)
			p2.UIPadding(Iris_ImageButton, Vector2.new(p1._config.ImageBorderSize, p1._config.ImageBorderSize))
			local ImageLabel = Instance.new("ImageLabel")
			ImageLabel.Name = "ImageLabel"
			ImageLabel.BackgroundTransparency = 1
			ImageLabel.BorderSizePixel = 0
			ImageLabel.ImageColor3 = p1._config.ImageColor
			ImageLabel.ImageTransparency = p1._config.ImageTransparency
			ImageLabel.Parent = Iris_ImageButton
			p2.applyInteractionHighlights("Background", Iris_ImageButton, Iris_ImageButton, {
				Color = p1._config.FrameBgColor,
				Transparency = p1._config.FrameBgTransparency,
				HoveredColor = p1._config.FrameBgHoveredColor,
				HoveredTransparency = p1._config.FrameBgHoveredTransparency,
				ActiveColor = p1._config.FrameBgActiveColor,
				ActiveTransparency = p1._config.FrameBgActiveTransparency
			})
			return Iris_ImageButton
		end,
		Update = function(p1)
			local ImageLabel = p1.Instance.ImageLabel
			ImageLabel.Image = p1.arguments.Image or p2.ICONS.UNKNOWN_TEXTURE
			ImageLabel.Size = p1.arguments.Size
			if p1.arguments.ScaleType then
				ImageLabel.ScaleType = p1.arguments.ScaleType
				if p1.arguments.ScaleType == Enum.ScaleType.Tile and p1.arguments.TileSize then
					ImageLabel.TileSize = p1.arguments.TileSize
				elseif p1.arguments.ScaleType == Enum.ScaleType.Slice then
					if p1.arguments.SliceCenter then
						ImageLabel.SliceCenter = p1.arguments.SliceCenter
					end
					if p1.arguments.SliceScale then
						ImageLabel.SliceScale = p1.arguments.SliceScale
					end
				end
			end
			if p1.arguments.Rect then
				ImageLabel.ImageRectOffset = p1.arguments.Rect.Min
				ImageLabel.ImageRectSize = Vector2.new(p1.arguments.Rect.Width, p1.arguments.Rect.Height)
			end
			if p1.arguments.ResampleMode then
				ImageLabel.ResampleMode = p1.arguments.ResampleMode
			end
		end
	}))
end
