-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local SafeComponent = require(script.Parent.SafeComponent)
local RewardSpinnerConsts = require(ReplicatedStorage.RewardSpinner.RewardSpinnerConsts)
return function(p1)
	local aspectRatio = p1.aspectRatio
	local verticalPaddingRatio = p1.verticalPaddingRatio
	local t = {}
	local v1 = #RewardSpinnerConsts.RARITIES
	t.ListLayout = createElement("UIListLayout", {
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
		FillDirection = Enum.FillDirection.Vertical
	})
	local count = 0
	for i = 1, v1 do
		local v2 = RewardSpinnerConsts.RARITIES[i]
		local var3 = 1.6 / v1
		local var4 = p1.RarityProbabilities[v2.id]
		if var4 then
			count = count + 1
			t[count] = createElement("Frame", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 1 / v1, 0),
				Position = UDim2.new(0, 0, (count - 1) / v1, 0),
				LayoutOrder = count
			}, {
				Number = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(var3, 0, 1, 0),
					Position = UDim2.new(0, 0, 0, 0),
					Text = tostring(var4) .. "%",
					TextXAlignment = Enum.TextXAlignment.Right,
					Font = Enum.Font.Bangers,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = v2.color
				}),
				Text = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1 - var3, 0, 1, 0),
					Position = UDim2.new(var3 + 1 / verticalPaddingRatio / aspectRatio, 0, 0, 0),
					Text = v2.name,
					TextXAlignment = Enum.TextXAlignment.Left,
					Font = Enum.Font.Bangers,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = v2.color
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
				Text = p1.Title .. " SAFE",
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
			imageId = p1.ImageId
		}),
		Numbers = createElement("Frame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0.9 - aspectRatio - 2 / verticalPaddingRatio, 0),
			Position = UDim2.new(0, 0, 0.1 + aspectRatio + 2 / verticalPaddingRatio, 0),
			LayoutOrder = 4
		}, t)
	})
end
