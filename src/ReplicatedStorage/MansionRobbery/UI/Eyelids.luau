-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local func = Roact.PureComponent:extend("Eyelids")
function func.init(p1)
	p1.maid = Maid.new()
end
function func.render(p1)
	local func = p1.props.pctClosed:map(function(p1)
		return UDim2.new(1, 0, p1 / 2, 0)
	end)
	return createElement("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1
	}, {
		Top = createElement("Frame", {
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.new(0.5, 0, 0, 0),
			Size = func,
			BorderSizePixel = 0
		}),
		Bottom = createElement("Frame", {
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			AnchorPoint = Vector2.new(0.5, 1),
			Position = UDim2.new(0.5, 0, 1, 0),
			Size = func,
			BorderSizePixel = 0
		})
	})
end
function func.didMount(p1)  end
function func.willUnmount(p1)
	p1.maid:DoCleaning()
end
return func
