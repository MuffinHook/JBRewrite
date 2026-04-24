-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local Roact = require(ReplicatedStorage.Roact)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("PlacerButton")
function v1.init(p1)
	p1:setState({
		hovered = false,
		pressed = false
	})
	function p1.onMouseEnter()
		p1:setState({
			hovered = true
		})
	end
	function p1.onMouseLeave()
		p1:setState({
			hovered = false
		})
	end
	function p1.onMouseDown()
		p1:setState({
			pressed = true
		})
		if p1.props.onMouseDown then
			p1.props.onMouseDown()
		end
	end
	function p1.onMouseUp()
		p1:setState({
			pressed = false
		})
		if p1.props.onMouseUp then
			p1.props.onMouseUp()
		end
	end
end
function v1.render(p1)
	local state = p1.state
	local bgColor = p1.props.bgColor
	if state.pressed then
		bgColor = ColorUtils.brightenBy(bgColor, -0.2)
	elseif state.hovered then
		bgColor = ColorUtils.brightenBy(bgColor, -0.1)
	end
	local t2 = {}
	t2.Icon = p1.props.icon and createElement("ImageButton", {
		BackgroundTransparency = 1,
		Image = p1.props.icon,
		Size = UDim2.fromScale(1, 1),
		ImageColor3 = ColorUtils.brightenBy(bgColor, -0.7),
		Selectable = true,
		[Roact.Event.Activated] = p1.props.onClick,
		[Roact.Event.MouseEnter] = p1.onMouseEnter,
		[Roact.Event.MouseLeave] = p1.onMouseLeave,
		[Roact.Event.SelectionGained] = p1.onMouseEnter,
		[Roact.Event.SelectionLost] = p1.onMouseLeave,
		[Roact.Event.MouseButton1Down] = p1.onMouseDown,
		[Roact.Event.MouseButton1Up] = p1.onMouseUp
	})
	t2.Button = p1.props.text and createElement("TextButton", {
		BackgroundTransparency = 1,
		Text = "",
		Size = UDim2.fromScale(1, 1),
		Selectable = true,
		[Roact.Event.Activated] = p1.props.onClick,
		[Roact.Event.MouseEnter] = p1.onMouseEnter,
		[Roact.Event.MouseLeave] = p1.onMouseLeave,
		[Roact.Event.SelectionGained] = p1.onMouseEnter,
		[Roact.Event.SelectionLost] = p1.onMouseLeave,
		[Roact.Event.MouseButton1Down] = p1.onMouseDown,
		[Roact.Event.MouseButton1Up] = p1.onMouseUp
	}, {
		Title = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Text = p1.props.text,
			Size = UDim2.fromScale(0.8, 0.8),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Font = Enum.Font.LuckiestGuy,
			LineHeight = 0.7,
			TextScaled = true,
			TextColor3 = ColorUtils.brightenBy(p1.props.bgColor, -0.7)
		})
	})
	t2.UICorner = createElement("UICorner", {
		CornerRadius = UDim.new(0, 4)
	})
	local keyCode = p1.props.keyCode
	if keyCode then
		local t3 = {
			BackgroundTransparency = 1
		}
		t3.Text = tostring(p1.props.keyCode)
		t3.Font = Enum.Font.SourceSansBold
		t3.TextColor3 = ColorUtils.brightenBy(p1.props.bgColor, -0.5)
		t3.TextScaled = true
		t3.Size = UDim2.fromScale(0.4, 0.4)
		t3.Position = UDim2.fromScale(1, 1)
		t3.AnchorPoint = Vector2.new(1, 1)
		t3.ZIndex = 3
		keyCode = createElement("TextLabel", t3, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		})
	end
	t2.KeyCodeContext = keyCode
	return createElement(PaddedContainer, {
		aspectRatio = p1.props.aspectRatio,
		verticalPaddingRatio = p1.props.verticalPaddingRatio,
		backgroundColor = bgColor,
		size = p1.props.size,
		position = p1.props.position,
		paddingTop = 0.5,
		paddingBottom = 0.5,
		paddingLeft = 0.5,
		paddingRight = 0.5
	}, t2)
end
local function buttons(p1)
	local t2 = {
		Left = createElement(v1, {
			exposePaddedContainerProps = true,
			bgColor = p1.bgColor,
			icon = "rbxassetid://6535451691",
			onMouseDown = p1.onDownLeft,
			onMouseUp = p1.onUpLeft,
			keyCode = "Q",
			size = UDim2.fromScale(1 / p1.aspectRatio, 1),
			position = UDim2.fromScale(0, 0)
		}),
		Right = createElement(v1, {
			exposePaddedContainerProps = true,
			bgColor = p1.bgColor,
			icon = "rbxassetid://6535451364",
			onMouseDown = p1.onDownRight,
			onMouseUp = p1.onUpRight,
			keyCode = "E",
			size = UDim2.fromScale(1 / p1.aspectRatio, 1),
			position = UDim2.fromScale(1 - 1 / p1.aspectRatio, 0)
		})
	}
	local t3 = {
		exposePaddedContainerProps = true,
		bgColor = p1.bgColor,
		text = "Delete",
		onClick = p1.onClickDelete
	}
	t3.size = if p1.showPlace then UDim2.fromScale(0.5 - 1 / p1.aspectRatio, 1) else UDim2.fromScale(1 - 2 / p1.aspectRatio, 1)
	t3.position = UDim2.fromScale(1 / p1.aspectRatio, 0)
	t2.Delete = createElement(v1, t3)
	t2.Place = p1.showPlace and createElement(v1, {
		exposePaddedContainerProps = true,
		bgColor = p1.bgColor,
		text = "Place",
		onClick = p1.onClickPlace,
		size = UDim2.fromScale(0.5 - 1 / p1.aspectRatio, 1),
		position = UDim2.fromScale(0.5, 0)
	})
	return createElement(PaddedContainer, {
		backgroundTransparency = 1,
		aspectRatio = p1.aspectRatio,
		verticalPaddingRatio = p1.verticalPaddingRatio,
		paddingTop = 0,
		paddingBottom = 0,
		paddingLeft = 0,
		paddingRight = 0
	}, t2)
end
local v2 = Roact.PureComponent:extend("PlacerApp")
function v2.init(p1) end
function v2.render(p1)
	return createElement(PaddedContainer, {
		backgroundTransparency = 0.8,
		backgroundColor = Color3.new(0/255, 0/255, 0/255),
		aspectRatio = p1.props.aspectRatio,
		verticalPaddingRatio = p1.props.verticalPaddingRatio,
		paddingTop = 0,
		paddingBottom = 0,
		paddingLeft = 0,
		paddingRight = 0
	}, {
		UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
			AspectRatio = p1.props.aspectRatio
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Buttons = createElement(PaddedContainer, {
			backgroundTransparency = 1,
			paddingTop = 0.5,
			paddingBottom = 0.5,
			paddingLeft = 0.5,
			paddingRight = 0.5
		}, {
			Buttons = createElement(buttons, {
				exposePaddedContainerProps = true,
				bgColor = Color3.fromRGB(255, 202, 11),
				onDownLeft = p1.props.onDownLeft,
				onUpLeft = p1.props.onUpLeft,
				onDownRight = p1.props.onDownRight,
				onUpRight = p1.props.onUpRight,
				onClickDelete = p1.props.onClickDelete,
				onClickPlace = p1.props.onClickPlace,
				showPlace = p1.props.showPlace
			})
		})
	})
end
return v2
