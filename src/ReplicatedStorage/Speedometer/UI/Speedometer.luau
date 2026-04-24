-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local HyperChromeConsts = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local Roact = require(ReplicatedStorage.Roact)
local Maid = require(ReplicatedStorage.Std.Maid)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local createElement = Roact.createElement
local function comma(p1)
	local v1, v2, v3 = string.match(p1, "^([^%d]*%d)(%d*)(.-)$")
	return v1 .. v2:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v3
end
local v1 = Roact.PureComponent:extend("Speedometer")
v1.defaultProps = {
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
function v1.init(p1)
	p1:setState({
		ejectOpen = false
	})
	p1.color_strokeRef = Roact.createRef()
	p1.color_frameRef = Roact.createRef()
	p1.color_frame2Ref = Roact.createRef()
end
function v1.didMount(p1)
	p1.maid = Maid.new()
	local v1 = VehicleUtils.GetLocalVehicleModel()
	assert(v1, "No local vehicle model")
	p1.maid:GiveTask(VehicleUtils.getTireHealthChangedSignal(v1):Connect(function()
		p1:setState({
			_c = math.random()
		})
	end))
	p1.maid:GiveTask(VehicleUtils.getTireMaxHealthChangedSignal(v1):Connect(function()
		p1:setState({
			_c = math.random()
		})
	end))
	local function setColor(p12)
		local v1 = p1.color_strokeRef:getValue()
		local v2 = p1.color_frameRef:getValue()
		local v3 = p1.color_frame2Ref:getValue()
		if v1 then
			v1.Color = p12
		end
		if v2 then
			v2.BackgroundColor3 = p12
		end
		if v3 then
			v3.BackgroundColor3 = p12
		end
	end
	local function hyperChromeUpdated()
		if v1:GetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME) == HyperChromeConsts.COLOR_SHIFT_NAME then
			p1.maid.hyperShiftParticleRainbowHeartbeat = RunService.Heartbeat:Connect(function()
				local v2 = Color3.fromHSV(os.clock() % HyperChromeConsts.RAINBOW_ANIMATION_CYCLE_TIME / HyperChromeConsts.RAINBOW_ANIMATION_CYCLE_TIME, 1, 1)
				local v3 = p1.color_strokeRef:getValue()
				local v4 = p1.color_frameRef:getValue()
				local v5 = p1.color_frame2Ref:getValue()
				if v3 then
					v3.Color = v2
				end
				if v4 then
					v4.BackgroundColor3 = v2
				end
				if v5 then
					v5.BackgroundColor3 = v2
				end
			end)
		else
			p1.maid.hyperShiftParticleRainbowHeartbeat = nil
			local color = p1.props.color
			local v12 = p1.color_strokeRef:getValue()
			local v2 = p1.color_frameRef:getValue()
			local v3 = p1.color_frame2Ref:getValue()
			if v12 then
				v12.Color = color
			end
			if v2 then
				v2.BackgroundColor3 = color
			end
			if v3 then
				v3.BackgroundColor3 = color
			end
		end
	end
	task.spawn(hyperChromeUpdated)
	p1.maid:GiveTask(v1:GetAttributeChangedSignal(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME):Connect(hyperChromeUpdated))
end
function v1.render(p1)
	if p1.props.enabled then
		local smallUI = p1.props.smallUI
		local v1 = VehicleUtils.GetLocalVehicleModel()
		if v1 then
			local v2 = VehicleUtils.getTireHealth(v1)
			local v3 = VehicleUtils.getTireMaxHealth(v1)
			if RunService:IsRunning() then
				assert(v2 and v3, "No health or maxHealth")
			else
				v2 = 75
				v3 = 150
			end
			local v4 = v2 / v3
			local t = {}
			if p1.state.ejectOpen and p1.props.passengers then
				for i, v in ipairs(p1.props.passengers) do
					local v5 = v.Name
					t[v5] = createElement("TextButton", {
						BackgroundTransparency = 0,
						BorderSizePixel = 0,
						BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
						Size = UDim2.new(1, 0, 1, 0),
						AnchorPoint = Vector2.new(0, 0),
						Text = "",
						LayoutOrder = 10 - i,
						[Roact.Event.MouseButton1Down] = function()
							p1:setState({
								ejectOpen = false
							})
							if p1.props.onClickEjectName then
								p1.props.onClickEjectName(v5)
							end
						end
					}, {
						UICorner = createElement("UICorner", {
							CornerRadius = UDim.new(0.25, 0)
						}),
						Title = createElement("TextLabel", {
							BackgroundTransparency = 1,
							Text = v5,
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
			local t2 = {}
			for i = 1, 9 do
				t2[i] = createElement("ImageLabel", {
					BackgroundTransparency = 1,
					ImageTransparency = 0,
					Image = "rbxassetid://8208058512",
					Size = UDim2.new(1, 0, 1, 0),
					ImageColor3 = p1.props.accelRatio:map(function(p1)
						local v1 = Color3.new(255/255, 255/255, 255/255)
						local v2 = i / 10
						local v3 = (i + 1) / 10
						if p1 < v2 then
							return Color3.new(0/255, 0/255, 0/255)
						else
							if p1 < v3 then
								v1 = Color3.new(0/255, 0/255, 0/255):lerp(v1, ((p1 - v2) / (v3 - v2)) ^ 2)
							end
							return v1
						end
					end),
					LayoutOrder = i
				}, {
					AspectRatio = createElement("UIAspectRatioConstraint", {
						AspectRatio = 1.34375
					})
				})
			end
			local t3 = {
				BackgroundTransparency = 0.6666666666666666,
				BackgroundColor3 = Color3.new(51/255, 51/255, 51/255),
				Size = p1.props.size,
				Position = p1.props.position,
				AnchorPoint = p1.props.anchorPoint
			}
			local t4 = {}
			local t5 = {}
			t5.AspectRatio = if smallUI then 5 else 3
			t4.AspectRatio = createElement("UIAspectRatioConstraint", t5)
			t4.UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0.25, 0)
			})
			t4.UIStroke = createElement("UIStroke", {
				Color = p1.props.color,
				Thickness = 3,
				[Roact.Ref] = p1.color_strokeRef
			})
			local t6 = {
				BackgroundTransparency = 1
			}
			t6.Size = UDim2.new(1, 0, if smallUI then 1 else 0.5714285714285714, 0)
			t6.Position = UDim2.new(0, 0, 0, 0)
			t6.ZIndex = 2
			local t7 = {}
			local t8 = {
				BackgroundTransparency = 1
			}
			t8.Size = UDim2.new(0.4, 0, if smallUI then 0.75 else 1, 0)
			t8.AnchorPoint = Vector2.new(0.5, 0)
			t8.Position = UDim2.new(0.5, 0, 0, 0)
			t8.TextColor3 = Color3.new(255/255, 255/255, 255/255)
			t8.TextScaled = true
			t8.Text = p1.props.speed:map(function(p1)
				return ("%03d"):format(p1)
			end)
			t8.Font = Enum.Font.Bangers
			t7.Speed = createElement("TextLabel", t8)
			t7.Metric = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.1, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.new(0.7124999999999999, 0, 0.1, 0),
				TextColor3 = Color3.new(255/255, 255/255, 255/255),
				TextScaled = true,
				Text = p1.props.metric,
				Font = Enum.Font.Bangers
			})
			t7.Amount = smallUI and createElement("TextLabel", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
				Size = UDim2.new(0.2, 0, 0.2, 0),
				AnchorPoint = Vector2.new(1, 1),
				Position = UDim2.new(1, 0, 0.72, 0),
				TextColor3 = Color3.new(255/255, 255/255, 255/255),
				TextScaled = true,
				Text = p1.props.distance:map(function(p1)
					local v2, v3, v4 = string.match(math.floor(p1 + 0.5), "^([^%d]*%d)(%d*)(.-)$")
					return ("%s mi"):format(v2 .. v3:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v4)
				end),
				Font = Enum.Font.LuckiestGuy,
				TextYAlignment = Enum.TextYAlignment.Bottom
			})
			t7.Plate = not smallUI and createElement("TextButton", {
				BackgroundTransparency = 0,
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
				Size = UDim2.new(0.3, 0, 1, 0),
				AnchorPoint = Vector2.new(1, 1),
				Position = UDim2.new(1, 0, 1, -6),
				Text = "",
				Visible = p1.props.hasLicensePlate,
				[Roact.Event.MouseButton1Down] = p1.props.onClickPlate
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
					Text = p1.props.licensePlate,
					Font = Enum.Font.LuckiestGuy
				})
			})
			local t9 = {
				BackgroundTransparency = 1,
				ImageColor3 = Color3.new(255/255, 255/255, 255/255),
				Image = "rbxassetid://8208059198",
				Size = UDim2.new(0.5, 0, 0.5, 0),
				Position = UDim2.new(0.04, 0, 0.14, 0),
				Visible = p1.props.lockEnabled,
				[Roact.Event.MouseButton1Down] = p1.props.onClickLock
			}
			local t10 = {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 1
				})
			}
			local t11 = {
				BackgroundTransparency = 1,
				ImageColor3 = Color3.new(255/255, 255/255, 255/255)
			}
			t11.Image = if p1.props.locked then "rbxassetid://5928936980" else "rbxassetid://5928936296"
			t11.Size = UDim2.new(0.6, 0, 0.6, 0)
			t11.AnchorPoint = Vector2.new(0.5, 0.5)
			t11.Position = UDim2.new(0.5, 0, 0.5, 0)
			t10.Icon = createElement("ImageLabel", t11)
			t7.Lock = createElement("ImageButton", t9, t10)
			t7.Eject = createElement("ImageButton", {
				BackgroundTransparency = 1,
				ImageColor3 = Color3.new(255/255, 255/255, 255/255),
				Image = "rbxassetid://8208059198",
				Size = UDim2.new(0.5, 0, 0.5, 0),
				Position = UDim2.new(0.16, 0, 0.14, 0),
				Visible = p1.props.ejectEnabled,
				[Roact.Event.MouseButton1Down] = function()
					local v1 = not p1.state.ejectOpen
					p1:setState({
						ejectOpen = v1
					})
					if p1.props.onClickEject then
						p1.props.onClickEject(v1)
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
					Visible = p1.props.ejectOpen
				}, Dictionary.merge({
					ListLayout = createElement("UIListLayout", {
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						VerticalAlignment = Enum.VerticalAlignment.Bottom,
						SortOrder = Enum.SortOrder.LayoutOrder,
						FillDirection = Enum.FillDirection.Vertical,
						Padding = UDim.new(0.2, 0)
					})
				}, t))
			})
			t7.Missiles = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.25, 0, 0.3, 0),
				AnchorPoint = Vector2.new(0, 1),
				Position = UDim2.new(0.04, 0, 0.96, 0),
				TextColor3 = Color3.new(255/255, 255/255, 255/255),
				TextScaled = true,
				Text = ("%d/%d MISSILES"):format(p1.props.missileCount, p1.props.missileMax),
				Font = Enum.Font.LuckiestGuy,
				Visible = p1.props.missilesEnabled
			})
			t7.MissileBuy = createElement("TextButton", {
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
				Size = UDim2.new(1, 0, 0.18, 0),
				AnchorPoint = Vector2.new(0.5, 1),
				Position = UDim2.new(0.15, 0, 1.07, 0),
				ZIndex = 4,
				Text = "",
				Visible = p1.props.missilesEnabled,
				[Roact.Event.MouseButton1Down] = p1.props.onClickMissileBuy
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
			t4.Top = createElement("Frame", t6, t7)
			local t12 = {
				BackgroundTransparency = 1
			}
			t12.Size = UDim2.new(1, 0, if smallUI then 1 else 0.5714285714285714, 0)
			t12.Position = UDim2.new(0, 0, if smallUI then 0.7272727272727273 else 0.5714285714285714, 0)
			local t13 = {
				Line0 = createElement("Frame", {
					BorderSizePixel = 0,
					BackgroundColor3 = p1.props.color,
					Size = UDim2.new(1, 0, 0, 2),
					[Roact.Ref] = p1.color_frameRef
				})
			}
			t13.Line1 = not smallUI and createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundColor3 = p1.props.color,
				Size = UDim2.new(1, 0, 0, 2),
				Position = UDim2.new(0, 0, 0, -6),
				[Roact.Ref] = p1.color_frame2Ref
			})
			local t14 = {
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.fromHex("cb342a"),
				Size = UDim2.new(0.85, 0, 0.1, 0)
			}
			t14.Position = UDim2.new(0.5, 0, if smallUI then 0.15 else 0.47, 0)
			t14.AnchorPoint = Vector2.new(0.5, 0.5)
			t14.Text = ""
			t14.TextScaled = true
			t14.TextColor3 = Color3.new(255/255, 255/255, 255/255)
			t14.TextXAlignment = Enum.TextXAlignment.Right
			t13.HealthBar = createElement("TextLabel", t14, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(1, 0)
				}),
				Inner = createElement("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.new(v4, 0, 1, 0),
					ClipsDescendants = true
				}, {
					Value = createElement("Frame", {
						BackgroundTransparency = 0,
						BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
						Size = UDim2.new(math.min(1 / v4, 2), 0, 1, 0)
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
			t13.NitroBar = not smallUI and createElement("TextButton", {
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
				Size = UDim2.new(0.85, 0, 0.1, 0),
				Position = UDim2.new(0.5, 0, 0.62, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = "",
				[Roact.Event.MouseButton1Down] = p1.props.onClickBar
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(1, 0)
				}),
				Inner = createElement("Frame", {
					BackgroundTransparency = 1,
					Size = p1.props.barRatio:map(function(p1)
						return UDim2.new(p1, 0, 1, 0)
					end),
					ClipsDescendants = true
				}, {
					Value = createElement("Frame", {
						BackgroundTransparency = 0,
						BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
						Size = p1.props.barRatio:map(function(p1)
							return UDim2.new(math.min(1 / p1, 2), 0, 1, 0)
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
			t13.Meter = not smallUI and createElement("Frame", {
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
						Text = p1.props.distance:map(function(p1)
							local v2, v3, v4 = string.match(math.floor(p1 + 0.5), "^([^%d]*%d)(%d*)(.-)$")
							return ("%s mi"):format(v2 .. v3:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v4)
						end),
						Font = Enum.Font.LuckiestGuy
					})
				})
			}, t2))
			t4.Bottom = createElement("Frame", t12, t13)
			return createElement("Frame", t3, t4)
		end
	end
end
function v1.willUnmount(p1)
	p1.maid:Destroy()
end
return v1
