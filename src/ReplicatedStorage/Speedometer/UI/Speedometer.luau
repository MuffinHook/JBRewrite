local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local HyperChromeConsts = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local Roact = require(ReplicatedStorage.Roact)
local Maid = require(ReplicatedStorage.Std.Maid)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local createElement = Roact.createElement
local function comma(numberString)
	local numberPart, decimalPart, suffix = string.match(numberString, "^([^%d]*%d)(%d*)(.-)$")
	return numberPart .. decimalPart:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. suffix
end
local component = Roact.PureComponent:extend("Speedometer")
component.defaultProps = {
	metric = "MPH",
	hasLicensePlate = true,
	licensePlate = "JAILBRK!",
	locked = false,
	lockEnabled = true,
	ejectEnabled = true,
	missilesEnabled = false,
	missileCount = 0,
	missileMax = 10,
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	enabled = true
}
function component.init(self)
	self:setState({
		ejectOpen = false
	})
	self.color_strokeRef = Roact.createRef()
	self.color_frameRef = Roact.createRef()
	self.color_frame2Ref = Roact.createRef()
end
function component.didMount(self)
	self.maid = Maid.new()
	local vehicleModel = VehicleUtils.GetLocalVehicleModel()
	assert(vehicleModel, "No local vehicle model")
	self.maid:GiveTask(VehicleUtils.getTireHealthChangedSignal(vehicleModel):Connect(function()
		self:setState({
			_c = math.random()
		})
	end))
	self.maid:GiveTask(VehicleUtils.getTireMaxHealthChangedSignal(vehicleModel):Connect(function()
		self:setState({
			_c = math.random()
		})
	end))
	local function setColor(colorValue)
		local strokeElement = self.color_strokeRef:getValue()
		local frameElement = self.color_frameRef:getValue()
		local frame2Element = self.color_frame2Ref:getValue()
		if strokeElement then
			strokeElement.Color = colorValue
		end
		if frameElement then
			frameElement.BackgroundColor3 = colorValue
		end
		if frame2Element then
			frame2Element.BackgroundColor3 = colorValue
		end
	end
	local function hyperChromeUpdated()
		if vehicleModel:GetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME) == HyperChromeConsts.COLOR_SHIFT_NAME then
			self.maid.hyperShiftParticleRainbowHeartbeat = RunService.Heartbeat:Connect(function()
				local rainbowColor = Color3.fromHSV(os.clock() % HyperChromeConsts.RAINBOW_ANIMATION_CYCLE_TIME / HyperChromeConsts.RAINBOW_ANIMATION_CYCLE_TIME, 1, 1)
				local strokeElement = self.color_strokeRef:getValue()
				local frameElement = self.color_frameRef:getValue()
				local frame2Element = self.color_frame2Ref:getValue()
				if strokeElement then
					strokeElement.Color = rainbowColor
				end
				if frameElement then
					frameElement.BackgroundColor3 = rainbowColor
				end
				if frame2Element then
					frame2Element.BackgroundColor3 = rainbowColor
				end
			end)
		else
			self.maid.hyperShiftParticleRainbowHeartbeat = nil
			local baseColor = self.props.color
			local strokeElement = self.color_strokeRef:getValue()
			local frameElement = self.color_frameRef:getValue()
			local frame2Element = self.color_frame2Ref:getValue()
			if strokeElement then
				strokeElement.Color = baseColor
			end
			if frameElement then
				frameElement.BackgroundColor3 = baseColor
			end
			if frame2Element then
				frame2Element.BackgroundColor3 = baseColor
			end
		end
	end
	task.spawn(hyperChromeUpdated)
	self.maid:GiveTask(vehicleModel:GetAttributeChangedSignal(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME):Connect(hyperChromeUpdated))
end
function component.render(self)
	if self.props.enabled then
		local smallUI = self.props.smallUI
		local vehicleModel = VehicleUtils.GetLocalVehicleModel()
		if vehicleModel then
			local tireHealth = VehicleUtils.getTireHealth(vehicleModel)
			local tireMaxHealth = VehicleUtils.getTireMaxHealth(vehicleModel)
			if RunService:IsRunning() then
				assert(tireHealth and tireMaxHealth, "No health or maxHealth")
			else
				tireHealth = 75
				tireMaxHealth = 150
			end
			local healthRatio = tireHealth / tireMaxHealth
			local passengerElements = {}
			if self.state.ejectOpen and self.props.passengers then
				for i, v in ipairs(self.props.passengers) do
					local passengerName = v.Name
					passengerElements[passengerName] = createElement("TextButton", {
						BackgroundTransparency = 0,
						BorderSizePixel = 0,
						BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
						Size = UDim2.new(1, 0, 1, 0),
						AnchorPoint = Vector2.new(0, 0),
						Text = "",
						LayoutOrder = 10 - i,
						[Roact.Event.MouseButton1Down] = function()
							self:setState({
								ejectOpen = false
							})
							if self.props.onClickEjectName then
								self.props.onClickEjectName(passengerName)
							end
						end
					}, {
						UICorner = createElement("UICorner", {
							CornerRadius = UDim.new(0.25, 0)
						}),
						Title = createElement("TextLabel", {
							BackgroundTransparency = 1,
							Text = passengerName,
							Font = Enum.Font.LuckiestGuy,
							TextColor3 = Color3.new(51/255, 51/255, 51/255),
							TextScaled = true,
							Size = UDim2.new(1, 0, 0.9, 0),
							AnchorPoint = Vector2.new(0.5, 0.5),
							Position = UDim2.new(0.5, 0, 0.6, 0)
						})
					})
				end
			end
			local accelerationBarElements = {}
			for i = 1, 9 do
				accelerationBarElements[i] = createElement("ImageLabel", {
					BackgroundTransparency = 1,
					ImageTransparency = 0,
					Image = "rbxassetid://8208058512",
					Size = UDim2.new(1, 0, 1, 0),
					ImageColor3 = self.props.accelRatio:map(function(accelRatio)
						local whiteColor = Color3.new(255/255, 255/255, 255/255)
						local barLowerThreshold = i / 10
						local barUpperThreshold = (i + 1) / 10
						if accelRatio < barLowerThreshold then
							return Color3.new(0/255, 0/255, 0/255)
						else
							if accelRatio < barUpperThreshold then
								whiteColor = Color3.new(0/255, 0/255, 0/255):lerp(whiteColor, ((accelRatio - barLowerThreshold) / (barUpperThreshold - barLowerThreshold)) ^ 2)
							end
							return whiteColor
						end
					end),
					LayoutOrder = i
				}, {
					AspectRatio = createElement("UIAspectRatioConstraint", {
						AspectRatio = 1.34375
					})
				})
			end
			local mainFrameProps = {
				BackgroundTransparency = 0.6666666666666666,
				BackgroundColor3 = Color3.new(51/255, 51/255, 51/255),
				Size = self.props.size,
				Position = self.props.position,
				AnchorPoint = self.props.anchorPoint
			}
			local speedometerChildren = {}
			local aspectRatioConstraintProps = {}
			aspectRatioConstraintProps.AspectRatio = if smallUI then 5 else 3
			speedometerChildren.AspectRatio = createElement("UIAspectRatioConstraint", aspectRatioConstraintProps)
			speedometerChildren.UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0.25, 0)
			})
			speedometerChildren.UIStroke = createElement("UIStroke", {
				Color = self.props.color,
				Thickness = 3,
				[Roact.Ref] = self.color_strokeRef
			})
			local topSectionProps = {
				BackgroundTransparency = 1
			}
			topSectionProps.Size = UDim2.new(1, 0, if smallUI then 1 else 0.5714285714285714, 0)
			topSectionProps.Position = UDim2.new(0, 0, 0, 0)
			topSectionProps.ZIndex = 2
			local topSectionChildren = {}
			local speedLabelProps = {
				BackgroundTransparency = 1
			}
			speedLabelProps.Size = UDim2.new(0.4, 0, if smallUI then 0.75 else 1, 0)
			speedLabelProps.AnchorPoint = Vector2.new(0.5, 0)
			speedLabelProps.Position = UDim2.new(0.5, 0, 0, 0)
			speedLabelProps.TextColor3 = Color3.new(255/255, 255/255, 255/255)
			speedLabelProps.TextScaled = true
			speedLabelProps.Text = self.props.speed:map(function(speed)
				return ("%03d"):format(speed)
			end)
			speedLabelProps.Font = Enum.Font.Bangers
			topSectionChildren.Speed = createElement("TextLabel", speedLabelProps)
			topSectionChildren.Metric = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.1, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.new(0.7124999999999999, 0, 0.1, 0),
				TextColor3 = Color3.new(255/255, 255/255, 255/255),
				TextScaled = true,
				Text = self.props.metric,
				Font = Enum.Font.Bangers
			})
			topSectionChildren.Amount = smallUI and createElement("TextLabel", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
				Size = UDim2.new(0.2, 0, 0.2, 0),
				AnchorPoint = Vector2.new(1, 1),
				Position = UDim2.new(1, 0, 0.72, 0),
				TextColor3 = Color3.new(255/255, 255/255, 255/255),
				TextScaled = true,
				Text = self.props.distance:map(function(distance)
					local numberPart, decimalPart, suffix = string.match(math.floor(distance + 0.5), "^([^%d]*%d)(%d*)(.-)$")
					return ("%s mi"):format(numberPart .. decimalPart:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. suffix)
				end),
				Font = Enum.Font.LuckiestGuy,
				TextYAlignment = Enum.TextYAlignment.Bottom
			})
			topSectionChildren.Plate = not smallUI and createElement("TextButton", {
				BackgroundTransparency = 0,
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
				Size = UDim2.new(0.3, 0, 1, 0),
				AnchorPoint = Vector2.new(1, 1),
				Position = UDim2.new(1, 0, 1, -6),
				Text = "",
				Visible = self.props.hasLicensePlate,
				[Roact.Event.MouseButton1Down] = self.props.onClickPlate
			}, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 4
				}),
				Title = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(0.8, 0, 1, 0),
					AnchorPoint = Vector2.new(0.5, 0),
					Position = UDim2.new(0.5, 0, 0.2, 0),
					TextColor3 = Color3.new(255/255, 255/255, 255/255),
					TextScaled = true,
					Text = self.props.licensePlate,
					Font = Enum.Font.LuckiestGuy
				})
			})
			local lockButtonProps = {
				BackgroundTransparency = 1,
				ImageColor3 = Color3.new(255/255, 255/255, 255/255),
				Image = "rbxassetid://8208059198",
				Size = UDim2.new(0.5, 0, 0.5, 0),
				Position = UDim2.new(0.04, 0, 0.14, 0),
				Visible = self.props.lockEnabled,
				[Roact.Event.MouseButton1Down] = self.props.onClickLock
			}
			local lockButtonChildren = {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 1
				})
			}
			local lockIconProps = {
				BackgroundTransparency = 1,
				ImageColor3 = Color3.new(255/255, 255/255, 255/255)
			}
			lockIconProps.Image = if self.props.locked then "rbxassetid://5928936980" else "rbxassetid://5928936296"
			lockIconProps.Size = UDim2.new(0.6, 0, 0.6, 0)
			lockIconProps.AnchorPoint = Vector2.new(0.5, 0.5)
			lockIconProps.Position = UDim2.new(0.5, 0, 0.5, 0)
			lockButtonChildren.Icon = createElement("ImageLabel", lockIconProps)
			topSectionChildren.Lock = createElement("ImageButton", lockButtonProps, lockButtonChildren)
			topSectionChildren.Eject = createElement("ImageButton", {
				BackgroundTransparency = 1,
				ImageColor3 = Color3.new(255/255, 255/255, 255/255),
				Image = "rbxassetid://8208059198",
				Size = UDim2.new(0.5, 0, 0.5, 0),
				Position = UDim2.new(0.16, 0, 0.14, 0),
				Visible = self.props.ejectEnabled,
				[Roact.Event.MouseButton1Down] = function()
					local isEjectOpen = not self.state.ejectOpen
					self:setState({
						ejectOpen = isEjectOpen
					})
					if self.props.onClickEject then
						self.props.onClickEject(isEjectOpen)
					end
				end
			}, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 1
				}),
				Icon = createElement("ImageLabel", {
					BackgroundTransparency = 1,
					Image = "rbxassetid://8208059624",
					ImageColor3 = Color3.new(255/255, 255/255, 255/255),
					Size = UDim2.new(0.6, 0, 0.6, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.new(0.5, 0, 0.5, 0)
				}),
				List = createElement("Frame", {
					BackgroundTransparency = 1,
					BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
					Size = UDim2.new(4, 0, 0.8, 0),
					Position = UDim2.new(0.5, 0, -0.8, 0),
					AnchorPoint = Vector2.new(0.5, 1),
					Visible = self.props.ejectOpen
				}, Dictionary.merge({
					ListLayout = createElement("UIListLayout", {
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						VerticalAlignment = Enum.VerticalAlignment.Bottom,
						SortOrder = Enum.SortOrder.LayoutOrder,
						FillDirection = Enum.FillDirection.Vertical,
						Padding = UDim.new(0.2, 0)
					})
				}, passengerElements))
			})
			topSectionChildren.Missiles = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.25, 0, 0.3, 0),
				AnchorPoint = Vector2.new(0, 1),
				Position = UDim2.new(0.04, 0, 0.96, 0),
				TextColor3 = Color3.new(255/255, 255/255, 255/255),
				TextScaled = true,
				Text = ("%d/%d MISSILES"):format(self.props.missileCount, self.props.missileMax),
				Font = Enum.Font.LuckiestGuy,
				Visible = self.props.missilesEnabled
			})
			topSectionChildren.MissileBuy = createElement("TextButton", {
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
				Size = UDim2.new(1, 0, 0.18, 0),
				AnchorPoint = Vector2.new(0.5, 1),
				Position = UDim2.new(0.15, 0, 1.07, 0),
				ZIndex = 4,
				Text = "",
				Visible = self.props.missilesEnabled,
				[Roact.Event.MouseButton1Down] = self.props.onClickMissileBuy
			}, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 3
				}),
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0.25, 0)
				}),
				Title = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.new(0.5, 0, 0.6, 0),
					TextColor3 = Color3.new(51/255, 51/255, 51/255),
					TextScaled = true,
					Text = "Buy",
					Font = Enum.Font.LuckiestGuy,
					ZIndex = 5
				})
			})
			speedometerChildren.Top = createElement("Frame", topSectionProps, topSectionChildren)
			local bottomSectionProps = {
				BackgroundTransparency = 1
			}
			bottomSectionProps.Size = UDim2.new(1, 0, if smallUI then 1 else 0.5714285714285714, 0)
			bottomSectionProps.Position = UDim2.new(0, 0, if smallUI then 0.7272727272727273 else 0.5714285714285714, 0)
			local bottomSectionChildren = {
				Line0 = createElement("Frame", {
					BorderSizePixel = 0,
					BackgroundColor3 = self.props.color,
					Size = UDim2.new(1, 0, 0, 2),
					[Roact.Ref] = self.color_frameRef
				})
			}
			bottomSectionChildren.Line1 = not smallUI and createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundColor3 = self.props.color,
				Size = UDim2.new(1, 0, 0, 2),
				Position = UDim2.new(0, 0, 0, -6),
				[Roact.Ref] = self.color_frame2Ref
			})
			local healthBarProps = {
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.fromHex("cb342a"),
				Size = UDim2.new(0.85, 0, 0.1, 0)
			}
			healthBarProps.Position = UDim2.new(0.5, 0, if smallUI then 0.15 else 0.47, 0)
			healthBarProps.AnchorPoint = Vector2.new(0.5, 0.5)
			healthBarProps.Text = ""
			healthBarProps.TextScaled = true
			healthBarProps.TextColor3 = Color3.new(255/255, 255/255, 255/255)
			healthBarProps.TextXAlignment = Enum.TextXAlignment.Right
			bottomSectionChildren.HealthBar = createElement("TextLabel", healthBarProps, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(1, 0)
				}),
				Inner = createElement("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.new(healthRatio, 0, 1, 0),
					ClipsDescendants = true
				}, {
					Value = createElement("Frame", {
						BackgroundTransparency = 0,
						BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
						Size = UDim2.new(math.min(1 / healthRatio, 2), 0, 1, 0)
					}, {
						UICorner = createElement("UICorner", {
							CornerRadius = UDim.new(1, 0)
						}),
						UIGradient = createElement("UIGradient", {
							Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(101, 216, 99)), ColorSequenceKeypoint.new(1, Color3.fromRGB(89, 201, 113)) }),
							Rotation = 90,
							Offset = Vector2.new(0, 0)
						})
					})
				})
			})
			bottomSectionChildren.NitroBar = not smallUI and createElement("TextButton", {
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
				Size = UDim2.new(0.85, 0, 0.1, 0),
				Position = UDim2.new(0.5, 0, 0.62, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = "",
				[Roact.Event.MouseButton1Down] = self.props.onClickBar
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(1, 0)
				}),
				Inner = createElement("Frame", {
					BackgroundTransparency = 1,
					Size = self.props.barRatio:map(function(barRatio)
						return UDim2.new(barRatio, 0, 1, 0)
					end),
					ClipsDescendants = true
				}, {
					Value = createElement("Frame", {
						BackgroundTransparency = 0,
						BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
						Size = self.props.barRatio:map(function(barRatio)
							return UDim2.new(math.min(1 / barRatio, 2), 0, 1, 0)
						end)
					}, {
						UICorner = createElement("UICorner", {
							CornerRadius = UDim.new(1, 0)
						}),
						UIGradient = createElement("UIGradient", {
							Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(204, 105, 207)), ColorSequenceKeypoint.new(1, Color3.fromRGB(164, 65, 167)) }),
							Rotation = 90,
							Offset = Vector2.new(0, 0)
						})
					})
				})
			})
			bottomSectionChildren.Meter = not smallUI and createElement("Frame", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0.31, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 0, 0.23, 0),
				ClipsDescendants = true
			}, Dictionary.merge({
				ListLayout = createElement("UIListLayout", {
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0, 0)
				}),
				Odometer = createElement("ImageLabel", {
					BackgroundTransparency = 1,
					Image = "rbxassetid://8247002133",
					Size = UDim2.new(1, 0, 1, 0),
					LayoutOrder = 100
				}, {
					AspectRatio = createElement("UIAspectRatioConstraint", {
						AspectRatio = 5.875
					}),
					Amount = createElement("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(0.8, 0, 0.8, 0),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim2.new(0.5, 0, 0.6, 0),
						TextColor3 = Color3.new(255/255, 255/255, 255/255),
						TextScaled = true,
						Text = self.props.distance:map(function(distance)
							local numberPart, decimalPart, suffix = string.match(math.floor(distance + 0.5), "^([^%d]*%d)(%d*)(.-)$")
							return ("%s mi"):format(numberPart .. decimalPart:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. suffix)
						end),
						Font = Enum.Font.LuckiestGuy
					})
				})
			}, accelerationBarElements))
			speedometerChildren.Bottom = createElement("Frame", bottomSectionProps, bottomSectionChildren)
			return createElement("Frame", mainFrameProps, speedometerChildren)
		end
	end
end
function component.willUnmount(self)
	self.maid:Destroy()
end
return component
