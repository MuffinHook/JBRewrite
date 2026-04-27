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
local BattleInvitesComponent = Roact.PureComponent:extend("BattleInvites")
BattleInvitesComponent.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	aspectRatio = 1.25,
	maximumItemsDisplayed = 4
}
function BattleInvitesComponent.init(self)
	function self.onAccept(inviteIndex)
		local inviteData = self.props.battleInvites[inviteIndex]
		self.props.removeByIndex(inviteIndex)
		if Players.LocalPlayer and Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
		if self.props.onAccept then
			self.props.onAccept(inviteData)
		end
	end
	function self.onDecline(inviteIndex)
		local inviteData = self.props.battleInvites[inviteIndex]
		self.props.removeByIndex(inviteIndex)
		if Players.LocalPlayer and Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
		if self.props.onDecline then
			self.props.onDecline(inviteData)
		end
	end
end
function BattleInvitesComponent.render(self)
	local itemAspectRatio = 1 / (1 / self.props.maximumItemsDisplayed - 1 / (256 / self.props.maximumItemsDisplayed)) * self.props.aspectRatio
	local verticalSpacing = self.props.maximumItemsDisplayed * self.props.aspectRatio
	local totalInvites = #self.props.battleInvites
	local inviteElements = {}
	for i = 1, math.min(totalInvites, self.props.maximumItemsDisplayed) do
		local reversedIndex = totalInvites - i + 1
		inviteElements[i] = createElement(BattleInvite, Dictionary.merge({
			aspectRatio = itemAspectRatio,
			position = UDim2.new(0, 0, 1 + (i - totalInvites - 1) / verticalSpacing * self.props.aspectRatio, 0),
			index = reversedIndex,
			onAccept = self.onAccept,
			onDecline = self.onDecline
		}, self.props.battleInvites[reversedIndex]))
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
	}, inviteElements))
end
return RoactRodux.connect(function(self, state)
	return {
		battleInvites = self.battleInvites
	}
end, function(self)
	return {
		removeByIndex = function(inviteIndex)
			self({
				type = "battleInvitesRemoveByIndex",
				index = inviteIndex
			})
		end
	}
end)(BattleInvitesComponent)
