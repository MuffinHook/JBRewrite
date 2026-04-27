local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local String = require(ReplicatedStorage.Std.String)
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local createElement = Roact.createElement
local CustomizeItemComponent = Roact.PureComponent:extend("CustomizeItem")
CustomizeItemComponent.defaultProps = {
	faved = false,
	canFavorite = true,
	favHeight = 0.165,
	cashHeight = 0.08,
	accentColor = Color3.fromRGB(98, 222, 253)
}
function CustomizeItemComponent.init(self)
	self:setState({
		hover = false,
		favHover = false
	})
	self.cameraRef = Roact.createRef()
	self.viewportRef = Roact.createRef()
	self.maid = Maid.new()
	self.mountCount = 0
end
function CustomizeItemComponent.render(self)
	local aspectRatio = self.props.aspectRatio
	local cornerPixel = self.props.cornerPixel
	local paddingRatio = self.props.paddingRatio
	local statusText = if self.props.equipped then "EQUIPPED" elseif self.props.owned then "OWNED" else self.props.price and self.props.price > 0 and "$" .. String.comma(self.props.price) or "FREE"
	local offSalePriceText = if self.props.offSalePrice and not (self.props.equipped or self.props.owned) then "$" .. String.comma(self.props.offSalePrice) else nil
	local cashHeight = self.props.cashHeight
	local favHeightScaled = self.props.favHeight * aspectRatio
	local buttonProps = {}
	buttonProps.Size = self.props.size or UDim2.new(1, 0, 1, 0)
	buttonProps.Position = self.props.position
	buttonProps.BackgroundTransparency = 0
	buttonProps.BorderSizePixel = 0
	buttonProps.Selectable = true
	buttonProps.AutoButtonColor = false
	buttonProps.Text = ""
	buttonProps.BackgroundColor3 = self.props.equipped and Color3.new(255/255, 255/255, 255/255) or (self.props.selected and Color3.new(0.05, 0.05, 0.05) or Color3.new(0.1, 0.1, 0.1))
	buttonProps.LayoutOrder = self.props.layoutOrder
	buttonProps[Roact.Event.MouseEnter] = function()
		self:setState({
			hover = true
		})
	end
	buttonProps[Roact.Event.MouseLeave] = function()
		self:setState({
			hover = false
		})
	end
	buttonProps[Roact.Event.SelectionGained] = function()
		self:setState({
			hover = true
		})
	end
	buttonProps[Roact.Event.SelectionLost] = function()
		self:setState({
			hover = false
		})
	end
	buttonProps[Roact.Event.Activated] = self.props.onSelect or self.props.onClick
	local childElements = {}
	local strokeProps = {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	}
	strokeProps.Color = self.state.hover and self.props.accentColor or (self.props.equipped and Color3.new(204/255, 204/255, 204/255) or (self.props.selected and Color3.fromRGB(134, 195, 81) or (offSalePriceText and Color3.new(255/255, 0/255, 0/255) or Color3.new(1, 0.1, 0.1))))
	strokeProps.Thickness = if self.props.equipped then 2 else 1
	strokeProps.Enabled = (self.props.owned and self.props.equipped or (self.props.selected or (self.state.hover or self.props.offSalePrice))) and true or false
	childElements.UIStroke = createElement("UIStroke", strokeProps)
	childElements.UICorner = createElement("UICorner", {
		CornerRadius = UDim.new(0, cornerPixel)
	})
	childElements.Viewport = createElement("ViewportFrame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, paddingRatio + 0.1, 0),
		Size = UDim2.new(1, 0, 1 - (paddingRatio + 0.1) - 0.5 * paddingRatio * 2 - favHeightScaled - paddingRatio * 0.5, 0),
		Ambient = Color3.new(255/255, 255/255, 255/255),
		LightColor = Color3.new(255/255, 255/255, 255/255),
		CurrentCamera = self.cameraRef,
		[Roact.Ref] = self.viewportRef
	}, {
		Camera = createElement("Camera", {
			FieldOfView = self.props.fieldOfView,
			[Roact.Ref] = self.cameraRef
		})
	})
	local maskProps = {
		BackgroundTransparency = 0.4,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 3
	}
	local shouldShowMask = if self.props.masked == nil then false else self.props.masked
	if not shouldShowMask then
		shouldShowMask = if self.props.masked == nil then self.props.owned == false else false
	end
	maskProps.Visible = shouldShowMask
	childElements.Mask = createElement("Frame", maskProps, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, cornerPixel)
		})
	})
	childElements.Locked = self.props.locked and createElement("ImageLabel", {
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
	local titleProps = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1 - paddingRatio * 2, 0, 0.1, 0),
		Position = UDim2.new(0.5, 0, 0.5 * paddingRatio * 2, 0),
		AnchorPoint = Vector2.new(0.5, 0),
		Text = self.props.title,
		Font = Enum.Font.LuckiestGuy,
		LineHeight = 0.7,
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Top
	}
	titleProps.TextColor3 = self.props.equipped and Color3.new(0.1, 0.1, 0.1) or Color3.new(255/255, 255/255, 255/255)
	titleProps.ZIndex = 10
	childElements.Title = createElement("TextLabel", titleProps)
	local offSalePriceLabelElement
	if offSalePriceText then
		local offSalePriceProps = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1 - paddingRatio / aspectRatio * 2, 0, cashHeight * 0.8, 0),
			Position = UDim2.new(0.5, 0, 1 - 0.5 * paddingRatio * 2 - favHeightScaled - paddingRatio * 0.5 - cashHeight - paddingRatio, 0),
			AnchorPoint = Vector2.new(0.5, 1),
			Text = offSalePriceText,
			Font = Enum.Font.LuckiestGuy,
			LineHeight = 0.7,
			TextScaled = true,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			TextColor3 = Color3.new(255/255, 204/255, 204/255)
		}
		offSalePriceProps.Visible = not self.props.limited or self.props.owned or self.props.equipped or false
		offSalePriceProps.ZIndex = 10
		offSalePriceLabelElement = createElement("TextLabel", offSalePriceProps, {
			CrossOut = createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(230, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.new(0.7, 0, 0, 2),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5)
			})
		})
	else
		offSalePriceLabelElement = nil
	end
	childElements.OffSalePrice = offSalePriceLabelElement
	local priceProps = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1 - paddingRatio / aspectRatio * 2, 0, cashHeight, 0),
		Position = UDim2.new(0.5, 0, 1 - 0.5 * paddingRatio * 2 - favHeightScaled - paddingRatio * 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 1),
		Text = statusText,
		Font = Enum.Font.LuckiestGuy,
		LineHeight = 0.7,
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center
	}
	priceProps.TextColor3 = self.props.equipped and Color3.new(0.1, 0.1, 0.1) or (self.props.owned and Color3.new(255/255, 255/255, 255/255) or (offSalePriceText and Color3.new(1, 0.1, 0.1) or Color3.fromRGB(134, 195, 81)))
	priceProps.Visible = not self.props.limited or self.props.owned or self.props.equipped or false
	priceProps.ZIndex = 10
	childElements.Price = createElement("TextLabel", priceProps)
	childElements.CreatorName = if self.state.creatorVisible then createElement("TextLabel", {
	Text = ("by: %*"):format(self.props.creatorName),
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
}) else self.state.creatorHover and createElement("TextLabel", {
	Text = ("by: %*"):format(self.props.creatorName),
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
	local creatorName = self.props.creatorName
	if creatorName then
		local creatorToggleProps = {
			Size = UDim2.new(favHeightScaled / aspectRatio, 0, favHeightScaled, 0),
			Position = UDim2.new(1 - 0.5 * paddingRatio / aspectRatio * 2 - favHeightScaled / aspectRatio - paddingRatio / aspectRatio, 0, 1 - 0.5 * paddingRatio * 2, 0),
			AnchorPoint = Vector2.new(1, 1),
			BackgroundTransparency = 0
		}
		creatorToggleProps.BackgroundColor3 = self.state.creatorHover and Color3.new(0.5, 0.5, 0.5) or Color3.new(0.7, 0.7, 0.7)
		creatorToggleProps.Text = ""
		creatorToggleProps.ZIndex = 10
		creatorToggleProps[Roact.Event.MouseEnter] = function()
			self:setState({
				creatorHover = true
			})
		end
		creatorToggleProps[Roact.Event.MouseLeave] = function()
			self:setState({
				creatorHover = false
			})
		end
		creatorToggleProps[Roact.Event.SelectionGained] = function()
			self:setState({
				creatorHover = true
			})
		end
		creatorToggleProps[Roact.Event.SelectionLost] = function()
			self:setState({
				creatorHover = false
			})
		end
		creatorToggleProps[Roact.Event.Activated] = function()
			self:setState({
				creatorVisible = not self.state.creatorVisible
			})
		end
		creatorName = createElement("TextButton", creatorToggleProps, {
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
	childElements.CreatorToggle = creatorName
	local canFavorite = self.props.canFavorite
	if canFavorite then
		local favoriteButtonProps = {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(favHeightScaled / aspectRatio, 0, favHeightScaled, 0),
			Position = UDim2.new(1 - 0.5 * paddingRatio / aspectRatio * 2, 0, 1 - 0.5 * paddingRatio * 2, 0),
			AnchorPoint = Vector2.new(1, 1)
		}
		favoriteButtonProps.ImageColor3 = (self.props.faved or self.state.favHover) and Color3.fromRGB(255, 251, 0) or Color3.new(0.7, 0.7, 0.7)
		favoriteButtonProps.Image = "rbxassetid://8552830996"
		favoriteButtonProps.ZIndex = 10
		favoriteButtonProps[Roact.Event.MouseEnter] = function()
			self:setState({
				favHover = true
			})
		end
		favoriteButtonProps[Roact.Event.MouseLeave] = function()
			self:setState({
				favHover = false
			})
		end
		favoriteButtonProps[Roact.Event.SelectionGained] = function()
			self:setState({
				favHover = true
			})
		end
		favoriteButtonProps[Roact.Event.SelectionLost] = function()
			self:setState({
				favHover = false
			})
		end
		favoriteButtonProps[Roact.Event.Activated] = function()
			if self.props.onFavorite then
				self.props.onFavorite(not self.props.faved)
			end
		end
		canFavorite = createElement("ImageButton", favoriteButtonProps)
	end
	childElements.Star = canFavorite
	childElements.CustomContainer = self.props.customComponent and createElement("Frame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(favHeightScaled / aspectRatio, 0, favHeightScaled, 0),
		Position = UDim2.new(1 - 0.5 * paddingRatio / aspectRatio * 2, 0, 1 - 0.5 * paddingRatio * 2, 0),
		AnchorPoint = Vector2.new(1, 1),
		ZIndex = 5
	}, {
		CustomComponent = self.props.customComponent
	})
	local tagsContainerProps = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0
	}
	tagsContainerProps.Size = self.props.canFavorite and UDim2.new(1 + (-paddingRatio * 2 - favHeightScaled - paddingRatio * 0.5) / aspectRatio, 0, favHeightScaled, 0) or UDim2.new(1 + -paddingRatio * 2 / aspectRatio, 0, favHeightScaled, 0)
	tagsContainerProps.Position = UDim2.new(paddingRatio / aspectRatio, 0, 1 - 0.5 * paddingRatio * 2, 0)
	tagsContainerProps.AnchorPoint = Vector2.new(0, 1)
	tagsContainerProps.ZIndex = 10
	local tagsElements = {}
	local seasonLevelBadgeProps = {
		Size = UDim2.new(0.7 - 0.5 * paddingRatio * 0.5 / aspectRatio, 0, 1, 0)
	}
	seasonLevelBadgeProps.BackgroundColor3 = if self.props.fakeLimited then Color3.fromRGB(253, 212, 98) else self.props.accentColor
	seasonLevelBadgeProps.Visible = (self.props.season or (self.props.level or (self.props.limited or self.props.fakeLimited))) and true or false
	local seasonLevelBadgeChildren = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0.25, 0)
		})
	}
	local seasonLevelTextProps = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(0.9, 0, 0.8, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5)
	}
	seasonLevelTextProps.Text = self.props.season and self.props.level and ("S%d-L%d"):format(self.props.season, self.props.level) or (self.props.season and self.props.topPct and ("S%d-%d%%"):format(self.props.season, self.props.topPct) or (self.props.season and ("S%d"):format(self.props.season) or (self.props.level and ("L%d"):format(self.props.level) or if self.props.limited or self.props.fakeLimited then "LIMITED" else "")))
	seasonLevelTextProps.Font = Enum.Font.LuckiestGuy
	seasonLevelTextProps.LineHeight = 0.7
	seasonLevelTextProps.TextScaled = true
	seasonLevelTextProps.TextXAlignment = Enum.TextXAlignment.Center
	seasonLevelTextProps.TextYAlignment = Enum.TextYAlignment.Center
	seasonLevelTextProps.TextColor3 = ColorUtils.brightenBy(self.props.accentColor, -0.7)
	seasonLevelTextProps.ZIndex = 10
	seasonLevelBadgeChildren.Title = createElement("TextLabel", seasonLevelTextProps)
	tagsElements.SeasonLevel = createElement("Frame", seasonLevelBadgeProps, seasonLevelBadgeChildren)
	local vipBadgeProps = {
		Position = UDim2.new(0.7 + 0.5 * paddingRatio * 0.5 / aspectRatio, 0, 0, 0),
		Size = UDim2.new(0.3 - 0.5 * paddingRatio * 0.5 / aspectRatio, 0, 1, 0),
		BackgroundColor3 = self.props.accentColor
	}
	vipBadgeProps.Visible = self.props.vip and true or false
	tagsElements.VIP = createElement("Frame", vipBadgeProps, {
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
	childElements.Tags = createElement("Frame", tagsContainerProps, tagsElements)
	return createElement("TextButton", buttonProps, childElements)
end
function CustomizeItemComponent._updateViewport(self)
	local camera = self.cameraRef:getValue()
	local inst = self.maid.inst
	if inst and inst.Parent ~= nil then
		self.props.updateCamera(camera, inst)
	end
end
function CustomizeItemComponent._reparent(self)
	local viewport = self.viewportRef:getValue()
	self.maid.inst = nil
	if self.props.getInst then
		local mountCount = self.mountCount
		task.delay(math.random() * 0.3, function()
			if self.mounted and self.mountCount == mountCount then
				local newInstance = self.props.getInst()
				self.maid.inst = newInstance
				newInstance.Parent = viewport
			end
		end)
	end
	self:_updateViewport()
end
function CustomizeItemComponent.didMount(self)
	self.mounted = true
	self.mountCount = self.mountCount + 1
	self:_reparent()
	self.maid.updateCamera = RunService.Heartbeat:Connect(function()
		self:_updateViewport()
	end)
end
function CustomizeItemComponent.didUpdate(self, prevProps, prevState)
	if self.props.getInstCompare and self.props.getInstCompare ~= prevProps.getInstCompare or not self.props.getInstCompare and self.props.getInst ~= prevProps.getInst then
		self:_reparent()
	end
end
function CustomizeItemComponent.willUnmount(self)
	self.mounted = false
	self.maid:DoCleaning()
end
return CustomizeItemComponent
