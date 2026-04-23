local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemUtils = require(ReplicatedStorage.App.ItemUtils)
local Checkbox = require(ReplicatedStorage.EzUi.Checkbox)
local ButtonComponent = require(script.Parent.ButtonComponent)
local Roact = require(ReplicatedStorage.Roact)
require(ReplicatedStorage.Std.Maid)
local createElement = Roact.createElement
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local CashBar = require(ReplicatedStorage.Garage.UI.CashBar)
local CustomizeItem = require(ReplicatedStorage.Garage.UI.CustomizeItem)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local paddedScrollingGrid = require(ReplicatedStorage.Safes.UI.paddedScrollingGrid)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local CreatorValues = require(ReplicatedStorage.Trade.CreatorValues)
local CategoryButtonComponent = require(script.Parent.CategoryButtonComponent)
local PageButtonComponent = require(script.Parent.PageButtonComponent)

local SettingItem = Roact.PureComponent:extend("SettingItem")
function SettingItem.init(self)
	self:setState({
		value = self.props.defaultValue
	})
end
function SettingItem.render(self)
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = self.props.size,
		Position = self.props.position
	}, {
		Value = createElement(Checkbox, {
			size = UDim2.new(1, 0, 1, 0),
			value = self.state.value,
			onChecked = function(newValue)
				self:setState({
					value = newValue
				})
				if self.props.onChecked then
					self.props.onChecked(newValue)
				end
			end,
			layoutOrder = 1,
			checkColor = self.props.color,
			cornerRadius = UDim.new(0, 4),
			disabled = self.props.disabled
		}),
		Title = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1 - (1 / self.props.aspectRatio + self.props.paddingRatio / self.props.aspectRatio), 0.8),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.fromScale(1 / self.props.aspectRatio + self.props.paddingRatio / self.props.aspectRatio, 0.5),
			Text = self.props.title,
			Font = Enum.Font.LuckiestGuy,
			LineHeight = 0.7,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextScaled = true,
			TextColor3 = Color3.new(255/255, 255/255, 255/255),
			LayoutOrder = 2
		})
	})
end

local HomeApp = Roact.Component:extend("HomeApp")
function HomeApp.init(self)
	self.categories = {
		{
			name = "floorFurniture",
			title = "Floor Furniture",
			module = "HomeItem",
			upDot = 1,
			use = 1
		},
		{
			name = "wallFurniture",
			title = "Wall Furniture",
			module = "HomeItem",
			upDot = 0,
			use = 1
		},
		{
			name = "ceilingFurniture",
			title = "Ceiling Furniture",
			module = "HomeItem",
			upDot = -1,
			use = 1
		},
		{
			name = "defense",
			title = "Defense",
			module = "HomeItem",
			use = 2
		},
		{
			name = "wallColor",
			title = "Wall Color",
			module = "WallColor"
		},
		{
			name = "secondWallColor",
			title = "Second Wall Color",
			module = "SecondWallColor"
		},
		{
			name = "floorMaterial",
			title = "Floor Material",
			module = "FloorMaterial"
		},
		{
			name = "floorColor",
			title = "Floor Color",
			module = "FloorColor"
		},
		{
			name = "windowColor",
			title = "Window Color",
			module = "WindowColor"
		},
		{
			name = "windowTint",
			title = "Window Tint",
			module = "WindowTint"
		}
	}
	function self.categoryOnClick(index)
		local category = self.categories[index]
		if category.name == "floorFurniture" or (category.name == "wallFurniture" or (category.name == "ceilingFurniture" or category.name == "defense")) then
			self.props.setFurnitureCategory(category)
		elseif category.module then
			self.props.setCategory(category)
		end
		self:setState({
			categoryName = category.name,
			selectedName = Roact.None
		})
		local searchBox = self.searchRef:getValue()
		if searchBox then
			searchBox.Text = ""
		end
	end
	self.pages = {
		{
			name = "inventory",
			title = "INVENTORY",
			bgColor = Color3.fromRGB(255, 202, 11)
		},
		{
			name = "store",
			title = "STORE",
			bgColor = Color3.fromRGB(255, 155, 25)
		},
		{
			name = "settings",
			title = "SETTINGS",
			bgColor = Color3.fromRGB(255, 112, 25)
		},
		{
			name = "edit",
			title = "EDIT",
			bgColor = Color3.fromRGB(255, 151, 24)
		}
	}
	function self.pageOnClick(index)
		self:setState({
			pageName = self.pages[index].name,
			selectedName = Roact.None
		})
		local searchBox = self.searchRef:getValue()
		if searchBox then
			searchBox.Text = ""
		end
	end
	local firstCategory = self.categories[1]
	self:setState({
		pageName = "inventory",
		categoryName = firstCategory.name,
		selectedName = Roact.None
	})
	self.props.setFurnitureCategory(firstCategory)
	self.settingItems = {
		{
			name = "entryAllowFriends",
			title = "ENTRY: ALLOW FRIENDS"
		},
		{
			name = "entryAllowTeam",
			title = "ENTRY: ALLOW TEAM"
		},
		{
			name = "entryAllowEveryone",
			title = "ENTRY: ALLOW EVERYONE"
		},
		{
			name = "editingAllowFriends",
			title = "EDITING: ALLOW FRIENDS",
			requires = "entryAllowFriends"
		},
		{
			name = "editingAllowTeam",
			title = "EDITING: ALLOW TEAM",
			requires = "entryAllowTeam"
		},
		{
			name = "editingAllowEveryone",
			title = "EDITING: ALLOW EVERYONE",
			requires = "entryAllowEveryone"
		}
	}
	self.searchRef = Roact.createRef()
	self:setState({
		search = ""
	})
end

local searchConnection = false
function HomeApp.render(self)
	if self.props.visible then
		if not searchConnection then
			searchConnection = true
			task.delay(0.05, function()
				self:setState({
					search = ""
				})
				local searchBox = self.searchRef:getValue()
				if searchBox then
					searchConnection = searchBox:GetPropertyChangedSignal("Text"):Connect(function()
						task.delay(0.02, function()
							self:setState({
								search = searchBox.Text
							})
						end)
					end)
				end
			end)
		end

		local isOwner = if self.props.home == nil then false else self.props.home:GetOwnerId() == Players.LocalPlayer.UserId

		local pageStateMap = {}
		local selectedPage = nil
		for pageIndex, page in self.pages do
			local pageState = {}
			pageState.selected = page.name == self.state.pageName
			pageStateMap[pageIndex] = pageState
			if pageStateMap[pageIndex].selected then
				selectedPage = page
			end
		end
		assert(selectedPage ~= nil, "selectedPage must not be nil")

		local pageButtonElements = {}
		for pageIndex, page in self.pages do
			pageButtonElements[page.name] = createElement(PaddedContainer, {
				size = UDim2.fromScale(1, 1 / #self.pages),
				position = UDim2.fromScale(0, (pageIndex - 1) / #self.pages),
				paddingTop = 0.5,
				paddingBottom = 0.5,
				paddingLeft = 0.5,
				paddingRight = 0.5,
				component = PageButtonComponent,
				props = {
					title = page.title,
					selected = pageStateMap[pageIndex].selected,
					backgroundColor = page.bgColor,
					onClick = function()
						self.pageOnClick(pageIndex)
					end
				}
			})
		end

		local categoryStateMap = {}
		local selectedCategory = nil
		for categoryIndex, category in self.categories do
			local categoryState = {}
			categoryState.selected = category.name == self.state.categoryName
			categoryStateMap[categoryIndex] = categoryState
			if categoryStateMap[categoryIndex].selected then
				selectedCategory = category
			end
		end
		assert(selectedCategory ~= nil, "selectedCategory must not be nil")

		local categoryButtonDefaults = {
			selectedBgColor = selectedPage.bgColor,
			onClick = self.categoryOnClick
		}

		local gridContainer = nil
		local categoryTitle = nil
		local searchQuery = (self.state.search or ""):lower():gsub(" ", "")
		local hasSearch = #searchQuery > 0

		if self.state.pageName == "inventory" or self.state.pageName == "store" then
			local filteredItems = {}
			for _, item in self.props.items do
				local itemTitle = (item.title or ""):lower():gsub(" ", "")
				local matchesSearch = hasSearch
				if matchesSearch then
					matchesSearch = string.find(itemTitle, searchQuery, 1, true) ~= nil
				end
				if (not hasSearch or matchesSearch) and self.state.pageName == "inventory" then
					if self.props.inventory[item.module] and (self.props.inventory[item.module][item.name] and not (self.props.inventory[item.module][item.name] <= 0)) then
						table.insert(filteredItems, item)
					end
				elseif (not hasSearch or matchesSearch) and (self.state.pageName ~= "store" or item.available and (item.module == "HomeItem" or not (self.props.inventory[item.module] and self.props.inventory[item.module][item.name]))) then
					table.insert(filteredItems, item)
				end
			end

			local itemMetadata = {}
			local selectedItem = nil
			for filteredIndex, item in filteredItems do
				local countLabel = nil
				if item.module == "HomeItem" then
					local ownedCount = if self.props.inventory[item.module] == nil then 0 else self.props.inventory[item.module][item.name] or 0
					local placedCount = self.props.quantityPlaced[item.name] or 0
					if self.state.pageName == "inventory" then
						countLabel = ("%d/%d"):format(ownedCount - placedCount, ownedCount)
					elseif self.state.pageName == "store" then
						local maxPlacedStr = if item.maxPlaced == nil then "\226\136\158" else tostring(item.maxPlaced)
						countLabel = ("%d/%s"):format(ownedCount, maxPlacedStr)
					end
				end

				local fullItemName = ItemUtils.getFullNameFromTable((ItemUtils.createHomeItemItemTable(item.name)))
				local meta = {
					onClick = function()
						self:setState({
							selectedName = item.name
						})
						if self.state.pageName == "inventory" then
							self.props.attemptPlaceItem(item)
						elseif self.state.pageName == "store" then
							self.props.attemptPreviewItem(item)
						end
					end
				}

				meta.selected = item.name == self.state.selectedName
				meta.equipped = self.props.equipped[item.module] == item.name
				meta.customComponent = countLabel and createElement("TextLabel", {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					Text = countLabel,
					TextColor3 = Color3.new(255/255, 255/255, 255/255),
					Font = Enum.Font.FredokaOne,
					TextScaled = true
				})
				meta.creatorName = CreatorValues[fullItemName] and CreatorValues[fullItemName].CreatorName

				if self.state.pageName == "store" then
					if item.module ~= "HomeItem" then
						meta.owned = if self.props.inventory[item.module] and self.props.inventory[item.module][item.name] ~= nil then true else nil
					end
				elseif self.state.pageName == "inventory" then
					meta.owned = true
				end

				itemMetadata[filteredIndex] = meta
				if itemMetadata[filteredIndex].selected then
					selectedItem = item
				end
			end

			local gridContainerProps = {
				backgroundTransparency = 0,
				backgroundColor = Color3.new(51/255, 51/255, 51/255),
				size = UDim2.fromScale(1, 0.8350000000000001),
				position = UDim2.fromScale(0, 0.16499999999999998),
				paddingTop = 0.5,
				paddingBottom = 0,
				paddingLeft = 0,
				paddingRight = 0
			}
			local gridContainerChildren = {
				Corner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				})
			}

			gridContainerChildren.Scrolling = if #filteredItems > 0 then createElement(paddedScrollingGrid, {
				exposePaddedContainerProps = true,
				rowsPerPage = 2.5,
				colsPerRow = 8,
				component = CustomizeItem,
				items = filteredItems,
				metadata = itemMetadata,
				itemDefaults = {
					canFavorite = false,
					accentColor = selectedPage.bgColor
				}
			}) else false

			local helpElement
			if #filteredItems == 0 then
				helpElement = not hasSearch
				if helpElement then
					local helpChildren = {}
					local emptyLabelProps = {
						Size = UDim2.fromScale(1, 0.1),
						BackgroundTransparency = 1
					}
					emptyLabelProps.Text = if self.state.pageName == "inventory" then "You don\'t have any of these.. check out the store!" else "No more items to buy.. check your inventory!"
					emptyLabelProps.TextColor3 = Color3.new(255/255, 255/255, 255/255)
					emptyLabelProps.Font = Enum.Font.FredokaOne
					emptyLabelProps.TextScaled = true
					helpChildren.Title = createElement("TextLabel", emptyLabelProps)

					local switchButtonProps = {
						size = UDim2.fromScale(0.3, 0.2),
						position = UDim2.fromScale(0.5, 0.5),
						anchorPoint = Vector2.new(0.5, 0.5),
						cornerRadius = UDim.new(0, 4),
						backgroundColor = Color3.fromRGB(255, 155, 25)
					}
					switchButtonProps.title = if self.state.pageName == "inventory" then "Store" else "Inventory"
					function switchButtonProps.onClick()
						if self.state.pageName == "inventory" then
							self:setState({
								pageName = "store"
							})
						else
							self:setState({
								pageName = "inventory"
							})
						end
					end
					helpChildren.Button = createElement(ButtonComponent, switchButtonProps)
					helpElement = createElement(PaddedContainer, {
						backgroundTransparency = 1
					}, helpChildren)
				end
			else
				helpElement = false
			end

			gridContainerChildren.Help = helpElement
			gridContainer = createElement(PaddedContainer, gridContainerProps, gridContainerChildren)
			selectedItem = selectedItem
		elseif self.state.pageName == "settings" then
			local visibleSettings = {}
			for _, settingItem in self.settingItems do
				if not settingItem.requires or self.props.savedSettings[settingItem.requires] then
					table.insert(visibleSettings, settingItem)
				end
			end

			local settingMetadata = {}
			for settingIndex, settingItem in visibleSettings do
				local meta = {
					onChecked = function(newValue)
						self.props.setSavedSetting(settingItem.name, newValue)
						if self.props.onSettingChanged then
							self.props.onSettingChanged(settingItem.name, newValue)
						end
					end
				}
				meta.defaultValue = self.props.savedSettings[settingItem.name] == true
				meta.disabled = not isOwner
				settingMetadata[settingIndex] = meta
			end

			gridContainer = createElement(PaddedContainer, {
				backgroundTransparency = 0,
				backgroundColor = Color3.new(51/255, 51/255, 51/255),
				size = UDim2.fromScale(1, 0.8350000000000001),
				position = UDim2.fromScale(0, 0.16499999999999998),
				paddingTop = 0.5,
				paddingBottom = 0,
				paddingLeft = 0,
				paddingRight = 0
			}, {
				Corner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				Scrolling = createElement(paddedScrollingGrid, {
					exposePaddedContainerProps = true,
					rowsPerPage = 12,
					colsPerRow = 1,
					component = SettingItem,
					items = visibleSettings,
					metadata = settingMetadata,
					itemDefaults = {
						color = selectedPage.bgColor
					}
				})
			})
		else
			local isPageName = self.state.pageName == "edit"
		end

		local actionButtonElements = {}
		local actionButtons = {}
		if self.state.pageName == "store" and (selectedItem ~= nil and selectedItem.available) then
			table.insert(actionButtons, {
				name = "purchase",
				title = "BUY"
			})
		end
		table.insert(actionButtons, {
			name = "exit",
			title = "EXIT"
		})
		for buttonIndex, actionButton in actionButtons do
			actionButtonElements[actionButton.name] = createElement(PaddedContainer, {
				size = UDim2.fromScale(1 / #actionButtons, 1),
				position = UDim2.fromScale((buttonIndex - 1) / #actionButtons, 0),
				paddingTop = 0.5,
				paddingBottom = 0.5,
				paddingLeft = 0.5,
				paddingRight = 0.5,
				component = ButtonComponent,
				props = {
					cornerRadius = UDim.new(0, 4),
					title = actionButton.title,
					backgroundColor = selectedPage.bgColor,
					onClick = function()
						if actionButton.name == "place" then
							self.props.attemptPlaceItem(selectedItem)
						elseif actionButton.name == "purchase" then
							self.props.attemptPurchaseItem(selectedItem)
						elseif actionButton.name == "delete" then
							self.props.attemptDeleteItem()
						elseif actionButton.name == "exit" then
							self.props.exit()
						end
					end
				}
			})
		end

		local categoryListElement = nil
		local categoryTitleText = nil
		if self.state.pageName == "store" or self.state.pageName == "inventory" then
			local categoryList = createElement(PaddedContainer, {
				backgroundTransparency = 0,
				backgroundColor = Color3.new(51/255, 51/255, 51/255),
				size = UDim2.fromScale(1, 0.56),
				position = UDim2.fromScale(0, 0.44),
				paddingTop = 0,
				paddingLeft = 0,
				paddingRight = 0,
				paddingBottom = 0
			}, {
				Corner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				Scrolling = createElement(paddedScrollingGrid, {
					exposePaddedContainerProps = true,
					rowsPerPage = 6.9,
					colsPerRow = 1,
					component = CategoryButtonComponent,
					items = self.categories,
					itemDefaults = categoryButtonDefaults,
					metadata = categoryStateMap
				})
			})
			categoryTitleText = selectedCategory.title
			categoryListElement = categoryList
		elseif self.state.pageName == "settings" then
			categoryTitleText = "Settings"
		elseif self.state.pageName == "edit" then
			categoryTitleText = "Editing"
		end

		local outerContainerProps = {}
		outerContainerProps.backgroundTransparency = if self.state.pageName == "edit" then 1 else 0.8
		outerContainerProps.backgroundColor = Color3.new(0/255, 0/255, 0/255)
		outerContainerProps.aspectRatio = self.props.aspectRatio
		outerContainerProps.verticalPaddingRatio = self.props.verticalPaddingRatio
		outerContainerProps.paddingTop = 0
		outerContainerProps.paddingBottom = 0
		outerContainerProps.paddingLeft = 0
		outerContainerProps.paddingRight = 0

		local outerChildren = {
			UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
				AspectRatio = self.props.aspectRatio
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 4)
			}),
			Sidebar = createElement(PaddedContainer, {
				backgroundTransparency = 1,
				size = UDim2.fromScale(0.15, 1),
				paddingRight = 0.5
			}, {
				Title = createElement(PaddedContainer, {
					backgroundTransparency = 1,
					size = UDim2.fromScale(1, 0.16499999999999998),
					paddingTop = 0,
					paddingLeft = 0,
					paddingRight = 0,
					paddingBottom = 0
				}, {
					Title = createElement("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(0.9, 0, 0.9, 0),
						Position = UDim2.new(0.5, 0, 0.5, 0),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Text = "HOME",
						Font = Enum.Font.Bangers,
						LineHeight = 1,
						TextScaled = true,
						TextColor3 = Color3.fromRGB(255, 202, 11)
					}, {
						UIStroke = createElement("UIStroke", {
							Color = Color3.new(0/255, 0/255, 0/255),
							Thickness = 3
						})
					})
				}),
				Pages = createElement(PaddedContainer, {
					backgroundTransparency = 1,
					size = UDim2.fromScale(1, 0.275),
					position = UDim2.fromScale(0, 0.16499999999999998),
					paddingTop = 0,
					paddingLeft = 0,
					paddingRight = 0,
					paddingBottom = 0
				}, {
					Inner = createElement(PaddedContainer, {
						backgroundTransparency = 1,
						paddingLeft = 0.5,
						paddingRight = 0.5,
						paddingTop = 0.5,
						paddingBottom = 0.5
					}, pageButtonElements)
				}),
				Categories = categoryListElement
			})
		}

		local bodyProps = {
			backgroundTransparency = 1,
			size = UDim2.fromScale(0.85, 1),
			position = UDim2.fromScale(0.15, 0),
			paddingLeft = 0.5
		}
		local bodyChildren = {
			Cash = createElement(PaddedContainer, {
				backgroundTransparency = 1,
				size = UDim2.fromScale(1, 0.075),
				paddingTop = 0,
				paddingLeft = 0,
				paddingRight = 0,
				paddingBottom = 0.5
			}, {
				Bar = createElement(CashBar, {
					exposePaddedContainerProps = true,
					cash = self.props.cash,
					promptCashPurchase = self.props.promptCashPurchase
				})
			})
		}

		local categoryTitleBarProps = {
			backgroundTransparency = 0,
			backgroundColor = selectedPage.bgColor,
			size = UDim2.fromScale(1, 0.09),
			position = UDim2.fromScale(0, 0.075),
			paddingTop = 0.5,
			paddingLeft = 0,
			paddingRight = 0,
			paddingBottom = 0.5
		}
		local categoryTitleBarChildren = {
			Corner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 4)
			})
		}
		local categoryTitleInnerChildren = {
			Title = createElement("TextLabel", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.fromScale(0.5, 0.8),
				Position = UDim2.fromScale(0.005, 0.5),
				AnchorPoint = Vector2.new(0, 0.5),
				Text = categoryTitleText,
				Font = Enum.Font.LuckiestGuy,
				LineHeight = 0.7,
				TextScaled = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextColor3 = ColorUtils.saturateBy(selectedPage.bgColor, -0.7),
				ZIndex = 4
			}, {
				UIStroke = createElement("UIStroke", {
					Color = Color3.new(0/255, 0/255, 0/255),
					Thickness = 1
				})
			})
		}

		local searchBoxProps = {
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			Size = UDim2.new(0.15, 0, 1, 0),
			Position = UDim2.new(1, 0, 0.5, 0),
			PlaceholderText = "Search...",
			Text = "",
			Font = Enum.Font.Bangers,
			TextScaled = true,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextColor3 = Color3.new(0/255, 0/255, 0/255),
			PlaceholderColor3 = Color3.new(0.5, 0.5, 0.5),
			ZIndex = 1,
			[Roact.Ref] = self.searchRef
		}
		searchBoxProps.Visible = if categoryTitleText == "Settings" then false else categoryTitleText ~= "Editing"
		categoryTitleInnerChildren.SearchBox = createElement("TextBox", searchBoxProps, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 4)
			})
		})
		categoryTitleBarChildren.Inner = createElement(PaddedContainer, {
			backgroundTransparency = 1
		}, categoryTitleInnerChildren)
		bodyChildren.CategoryTitle = createElement(PaddedContainer, categoryTitleBarProps, categoryTitleBarChildren)
		bodyChildren.GridContainer = gridContainer
		outerChildren.Body = createElement(PaddedContainer, bodyProps, bodyChildren)

		local bottomBarElement
		if #actionButtons > 0 then
			local bottomBarProps = {
				backgroundTransparency = 0.8,
				backgroundColor = Color3.new(0/255, 0/255, 0/255),
				size = UDim2.fromScale(0.25, 0.1)
			}
			bottomBarProps.position = UDim2.fromScale(0.375, if self.state.pageName == "edit" then 0.2 else 1)
			bottomBarProps.paddingTop = 1
			bottomBarProps.paddingBottom = 0
			bottomBarProps.paddingLeft = 0
			bottomBarProps.paddingRight = 0
			bottomBarElement = createElement(PaddedContainer, bottomBarProps, {
				Corners = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				Buttons = createElement(PaddedContainer, {
					backgroundTransparency = 1,
					paddingTop = 0.5,
					paddingBottom = 0.5,
					paddingLeft = 0.5,
					paddingRight = 0.5
				}, actionButtonElements)
			})
		else
			bottomBarElement = false
		end

		outerChildren.Bottom = bottomBarElement
		return createElement(PaddedContainer, outerContainerProps, outerChildren)
	end
	if typeof(searchConnection) == "RBXScriptConnection" then
		searchConnection:Disconnect()
	end
	searchConnection = false
end

return RoactRodux.connect(function(state, props)
	return {
		home = state.home,
		cash = state.cash,
		items = state.items,
		visible = state.visible,
		inventory = state.inventory,
		equipped = state.equipped,
		quantityPlaced = state.quantityPlaced,
		savedSettings = state.savedSettings
	}
end, function(dispatch)
	return {
		setFurnitureCategory = function(category)
			dispatch({
				type = "setFurnitureCategory",
				upDot = category.upDot,
				use = category.use
			})
		end,
		setCategory = function(category)
			dispatch({
				type = "setCategory",
				module = category.module
			})
		end,
		setSavedSetting = function(key, value)
			dispatch({
				type = "setSavedSetting",
				key = key,
				value = value
			})
		end
	}
end)(HomeApp)
