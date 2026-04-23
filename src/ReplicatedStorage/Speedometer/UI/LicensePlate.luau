local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("LicensePlate")
v1.defaultProps = {
	text = "JAILBRK"
}
function v1.init(p1) --[[ Line: 9 | Upvalues: Roact (copy) ]]
	p1.boxRef = Roact.createRef()
end
function v1.render(p1) --[[ Line: 12 | Upvalues: createElement (copy), Roact (copy) ]]
	return createElement("Frame", {
		BackgroundTransparency = 0.6666666666666666,
		BackgroundColor3 = Color3.new(51/255, 51/255, 51/255),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = p1.props.size,
		Position = p1.props.position
	}, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 3
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0.125, 0)
		}),
		UIStroke = createElement("UIStroke", {
			Color = Color3.new(255/255, 255/255, 255/255),
			Thickness = 3
		}),
		Close = createElement("ImageButton", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://4933143781",
			AnchorPoint = Vector2.new(0.4, 0.4),
			ZIndex = 3,
			Position = UDim2.new(0, 0, 0),
			Size = UDim2.new(0.2, 0, 0.2, 0),
			Selectable = true,
			[Roact.Event.MouseButton1Down] = p1.props.onClickClose
		}, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		}),
		Input = createElement("Frame", {
			BackgroundTransparency = 0.6666666666666666,
			BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
			Size = UDim2.new(0.8, 0, 0.3333333333333333, 0),
			Position = UDim2.new(0.5, 0, 0.3333333333333333, 0),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0.125, 0)
			}),
			UIStroke = createElement("UIStroke", {
				Color = Color3.new(255/255, 255/255, 255/255),
				Thickness = 3
			}),
			Box = createElement("TextBox", {
				Size = UDim2.new(0.9, 0, 0.8, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.6, 0),
				BackgroundTransparency = 1,
				TextScaled = true,
				Font = Enum.Font.LuckiestGuy,
				TextColor3 = Color3.new(255/255, 255/255, 255/255),
				PlaceholderText = p1.props.text .. "...",
				Text = "",
				[Roact.Ref] = p1.boxRef,
				[Roact.Change.Text] = function(p1) --[[ Line: 69 ]]
					p1.Text = p1.Text:upper():gsub("[^%w%s]", ""):sub(1, 7)
				end
			})
		}),
		Apply = createElement("TextButton", {
			BackgroundTransparency = 0.3333333333333333,
			BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
			Size = UDim2.new(0.4, 0, 0.2333333333333333, 0),
			Position = UDim2.new(0.5, 0, 0.7666666666666666, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = "",
			[Roact.Event.MouseButton1Down] = function() --[[ Line: 85 | Upvalues: p1 (copy) ]]
				if p1.props.onClickApply then
					p1.props.onClickApply(p1.boxRef:getValue().Text)
				end
			end
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0.125, 0)
			}),
			UIStroke = createElement("UIStroke", {
				Color = Color3.new(255/255, 255/255, 255/255),
				Thickness = 3,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			}),
			Title = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.9, 0, 0.8, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.6, 0),
				TextScaled = true,
				Font = Enum.Font.LuckiestGuy,
				TextColor3 = Color3.new(255/255, 255/255, 255/255),
				Text = "Apply"
			})
		})
	})
end
return v1