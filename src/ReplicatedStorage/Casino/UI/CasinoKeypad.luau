-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Interval = require(ReplicatedStorage.Std.Interval)
local Maid = require(ReplicatedStorage.Std.Maid)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local createElement = Roact.createElement
local Keypad = require(ReplicatedStorage.App.UI.Keypad)
local CasinoKeypadComponent = Roact.PureComponent:extend("CasinoKeypad")
CasinoKeypadComponent.defaultProps = {
	expireDistance = 16
}
function CasinoKeypadComponent.init(self)
	self.maid = Maid.new()
end
function CasinoKeypadComponent.render(self)
	if self.props.keypadVisible then
		return createElement(Keypad, {
			title = "Search around the room...",
			size = UDim2.new(0.5, 0, 0.5, 0),
			onSubmit = function(...)
				self.props.keypadCallback(...)
				self.props.onClickClose()
			end,
			onClickClose = self.props.onClickClose
		})
	end
end
function CasinoKeypadComponent.didUpdate(self, previousProps)
	if self.props.keypadVisible ~= previousProps.keypadVisible then
		if self.props.keypadVisible then
			if self.props.expireDistance then
				local rootPart = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
				if rootPart then
					local initialPosition = rootPart.Position
					self.maid.expireDistCheck = Interval.every(1):Connect(function()
						rootPart = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
						if rootPart then
							if (rootPart.Position - initialPosition).Magnitude > self.props.expireDistance then
								self.props.onClickClose()
							end
						else
							self.props.onClickClose()
						end
					end)
				end
			end
		else
			self.maid.expireDistCheck = nil
		end
	end
end
function CasinoKeypadComponent.willUnmount(self)
	self.maid:DoCleaning()
end
return RoactRodux.connect(function(state, dispatch)
	return {
		keypadVisible = state.casinoKeypadVisible,
		keypadCallback = state.casinoKeypadCallback
	}
end, function(dispatch)
	return {
		onClickClose = function()
			dispatch({
				type = "setCasinoKeypadVisible",
				visible = false
			})
		end
	}
end)(CasinoKeypadComponent)