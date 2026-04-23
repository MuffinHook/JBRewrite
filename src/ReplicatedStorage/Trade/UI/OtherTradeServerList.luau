local ReplicatedStorage = game:GetService("ReplicatedStorage")
local store = require(ReplicatedStorage.App.store)
local OtherTradeServerItem = require(script.Parent.OtherTradeServerItem)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
require(ReplicatedStorage.EzUi.ScrollingGrid)
local paddedScrollingGrid = require(ReplicatedStorage.EzUi.paddedScrollingGrid)
local v1 = Roact.PureComponent:extend("OtherTradeServerList")
v1.defaultProps = {
	verticalPaddingRatio = 96,
	aspectRatio = 1.7777777777777777
}
function v1.render(p1) --[[ Line: 15 | Upvalues: createElement (copy), PaddedContainer (copy), Roact (copy), store (copy), paddedScrollingGrid (copy), OtherTradeServerItem (copy) ]]
	if p1.props.visible then
		local t = {}
		if p1.props.otherTradeServerInfo then
			local v1 = table.clone(p1.props.otherTradeServerInfo)
			table.sort(v1, function(p1, p2) --[[ Line: 28 ]]
				return #p1.userIds < #p2.userIds
			end)
			t.Header = createElement(PaddedContainer, {
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
						[Roact.Event.Activated] = function() --[[ Line: 78 | Upvalues: store (ref) ]]
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
			t.Body = createElement(PaddedContainer, {
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
					items = v1,
					itemDefaults = {
						onJoinOtherTradeServer = p1.props.onJoinOtherTradeServer
					}
				})
			})
			local v2 = createElement(PaddedContainer, {
				backgroundTransparency = 1,
				aspectRatio = p1.props.aspectRatio,
				verticalPaddingRatio = p1.props.verticalPaddingRatio,
				exposePaddedContainerProps = true
			}, t)
			return createElement("Frame", {
				BackgroundTransparency = 1,
				Size = p1.props.size,
				Position = p1.props.position,
				AnchorPoint = Vector2.new(0.5, 0.5)
			}, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = p1.props.aspectRatio
				}),
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				Container = v2
			})
		end
	end
end
return v1