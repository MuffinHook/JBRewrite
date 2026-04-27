local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local topBarButtonsComponent = require(script.Parent.topBarButtonsComponent)
local SafeComponent = require(script.Parent.SafeComponent)
local paddedScrollingGrid = require(script.Parent.paddedScrollingGrid)
local color = Roact.PureComponent:extend("SafesInventory")
function color.render(props)
	local darkGrayColor = Color3.new(51/255, 51/255, 51/255)
	return createElement("Frame", {
		BackgroundTransparency = 0.8,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		Size = props.size,
		Position = props.position,
		AnchorPoint = props.anchorPoint
	}, {
		Container = createElement(PaddedContainer, {
			backgroundTransparency = 1,
			aspectRatio = 1.8,
			verticalPaddingRatio = 128
		}, {
			TopBar = createElement(PaddedContainer, {
				backgroundColor = darkGrayColor,
				paddingTop = 0,
				paddingLeft = 0,
				paddingRight = 0,
				paddingBottom = 0.5,
				size = UDim2.new(1, 0, 0.1, 0)
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				Inner = createElement(PaddedContainer, {
					backgroundTransparency = 1
				}, {
					Title = createElement("Frame", {
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
						Size = UDim2.new(0.5, 0, 1, 0),
						Position = UDim2.new(0, 0, 0, 0)
					}, {
						Text = createElement("TextLabel", {
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 1.25, 0),
							Position = UDim2.new(0.5, 0, 0.5, 0),
							AnchorPoint = Vector2.new(0.5, 0.5),
							Text = "MY SAFES",
							TextXAlignment = Enum.TextXAlignment.Left,
							Font = Enum.Font.Bangers,
							LineHeight = 1,
							TextScaled = true,
							TextColor3 = Color3.new(255/255, 255/255, 255/255)
						})
					}),
					Buttons = createElement(topBarButtonsComponent, {
						exposePaddedContainerProps = true,
						nextPageTitle = "BUY SAFES",
						onSelectToggle = props.onSelectBuySafes,
						onSelectExit = props.onSelectExit
					})
				})
			}),
			Left = createElement(PaddedContainer, {
				backgroundColor = darkGrayColor,
				paddingTop = 0.5,
				paddingLeft = 0,
				paddingRight = 0.5,
				paddingBottom = 0,
				size = UDim2.new(0.12, 0, 0.9, 0),
				position = UDim2.new(0, 0, 0.1, 0)
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				Icons = createElement(paddedScrollingGrid, {
					exposePaddedContainerProps = true,
					paddingRatio = 32,
					rowsPerPage = 4.5,
					colsPerRow = 1,
					component = SafeComponent,
					items = props.sidebarItems,
					metadata = props.sidebarItemMetadata
				})
			}),
			Body = createElement(PaddedContainer, {
				backgroundColor = darkGrayColor,
				paddingTop = 0.5,
				paddingLeft = 0.5,
				paddingRight = 0.5,
				paddingBottom = 0,
				size = UDim2.new(0.88, 0, 0.9, 0),
				position = UDim2.new(0.12, 0, 0.1, 0)
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				Icons = createElement(paddedScrollingGrid, {
					exposePaddedContainerProps = true,
					paddingRatio = 32,
					rowsPerPage = 3.5,
					colsPerRow = 6,
					component = SafeComponent,
					items = props.items,
					metadata = props.itemMetadata
				})
			})
		}),
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 1.8
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	})
end
return color
