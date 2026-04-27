local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local EnumSort = require(ReplicatedStorage.Garage.EnumSort)
local TradeCard = require(script.Parent.TradeCard)
local TradeCategory = require(script.Parent.TradeCategory)
local TradeButton = require(script.Parent.TradeButton)
local ScrollingGrid = require(ReplicatedStorage.EzUi.ScrollingGrid)
local store = require(ReplicatedStorage.App.store)
local TradeChat = require(script.Parent.TradeChat)
local color = Roact.PureComponent:extend("TradeInventory")
color.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	cornerPixel = 4,
	sortEnabled = true,
	displayName = ""
}
function color.init(component)
	component.itemDefaults = {
		cornerPixel = component.props.cornerPixel,
		onClick = component.props.onClickItem,
		onCardFlipped = component.props.onCardFlipped
	}
end
function color.render(component)
	local cornerPixel = component.props.cornerPixel
	local color = Color3.new(51/255, 51/255, 51/255)
	local sortTypeDisplay = nil
	if component.props.sortId == EnumSort.Alphabetical then
		sortTypeDisplay = "ALPHABETICAL"
	elseif component.props.sortId == EnumSort.Newest then
		sortTypeDisplay = "RECENT"
	elseif component.props.sortId == EnumSort.Price then
		sortTypeDisplay = "EXPENSIVE"
	elseif component.props.sortId == EnumSort.Popular then
		sortTypeDisplay = "HIGH DEMAND"
	end
	local categoryItems = {}
	for i, categoryData in ipairs(component.props.categories) do
		local isCategorySelected
		local categoryEntry = {
			itemType = categoryData.match.itemType,
			title = categoryData.categoryTitle,
			onClick = function()
				if component.props.onClickCategory then
					component.props.onClickCategory(categoryData)
				end
			end
		}
		isCategorySelected = categoryData == component.props.category
		categoryEntry.selected = isCategorySelected
		table.insert(categoryItems, categoryEntry)
	end
	local playerItems = {}
	if component.props.inventoryPlayers then
		for playerIndex, playerData in component.props.inventoryPlayers.allPlayers do
			local isPlayerSelected
			local playerEntry = {
				title = playerData.DisplayName,
				onClick = function()
					if component.props.onClickInventoryPlayer and playerData ~= component.props.inventoryPlayers.selectedPlayer then
						component.props.onClickInventoryPlayer(playerData)
					end
				end
			}
			isPlayerSelected = playerData == component.props.inventoryPlayers.selectedPlayer
			playerEntry.selected = isPlayerSelected
			table.insert(playerItems, playerEntry)
		end
	end
	local elementTree = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 1.6
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, cornerPixel)
		})
	}
	local headerProperties = {
		BorderSizePixel = 0,
		BackgroundColor3 = color,
		Size = UDim2.new(0.984375, 0, 0.08, 0),
		Position = UDim2.new(0.0078125, 0, 0.0125, 0)
	}
	local headerContent = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, cornerPixel)
		})
	}
	local inventoryTitleProperties = {
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
		Size = UDim2.new(0.4875, 0, 1, 0),
		Position = UDim2.new(0.0125, 0, 0, 0)
	}
	local inventoryTitleContent = {}
	local inventoryTitleTextProperties = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		TextColor3 = Color3.new(255/255, 255/255, 255/255)
	}
	inventoryTitleTextProperties.Text = ("%s\'s Inventory"):format(component.props.inventoryPlayers and component.props.inventoryPlayers.selectedPlayer and component.props.inventoryPlayers.selectedPlayer.DisplayName or "Player")
	inventoryTitleTextProperties.TextXAlignment = Enum.TextXAlignment.Left
	inventoryTitleTextProperties.Font = Enum.Font.Bangers
	inventoryTitleTextProperties.LineHeight = 1
	inventoryTitleTextProperties.TextScaled = true
	inventoryTitleContent.Text = createElement("TextLabel", inventoryTitleTextProperties)
	headerContent.Title = createElement("Frame", inventoryTitleProperties, inventoryTitleContent)
	headerContent.Input = createElement("Frame", {
		BackgroundTransparency = 0.6666666666666666,
		BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
		Size = UDim2.new(0.2, 0, 0.7, 0),
		Position = UDim2.new(0.65, 0, 0.5, 0),
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
			PlaceholderText = "SEARCH ITEMS...",
			Text = "",
			[Roact.Ref] = component.boxRef,
			[Roact.Change.Text] = function(textBox)
				local searchText = textBox.Text:upper():gsub("[^%w%s]", "")
				textBox.Text = searchText
				store:dispatch({
					type = "setTradeInventorySearchText",
					value = searchText
				})
			end
		})
	})
	headerContent.SortContainer = component.props.sortEnabled and createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0.75, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(0.99, 0, 0.5, 0)
	}, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 6
		}),
		Left = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(0.3, 0, 1, 0)
		}, {
			Title = createElement("TextLabel", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0.8, 0),
				Position = UDim2.new(0, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				Text = "SORT:",
				Font = Enum.Font.Bangers,
				LineHeight = 0.95,
				TextScaled = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextColor3 = Color3.new(255/255, 255/255, 255/255),
				ZIndex = 1
			})
		}),
		Right = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 255/255, 0/255),
			Size = UDim2.new(0.7, 0, 1, 0),
			Position = UDim2.new(0.3, 0, 0, 0)
		}, {
			Container = createElement("TextButton", {
				Text = "",
				BackgroundTransparency = 0,
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
				Size = UDim2.new(1, 0, 1, 0),
				Position = UDim2.new(0, 0, 0, 0),
				[Roact.Event.Activated] = function()
					component.props.onSelectSort(component.props.sortId)
				end
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, cornerPixel)
				}),
				Title = createElement("TextLabel", {
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(0.9, 0, 0.8, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Text = sortTypeDisplay,
					Font = Enum.Font.Bangers,
					LineHeight = 0.95,
					TextScaled = true,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextColor3 = Color3.new(0/255, 0/255, 0/255),
					ZIndex = 1
				})
			})
		})
	})
	elementTree.Header = createElement("Frame", headerProperties, headerContent)
	elementTree.OtherPlayerInventoryContainers = createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = color,
		BackgroundTransparency = 0,
		Size = UDim2.new(0.13828125, 0, 1, 0),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(-0.0078125, 0, 0, 0),
		Visible = not component.props.tradeActive
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, cornerPixel)
		}),
		ScrollingGrid = createElement(ScrollingGrid, {
			aspectRatio = 0.2800632911392405,
			paddingRatio = 17.700000000000003,
			rowsPerPage = 14,
			colsPerRow = 1,
			component = TradeCategory,
			itemDefaults = {
				cornerPixel = cornerPixel
			},
			items = playerItems
		})
	})
	elementTree.ItemTypesContainer = createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = color,
		Size = UDim2.new(0.13828125, 0, 0.79, 0),
		Position = UDim2.new(0.0078125, 0, 0.10500000000000001, 0)
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, cornerPixel)
		}),
		ScrollingGrid = createElement(ScrollingGrid, {
			aspectRatio = 0.2800632911392405,
			paddingRatio = 17.700000000000003,
			rowsPerPage = 12,
			colsPerRow = 1,
			component = TradeCategory,
			itemDefaults = {
				cornerPixel = cornerPixel
			},
			items = categoryItems
		})
	})
	elementTree.ItemsContainer = createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = color,
		Size = UDim2.new(0.83828125, 0, 0.79, 0),
		Position = UDim2.new(0.15390625, 0, 0.10500000000000001, 0)
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, cornerPixel)
		}),
		ScrollingGrid = createElement(ScrollingGrid, {
			aspectRatio = 1.6977848101265822,
			paddingRatio = 107.30000000000001,
			rowsPerPage = 3,
			colsPerRow = 7,
			component = TradeCard,
			itemDefaults = component.itemDefaults,
			items = component.props.items,
			metadata = component.props.itemMetadata
		})
	})
	elementTree.Footer = createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = color,
		Size = UDim2.new(0.984375, 0, 0.08, 0),
		Position = UDim2.new(0.0078125, 0, 0.9075, 0)
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, cornerPixel)
		}),
		ListLayout = createElement("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0.0078125, 0)
		}),
		Padding = createElement("UIPadding", {
			PaddingLeft = UDim.new(0.0078125, 0),
			PaddingRight = UDim.new(0.0078125, 0),
			PaddingTop = UDim.new(0.15625, 0),
			PaddingBottom = UDim.new(0.15625, 0)
		}),
		Button1 = createElement(TradeButton, {
			layoutOrder = 1,
			backgroundColor = Color3.fromRGB(255, 58, 43),
			text = "Back",
			onClick = component.props.onClickExit
		})
	})
	if component.props.showChat then
		elementTree.Chat = createElement(TradeChat, {
			size = UDim2.new(0.25, 0, 1, 0),
			position = UDim2.new(1.0078125, 0, 0, 0),
			aspectRatio = 0.4,
			verticalPaddingRatio = 80,
			messages = component.props.tradeChatMessages
		})
	end
	return createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		BackgroundTransparency = 0.8,
		Size = component.props.size,
		Position = component.props.position,
		AnchorPoint = component.props.anchorPoint
	}, elementTree)
end
return color
