local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local Eyelids = Roact.PureComponent:extend("Eyelids")
function Eyelids.init(self)
	self.maid = Maid.new()
end
function Eyelids.render(self)
	local frameSizeSignal = self.props.pctClosed:map(function(percentClosed)
		return UDim2.new(1, 0, percentClosed / 2, 0)
	end)
	return createElement("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1
	}, {
		Top = createElement("Frame", {
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.new(0.5, 0, 0, 0),
			Size = frameSizeSignal,
			BorderSizePixel = 0
		}),
		Bottom = createElement("Frame", {
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			AnchorPoint = Vector2.new(0.5, 1),
			Position = UDim2.new(0.5, 0, 1, 0),
			Size = frameSizeSignal,
			BorderSizePixel = 0
		})
	})
end
function Eyelids.didMount(self)  end
function Eyelids.willUnmount(self)
	self.maid:DoCleaning()
end
return Eyelids
