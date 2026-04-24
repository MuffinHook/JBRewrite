-- Reviewed by Claude
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
function color.init(p1)
	p1.itemDefaults = {
		cornerPixel = p1.props.cornerPixel,
		onClick = p1.props.onClickItem,
		onCardFlipped = p1.props.onCardFlipped
	}
end
function color.render(p1)
	local cornerPixel = p1.props.cornerPixel
	local color = Color3.new(51/255, 51/255, 51/255)
	local v2 = nil
	if p1.props.sortId == EnumSort.Alphabetical then
		v2 = "ALPHABETICAL"
	elseif p1.props.sortId == EnumSort.Newest then
		v2 = "RECENT"
	elseif p1.props.sortId == EnumSort.Price then
		v2 = "EXPENSIVE"
	elseif p1.props.sortId == EnumSort.Popular then
		v2 = "HIGH DEMAND"
	end
	local t = {}
	for i, v in ipairs(p1.props.categories) do
		local v3
		local t2 = {
			itemType = v.match.itemType,
			title = v.categoryTitle,
			onClick = function()
				if p1.props.onClickCategory then
					p1.props.onClickCategory(v)
				end
			end
		}
		v3 = v == p1.props.category
		t2.selected = v3
		table.insert(t, t2)
	end
	local t2 = {}
	if p1.props.inventoryPlayers then
		for v5, v6 in p1.props.inventoryPlayers.allPlayers do
			local v4
			local t3 = {
				title = v6.DisplayName,
				onClick = function()
					if p1.props.onClickInventoryPlayer and v6 ~= p1.props.inventoryPlayers.selectedPlayer then
						p1.props.onClickInventoryPlayer(v6)
					end
				end
			}
			v4 = v6 == p1.props.inventoryPlayers.selectedPlayer
			t3.selected = v4
			table.insert(t2, t3)
		end
	end
	local t3 = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 1.6
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, cornerPixel)
		})
	}
	local t4 = {
		BorderSizePixel = 0,
		BackgroundColor3 = color,
		Size = UDim2.new(0.984375, 0, 0.08, 0),
		Position = UDim2.new(0.0078125, 0, 0.0125, 0)
	}
	local t5 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, cornerPixel)
		})
	}
	local t6 = {
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
		Size = UDim2.new(0.4875, 0, 1, 0),
		Position = UDim2.new(0.0125, 0, 0, 0)
	}
	local t7 = {}
	local t8 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		TextColor3 = Color3.new(255/255, 255/255, 255/255)
	}
	t8.Text = ("%s\'s Inventory"):format(p1.props.inventoryPlayers and p1.props.inventoryPlayers.selectedPlayer and p1.props.inventoryPlayers.selectedPlayer.DisplayName or "Player")
	t8.TextXAlignment = Enum.TextXAlignment.Left
	t8.Font = Enum.Font.Bangers
	t8.LineHeight = 1
	t8.TextScaled = true
	t7.Text = createElement("TextLabel", t8)
	t5.Title = createElement("Frame", t6, t7)
	t5.Input = createElement("Frame", {
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
			[Roact.Ref] = p1.boxRef,
			[Roact.Change.Text] = function(p1)
				local color = p1.Text:upper():gsub("[^%w%s]", "")
				p1.Text = color
				store:dispatch({
					type = "setTradeInventorySearchText",
					value = color
				})
			end
		})
	})
	t5.SortContainer = p1.props.sortEnabled and createElement("Frame", {
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
					p1.props.onSelectSort(p1.props.sortId)
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
					Text = v2,
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
	t3.Header = createElement("Frame", t4, t5)
	t3.OtherPlayerInventoryContainers = createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = color,
		BackgroundTransparency = 0,
		Size = UDim2.new(0.13828125, 0, 1, 0),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(-0.0078125, 0, 0, 0),
		Visible = not p1.props.tradeActive
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
			items = t2
		})
	})
	t3.ItemTypesContainer = createElement("Frame", {
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
			items = t
		})
	})
	t3.ItemsContainer = createElement("Frame", {
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
			itemDefaults = p1.itemDefaults,
			items = p1.props.items,
			metadata = p1.props.itemMetadata
		})
	})
	t3.Footer = createElement("Frame", {
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
			onClick = p1.props.onClickExit
		})
	})
	if p1.props.showChat then
		t3.Chat = createElement(TradeChat, {
			size = UDim2.new(0.25, 0, 1, 0),
			position = UDim2.new(1.0078125, 0, 0, 0),
			aspectRatio = 0.4,
			verticalPaddingRatio = 80,
			messages = p1.props.tradeChatMessages
		})
	end
	return createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		BackgroundTransparency = 0.8,
		Size = p1.props.size,
		Position = p1.props.position,
		AnchorPoint = p1.props.anchorPoint
	}, t3)
end
return color
