local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local RunService = game:GetService("RunService")
require(ReplicatedStorage.App.MinimapConsts)
local Roact = require(ReplicatedStorage.Roact)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local createElement = Roact.createElement
local MinimapUtils = require(script.Parent.MinimapUtils)
local Minimap = Roact.PureComponent:extend("Minimap")
Minimap.defaultProps = {
	visible = true,
	open = true,
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	mapScale = 1,
	showToggleButton = true
}
function Minimap.init(self) --[[ Line: 23 | Upvalues: Maid (copy), Roact (copy) ]]
	self._maid = Maid.new()
	if self.props.containerSize then
		local updateContainerSize = self.props.updateContainerSize
		self.containerSize = self.props.containerSize
		self.updateContainerSize = updateContainerSize
	else
		local containerSizeBinding, updateContainerSize = Roact.createBinding(Vector2.new(512, 512))
		self.containerSize = containerSizeBinding
		self.updateContainerSize = updateContainerSize
	end
	if self.props.containerRef then
		self.containerRef = self.props.containerRef
	else
		self.containerRef = Roact.createRef()
	end
	self:setState({
		trackVisible = false
	})
end
local function makeMinimap(self, positionBinding, imageId, zIndex, scale, transparency) --[[ Line: 40 | Upvalues: createElement (copy), MinimapUtils (copy) ]]
	return createElement("ImageLabel", {
		Image = ("rbxassetid://%d"):format(imageId),
		ImageColor3 = self.props.mapImageColor3,
		BackgroundTransparency = transparency,
		Position = positionBinding:map(function(bindingPosition) --[[ Line: 46 | Upvalues: MinimapUtils (ref), self (copy), scale (copy) ]]
			local isValid, offsetX, offsetY = MinimapUtils.computeOffsetXY(bindingPosition[2], bindingPosition[1], self.props.mapWorldWidth, self.props.mapWorldHeight, self.props.mapWorldCenterX, self.props.mapWorldCenterY, self.props.mapImageWidth * scale, self.props.mapImageHeight * scale, self.props.mapScale)
			if isValid then
				return UDim2.new(0, -offsetX, 0, -offsetY)
			else
				return UDim2.new(0, 0, 0, 0)
			end
		end),
		Size = positionBinding:map(function(bindingPosition) --[[ Line: 63 | Upvalues: MinimapUtils (ref), self (copy), scale (copy) ]]
			local isValid, _, _2, scaleValue = MinimapUtils.computeOffsetXY(bindingPosition[2], bindingPosition[1], self.props.mapWorldWidth, self.props.mapWorldHeight, self.props.mapWorldCenterX, self.props.mapWorldCenterY, self.props.mapImageWidth * scale, self.props.mapImageHeight * scale, self.props.mapScale)
			if isValid then
				return UDim2.new(0, self.props.mapImageWidth * scale * scaleValue, 0, self.props.mapImageHeight * scale * scaleValue)
			else
				return UDim2.new(1, 0, 1, 0)
			end
		end),
		ImageRectSize = positionBinding:map(function(bindingPosition) --[[ Line: 84 | Upvalues: MinimapUtils (ref), self (copy), scale (copy) ]]
			local isValid, _, _2, scaleValue = MinimapUtils.computeOffsetXY(bindingPosition[2], bindingPosition[1], self.props.mapWorldWidth, self.props.mapWorldHeight, self.props.mapWorldCenterX, self.props.mapWorldCenterY, self.props.mapImageWidth * scale, self.props.mapImageHeight * scale, self.props.mapScale)
			if isValid then
				return nil
			end
			local imageRectSizeValue = bindingPosition[1]
			if imageRectSizeValue then
				return imageRectSizeValue / scaleValue
			end
		end),
		ImageRectOffset = positionBinding:map(function(bindingPosition) --[[ Line: 105 | Upvalues: MinimapUtils (ref), self (copy), scale (copy) ]]
			local isValid, offsetX, offsetY, scaleValue = MinimapUtils.computeOffsetXY(bindingPosition[2], bindingPosition[1], self.props.mapWorldWidth, self.props.mapWorldHeight, self.props.mapWorldCenterX, self.props.mapWorldCenterY, self.props.mapImageWidth * scale, self.props.mapImageHeight * scale, self.props.mapScale)
			if isValid then
				return nil
			else
				return Vector2.new(offsetX, offsetY) / scaleValue
			end
		end),
		ZIndex = zIndex
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	})
end
function Minimap.didMount(self) --[[ Line: 130 | Upvalues: RunService (copy), CharacterUtils (copy), Players (copy) ]]
	self._maid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 131 | Upvalues: self (copy), CharacterUtils (ref), Players (ref) ]]
		local now = os.clock()
		if self.props.points then
			for i, v in ipairs(self.props.points) do
				local distanceToPlayer, invisibilityDuration
				if v._position and v.part then
					v._updatePosition(v.part.Position)
				end
				if v._visible then
					if v.flash then
						if v.nextVisibleToggle < now then
							local shouldBeVisible = not v._visible:getValue()
							local playerRoot = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
							distanceToPlayer = if playerRoot and v._position then (playerRoot.Position - v._position:getValue()).Magnitude else 1.797693134862316e308
							if distanceToPlayer > 700 then
								shouldBeVisible = false
							end
							if shouldBeVisible then
								v.nextVisibleToggle = now + 0.3333333333333333
							else
								invisibilityDuration = v.invisibilityTimeFunc and v.invisibilityTimeFunc() or 3
								v.nextVisibleToggle = now + invisibilityDuration
							end
							v._updateVisible(shouldBeVisible)
						end
					elseif not v._visible:getValue() then
						v._updateVisible(true)
					end
				end
			end
		end
	end))
	self._maid:GiveTask(workspace:GetAttributeChangedSignal("RaceTrackActive"):Connect(function() --[[ Line: 168 | Upvalues: self (copy) ]]
		local stateUpdate = {}
		stateUpdate.trackVisible = workspace:GetAttribute("RaceTrackActive") == true
		self:setState(stateUpdate)
	end))
	local isNotTrackVisible = self.state.trackVisible ~= workspace:GetAttribute("RaceTrackActive")
	if isNotTrackVisible == true then
		local stateUpdate = {}
		stateUpdate.trackVisible = workspace:GetAttribute("RaceTrackActive") == true
		self:setState(stateUpdate)
	end
end
function Minimap.render(self) --[[ Line: 179 | Upvalues: Roact (copy), createElement (copy), MinimapUtils (copy), ColorUtils (copy), Dictionary (copy), makeMinimap (copy) ]]
	if self.props.visible then
		local children = self.props.pointsChildren or {}
		if self.props.points then
			for i, v in ipairs(self.props.points) do
				if not v._position then
					local initialPosition = v.worldPosition or v.part and v.part.Position
					if not initialPosition then
						if typeof(v._debugStr) == "string" then
							warn("^ debug str: " .. v._debugStr)
						end
						initialPosition = Vector3.new(0, 0, 0)
					end
					local positionBinding, updatePosition = Roact.createBinding(initialPosition)
					v._position = positionBinding
					v._updatePosition = updatePosition
				end
				if not v._visible then
					v.nextVisibleToggle = os.clock()
					local visibleBinding, updateVisible = Roact.createBinding(not v.flash)
					v._visible = visibleBinding
					v._updateVisible = updateVisible
				end
				local iconSize = v.size or UDim2.new(0, 16, 0, 16)
				if self.props.isSmallScreen then
					iconSize = UDim2.new(0, iconSize.X.Offset / 2, 0, iconSize.Y.Offset / 2)
				end
				children[v.name] = createElement("ImageLabel", {
					BackgroundTransparency = 1,
					Image = "rbxassetid://4903883144",
					ImageColor3 = v.color,
					Size = iconSize,
					AnchorPoint = Vector2.new(0.5, 0.5),
					Visible = v._visible,
					ZIndex = 3,
					Position = v._position:map(function(bindingPosition) --[[ Line: 212 | Upvalues: MinimapUtils (ref), self (copy) ]]
						return MinimapUtils.worldToScale(bindingPosition.X, bindingPosition.Z, self.props.mapWorldCenterX, self.props.mapWorldCenterY, self.props.mapWorldWidth, self.props.mapWorldHeight)
					end)
				})
			end
		end
		if self.props.labels then
			for i, v in ipairs(self.props.labels) do
				local labelKey = ("label_%s"):format(v.title)
				local labelPosition = nil
				if typeof(v.position) == "Vector3" then
					local position_2 = v.position
					labelPosition = MinimapUtils.worldToScale(position_2.X, position_2.Z, self.props.mapWorldCenterX, self.props.mapWorldCenterY, self.props.mapWorldWidth, self.props.mapWorldHeight)
				else
					if typeof(v.position) == "table" and v.position.map then
						labelPosition = v.position:map(function(bindingPosition) --[[ Line: 240 | Upvalues: MinimapUtils (ref), self (copy) ]]
							return MinimapUtils.worldToScale(bindingPosition.X, bindingPosition.Z, self.props.mapWorldCenterX, self.props.mapWorldCenterY, self.props.mapWorldWidth, self.props.mapWorldHeight)
						end)
					end
				end
				local labelClassName = nil
				local labelProps = {
					BackgroundTransparency = 1,
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = labelPosition,
					ZIndex = 1
				}
				local labelChildren = {}
				if v.imageId then
					labelClassName = "ImageLabel"
					labelProps.Image = "rbxassetid://2819326547"
					labelProps.Size = self.containerSize:map(function(containerSizeValue) --[[ Line: 262 ]]
						return UDim2.new(0, containerSizeValue.X * 0.03, 0, containerSizeValue.X * 0.03)
					end)
					labelProps.ImageColor3 = v.markerColor
					local iconChildren = {
						Icon = createElement("ImageLabel", {
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 1, 0),
							ImageColor3 = Color3.fromRGB(0, 0, 0),
							Image = ("rbxassetid://%s"):format(v.imageId)
						})
					}
					iconChildren.UIScale = v.scale and createElement("UIScale", {
						Scale = v.scale
					})
					labelChildren = iconChildren
				elseif v.title then
					labelProps.Size = self.containerSize:map(function(containerSizeValue) --[[ Line: 279 ]]
						return UDim2.new(0, containerSizeValue.X * 0.1, 0, containerSizeValue.X * 0.02)
					end)
					labelProps.Font = Enum.Font.GothamBlack
					labelProps.TextColor3 = Color3.new(255/255, 255/255, 255/255)
					labelProps.Text = v.title
					labelProps.TextScaled = true
					labelProps.ZIndex = 2
					labelChildren.UIStroke = createElement("UIStroke", {
						Color = Color3.new(0/255, 0/255, 0/255),
						Thickness = 2
					})
					labelClassName = "TextLabel"
				end
				assert(labelClassName, "missing classname for label")
				children[labelKey] = createElement(labelClassName, labelProps, labelChildren)
			end
		end
		children._you = createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://4903882925",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = self.containerSize:map(function(containerSizeValue) --[[ Line: 301 ]]
				return UDim2.new(0, math.min(20, containerSizeValue.X * 0.1), 0, (math.min(20, containerSizeValue.X * 0.1)))
			end),
			ImageColor3 = self.props.color,
			ZIndex = 5,
			Position = self.props.worldPosition:map(function(bindingPosition) --[[ Line: 307 | Upvalues: MinimapUtils (ref), self (copy) ]]
				return MinimapUtils.worldToScale(bindingPosition.X, bindingPosition.Z, self.props.mapWorldCenterX, self.props.mapWorldCenterY, self.props.mapWorldWidth, self.props.mapWorldHeight)
			end),
			Rotation = self.props.worldDirection:map(function(directionValue) --[[ Line: 317 ]]
				return -math.deg(math.atan2(-directionValue.Z, directionValue.X) - 1.5707963267948966)
			end)
		})
		if self.props.waypoint then
			local waypoint = self.props.waypoint
			local waypointProps = {
				BackgroundTransparency = 1,
				Image = "rbxassetid://8971844725",
				ImageColor3 = Color3.new(255/255, 255/255, 255/255)
			}
			waypointProps.Size = self.props.isSmallScreen and UDim2.new(0, 24, 0, 24) or UDim2.new(0, 48, 0, 48)
			waypointProps.AnchorPoint = Vector2.new(0.5, 0.5)
			waypointProps.ZIndex = 3
			waypointProps.Position = MinimapUtils.worldToScale(waypoint.X, waypoint.Z, self.props.mapWorldCenterX, self.props.mapWorldCenterY, self.props.mapWorldWidth, self.props.mapWorldHeight)
			children._waypoint = createElement("ImageLabel", waypointProps)
		end
		local frameChildren = self.props[Roact.Children] or {}
		if self.props.square then
			frameChildren.AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		end
		if self.props.time ~= nil then
			local timeProps = {
				BackgroundTransparency = 1,
				Image = "rbxassetid://4903944433",
				ImageColor3 = self.props.color,
				Size = UDim2.new(0.5, 0, 1, 0)
			}
			timeProps.AnchorPoint = self.props.open and Vector2.new(0.9, 0.5) or Vector2.new(0, 0)
			timeProps.Position = UDim2.new(if self.props.open then 1 elseif self.props.isSmallScreen then 0.05 else 0, 0, if self.props.open then 1 elseif self.props.isSmallScreen then 0.05 else 0, 0)
			timeProps.ZIndex = 2
			frameChildren.Time = createElement("ImageLabel", timeProps, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 3
				}),
				SizeConstraint = createElement("UISizeConstraint", {
					MaxSize = Vector2.new(200, 50)
				}),
				Time = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Font = Enum.Font.LuckiestGuy,
					Text = self.props.time,
					TextColor3 = Color3.new(255/255, 255/255, 255/255),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.new(0.7, 0, 0.7, 0),
					Position = UDim2.new(0.5, 0, 0.58, 0),
					TextScaled = true
				})
			})
		end
		if self.props.showToggleButton then
			local toggleProps = {
				BackgroundTransparency = 1,
				Image = "rbxassetid://4933143781",
				AnchorPoint = Vector2.new(0.4, 0.4),
				ZIndex = 3,
				Position = UDim2.new(0, 0, 0, 0)
			}
			toggleProps.Size = self.props.isSmallScreen and UDim2.new(0.2, 0, 0.2, 0) or UDim2.new(0.1, 0, 0.1, 0)
			toggleProps[Roact.Event.MouseButton1Down] = function() --[[ Line: 388 | Upvalues: self (copy) ]]
				if self.props.onToggle then
					self.props.onToggle(not self.props.open)
				end
			end
			frameChildren.Toggle = createElement("ImageButton", toggleProps, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 1
				}),
				SizeConstraint = createElement("UISizeConstraint", {
					MaxSize = Vector2.new(30, 30)
				})
			})
		end
		local circlesTable = {}
		if self.props.circles then
			for v29, v30 in self.props.circles do
				if not v30.worldRadiusBinding then
					error("circle missing worldRadiusBinding")
				end
				if not v30.worldPositionBinding then
					error("circle missing worldPositionBinding")
				end
				if not v30.name then
					error("circle missing name")
				end
				local circleKey = ("circle_%s"):format(v30.name)
				if circlesTable[circleKey] then
					error(("duplicate circle name %s"):format(v30.name))
				end
				local scaledRadius = v30.worldRadiusBinding:map(function(bindingPosition) --[[ Line: 419 | Upvalues: MinimapUtils (ref), self (copy) ]]
					return MinimapUtils.relativeWorldToScale(2 * bindingPosition, 2 * bindingPosition, self.props.mapWorldWidth, self.props.mapWorldHeight)
				end)
				local scaledPosition = v30.worldPositionBinding:map(function(bindingPosition) --[[ Line: 426 | Upvalues: MinimapUtils (ref), self (copy) ]]
					return MinimapUtils.worldToScale(bindingPosition.X, bindingPosition.Z, self.props.mapWorldCenterX, self.props.mapWorldCenterY, self.props.mapWorldWidth, self.props.mapWorldHeight)
				end)
				local circleColor = v30.color or Color3.new(255/255, 255/255, 255/255)
				if v30.invert then
					circlesTable[circleKey] = createElement("Frame", {
						BackgroundTransparency = v30.transparency or 0,
						BackgroundColor3 = circleColor,
						BorderSizePixel = 0,
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = scaledPosition,
						Size = scaledRadius,
						ZIndex = 1
					}, {
						Corner = createElement("UICorner", {
							CornerRadius = UDim.new(1, 0)
						}),
						StrokeOuter = createElement("UIStroke", {
							Color = circleColor,
							Thickness = 500,
							Transparency = 0
						}),
						Fake = createElement("Frame", {
							Size = UDim2.new(1, 0, 1, 0),
							BackgroundTransparency = 1
						}, {
							Corner = createElement("UICorner", {
								CornerRadius = UDim.new(1, 0)
							}),
							Stroke = createElement("UIStroke", {
								Color = ColorUtils.brightenBy(circleColor, -0.2),
								Thickness = 2
							})
						})
					})
				else
					circlesTable[circleKey] = createElement("Frame", {
						BackgroundTransparency = v30.transparency or 0,
						BackgroundColor3 = circleColor,
						BorderSizePixel = 0,
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = scaledPosition,
						Size = scaledRadius,
						ZIndex = 1
					}, {
						Corner = createElement("UICorner", {
							CornerRadius = UDim.new(1, 0)
						}),
						Stroke = createElement("UIStroke", {
							Color = ColorUtils.brightenBy(circleColor, -0.2),
							Thickness = 2
						})
					})
				end
			end
		end
		if self.props.open then
			local containerSizeAndPosition = Roact.joinBindings({ self.containerSize, self.props.worldPosition })
			local mapButtonProps = {
				AutoButtonColor = false,
				Text = "",
				BackgroundTransparency = 0,
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundColor3 = self.props.color,
				[Roact.Event.Activated] = self.props.onClick
			}
			local mapButtonChildren = {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				})
			}
			local containerProps = {}
			containerProps.BackgroundColor3 = self.props.mapImageColor3 and self.props.mapImageColor3:map(function(colorValue) --[[ Line: 508 ]]
				return Color3.fromRGB(84 * colorValue.r, 128 * colorValue.g, 178 * colorValue.b)
			end) or Color3.new(0.1, 0.1, 0.1)
			containerProps.BackgroundTransparency = 0
			containerProps.AnchorPoint = Vector2.new(0.5, 0.5)
			containerProps.Size = UDim2.new(1, -4, 1, -4)
			containerProps.Position = UDim2.new(0.5, 0, 0.5, 0)
			containerProps.ClipsDescendants = true
			containerProps[Roact.Ref] = self.containerRef
			containerProps[Roact.Change.AbsoluteSize] = function(bindingPosition) --[[ Line: 519 | Upvalues: self (copy) ]]
				if bindingPosition then
					self.updateContainerSize(bindingPosition.AbsoluteSize)
				end
			end
			local containerChildren = {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				Points = createElement("Frame", {
					BackgroundTransparency = 1,
					AnchorPoint = Vector2.new(0, 0),
					Position = containerSizeAndPosition:map(function(bindingPosition) --[[ Line: 532 | Upvalues: MinimapUtils (ref), self (copy) ]]
						local _, offsetX, offsetY = MinimapUtils.computeOffsetXY(bindingPosition[2], bindingPosition[1], self.props.mapWorldWidth, self.props.mapWorldHeight, self.props.mapWorldCenterX, self.props.mapWorldCenterY, self.props.mapImageWidth, self.props.mapImageHeight, self.props.mapScale)
						return UDim2.new(0, -offsetX, 0, -offsetY)
					end),
					Size = containerSizeAndPosition:map(function(bindingPosition) --[[ Line: 546 | Upvalues: MinimapUtils (ref), self (copy) ]]
						local _, _2, _3, scaleValue = MinimapUtils.computeOffsetXY(bindingPosition[2], bindingPosition[1], self.props.mapWorldWidth, self.props.mapWorldHeight, self.props.mapWorldCenterX, self.props.mapWorldCenterY, self.props.mapImageWidth, self.props.mapImageHeight, self.props.mapScale)
						return UDim2.new(0, self.props.mapImageWidth * scaleValue, 0, self.props.mapImageHeight * scaleValue)
					end),
					ZIndex = 2
				}, Dictionary.merge(children, circlesTable)),
				Render = makeMinimap(self, containerSizeAndPosition, self.props.mapImageId, 0, 1, 0)
			}
			containerChildren.RenderTrack = self.state.trackVisible and makeMinimap(self, containerSizeAndPosition, 106966740654302, 1, 2, 1) or nil
			mapButtonChildren.Container = createElement("Frame", containerProps, Dictionary.merge(containerChildren, self.props.containerChildren))
			frameChildren.Map = createElement("TextButton", mapButtonProps, mapButtonChildren)
		end
		return createElement("Frame", {
			BackgroundTransparency = 1,
			Size = self.props.size,
			Position = self.props.position,
			AnchorPoint = self.props.anchorPoint,
			LayoutOrder = self.props.displayOrder
		}, frameChildren)
	end
end
function Minimap.willUnmount(self) --[[ Line: 579 ]]
	self._maid:DoCleaning()
end
return Minimap
