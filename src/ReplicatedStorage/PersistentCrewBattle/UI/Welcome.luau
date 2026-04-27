local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local TextButton = require(ReplicatedStorage.PersistentCrew.UI.TextButton)
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local PersistentCrewBattleConsts = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local WelcomeComponent = Roact.PureComponent:extend("Welcome")
function WelcomeComponent.render(self)
	return createElement("Frame", {
		BackgroundTransparency = 0.8,
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		Size = UDim2.new(0.36363636363636365, 0, 1, 0),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5)
	}, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 1.7777777777777777
		}),
		UICorners = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		ContainerMessage = createElement(PaddedContainer, {
			backgroundTransparency = 1,
			verticalPaddingRatio = 96,
			aspectRatio = 1.7777777777777777
		}, {
			Topbar = createElement(PaddedContainer, {
				backgroundTransparency = 0,
				backgroundColor = Color3.new(51/255, 51/255, 51/255),
				size = UDim2.new(1, 0, 0.25, 0),
				paddingTop = 0,
				paddingLeft = 0,
				paddingRight = 0,
				paddingBottom = 0.5,
				zIndex = 2
			}, {
				UICorners = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				Icon = createElement("ImageLabel", {
					BackgroundTransparency = 1,
					Image = "rbxassetid://12598895668",
					Size = UDim2.new(1, 0, 1.3, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0, 0.5),
					ZIndex = 3
				}, {
					UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
						AspectRatio = 2
					})
				}),
				TitleContainer = createElement(PaddedContainer, {
					backgroundTransparency = 1,
					size = UDim2.new(0.5, 0, 1, 0),
					position = UDim2.new(0.15, 0, 0, 0),
					paddingLeft = 2,
					paddingRight = 2,
					paddingTop = 2,
					paddingBottom = 2
				}, {
					Text = createElement("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 1, 0),
						Position = UDim2.new(0.5, 0, 0.5, 0),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Font = Enum.Font.FredokaOne,
						TextXAlignment = Enum.TextXAlignment.Left,
						Text = "Welcome!",
						LineHeight = 1,
						TextScaled = true,
						TextColor3 = Color3.new(255/255, 255/255, 255/255)
					})
				})
			}),
			Body = createElement(PaddedContainer, {
				backgroundTransparency = 0,
				backgroundColor = Color3.new(51/255, 51/255, 51/255),
				size = UDim2.new(1, 0, 0.6, 0),
				position = UDim2.new(0, 0, 0.25, 0),
				paddingTop = 0.5,
				paddingLeft = 0,
				paddingRight = 0,
				paddingBottom = 0.5
			}, {
				UICorners = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				BodyContainer = createElement(PaddedContainer, {
					backgroundTransparency = 1,
					size = UDim2.new(1, 0, 1, 0),
					position = UDim2.new(0, 0, 0, 0),
					paddingLeft = 2,
					paddingRight = 2,
					paddingTop = 2,
					paddingBottom = 2
				}, {
					Text = createElement("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 1, 0),
						Position = UDim2.new(0.5, 0, 0.5, 0),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Font = Enum.Font.FredokaOne,
						TextYAlignment = Enum.TextYAlignment.Top,
						TextXAlignment = Enum.TextXAlignment.Left,
						RichText = true,
						Text = ("\226\128\134- One crew becomes <font color=\"rgb(252, 40, 47)\">CRIMINALS</font>, the other <font color=\"rgb(42, 204, 255)\">POLICE</font>.\n- <font color=\"rgb(252, 40, 47)\">CRIMINALS</font>, rob <u>%d</u> of the <u>%d</u> locations listed!\n- <font color=\"rgb(42, 204, 255)\">POLICE</font>, slow them down!\n- Arrests & deaths count as <u>time penalties</u>.\n- Teams switch next round.\n- The quickest crew to speedrun will claim victory & climb the ranks!"):format(PersistentCrewBattleConsts.NUM_ROBBERIES_TO_FINISH_ROUND, PersistentCrewBattleConsts.NUM_ROBBERIES_AVAILABLE),
						LineHeight = 1,
						TextScaled = true,
						TextColor3 = Color3.new(255/255, 255/255, 255/255)
					})
				})
			}),
			Footer = createElement(PaddedContainer, {
				backgroundTransparency = 0,
				backgroundColor = Color3.new(51/255, 51/255, 51/255),
				position = UDim2.new(0, 0, 0.85, 0),
				size = UDim2.new(1, 0, 0.15, 0),
				paddingTop = 0.5,
				paddingLeft = 0,
				paddingRight = 0,
				paddingBottom = 0
			}, {
				UICorners = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				UIListLayout = createElement("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					SortOrder = Enum.SortOrder.LayoutOrder
				}),
				CloseContainer = createElement("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.new(0.2, 0, 1, 0),
					LayoutOrder = 10
				}, {
					Container = createElement(PaddedContainer, {
						backgroundTransparency = 1
					}, {
						Button = createElement(TextButton, {
							size = UDim2.new(1, 0, 1, 0),
							position = UDim2.new(1, 0, 0, 0),
							anchorPoint = Vector2.new(1, 0),
							text = "READY",
							backgroundColor = Color3.fromRGB(88, 172, 246),
							onClick = self.props.onClickClose
						})
					})
				})
			})
		})
	})
end
return WelcomeComponent
