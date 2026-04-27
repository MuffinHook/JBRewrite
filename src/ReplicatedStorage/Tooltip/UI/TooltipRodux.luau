local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
local Roact = require(ReplicatedStorage.Roact)
local Tooltip = require(script.Parent.Tooltip)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local createElement = Roact.createElement
local TooltipContainer = Roact.PureComponent:extend("TooltipContainer")
function TooltipContainer.init(component)
	component:setState({
		smallScreen = EzUtils.isSmallScreen(),
		touchControls = InputUtils.isTouch()
	})
	component.maid = Maid.new()
end
function TooltipContainer.render(component)
	local frameProperties = {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1)
	}
	local containerChildren = {
		UIListLayout1 = createElement("UIListLayout", {
			Padding = UDim.new(0.01, 0),
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Bottom
		}),
		UIPadding = createElement("UIPadding", {
			PaddingBottom = UDim.new(0.01, 0)
		})
	}
	local containerFrameProps = {
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		LayoutOrder = 3,
		Position = UDim2.fromScale(0.2, 0)
	}
	containerFrameProps.Size = UDim2.fromScale(if component.state.smallScreen or component.state.touchControls then 0.7 else 0.4, 1)
	containerChildren.Container = createElement("Frame", containerFrameProps, {
		UIListLayout = createElement("UIListLayout", {
			Padding = UDim.new(0, 8),
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center
		}),
		UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
			AspectRatio = 12,
			AspectType = Enum.AspectType.ScaleWithParentSize
		})
	})
	containerChildren.TooltipContainer = createElement("Frame", {
		BackgroundTransparency = 1,
		LayoutOrder = 2,
		Size = UDim2.fromScale(1, 1)
	}, {
		Tooltip = createElement(Tooltip, component.props)
	})
	return createElement("Frame", frameProperties, containerChildren)
end
function TooltipContainer.didMount(component)
	component.maid:GiveTask(EzUtils.getViewportSizeChangedSignal():Connect(function()
		local currentIsSmallScreen = EzUtils.isSmallScreen()
		local currentIsTouch = InputUtils.isTouch()
		if currentIsSmallScreen ~= component.state.smallScreen or currentIsTouch ~= component.state.touchControls then
			component:setState({
				smallScreen = currentIsSmallScreen,
				touchControls = currentIsTouch
			})
		end
	end))
end
return RoactRodux.connect(function(tooltipConfig, state)
	local tooltipProps = {
		text = tooltipConfig.tooltipConfig.text
	}
	tooltipProps.visible = state.visible and tooltipConfig.tooltipConfig.visible
	return tooltipProps
end)(TooltipContainer)
