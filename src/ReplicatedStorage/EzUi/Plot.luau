-- Reviewed by Claude
-- variables reassigned
local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
local createElement = Roact.createElement
local v2 = Roact.Component:extend("Plot")
function v2.init(self)
	self:setState({
		aspectRatio = 1
	})
end
function v2.CalculateAspectRatio(self, sizeContainer)
	self:setState({
		aspectRatio = sizeContainer.AbsoluteSize.Y / sizeContainer.AbsoluteSize.X
	})
end
function v2.render(self)
	local window = self.props.window
	local minX = window[1]
	local minY = window[2]
	local width = window[3] - minX
	local height = window[4] - minY
	local frameElements = {}
	if self.props.lines then
		local lineWidth = self.props.lineWidth or 2
		for i, v in ipairs(self.props.lines) do
			local normalizedX1 = (v[1] - minX) / width
			local normalizedY1 = (v[2] - minY) / height
			local normalizedX2 = (v[3] - minX) / width
			local normalizedY2 = (v[4] - minY) / height
			local deltaX = normalizedX2 - normalizedX1
			local deltaY = normalizedY2 - normalizedY1
			local lineLength = math.sqrt(deltaY * deltaY * self.state.aspectRatio * self.state.aspectRatio + deltaX * deltaX)
			local angle = math.atan2(deltaY * self.state.aspectRatio, deltaX)
			local frameProps = {
				AnchorPoint = Vector2.new(0.5, 0.5)
			}
			frameProps.BackgroundColor3 = self.props.lineColor or Color3.new(255/255, 255/255, 255/255)
			frameProps.BorderSizePixel = 0
			frameProps.Size = UDim2.new(lineLength, 0, 0, lineWidth)
			frameProps.Rotation = math.deg(-angle)
			frameProps.Position = UDim2.new((normalizedX1 + normalizedX2) * 0.5, 0, 1 - (normalizedY1 + normalizedY2) * 0.5, 0)
			table.insert(frameElements, createElement("Frame", frameProps))
		end
	end
	if self.props.points then
		local pointRadius = self.props.pointRadius or 3
		for i, v in ipairs(self.props.points) do
			local frameProps = {
				AnchorPoint = Vector2.new(0.5, 0.5)
			}
			frameProps.BackgroundColor3 = self.props.pointColor or Color3.new(255/255, 255/255, 255/255)
			frameProps.BorderSizePixel = 0
			frameProps.Size = UDim2.new(0, pointRadius * 2, 0, pointRadius * 2)
			frameProps.Position = UDim2.new((v[1] - minX) / width, 0, 1 - (v[2] - minY) / height, 0)
			table.insert(frameElements, createElement("Frame", frameProps))
		end
	end
	if self.props.labels then
		for i, v in ipairs(self.props.labels) do
			local frameProps = {
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = v[1]
			}
			frameProps.TextColor3 = self.props.labelColor or Color3.new(255/255, 255/255, 255/255)
			frameProps.Position = UDim2.new((v[2] - minX) / width, 0, 1 - (v[3] - minY) / height, 0)
			table.insert(frameElements, createElement("TextLabel", frameProps))
		end
	end
	return createElement("Frame", {
		BorderSizePixel = 1,
		BorderColor3 = Color3.new(255/255, 255/255, 255/255),
		BackgroundColor3 = Color3.fromRGB(20, 20, 20),
		BackgroundTransparency = self.props.backgroundTransparency,
		Size = self.props.size,
		Position = self.props.position,
		ZIndex = self.props.zIndex,
		[Roact.Change.AbsoluteSize] = function(sizeContainer)
			self:CalculateAspectRatio(sizeContainer)
		end
	}, frameElements)
end
return v2
