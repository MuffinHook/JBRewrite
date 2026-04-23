local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("ChooseSpawn")
v1.defaultProps = {
	visible = false,
	mapScale = 1,
	bornAt = workspace:GetServerTimeNow(),
	duration = 5,
	position = UDim2.new(0.5, 0, 0.5, 0),
	size = UDim2.new(0.25, 0, 0.25, 0)
}
function v1.init(p1) --[[ Line: 17 | Upvalues: Maid (copy) ]]
	p1.maid = Maid.new()
	p1:setState({
		remaining = p1.props.duration
	})
	function p1.onSelect() --[[ Line: 22 | Upvalues: p1 (copy) ]]
		p1.props.onSelect()
		p1.props.hide()
	end
end
function v1.render(p1) --[[ Line: 27 | Upvalues: createElement (copy), Roact (copy) ]]
	if p1.props.visible then
		local t = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = p1.props.size,
			Position = p1.props.position,
			AnchorPoint = Vector2.new(0.5, 0.5)
		}
		local t2 = {
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 6
			})
		}
		local t3 = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(0.16666666666666666, 0, 1, 0)
		}
		local t4 = {}
		local t5 = {
			Size = UDim2.new(0.9, 0, 0.9, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 0,
			BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		}
		local t6 = {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(1, 0)
			}),
			UIStroke = createElement("UIStroke", {
				Color = Color3.new(51/255, 51/255, 51/255),
				Thickness = 1,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			})
		}
		local t7 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.9, 0, 0.9, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}
		t7.Text = tostring(p1.state.remaining)
		t7.Font = Enum.Font.Bangers
		t7.LineHeight = 1
		t7.TextScaled = true
		t7.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		t6.Text = createElement("TextLabel", t7)
		t4.Inner = createElement("Frame", t5, t6)
		t2.Left = createElement("Frame", t3, t4)
		t2.Right = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Position = UDim2.new(0.16666666666666666, 0, 0, 0),
			Size = UDim2.new(0.8333333333333334, 0, 1, 0)
		}, {
			Inner = createElement("TextButton", {
				Text = "",
				Size = UDim2.new(0.98, 0, 0.9, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
				Selectable = true,
				[Roact.Event.Activated] = p1.onSelect
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0.25, 0)
				}),
				UIStroke = createElement("UIStroke", {
					Color = Color3.new(255/255, 255/255, 255/255),
					Thickness = 1,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				}),
				Title = createElement("Frame", {
					BackgroundTransparency = 1,
					BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
					Size = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(0, 0, 0, 0)
				}, {
					Text = createElement("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(0.9, 0, 0.9, 0),
						Position = UDim2.new(0.5, 0, 0.5, 0),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Text = "Choose Spawn",
						Font = Enum.Font.Bangers,
						LineHeight = 1,
						TextScaled = true,
						TextColor3 = Color3.new(255/255, 255/255, 255/255)
					})
				})
			})
		})
		return createElement("Frame", t, t2)
	end
end
function v1.didUpdate(p1, p2, p3) --[[ Line: 121 ]]
	if p2.duration ~= p1.props.duration or p2.bornAt ~= p1.props.bornAt then
		p1:_startTimer()
	end
end
function v1._startTimer(p1) --[[ Line: 126 | Upvalues: Interval (copy) ]]
	local function update() --[[ Line: 127 | Upvalues: p1 (copy) ]]
		local v1 = workspace:GetServerTimeNow() - p1.props.bornAt
		local v2
		if p1.props.duration <= v1 then
			p1.maid.countdown = nil
			v2 = true
		else
			v2 = false
		end
		local t = {}
		t.remaining = math.max(0, (math.ceil(p1.props.duration - v1)))
		p1:setState(t)
		if v2 then
			p1.props.hide()
		end
	end
	update()
	p1.maid.countdown = Interval.every(1):Connect(update)
end
function v1.didMount(p1) --[[ Line: 145 ]]
	if p1.props.visible then
		p1:_startTimer()
	end
end
function v1.willUnmount(p1) --[[ Line: 150 ]]
	p1.maid:DoCleaning()
end
return RoactRodux.connect(function(p1, p2) --[[ Line: 154 ]]
	return {
		bornAt = p1.lastDiedAt,
		visible = p1.spawnSelectionOfferVisible
	}
end, function(p1) --[[ Line: 159 ]]
	return {
		hide = function() --[[ Name: hide | Line: 161 | Upvalues: p1 (copy) ]]
			p1({
				type = "setSpawnSelectionOfferVisible",
				visible = false
			})
		end
	}
end)(v1)