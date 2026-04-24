-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local ViewportFrame = require(ReplicatedStorage.EzUi.ViewportFrame)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local ScrollingGrid = require(ReplicatedStorage.EzUi.ScrollingGrid)
local function infoComponent(p1)
	local v1 = p1.valueColor or Color3.new(255/255, 255/255, 255/255)
	local t2 = {}
	local t3 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.9, 0, 0.3, 0),
		Position = UDim2.new(0.5, 0, 0, 0),
		AnchorPoint = Vector2.new(0.5, 0),
		Text = p1.title,
		Font = Enum.Font.Bangers,
		TextXAlignment = Enum.TextXAlignment.Center,
		LineHeight = 1,
		TextScaled = true
	}
	t3.TextColor3 = p1.titleColor or Color3.new(255/255, 255/255, 255/255)
	t2.Title = createElement("TextLabel", t3)
	t2.Value = createElement("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.9, 0, 0.7, 0),
		Position = UDim2.new(0.5, 0, 0.3, 0),
		AnchorPoint = Vector2.new(0.5, 0),
		Text = p1.value,
		Font = Enum.Font.Bangers,
		TextXAlignment = Enum.TextXAlignment.Center,
		LineHeight = 1,
		TextScaled = true,
		TextColor3 = v1
	})
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = p1.size,
		Position = p1.position
	}, t2)
end
local v1 = Roact.PureComponent:extend("TradeCard")
v1.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	cornerPixel = 8,
	aspectRatio = 0.5,
	selected = false,
	number = nil,
	isOriginalOwner = false
}
function v1.init(p1)
	p1:setState({
		hover = false,
		hoverInfo = false,
		showInfo = false
	})
	function p1.setHoverTrue()
		p1:setState({
			hover = true
		})
	end
	function p1.setHoverFalse()
		p1:setState({
			hover = false
		})
	end
	function p1.setHoverInfoTrue()
		p1:setState({
			hoverInfo = true
		})
	end
	function p1.setHoverInfoFalse()
		p1:setState({
			hoverInfo = false
		})
	end
end
function v1.render(p1)
	local aspectRatio = p1.props.aspectRatio
	local v3 = 10
	local v4 = 8
	if p1.state.showInfo then
		v4 = v4 * 2
		v3 = v3 * 2
	end
	local v5 = 1 / (1 - 1 / v4 - 1 / v3 - 0.05)
	local v6 = 0.8 * aspectRatio
	local v7 = if p1.props.showPlus then Color3.fromRGB(0, 200, 90) elseif p1.props.itemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then Color3.fromRGB(122, 212, 255) elseif p1.props.itemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then Color3.fromRGB(255, 90, 82) elseif p1.props.itemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then Color3.fromRGB(255, 213, 122) elseif p1.props.itemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE then Color3.fromRGB(167, 131, 255) elseif p1.props.itemType == PlayerDataConsts.SAFE_ITEM_TYPE then Color3.fromRGB(255, 126, 191) else Color3.new(204/255, 204/255, 204/255)
	local v15, v16, v17
	if p1.state.hover and not p1.state.hoverInfo then
		v15 = v7
		v16 = v7
		v17 = -0.2
	else
		v15 = v7
		v16 = v7
		v17 = 0
	end
	local v18 = ColorUtils.brightenBy(v16, v17)
	local t = {}
	if p1.props.showPlus then
		t.Plus = createElement("Frame", {
			BackgroundColor3 = v18,
			BackgroundTransparency = 0,
			Size = UDim2.new(0.8, 0, 0.8 * aspectRatio, 0),
			Position = UDim2.new(0.09999999999999998, 0, 1 - v6 - 0.09999999999999998, 0)
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
	elseif p1.props.blank then
		t.Blank = createElement("Frame", {
			BackgroundColor3 = v18,
			BackgroundTransparency = 0,
			Size = UDim2.new(0.8, 0, 0.8 * aspectRatio, 0),
			Position = UDim2.new(0.09999999999999998, 0, 1 - v6 - 0.09999999999999998, 0)
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			})
		})
	elseif p1.state.showInfo then
		local t2 = {
			BorderSizePixel = 0
		}
		t2.BackgroundColor3 = (p1.state.hover or p1.state.hoverInfo) and Color3.new(0.1, 0.1, 0.1) or Color3.new(0.25, 0.25, 0.25)
		t2.Size = UDim2.new(0.15, 0, 0.15 * aspectRatio, 0)
		t2.Position = UDim2.new(0.834375, 0, 0.015625 * aspectRatio, 0)
		t2.ZIndex = 4
		t.Info = createElement("Frame", t2, {
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
		t.ClickInfo = createElement("TextButton", {
			BackgroundTransparency = 1,
			Selectable = false,
			AutoButtonColor = false,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Text = "",
			Size = UDim2.new(0.3, 0, 0.3 * aspectRatio, 0),
			Position = UDim2.new(0.7, 0, 0, 0),
			ZIndex = 4,
			[Roact.Event.MouseEnter] = p1.setHoverInfoTrue,
			[Roact.Event.MouseLeave] = p1.setHoverInfoFalse,
			[Roact.Event.SelectionGained] = p1.setHoverInfoTrue,
			[Roact.Event.SelectionLost] = p1.setHoverInfoFalse,
			[Roact.Event.Activated] = function()
				p1:setState({
					showInfo = false
				})
				if p1.props.onCardFlipped then
					p1.props.onCardFlipped()
				end
			end
		})
		t.InfoContainer = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1 / v5, 0),
			Position = UDim2.new(0, 0, 1 - 1 / v5, 0)
		}, {
			Line = createElement("Frame", {
				BackgroundTransparency = 0.8,
				BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
				Size = UDim2.new(1, 0, 0, 1)
			}),
			InfoItems = createElement(ScrollingGrid, {
				aspectRatio = v5,
				paddingRatio = 64,
				rowsPerPage = 3,
				colsPerRow = 1,
				component = infoComponent,
				items = p1.props.info
			})
		})
	else
		if p1.props.getInst then
			t.ViewportFrame = createElement(ViewportFrame, {
				backgroundColor = v18,
				backgroundTransparency = 0,
				getInst = p1.props.getInst,
				getInstCompare = p1.props.getInstCompare,
				updateCamera = p1.props.updateCamera,
				size = UDim2.new(0.8, 0, 0.8 * aspectRatio, 0),
				position = UDim2.new(0.09999999999999998, 0, 1 - v6 - 0.09999999999999998, 0)
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(1, 0)
				})
			})
		else
			t.ViewportFrame = createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundColor3 = v18,
				Size = UDim2.new(0.8, 0, 0.8 * aspectRatio, 0),
				Position = UDim2.new(0.09999999999999998, 0, 1 - v6 - 0.09999999999999998, 0)
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(1, 0)
				}),
				Icon = createElement("ImageLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(0.9, 0, 0.9, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Image = p1.props.image
				})
			})
		end
		local v22 = v18
		local v23 = v6 * 0.5 * 0.5956993044924335
		if p1.props.season then
			t.Season = createElement("Frame", {
				BackgroundColor3 = v22,
				Size = UDim2.new(0.25, 0, 0.25 * aspectRatio, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.17871698740774206, 0, 0.9 - v6 * 0.5 + v23, 0),
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
					Text = ("S%d"):format(p1.props.season),
					Font = Enum.Font.Bangers,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = Color3.new(255/255, 255/255, 255/255)
				})
			})
		end
		local v24 = v6 * 0.5 * 0.9569403357322089
		if p1.props.level then
			t.Level = createElement("Frame", {
				BackgroundColor3 = v22,
				Size = UDim2.new(0.2, 0, 0.2 * aspectRatio, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.3838861290982151, 0, 0.9 - v6 * 0.5 + v24, 0),
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
					Text = ("L%d"):format(p1.props.level),
					Font = Enum.Font.Bangers,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = Color3.new(255/255, 255/255, 255/255)
				})
			})
		end
		local t2 = {
			BorderSizePixel = 0
		}
		t2.BackgroundColor3 = p1.state.hoverInfo and Color3.new(0.1, 0.1, 0.1) or Color3.new(0.25, 0.25, 0.25)
		t2.Size = UDim2.new(0.15, 0, 0.15 * aspectRatio, 0)
		t2.Position = UDim2.new(0.834375, 0, 0.015625 * aspectRatio, 0)
		t.Info = createElement("Frame", t2, {
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
		t.ClickInfo = createElement("TextButton", {
			BackgroundTransparency = 1,
			AutoButtonColor = false,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Text = "",
			Size = UDim2.new(0.3, 0, 0.3 * aspectRatio, 0),
			Position = UDim2.new(0.7, 0, 0, 0),
			ZIndex = 4,
			[Roact.Event.MouseEnter] = p1.setHoverInfoTrue,
			[Roact.Event.MouseLeave] = p1.setHoverInfoFalse,
			[Roact.Event.SelectionGained] = p1.setHoverInfoTrue,
			[Roact.Event.SelectionLost] = p1.setHoverInfoFalse,
			[Roact.Event.Activated] = function()
				p1:setState({
					showInfo = true
				})
				if p1.props.onCardFlipped then
					p1.props.onCardFlipped()
				end
			end
		})
		if p1.props.number then
			local t3 = {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
				Size = UDim2.new(0.15, 0, 0.15, 0),
				Position = UDim2.new(0.834375, 0, 0.85 - 0.015625 * aspectRatio, 0),
				ZIndex = 3
			}
			local t4 = {}
			local t5 = {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5)
			}
			t5.Text = "#" .. tostring(p1.props.number)
			t5.Font = Enum.Font.SourceSansBold
			t5.TextXAlignment = Enum.TextXAlignment.Right
			t5.LineHeight = 1
			t5.TextScaled = true
			t5.TextColor3 = v22
			t4.Text = createElement("TextLabel", t5)
			t.Number = createElement("Frame", t3, t4)
		end
	end
	if not (p1.props.showPlus or p1.props.blank or p1.state.showInfo) or p1.state.showInfo then
		local v30 = Color3.new(0.25, 0.25, 0.25)
		if p1.state.showInfo then
			v30 = Color3.new(255/255, 255/255, 255/255)
		end
		t.Category = createElement("Frame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(0.95, 0, 1 / v3, 0),
			Position = UDim2.new(0.05, 0, 0.05 * aspectRatio, 0),
			ZIndex = 3
		}, {
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1.2, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = p1.props.categoryTitle,
				Font = Enum.Font.Bangers,
				TextXAlignment = Enum.TextXAlignment.Left,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = v30
			})
		})
		local v32 = Color3.new(0.1, 0.1, 0.1)
		if p1.state.showInfo then
			v32 = Color3.new(255/255, 255/255, 255/255)
		end
		t.Title = createElement("Frame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(0.95, 0, 1 / v4, 0),
			Position = UDim2.new(0.05, 0, 1 / v3 + 0.05 * aspectRatio, 0),
			ZIndex = 3
		}, {
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1.2, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = p1.props.title,
				Font = Enum.Font.Bangers,
				TextXAlignment = Enum.TextXAlignment.Left,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = v32
			})
		})
	end
	if p1.props.selected then
		t.Selected = createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.8, 0, 0.8 * aspectRatio, 0),
			Position = UDim2.new(0.09999999999999998, 0, 1 - v6 - 0.09999999999999998, 0),
			Image = "rbxassetid://9839329507",
			ZIndex = 6
		})
	end
	local v34 = p1.props.isOriginalOwner and Color3.fromRGB(255, 238, 152) or Color3.new(255/255, 255/255, 255/255)
	if p1.state.showInfo then
		v34 = v15
	end
	if p1.state.hover and not (p1.state.hoverInfo or p1.state.showInfo) then
		v34 = ColorUtils.brightenBy(v34, -0.1)
	end
	return createElement("TextButton", {
		AutoButtonColor = false,
		BorderSizePixel = 0,
		Selectable = true,
		Size = p1.props.size,
		Position = p1.props.position,
		BackgroundColor3 = v34,
		Text = "",
		[Roact.Event.MouseEnter] = p1.setHoverTrue,
		[Roact.Event.MouseLeave] = p1.setHoverFalse,
		[Roact.Event.SelectionGained] = p1.setHoverTrue,
		[Roact.Event.SelectionLost] = p1.setHoverFalse,
		[Roact.Event.Activated] = function()
			if p1.state.showInfo then
				p1:setState({
					showInfo = false
				})
				if p1.props.onCardFlipped then
					p1.props.onCardFlipped()
				end
			elseif p1.props.onClick then
				p1.props.onClick(p1.props.index)
			end
		end
	}, Dictionary.merge({
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, p1.props.cornerPixel)
		})
	}, t))
end
return v1
