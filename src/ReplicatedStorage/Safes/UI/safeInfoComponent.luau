local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local SafeComponent = require(script.Parent.SafeComponent)
local RewardSpinnerConsts = require(ReplicatedStorage.RewardSpinner.RewardSpinnerConsts)
return function(props)
	local aspectRatio = props.aspectRatio
	local verticalPaddingRatio = props.verticalPaddingRatio
	local elements = {}
	local rarityCount = #RewardSpinnerConsts.RARITIES
	elements.ListLayout = createElement("UIListLayout", {
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
		FillDirection = Enum.FillDirection.Vertical
	})
	local count = 0
	for i = 1, rarityCount do
		local rarity = RewardSpinnerConsts.RARITIES[i]
		local percentageColumnWidth = 1.6 / rarityCount
		local probability = props.RarityProbabilities[rarity.id]
		if probability then
			count = count + 1
			elements[count] = createElement("Frame", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 1 / rarityCount, 0),
				Position = UDim2.new(0, 0, (count - 1) / rarityCount, 0),
				LayoutOrder = count
			}, {
				Number = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(percentageColumnWidth, 0, 1, 0),
					Position = UDim2.new(0, 0, 0, 0),
					Text = tostring(probability) .. "%",
					TextXAlignment = Enum.TextXAlignment.Right,
					Font = Enum.Font.Bangers,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = rarity.color
				}),
				Text = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1 - percentageColumnWidth, 0, 1, 0),
					Position = UDim2.new(percentageColumnWidth + 1 / verticalPaddingRatio / aspectRatio, 0, 0, 0),
					Text = rarity.name,
					TextXAlignment = Enum.TextXAlignment.Left,
					Font = Enum.Font.Bangers,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = rarity.color
				})
			})
		end
	end
	return Roact.createFragment({
		Title = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(1, 0, 0.1, 0),
			Position = UDim2.new(0, 0, 0, 0)
		}, {
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = props.Title .. " SAFE",
				TextXAlignment = Enum.TextXAlignment.Center,
				Font = Enum.Font.Bangers,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255)
			})
		}),
		Safe = createElement(SafeComponent, {
			static = true,
			selected = true,
			size = UDim2.new(aspectRatio / aspectRatio, 0, aspectRatio, 0),
			position = UDim2.new(0, 0, 0.1 + 1 / verticalPaddingRatio, 0),
			aspectRatio = 1,
			layoutOrder = 2,
			imageId = props.ImageId
		}),
		Numbers = createElement("Frame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0.9 - aspectRatio - 2 / verticalPaddingRatio, 0),
			Position = UDim2.new(0, 0, 0.1 + aspectRatio + 2 / verticalPaddingRatio, 0),
			LayoutOrder = 4
		}, elements)
	})
end
