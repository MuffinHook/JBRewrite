local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local TypeWriteLabel = require(ReplicatedStorage.Game.TypeWriteLabel)
local createElement = Roact.createElement
local Subtitle = Roact.PureComponent:extend("Subtitle")
Subtitle.defaultProps = {
	charPerSecond = 25,
	fontFace = Font.fromName("Merriweather", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
}
function Subtitle.init(self)
	self.maid = Maid.new()
	self.labelRef = Roact.createRef()
end
function Subtitle.render(self)
	return createElement("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1
	}, {
		Label = createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.8, 0, 0.1, 0),
			AnchorPoint = Vector2.new(0.5, 1),
			Position = UDim2.new(0.5, 0, 0.8, 0),
			Text = "",
			TextStrokeTransparency = 0.8,
			TextStrokeColor3 = Color3.new(0/255, 0/255, 0/255),
			FontFace = self.props.fontFace,
			TextSize = 20,
			TextColor3 = Color3.new(255/255, 255/255, 255/255),
			TextWrapped = true,
			[Roact.Ref] = self.labelRef
		})
	})
end
function Subtitle._write(self)
	self.maid.typewrite = TypeWriteLabel(self.props.text, self.labelRef:getValue(), self.props.charPerSecond, self.props.maxVisibleGraphemeCallback)
end
function Subtitle.didMount(self)
	self:_write()
end
function Subtitle.didUpdate(self, oldProps, oldState)
	if self.props.text ~= oldProps.text then
		self:_write()
	end
end
function Subtitle.willUnmount(self)
	self.maid:DoCleaning()
end
return Subtitle
