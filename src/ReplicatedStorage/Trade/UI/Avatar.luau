local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local AvatarComponent = Roact.PureComponent:extend("Avatar")
function AvatarComponent.init(component)  end
function AvatarComponent.render(component)
	local imageLabelProps = {
		Position = component.props.position,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0.7, 0.7, 0.7),
		BackgroundTransparency = 0
	}
	imageLabelProps.Image = "rbxthumb://type=AvatarHeadShot&w=150&h=150&id=" .. tostring(component.props.userId)
	imageLabelProps.Size = component.props.size
	local imageLabelChildren = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(1, 0)
		})
	}
	imageLabelChildren.UIStroke = component.props.isFriend and createElement("UIStroke", {
		Thickness = 1,
		Color = Color3.fromHex("5cc76d")
	})
	imageLabelChildren.UIAspectRatio = createElement("UIAspectRatioConstraint", {
		AspectRatio = 1
	})
	return createElement("ImageLabel", imageLabelProps, imageLabelChildren)
end
return AvatarComponent
