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
local v1 = Roact.PureComponent:extend("SettingItem")
function v1.init(p1) --[[ Line: 30 ]]
	p1:setState({
		value = p1.props.defaultValue
	})
end
function v1.render(p1) --[[ Line: 35 | Upvalues: createElement (copy), Checkbox (copy) ]]
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = p1.props.size,
		Position = p1.props.position
	}, {
		Value = createElement(Checkbox, {
			size = UDim2.new(1, 0, 1, 0),
			value = p1.state.value,
			onChecked = function(p12) --[[ Name: onChecked | Line: 44 | Upvalues: p1 (copy) ]]
				p1:setState({
					value = p12
				})
				if p1.props.onChecked then
					p1.props.onChecked(p12)
				end
			end,
			layoutOrder = 1,
			checkColor = p1.props.color,
			cornerRadius = UDim.new(0, 4),
			disabled = p1.props.disabled
		}),
		Title = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1 - (1 / p1.props.aspectRatio + p1.props.paddingRatio / p1.props.aspectRatio), 0.8),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.fromScale(1 / p1.props.aspectRatio + p1.props.paddingRatio / p1.props.aspectRatio, 0.5),
			Text = p1.props.title,
			Font = Enum.Font.LuckiestGuy,
			LineHeight = 0.7,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextScaled = true,
			TextColor3 = Color3.new(255/255, 255/255, 255/255),
			LayoutOrder = 2
		})
	})
end
local v2 = Roact.Component:extend("HomeApp")
function v2.init(p1) --[[ Line: 80 | Upvalues: Roact (copy) ]]
	p1.categories = {
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
	function p1.categoryOnClick(p12) --[[ Line: 142 | Upvalues: p1 (copy), Roact (ref) ]]
		local v1 = p1.categories[p12]
		if v1.name == "floorFurniture" or (v1.name == "wallFurniture" or (v1.name == "ceilingFurniture" or v1.name == "defense")) then
			p1.props.setFurnitureCategory(v1)
		elseif v1.module then
			p1.props.setCategory(v1)
		end
		p1:setState({
			categoryName = v1.name,
			selectedName = Roact.None
		})
		local v2 = p1.searchRef:getValue()
		if v2 then
			v2.Text = ""
		end
	end
	p1.pages = {
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
	function p1.pageOnClick(p12) --[[ Line: 186 | Upvalues: p1 (copy), Roact (ref) ]]
		p1:setState({
			pageName = p1.pages[p12].name,
			selectedName = Roact.None
		})
		local v1 = p1.searchRef:getValue()
		if v1 then
			v1.Text = ""
		end
	end
	local v1 = p1.categories[1]
	p1:setState({
		pageName = "inventory",
		categoryName = v1.name,
		selectedName = Roact.None
	})
	p1.props.setFurnitureCategory(v1)
	p1.settingItems = {
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
	p1.searchRef = Roact.createRef()
	p1:setState({
		search = ""
	})
end
local v3 = false
function v2.render(p1) --[[ Line: 252 | Upvalues: v3 (ref), Players (copy), createElement (copy), PaddedContainer (copy), PageButtonComponent (copy), ItemUtils (copy), CreatorValues (copy), paddedScrollingGrid (copy), CustomizeItem (copy), ButtonComponent (copy), v1 (copy), CategoryButtonComponent (copy), CashBar (copy), ColorUtils (copy), Roact (copy) ]]
	if p1.props.visible then
		if not v3 then
			v3 = true
			task.delay(0.05, function() --[[ Line: 263 | Upvalues: p1 (copy), v3 (ref) ]]
				p1:setState({
					search = ""
				})
				local v1 = p1.searchRef:getValue()
				if v1 then
					v3 = v1:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 269 | Upvalues: p1 (ref), v1 (copy) ]]
						task.delay(0.02, function() --[[ Line: 270 | Upvalues: p1 (ref), v1 (ref) ]]
							p1:setState({
								search = v1.Text
							})
						end)
					end)
				end
			end)
		end
		local v12 = if p1.props.home == nil then false else p1.props.home:GetOwnerId() == Players.LocalPlayer.UserId
		local t = {}
		local v2 = nil
		for v4, v5 in p1.pages do
			local v32
			local t2 = {}
			v32 = v5.name == p1.state.pageName
			t2.selected = v32
			t[v4] = t2
			if t[v4].selected then
				v2 = v5
			end
		end
		assert(v2 ~= nil, "selectedPage must not be nil")
		local t2 = {}
		for v7, v8 in p1.pages do
			t2[v8.name] = createElement(PaddedContainer, {
				size = UDim2.fromScale(1, 1 / #p1.pages),
				position = UDim2.fromScale(0, (v7 - 1) / #p1.pages),
				paddingTop = 0.5,
				paddingBottom = 0.5,
				paddingLeft = 0.5,
				paddingRight = 0.5,
				component = PageButtonComponent,
				props = {
					title = v8.title,
					selected = t[v7].selected,
					backgroundColor = v8.bgColor,
					onClick = function() --[[ Name: onClick | Line: 317 | Upvalues: p1 (copy), v7 (copy) ]]
						p1.pageOnClick(v7)
					end
				}
			})
		end
		local t3 = {}
		local v10 = nil
		for v122, v13 in p1.categories do
			local v11
			local t4 = {}
			v11 = v13.name == p1.state.categoryName
			t4.selected = v11
			t3[v122] = t4
			if t3[v122].selected then
				v10 = v13
			end
		end
		assert(v10 ~= nil, "selectedCategory must not be nil")
		local t4 = {
			selectedBgColor = v2.bgColor,
			onClick = p1.categoryOnClick
		}
		local v15 = nil
		local v16 = nil
		local v17 = (p1.state.search or ""):lower():gsub(" ", "")
		local v18 = #v17 > 0
		if p1.state.pageName == "inventory" or p1.state.pageName == "store" then
			local t5 = {}
			for v19, v20 in p1.props.items do
				local v21 = (v20.title or ""):lower():gsub(" ", "")
				local v22 = v18
				if v22 then
					v22 = string.find(v21, v17, 1, true) ~= nil
				end
				if (not v18 or v22) and p1.state.pageName == "inventory" then
					if p1.props.inventory[v20.module] and (p1.props.inventory[v20.module][v20.name] and not (p1.props.inventory[v20.module][v20.name] <= 0)) then
						table.insert(t5, v20)
					end
				elseif (not v18 or v22) and (p1.state.pageName ~= "store" or v20.available and (v20.module == "HomeItem" or not (p1.props.inventory[v20.module] and p1.props.inventory[v20.module][v20.name]))) then
					table.insert(t5, v20)
				end
			end
			local t7 = {}
			for v29, v30 in t5 do
				local v23, v24, v25, v26, v27, v28
				local v31 = nil
				if v30.module == "HomeItem" then
					v23 = if p1.props.inventory[v30.module] == nil then 0 else p1.props.inventory[v30.module][v30.name] or 0
					local v322 = p1.props.quantityPlaced[v30.name] or 0
					if p1.state.pageName == "inventory" then
						v31 = ("%d/%d"):format(v23 - v322, v23)
					elseif p1.state.pageName == "store" then
						v24 = if v30.maxPlaced == nil then "\226\136\158" else tostring(v30.maxPlaced)
						v31 = ("%d/%s"):format(v23, v24)
					end
				end
				local v37 = ItemUtils.getFullNameFromTable((ItemUtils.createHomeItemItemTable(v30.name)))
				local t8 = {
					onClick = function() --[[ Name: onClick | Line: 408 | Upvalues: p1 (copy), v30 (copy) ]]
						p1:setState({
							selectedName = v30.name
						})
						if p1.state.pageName == "inventory" then
							p1.props.attemptPlaceItem(v30)
						elseif p1.state.pageName == "store" then
							p1.props.attemptPreviewItem(v30)
						end
					end
				}
				v25 = v30.name == p1.state.selectedName
				t8.selected = v25
				v26 = p1.props.equipped[v30.module] == v30.name
				t8.equipped = v26
				v27 = v31 and createElement("TextLabel", {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					Text = v31,
					TextColor3 = Color3.new(255/255, 255/255, 255/255),
					Font = Enum.Font.FredokaOne,
					TextScaled = true
				})
				t8.customComponent = v27
				t8.creatorName = CreatorValues[v37] and CreatorValues[v37].CreatorName
				if p1.state.pageName == "store" then
					if v30.module ~= "HomeItem" then
						v28 = if p1.props.inventory[v30.module] and p1.props.inventory[v30.module][v30.name] ~= nil then true else nil
						t8.owned = v28
					end
				elseif p1.state.pageName == "inventory" then
					t8.owned = true
				end
				t7[v29] = t8
				if t7[v29].selected then
					v16 = v30
				end
			end
			local t8 = {
				backgroundTransparency = 0,
				backgroundColor = Color3.new(51/255, 51/255, 51/255),
				size = UDim2.fromScale(1, 0.8350000000000001),
				position = UDim2.fromScale(0, 0.16499999999999998),
				paddingTop = 0.5,
				paddingBottom = 0,
				paddingLeft = 0,
				paddingRight = 0
			}
			local t9 = {
				Corner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				})
			}
			t9.Scrolling = if #t5 > 0 then createElement(paddedScrollingGrid, {
	exposePaddedContainerProps = true,
	rowsPerPage = 2.5,
	colsPerRow = 8,
	component = CustomizeItem,
	items = t5,
	metadata = t7,
	itemDefaults = {
		canFavorite = false,
		accentColor = v2.bgColor
	}
}) else false
			local v42
			if #t5 == 0 then
				v42 = not v18
				if v42 then
					local t11 = {}
					local t12 = {
						Size = UDim2.fromScale(1, 0.1),
						BackgroundTransparency = 1
					}
					t12.Text = if p1.state.pageName == "inventory" then "You don\'t have any of these.. check out the store!" else "No more items to buy.. check your inventory!"
					t12.TextColor3 = Color3.new(255/255, 255/255, 255/255)
					t12.Font = Enum.Font.FredokaOne
					t12.TextScaled = true
					t11.Title = createElement("TextLabel", t12)
					local t13 = {
						size = UDim2.fromScale(0.3, 0.2),
						position = UDim2.fromScale(0.5, 0.5),
						anchorPoint = Vector2.new(0.5, 0.5),
						cornerRadius = UDim.new(0, 4),
						backgroundColor = Color3.fromRGB(255, 155, 25)
					}
					t13.title = if p1.state.pageName == "inventory" then "Store" else "Inventory"
					function t13.onClick() --[[ Line: 496 | Upvalues: p1 (copy) ]]
						if p1.state.pageName == "inventory" then
							p1:setState({
								pageName = "store"
							})
						else
							p1:setState({
								pageName = "inventory"
							})
						end
					end
					t11.Button = createElement(ButtonComponent, t13)
					v42 = createElement(PaddedContainer, {
						backgroundTransparency = 1
					}, t11)
				end
			else
				v42 = false
			end
			t9.Help = v42
			v15 = createElement(PaddedContainer, t8, t9)
		elseif p1.state.pageName == "settings" then
			local t6 = {}
			for v51, v52 in p1.settingItems do
				if not v52.requires or p1.props.savedSettings[v52.requires] then
					table.insert(t6, v52)
				end
			end
			local t7 = {}
			for v54, v55 in t6 do
				local v53
				local t8 = {
					onChecked = function(p12) --[[ Name: onChecked | Line: 523 | Upvalues: p1 (copy), v55 (copy) ]]
						p1.props.setSavedSetting(v55.name, p12)
						if p1.props.onSettingChanged then
							p1.props.onSettingChanged(v55.name, p12)
						end
					end
				}
				v53 = p1.props.savedSettings[v55.name] == true
				t8.defaultValue = v53
				t8.disabled = not v12
				t7[v54] = t8
			end
			v15 = createElement(PaddedContainer, {
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
					component = v1,
					items = t6,
					metadata = t7,
					itemDefaults = {
						color = v2.bgColor
					}
				})
			})
		else
			local isPageName = p1.state.pageName == "edit"
		end
		local t5 = {}
		local t6 = {}
		if p1.state.pageName == "store" and (v16 ~= nil and v16.available) then
			table.insert(t6, {
				name = "purchase",
				title = "BUY"
			})
		end
		table.insert(t6, {
			name = "exit",
			title = "EXIT"
		})
		for v56, v57 in t6 do
			t5[v57.name] = createElement(PaddedContainer, {
				size = UDim2.fromScale(1 / #t6, 1),
				position = UDim2.fromScale((v56 - 1) / #t6, 0),
				paddingTop = 0.5,
				paddingBottom = 0.5,
				paddingLeft = 0.5,
				paddingRight = 0.5,
				component = ButtonComponent,
				props = {
					cornerRadius = UDim.new(0, 4),
					title = v57.title,
					backgroundColor = v2.bgColor,
					onClick = function() --[[ Name: onClick | Line: 625 | Upvalues: v57 (copy), p1 (copy), v16 (ref) ]]
						if v57.name == "place" then
							p1.props.attemptPlaceItem(v16)
						elseif v57.name == "purchase" then
							p1.props.attemptPurchaseItem(v16)
						elseif v57.name == "delete" then
							p1.props.attemptDeleteItem()
						elseif v57.name == "exit" then
							p1.props.exit()
						end
					end
				}
			})
		end
		local v58 = nil
		local v59 = nil
		if p1.state.pageName == "store" or p1.state.pageName == "inventory" then
			local v60 = createElement(PaddedContainer, {
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
					items = p1.categories,
					itemDefaults = t4,
					metadata = t3
				})
			})
			v59 = v10.title
			v58 = v60
		elseif p1.state.pageName == "settings" then
			v59 = "Settings"
		elseif p1.state.pageName == "edit" then
			v59 = "Editing"
		end
		local t7 = {}
		t7.backgroundTransparency = if p1.state.pageName == "edit" then 1 else 0.8
		t7.backgroundColor = Color3.new(0/255, 0/255, 0/255)
		t7.aspectRatio = p1.props.aspectRatio
		t7.verticalPaddingRatio = p1.props.verticalPaddingRatio
		t7.paddingTop = 0
		t7.paddingBottom = 0
		t7.paddingLeft = 0
		t7.paddingRight = 0
		local t8 = {
			UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
				AspectRatio = p1.props.aspectRatio
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
					}, t2)
				}),
				Categories = v58
			})
		}
		local t9 = {
			backgroundTransparency = 1,
			size = UDim2.fromScale(0.85, 1),
			position = UDim2.fromScale(0.15, 0),
			paddingLeft = 0.5
		}
		local t10 = {
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
					cash = p1.props.cash,
					promptCashPurchase = p1.props.promptCashPurchase
				})
			})
		}
		local t11 = {
			backgroundTransparency = 0,
			backgroundColor = v2.bgColor,
			size = UDim2.fromScale(1, 0.09),
			position = UDim2.fromScale(0, 0.075),
			paddingTop = 0.5,
			paddingLeft = 0,
			paddingRight = 0,
			paddingBottom = 0.5
		}
		local t12 = {
			Corner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 4)
			})
		}
		local t14 = {
			Title = createElement("TextLabel", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.fromScale(0.5, 0.8),
				Position = UDim2.fromScale(0.005, 0.5),
				AnchorPoint = Vector2.new(0, 0.5),
				Text = v59,
				Font = Enum.Font.LuckiestGuy,
				LineHeight = 0.7,
				TextScaled = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextColor3 = ColorUtils.saturateBy(v2.bgColor, -0.7),
				ZIndex = 4
			}, {
				UIStroke = createElement("UIStroke", {
					Color = Color3.new(0/255, 0/255, 0/255),
					Thickness = 1
				})
			})
		}
		local t15 = {
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
			[Roact.Ref] = p1.searchRef
		}
		t15.Visible = if v59 == "Settings" then false else v59 ~= "Editing"
		t14.SearchBox = createElement("TextBox", t15, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 4)
			})
		})
		t12.Inner = createElement(PaddedContainer, {
			backgroundTransparency = 1
		}, t14)
		t10.CategoryTitle = createElement(PaddedContainer, t11, t12)
		t10.GridContainer = v15
		t8.Body = createElement(PaddedContainer, t9, t10)
		local v73
		if #t6 > 0 then
			local t16 = {
				backgroundTransparency = 0.8,
				backgroundColor = Color3.new(0/255, 0/255, 0/255),
				size = UDim2.fromScale(0.25, 0.1)
			}
			t16.position = UDim2.fromScale(0.375, if p1.state.pageName == "edit" then 0.2 else 1)
			t16.paddingTop = 1
			t16.paddingBottom = 0
			t16.paddingLeft = 0
			t16.paddingRight = 0
			v73 = createElement(PaddedContainer, t16, {
				Corners = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				Buttons = createElement(PaddedContainer, {
					backgroundTransparency = 1,
					paddingTop = 0.5,
					paddingBottom = 0.5,
					paddingLeft = 0.5,
					paddingRight = 0.5
				}, t5)
			})
		else
			v73 = false
		end
		t8.Bottom = v73
		return createElement(PaddedContainer, t7, t8)
	end
	if typeof(v3) == "RBXScriptConnection" then
		v3:Disconnect()
	end
	v3 = false
end
return RoactRodux.connect(function(p1, p2) --[[ Line: 844 ]]
	return {
		home = p1.home,
		cash = p1.cash,
		items = p1.items,
		visible = p1.visible,
		inventory = p1.inventory,
		equipped = p1.equipped,
		quantityPlaced = p1.quantityPlaced,
		savedSettings = p1.savedSettings
	}
end, function(p1) --[[ Line: 855 ]]
	return {
		setFurnitureCategory = function(p12) --[[ Name: setFurnitureCategory | Line: 857 | Upvalues: p1 (copy) ]]
			p1({
				type = "setFurnitureCategory",
				upDot = p12.upDot,
				use = p12.use
			})
		end,
		setCategory = function(p12) --[[ Name: setCategory | Line: 864 | Upvalues: p1 (copy) ]]
			p1({
				type = "setCategory",
				module = p12.module
			})
		end,
		setSavedSetting = function(p12, p2) --[[ Name: setSavedSetting | Line: 870 | Upvalues: p1 (copy) ]]
			p1({
				type = "setSavedSetting",
				key = p12,
				value = p2
			})
		end
	}
end)(v2)