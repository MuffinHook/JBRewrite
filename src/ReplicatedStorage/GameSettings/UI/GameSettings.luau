-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Checkbox = require(ReplicatedStorage.EzUi.Checkbox)
local Slider = require(ReplicatedStorage.EzUi.Slider)
local Maid = require(ReplicatedStorage.Std.Maid)
local GameSettingsService = require(script.Parent.Parent.GameSettingsService)
local gameSettingType = require(script.Parent.Parent.gameSettingType)
local v1 = Roact.PureComponent:extend("GameSettings")
function v1.init(p1)
	p1.maid = Maid.new()
	p1:setState({
		updateCounter = 0
	})
	p1.maid:GiveTask(GameSettingsService.onUpdate:Connect(function()
		p1:_forceUpdate()
	end))
end
function v1._forceUpdate(p1)
	p1:setState({
		updateCounter = p1.state.updateCounter + 1
	})
end
function v1.render(p1)
	local t = {}
	for i, v in ipairs(GameSettingsService.getAll()) do
		local v1 = nil
		if v.type == gameSettingType.Checkbox then
			local t2 = {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				LayoutOrder = v.order
			}
			local t3 = {
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
					value = v._value,
					onChecked = function(p12)
						v._value = p12
						p1:_forceUpdate()
						v.onChanged:Fire(p12)
					end,
					layoutOrder = 1,
					checkColor = p1.props.color
				})
			}
			local t4 = {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.85, 0, 0.8, 0),
				Position = UDim2.new(0, 0, 0, 0)
			}
			t4.Text = v.title or v.name
			t4.Font = Enum.Font.LuckiestGuy
			t4.LineHeight = 0.7
			t4.TextXAlignment = Enum.TextXAlignment.Left
			t4.TextScaled = true
			t4.TextColor3 = Color3.new(255/255, 255/255, 255/255)
			t4.LayoutOrder = 2
			t3.Title = createElement("TextLabel", t4)
			v1 = createElement("Frame", t2, t3)
		elseif v.type == gameSettingType.Slider then
			local t2 = {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				LayoutOrder = v.order
			}
			local t3 = {
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
					min = v.min,
					max = v.max,
					step = v.step,
					value = v._value,
					updateValue = function(p1)
						v._updateValue(p1)
						v.onChanged:Fire(p1)
					end,
					layoutOrder = 1,
					text = v._value:map(v.textMap)
				})
			}
			local t4 = {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.5, 0, 0.8, 0),
				Position = UDim2.new(0, 0, 0, 0)
			}
			t4.Text = v.title or v.name
			t4.Font = Enum.Font.LuckiestGuy
			t4.LineHeight = 0.7
			t4.TextXAlignment = Enum.TextXAlignment.Left
			t4.TextScaled = true
			t4.TextColor3 = Color3.new(255/255, 255/255, 255/255)
			t4.LayoutOrder = 2
			t3.Title = createElement("TextLabel", t4)
			v1 = createElement("Frame", t2, t3)
		end
		t[v.name] = v1
	end
	return createElement("ScrollingFrame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = p1.props.size,
		Position = p1.props.position,
		AnchorPoint = p1.props.anchorPoint,
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
	}, t))
end
function v1.willUnmount(p1)
	p1.maid:DoCleaning()
end
return v1
