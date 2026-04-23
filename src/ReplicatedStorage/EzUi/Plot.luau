local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local createElement = Roact.createElement
local v2 = Roact.Component:extend("Plot")
function v2.init(p1) --[[ Line: 8 ]]
	p1:setState({
		aspectRatio = 1
	})
end
function v2.CalculateAspectRatio(p1, p2) --[[ Line: 13 ]]
	p1:setState({
		aspectRatio = p2.AbsoluteSize.Y / p2.AbsoluteSize.X
	})
end
function v2.render(p1) --[[ Line: 18 | Upvalues: createElement (copy), Roact (copy) ]]
	local window = p1.props.window
	local v1 = window[1]
	local v2 = window[2]
	local v3 = window[3] - v1
	local v4 = window[4] - v2
	local t = {}
	if p1.props.lines then
		local v5 = p1.props.lineWidth or 2
		for i, v in ipairs(p1.props.lines) do
			local v6 = (v[1] - v1) / v3
			local v7 = (v[2] - v2) / v4
			local v8 = (v[3] - v1) / v3
			local v9 = (v[4] - v2) / v4
			local v12 = v8 - v6
			local v13 = v9 - v7
			local v15 = math.sqrt(v13 * v13 * p1.state.aspectRatio * p1.state.aspectRatio + v12 * v12)
			local v17 = math.atan2(v13 * p1.state.aspectRatio, v12)
			local t2 = {
				AnchorPoint = Vector2.new(0.5, 0.5)
			}
			t2.BackgroundColor3 = p1.props.lineColor or Color3.new(255/255, 255/255, 255/255)
			t2.BorderSizePixel = 0
			t2.Size = UDim2.new(v15, 0, 0, v5)
			t2.Rotation = math.deg(-v17)
			t2.Position = UDim2.new((v6 + v8) * 0.5, 0, 1 - (v7 + v9) * 0.5, 0)
			table.insert(t, createElement("Frame", t2))
		end
	end
	if p1.props.points then
		local v21 = p1.props.pointRadius or 3
		for i, v in ipairs(p1.props.points) do
			local t2 = {
				AnchorPoint = Vector2.new(0.5, 0.5)
			}
			t2.BackgroundColor3 = p1.props.pointColor or Color3.new(255/255, 255/255, 255/255)
			t2.BorderSizePixel = 0
			t2.Size = UDim2.new(0, v21 * 2, 0, v21 * 2)
			t2.Position = UDim2.new((v[1] - v1) / v3, 0, 1 - (v[2] - v2) / v4, 0)
			table.insert(t, createElement("Frame", t2))
		end
	end
	if p1.props.labels then
		for i, v in ipairs(p1.props.labels) do
			local t2 = {
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = v[1]
			}
			t2.TextColor3 = p1.props.labelColor or Color3.new(255/255, 255/255, 255/255)
			t2.Position = UDim2.new((v[2] - v1) / v3, 0, 1 - (v[3] - v2) / v4, 0)
			table.insert(t, createElement("TextLabel", t2))
		end
	end
	return createElement("Frame", {
		BorderSizePixel = 1,
		BorderColor3 = Color3.new(255/255, 255/255, 255/255),
		BackgroundColor3 = Color3.fromRGB(20, 20, 20),
		BackgroundTransparency = p1.props.backgroundTransparency,
		Size = p1.props.size,
		Position = p1.props.position,
		ZIndex = p1.props.zIndex,
		[Roact.Change.AbsoluteSize] = function(p12) --[[ Line: 96 | Upvalues: p1 (copy) ]]
			p1:CalculateAspectRatio(p12)
		end
	}, t)
end
return v2