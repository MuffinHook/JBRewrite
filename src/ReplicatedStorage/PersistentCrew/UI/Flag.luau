-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local local1 = Roact.PureComponent:extend("Flag")
local1.defaultProps = {
	flagColor = Color3.new(255/255, 255/255, 255/255),
	userId = 1,
	size = UDim2.fromScale(1, 1),
	position = UDim2.fromScale(0.5, 0.5),
	anchorPoint = Vector2.new(0.5, 0.5)
}
function local1.render(self)
	return createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = self.props.flagColor,
		Size = self.props.size,
		AnchorPoint = self.props.anchorPoint,
		Position = self.props.position
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		FlagBg = createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://12385250525",
			Size = UDim2.fromScale(1, 1),
			ImageColor3 = self.props.flagColor
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 4)
			})
		}),
		Avatar = createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Image = "rbxthumb://type=AvatarHeadShot&w=150&h=150&id=" .. (self.props.userId or 1),
			Size = UDim2.fromScale(1, 0.9),
			Position = UDim2.fromScale(0, 0),
			AnchorPoint = Vector2.new(0, 0),
			ZIndex = 3
		}, {
			UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1,
				AspectType = Enum.AspectType.FitWithinMaxSize,
				DominantAxis = Enum.DominantAxis.Height
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			})
		})
	})
end
return local1
