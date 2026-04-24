-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local PersistentCrewBattleConsts = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("ReportCrew")
v1.defaultProps = {
	position = UDim2.fromScale(0.5, 0.5),
	size = UDim2.fromScale(0.9, 0.9)
}
function v1.init(p1)
	p1.explainBoxRef = Roact.createRef()
	p1.reportButtons = PersistentCrewBattleConsts.CLAN_REPORT_OPTIONS
	p1:setState({
		selectedButton = Roact.None
	})
	function p1.close()
		p1.explainBoxRef:getValue().Text = ""
		p1:setState({
			selectedButton = Roact.None
		})
		p1.props.onClose()
	end
	function p1.attemptSubmit()
		if p1.state.selectedButton ~= nil then
			local Text = p1.explainBoxRef:getValue().Text
			p1.props.onSubmit(p1.state.selectedButton.name, Text)
			p1.close()
		end
	end
end
function v1.render(p1)
	local v1 = Color3.new(51/255, 51/255, 51/255)
	local function button(p1)
		return createElement(PaddedContainer, {
			size = p1.size,
			position = p1.position,
			backgroundTransparency = 1,
			paddingTop = 0.5,
			paddingBottom = 0.5,
			paddingLeft = 0.5,
			paddingRight = 0.5
		}, {
			Button = createElement("TextButton", {
				AutoButtonColor = not p1.disabled,
				BackgroundColor3 = p1.bgColor,
				BackgroundTransparency = 0,
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.fromScale(0, 0.5),
				AnchorPoint = Vector2.new(0, 0.5),
				Text = "",
				TextScaled = true,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextXAlignment = Enum.TextXAlignment.Left,
				Selectable = true,
				[Roact.Event.Activated] = p1.onClicked
			}, {
				Stroke = createElement("UIStroke", {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Thickness = 1.5,
					Color = Color3.new(0.1, 0.1, 0.1)
				}),
				Corner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 8)
				}),
				Inner = createElement(PaddedContainer, {
					backgroundTransparency = 1,
					paddingTop = 1,
					paddingBottom = 1,
					paddingLeft = 2,
					paddingRight = 2
				}, {
					Title = createElement("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 0.9),
						Position = UDim2.fromScale(0, 0.5),
						AnchorPoint = Vector2.new(0, 0.5),
						Text = p1.text,
						LineHeight = p1.lineHeight,
						Font = p1.font,
						TextScaled = true,
						TextColor3 = Color3.fromRGB(255, 255, 255)
					})
				})
			})
		})
	end
	local t = {}
	for v4, v5 in p1.reportButtons do
		local v2, v3
		v2 = p1.state.selectedButton == v5
		local t2 = {
			size = UDim2.fromScale(1, 1 / #p1.reportButtons),
			position = UDim2.fromScale(0, 1 / #p1.reportButtons * (v4 - 1)),
			text = v5.title,
			font = Enum.Font.FredokaOne
		}
		v3 = if v2 then Color3.fromRGB(251, 121, 121) else Color3.fromRGB(88, 172, 246)
		t2.bgColor = v3
		function t2.onClicked()
			p1:setState({
				selectedButton = v5
			})
		end
		table.insert(t, button(t2))
	end
	local t2 = {
		BackgroundTransparency = 1,
		Size = p1.props.size,
		Position = p1.props.position,
		AnchorPoint = Vector2.new(0.5, 0.5)
	}
	local t3 = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 0.75
		})
	}
	local t5 = {
		Header = createElement(PaddedContainer, {
			backgroundColor = v1,
			size = UDim2.fromScale(1, 0.15),
			paddingBottom = 0.5
		}, {
			Corner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 4)
			}),
			Inner = createElement(PaddedContainer, {
				backgroundTransparency = 1,
				paddingTop = 2,
				paddingBottom = 2,
				paddingLeft = 2,
				paddingRight = 2
			}, {
				Title = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 0.9),
					Position = UDim2.fromScale(0, 0.5),
					AnchorPoint = Vector2.new(0, 0.5),
					Text = "Report Crew?",
					LineHeight = 0.7,
					Font = Enum.Font.LuckiestGuy,
					TextScaled = true,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextXAlignment = Enum.TextXAlignment.Left
				})
			})
		}),
		Body = createElement(PaddedContainer, {
			backgroundColor = v1,
			size = UDim2.fromScale(1, 0.7),
			position = UDim2.fromScale(0, 0.15),
			paddingTop = 0.5,
			paddingBottom = 0.5
		}, {
			Corner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 4)
			}),
			Inner = createElement(PaddedContainer, {
				backgroundTransparency = 1,
				paddingTop = 2,
				paddingBottom = 2,
				paddingLeft = 2,
				paddingRight = 2
			}, {
				Buttons = createElement(PaddedContainer, {
					backgroundTransparency = 1,
					size = UDim2.fromScale(1, 0.75),
					paddingBottom = 0.25,
					paddingTop = 0.5,
					paddingRight = 0.5,
					paddingLeft = 0.5
				}, t),
				Explain = createElement(PaddedContainer, {
					backgroundTransparency = 0,
					backgroundColor = Color3.fromRGB(150, 150, 150),
					size = UDim2.fromScale(1, 0.25),
					position = UDim2.fromScale(0, 0.75),
					paddingTop = 0.5
				}, {
					Corner = createElement("UICorner", {
						CornerRadius = UDim.new(0, 4)
					}),
					Inner = createElement(PaddedContainer, {
						backgroundTransparency = 1,
						paddingTop = 2,
						paddingBottom = 2,
						paddingLeft = 2,
						paddingRight = 2
					}, {
						Box = createElement("TextBox", {
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Size = UDim2.fromScale(1, 1),
							Font = Enum.Font.FredokaOne,
							TextScaled = true,
							ClearTextOnFocus = false,
							Text = "",
							TextWrapped = true,
							PlaceholderText = "Tell us more...",
							TextXAlignment = Enum.TextXAlignment.Left,
							TextYAlignment = Enum.TextYAlignment.Top,
							TextColor3 = Color3.fromRGB(255, 255, 255),
							[Roact.Ref] = p1.explainBoxRef
						}, {
							TextSizeConstraint = createElement("UITextSizeConstraint", {
								MinTextSize = 1,
								MaxTextSize = 20
							})
						})
					})
				})
			})
		})
	}
	local t6 = {
		backgroundColor = v1,
		size = UDim2.fromScale(1, 0.15),
		position = UDim2.fromScale(0, 0.85),
		paddingTop = 0.5
	}
	local t7 = {
		Corner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	}
	local t8 = {
		backgroundTransparency = 1,
		size = UDim2.fromScale(1, 0.7),
		paddingTop = 0.5,
		paddingBottom = 0.5,
		paddingLeft = 0.5,
		paddingRight = 0.5
	}
	local t9 = {
		NevermindButton = button({
			text = "Nevermind",
			size = UDim2.fromScale(0.6, 1),
			font = Enum.Font.LuckiestGuy,
			lineHeight = 0.7,
			bgColor = Color3.fromRGB(88, 172, 246),
			onClicked = p1.close
		})
	}
	local t10 = {
		text = "Submit",
		size = UDim2.fromScale(0.4, 1),
		position = UDim2.fromScale(0.6, 0),
		font = Enum.Font.LuckiestGuy,
		lineHeight = 0.7
	}
	t10.disabled = p1.state.selectedButton == nil
	t10.bgColor = if p1.state.selectedButton == nil then Color3.new(0.5, 0.5, 0.5) else Color3.fromRGB(251, 121, 121)
	t10.onClicked = p1.attemptSubmit
	t9.SubmitButton = button(t10)
	t7.Buttons = createElement(PaddedContainer, t8, t9)
	t7.Help = createElement(PaddedContainer, {
		backgroundTransparency = 1,
		size = UDim2.fromScale(1, 0.3),
		position = UDim2.fromScale(0, 0.7),
		paddingNone = true
	}, {
		Inner = createElement(PaddedContainer, {
			backgroundTransparency = 1,
			paddingNone = true
		}, {
			Title = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(0.8, 1.6),
				Position = UDim2.fromScale(0.5, 0.3),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = "All reports must be honest. If you are caught abusing this system, you may be banned from the game.",
				Font = Enum.Font.FredokaOne,
				TextScaled = true,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextXAlignment = Enum.TextXAlignment.Center
			})
		})
	})
	t5.Footer = createElement(PaddedContainer, t6, t7)
	t3.Container = createElement(PaddedContainer, {
		backgroundTransparency = 1,
		aspectRatio = 0.75,
		verticalPaddingRatio = 85.33333333333333,
		paddingNone = true
	}, t5)
	return createElement("Frame", t2, t3)
end
return v1
