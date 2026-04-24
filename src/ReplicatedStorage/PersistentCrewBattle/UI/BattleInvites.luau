-- Reviewed by Claude
-- variables reassigned
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local BattleInvite = require(script.Parent.BattleInvite)
local function playTick()
	if Players.LocalPlayer and Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
			Volume = 0.15
		})
	end
end
local constant = Roact.PureComponent:extend("BattleInvites")
constant.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	aspectRatio = 1.25,
	maximumItemsDisplayed = 4
}
function constant.init(self)
	function self.onAccept(arg12)
		local constant = self.props.battleInvites[arg12]
		self.props.removeByIndex(arg12)
		if Players.LocalPlayer and Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
		if self.props.onAccept then
			self.props.onAccept(constant)
		end
	end
	function self.onDecline(arg12)
		local constant = self.props.battleInvites[arg12]
		self.props.removeByIndex(arg12)
		if Players.LocalPlayer and Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
		if self.props.onDecline then
			self.props.onDecline(constant)
		end
	end
end
function constant.render(self)
	local constant = 1 / (1 / self.props.maximumItemsDisplayed - 1 / (256 / self.props.maximumItemsDisplayed)) * self.props.aspectRatio
	local local2 = self.props.maximumItemsDisplayed * self.props.aspectRatio
	local local3 = #self.props.battleInvites
	local t = {}
	for i = 1, math.min(local3, self.props.maximumItemsDisplayed) do
		local local4 = local3 - i + 1
		t[i] = createElement(BattleInvite, Dictionary.merge({
			aspectRatio = constant,
			position = UDim2.new(0, 0, 1 + (i - local3 - 1) / local2 * self.props.aspectRatio, 0),
			index = local4,
			onAccept = self.onAccept,
			onDecline = self.onDecline
		}, self.props.battleInvites[local4]))
	end
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = self.props.size,
		Position = self.props.position,
		AnchorPoint = self.props.anchorPoint
	}, Dictionary.merge({
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = self.props.aspectRatio
		})
	}, t))
end
return RoactRodux.connect(function(self, arg2)
	return {
		battleInvites = self.battleInvites
	}
end, function(self)
	return {
		removeByIndex = function(arg12)
			self({
				type = "battleInvitesRemoveByIndex",
				index = arg12
			})
		end
	}
end)(constant)
