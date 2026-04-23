local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local TypeWriteLabel = require(ReplicatedStorage.Game.TypeWriteLabel)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("Subtitle")
v1.defaultProps = {
	charPerSecond = 25,
	fontFace = Font.fromName("Merriweather", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
}
function v1.init(p1) --[[ Line: 12 | Upvalues: Maid (copy), Roact (copy) ]]
	p1.maid = Maid.new()
	p1.labelRef = Roact.createRef()
end
function v1.render(p1) --[[ Line: 16 | Upvalues: createElement (copy), Roact (copy) ]]
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
			FontFace = p1.props.fontFace,
			TextSize = 20,
			TextColor3 = Color3.new(255/255, 255/255, 255/255),
			TextWrapped = true,
			[Roact.Ref] = p1.labelRef
		})
	})
end
function v1._write(p1) --[[ Line: 37 | Upvalues: TypeWriteLabel (copy) ]]
	p1.maid.typewrite = TypeWriteLabel(p1.props.text, p1.labelRef:getValue(), p1.props.charPerSecond, p1.props.maxVisibleGraphemeCallback)
end
function v1.didMount(p1) --[[ Line: 45 ]]
	p1:_write()
end
function v1.didUpdate(p1, p2, p3) --[[ Line: 48 ]]
	if p1.props.text ~= p2.text then
		p1:_write()
	end
end
function v1.willUnmount(p1) --[[ Line: 53 ]]
	p1.maid:DoCleaning()
end
return v1