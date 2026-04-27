local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local Roact = require(ReplicatedStorage.Roact)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local createElement = Roact.createElement
local PlacerButton = Roact.PureComponent:extend("PlacerButton")
function PlacerButton.init(self)
	self:setState({
		hovered = false,
		pressed = false
	})
	function self.onMouseEnter()
		self:setState({
			hovered = true
		})
	end
	function self.onMouseLeave()
		self:setState({
			hovered = false
		})
	end
	function self.onMouseDown()
		self:setState({
			pressed = true
		})
		if self.props.onMouseDown then
			self.props.onMouseDown()
		end
	end
	function self.onMouseUp()
		self:setState({
			pressed = false
		})
		if self.props.onMouseUp then
			self.props.onMouseUp()
		end
	end
end
function PlacerButton.render(self)
	local state = self.state
	local bgColor = self.props.bgColor
	if state.pressed then
		bgColor = ColorUtils.brightenBy(bgColor, -0.2)
	elseif state.hovered then
		bgColor = ColorUtils.brightenBy(bgColor, -0.1)
	end
	local buttonChildren = {}
	buttonChildren.Icon = self.props.icon and createElement("ImageButton", {
		BackgroundTransparency = 1,
		Image = self.props.icon,
		Size = UDim2.fromScale(1, 1),
		ImageColor3 = ColorUtils.brightenBy(bgColor, -0.7),
		Selectable = true,
		[Roact.Event.Activated] = self.props.onClick,
		[Roact.Event.MouseEnter] = self.onMouseEnter,
		[Roact.Event.MouseLeave] = self.onMouseLeave,
		[Roact.Event.SelectionGained] = self.onMouseEnter,
		[Roact.Event.SelectionLost] = self.onMouseLeave,
		[Roact.Event.MouseButton1Down] = self.onMouseDown,
		[Roact.Event.MouseButton1Up] = self.onMouseUp
	})
	buttonChildren.Button = self.props.text and createElement("TextButton", {
		BackgroundTransparency = 1,
		Text = "",
		Size = UDim2.fromScale(1, 1),
		Selectable = true,
		[Roact.Event.Activated] = self.props.onClick,
		[Roact.Event.MouseEnter] = self.onMouseEnter,
		[Roact.Event.MouseLeave] = self.onMouseLeave,
		[Roact.Event.SelectionGained] = self.onMouseEnter,
		[Roact.Event.SelectionLost] = self.onMouseLeave,
		[Roact.Event.MouseButton1Down] = self.onMouseDown,
		[Roact.Event.MouseButton1Up] = self.onMouseUp
	}, {
		Title = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Text = self.props.text,
			Size = UDim2.fromScale(0.8, 0.8),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Font = Enum.Font.LuckiestGuy,
			LineHeight = 0.7,
			TextScaled = true,
			TextColor3 = ColorUtils.brightenBy(self.props.bgColor, -0.7)
		})
	})
	buttonChildren.UICorner = createElement("UICorner", {
		CornerRadius = UDim.new(0, 4)
	})
	local keyCode = self.props.keyCode
	if keyCode then
		local keyCodeLabelProps = {
			BackgroundTransparency = 1
		}
		keyCodeLabelProps.Text = tostring(self.props.keyCode)
		keyCodeLabelProps.Font = Enum.Font.SourceSansBold
		keyCodeLabelProps.TextColor3 = ColorUtils.brightenBy(self.props.bgColor, -0.5)
		keyCodeLabelProps.TextScaled = true
		keyCodeLabelProps.Size = UDim2.fromScale(0.4, 0.4)
		keyCodeLabelProps.Position = UDim2.fromScale(1, 1)
		keyCodeLabelProps.AnchorPoint = Vector2.new(1, 1)
		keyCodeLabelProps.ZIndex = 3
		keyCode = createElement("TextLabel", keyCodeLabelProps, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		})
	end
	buttonChildren.KeyCodeContext = keyCode
	return createElement(PaddedContainer, {
		aspectRatio = self.props.aspectRatio,
		verticalPaddingRatio = self.props.verticalPaddingRatio,
		backgroundColor = bgColor,
		size = self.props.size,
		position = self.props.position,
		paddingTop = 0.5,
		paddingBottom = 0.5,
		paddingLeft = 0.5,
		paddingRight = 0.5
	}, buttonChildren)
end
local function buttons(buttonConfig)
	local buttonElements = {
		Left = createElement(PlacerButton, {
			exposePaddedContainerProps = true,
			bgColor = buttonConfig.bgColor,
			icon = "rbxassetid://6535451691",
			onMouseDown = buttonConfig.onDownLeft,
			onMouseUp = buttonConfig.onUpLeft,
			keyCode = "Q",
			size = UDim2.fromScale(1 / buttonConfig.aspectRatio, 1),
			position = UDim2.fromScale(0, 0)
		}),
		Right = createElement(PlacerButton, {
			exposePaddedContainerProps = true,
			bgColor = buttonConfig.bgColor,
			icon = "rbxassetid://6535451364",
			onMouseDown = buttonConfig.onDownRight,
			onMouseUp = buttonConfig.onUpRight,
			keyCode = "E",
			size = UDim2.fromScale(1 / buttonConfig.aspectRatio, 1),
			position = UDim2.fromScale(1 - 1 / buttonConfig.aspectRatio, 0)
		})
	}
	local deleteButtonProps = {
		exposePaddedContainerProps = true,
		bgColor = buttonConfig.bgColor,
		text = "Delete",
		onClick = buttonConfig.onClickDelete
	}
	deleteButtonProps.size = if buttonConfig.showPlace then UDim2.fromScale(0.5 - 1 / buttonConfig.aspectRatio, 1) else UDim2.fromScale(1 - 2 / buttonConfig.aspectRatio, 1)
	deleteButtonProps.position = UDim2.fromScale(1 / buttonConfig.aspectRatio, 0)
	buttonElements.Delete = createElement(PlacerButton, deleteButtonProps)
	buttonElements.Place = buttonConfig.showPlace and createElement(PlacerButton, {
		exposePaddedContainerProps = true,
		bgColor = buttonConfig.bgColor,
		text = "Place",
		onClick = buttonConfig.onClickPlace,
		size = UDim2.fromScale(0.5 - 1 / buttonConfig.aspectRatio, 1),
		position = UDim2.fromScale(0.5, 0)
	})
	return createElement(PaddedContainer, {
		backgroundTransparency = 1,
		aspectRatio = buttonConfig.aspectRatio,
		verticalPaddingRatio = buttonConfig.verticalPaddingRatio,
		paddingTop = 0,
		paddingBottom = 0,
		paddingLeft = 0,
		paddingRight = 0
	}, buttonElements)
end
local PlacerApp = Roact.PureComponent:extend("PlacerApp")
function PlacerApp.init(self) end
function PlacerApp.render(self)
	return createElement(PaddedContainer, {
		backgroundTransparency = 0.8,
		backgroundColor = Color3.new(0/255, 0/255, 0/255),
		aspectRatio = self.props.aspectRatio,
		verticalPaddingRatio = self.props.verticalPaddingRatio,
		paddingTop = 0,
		paddingBottom = 0,
		paddingLeft = 0,
		paddingRight = 0
	}, {
		UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
			AspectRatio = self.props.aspectRatio
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
				onDownLeft = self.props.onDownLeft,
				onUpLeft = self.props.onUpLeft,
				onDownRight = self.props.onDownRight,
				onUpRight = self.props.onUpRight,
				onClickDelete = self.props.onClickDelete,
				onClickPlace = self.props.onClickPlace,
				showPlace = self.props.showPlace
			})
		})
	})
end
return PlacerApp
