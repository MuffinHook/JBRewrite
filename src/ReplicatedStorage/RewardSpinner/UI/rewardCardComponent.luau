-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local createElement = require(ReplicatedStorage.Roact).createElement
local ViewportFrame = require(ReplicatedStorage.EzUi.ViewportFrame)
return function(p1)
	local aspectRatio = p1.aspectRatio
	local v2 = p1.backGlowEnabled or false
	local bubbleColor = p1.bubbleColor
	local var4 = if p1.getInst == nil then createElement("Frame", {
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
		Image = p1.image
	})
}) else createElement(ViewportFrame, {
	backgroundColor = bubbleColor,
	backgroundTransparency = 0,
	getInst = p1.getInst,
	getInstCompare = p1.getInstCompare,
	updateCamera = p1.updateCamera,
	size = UDim2.new(0.8, 0, 0.8 * aspectRatio, 0),
	position = UDim2.new(0.5, 0, 0.5, 0),
	anchorPoint = Vector2.new(0.5, 0.5),
	zIndex = 2
}, {
	UICorner = createElement("UICorner", {
		CornerRadius = UDim.new(1, 0)
	})
})
	local t = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = p1.size,
		Position = p1.position
	}
	t.ZIndex = if v2 then 2 else 1
	local t2 = {
		BackGlow = createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://10046133665",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(1.5 / aspectRatio, 0, 1.5, 0),
			ImageColor3 = bubbleColor,
			ZIndex = 1,
			Visible = v2
		})
	}
	local t3 = {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 2
	}
	local t4 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, p1.cornerPixel)
		}),
		FrontGlow = createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://10046133665",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(1.1 / aspectRatio, 0, 1.1, 0),
			ImageTransparency = 0.5,
			ImageColor3 = bubbleColor,
			Visible = p1.frontGlowEnabled or false
		}),
		Circle = var4
	}
	t4.Owned = p1.owned and createElement("ImageLabel", {
		BackgroundTransparency = 1,
		Image = "rbxassetid://8724615287",
		ImageColor3 = Color3.new(0/255, 255/255, 0/255),
		Size = UDim2.new(0.8, 0, 0.8 * aspectRatio, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		ZIndex = 3
	})
	t4.Type = createElement("Frame", {
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
			Text = p1.typeTitle,
			Font = Enum.Font.Bangers,
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = Color3.new(0.5, 0.5, 0.5)
		})
	})
	t4.SubTitle = if p1.subTitle == nil then false else createElement("Frame", {
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
		Text = p1.subTitle,
		Font = Enum.Font.Bangers,
		LineHeight = 1,
		TextScaled = true,
		TextColor3 = Color3.new(255/255, 255/255, 255/255)
	})
})
	t4.Title = createElement("Frame", {
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
			Text = p1.title,
			Font = Enum.Font.Bangers,
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = Color3.new(255/255, 255/255, 255/255)
		})
	})
	t4.Rarity = createElement("Frame", {
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
			Text = p1.rarityTitle,
			Font = Enum.Font.Bangers,
			LineHeight = 1,
			TextScaled = true,
			TextColor3 = bubbleColor
		})
	})
	t2.Card = createElement("Frame", t3, t4)
	return createElement("Frame", t, t2)
end
