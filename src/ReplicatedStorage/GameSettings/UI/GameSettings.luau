local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Checkbox = require(ReplicatedStorage.EzUi.Checkbox)
local Slider = require(ReplicatedStorage.EzUi.Slider)
local Maid = require(ReplicatedStorage.Std.Maid)
local GameSettingsService = require(script.Parent.Parent.GameSettingsService)
local gameSettingType = require(script.Parent.Parent.gameSettingType)
local GameSettingsComponent = Roact.PureComponent:extend("GameSettings")
function GameSettingsComponent.init(self)
	self.maid = Maid.new()
	self:setState({
		updateCounter = 0
	})
	self.maid:GiveTask(GameSettingsService.onUpdate:Connect(function()
		self:_forceUpdate()
	end))
end
function GameSettingsComponent._forceUpdate(self)
	self:setState({
		updateCounter = self.state.updateCounter + 1
	})
end
function GameSettingsComponent.render(self)
	local elementsByName = {}
	for settingIndex, gameSetting in ipairs(GameSettingsService.getAll()) do
		local element = nil
		if gameSetting.type == gameSettingType.Checkbox then
			local frameProps = {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				LayoutOrder = gameSetting.order
			}
			local frameChildren = {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 30
				}),
				ListLayout = createElement("UIListLayout", {
					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0.02, 0)
				}),
				Value = createElement(Checkbox, {
					size = UDim2.new(1, 0, 1, 0),
					value = gameSetting._value,
					onChecked = function(newValue)
						gameSetting._value = newValue
						self:_forceUpdate()
						gameSetting.onChanged:Fire(newValue)
					end,
					layoutOrder = 1,
					checkColor = self.props.color
				})
			}
			local labelProps = {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.85, 0, 0.8, 0),
				Position = UDim2.new(0, 0, 0, 0)
			}
			labelProps.Text = gameSetting.title or gameSetting.name
			labelProps.Font = Enum.Font.LuckiestGuy
			labelProps.LineHeight = 0.7
			labelProps.TextXAlignment = Enum.TextXAlignment.Left
			labelProps.TextScaled = true
			labelProps.TextColor3 = Color3.new(255/255, 255/255, 255/255)
			labelProps.LayoutOrder = 2
			frameChildren.Title = createElement("TextLabel", labelProps)
			element = createElement("Frame", frameProps, frameChildren)
		elseif gameSetting.type == gameSettingType.Slider then
			local frameProps = {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				LayoutOrder = gameSetting.order
			}
			local frameChildren = {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 30
				}),
				ListLayout = createElement("UIListLayout", {
					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0.02, 0)
				}),
				Value = createElement(Slider, {
					backgroundColor = Color3.new(0/255, 0/255, 0/255),
					handleColor = Color3.new(255/255, 255/255, 255/255),
					size = UDim2.new(0.48, 0, 1, 0),
					min = gameSetting.min,
					max = gameSetting.max,
					step = gameSetting.step,
					value = gameSetting._value,
					updateValue = function(newValue)
						gameSetting._updateValue(newValue)
						gameSetting.onChanged:Fire(newValue)
					end,
					layoutOrder = 1,
					text = gameSetting._value:map(gameSetting.textMap)
				})
			}
			local labelProps = {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.5, 0, 0.8, 0),
				Position = UDim2.new(0, 0, 0, 0)
			}
			labelProps.Text = gameSetting.title or gameSetting.name
			labelProps.Font = Enum.Font.LuckiestGuy
			labelProps.LineHeight = 0.7
			labelProps.TextXAlignment = Enum.TextXAlignment.Left
			labelProps.TextScaled = true
			labelProps.TextColor3 = Color3.new(255/255, 255/255, 255/255)
			labelProps.LayoutOrder = 2
			frameChildren.Title = createElement("TextLabel", labelProps)
			element = createElement("Frame", frameProps, frameChildren)
		end
		elementsByName[gameSetting.name] = element
	end
	return createElement("ScrollingFrame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = self.props.size,
		Position = self.props.position,
		AnchorPoint = self.props.anchorPoint,
		Selectable = false,
		ScrollBarThickness = 6,
		ScrollingDirection = Enum.ScrollingDirection.Y
	}, Dictionary.merge({
		Padding = createElement("UIPadding", {
			PaddingLeft = UDim.new(0, 4),
			PaddingRight = UDim.new(0, 4),
			PaddingTop = UDim.new(0, 4),
			PaddingBottom = UDim.new(0, 4)
		}),
		ListLayout = createElement("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0.02, 0)
		})
	}, elementsByName))
end
function GameSettingsComponent.willUnmount(self)
	self.maid:DoCleaning()
end
return GameSettingsComponent
