local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("Eyelids")
function v1.init(p1) --[[ Line: 7 | Upvalues: Maid (copy) ]]
	p1.maid = Maid.new()
end
function v1.render(p1) --[[ Line: 10 | Upvalues: createElement (copy) ]]
	local v1 = p1.props.pctClosed:map(function(p1) --[[ Line: 11 ]]
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
			Size = v1,
			BorderSizePixel = 0
		}),
		Bottom = createElement("Frame", {
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			AnchorPoint = Vector2.new(0.5, 1),
			Position = UDim2.new(0.5, 0, 1, 0),
			Size = v1,
			BorderSizePixel = 0
		})
	})
end
function v1.didMount(p1) --[[ Line: 34 ]] end
function v1.willUnmount(p1) --[[ Line: 35 ]]
	p1.maid:DoCleaning()
end
return v1