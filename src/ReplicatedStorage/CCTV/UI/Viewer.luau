-- Reviewed by Claude
-- variables reassigned
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
local ViewerComponent = Roact.PureComponent:extend("Viewer")
function ViewerComponent.init(self)
	self._maid = Maid.new()
	self:setState({
		index = 1
	})
	self:_updateCameraParts()
	local flashBinding, updateFlashBinding = Roact.createBinding(1)
	self.flash = flashBinding
	self.updateFlash = updateFlashBinding
end
function ViewerComponent._flash(self)
	local startTime = os.clock()
	self._maid.flash = RunService.Heartbeat:Connect(function()
		local elapsedFraction = (os.clock() - startTime) / 0.25
		if elapsedFraction > 1 then
			self._maid.flash = nil
			elapsedFraction = 1
		end
		self.updateFlash(1 - math.sin(math.pi * (elapsedFraction + 0.25) / 1.25))
	end)
end
function ViewerComponent._updateCameraParts(self)
	local cameraPartsList = CollectionService:GetTagged(self.props.cameraTag)
	self:setState({
		cameraParts = cameraPartsList
	})
	local cameraPartMaid = Maid.new()
	self._maid.cameraPartMaid = cameraPartMaid
	for i, v in ipairs(cameraPartsList) do
		cameraPartMaid:GiveTask(v:GetAttributeChangedSignal("CCTVDisabled"):Connect(function()
			self:_updateCameraParts()
		end))
	end
end
function ViewerComponent.render(self)
	if self.state.cameraParts and #self.state.cameraParts ~= 0 then
		local cameraCFrameList = {}
		local cameraNameList = {}
		local isDisabledList = {}
		for i = 1, #self.state.cameraParts do
			local cameraIsDisabled
			local cameraPart = self.state.cameraParts[i]
			cameraCFrameList[i] = cameraPart.CFrame * CFrame.new(0, 0, -cameraPart.Size.Z * 0.5)
			cameraNameList[i] = cameraPart:GetAttribute("CCTVName")
			cameraIsDisabled = cameraPart:GetAttribute("CCTVDisabled") == true
			isDisabledList[i] = cameraIsDisabled
		end
		local previewCameraElements = {}
		for j = 1, 3 do
			local cameraIndex = (self.state.index + j - 1) % #cameraCFrameList + 1
			previewCameraElements[cameraIndex] = createElement(CCTV, {
				active = false,
				size = UDim2.new(1, 0, 1, 0),
				position = UDim2.new(0.5, 0, 0.5, 0),
				distance = self.props.distance,
				aspectRatio = self.props.aspectRatio,
				cameraCFrame = cameraCFrameList[cameraIndex],
				fieldOfView = self.props.fieldOfView,
				layoutOrder = j,
				disabled = isDisabledList[cameraIndex]
			})
		end
		return createElement("Frame", {
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
			Size = self.props.size,
			Position = self.props.position,
			LayoutOrder = self.props.layoutOrder,
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
				[Roact.Event.MouseButton1Down] = self.props.onClickClose
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
					distance = self.props.distance,
					aspectRatio = self.props.aspectRatio,
					cameraCFrame = cameraCFrameList[self.state.index],
					fieldOfView = self.props.fieldOfView,
					disabled = isDisabledList[self.state.index],
					flash = self.flash,
					onCharacterEnter = function(character)
						CameraBinder:Get(self.state.cameraParts[self.state.index]):Spot(character)
						self:_flash()
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
						Text = ("%02d/%02d"):format(self.state.index, #cameraCFrameList),
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
						Text = cameraNameList[self.state.index],
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
					[Roact.Event.MouseButton1Down] = function()
						self:setState({
							index = (self.state.index + 1 - 1) % #cameraCFrameList + 1
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
					[Roact.Event.MouseButton1Down] = function()
						self:setState({
							index = (self.state.index - 1 - 1) % #cameraCFrameList + 1
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
			}, previewCameraElements))
		})
	end
end
function ViewerComponent.didMount(self)
	self.updateFlash(1)
	self._maid:GiveTask(CollectionService:GetInstanceAddedSignal(self.props.cameraTag):Connect(function()
		self:_updateCameraParts()
	end))
	self._maid:GiveTask(CollectionService:GetInstanceRemovedSignal(self.props.cameraTag):Connect(function()
		self:_updateCameraParts()
	end))
	if Players.LocalPlayer then
		self._maid:GiveTask((Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9058379519, {
			Volume = 0.6,
			Looped = true
		})))
	end
	if self.props.expireDistance then
		local rootPart = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
		if rootPart then
			local initialPosition = rootPart.Position
			self._maid:GiveTask(Interval.every(1):Connect(function()
				rootPart = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
				if rootPart then
					if (rootPart.Position - initialPosition).Magnitude > self.props.expireDistance then
						self.props.onClickClose()
					end
				else
					self.props.onClickClose()
				end
			end))
		end
	end
end
function ViewerComponent.willUnmount(self)
	self._maid:DoCleaning()
end
return ViewerComponent
