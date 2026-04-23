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
local v1 = Roact.PureComponent:extend("PortalBase")
function v1.init(p1) --[[ Line: 19 | Upvalues: Roact (copy), Maid (copy) ]]
	local v1, v2 = Roact.createBinding(p1.props.title)
	p1.titleBinding = v1
	p1.updateTitleBinding = v2
	p1.maid = Maid.new()
	p1.searchRef = Roact.createRef()
	p1:setState({
		search = "",
		aerialEnabled = false
	})
end
function v1.render(p1) --[[ Line: 28 | Upvalues: EnumSort (copy), RunUtils (copy), createElement (copy), SaleConsts (copy), Checkbox (copy), Roact (copy), ScrollingGrid (copy), CustomizeItem (copy) ]]
	local portalRatio = p1.props.portalRatio
	local paddingRatio = p1.props.paddingRatio
	local v1 = portalRatio * 10
	local cornerPixel = p1.props.cornerPixel
	local v2 = 1 / (1 / portalRatio - 1 / v1 - 1 / paddingRatio)
	local v3 = 0.125 / v1
	local v4 = 4.5 / v1
	local v7 = 1 - 5 * v3 - 2 * v4
	local v9 = nil
	if p1.props.sortId == EnumSort.Alphabetical then
		v9 = "ALPHABETICAL"
	elseif p1.props.sortId == EnumSort.Newest then
		v9 = "NEWEST"
	elseif p1.props.sortId == EnumSort.Price then
		v9 = "EXPENSIVE"
	elseif p1.props.sortId == EnumSort.PriceLow then
		v9 = "LOWEST"
	elseif p1.props.sortId == EnumSort.Popular then
		v9 = "POPULAR"
	end
	local items = p1.props.items
	local metadata = p1.props.metadata
	local search = p1.state.search
	local aerialEnabled = p1.state.aerialEnabled
	local function shouldShow(p12, p2, p3) --[[ Line: 67 | Upvalues: p1 (copy), aerialEnabled (copy), RunUtils (ref) ]]
		local v1 = (p3 or ""):lower():gsub(" ", "")
		local v3 = #v1 > 0
		local v4 = v3 and string.find((p12.title or ""):lower():gsub(" ", ""), v1, 1, true) ~= nil
		local v5 = not p1.props.showFavorited or p2.faved
		local v6 = p1.props.showAll and not p12.hiddenAll or (p12.available or p2.owned)
		local v7
		if aerialEnabled then
			v7 = if aerialEnabled and p12.vehicleType == "Heli" then true elseif p1.props.title == "SPAWN" then RunUtils.isTradeWorld() else true
		else
			v7 = not p12.aerialOnly
			if not v7 then
				v7 = if aerialEnabled and p12.vehicleType == "Heli" then true elseif p1.props.title == "SPAWN" then RunUtils.isTradeWorld() else true
			end
		end
		if v3 then
			return v5 and (v6 and (v4 and v7))
		else
			return v5 and (v6 and v7)
		end
	end
	local t = {}
	local t2 = {}
	for i = 1, #items do
		local v10 = items[i]
		local v11 = metadata[i]
		if shouldShow(v10, v11, search) then
			local v12 = #t2 + 1
			t2[v12] = v10
			t[v12] = v11
		end
	end
	p1:_updateTitle()
	local t3 = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
		Size = UDim2.new(1, 0, 1, 0),
		LayoutOrder = 3
	}
	local t4 = {
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
	local t5 = {
		BackgroundTransparency = 0.4,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
		Size = UDim2.new(1, 0, 1, 0),
		LayoutOrder = 1
	}
	local t6 = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = v1
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, cornerPixel)
		})
	}
	local t7 = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(0.5, 0, 0.5, 0),
		Position = UDim2.new(0.25 / v1, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		Text = p1.titleBinding,
		Font = Enum.Font.LuckiestGuy,
		LineHeight = 0.7,
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left
	}
	t7.TextColor3 = if p1.props.title == SaleConsts.CATEGORY_NAME then Color3.new(1, 0.1, 0.1) else Color3.fromRGB(98, 222, 253)
	t7.ZIndex = 4
	t6.Title = createElement("TextLabel", t7, {
		UIStroke = createElement("UIStroke", {
			Color = Color3.new(0/255, 0/255, 0/255),
			Thickness = 1
		})
	})
	t6.OwnedCheckbox = p1.props.sortEnabled and createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0.75, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1 - 7 * v3 - 2 * v4 - 0.75 / v1, 0, 0.5, 0)
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
				value = p1.props.showAll,
				onChecked = p1.props.onToggleAll
			})
		})
	})
	local sortEnabled = p1.props.sortEnabled
	if sortEnabled then
		local t8 = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0.75, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(v7, 0, 0.5, 0)
		}
		local t9 = {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		}
		local t10 = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}
		t10.ImageColor3 = (p1.props.showFavorited or p1.state.favHover) and Color3.fromRGB(255, 251, 0) or Color3.new(0.7, 0.7, 0.7)
		t10.Image = "rbxassetid://8552830996"
		t10.ZIndex = 10
		t10[Roact.Event.MouseEnter] = function() --[[ Line: 218 | Upvalues: p1 (copy) ]]
			p1:setState({
				favHover = true
			})
		end
		t10[Roact.Event.MouseLeave] = function() --[[ Line: 223 | Upvalues: p1 (copy) ]]
			p1:setState({
				favHover = false
			})
		end
		t10[Roact.Event.SelectionGained] = function() --[[ Line: 228 | Upvalues: p1 (copy) ]]
			p1:setState({
				favHover = true
			})
		end
		t10[Roact.Event.SelectionLost] = function() --[[ Line: 233 | Upvalues: p1 (copy) ]]
			p1:setState({
				favHover = false
			})
		end
		t10[Roact.Event.Activated] = p1.props.onToggleFavorited
		t9.Star = createElement("ImageButton", t10)
		sortEnabled = createElement("Frame", t8, t9)
	end
	t6.FavoritedCheckbox = sortEnabled
	t6.SortContainer = p1.props.sortEnabled and createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0.75, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1 - 3 * v3 - v4, 0, 0.5, 0)
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
				[Roact.Event.Activated] = function() --[[ Line: 286 | Upvalues: p1 (copy) ]]
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
					Text = v9,
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
	t6.SearchContainer = p1.props.sortEnabled and createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0.75, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1 - v3, 0, 0.5, 0)
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
			[Roact.Ref] = p1.searchRef
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, cornerPixel)
			})
		})
	})
	t4.Top = createElement("Frame", t5, t6)
	t4.Padding1 = createElement("Frame", {
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
	t4.Body = createElement("Frame", {
		BackgroundTransparency = 0.4,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
		Size = UDim2.new(1, 0, 1, 0),
		LayoutOrder = 3
	}, {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = v2
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, cornerPixel)
		}),
		ScrollingGrid = createElement(ScrollingGrid, {
			aspectRatio = v2,
			paddingRatio = paddingRatio,
			component = CustomizeItem,
			items = t2,
			metadata = t,
			onSelectItem = p1.props.onSelectItem,
			colsPerRow = p1.props.colsPerRow,
			rowsPerPage = p1.props.rowsPerPage
		})
	})
	return createElement("Frame", t3, t4)
end
function v1._updateTitle(p1) --[[ Line: 379 | Upvalues: SaleConsts (copy), SaleUtils (copy) ]]
	if p1.props.title == SaleConsts.CATEGORY_NAME then
		p1.updateTitleBinding(SaleConsts.CATEGORY_NAME .. ": " .. SaleUtils.formatRemaining(SaleUtils.getTimeToNextSale()))
	else
		p1.updateTitleBinding(p1.props.title)
	end
end
function v1.didMount(p1) --[[ Line: 388 | Upvalues: Interval (copy), Players (copy), GarageConsts (copy) ]]
	p1.maid.updateTitle = Interval.every(1):Connect(function() --[[ Line: 389 | Upvalues: p1 (copy) ]]
		p1:_updateTitle()
	end)
	local v1 = p1.searchRef:getValue()
	if v1 then
		p1.maid:GiveTask(v1:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 394 | Upvalues: p1 (copy), v1 (copy) ]]
			p1.maid.searchDelay = task.delay(0.1, function() --[[ Line: 395 | Upvalues: p1 (ref), v1 (ref) ]]
				p1:setState({
					search = v1.Text
				})
			end)
		end))
	end
	if Players.LocalPlayer then
		p1.maid:GiveTask(Players.LocalPlayer:GetAttributeChangedSignal(GarageConsts.AERIAL_SPAWN_ATTR_NAME):Connect(function() --[[ Line: 405 | Upvalues: p1 (copy), Players (ref), GarageConsts (ref) ]]
			local t = {}
			t.aerialEnabled = Players.LocalPlayer:GetAttribute(GarageConsts.AERIAL_SPAWN_ATTR_NAME) == true
			p1:setState(t)
		end))
		if p1.state.aerialEnabled ~= Players.LocalPlayer:GetAttribute(GarageConsts.AERIAL_SPAWN_ATTR_NAME) then
			local t = {}
			t.aerialEnabled = Players.LocalPlayer:GetAttribute(GarageConsts.AERIAL_SPAWN_ATTR_NAME) == true
			p1:setState(t)
		end
	end
end
function v1.willUnmount(p1) --[[ Line: 418 ]]
	p1.maid:DoCleaning()
end
return RoactRodux.connect(function(p1, p2) --[[ Line: 422 ]]
	return {
		sortId = p1.garageSort
	}
end, function(p1) --[[ Line: 430 | Upvalues: EnumSort (copy) ]]
	return {
		onSelectSort = function(p12) --[[ Name: onSelectSort | Line: 432 | Upvalues: EnumSort (ref), p1 (copy) ]]
			local count = 0
			for v1 in EnumSort:GetEnumItems() do
				count = count + 1
			end
			p1({
				type = "setSort",
				id = p12 % count + 1
			})
		end
	}
end)(v1)