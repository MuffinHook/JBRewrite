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
local v1 = Roact.PureComponent:extend("Minimap")
v1.defaultProps = {
	visible = true,
	open = true,
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	mapScale = 1,
	showToggleButton = true
}
function v1.init(p1) --[[ Line: 23 | Upvalues: Maid (copy), Roact (copy) ]]
	p1._maid = Maid.new()
	if p1.props.containerSize then
		local updateContainerSize = p1.props.updateContainerSize
		p1.containerSize = p1.props.containerSize
		p1.updateContainerSize = updateContainerSize
	else
		local v1, v2 = Roact.createBinding(Vector2.new(512, 512))
		p1.containerSize = v1
		p1.updateContainerSize = v2
	end
	if p1.props.containerRef then
		p1.containerRef = p1.props.containerRef
	else
		p1.containerRef = Roact.createRef()
	end
	p1:setState({
		trackVisible = false
	})
end
local function makeMinimap(p1, p2, p3, p4, p5, p6) --[[ Line: 40 | Upvalues: createElement (copy), MinimapUtils (copy) ]]
	return createElement("ImageLabel", {
		Image = ("rbxassetid://%d"):format(p3),
		ImageColor3 = p1.props.mapImageColor3,
		BackgroundTransparency = p6,
		Position = p2:map(function(p12) --[[ Line: 46 | Upvalues: MinimapUtils (ref), p1 (copy), p5 (copy) ]]
			local v1, v2, v3 = MinimapUtils.computeOffsetXY(p12[2], p12[1], p1.props.mapWorldWidth, p1.props.mapWorldHeight, p1.props.mapWorldCenterX, p1.props.mapWorldCenterY, p1.props.mapImageWidth * p5, p1.props.mapImageHeight * p5, p1.props.mapScale)
			if v1 then
				return UDim2.new(0, -v2, 0, -v3)
			else
				return UDim2.new(0, 0, 0, 0)
			end
		end),
		Size = p2:map(function(p12) --[[ Line: 63 | Upvalues: MinimapUtils (ref), p1 (copy), p5 (copy) ]]
			local v1, _, _2, v2 = MinimapUtils.computeOffsetXY(p12[2], p12[1], p1.props.mapWorldWidth, p1.props.mapWorldHeight, p1.props.mapWorldCenterX, p1.props.mapWorldCenterY, p1.props.mapImageWidth * p5, p1.props.mapImageHeight * p5, p1.props.mapScale)
			if v1 then
				return UDim2.new(0, p1.props.mapImageWidth * p5 * v2, 0, p1.props.mapImageHeight * p5 * v2)
			else
				return UDim2.new(1, 0, 1, 0)
			end
		end),
		ImageRectSize = p2:map(function(p12) --[[ Line: 84 | Upvalues: MinimapUtils (ref), p1 (copy), p5 (copy) ]]
			local v1, _, _2, v2 = MinimapUtils.computeOffsetXY(p12[2], p12[1], p1.props.mapWorldWidth, p1.props.mapWorldHeight, p1.props.mapWorldCenterX, p1.props.mapWorldCenterY, p1.props.mapImageWidth * p5, p1.props.mapImageHeight * p5, p1.props.mapScale)
			if v1 then
				return nil
			end
			local v3 = p12[1]
			if v3 then
				return v3 / v2
			end
		end),
		ImageRectOffset = p2:map(function(p12) --[[ Line: 105 | Upvalues: MinimapUtils (ref), p1 (copy), p5 (copy) ]]
			local v1, v2, v3, v4 = MinimapUtils.computeOffsetXY(p12[2], p12[1], p1.props.mapWorldWidth, p1.props.mapWorldHeight, p1.props.mapWorldCenterX, p1.props.mapWorldCenterY, p1.props.mapImageWidth * p5, p1.props.mapImageHeight * p5, p1.props.mapScale)
			if v1 then
				return nil
			else
				return Vector2.new(v2, v3) / v4
			end
		end),
		ZIndex = p4
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		})
	})
end
function v1.didMount(p1) --[[ Line: 130 | Upvalues: RunService (copy), CharacterUtils (copy), Players (copy) ]]
	p1._maid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 131 | Upvalues: p1 (copy), CharacterUtils (ref), Players (ref) ]]
		local v1 = os.clock()
		if p1.props.points then
			for i, v in ipairs(p1.props.points) do
				local v2, v3
				if v._position and v.part then
					v._updatePosition(v.part.Position)
				end
				if v._visible then
					if v.flash then
						if v.nextVisibleToggle < v1 then
							local v4 = not v._visible:getValue()
							local v5 = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
							v2 = if v5 and v._position then (v5.Position - v._position:getValue()).Magnitude else 1.797693134862316e308
							if v2 > 700 then
								v4 = false
							end
							if v4 then
								v.nextVisibleToggle = v1 + 0.3333333333333333
							else
								v3 = v.invisibilityTimeFunc and v.invisibilityTimeFunc() or 3
								v.nextVisibleToggle = v1 + v3
							end
							v._updateVisible(v4)
						end
					elseif not v._visible:getValue() then
						v._updateVisible(true)
					end
				end
			end
		end
	end))
	p1._maid:GiveTask(workspace:GetAttributeChangedSignal("RaceTrackActive"):Connect(function() --[[ Line: 168 | Upvalues: p1 (copy) ]]
		local t = {}
		t.trackVisible = workspace:GetAttribute("RaceTrackActive") == true
		p1:setState(t)
	end))
	local isNotTrackVisible = p1.state.trackVisible ~= workspace:GetAttribute("RaceTrackActive")
	if isNotTrackVisible == true then
		local t = {}
		t.trackVisible = workspace:GetAttribute("RaceTrackActive") == true
		p1:setState(t)
	end
end
function v1.render(p1) --[[ Line: 179 | Upvalues: Roact (copy), createElement (copy), MinimapUtils (copy), ColorUtils (copy), Dictionary (copy), makeMinimap (copy) ]]
	if p1.props.visible then
		local v1 = p1.props.pointsChildren or {}
		if p1.props.points then
			for i, v in ipairs(p1.props.points) do
				if not v._position then
					local v2 = v.worldPosition or v.part and v.part.Position
					if not v2 then
						if typeof(v._debugStr) == "string" then
							warn("^ debug str: " .. v._debugStr)
						end
						v2 = Vector3.new(0, 0, 0)
					end
					local v3, v4 = Roact.createBinding(v2)
					v._position = v3
					v._updatePosition = v4
				end
				if not v._visible then
					v.nextVisibleToggle = os.clock()
					local v5, v6 = Roact.createBinding(not v.flash)
					v._visible = v5
					v._updateVisible = v6
				end
				local v7 = v.size or UDim2.new(0, 16, 0, 16)
				if p1.props.isSmallScreen then
					v7 = UDim2.new(0, v7.X.Offset / 2, 0, v7.Y.Offset / 2)
				end
				v1[v.name] = createElement("ImageLabel", {
					BackgroundTransparency = 1,
					Image = "rbxassetid://4903883144",
					ImageColor3 = v.color,
					Size = v7,
					AnchorPoint = Vector2.new(0.5, 0.5),
					Visible = v._visible,
					ZIndex = 3,
					Position = v._position:map(function(p12) --[[ Line: 212 | Upvalues: MinimapUtils (ref), p1 (copy) ]]
						return MinimapUtils.worldToScale(p12.X, p12.Z, p1.props.mapWorldCenterX, p1.props.mapWorldCenterY, p1.props.mapWorldWidth, p1.props.mapWorldHeight)
					end)
				})
			end
		end
		if p1.props.labels then
			for i, v in ipairs(p1.props.labels) do
				local v9 = ("label_%s"):format(v.title)
				local v10 = nil
				if typeof(v.position) == "Vector3" then
					local position_2 = v.position
					v10 = MinimapUtils.worldToScale(position_2.X, position_2.Z, p1.props.mapWorldCenterX, p1.props.mapWorldCenterY, p1.props.mapWorldWidth, p1.props.mapWorldHeight)
				else
					if typeof(v.position) == "table" and v.position.map then
						v10 = v.position:map(function(p12) --[[ Line: 240 | Upvalues: MinimapUtils (ref), p1 (copy) ]]
							return MinimapUtils.worldToScale(p12.X, p12.Z, p1.props.mapWorldCenterX, p1.props.mapWorldCenterY, p1.props.mapWorldWidth, p1.props.mapWorldHeight)
						end)
					end
				end
				local v13 = nil
				local t = {
					BackgroundTransparency = 1,
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = v10,
					ZIndex = 1
				}
				local t2 = {}
				if v.imageId then
					v13 = "ImageLabel"
					t.Image = "rbxassetid://2819326547"
					t.Size = p1.containerSize:map(function(p1) --[[ Line: 262 ]]
						return UDim2.new(0, p1.X * 0.03, 0, p1.X * 0.03)
					end)
					t.ImageColor3 = v.markerColor
					local t3 = {
						Icon = createElement("ImageLabel", {
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 1, 0),
							ImageColor3 = Color3.fromRGB(0, 0, 0),
							Image = ("rbxassetid://%s"):format(v.imageId)
						})
					}
					t3.UIScale = v.scale and createElement("UIScale", {
						Scale = v.scale
					})
					t2 = t3
				elseif v.title then
					t.Size = p1.containerSize:map(function(p1) --[[ Line: 279 ]]
						return UDim2.new(0, p1.X * 0.1, 0, p1.X * 0.02)
					end)
					t.Font = Enum.Font.GothamBlack
					t.TextColor3 = Color3.new(255/255, 255/255, 255/255)
					t.Text = v.title
					t.TextScaled = true
					t.ZIndex = 2
					t2.UIStroke = createElement("UIStroke", {
						Color = Color3.new(0/255, 0/255, 0/255),
						Thickness = 2
					})
					v13 = "TextLabel"
				end
				assert(v13, "missing classname for label")
				v1[v9] = createElement(v13, t, t2)
			end
		end
		v1._you = createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://4903882925",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = p1.containerSize:map(function(p1) --[[ Line: 301 ]]
				return UDim2.new(0, math.min(20, p1.X * 0.1), 0, (math.min(20, p1.X * 0.1)))
			end),
			ImageColor3 = p1.props.color,
			ZIndex = 5,
			Position = p1.props.worldPosition:map(function(p12) --[[ Line: 307 | Upvalues: MinimapUtils (ref), p1 (copy) ]]
				return MinimapUtils.worldToScale(p12.X, p12.Z, p1.props.mapWorldCenterX, p1.props.mapWorldCenterY, p1.props.mapWorldWidth, p1.props.mapWorldHeight)
			end),
			Rotation = p1.props.worldDirection:map(function(p1) --[[ Line: 317 ]]
				return -math.deg(math.atan2(-p1.Z, p1.X) - 1.5707963267948966)
			end)
		})
		if p1.props.waypoint then
			local waypoint = p1.props.waypoint
			local t = {
				BackgroundTransparency = 1,
				Image = "rbxassetid://8971844725",
				ImageColor3 = Color3.new(255/255, 255/255, 255/255)
			}
			t.Size = p1.props.isSmallScreen and UDim2.new(0, 24, 0, 24) or UDim2.new(0, 48, 0, 48)
			t.AnchorPoint = Vector2.new(0.5, 0.5)
			t.ZIndex = 3
			t.Position = MinimapUtils.worldToScale(waypoint.X, waypoint.Z, p1.props.mapWorldCenterX, p1.props.mapWorldCenterY, p1.props.mapWorldWidth, p1.props.mapWorldHeight)
			v1._waypoint = createElement("ImageLabel", t)
		end
		local v18 = p1.props[Roact.Children] or {}
		if p1.props.square then
			v18.AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1
			})
		end
		if p1.props.time ~= nil then
			local t = {
				BackgroundTransparency = 1,
				Image = "rbxassetid://4903944433",
				ImageColor3 = p1.props.color,
				Size = UDim2.new(0.5, 0, 1, 0)
			}
			t.AnchorPoint = p1.props.open and Vector2.new(0.9, 0.5) or Vector2.new(0, 0)
			t.Position = UDim2.new(if p1.props.open then 1 elseif p1.props.isSmallScreen then 0.05 else 0, 0, if p1.props.open then 1 elseif p1.props.isSmallScreen then 0.05 else 0, 0)
			t.ZIndex = 2
			v18.Time = createElement("ImageLabel", t, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 3
				}),
				SizeConstraint = createElement("UISizeConstraint", {
					MaxSize = Vector2.new(200, 50)
				}),
				Time = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Font = Enum.Font.LuckiestGuy,
					Text = p1.props.time,
					TextColor3 = Color3.new(255/255, 255/255, 255/255),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.new(0.7, 0, 0.7, 0),
					Position = UDim2.new(0.5, 0, 0.58, 0),
					TextScaled = true
				})
			})
		end
		if p1.props.showToggleButton then
			local t = {
				BackgroundTransparency = 1,
				Image = "rbxassetid://4933143781",
				AnchorPoint = Vector2.new(0.4, 0.4),
				ZIndex = 3,
				Position = UDim2.new(0, 0, 0, 0)
			}
			t.Size = p1.props.isSmallScreen and UDim2.new(0.2, 0, 0.2, 0) or UDim2.new(0.1, 0, 0.1, 0)
			t[Roact.Event.MouseButton1Down] = function() --[[ Line: 388 | Upvalues: p1 (copy) ]]
				if p1.props.onToggle then
					p1.props.onToggle(not p1.props.open)
				end
			end
			v18.Toggle = createElement("ImageButton", t, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 1
				}),
				SizeConstraint = createElement("UISizeConstraint", {
					MaxSize = Vector2.new(30, 30)
				})
			})
		end
		local t = {}
		if p1.props.circles then
			for v29, v30 in p1.props.circles do
				if not v30.worldRadiusBinding then
					error("circle missing worldRadiusBinding")
				end
				if not v30.worldPositionBinding then
					error("circle missing worldPositionBinding")
				end
				if not v30.name then
					error("circle missing name")
				end
				local v31 = ("circle_%s"):format(v30.name)
				if t[v31] then
					error(("duplicate circle name %s"):format(v30.name))
				end
				local v32 = v30.worldRadiusBinding:map(function(p12) --[[ Line: 419 | Upvalues: MinimapUtils (ref), p1 (copy) ]]
					return MinimapUtils.relativeWorldToScale(2 * p12, 2 * p12, p1.props.mapWorldWidth, p1.props.mapWorldHeight)
				end)
				local v33 = v30.worldPositionBinding:map(function(p12) --[[ Line: 426 | Upvalues: MinimapUtils (ref), p1 (copy) ]]
					return MinimapUtils.worldToScale(p12.X, p12.Z, p1.props.mapWorldCenterX, p1.props.mapWorldCenterY, p1.props.mapWorldWidth, p1.props.mapWorldHeight)
				end)
				local v34 = v30.color or Color3.new(255/255, 255/255, 255/255)
				if v30.invert then
					t[v31] = createElement("Frame", {
						BackgroundTransparency = v30.transparency or 0,
						BackgroundColor3 = v34,
						BorderSizePixel = 0,
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = v33,
						Size = v32,
						ZIndex = 1
					}, {
						Corner = createElement("UICorner", {
							CornerRadius = UDim.new(1, 0)
						}),
						StrokeOuter = createElement("UIStroke", {
							Color = v34,
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
								Color = ColorUtils.brightenBy(v34, -0.2),
								Thickness = 2
							})
						})
					})
				else
					t[v31] = createElement("Frame", {
						BackgroundTransparency = v30.transparency or 0,
						BackgroundColor3 = v34,
						BorderSizePixel = 0,
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = v33,
						Size = v32,
						ZIndex = 1
					}, {
						Corner = createElement("UICorner", {
							CornerRadius = UDim.new(1, 0)
						}),
						Stroke = createElement("UIStroke", {
							Color = ColorUtils.brightenBy(v34, -0.2),
							Thickness = 2
						})
					})
				end
			end
		end
		if p1.props.open then
			local v35 = Roact.joinBindings({ p1.containerSize, p1.props.worldPosition })
			local t2 = {
				AutoButtonColor = false,
				Text = "",
				BackgroundTransparency = 0,
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundColor3 = p1.props.color,
				[Roact.Event.Activated] = p1.props.onClick
			}
			local t3 = {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				})
			}
			local t4 = {}
			t4.BackgroundColor3 = p1.props.mapImageColor3 and p1.props.mapImageColor3:map(function(p1) --[[ Line: 508 ]]
				return Color3.fromRGB(84 * p1.r, 128 * p1.g, 178 * p1.b)
			end) or Color3.new(0.1, 0.1, 0.1)
			t4.BackgroundTransparency = 0
			t4.AnchorPoint = Vector2.new(0.5, 0.5)
			t4.Size = UDim2.new(1, -4, 1, -4)
			t4.Position = UDim2.new(0.5, 0, 0.5, 0)
			t4.ClipsDescendants = true
			t4[Roact.Ref] = p1.containerRef
			t4[Roact.Change.AbsoluteSize] = function(p12) --[[ Line: 519 | Upvalues: p1 (copy) ]]
				if p12 then
					p1.updateContainerSize(p12.AbsoluteSize)
				end
			end
			local t5 = {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				Points = createElement("Frame", {
					BackgroundTransparency = 1,
					AnchorPoint = Vector2.new(0, 0),
					Position = v35:map(function(p12) --[[ Line: 532 | Upvalues: MinimapUtils (ref), p1 (copy) ]]
						local _, v1, v2 = MinimapUtils.computeOffsetXY(p12[2], p12[1], p1.props.mapWorldWidth, p1.props.mapWorldHeight, p1.props.mapWorldCenterX, p1.props.mapWorldCenterY, p1.props.mapImageWidth, p1.props.mapImageHeight, p1.props.mapScale)
						return UDim2.new(0, -v1, 0, -v2)
					end),
					Size = v35:map(function(p12) --[[ Line: 546 | Upvalues: MinimapUtils (ref), p1 (copy) ]]
						local _, _2, _3, v1 = MinimapUtils.computeOffsetXY(p12[2], p12[1], p1.props.mapWorldWidth, p1.props.mapWorldHeight, p1.props.mapWorldCenterX, p1.props.mapWorldCenterY, p1.props.mapImageWidth, p1.props.mapImageHeight, p1.props.mapScale)
						return UDim2.new(0, p1.props.mapImageWidth * v1, 0, p1.props.mapImageHeight * v1)
					end),
					ZIndex = 2
				}, Dictionary.merge(v1, t)),
				Render = makeMinimap(p1, v35, p1.props.mapImageId, 0, 1, 0)
			}
			t5.RenderTrack = p1.state.trackVisible and makeMinimap(p1, v35, 106966740654302, 1, 2, 1) or nil
			t3.Container = createElement("Frame", t4, Dictionary.merge(t5, p1.props.containerChildren))
			v18.Map = createElement("TextButton", t2, t3)
		end
		return createElement("Frame", {
			BackgroundTransparency = 1,
			Size = p1.props.size,
			Position = p1.props.position,
			AnchorPoint = p1.props.anchorPoint,
			LayoutOrder = p1.props.displayOrder
		}, v18)
	end
end
function v1.willUnmount(p1) --[[ Line: 579 ]]
	p1._maid:DoCleaning()
end
return v1