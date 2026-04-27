local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local LicensePlate = Roact.PureComponent:extend("LicensePlate")
LicensePlate.defaultProps = {
	text = "JAILBRK"
}
function LicensePlate.init(self)
	self.boxRef = Roact.createRef()
end
function LicensePlate.render(self)
	return createElement("Frame", {
		BackgroundTransparency = 2/3,
		BackgroundColor3 = Color3.new(51/255, 51/255, 51/255),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = self.props.size,
		Position = self.props.position
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
			[Roact.Event.MouseButton1Down] = self.props.onClickClose
		}, {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		}),
		Input = createElement("Frame", {
			BackgroundTransparency = 2/3,
			BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
			Size = UDim2.new(0.8, 0, 1/3, 0),
			Position = UDim2.new(0.5, 0, 1/3, 0),
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
				PlaceholderText = self.props.text .. "...",
				Text = "",
				[Roact.Ref] = self.boxRef,
				[Roact.Change.Text] = function(textbox)
					textbox.Text = textbox.Text:upper():gsub("[^%w%s]", ""):sub(1, 7)
				end
			})
		}),
		Apply = createElement("TextButton", {
			BackgroundTransparency = 1/3,
			BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
			Size = UDim2.new(0.4, 0, 7/30, 0),
			Position = UDim2.new(0.5, 0, 23/30, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = "",
			[Roact.Event.MouseButton1Down] = function()
				if self.props.onClickApply then
					self.props.onClickApply(self.boxRef:getValue().Text)
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
return LicensePlate
