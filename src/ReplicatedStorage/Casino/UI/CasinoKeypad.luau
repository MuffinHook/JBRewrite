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
local v1 = Roact.PureComponent:extend("CasinoKeypad")
v1.defaultProps = {
	expireDistance = 16
}
function v1.init(p1)
	p1.maid = Maid.new()
end
function v1.render(p1)
	if p1.props.keypadVisible then
		return createElement(Keypad, {
			title = "Search around the room...",
			size = UDim2.new(0.5, 0, 0.5, 0),
			onSubmit = function(...)
				p1.props.keypadCallback(...)
				p1.props.onClickClose()
			end,
			onClickClose = p1.props.onClickClose
		})
	end
end
function v1.didUpdate(p1, p2)
	if p1.props.keypadVisible ~= p2.keypadVisible then
		if p1.props.keypadVisible then
			if p1.props.expireDistance then
				local v1 = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
				if v1 then
					local Position = v1.Position
					p1.maid.expireDistCheck = Interval.every(1):Connect(function()
						v1 = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
						if v1 then
							if (v1.Position - Position).Magnitude > p1.props.expireDistance then
								p1.props.onClickClose()
							end
						else
							p1.props.onClickClose()
						end
					end)
				end
			end
		else
			p1.maid.expireDistCheck = nil
		end
	end
end
function v1.willUnmount(p1)
	p1.maid:DoCleaning()
end
return RoactRodux.connect(function(p1, p2)
	return {
		keypadVisible = p1.casinoKeypadVisible,
		keypadCallback = p1.casinoKeypadCallback
	}
end, function(p1)
	return {
		onClickClose = function()
			p1({
				type = "setCasinoKeypadVisible",
				visible = false
			})
		end
	}
end)(v1)