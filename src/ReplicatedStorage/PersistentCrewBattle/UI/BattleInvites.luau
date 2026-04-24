-- Reviewed by Claude
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
local v1 = Roact.PureComponent:extend("BattleInvites")
v1.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	aspectRatio = 1.25,
	maximumItemsDisplayed = 4
}
function v1.init(p1)
	function p1.onAccept(p12)
		local v1 = p1.props.battleInvites[p12]
		p1.props.removeByIndex(p12)
		if Players.LocalPlayer and Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
		if p1.props.onAccept then
			p1.props.onAccept(v1)
		end
	end
	function p1.onDecline(p12)
		local v1 = p1.props.battleInvites[p12]
		p1.props.removeByIndex(p12)
		if Players.LocalPlayer and Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
		if p1.props.onDecline then
			p1.props.onDecline(v1)
		end
	end
end
function v1.render(p1)
	local v1 = 1 / (1 / p1.props.maximumItemsDisplayed - 1 / (256 / p1.props.maximumItemsDisplayed)) * p1.props.aspectRatio
	local v2 = p1.props.maximumItemsDisplayed * p1.props.aspectRatio
	local v3 = #p1.props.battleInvites
	local t = {}
	for i = 1, math.min(v3, p1.props.maximumItemsDisplayed) do
		local v4 = v3 - i + 1
		t[i] = createElement(BattleInvite, Dictionary.merge({
			aspectRatio = v1,
			position = UDim2.new(0, 0, 1 + (i - v3 - 1) / v2 * p1.props.aspectRatio, 0),
			index = v4,
			onAccept = p1.onAccept,
			onDecline = p1.onDecline
		}, p1.props.battleInvites[v4]))
	end
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = p1.props.size,
		Position = p1.props.position,
		AnchorPoint = p1.props.anchorPoint
	}, Dictionary.merge({
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = p1.props.aspectRatio
		})
	}, t))
end
return RoactRodux.connect(function(p1, p2)
	return {
		battleInvites = p1.battleInvites
	}
end, function(p1)
	return {
		removeByIndex = function(p12)
			p1({
				type = "battleInvitesRemoveByIndex",
				index = p12
			})
		end
	}
end)(v1)
