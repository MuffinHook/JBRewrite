-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("Avatar")
function v1.init(p1)  end
function v1.render(p1)
	local t = {
		Position = p1.props.position,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0.7, 0.7, 0.7),
		BackgroundTransparency = 0
	}
	t.Image = "rbxthumb://type=AvatarHeadShot&w=150&h=150&id=" .. tostring(p1.props.userId)
	t.Size = p1.props.size
	local t2 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(1, 0)
		})
	}
	t2.UIStroke = p1.props.isFriend and createElement("UIStroke", {
		Thickness = 1,
		Color = Color3.fromHex("5cc76d")
	})
	t2.UIAspectRatio = createElement("UIAspectRatioConstraint", {
		AspectRatio = 1
	})
	return createElement("ImageLabel", t, t2)
end
return v1
