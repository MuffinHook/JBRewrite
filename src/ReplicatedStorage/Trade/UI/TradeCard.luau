local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local ViewportFrame = require(ReplicatedStorage.EzUi.ViewportFrame)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local ScrollingGrid = require(ReplicatedStorage.EzUi.ScrollingGrid)
local function infoComponent(props)
	local valueColor = props.valueColor or Color3.new(255/255, 255/255, 255/255)
	local children = {}
	local titleProperties = {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.9, 0, 0.3, 0),
		Position = UDim2.new(0.5, 0, 0, 0),
		AnchorPoint = Vector2.new(0.5, 0),
		Text = props.title,
		Font = Enum.Font.Bangers,
		TextXAlignment = Enum.TextXAlignment.Center,
		LineHeight = 1,
		TextScaled = true
	}
	titleProperties.TextColor3 = props.titleColor or Color3.new(255/255, 255/255, 255/255)
	children.Title = createElement("TextLabel", titleProperties)
	children.Value = createElement("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.9, 0, 0.7, 0),
		Position = UDim2.new(0.5, 0, 0.3, 0),
		AnchorPoint = Vector2.new(0.5, 0),
		Text = props.value,
		Font = Enum.Font.Bangers,
		TextXAlignment = Enum.TextXAlignment.Center,
		LineHeight = 1,
		TextScaled = true,
		TextColor3 = valueColor
	})
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = props.size,
		Position = props.position
	}, children)
end
local TradeCard = Roact.PureComponent:extend("TradeCard")
TradeCard.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	cornerPixel = 8,
	aspectRatio = 0.5,
	selected = false,
	number = nil,
	isOriginalOwner = false
}
function TradeCard.init(props)
	props:setState({
		hover = false,
		hoverInfo = false,
		showInfo = false
	})
	function props.setHoverTrue()
		props:setState({
			hover = true
		})
	end
	function props.setHoverFalse()
		props:setState({
			hover = false
		})
	end
	function props.setHoverInfoTrue()
		props:setState({
			hoverInfo = true
		})
	end
	function props.setHoverInfoFalse()
		props:setState({
			hoverInfo = false
		})
	end
end
function TradeCard.render(props)
	local aspectRatio = props.props.aspectRatio
	local baseHeaderHeight = 10
	local baseTitleHeight = 8
	if props.state.showInfo then
		baseTitleHeight = baseTitleHeight * 2
		baseHeaderHeight = baseHeaderHeight * 2
	end
	local infoContainerScale = 1 / (1 - 1 / baseTitleHeight - 1 / baseHeaderHeight - 0.05)
	local scaledItemHeight = 0.8 * aspectRatio
	local itemColor = if props.props.showPlus then Color3.fromRGB(0, 200, 90) elseif props.props.itemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then Color3.fromRGB(122, 212, 255) elseif props.props.itemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then Color3.fromRGB(255, 90, 82) elseif props.props.itemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then Color3.fromRGB(255, 213, 122) elseif props.props.itemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE then Color3.fromRGB(167, 131, 255) elseif props.props.itemType == PlayerDataConsts.SAFE_ITEM_TYPE then Color3.fromRGB(255, 126, 191) else Color3.new(204/255, 204/255, 204/255)
	local baseItemColor, hoverColor, brightnessOffset
	if props.state.hover and not props.state.hoverInfo then
		baseItemColor = itemColor
		hoverColor = itemColor
		brightnessOffset = -0.2
	else
		baseItemColor = itemColor
		hoverColor = itemColor
		brightnessOffset = 0
	end
	local finalItemColor = ColorUtils.brightenBy(hoverColor, brightnessOffset)
	local children = {}
	if props.props.showPlus then
		children.Plus = createElement("Frame", {
			BackgroundColor3 = finalItemColor,
			BackgroundTransparency = 0,
			Size = UDim2.new(0.8, 0, 0.8 * aspectRatio, 0),
			Position = UDim2.new(0.09999999999999998, 0, 1 - scaledItemHeight - 0.09999999999999998, 0)
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			}),
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.9, 0, 1.1, 0),
				Position = UDim2.new(0.5, 0, 0.45, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = "+",
				Font = Enum.Font.LuckiestGuy,
				TextXAlignment = Enum.TextXAlignment.Center,
				LineHeight = 0.7,
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255)
			})
		})
	elseif props.props.blank then
		children.Blank = createElement("Frame", {
			BackgroundColor3 = finalItemColor,
			BackgroundTransparency = 0,
			Size = UDim2.new(0.8, 0, 0.8 * aspectRatio, 0),
			Position = UDim2.new(0.09999999999999998, 0, 1 - scaledItemHeight - 0.09999999999999998, 0)
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			})
		})
	elseif props.state.showInfo then
		local infoFrameProperties = {
			BorderSizePixel = 0
		}
		infoFrameProperties.BackgroundColor3 = (props.state.hover or props.state.hoverInfo) and Color3.new(0.1, 0.1, 0.1) or Color3.new(0.25, 0.25, 0.25)
		infoFrameProperties.Size = UDim2.new(0.15, 0, 0.15 * aspectRatio, 0)
		infoFrameProperties.Position = UDim2.new(0.834375, 0, 0.015625 * aspectRatio, 0)
		infoFrameProperties.ZIndex = 4
		children.Info = createElement("Frame", infoFrameProperties, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			}),
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.9, 0, 0.9, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = "x",
				Font = Enum.Font.GothamBold,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255)
			})
		})
		children.ClickInfo = createElement("TextButton", {
			BackgroundTransparency = 1,
			Selectable = false,
			AutoButtonColor = false,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Text = "",
			Size = UDim2.new(0.3, 0, 0.3 * aspectRatio, 0),
			Position = UDim2.new(0.7, 0, 0, 0),
			ZIndex = 4,
			[Roact.Event.MouseEnter] = props.setHoverInfoTrue,
			[Roact.Event.MouseLeave] = props.setHoverInfoFalse,
			[Roact.Event.SelectionGained] = props.setHoverInfoTrue,
			[Roact.Event.SelectionLost] = props.setHoverInfoFalse,
			[Roact.Event.Activated] = function()
				props:setState({
					showInfo = false
				})
				if props.props.onCardFlipped then
					props.props.onCardFlipped()
				end
			end
		})
		children.InfoContainer = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1 / infoContainerScale, 0),
			Position = UDim2.new(0, 0, 1 - 1 / infoContainerScale, 0)
		}, {
			Line = createElement("Frame", {
				BackgroundTransparency = 0.8,
				BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
				Size = UDim2.new(1, 0, 0, 1)
			}),
			InfoItems = createElement(ScrollingGrid, {
				aspectRatio = infoContainerScale,
				paddingRatio = 64,
				rowsPerPage = 3,
				colsPerRow = 1,
				component = infoComponent,
				items = props.props.info
			})
		})
	else
		if props.props.getInst then
			children.ViewportFrame = createElement(ViewportFrame, {
				backgroundColor = finalItemColor,
				backgroundTransparency = 0,
				getInst = props.props.getInst,
				getInstCompare = props.props.getInstCompare,
				updateCamera = props.props.updateCamera,
				size = UDim2.new(0.8, 0, 0.8 * aspectRatio, 0),
				position = UDim2.new(0.09999999999999998, 0, 1 - scaledItemHeight - 0.09999999999999998, 0)
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(1, 0)
				})
			})
		else
			children.ViewportFrame = createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundColor3 = finalItemColor,
				Size = UDim2.new(0.8, 0, 0.8 * aspectRatio, 0),
				Position = UDim2.new(0.09999999999999998, 0, 1 - scaledItemHeight - 0.09999999999999998, 0)
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(1, 0)
				}),
				Icon = createElement("ImageLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(0.9, 0, 0.9, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Image = props.props.image
				})
			})
		end
		local accentColor = finalItemColor
		local seasonBadgeOffset = scaledItemHeight * 0.5 * 0.5956993044924335
		if props.props.season then
			children.Season = createElement("Frame", {
				BackgroundColor3 = accentColor,
				Size = UDim2.new(0.25, 0, 0.25 * aspectRatio, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.17871698740774206, 0, 0.9 - scaledItemHeight * 0.5 + seasonBadgeOffset, 0),
				ZIndex = 3
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(1, 0)
				}),
				UIStroke = createElement("UIStroke", {
					Color = Color3.new(255/255, 255/255, 255/255),
					Thickness = 2
				}),
				Text = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(0.9, 0, 0.8, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Text = ("S%d"):format(props.props.season),
					Font = Enum.Font.Bangers,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = Color3.new(255/255, 255/255, 255/255)
				})
			})
		end
		local levelBadgeOffset = scaledItemHeight * 0.5 * 0.9569403357322089
		if props.props.level then
			children.Level = createElement("Frame", {
				BackgroundColor3 = accentColor,
				Size = UDim2.new(0.2, 0, 0.2 * aspectRatio, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.3838861290982151, 0, 0.9 - scaledItemHeight * 0.5 + levelBadgeOffset, 0),
				ZIndex = 4
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(1, 0)
				}),
				UIStroke = createElement("UIStroke", {
					Color = Color3.new(255/255, 255/255, 255/255),
					Thickness = 2
				}),
				Text = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(0.9, 0, 0.8, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Text = ("L%d"):format(props.props.level),
					Font = Enum.Font.Bangers,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = Color3.new(255/255, 255/255, 255/255)
				})
			})
		end
		local infoButtonProperties = {
			BorderSizePixel = 0
		}
		infoButtonProperties.BackgroundColor3 = props.state.hoverInfo and Color3.new(0.1, 0.1, 0.1) or Color3.new(0.25, 0.25, 0.25)
		infoButtonProperties.Size = UDim2.new(0.15, 0, 0.15 * aspectRatio, 0)
		infoButtonProperties.Position = UDim2.new(0.834375, 0, 0.015625 * aspectRatio, 0)
		children.Info = createElement("Frame", infoButtonProperties, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			}),
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.9, 0, 0.9, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = "i",
				Font = Enum.Font.GothamBold,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255)
			})
		})
		children.ClickInfo = createElement("TextButton", {
			BackgroundTransparency = 1,
			AutoButtonColor = false,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Text = "",
			Size = UDim2.new(0.3, 0, 0.3 * aspectRatio, 0),
			Position = UDim2.new(0.7, 0, 0, 0),
			ZIndex = 4,
			[Roact.Event.MouseEnter] = props.setHoverInfoTrue,
			[Roact.Event.MouseLeave] = props.setHoverInfoFalse,
			[Roact.Event.SelectionGained] = props.setHoverInfoTrue,
			[Roact.Event.SelectionLost] = props.setHoverInfoFalse,
			[Roact.Event.Activated] = function()
				props:setState({
					showInfo = true
				})
				if props.props.onCardFlipped then
					props.props.onCardFlipped()
				end
			end
		})
		if props.props.number then
			local numberFrameProperties = {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
				Size = UDim2.new(0.15, 0, 0.15, 0),
				Position = UDim2.new(0.834375, 0, 0.85 - 0.015625 * aspectRatio, 0),
				ZIndex = 3
			}
			local numberChildren = {}
			local numberTextProperties = {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5)
			}
			numberTextProperties.Text = "#" .. tostring(props.props.number)
			numberTextProperties.Font = Enum.Font.SourceSansBold
			numberTextProperties.TextXAlignment = Enum.TextXAlignment.Right
			numberTextProperties.LineHeight = 1
			numberTextProperties.TextScaled = true
			numberTextProperties.TextColor3 = accentColor
			numberChildren.Text = createElement("TextLabel", numberTextProperties)
			children.Number = createElement("Frame", numberFrameProperties, numberChildren)
		end
	end
	if not (props.props.showPlus or props.props.blank or props.state.showInfo) or props.state.showInfo then
		local categoryTextColor = Color3.new(0.25, 0.25, 0.25)
		if props.state.showInfo then
			categoryTextColor = Color3.new(255/255, 255/255, 255/255)
		end
		children.Category = createElement("Frame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(0.95, 0, 1 / baseHeaderHeight, 0),
			Position = UDim2.new(0.05, 0, 0.05 * aspectRatio, 0),
			ZIndex = 3
		}, {
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1.2, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = props.props.categoryTitle,
				Font = Enum.Font.Bangers,
				TextXAlignment = Enum.TextXAlignment.Left,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = categoryTextColor
			})
		})
		local titleTextColor = Color3.new(0.1, 0.1, 0.1)
		if props.state.showInfo then
			titleTextColor = Color3.new(255/255, 255/255, 255/255)
		end
		children.Title = createElement("Frame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(0.95, 0, 1 / baseTitleHeight, 0),
			Position = UDim2.new(0.05, 0, 1 / baseHeaderHeight + 0.05 * aspectRatio, 0),
			ZIndex = 3
		}, {
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1.2, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = props.props.title,
				Font = Enum.Font.Bangers,
				TextXAlignment = Enum.TextXAlignment.Left,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = titleTextColor
			})
		})
	end
	if props.props.selected then
		children.Selected = createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.8, 0, 0.8 * aspectRatio, 0),
			Position = UDim2.new(0.09999999999999998, 0, 1 - scaledItemHeight - 0.09999999999999998, 0),
			Image = "rbxassetid://9839329507",
			ZIndex = 6
		})
	end
	local borderColor = props.props.isOriginalOwner and Color3.fromRGB(255, 238, 152) or Color3.new(255/255, 255/255, 255/255)
	if props.state.showInfo then
		borderColor = baseItemColor
	end
	if props.state.hover and not (props.state.hoverInfo or props.state.showInfo) then
		borderColor = ColorUtils.brightenBy(borderColor, -0.1)
	end
	return createElement("TextButton", {
		AutoButtonColor = false,
		BorderSizePixel = 0,
		Selectable = true,
		Size = props.props.size,
		Position = props.props.position,
		BackgroundColor3 = borderColor,
		Text = "",
		[Roact.Event.MouseEnter] = props.setHoverTrue,
		[Roact.Event.MouseLeave] = props.setHoverFalse,
		[Roact.Event.SelectionGained] = props.setHoverTrue,
		[Roact.Event.SelectionLost] = props.setHoverFalse,
		[Roact.Event.Activated] = function()
			if props.state.showInfo then
				props:setState({
					showInfo = false
				})
				if props.props.onCardFlipped then
					props.props.onCardFlipped()
				end
			elseif props.props.onClick then
				props.props.onClick(props.props.index)
			end
		end
	}, Dictionary.merge({
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, props.props.cornerPixel)
		})
	}, children))
end
return TradeCard
