local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Grid = require(ReplicatedStorage.EzUi.Grid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local function button(p1) --[[ Line: 6 | Upvalues: createElement (copy), Roact (copy) ]]
	local t = {
		BorderSizePixel = 1,
		BorderColor3 = Color3.new(0.3, 0.3, 0.3),
		BackgroundTransparency = 0
	}
	t.BackgroundColor3 = p1.color or Color3.new(0.1, 0.1, 0.1)
	t.Size = p1.size
	t.Position = p1.position
	t.Text = ""
	t.Selectable = true
	t[Roact.Event.Activated] = p1.onClicked
	return createElement("TextButton", t, {
		Title = createElement("TextLabel", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(0.9, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = p1.title,
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
local v1 = Roact.PureComponent:extend("Keypad")
v1.defaultProps = {
	anchorPoint = Vector2.new(0.5, 0.5),
	position = UDim2.new(0.5, 0, 0.5, 0),
	title = "Keypad"
}
function v1.init(p1) --[[ Line: 42 ]]
	p1:setState({
		code = ""
	})
end
function v1.render(p1) --[[ Line: 47 | Upvalues: createElement (copy), Roact (copy), Grid (copy), button (copy) ]]
	local t = {}
	for i = 1, 9 do
		table.insert(t, {
			title = tostring(i),
			onClicked = function() --[[ Name: onClicked | Line: 52 | Upvalues: p1 (copy), i (copy) ]]
				if p1.props.onClicked then
					p1.props.onClicked(i)
				end
				local t = {}
				t.code = p1.state.code .. tostring(i)
				p1:setState(t)
			end
		})
	end
	table.insert(t, {
		title = "Clear",
		color = Color3.fromRGB(235, 60, 0),
		onClicked = function() --[[ Name: onClicked | Line: 65 | Upvalues: p1 (copy) ]]
			if p1.props.onClicked then
				p1.props.onClicked(-2)
			end
			p1:setState({
				code = ""
			})
		end
	})
	table.insert(t, {
		title = tostring(0),
		onClicked = function() --[[ Name: onClicked | Line: 76 | Upvalues: p1 (copy) ]]
			if p1.props.onClicked then
				p1.props.onClicked(0)
			end
			p1:setState({
				code = p1.state.code .. tostring(0)
			})
		end
	})
	table.insert(t, {
		title = "Enter",
		color = Color3.fromRGB(25, 200, 53),
		onClicked = function() --[[ Name: onClicked | Line: 88 | Upvalues: p1 (copy) ]]
			local code = p1.state.code
			if p1.props.onClicked then
				p1.props.onClicked(-1)
			end
			if p1.props.onSubmit then
				p1.props.onSubmit(code)
			end
			p1:setState({
				code = ""
			})
		end
	})
	return createElement("Frame", {
		BackgroundTransparency = 0,
		BackgroundColor3 = Color3.new(51/255, 51/255, 51/255),
		BorderSizePixel = 0,
		Size = p1.props.size,
		Position = p1.props.position,
		AnchorPoint = p1.props.anchorPoint
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
			[Roact.Event.MouseButton1Down] = p1.props.onClickClose
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
				Text = p1.state.code,
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
				Text = p1.props.title or "",
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
					Enabled = p1.props.active
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
				items = t
			})
		})
	})
end
function v1.didMount(p1) --[[ Line: 195 ]]
	p1:setState({
		code = ""
	})
end
return v1