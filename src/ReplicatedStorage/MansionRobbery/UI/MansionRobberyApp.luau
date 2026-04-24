-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local Eyelids = require(script.Parent.Eyelids)
local Subtitle = require(script.Parent.Subtitle)
local v1 = Roact.PureComponent:extend("App")
function v1.init(p1)
	p1.maid = Maid.new()
end
function v1.render(p1)
	return Roact.createFragment({
		Eyelids = createElement(Eyelids, {
			pctClosed = p1.props.pctClosed
		}),
		Subtitle = createElement(Subtitle, {
			text = p1.props.dialogueText,
			charPerSecond = p1.props.charPerSecond
		})
	})
end
function v1.didMount(p1)  end
function v1.willUnmount(p1)
	p1.maid:DoCleaning()
end
return RoactRodux.connect(function(p1, p2)
	return {
		dialogueText = p1.dialogueText
	}
end)(v1)
