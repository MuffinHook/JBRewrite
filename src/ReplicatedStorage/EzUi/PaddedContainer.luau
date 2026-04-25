-- Reviewed by Claude
-- variables reassigned
local eZUiModule = script:FindFirstAncestor("EzUi")
local Dictionary = require(eZUiModule.Dictionary)
local Roact = require(eZUiModule.Parent.Roact)
local createElement = Roact.createElement
local paddedContainerClass = Roact.PureComponent:extend("PaddedContainer")
paddedContainerClass.defaultProps = {
	backgroundTransparency = 0,
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	anchorPoint = Vector2.new(0, 0),
	paddingLeft = 1,
	paddingRight = 1,
	paddingTop = 1,
	paddingBottom = 1,
	zIndex = nil
}
local hueValue = math.random()
function paddedContainerClass.render(self)
	local backgroundColor = self.props.backgroundColor
	if not backgroundColor and self.props.backgroundTransparency < 1 then
		hueValue = hueValue + 0.07725424859373685
		hueValue = hueValue % 1
		backgroundColor = Color3.fromHSV(hueValue, 0.8, 0.8)
	end
	local verticalPaddingRatio = self.props.verticalPaddingRatio
	local innerScaleXRatio = verticalPaddingRatio * self.props.aspectRatio
	local paddingLeft = self.props.paddingLeft
	local paddingRight = self.props.paddingRight
	local paddingTop = self.props.paddingTop
	local paddingBottom = self.props.paddingBottom
	if self.props.paddingNone then
		paddingLeft = 0
		paddingRight = 0
		paddingTop = 0
		paddingBottom = 0
	end
	local innerScaleX = self.props.size.X.Scale - paddingLeft / innerScaleXRatio - paddingRight / innerScaleXRatio
	if innerScaleX < 0 then
		warn("PaddedContainer: innerScaleX < 0: " .. tostring(innerScaleX))
	end
	local innerScaleY = self.props.size.Y.Scale - paddingTop / verticalPaddingRatio - paddingBottom / verticalPaddingRatio
	if innerScaleY < 0 then
		warn("PaddedContainer: innerScaleY < 0: " .. tostring(innerScaleY))
	end
	local aspectRatioValue = innerScaleX / innerScaleY
	local function processChildProps(componentNode, baseAspectRatio, basePaddingRatio)
		local childrenTable = componentNode.props[Roact.Children]
		if childrenTable then
			if componentNode.props.Size and typeof(componentNode.props.Size) == "UDim2" then
				baseAspectRatio = baseAspectRatio * (componentNode.props.Size.X.Scale / componentNode.props.Size.Y.Scale)
				basePaddingRatio = basePaddingRatio * componentNode.props.Size.Y.Scale
			end
			for _, childComponent in childrenTable do
				if typeof(childComponent) == "table" and childComponent.props then
					if childComponent.component == paddedContainerClass or (childComponent.props.exposePaddedContainerProps or childComponent.props.injectPaddedContainerProps) then
						childComponent.props.aspectRatio = baseAspectRatio * aspectRatioValue
						childComponent.props.verticalPaddingRatio = basePaddingRatio * innerScaleY
					end
					if childComponent.props[Roact.Children] then
						processChildProps(childComponent, baseAspectRatio, basePaddingRatio)
					end
				end
			end
		end
	end
	processChildProps(self, self.props.aspectRatio, verticalPaddingRatio)
	local finalSize = UDim2.new(innerScaleX, 0, innerScaleY, 0)
	local finalPosition = self.props.position + UDim2.new(paddingLeft / innerScaleXRatio, 0, paddingTop / verticalPaddingRatio, 0)
	if self.props.component then
		return createElement(self.props.component, Dictionary.merge(self.props.props, {
			size = finalSize,
			position = finalPosition,
			aspectRatio = aspectRatioValue,
			[Roact.Children] = self.props[Roact.Children],
			[Roact.Ref] = self.props[Roact.Ref]
		}))
	else
		return createElement("Frame", {
			BackgroundTransparency = self.props.backgroundTransparency,
			BackgroundColor3 = backgroundColor,
			BorderSizePixel = 0,
			ZIndex = self.props.zIndex,
			Size = finalSize,
			Position = finalPosition,
			AnchorPoint = self.props.anchorPoint,
			Visible = self.props.visible,
			[Roact.Children] = self.props[Roact.Children],
			[Roact.Ref] = self.props[Roact.Ref]
		})
	end
end
return paddedContainerClass
