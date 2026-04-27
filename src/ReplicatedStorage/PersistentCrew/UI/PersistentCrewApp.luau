local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local Utils = require(ReplicatedStorage.EzUi.Utils)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local Glicko2Consts = require(ReplicatedStorage.Glicko2.Glicko2Consts)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local PersistentCrewBattleUtils = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleUtils)
local JoinOrCreate = require(script.Parent.JoinOrCreate)
local Info = require(script.Parent.Info)
local BattleInvites = require(ReplicatedStorage.PersistentCrewBattle.UI.BattleInvites)
local Elapsed = require(ReplicatedStorage.PersistentCrewBattle.UI.Elapsed)
local BattleCrewInfo = require(ReplicatedStorage.PersistentCrewBattle.UI.BattleCrewInfo)
local ReportCrew = require(ReplicatedStorage.PersistentCrewBattle.UI.ReportCrew)
local Welcome = require(ReplicatedStorage.PersistentCrewBattle.UI.Welcome)
local Responses = require(ReplicatedStorage.PersistentCrewBattle.UI.Responses)
local function playClick()
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
			Volume = 0.2
		})
	end
end
local PersistentCrewAppComponent = Roact.PureComponent:extend("PersistentCrewApp")
PersistentCrewAppComponent.defaultProps = {
	size = UDim2.fromScale(0.9, 0.9),
	position = UDim2.fromScale(0.5, 0.5),
	anchorPoint = Vector2.new(0.5, 0.5)
}
function PersistentCrewAppComponent.init(self)
	self.maid = Maid.new()
	function self.onClickAdmin(self)
		self.props.attemptAdmin(self.userId)
	end
	function self.onClickRenameCrew(self)
		self.props.attemptRenameCrew(self)
	end
	function self.onClickUnAdmin(self)
		self.props.attemptUnAdmin(self.userId)
	end
	function self.onClickKick(self)
		self.props.attemptKick(self.userId)
	end
	function self.onClickJoinRequestAccept(self)
		self.props.onClickJoinRequestAccept(self.userId)
	end
	function self.onClickJoinRequestDeny(self)
		self.props.onClickJoinRequestDeny(self.userId)
	end
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
	function self.onClickToggleRequests()
		self:setState({
			showRequests = not self.state.showRequests
		})
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
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
	function self.onClickViewMe()
		self.props.attemptViewUserIdClan(Players.LocalPlayer.UserId)
		self.props.onClickViewMe()
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	function self.onCountdownElapsed(self)
		if self < 0 then
			self:setState({
				countdownVisible = false
			})
			self.props.onCountdownFinished()
		end
	end
	function self.onReportDialogClose()
		self:setState({
			reportDialogVisible = false
		})
	end
	function self.onReportDialogSubmit(component, reportData)
		component.props.attemptReportCrew(reportData, reportData)
	end
end
function PersistentCrewAppComponent.render(self)
	local currentClanInfo = self.props.currentClanInfo
	local targetClanInfo = self.props.viewingClanInfo or currentClanInfo
	local children = {}
	if self.props.groupVisible then
		local crewElements = {}
		local contentSize, contentPosition
		if targetClanInfo then
			local localPlayer = if Players.LocalPlayer then Players.LocalPlayer.UserId else -1
			local crewContainerSize = UDim2.fromScale(1, 0.5)
			local responseAdjustedPosition = UDim2.fromScale(0.5, 0.5 - if self.props.battleResponseData == nil then 0 else 0.1)
			local crewInfoProps = {
				aspectRatio = 1.7777777777777777,
				verticalPaddingRatio = 128,
				clanId = targetClanInfo.ClanId,
				playersClanId = targetClanInfo.PlayersClanId
			}
			local isPlayersClan
			if targetClanInfo.PlayersClanId == targetClanInfo.ClanId then
				isPlayersClan = true
				contentSize = crewContainerSize
			else
				isPlayersClan = false
				contentSize = crewContainerSize
			end
			crewInfoProps.isPlayersClan = isPlayersClan
			crewInfoProps.leaderboardRank = targetClanInfo.LeaderboardRank
			local isAdminOfViewingClan
			if targetClanInfo.AdminIdMap[tostring(localPlayer)] == true then
				isAdminOfViewingClan = true
				contentPosition = responseAdjustedPosition
			else
				isAdminOfViewingClan = false
				contentPosition = responseAdjustedPosition
			end
			crewInfoProps.isAdminOfViewingClan = isAdminOfViewingClan
			crewInfoProps.isAdminOfCurrentClan = currentClanInfo and currentClanInfo.AdminIdMap[tostring(localPlayer)] == true
			crewInfoProps.battlesPlayed = targetClanInfo.BattlesPlayed or 0
			crewInfoProps.battlesWon = targetClanInfo.BattlesWon or 0
			crewInfoProps.attemptLeave = self.props.attemptLeave
			crewInfoProps.clanOwnerUserId = targetClanInfo.OwnerUserId
			crewInfoProps.clanName = targetClanInfo.ClanName
			crewInfoProps.clanDisplayRating = targetClanInfo.DisplayRating or Glicko2Consts.DEFAULT_MU
			crewInfoProps.flagColor = targetClanInfo.FlagColor
			crewInfoProps.membersOnlineMap = self.props.membersOnlineMap
			crewInfoProps.showRequests = self.state.showRequests
			crewInfoProps.members = self.props.members
			crewInfoProps.joinRequests = self.props.joinRequests
			crewInfoProps.isReadiedUp = self.props.isReadiedUp
			crewInfoProps.playerHasAcceptedInvite = self.props.battleResponseData ~= nil
			crewInfoProps.playerDisplayRating = targetClanInfo.PlayerDisplayRating
			crewInfoProps.attemptBattleClanId = self.props.attemptBattleClanId
			crewInfoProps.attemptViewUserIdClan = self.props.attemptViewUserIdClan
			crewInfoProps.onClickAdmin = self.onClickAdmin
			crewInfoProps.onClickRenameCrew = self.onClickRenameCrew
			crewInfoProps.onClickUnAdmin = self.onClickUnAdmin
			crewInfoProps.onClickKick = self.onClickKick
			crewInfoProps.onClickJoinRequestAccept = self.onClickJoinRequestAccept
			crewInfoProps.onClickJoinRequestDeny = self.onClickJoinRequestDeny
			crewInfoProps.onClickToggleRequests = self.onClickToggleRequests
			crewInfoProps.attemptRequestJoinUserId = self.props.attemptRequestJoinUserId
			crewInfoProps.onClickReadyUp = self.props.onClickReadyUp
			crewInfoProps.onClickUnreadyUp = self.props.onClickUnreadyUp
			crewInfoProps.networkMutexLocked = self.props.networkMutexLocked
			crewInfoProps.onClickViewMe = self.onClickViewMe
			crewInfoProps.onClickClose = self.props.onClickClose
			crewElements.Crew = createElement(Info, crewInfoProps)
		else
			local joinCreateSize = UDim2.fromScale(1, 0.35)
			local joinCreatePosition = UDim2.fromScale(0.5, 0.5)
			crewElements.JoinOrCreate = createElement(JoinOrCreate, {
				aspectRatio = 1.7777777777777777,
				verticalPaddingRatio = 128,
				attemptCreate = self.props.attemptCreate,
				attemptViewUserIdClan = self.props.attemptViewUserIdClan,
				networkMutexLocked = self.props.networkMutexLocked,
				onClickClose = self.props.onClickClose
			})
			contentSize = joinCreateSize
			contentPosition = joinCreatePosition
		end
		children.Group = createElement("Frame", {
			BackgroundTransparency = 0.8,
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			Size = contentSize,
			Position = contentPosition,
			AnchorPoint = self.props.anchorPoint
		}, Dictionary.merge({
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1.7777777777777777
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 8)
			})
		}, crewElements))
	end
	if self.state.welcomeVisible then
		children.Welcome = createElement(Welcome, {
			onClickClose = self.onClickCloseWelcome
		})
	end
	local battleInvitesProps = {
		size = UDim2.new(0.3333333333333333, 0, 0.3333333333333333, 0)
	}
	battleInvitesProps.position = self.state.isSmallScreen and UDim2.new(0.5, 0, 0.6666666666666666, 0) or UDim2.new(1, 0, 0.5, 0)
	battleInvitesProps.anchorPoint = self.state.isSmallScreen and Vector2.new(0.5, 0.5) or Vector2.new(1, 0.5)
	battleInvitesProps.onAccept = self.props.onAcceptBattleInvite
	battleInvitesProps.onDecline = self.props.onDeclineBattleInvite
	children.BattleInvites = createElement(BattleInvites, battleInvitesProps)
	local playersClanId = targetClanInfo and targetClanInfo.ClanId
	local clanIdList = {}
	for clanId in self.props.clanName do
		table.insert(clanIdList, clanId)
	end
	local otherClanId = if clanIdList[1] == playersClanId then clanIdList[2] else clanIdList[1]
	local attackingClanId = self.props.attackingClanId
	local identityColor = Color3.fromRGB(121, 251, 177)
	local identityColor = Color3.fromRGB(255, 49, 49)
	local penalty = self.props.penalty
	local hasPenalty = penalty ~= nil
	if self.props.isBattleServer then
		local containerProps = {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}
		local borderElements = {}
		local borderOuterProps = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -48, 1, -48),
			Position = UDim2.fromOffset(24, 24)
		}
		local borderOuterChildren = {}
		local strokeProps = {
			Thickness = 2
		}
		strokeProps.Color = if hasPenalty then identityColor else identityColor
		strokeProps.Transparency = 0.75
		borderOuterChildren.UIStroke = createElement("UIStroke", strokeProps)
		borderOuterChildren.UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 32)
		})
		borderElements.BorderOuter = createElement("Frame", borderOuterProps, borderOuterChildren)
		borderElements.BorderInner = createElement("Frame", {
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
		children.Container = createElement("Frame", containerProps, borderElements)
		children.Penalty = hasPenalty and createElement("Frame", {
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
		local elapsedProps = {
			font = Enum.Font.FredokaOne,
			position = UDim2.fromScale(0.5, 0.5),
			textColor = ColorUtils.saturateBy(identityColor, 0.8),
			createdAt = self.props.startedAt[attackingClanId],
			elapsed = self.props.timeTook[attackingClanId]
		}
		elapsedProps.disabled = self.props.startedAt[attackingClanId] == nil
		timerFrameChildren.ElapsedContainer = createElement(Elapsed, elapsedProps)
		topBarChildren.Timer = createElement("Frame", timerFrameProps, timerFrameChildren)
		local oursCrewInfoProps = {
			clanName = self.props.clanName[playersClanId],
			backgroundColor = identityColor,
			size = UDim2.fromScale(0.4, 1),
			position = UDim2.fromScale(0, 0.5),
			anchorPoint = Vector2.new(0, 0.5),
			createdAt = self.props.startedAt[playersClanId]
		}
		oursCrewInfoProps.elapsed = if self.props.startedAt[playersClanId] == nil then 0 else self.props.timeTook[playersClanId]
		oursCrewInfoProps.disabled = self.props.startedAt[playersClanId] == nil
		oursCrewInfoProps.attacking = playersClanId == attackingClanId
		oursCrewInfoProps.robberiesCompleted = self.props.robberiesCompleted
		topBarChildren.CrewOurs = createElement(BattleCrewInfo, oursCrewInfoProps)
		local theirsCrewInfoProps = {
			clanName = self.props.clanName[otherClanId],
			backgroundColor = identityColor,
			size = UDim2.fromScale(0.4, 1),
			position = UDim2.fromScale(1, 0.5),
			anchorPoint = Vector2.new(1, 0.5),
			createdAt = self.props.startedAt[otherClanId]
		}
		theirsCrewInfoProps.elapsed = if self.props.startedAt[otherClanId] == nil then 0 else self.props.timeTook[otherClanId]
		theirsCrewInfoProps.disabled = self.props.startedAt[otherClanId] == nil
		theirsCrewInfoProps.attacking = otherClanId == attackingClanId
		theirsCrewInfoProps.robberiesCompleted = self.props.robberiesCompleted
		topBarChildren.CrewTheirs = createElement(BattleCrewInfo, theirsCrewInfoProps, {
			Report = createElement("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.new(1, 4, 0, 0)
			}, {
				Image = createElement("ImageButton", {
					BackgroundColor3 = Color3.fromRGB(251, 121, 121),
					Size = UDim2.fromScale(1, 1),
					Image = "rbxassetid://14280463776",
					[Roact.Event.Activated] = function()
						self:setState({
							reportDialogVisible = not self.state.reportDialogVisible
						})
					end
				}, {
					Corner = createElement("UICorner", {
						CornerRadius = UDim.new(0, 4)
					})
				}),
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = 1
				})
			})
		})
		children.TopBar = createElement("Frame", topBarProps, topBarChildren)
		if self.state.countdownVisible then
			children.Countdown = createElement(Elapsed, {
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
		if self.state.reportDialogVisible then
			children.ReportDialog = createElement(ReportCrew, {
				size = UDim2.fromScale(1, 0.45),
				onClose = self.onReportDialogClose,
				onSubmit = self.onReportDialogSubmit
			})
		end
	end
	if self.props.battleResponseData then
		local battleResponseData = self.props.battleResponseData
		local TheirClanInfo = battleResponseData.TheirClanInfo
		local responsesProps = {
			anchorPoint = Vector2.new(0.5, 1),
			position = UDim2.fromScale(0.5, 0.875),
			size = UDim2.fromScale(1, 0.2),
			aspectRatio = 2.8,
			verticalPaddingRatio = 64,
			zIndex = 3,
			numPlayersPerTeam = battleResponseData.NumPlayersPerTeam,
			clanNameOurs = battleResponseData.OurClanInfo.ClanName,
			clanOwnerOurs = battleResponseData.OurClanInfo.OwnerUserId,
			clanColorOurs = Color3.fromHex(battleResponseData.OurClanInfo.FlagColorStr),
			clanMembersOurs = battleResponseData.OurClanAccepted
		}
		responsesProps.clanNameTheirs = if TheirClanInfo then TheirClanInfo.ClanName else nil
		responsesProps.clanOwnerTheirs = if TheirClanInfo then TheirClanInfo.OwnerUserId else nil
		responsesProps.clanColorTheirs = if TheirClanInfo then Color3.fromHex(TheirClanInfo.FlagColorStr) else nil
		responsesProps.clanMembersTheirs = battleResponseData.TheirClanAccepted
		responsesProps.onUnAcceptBattleInvite = self.props.onUnAcceptBattleInvite
		children.Responses = createElement(Responses, responsesProps)
	end
	return Roact.createFragment(children)
end
function PersistentCrewAppComponent.didMount(self)
	self:_updateWelcomeVisible()
	local function updateCountdown()
		local roundStartsAt = PersistentCrewBattleUtils.getRoundStartsAt()
		if roundStartsAt and workspace:GetServerTimeNow() < roundStartsAt then
			self:setState({
				countdownVisible = true,
				countdownTil = roundStartsAt
			})
		end
	end
	self.maid:GiveTask(PersistentCrewBattleUtils.getRoundStartsAtAttributeChangedSignal():Connect(updateCountdown))
	updateCountdown()
end
function PersistentCrewAppComponent._updateWelcomeVisible(self)
	if self.props.isBattleServer then
		self:setState({
			welcomeVisible = true
		})
	end
end
function PersistentCrewAppComponent.didUpdate(self, prevProps, prevState)
	if self.props.isBattleServer ~= prevProps.isBattleServer then
		self:_updateWelcomeVisible()
	end
end
function PersistentCrewAppComponent.willUnmount(self)
	self.maid:DoCleaning()
end
return RoactRodux.connect(function(state, state)
	return {
		viewingClanInfo = state.viewingClanInfo,
		currentClanInfo = state.currentClanInfo,
		membersOnlineMap = state.membersOnlineMap,
		members = state.members,
		joinRequests = state.joinRequests,
		isReadiedUp = state.isReadiedUp,
		groupVisible = state.groupVisible,
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
end)(PersistentCrewAppComponent)
