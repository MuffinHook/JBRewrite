local ReplicatedStorage = game:GetService("ReplicatedStorage")
local createElement = require(ReplicatedStorage.Roact).createElement
local ViewportFrame = require(ReplicatedStorage.EzUi.ViewportFrame)
return function(props)
	local aspectRatio = props.aspectRatio
	local isBackGlowEnabled = props.backGlowEnabled or false
	local bubbleColor = props.bubbleColor
	local circleElement = if props.getInst == nil then createElement("Frame", {
	BackgroundColor3 = bubbleColor,
	Size = UDim2.new(0.8, 0, 0.8 * aspectRatio, 0),
	Position = UDim2.new(0.5, 0, 0.5, 0),
	AnchorPoint = Vector2.new(0.5, 0.5),
	ZIndex = 2
}, {
	UICorner = createElement("UICorner", {
		CornerRadius = UDim.new(1, 0)
	}),
	Icon = createElement("ImageLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.9, 0, 0.9, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Image = props.image
	})
}) else createElement(ViewportFrame, {
	backgroundColor = bubbleColor,
	backgroundTransparency = 0,
	getInst = props.getInst,
	getInstCompare = props.getInstCompare,
	updateCamera = props.updateCamera,
	size = UDim2.new(0.8, 0, 0.8 * aspectRatio, 0),
	position = UDim2.new(0.5, 0, 0.5, 0),
	anchorPoint = Vector2.new(0.5, 0.5),
	zIndex = 2
}, {
	UICorner = createElement("UICorner", {
		CornerRadius = UDim.new(1, 0)
	})
})
	local cardFrameProps = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = props.size,
		Position = props.position
	}
	cardFrameProps.ZIndex = if isBackGlowEnabled then 2 else 1
	local cardChildren = {
		BackGlow = createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://10046133665",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(1.5 / aspectRatio, 0, 1.5, 0),
			ImageColor3 = bubbleColor,
			ZIndex = 1,
			Visible = isBackGlowEnabled
		})
	}
	local innerFrameProps = {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 2
	}
	local cardElementsConfig = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, props.cornerPixel)
		}),
		FrontGlow = createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://10046133665",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(1.1 / aspectRatio, 0, 1.1, 0),
			ImageTransparency = 0.5,
			ImageColor3 = bubbleColor,
			Visible = props.frontGlowEnabled or false
		}),
		Circle = circleElement
	}
	cardElementsConfig.Owned = props.owned and createElement("ImageLabel", {
		BackgroundTransparency = 1,
		Image = "rbxassetid://8724615287",
		ImageColor3 = Color3.new(0/255, 255/255, 0/255),
		Size = UDim2.new(0.8, 0, 0.8 * aspectRatio, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		ZIndex = 3
	})
	cardElementsConfig.Type = createElement("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.5, 0, 0.1, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.075, 0),
		ZIndex = 3
	}, {
		Text = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = props.typeTitle,
			Font = Enum.Font.Bangers,
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = Color3.new(0.5, 0.5, 0.5)
		})
	})
	cardElementsConfig.SubTitle = if props.subTitle == nil then false else createElement("Frame", {
	BackgroundTransparency = 1,
	Size = UDim2.new(0.5, 0, 0.1, 0),
	AnchorPoint = Vector2.new(0.5, 1),
	Position = UDim2.new(0.5, 0, 0.795, 0),
	ZIndex = 3
}, {
	Text = createElement("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1.25, 0, 1.25, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Text = props.subTitle,
		Font = Enum.Font.Bangers,
		LineHeight = 1,
		TextScaled = true,
		TextColor3 = Color3.new(255/255, 255/255, 255/255)
	})
})
	cardElementsConfig.Title = createElement("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.8, 0, 0.125, 0),
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 0.92, 0),
		ZIndex = 3
	}, {
		Text = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1.25, 0, 1.25, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = props.title,
			Font = Enum.Font.Bangers,
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = Color3.new(255/255, 255/255, 255/255)
		})
	})
	cardElementsConfig.Rarity = createElement("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.5, 0, 0.08, 0),
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 1, 0),
		ZIndex = 3
	}, {
		Text = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1.25, 0, 1.25, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = props.rarityTitle,
			Font = Enum.Font.Bangers,
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = bubbleColor
		})
	})
	cardChildren.Card = createElement("Frame", innerFrameProps, cardElementsConfig)
	return createElement("Frame", cardFrameProps, cardChildren)
end
