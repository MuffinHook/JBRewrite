local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Interval = require(ReplicatedStorage.Std.Interval)
local Audio = require(ReplicatedStorage.Std.Audio)
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local CCTV = require(script.Parent.CCTV)
local CameraBinder = require(script.Parent.Parent.CameraBinder)
local v1 = Roact.PureComponent:extend("Viewer")
function v1.init(p1) --[[ Line: 17 | Upvalues: Maid (copy), Roact (copy) ]]
	p1._maid = Maid.new()
	p1:setState({
		index = 1
	})
	p1:_updateCameraParts()
	local v1, v2 = Roact.createBinding(1)
	p1.flash = v1
	p1.updateFlash = v2
end
function v1._flash(p1) --[[ Line: 25 | Upvalues: RunService (copy) ]]
	local v1 = os.clock()
	p1._maid.flash = RunService.Heartbeat:Connect(function() --[[ Line: 28 | Upvalues: v1 (copy), p1 (copy) ]]
		local v12 = (os.clock() - v1) / 0.25
		if v12 > 1 then
			p1._maid.flash = nil
			v12 = 1
		end
		p1.updateFlash(1 - math.sin(math.pi * (v12 + 0.25) / 1.25))
	end)
end
function v1._updateCameraParts(p1) --[[ Line: 39 | Upvalues: CollectionService (copy), Maid (copy) ]]
	local v1 = CollectionService:GetTagged(p1.props.cameraTag)
	p1:setState({
		cameraParts = v1
	})
	local v2 = Maid.new()
	p1._maid.cameraPartMaid = v2
	for i, v in ipairs(v1) do
		v2:GiveTask(v:GetAttributeChangedSignal("CCTVDisabled"):Connect(function() --[[ Line: 47 | Upvalues: p1 (copy) ]]
			p1:_updateCameraParts()
		end))
	end
end
function v1.render(p1) --[[ Line: 52 | Upvalues: createElement (copy), CCTV (copy), Roact (copy), CameraBinder (copy), Dictionary (copy) ]]
	if p1.state.cameraParts and #p1.state.cameraParts ~= 0 then
		local t = {}
		local t2 = {}
		local t3 = {}
		for i = 1, #p1.state.cameraParts do
			local v1
			local v2 = p1.state.cameraParts[i]
			t[i] = v2.CFrame * CFrame.new(0, 0, -v2.Size.Z * 0.5)
			t2[i] = v2:GetAttribute("CCTVName")
			v1 = v2:GetAttribute("CCTVDisabled") == true
			t3[i] = v1
		end
		local t4 = {}
		for j = 1, 3 do
			local v3 = (p1.state.index + j - 1) % #t + 1
			t4[v3] = createElement(CCTV, {
				active = false,
				size = UDim2.new(1, 0, 1, 0),
				position = UDim2.new(0.5, 0, 0.5, 0),
				distance = p1.props.distance,
				aspectRatio = p1.props.aspectRatio,
				cameraCFrame = t[v3],
				fieldOfView = p1.props.fieldOfView,
				layoutOrder = j,
				disabled = t3[v3]
			})
		end
		return createElement("Frame", {
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
			Size = p1.props.size,
			Position = p1.props.position,
			LayoutOrder = p1.props.layoutOrder,
			AnchorPoint = Vector2.new(0.5, 0.5)
		}, {
			Padding = createElement("UIPadding", {
				PaddingLeft = UDim.new(0.015625, 0),
				PaddingRight = UDim.new(0.015625, 0),
				PaddingTop = UDim.new(0.03359375, 0),
				PaddingBottom = UDim.new(0.03359375, 0)
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0.015625, 0)
			}),
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 2.15
			}),
			Close = createElement("ImageButton", {
				BackgroundTransparency = 1,
				Image = "rbxassetid://4933143781",
				AnchorPoint = Vector2.new(0.6, 0.6),
				ZIndex = 3,
				Position = UDim2.new(0, 0, 0),
				Size = UDim2.new(0.1, 0, 0.1, 0),
				Selectable = true,
				[Roact.Event.MouseButton1Down] = p1.props.onClickClose
			}, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 1
				})
			}),
			Main = createElement("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.8, 0, 1, 0)
			}, {
				Padding = createElement("UIPadding", {
					PaddingRight = UDim.new(0.015625, 0)
				}),
				Camera = createElement(CCTV, {
					size = UDim2.new(1, 0, 1, 0),
					position = UDim2.new(0.5, 0, 0.5, 0),
					distance = p1.props.distance,
					aspectRatio = p1.props.aspectRatio,
					cameraCFrame = t[p1.state.index],
					fieldOfView = p1.props.fieldOfView,
					disabled = t3[p1.state.index],
					flash = p1.flash,
					onCharacterEnter = function(p12) --[[ Name: onCharacterEnter | Line: 133 | Upvalues: CameraBinder (ref), p1 (copy) ]]
						CameraBinder:Get(p1.state.cameraParts[p1.state.index]):Spot(p12)
						p1:_flash()
					end
				}),
				Number = createElement("Frame", {
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
					BackgroundTransparency = 1,
					Size = UDim2.new(0.2, 0, 1, 0),
					AnchorPoint = Vector2.new(1, 1),
					Position = UDim2.new(0.98, 0, 0.98, 0),
					ZIndex = 3
				}, {
					AspectRatio = createElement("UIAspectRatioConstraint", {
						AspectRatio = 3
					}),
					Title = createElement("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 1, 0),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim2.new(0.5, 0, 0.6, 0),
						TextColor3 = Color3.new(255/255, 255/255, 255/255),
						TextScaled = true,
						Text = ("%02d/%02d"):format(p1.state.index, #t),
						Font = Enum.Font.LuckiestGuy
					})
				}),
				Title = createElement("Frame", {
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
					BackgroundTransparency = 1,
					Size = UDim2.new(0.5, 0, 1, 0),
					AnchorPoint = Vector2.new(0, 0),
					Position = UDim2.new(0.02, 0, 0.02, 0),
					ZIndex = 3
				}, {
					AspectRatio = createElement("UIAspectRatioConstraint", {
						AspectRatio = 8
					}),
					Title = createElement("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 1, 0),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim2.new(0.5, 0, 0.6, 0),
						TextColor3 = Color3.new(255/255, 255/255, 255/255),
						TextScaled = true,
						Text = t2[p1.state.index],
						Font = Enum.Font.LuckiestGuy,
						TextXAlignment = Enum.TextXAlignment.Left
					})
				})
			}),
			Side = createElement("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.2, 0, 1, 0),
				Position = UDim2.new(0.8, 0, 0, 0)
			}, Dictionary.merge({
				ListLayout = createElement("UIListLayout", {
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					FillDirection = Enum.FillDirection.Vertical,
					Padding = UDim.new(0.0215, 0)
				}),
				Next = createElement("TextButton", {
					BackgroundTransparency = 0,
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.new(0.3, 0.3, 0.3),
					Size = UDim2.new(1, 0, 1, 0),
					LayoutOrder = 100,
					Text = "",
					[Roact.Event.MouseButton1Down] = function() --[[ Line: 209 | Upvalues: p1 (copy), t (copy) ]]
						p1:setState({
							index = (p1.state.index + 1 - 1) % #t + 1
						})
					end
				}, {
					AspectRatio = createElement("UIAspectRatioConstraint", {
						AspectRatio = 6
					}),
					Title = createElement("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 1, 0),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim2.new(0.5, 0, 0.65, 0),
						TextColor3 = Color3.new(255/255, 255/255, 255/255),
						TextScaled = true,
						Text = "Next",
						Font = Enum.Font.LuckiestGuy
					})
				}),
				Prev = createElement("TextButton", {
					BackgroundTransparency = 0,
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.new(0.3, 0.3, 0.3),
					Size = UDim2.new(1, 0, 1, 0),
					LayoutOrder = 101,
					Text = "",
					[Roact.Event.MouseButton1Down] = function() --[[ Line: 236 | Upvalues: p1 (copy), t (copy) ]]
						p1:setState({
							index = (p1.state.index - 1 - 1) % #t + 1
						})
					end
				}, {
					AspectRatio = createElement("UIAspectRatioConstraint", {
						AspectRatio = 6
					}),
					Title = createElement("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 1, 0),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim2.new(0.5, 0, 0.65, 0),
						TextColor3 = Color3.new(255/255, 255/255, 255/255),
						TextScaled = true,
						Text = "Prev",
						Font = Enum.Font.LuckiestGuy
					})
				})
			}, t4))
		})
	end
end
function v1.didMount(p1) --[[ Line: 260 | Upvalues: CollectionService (copy), Players (copy), Audio (copy), CharacterUtils (copy), Interval (copy) ]]
	p1.updateFlash(1)
	p1._maid:GiveTask(CollectionService:GetInstanceAddedSignal(p1.props.cameraTag):Connect(function() --[[ Line: 263 | Upvalues: p1 (copy) ]]
		p1:_updateCameraParts()
	end))
	p1._maid:GiveTask(CollectionService:GetInstanceRemovedSignal(p1.props.cameraTag):Connect(function() --[[ Line: 266 | Upvalues: p1 (copy) ]]
		p1:_updateCameraParts()
	end))
	if Players.LocalPlayer then
		p1._maid:GiveTask((Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9058379519, {
			Volume = 0.6,
			Looped = true
		})))
	end
	if p1.props.expireDistance then
		local v2 = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
		if v2 then
			local Position = v2.Position
			p1._maid:GiveTask(Interval.every(1):Connect(function() --[[ Line: 279 | Upvalues: v2 (ref), CharacterUtils (ref), Players (ref), Position (copy), p1 (copy) ]]
				v2 = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
				if v2 then
					if (v2.Position - Position).Magnitude > p1.props.expireDistance then
						p1.props.onClickClose()
					end
				else
					p1.props.onClickClose()
				end
			end))
		end
	end
end
function v1.willUnmount(p1) --[[ Line: 293 ]]
	p1._maid:DoCleaning()
end
return v1