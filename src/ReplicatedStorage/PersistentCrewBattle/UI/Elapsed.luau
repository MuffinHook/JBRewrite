local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("Elapsed")
v1.defaultProps = {
	size = UDim2.fromScale(1, 1),
	position = UDim2.fromScale(0.5, 0.5),
	anchorPoint = Vector2.new(0.5, 0.5),
	createdAt = nil,
	createdAtBinding = nil,
	textXAlignment = Enum.TextXAlignment.Center,
	prefix = "",
	suffix = "",
	disabled = false,
	font = Enum.Font.FredokaOne,
	textColor = Color3.new(0/255, 0/255, 0/255),
	countDown = false,
	alwaysShowHours = false,
	alwaysShowMinutes = true,
	alwaysShowSeconds = true
}
function v1.init(p1) --[[ Line: 25 | Upvalues: Maid (copy) ]]
	p1:setState({
		elapsed = 0
	})
	p1.maid = Maid.new()
end
function v1.render(p1) --[[ Line: 31 | Upvalues: createElement (copy), Roact (copy) ]]
	local v1 = p1.props.elapsed or p1.state.elapsed
	local v2 = math.floor(v1 % 86400 / 3600)
	local v3 = math.floor(v1 % 3600 / 60)
	local v4 = math.floor(v1 % 60)
	local alwaysShowHours = p1.props.alwaysShowHours
	if not alwaysShowHours then
		alwaysShowHours = v2 > 0
	end
	local alwaysShowMinutes = p1.props.alwaysShowMinutes
	if not alwaysShowMinutes then
		alwaysShowMinutes = alwaysShowHours or v3 > 0
	end
	local alwaysShowSeconds = p1.props.alwaysShowSeconds
	if not alwaysShowSeconds then
		alwaysShowSeconds = alwaysShowMinutes or v4 >= 0
	end
	local v8 = ("%s%s%s%s%s"):format(p1.props.prefix, if alwaysShowHours then ("%02d:"):format(v2) else "", if alwaysShowMinutes then ("%02d:"):format(v3) else "", if alwaysShowSeconds then ("%02d"):format(v4) else "", p1.props.suffix)
	local v9 = ("%s--%s"):format(p1.props.prefix, p1.props.suffix)
	local t = {
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
		Size = p1.props.size,
		Position = p1.props.position,
		AnchorPoint = p1.props.anchorPoint
	}
	local t2 = {}
	local t3 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.9, 0, 0.8, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5)
	}
	t3.Text = if p1.props.disabled then v9 else v8
	t3.TextXAlignment = p1.props.textXAlignment
	t3.Font = p1.props.font
	t3.LineHeight = 1
	t3.TextScaled = true
	t3.TextColor3 = p1.props.textColor
	t3[Roact.Children] = p1.props[Roact.Children]
	t2.Text = createElement("TextLabel", t3)
	return createElement("Frame", t, t2)
end
function v1._startCounting(p1) --[[ Line: 69 | Upvalues: Interval (copy) ]]
	local function update() --[[ Line: 70 | Upvalues: p1 (copy) ]]
		local v1 = workspace:GetServerTimeNow()
		local v2
		if p1.props.createdAtBinding then
			v2 = p1.props.createdAtBinding:getValue()
		elseif p1.props.createdAt then
			v2 = p1.props.createdAt
		else
			warn("No createdAt exists")
			v2 = 0
		end
		local v4 = if p1.props.countDown then v2 - v1 else v1 - v2
		local t = {}
		t.elapsed = math.max(0, (math.floor(v4)))
		p1:setState(t)
		if p1.props.onElapsed then
			p1.props.onElapsed(v4)
		end
	end
	update()
	p1.maid.counting = Interval.every(0.5):Connect(update)
end
function v1.didMount(p1) --[[ Line: 92 ]]
	if not (p1.props.elapsed or p1.props.disabled) then
		p1:_startCounting()
	end
end
function v1.didUpdate(p1, p2, p3) --[[ Line: 97 ]]
	if p1.props.elapsed or p1.props.disabled then
		p1.maid.counting = nil
	elseif p1.maid.counting == nil then
		p1:_startCounting()
	end
end
function v1.willUnmount(p1) --[[ Line: 106 ]]
	p1.maid:DoCleaning()
end
return v1