local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Checkbox = require(ReplicatedStorage.EzUi.Checkbox)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local ScrollingGrid = require(ReplicatedStorage.EzUi.ScrollingGrid)
local SaleConsts = require(ReplicatedStorage.Sale.SaleConsts)
local SaleUtils = require(ReplicatedStorage.Sale.SaleUtils)
local Interval = require(ReplicatedStorage.Std.Interval)
local Maid = require(ReplicatedStorage.Std.Maid)
local CustomizeItem = require(script.Parent.CustomizeItem)
local EnumSort = require(script.Parent.Parent.EnumSort)
local GarageConsts = require(script.Parent.Parent.GarageConsts)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local PortalBase = Roact.PureComponent:extend("PortalBase")
function PortalBase.init(self)
	local titleBinding, updateTitleBinding = Roact.createBinding(self.props.title)
	self.titleBinding = titleBinding
	self.updateTitleBinding = updateTitleBinding
	self.maid = Maid.new()
	self.searchRef = Roact.createRef()
	self:setState({
		search = "",
		aerialEnabled = false
	})
end
function PortalBase.render(self)
	local portalRatio = self.props.portalRatio
	local paddingRatio = self.props.paddingRatio
	local searchAreaRatio = portalRatio * 10
	local cornerPixel = self.props.cornerPixel
	local gridAspectRatio = 1 / (1 / portalRatio - 1 / searchAreaRatio - 1 / paddingRatio)
	local smallSpacing = 0.125 / searchAreaRatio
	local buttonSpacing = 4.5 / searchAreaRatio
	local sortAreaWidth = 1 - 5 * smallSpacing - 2 * buttonSpacing
	local sortDisplayText = nil
	if self.props.sortId == EnumSort.Alphabetical then
		sortDisplayText = "ALPHABETICAL"
	elseif self.props.sortId == EnumSort.Newest then
		sortDisplayText = "NEWEST"
	elseif self.props.sortId == EnumSort.Price then
		sortDisplayText = "EXPENSIVE"
	elseif self.props.sortId == EnumSort.PriceLow then
		sortDisplayText = "LOWEST"
	elseif self.props.sortId == EnumSort.Popular then
		sortDisplayText = "POPULAR"
	end
	local items = self.props.items
	local metadata = self.props.metadata
	local search = self.state.search
	local aerialEnabled = self.state.aerialEnabled
	local function shouldShow(itemData, itemMetadata, searchTerm)
		local searchTermNormalized = (searchTerm or ""):lower():gsub(" ", "")
		local hasSearchTerm = #searchTermNormalized > 0
		local titleMatches = hasSearchTerm and string.find((itemData.title or ""):lower():gsub(" ", ""), searchTermNormalized, 1, true) ~= nil
		local passesShowFilter = not self.props.showFavorited or itemMetadata.faved
		local passesAvailabilityFilter = self.props.showAll and not itemData.hiddenAll or (itemData.available or itemMetadata.owned)
		local passesAerialFilter
		if aerialEnabled then
			passesAerialFilter = if aerialEnabled and itemData.vehicleType == "Heli" then true elseif self.props.title == "SPAWN" then RunUtils.isTradeWorld() else true
		else
			passesAerialFilter = not itemData.aerialOnly
			if not passesAerialFilter then
				passesAerialFilter = if aerialEnabled and itemData.vehicleType == "Heli" then true elseif self.props.title == "SPAWN" then RunUtils.isTradeWorld() else true
			end
		end
		if hasSearchTerm then
			return passesShowFilter and (passesAvailabilityFilter and (titleMatches and passesAerialFilter))
		else
			return passesShowFilter and (passesAvailabilityFilter and passesAerialFilter)
		end
	end
	local filteredMetadata = {}
	local filteredItems = {}
	for i = 1, #items do
		local itemData = items[i]
		local itemMetadata = metadata[i]
		if shouldShow(itemData, itemMetadata, search) then
			local filteredIndex = #filteredItems + 1
			filteredItems[filteredIndex] = itemData
			filteredMetadata[filteredIndex] = itemMetadata
		end
	end
	self:_updateTitle()
	local mainFrameProps = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
		Size = UDim2.new(1, 0, 1, 0),
		LayoutOrder = 3
	}
	local containerProps = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = portalRatio
		}),
		ListLayout = createElement("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Vertical
		})
	}
	local headerFrameProps = {
		BackgroundTransparency = 0.4,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
		Size = UDim2.new(1, 0, 1, 0),
		LayoutOrder = 1
	}
	local headerChildProps = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = searchAreaRatio
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, cornerPixel)
		})
	}
	local titleProps = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(0.5, 0, 0.5, 0),
		Position = UDim2.new(0.25 / searchAreaRatio, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		Text = self.titleBinding,
		Font = Enum.Font.LuckiestGuy,
		LineHeight = 0.7,
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left
	}
	titleProps.TextColor3 = if self.props.title == SaleConsts.CATEGORY_NAME then Color3.new(1, 0.1, 0.1) else Color3.fromRGB(98, 222, 253)
	titleProps.ZIndex = 4
	headerChildProps.Title = createElement("TextLabel", titleProps, {
		UIStroke = createElement("UIStroke", {
			Color = Color3.new(0/255, 0/255, 0/255),
			Thickness = 1
		})
	})
	headerChildProps.OwnedCheckbox = self.props.sortEnabled and createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0.75, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1 - 7 * smallSpacing - 2 * buttonSpacing - 0.75 / searchAreaRatio, 0, 0.5, 0)
	}, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 2
		}),
		Left = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(0.4, 0, 1, 0)
		}, {
			Title = createElement("TextLabel", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0.8, 0),
				Position = UDim2.new(0, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				Text = "ALL:",
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
			Size = UDim2.new(0.5, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0, 0)
		}, {
			Checkbox = createElement(Checkbox, {
				size = UDim2.new(1, 0, 1, 0),
				value = self.props.showAll,
				onChecked = self.props.onToggleAll
			})
		})
	})
	local sortEnabled = self.props.sortEnabled
	if sortEnabled then
		local starFrameProps = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0.75, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(sortAreaWidth, 0, 0.5, 0)
		}
		local starContainerProps = {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		}
		local starButtonProps = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}
		starButtonProps.ImageColor3 = (self.props.showFavorited or self.state.favHover) and Color3.fromRGB(255, 251, 0) or Color3.new(0.7, 0.7, 0.7)
		starButtonProps.Image = "rbxassetid://8552830996"
		starButtonProps.ZIndex = 10
		starButtonProps[Roact.Event.MouseEnter] = function()
			self:setState({
				favHover = true
			})
		end
		starButtonProps[Roact.Event.MouseLeave] = function()
			self:setState({
				favHover = false
			})
		end
		starButtonProps[Roact.Event.SelectionGained] = function()
			self:setState({
				favHover = true
			})
		end
		starButtonProps[Roact.Event.SelectionLost] = function()
			self:setState({
				favHover = false
			})
		end
		starButtonProps[Roact.Event.Activated] = self.props.onToggleFavorited
		starContainerProps.Star = createElement("ImageButton", starButtonProps)
		sortEnabled = createElement("Frame", starFrameProps, starContainerProps)
	end
	headerChildProps.FavoritedCheckbox = sortEnabled
	headerChildProps.SortContainer = self.props.sortEnabled and createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0.75, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1 - 3 * smallSpacing - buttonSpacing, 0, 0.5, 0)
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
					self.props.onSelectSort(self.props.sortId)
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
					Text = sortDisplayText,
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
	headerChildProps.SearchContainer = self.props.sortEnabled and createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0.75, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1 - smallSpacing, 0, 0.5, 0)
	}, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 6
		}),
		SearchBox = createElement("TextBox", {
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0, 0, 0, 0),
			PlaceholderText = "Search...",
			Text = "",
			Font = Enum.Font.Bangers,
			TextScaled = true,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextColor3 = Color3.new(0/255, 0/255, 0/255),
			PlaceholderColor3 = Color3.new(0.5, 0.5, 0.5),
			ZIndex = 1,
			[Roact.Ref] = self.searchRef
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, cornerPixel)
			})
		})
	})
	containerProps.Top = createElement("Frame", headerFrameProps, headerChildProps)
	containerProps.Padding1 = createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
		Size = UDim2.new(1, 0, 1, 0),
		LayoutOrder = 2
	}, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = paddingRatio
		})
	})
	containerProps.Body = createElement("Frame", {
		BackgroundTransparency = 0.4,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
		Size = UDim2.new(1, 0, 1, 0),
		LayoutOrder = 3
	}, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = gridAspectRatio
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, cornerPixel)
		}),
		ScrollingGrid = createElement(ScrollingGrid, {
			aspectRatio = gridAspectRatio,
			paddingRatio = paddingRatio,
			component = CustomizeItem,
			items = filteredItems,
			metadata = filteredMetadata,
			onSelectItem = self.props.onSelectItem,
			colsPerRow = self.props.colsPerRow,
			rowsPerPage = self.props.rowsPerPage
		})
	})
	return createElement("Frame", mainFrameProps, containerProps)
end
function PortalBase._updateTitle(self)
	if self.props.title == SaleConsts.CATEGORY_NAME then
		self.updateTitleBinding(SaleConsts.CATEGORY_NAME .. ": " .. SaleUtils.formatRemaining(SaleUtils.getTimeToNextSale()))
	else
		self.updateTitleBinding(self.props.title)
	end
end
function PortalBase.didMount(self)
	self.maid.updateTitle = Interval.every(1):Connect(function()
		self:_updateTitle()
	end)
	local searchTextBox = self.searchRef:getValue()
	if searchTextBox then
		self.maid:GiveTask(searchTextBox:GetPropertyChangedSignal("Text"):Connect(function()
			self.maid.searchDelay = task.delay(0.1, function()
				self:setState({
					search = searchTextBox.Text
				})
			end)
		end))
	end
	if Players.LocalPlayer then
		self.maid:GiveTask(Players.LocalPlayer:GetAttributeChangedSignal(GarageConsts.AERIAL_SPAWN_ATTR_NAME):Connect(function()
			local aerialStateUpdate = {}
			aerialStateUpdate.aerialEnabled = Players.LocalPlayer:GetAttribute(GarageConsts.AERIAL_SPAWN_ATTR_NAME) == true
			self:setState(aerialStateUpdate)
		end))
		if self.state.aerialEnabled ~= Players.LocalPlayer:GetAttribute(GarageConsts.AERIAL_SPAWN_ATTR_NAME) then
			local aerialStateUpdate = {}
			aerialStateUpdate.aerialEnabled = Players.LocalPlayer:GetAttribute(GarageConsts.AERIAL_SPAWN_ATTR_NAME) == true
			self:setState(aerialStateUpdate)
		end
	end
end
function PortalBase.willUnmount(self)
	self.maid:DoCleaning()
end
return RoactRodux.connect(function(state, dispatch)
	return {
		sortId = state.garageSort
	}
end, function(dispatch)
	return {
		onSelectSort = function(sortId)
			local sortItemCount = 0
			for enumItem in EnumSort:GetEnumItems() do
				sortItemCount = sortItemCount + 1
			end
			dispatch({
				type = "setSort",
				id = sortId % sortItemCount + 1
			})
		end
	}
end)(PortalBase)
