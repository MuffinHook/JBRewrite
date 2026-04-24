-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
local Roact = require(ReplicatedStorage.Roact)
local Tooltip = require(script.Parent.Tooltip)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("TooltipContainer")
function v1.init(p1)
	p1:setState({
		smallScreen = EzUtils.isSmallScreen(),
		touchControls = InputUtils.isTouch()
	})
	p1.maid = Maid.new()
end
function v1.render(p1)
	local t = {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1)
	}
	local t2 = {
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
	local t3 = {
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		LayoutOrder = 3,
		Position = UDim2.fromScale(0.2, 0)
	}
	t3.Size = UDim2.fromScale(if p1.state.smallScreen or p1.state.touchControls then 0.7 else 0.4, 1)
	t2.Container = createElement("Frame", t3, {
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
	t2.TooltipContainer = createElement("Frame", {
		BackgroundTransparency = 1,
		LayoutOrder = 2,
		Size = UDim2.fromScale(1, 1)
	}, {
		Tooltip = createElement(Tooltip, p1.props)
	})
	return createElement("Frame", t, t2)
end
function v1.didMount(p1)
	p1.maid:GiveTask(EzUtils.getViewportSizeChangedSignal():Connect(function()
		local v1 = EzUtils.isSmallScreen()
		local v2 = InputUtils.isTouch()
		if v1 ~= p1.state.smallScreen or v2 ~= p1.state.touchControls then
			p1:setState({
				smallScreen = v1,
				touchControls = v2
			})
		end
	end))
end
return RoactRodux.connect(function(p1, p2)
	local t = {
		text = p1.tooltipConfig.text
	}
	t.visible = p2.visible and p1.tooltipConfig.visible
	return t
end)(v1)
