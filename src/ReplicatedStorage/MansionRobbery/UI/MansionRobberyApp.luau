local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local Eyelids = require(script.Parent.Eyelids)
local Subtitle = require(script.Parent.Subtitle)
local MansionRobberyAppComponent = Roact.PureComponent:extend("App")
function MansionRobberyAppComponent.init(self)
	self.maid = Maid.new()
end
function MansionRobberyAppComponent.render(self)
	return Roact.createFragment({
		Eyelids = createElement(Eyelids, {
			pctClosed = self.props.pctClosed
		}),
		Subtitle = createElement(Subtitle, {
			text = self.props.dialogueText,
			charPerSecond = self.props.charPerSecond
		})
	})
end
function MansionRobberyAppComponent.didMount(self)  end
function MansionRobberyAppComponent.willUnmount(self)
	self.maid:DoCleaning()
end
return RoactRodux.connect(function(stateData, dispatch)
	return {
		dialogueText = stateData.dialogueText
	}
end)(MansionRobberyAppComponent)
