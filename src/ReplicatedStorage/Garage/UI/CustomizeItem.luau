local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local String = require(ReplicatedStorage.Std.String)
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("CustomizeItem")
v1.defaultProps = {
	faved = false,
	canFavorite = true,
	favHeight = 0.165,
	cashHeight = 0.08,
	accentColor = Color3.fromRGB(98, 222, 253)
}
function v1.init(p1) --[[ Line: 19 | Upvalues: Roact (copy), Maid (copy) ]]
	p1:setState({
		hover = false,
		favHover = false
	})
	p1.cameraRef = Roact.createRef()
	p1.viewportRef = Roact.createRef()
	p1.maid = Maid.new()
	p1.mountCount = 0
end
function v1.render(p1) --[[ Line: 29 | Upvalues: String (copy), createElement (copy), Roact (copy), ColorUtils (copy) ]]
	local aspectRatio = p1.props.aspectRatio
	local cornerPixel = p1.props.cornerPixel
	local paddingRatio = p1.props.paddingRatio
	local v1 = if p1.props.equipped then "EQUIPPED" elseif p1.props.owned then "OWNED" else p1.props.price and p1.props.price > 0 and "$" .. String.comma(p1.props.price) or "FREE"
	local v2 = if p1.props.offSalePrice and not (p1.props.equipped or p1.props.owned) then "$" .. String.comma(p1.props.offSalePrice) else nil
	local cashHeight = p1.props.cashHeight
	local v3 = p1.props.favHeight * aspectRatio
	local t = {}
	t.Size = p1.props.size or UDim2.new(1, 0, 1, 0)
	t.Position = p1.props.position
	t.BackgroundTransparency = 0
	t.BorderSizePixel = 0
	t.Selectable = true
	t.AutoButtonColor = false
	t.Text = ""
	t.BackgroundColor3 = p1.props.equipped and Color3.new(255/255, 255/255, 255/255) or (p1.props.selected and Color3.new(0.05, 0.05, 0.05) or Color3.new(0.1, 0.1, 0.1))
	t.LayoutOrder = p1.props.layoutOrder
	t[Roact.Event.MouseEnter] = function() --[[ Line: 59 | Upvalues: p1 (copy) ]]
		p1:setState({
			hover = true
		})
	end
	t[Roact.Event.MouseLeave] = function() --[[ Line: 64 | Upvalues: p1 (copy) ]]
		p1:setState({
			hover = false
		})
	end
	t[Roact.Event.SelectionGained] = function() --[[ Line: 69 | Upvalues: p1 (copy) ]]
		p1:setState({
			hover = true
		})
	end
	t[Roact.Event.SelectionLost] = function() --[[ Line: 74 | Upvalues: p1 (copy) ]]
		p1:setState({
			hover = false
		})
	end
	t[Roact.Event.Activated] = p1.props.onSelect or p1.props.onClick
	local t2 = {}
	local t3 = {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	}
	t3.Color = p1.state.hover and p1.props.accentColor or (p1.props.equipped and Color3.new(204/255, 204/255, 204/255) or (p1.props.selected and Color3.fromRGB(134, 195, 81) or (v2 and Color3.new(255/255, 0/255, 0/255) or Color3.new(1, 0.1, 0.1))))
	t3.Thickness = if p1.props.equipped then 2 else 1
	t3.Enabled = (p1.props.owned and p1.props.equipped or (p1.props.selected or (p1.state.hover or p1.props.offSalePrice))) and true or false
	t2.UIStroke = createElement("UIStroke", t3)
	t2.UICorner = createElement("UICorner", {
		CornerRadius = UDim.new(0, cornerPixel)
	})
	t2.Viewport = createElement("ViewportFrame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, paddingRatio + 0.1, 0),
		Size = UDim2.new(1, 0, 1 - (paddingRatio + 0.1) - 0.5 * paddingRatio * 2 - v3 - paddingRatio * 0.5, 0),
		Ambient = Color3.new(255/255, 255/255, 255/255),
		LightColor = Color3.new(255/255, 255/255, 255/255),
		CurrentCamera = p1.cameraRef,
		[Roact.Ref] = p1.viewportRef
	}, {
		Camera = createElement("Camera", {
			FieldOfView = p1.props.fieldOfView,
			[Roact.Ref] = p1.cameraRef
		})
	})
	local t4 = {
		BackgroundTransparency = 0.4,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 3
	}
	local v16 = if p1.props.masked == nil then false else p1.props.masked
	if not v16 then
		v16 = if p1.props.masked == nil then p1.props.owned == false else false
	end
	t4.Visible = v16
	t2.Mask = createElement("Frame", t4, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, cornerPixel)
		})
	})
	t2.Locked = p1.props.locked and createElement("ImageLabel", {
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		BorderSizePixel = 0,
		Size = UDim2.new(0.4 / aspectRatio, 0, 0.4, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		ZIndex = 4,
		Visible = true,
		Image = "rbxassetid://8715708455"
	})
	local t5 = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1 - paddingRatio * 2, 0, 0.1, 0),
		Position = UDim2.new(0.5, 0, 0.5 * paddingRatio * 2, 0),
		AnchorPoint = Vector2.new(0.5, 0),
		Text = p1.props.title,
		Font = Enum.Font.LuckiestGuy,
		LineHeight = 0.7,
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Top
	}
	t5.TextColor3 = p1.props.equipped and Color3.new(0.1, 0.1, 0.1) or Color3.new(255/255, 255/255, 255/255)
	t5.ZIndex = 10
	t2.Title = createElement("TextLabel", t5)
	local v21
	if v2 then
		local t6 = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1 - paddingRatio / aspectRatio * 2, 0, cashHeight * 0.8, 0),
			Position = UDim2.new(0.5, 0, 1 - 0.5 * paddingRatio * 2 - v3 - paddingRatio * 0.5 - cashHeight - paddingRatio, 0),
			AnchorPoint = Vector2.new(0.5, 1),
			Text = v2,
			Font = Enum.Font.LuckiestGuy,
			LineHeight = 0.7,
			TextScaled = true,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			TextColor3 = Color3.new(255/255, 204/255, 204/255)
		}
		t6.Visible = not p1.props.limited or p1.props.owned or p1.props.equipped or false
		t6.ZIndex = 10
		v21 = createElement("TextLabel", t6, {
			CrossOut = createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(230, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.new(0.7, 0, 0, 2),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5)
			})
		})
	else
		v21 = nil
	end
	t2.OffSalePrice = v21
	local t6 = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1 - paddingRatio / aspectRatio * 2, 0, cashHeight, 0),
		Position = UDim2.new(0.5, 0, 1 - 0.5 * paddingRatio * 2 - v3 - paddingRatio * 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 1),
		Text = v1,
		Font = Enum.Font.LuckiestGuy,
		LineHeight = 0.7,
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center
	}
	t6.TextColor3 = p1.props.equipped and Color3.new(0.1, 0.1, 0.1) or (p1.props.owned and Color3.new(255/255, 255/255, 255/255) or (v2 and Color3.new(1, 0.1, 0.1) or Color3.fromRGB(134, 195, 81)))
	t6.Visible = not p1.props.limited or p1.props.owned or p1.props.equipped or false
	t6.ZIndex = 10
	t2.Price = createElement("TextLabel", t6)
	t2.CreatorName = if p1.state.creatorVisible then createElement("TextLabel", {
	Text = ("by: %*"):format(p1.props.creatorName),
	TextColor3 = Color3.new(255/255, 255/255, 255/255),
	Size = UDim2.new(0.8, 0, 0.3, 0),
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.new(0.5, 0, 0.5, 0),
	Font = Enum.Font.LuckiestGuy,
	TextScaled = true,
	TextXAlignment = Enum.TextXAlignment.Center,
	TextYAlignment = Enum.TextYAlignment.Center,
	TextStrokeTransparency = 0.5,
	TextStrokeColor3 = Color3.new(0/255, 0/255, 0/255),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ZIndex = 10
}) else p1.state.creatorHover and createElement("TextLabel", {
	Text = ("by: %*"):format(p1.props.creatorName),
	TextColor3 = Color3.new(255/255, 255/255, 255/255),
	Size = UDim2.new(0.8, 0, 0.3, 0),
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.new(0.5, 0, 0.5, 0),
	Font = Enum.Font.LuckiestGuy,
	TextScaled = true,
	TextXAlignment = Enum.TextXAlignment.Center,
	TextYAlignment = Enum.TextYAlignment.Center,
	TextStrokeTransparency = 0.5,
	TextStrokeColor3 = Color3.new(0/255, 0/255, 0/255),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ZIndex = 10
})
	local creatorName = p1.props.creatorName
	if creatorName then
		local t7 = {
			Size = UDim2.new(v3 / aspectRatio, 0, v3, 0),
			Position = UDim2.new(1 - 0.5 * paddingRatio / aspectRatio * 2 - v3 / aspectRatio - paddingRatio / aspectRatio, 0, 1 - 0.5 * paddingRatio * 2, 0),
			AnchorPoint = Vector2.new(1, 1),
			BackgroundTransparency = 0
		}
		t7.BackgroundColor3 = p1.state.creatorHover and Color3.new(0.5, 0.5, 0.5) or Color3.new(0.7, 0.7, 0.7)
		t7.Text = ""
		t7.ZIndex = 10
		t7[Roact.Event.MouseEnter] = function() --[[ Line: 244 | Upvalues: p1 (copy) ]]
			p1:setState({
				creatorHover = true
			})
		end
		t7[Roact.Event.MouseLeave] = function() --[[ Line: 249 | Upvalues: p1 (copy) ]]
			p1:setState({
				creatorHover = false
			})
		end
		t7[Roact.Event.SelectionGained] = function() --[[ Line: 254 | Upvalues: p1 (copy) ]]
			p1:setState({
				creatorHover = true
			})
		end
		t7[Roact.Event.SelectionLost] = function() --[[ Line: 259 | Upvalues: p1 (copy) ]]
			p1:setState({
				creatorHover = false
			})
		end
		t7[Roact.Event.Activated] = function() --[[ Line: 264 | Upvalues: p1 (copy) ]]
			p1:setState({
				creatorVisible = not p1.state.creatorVisible
			})
		end
		creatorName = createElement("TextButton", t7, {
			Corner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			}),
			Button = createElement("ImageLabel", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.fromScale(0.8, 0.8),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				ImageColor3 = Color3.new(255/255, 255/255, 255/255),
				Image = "rbxassetid://124725555389299"
			})
		})
	end
	t2.CreatorToggle = creatorName
	local canFavorite = p1.props.canFavorite
	if canFavorite then
		local t7 = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(v3 / aspectRatio, 0, v3, 0),
			Position = UDim2.new(1 - 0.5 * paddingRatio / aspectRatio * 2, 0, 1 - 0.5 * paddingRatio * 2, 0),
			AnchorPoint = Vector2.new(1, 1)
		}
		t7.ImageColor3 = (p1.props.faved or p1.state.favHover) and Color3.fromRGB(255, 251, 0) or Color3.new(0.7, 0.7, 0.7)
		t7.Image = "rbxassetid://8552830996"
		t7.ZIndex = 10
		t7[Roact.Event.MouseEnter] = function() --[[ Line: 293 | Upvalues: p1 (copy) ]]
			p1:setState({
				favHover = true
			})
		end
		t7[Roact.Event.MouseLeave] = function() --[[ Line: 298 | Upvalues: p1 (copy) ]]
			p1:setState({
				favHover = false
			})
		end
		t7[Roact.Event.SelectionGained] = function() --[[ Line: 303 | Upvalues: p1 (copy) ]]
			p1:setState({
				favHover = true
			})
		end
		t7[Roact.Event.SelectionLost] = function() --[[ Line: 308 | Upvalues: p1 (copy) ]]
			p1:setState({
				favHover = false
			})
		end
		t7[Roact.Event.Activated] = function() --[[ Line: 313 | Upvalues: p1 (copy) ]]
			if p1.props.onFavorite then
				p1.props.onFavorite(not p1.props.faved)
			end
		end
		canFavorite = createElement("ImageButton", t7)
	end
	t2.Star = canFavorite
	t2.CustomContainer = p1.props.customComponent and createElement("Frame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(v3 / aspectRatio, 0, v3, 0),
		Position = UDim2.new(1 - 0.5 * paddingRatio / aspectRatio * 2, 0, 1 - 0.5 * paddingRatio * 2, 0),
		AnchorPoint = Vector2.new(1, 1),
		ZIndex = 5
	}, {
		CustomComponent = p1.props.customComponent
	})
	local t7 = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0
	}
	t7.Size = p1.props.canFavorite and UDim2.new(1 + (-paddingRatio * 2 - v3 - paddingRatio * 0.5) / aspectRatio, 0, v3, 0) or UDim2.new(1 + -paddingRatio * 2 / aspectRatio, 0, v3, 0)
	t7.Position = UDim2.new(paddingRatio / aspectRatio, 0, 1 - 0.5 * paddingRatio * 2, 0)
	t7.AnchorPoint = Vector2.new(0, 1)
	t7.ZIndex = 10
	local t8 = {}
	local t9 = {
		Size = UDim2.new(0.7 - 0.5 * paddingRatio * 0.5 / aspectRatio, 0, 1, 0)
	}
	t9.BackgroundColor3 = if p1.props.fakeLimited then Color3.fromRGB(253, 212, 98) else p1.props.accentColor
	t9.Visible = (p1.props.season or (p1.props.level or (p1.props.limited or p1.props.fakeLimited))) and true or false
	local t10 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0.25, 0)
		})
	}
	local t11 = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(0.9, 0, 0.8, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5)
	}
	t11.Text = p1.props.season and p1.props.level and ("S%d-L%d"):format(p1.props.season, p1.props.level) or (p1.props.season and p1.props.topPct and ("S%d-%d%%"):format(p1.props.season, p1.props.topPct) or (p1.props.season and ("S%d"):format(p1.props.season) or (p1.props.level and ("L%d"):format(p1.props.level) or if p1.props.limited or p1.props.fakeLimited then "LIMITED" else "")))
	t11.Font = Enum.Font.LuckiestGuy
	t11.LineHeight = 0.7
	t11.TextScaled = true
	t11.TextXAlignment = Enum.TextXAlignment.Center
	t11.TextYAlignment = Enum.TextYAlignment.Center
	t11.TextColor3 = ColorUtils.brightenBy(p1.props.accentColor, -0.7)
	t11.ZIndex = 10
	t10.Title = createElement("TextLabel", t11)
	t8.SeasonLevel = createElement("Frame", t9, t10)
	local t12 = {
		Position = UDim2.new(0.7 + 0.5 * paddingRatio * 0.5 / aspectRatio, 0, 0, 0),
		Size = UDim2.new(0.3 - 0.5 * paddingRatio * 0.5 / aspectRatio, 0, 1, 0),
		BackgroundColor3 = p1.props.accentColor
	}
	t12.Visible = p1.props.vip and true or false
	t8.VIP = createElement("Frame", t12, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0.25, 0)
		}),
		Title = createElement("TextLabel", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(0.9, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = "VIP",
			Font = Enum.Font.LuckiestGuy,
			LineHeight = 0.7,
			TextScaled = true,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			TextColor3 = Color3.fromRGB(0, 64, 80),
			ZIndex = 10
		})
	})
	t2.Tags = createElement("Frame", t7, t8)
	return createElement("TextButton", t, t2)
end
function v1._updateViewport(p1) --[[ Line: 408 ]]
	local v1 = p1.cameraRef:getValue()
	local inst = p1.maid.inst
	if inst and inst.Parent ~= nil then
		p1.props.updateCamera(v1, inst)
	end
end
function v1._reparent(p1) --[[ Line: 415 ]]
	local v1 = p1.viewportRef:getValue()
	p1.maid.inst = nil
	if p1.props.getInst then
		local mountCount = p1.mountCount
		task.delay(math.random() * 0.3, function() --[[ Line: 423 | Upvalues: p1 (copy), mountCount (copy), v1 (copy) ]]
			if p1.mounted and p1.mountCount == mountCount then
				local v12 = p1.props.getInst()
				p1.maid.inst = v12
				v12.Parent = v1
			end
		end)
	end
	p1:_updateViewport()
end
function v1.didMount(p1) --[[ Line: 434 | Upvalues: RunService (copy) ]]
	p1.mounted = true
	p1.mountCount = p1.mountCount + 1
	p1:_reparent()
	p1.maid.updateCamera = RunService.Heartbeat:Connect(function() --[[ Line: 438 | Upvalues: p1 (copy) ]]
		p1:_updateViewport()
	end)
end
function v1.didUpdate(p1, p2, p3) --[[ Line: 442 ]]
	if p1.props.getInstCompare and p1.props.getInstCompare ~= p2.getInstCompare or not p1.props.getInstCompare and p1.props.getInst ~= p2.getInst then
		p1:_reparent()
	end
end
function v1.willUnmount(p1) --[[ Line: 452 ]]
	p1.mounted = false
	p1.maid:DoCleaning()
end
return v1