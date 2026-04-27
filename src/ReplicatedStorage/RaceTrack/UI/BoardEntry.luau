local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local BoardEntryComponent = Roact.PureComponent:extend("BoardEntry")
function BoardEntryComponent.render(self)
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		LayoutOrder = self.props.rank
	}, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 8
		}),
		Background = createElement("Frame", {
			BackgroundTransparency = 0,
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = Color3.fromRGB(2, 227, 248),
			BorderColor3 = Color3.new(255/255, 255/255, 255/255),
			BorderMode = Enum.BorderMode.Inset,
			BorderSizePixel = 4
		}),
		Content = createElement("Frame", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			ZIndex = 2
		}, {
			ListLayout = createElement("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Horizontal
			}),
			Number = createElement("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				LayoutOrder = 1
			}, {
				Label = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(0.8, 0, 0.8, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.new(0.5, 0, 0.65, 0),
					Text = ("#%d"):format(self.props.rank),
					TextColor3 = Color3.new(255/255, 255/255, 255/255),
					Font = Enum.Font.LuckiestGuy,
					TextScaled = true
				}),
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 1
				})
			}),
			Icon = createElement("Frame", {
				LayoutOrder = 2,
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1
			}, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 1
				}),
				Image = createElement("ImageLabel", {
					BackgroundTransparency = 1,
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0.8, 0, 0.8, 0),
					Image = ("rbxthumb://type=AvatarHeadShot&w=150&h=150&id=%d"):format(self.props.userId)
				})
			}),
			Stats = createElement("Frame", {
				LayoutOrder = 3,
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1
			}, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 6
				}),
				Title = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0.5, 0),
					Position = UDim2.new(0, 0, 0.1, 0),
					Text = self.props.name,
					TextColor3 = Color3.new(0.15, 0.15, 0.15),
					Font = Enum.Font.LuckiestGuy,
					TextScaled = true
				}),
				Message = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0.4, 0),
					Position = UDim2.new(0, 0, 0.6, 0),
					Text = self.props.message,
					TextColor3 = Color3.new(255/255, 255/255, 255/255),
					Font = Enum.Font.LuckiestGuy,
					TextScaled = true
				})
			})
		})
	})
end
return BoardEntryComponent
