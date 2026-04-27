local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local Utils = require(ReplicatedStorage.EzUi.Utils)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
require(ReplicatedStorage.Glicko2.Glicko2Consts)
require(ReplicatedStorage.EzUi.Dictionary)
require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local PersistentCrewBattleUtils = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleUtils)
local Elapsed = require(ReplicatedStorage.PersistentCrewBattle.UI.Elapsed)
local BattleCrewInfo = require(ReplicatedStorage.PersistentCrewBattle.UI.BattleCrewInfo)
local Welcome = require(ReplicatedStorage.PersistentCrewBattle.UI.Welcome)
local function playClick()
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
			Volume = 0.2
		})
	end
end
local GameModeCrewApp = Roact.PureComponent:extend("PersistentCrewApp")
GameModeCrewApp.defaultProps = {
	size = UDim2.fromScale(0.9, 0.9),
	position = UDim2.fromScale(0.5, 0.5),
	anchorPoint = Vector2.new(0.5, 0.5)
}
function GameModeCrewApp.init(self)
	self.maid = Maid.new()
	self:setState({
		showRequests = false,
		countdownTil = 0,
		countdownVisible = false,
		isSmallScreen = Utils.isSmallScreen()
	})
	self.maid:GiveTask(Utils.getViewportSizeChangedSignal():Connect(function()
		self:setState({
			isSmallScreen = Utils.isSmallScreen()
		})
	end))
	function self.onClickCloseWelcome()
		self:setState({
			welcomeVisible = false
		})
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	function self.onCountdownElapsed(elapsedSeconds)
		if elapsedSeconds < 0 then
			self:setState({
				countdownVisible = false
			})
			self.props.onCountdownFinished()
		end
	end
end
function GameModeCrewApp.render(self)
	local elements = {}
	if self.state.welcomeVisible then
		elements.Welcome = createElement(Welcome, {
			onClickClose = self.onClickCloseWelcome
		})
	end
	local playerTeamId = Players.LocalPlayer:GetAttribute("CrewBattleTeam")
	local teamIds = {}
	for teamId in self.props.clanName do
		table.insert(teamIds, teamId)
	end
	local enemyTeamId = if teamIds[1] == playerTeamId then teamIds[2] else teamIds[1]
	local attackingClanId = self.props.attackingClanId
	local identityColor = Color3.fromRGB(121, 251, 177)
	local enemyColor = Color3.fromRGB(255, 49, 49)
	local penalty = self.props.penalty
	local hasPenalty = penalty ~= nil
	if self.props.isBattleServer then
		local containerProps = {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}
		local containerChildren = {}
		local outerBorderProps = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -48, 1, -48),
			Position = UDim2.fromOffset(24, 24)
		}
		local outerBorderChildren = {}
		local outerStrokeProps = {
			Thickness = 2
		}
		outerStrokeProps.Color = if hasPenalty then identityColor else enemyColor
		outerStrokeProps.Transparency = 0.75
		outerBorderChildren.UIStroke = createElement("UIStroke", outerStrokeProps)
		outerBorderChildren.UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 32)
		})
		containerChildren.BorderOuter = createElement("Frame", outerBorderProps, outerBorderChildren)
		containerChildren.BorderInner = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -84, 1, -84),
			Position = UDim2.fromOffset(42, 42)
		}, {
			UIStroke = createElement("UIStroke", {
				Thickness = 2,
				Color = identityColor,
				Transparency = 0.5
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 32)
			})
		})
		elements.Container = createElement("Frame", containerProps, containerChildren)
		elements.Penalty = hasPenalty and createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 0, 16),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0, 23),
			ZIndex = 3
		}, {
			Timer = createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundColor3 = identityColor,
				Size = UDim2.fromScale(0.1, 1),
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.fromScale(0.5, 0)
			}, {
				UICorners = createElement("UICorner", {
					CornerRadius = UDim.new(0.25, 0)
				}),
				Text = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Font = Enum.Font.FredokaOne,
					Text = penalty,
					LineHeight = 1,
					TextScaled = true,
					TextColor3 = Color3.new(255/255, 255/255, 255/255)
				})
			})
		})
		local topBarProps = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 0, 24),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0, 41),
			ZIndex = 3
		}
		local topBarChildren = {}
		local timerFrameProps = {
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
			Size = UDim2.fromScale(0.125, 1.5),
			AnchorPoint = Vector2.new(0.5, 0.25),
			Position = UDim2.fromScale(0.5, 0.5)
		}
		local timerFrameChildren = {
			UIStroke = createElement("UIStroke", {
				Thickness = 2,
				Color = identityColor,
				Transparency = 0.5
			}),
			UICorners = createElement("UICorner", {
				CornerRadius = UDim.new(0.25, 0)
			})
		}
		local timerElapsedProps = {
			font = Enum.Font.FredokaOne,
			position = UDim2.fromScale(0.5, 0.5),
			textColor = ColorUtils.saturateBy(identityColor, 0.8),
			createdAt = self.props.startedAt[attackingClanId],
			elapsed = self.props.timeTook[attackingClanId]
		}
		timerElapsedProps.disabled = self.props.startedAt[attackingClanId] == nil
		timerFrameChildren.ElapsedContainer = createElement(Elapsed, timerElapsedProps)
		topBarChildren.Timer = createElement("Frame", timerFrameProps, timerFrameChildren)
		local playerCrewProps = {
			clanName = self.props.clanName[playerTeamId],
			backgroundColor = identityColor,
			size = UDim2.fromScale(0.4, 1),
			position = UDim2.fromScale(0, 0.5),
			anchorPoint = Vector2.new(0, 0.5),
			createdAt = self.props.startedAt[playerTeamId]
		}
		playerCrewProps.elapsed = if self.props.startedAt[playerTeamId] == nil then 0 else self.props.timeTook[playerTeamId]
		playerCrewProps.disabled = self.props.startedAt[playerTeamId] == nil
		playerCrewProps.attacking = playerTeamId == attackingClanId
		playerCrewProps.robberiesCompleted = self.props.robberiesCompleted
		topBarChildren.CrewOurs = createElement(BattleCrewInfo, playerCrewProps)
		local enemyCrewProps = {
			clanName = self.props.clanName[enemyTeamId],
			backgroundColor = enemyColor,
			size = UDim2.fromScale(0.4, 1),
			position = UDim2.fromScale(1, 0.5),
			anchorPoint = Vector2.new(1, 0.5),
			createdAt = self.props.startedAt[enemyTeamId]
		}
		enemyCrewProps.elapsed = if self.props.startedAt[enemyTeamId] == nil then 0 else self.props.timeTook[enemyTeamId]
		enemyCrewProps.disabled = self.props.startedAt[enemyTeamId] == nil
		enemyCrewProps.attacking = enemyTeamId == attackingClanId
		enemyCrewProps.robberiesCompleted = self.props.robberiesCompleted
		topBarChildren.CrewTheirs = createElement(BattleCrewInfo, enemyCrewProps, {
			Report = false
		})
		elements.TopBar = createElement("Frame", topBarProps, topBarChildren)
		if self.state.countdownVisible then
			elements.Countdown = createElement(Elapsed, {
				createdAt = self.state.countdownTil,
				countDown = true,
				onElapsed = self.onCountdownElapsed,
				textColor = Color3.new(51/255, 51/255, 51/255),
				alwaysShowMinutes = false
			}, {
				UIStroke = createElement("UIStroke", {
					Thickness = 2,
					Color = Color3.fromRGB(255, 215, 0)
				})
			})
		end
	end
	return Roact.createFragment(elements)
end
function GameModeCrewApp.didMount(self)
	self:_updateWelcomeVisible()
	local function updateCountdown()
		local roundStartTime = PersistentCrewBattleUtils.getRoundStartsAt()
		if roundStartTime and workspace:GetServerTimeNow() < roundStartTime then
			self:setState({
				countdownVisible = true,
				countdownTil = roundStartTime
			})
		end
	end
	self.maid:GiveTask(PersistentCrewBattleUtils.getRoundStartsAtAttributeChangedSignal():Connect(updateCountdown))
	updateCountdown()
end
function GameModeCrewApp._updateWelcomeVisible(self)
	if self.props.isBattleServer then
		self:setState({
			welcomeVisible = true
		})
	end
end
function GameModeCrewApp.didUpdate(self, prevProps, param3)
	if self.props.isBattleServer ~= prevProps.isBattleServer then
		self:_updateWelcomeVisible()
	end
end
function GameModeCrewApp.willUnmount(self)
	self.maid:DoCleaning()
end
return RoactRodux.connect(function(state, self)
	return {
		timeTook = state.timeTook,
		startedAt = state.startedAt,
		isBattleServer = state.isBattleServer,
		clanName = state.clanName,
		networkMutexLocked = state.networkMutexLocked,
		robberiesCompleted = state.robberiesCompleted,
		attackingClanId = state.attackingClanId,
		battleResponseData = state.battleResponseData,
		penalty = state.penalty
	}
end, function(dispatch)
	return {
		onClickClose = function()
			dispatch({
				type = "setGroupVisible",
				value = false
			})
			if Players.LocalPlayer.PlayerGui then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
					Volume = 0.2
				})
			end
		end,
		onClickViewMe = function()
			dispatch({
				type = "setMembers",
				value = {}
			})
			dispatch({
				type = "setViewingClanInfo",
				value = nil
			})
		end
	}
end)(GameModeCrewApp)
