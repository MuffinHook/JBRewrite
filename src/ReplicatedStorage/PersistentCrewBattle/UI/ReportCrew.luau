-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local PersistentCrewBattleConsts = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local local1 = Roact.PureComponent:extend("ReportCrew")
local1.defaultProps = {
	position = UDim2.fromScale(0.5, 0.5),
	size = UDim2.fromScale(0.9, 0.9)
}
function local1.init(self)
	self.explainBoxRef = Roact.createRef()
	self.reportButtons = PersistentCrewBattleConsts.CLAN_REPORT_OPTIONS
	self:setState({
		selectedButton = Roact.None
	})
	function self.close()
		self.explainBoxRef:getValue().Text = ""
		self:setState({
			selectedButton = Roact.None
		})
		self.props.onClose()
	end
	function self.attemptSubmit()
		if self.state.selectedButton ~= nil then
			local Text = self.explainBoxRef:getValue().Text
			self.props.onSubmit(self.state.selectedButton.name, Text)
			self.close()
		end
	end
end
function local1.render(self)
	local local1 = Color3.new(51/255, 51/255, 51/255)
	local function button(self)
		return createElement(PaddedContainer, {
			size = self.size,
			position = self.position,
			backgroundTransparency = 1,
			paddingTop = 0.5,
			paddingBottom = 0.5,
			paddingLeft = 0.5,
			paddingRight = 0.5
		}, {
			Button = createElement("TextButton", {
				AutoButtonColor = not self.disabled,
				BackgroundColor3 = self.bgColor,
				BackgroundTransparency = 0,
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.fromScale(0, 0.5),
				AnchorPoint = Vector2.new(0, 0.5),
				Text = "",
				TextScaled = true,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextXAlignment = Enum.TextXAlignment.Left,
				Selectable = true,
				[Roact.Event.Activated] = self.onClicked
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
						Text = self.text,
						LineHeight = self.lineHeight,
						Font = self.font,
						TextScaled = true,
						TextColor3 = Color3.fromRGB(255, 255, 255)
					})
				})
			})
		})
	end
	local t = {}
	for local4, local5 in self.reportButtons do
		local local2, local3
		local2 = self.state.selectedButton == local5
		local table2 = {
			size = UDim2.fromScale(1, 1 / #self.reportButtons),
			position = UDim2.fromScale(0, 1 / #self.reportButtons * (local4 - 1)),
			text = local5.title,
			font = Enum.Font.FredokaOne
		}
		local3 = if local2 then Color3.fromRGB(251, 121, 121) else Color3.fromRGB(88, 172, 246)
		table2.bgColor = local3
		function table2.onClicked()
			self:setState({
				selectedButton = local5
			})
		end
		table.insert(t, button(table2))
	end
	local table2 = {
		BackgroundTransparency = 1,
		Size = self.props.size,
		Position = self.props.position,
		AnchorPoint = Vector2.new(0.5, 0.5)
	}
	local table3 = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 0.75
		})
	}
	local table5 = {
		Header = createElement(PaddedContainer, {
			backgroundColor = local1,
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
			backgroundColor = local1,
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
							[Roact.Ref] = self.explainBoxRef
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
	local table6 = {
		backgroundColor = local1,
		size = UDim2.fromScale(1, 0.15),
		position = UDim2.fromScale(0, 0.85),
		paddingTop = 0.5
	}
	local table7 = {
		Corner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	}
	local table8 = {
		backgroundTransparency = 1,
		size = UDim2.fromScale(1, 0.7),
		paddingTop = 0.5,
		paddingBottom = 0.5,
		paddingLeft = 0.5,
		paddingRight = 0.5
	}
	local table9 = {
		NevermindButton = button({
			text = "Nevermind",
			size = UDim2.fromScale(0.6, 1),
			font = Enum.Font.LuckiestGuy,
			lineHeight = 0.7,
			bgColor = Color3.fromRGB(88, 172, 246),
			onClicked = self.close
		})
	}
	local table10 = {
		text = "Submit",
		size = UDim2.fromScale(0.4, 1),
		position = UDim2.fromScale(0.6, 0),
		font = Enum.Font.LuckiestGuy,
		lineHeight = 0.7
	}
	table10.disabled = self.state.selectedButton == nil
	table10.bgColor = if self.state.selectedButton == nil then Color3.new(0.5, 0.5, 0.5) else Color3.fromRGB(251, 121, 121)
	table10.onClicked = self.attemptSubmit
	table9.SubmitButton = button(table10)
	table7.Buttons = createElement(PaddedContainer, table8, table9)
	table7.Help = createElement(PaddedContainer, {
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
	table5.Footer = createElement(PaddedContainer, table6, table7)
	table3.Container = createElement(PaddedContainer, {
		backgroundTransparency = 1,
		aspectRatio = 0.75,
		verticalPaddingRatio = 85.33333333333333,
		paddingNone = true
	}, table5)
	return createElement("Frame", table2, table3)
end
return local1
