local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Grid = require(ReplicatedStorage.EzUi.Grid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local function button(buttonConfig)
	local buttonProperties = {
		BorderSizePixel = 1,
		BorderColor3 = Color3.new(0.3, 0.3, 0.3),
		BackgroundTransparency = 0
	}
	buttonProperties.BackgroundColor3 = buttonConfig.color or Color3.new(0.1, 0.1, 0.1)
	buttonProperties.Size = buttonConfig.size
	buttonProperties.Position = buttonConfig.position
	buttonProperties.Text = ""
	buttonProperties.Selectable = true
	buttonProperties[Roact.Event.Activated] = buttonConfig.onClicked
	return createElement("TextButton", buttonProperties, {
		Title = createElement("TextLabel", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(0.9, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = buttonConfig.title,
			Font = Enum.Font.LuckiestGuy,
			LineHeight = 0.7,
			TextScaled = true,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			ZIndex = 10
		})
	})
end
local KeypadComponent = Roact.PureComponent:extend("Keypad")
KeypadComponent.defaultProps = {
	anchorPoint = Vector2.new(0.5, 0.5),
	position = UDim2.new(0.5, 0, 0.5, 0),
	title = "Keypad"
}
function KeypadComponent.init(component)
	component:setState({
		code = ""
	})
end
function KeypadComponent.render(component)
	local buttonsList = {}
	for i = 1, 9 do
		table.insert(buttonsList, {
			title = tostring(i),
			onClicked = function()
				if component.props.onClicked then
					component.props.onClicked(i)
				end
				local stateUpdate = {}
				stateUpdate.code = component.state.code .. tostring(i)
				component:setState(stateUpdate)
			end
		})
	end
	table.insert(buttonsList, {
		title = "Clear",
		color = Color3.fromRGB(235, 60, 0),
		onClicked = function()
			if component.props.onClicked then
				component.props.onClicked(-2)
			end
			component:setState({
				code = ""
			})
		end
	})
	table.insert(buttonsList, {
		title = tostring(0),
		onClicked = function()
			if component.props.onClicked then
				component.props.onClicked(0)
			end
			component:setState({
				code = component.state.code .. tostring(0)
			})
		end
	})
	table.insert(buttonsList, {
		title = "Enter",
		color = Color3.fromRGB(25, 200, 53),
		onClicked = function()
			local code = component.state.code
			if component.props.onClicked then
				component.props.onClicked(-1)
			end
			if component.props.onSubmit then
				component.props.onSubmit(code)
			end
			component:setState({
				code = ""
			})
		end
	})
	return createElement("Frame", {
		BackgroundTransparency = 0,
		BackgroundColor3 = Color3.new(51/255, 51/255, 51/255),
		BorderSizePixel = 0,
		Size = component.props.size,
		Position = component.props.position,
		AnchorPoint = component.props.anchorPoint
	}, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 0.8333333333333333
		}),
		Close = createElement("ImageButton", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://4933143781",
			AnchorPoint = Vector2.new(0.5, 0.5),
			ZIndex = 3,
			Position = UDim2.new(0, 0, 0),
			Size = UDim2.new(0.05, 0, 0.05, 0),
			Selectable = true,
			[Roact.Event.MouseButton1Down] = component.props.onClickClose
		}, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		}),
		Code = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0.08333333333333333, 0),
			Position = UDim2.new(0, 0, 0.9166666666666666, 0)
		}, {
			Title = createElement("TextLabel", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(0.9, 0, 0.7, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = component.state.code,
				Font = Enum.Font.LuckiestGuy,
				LineHeight = 0.7,
				TextScaled = true,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				ZIndex = 10
			})
		}),
		Title = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0, 0, 0, 0)
		}, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 10
			}),
			Title = createElement("TextLabel", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(0.9, 0, 0.7, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = component.props.title or "",
				Font = Enum.Font.LuckiestGuy,
				LineHeight = 0.7,
				TextScaled = true,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				ZIndex = 10
			}, {
				UIStroke = createElement("UIStroke", {
					Color = Color3.new(0.1, 0.1, 0.1),
					Thickness = 2,
					Enabled = component.props.active
				})
			})
		}),
		Buttons = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0.8333333333333333, 0),
			Position = UDim2.new(0, 0, 0.08333333333333333, 0)
		}, {
			Grid = Roact.createElement(Grid, {
				aspectRatio = 1,
				paddingRatio = 100,
				rowsPerPage = 4,
				colsPerRow = 3,
				component = button,
				items = buttonsList
			})
		})
	})
end
function KeypadComponent.didMount(component)
	component:setState({
		code = ""
	})
end
return KeypadComponent
