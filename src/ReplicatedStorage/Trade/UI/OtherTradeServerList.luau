local ReplicatedStorage = game:GetService("ReplicatedStorage")
local store = require(ReplicatedStorage.App.store)
local OtherTradeServerItem = require(script.Parent.OtherTradeServerItem)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
require(ReplicatedStorage.EzUi.ScrollingGrid)
local paddedScrollingGrid = require(ReplicatedStorage.EzUi.paddedScrollingGrid)
local OtherTradeServerListComponent = Roact.PureComponent:extend("OtherTradeServerList")
OtherTradeServerListComponent.defaultProps = {
	verticalPaddingRatio = 96,
	aspectRatio = 1.7777777777777777
}
function OtherTradeServerListComponent.render(selfComponent)
	if selfComponent.props.visible then
		local uiElements = {}
		if selfComponent.props.otherTradeServerInfo then
			local sortedServerInfo = table.clone(selfComponent.props.otherTradeServerInfo)
			table.sort(sortedServerInfo, function(serverA, serverB)
				return #serverA.userIds < #serverB.userIds
			end)
			uiElements.Header = createElement(PaddedContainer, {
				backgroundColor = Color3.fromRGB(57, 58, 65),
				backgroundTransparency = 0,
				size = UDim2.new(1, 0, 0.15, 0),
				paddingTop = 0,
				paddingBottom = 0.5,
				paddingLeft = 0,
				paddingRight = 0
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 6)
				}),
				TitleContainer = createElement(PaddedContainer, {
					backgroundTransparency = 1,
					size = UDim2.new(0.7, 0, 1, 0)
				}, {
					Text = createElement("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 1, 0),
						Position = UDim2.new(0.5, 0, 0.5, 0),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Font = Enum.Font.FredokaOne,
						TextXAlignment = Enum.TextXAlignment.Left,
						Text = "FIND A TRADE SERVER",
						LineHeight = 1,
						TextScaled = true,
						TextColor3 = Color3.fromHex("489ff8")
					})
				}),
				CloseContainer = createElement(PaddedContainer, {
					backgroundTransparency = 1,
					backgroundColor = Color3.fromHex("eb4d39"),
					size = UDim2.new(0.15, 0, 1, 0),
					position = UDim2.new(0.85, 0, 0, 0)
				}, {
					TextButton = createElement("TextButton", {
						BackgroundTransparency = 0,
						BackgroundColor3 = Color3.fromHex("eb4d39"),
						Size = UDim2.new(1, 0, 1, 0),
						Font = Enum.Font.FredokaOne,
						TextXAlignment = Enum.TextXAlignment.Center,
						Text = "CLOSE",
						LineHeight = 1,
						TextScaled = true,
						TextColor3 = Color3.fromHex("ffffff"),
						[Roact.Event.Activated] = function()
							store:dispatch({
								type = "setOtherTradeServerListVisible",
								value = false
							})
						end
					}, {
						UICorner = createElement("UICorner", {
							CornerRadius = UDim.new(0, 6)
						})
					})
				})
			})
			uiElements.Body = createElement(PaddedContainer, {
				backgroundColor = Color3.new(51/255, 51/255, 51/255),
				backgroundTransparency = 0,
				position = UDim2.new(0, 0, 0.15, 0),
				size = UDim2.new(1, 0, 0.85, 0),
				paddingTop = 0,
				paddingBottom = 0,
				paddingLeft = 0,
				paddingRight = 0
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 6)
				}),
				Scrolling = paddedScrollingGrid({
					rowsPerPage = 7,
					colsPerRow = 1,
					component = OtherTradeServerItem,
					items = sortedServerInfo,
					itemDefaults = {
						onJoinOtherTradeServer = selfComponent.props.onJoinOtherTradeServer
					}
				})
			})
			local containerElement = createElement(PaddedContainer, {
				backgroundTransparency = 1,
				aspectRatio = selfComponent.props.aspectRatio,
				verticalPaddingRatio = selfComponent.props.verticalPaddingRatio,
				exposePaddedContainerProps = true
			}, uiElements)
			return createElement("Frame", {
				BackgroundTransparency = 1,
				Size = selfComponent.props.size,
				Position = selfComponent.props.position,
				AnchorPoint = Vector2.new(0.5, 0.5)
			}, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = selfComponent.props.aspectRatio
				}),
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				Container = containerElement
			})
		end
	end
end
return OtherTradeServerListComponent
