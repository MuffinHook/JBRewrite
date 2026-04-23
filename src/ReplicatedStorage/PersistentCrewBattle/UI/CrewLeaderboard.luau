local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local PersistentCrewBattleConsts = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local paddedScrollingGrid = require(ReplicatedStorage.Safes.UI.paddedScrollingGrid)
local ClanRating = require(ReplicatedStorage.PersistentCrewBattle.UI.ClanRating)
local v1 = Roact.PureComponent:extend("CrewLeaderboard")
v1.defaultProps = {
	verticalPaddingRatio = 96,
	aspectRatio = 1.7777777777777777
}
function v1.render(p1) --[[ Line: 15 | Upvalues: PersistentCrewBattleConsts (copy), createElement (copy), PaddedContainer (copy), paddedScrollingGrid (copy), ClanRating (copy) ]]
	assert(p1.props.displayType, "No display type set")
	local t = {}
	local v1 = nil
	local v2 = nil
	if p1.props.displayType == PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM.Leaderboard then
		v1 = "CREW BATTLES LEADERBOARD"
		v2 = 7.5
	elseif p1.props.displayType == PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM.CrewsInServer then
		assert(p1.props.attemptViewClanId, "No attemptViewClanId function set")
		local v3 = true
		v1 = "CREWS IN SERVER"
		v2 = 7.5
		for v4, v5 in p1.props.leaderboardInfo do
			v5.attemptViewClanId = p1.props.attemptViewClanId
			v5.showCrewView = v3
		end
	else
		local v6 = error
		v6("Invalid display type: " .. tostring(p1.props.displayType))
	end
	t.Header = createElement(PaddedContainer, {
		backgroundColor = Color3.fromRGB(57, 58, 65),
		backgroundTransparency = 0,
		size = UDim2.new(1, 0, 0.1111111111111111, 0),
		paddingTop = 0,
		paddingBottom = 0.5,
		paddingLeft = 0,
		paddingRight = 0
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		TitleContainer = createElement(PaddedContainer, {
			backgroundTransparency = 1,
			size = UDim2.new(0.7, 0, 1, 0)
		}, {
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Font = Enum.Font.FredokaOne,
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = v1,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = Color3.fromRGB(255, 169, 0)
			})
		})
	})
	t.Body = createElement(PaddedContainer, {
		backgroundColor = Color3.new(51/255, 51/255, 51/255),
		backgroundTransparency = 0,
		position = UDim2.new(0, 0, 0.1111111111111111, 0),
		size = UDim2.new(1, 0, 0.8888888888888888, 0),
		paddingTop = 0.5,
		paddingBottom = 0,
		paddingLeft = 0,
		paddingRight = 0
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Scrolling = createElement(paddedScrollingGrid, {
			exposePaddedContainerProps = true,
			rowsPerPage = v2,
			colsPerRow = 1,
			component = ClanRating,
			items = p1.props.leaderboardInfo
		})
	})
	return createElement(PaddedContainer, {
		backgroundTransparency = 1,
		backgroundColor = Color3.new(255/255, 255/255, 255/255),
		aspectRatio = p1.props.aspectRatio,
		verticalPaddingRatio = p1.props.verticalPaddingRatio
	}, t)
end
return v1