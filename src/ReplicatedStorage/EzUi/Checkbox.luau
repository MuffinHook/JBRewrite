-- Reviewed by Claude
local EzUiFolder = script:FindFirstAncestor("EzUi")
local Dictionary = require(script.Parent.Dictionary)
local Roact = require(EzUiFolder.Parent.Roact)
local createElement = Roact.createElement
local CheckboxComponent = Roact.Component:extend("Checkbox")
CheckboxComponent.defaultProps = {
	size = UDim2.new(0.5, 0, 0.5, 0),
	backgroundColor = Color3.new(204/255, 204/255, 204/255),
	checkColor = Color3.new(0/255, 0/255, 0/255),
	disabled = false
}
function CheckboxComponent.render(self)
	local frameProps = {
		Size = self.props.size,
		Position = self.props.position,
		LayoutOrder = self.props.layoutOrder
	}
	frameProps.BackgroundColor3 = self.props.value and Color3.new(0/255, 0/255, 0/255) or Color3.new(0.1, 0.1, 0.1)
	local frameChildren = {}
	frameChildren.Corner = self.props.cornerRadius and createElement("UICorner", {
		CornerRadius = self.props.cornerRadius
	})
	frameChildren.AspectRatio = createElement("UIAspectRatioConstraint", {
		AspectRatio = 1,
		DominantAxis = Enum.DominantAxis.Height
	})
	local checkboxButtonProps = {
		AutoButtonColor = not self.props.disabled,
		Size = UDim2.fromScale(0.92, 0.92),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		LayoutOrder = self.props.layoutOrder,
		BackgroundColor3 = self.props.backgroundColor,
		Selectable = true,
		Text = ""
	}
	checkboxButtonProps[Roact.Event.Activated] = if self.props.disabled then nil else function()
	if self.props.onChecked then
		self.props.onChecked(not self.props.value)
	end
end
	local checkboxButtonChildren = {
		Check = createElement("ImageLabel", {
			Size = UDim2.new(1, 0, 1, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Image = "rbxassetid://8724615287",
			ImageColor3 = self.props.checkColor,
			Visible = self.props.value
		})
	}
	checkboxButtonChildren.Corner = self.props.cornerRadius and createElement("UICorner", {
		CornerRadius = self.props.cornerRadius
	})
	frameChildren.Checkbox = createElement("TextButton", checkboxButtonProps, Dictionary.merge(self.props[Roact.Children], checkboxButtonChildren))
	return createElement("Frame", frameProps, frameChildren)
end
return CheckboxComponent
