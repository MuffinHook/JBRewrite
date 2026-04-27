local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local PersistentCrewBattleConsts = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local paddedScrollingGrid = require(ReplicatedStorage.Safes.UI.paddedScrollingGrid)
local ClanRating = require(ReplicatedStorage.PersistentCrewBattle.UI.ClanRating)
local CrewLeaderboard = Roact.PureComponent:extend("CrewLeaderboard")
CrewLeaderboard.defaultProps = {
	verticalPaddingRatio = 96,
	aspectRatio = 1.7777777777777777
}
function CrewLeaderboard.render(self)
	assert(self.props.displayType, "No display type set")
	local uiElements = {}
	local headerText = nil
	local rowsPerPage = nil
	if self.props.displayType == PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM.Leaderboard then
		headerText = "CREW BATTLES LEADERBOARD"
		rowsPerPage = 7.5
	elseif self.props.displayType == PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM.CrewsInServer then
		assert(self.props.attemptViewClanId, "No attemptViewClanId function set")
		local shouldShowCrewView = true
		headerText = "CREWS IN SERVER"
		rowsPerPage = 7.5
		for clanIndex, clanData in self.props.leaderboardInfo do
			clanData.attemptViewClanId = self.props.attemptViewClanId
			clanData.showCrewView = shouldShowCrewView
		end
	else
		local throwError = error
		throwError("Invalid display type: " .. tostring(self.props.displayType))
	end
	uiElements.Header = createElement(PaddedContainer, {
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
				Text = headerText,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = Color3.fromRGB(255, 169, 0)
			})
		})
	})
	uiElements.Body = createElement(PaddedContainer, {
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
			rowsPerPage = rowsPerPage,
			colsPerRow = 1,
			component = ClanRating,
			items = self.props.leaderboardInfo
		})
	})
	return createElement(PaddedContainer, {
		backgroundTransparency = 1,
		backgroundColor = Color3.new(255/255, 255/255, 255/255),
		aspectRatio = self.props.aspectRatio,
		verticalPaddingRatio = self.props.verticalPaddingRatio
	}, uiElements)
end
return CrewLeaderboard
