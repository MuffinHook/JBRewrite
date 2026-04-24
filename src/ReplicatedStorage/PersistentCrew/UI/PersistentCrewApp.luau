-- Reviewed by Claude
-- variables reassigned
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
local local1 = Roact.PureComponent:extend("PersistentCrewApp")
local1.defaultProps = {
	size = UDim2.fromScale(0.9, 0.9),
	position = UDim2.fromScale(0.5, 0.5),
	anchorPoint = Vector2.new(0.5, 0.5)
}
function local1.init(self)
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
	function self.onReportDialogSubmit(self, self)
		self.props.attemptReportCrew(self, self)
	end
end
function local1.render(self)
	local currentClanInfo = self.props.currentClanInfo
	local local1 = self.props.viewingClanInfo or currentClanInfo
	local t = {}
	if self.props.groupVisible then
		local table2 = {}
		local local2, local3
		if local1 then
			local localPlayer = if Players.LocalPlayer then Players.LocalPlayer.UserId else -1
			local local8 = UDim2.fromScale(1, 0.5)
			local local11 = UDim2.fromScale(0.5, 0.5 - if self.props.battleResponseData == nil then 0 else 0.1)
			local table3 = {
				aspectRatio = 1.7777777777777777,
				verticalPaddingRatio = 128,
				clanId = local1.ClanId,
				playersClanId = local1.PlayersClanId
			}
			local local14
			if local1.PlayersClanId == local1.ClanId then
				local14 = true
				local2 = local8
			else
				local14 = false
				local2 = local8
			end
			table3.isPlayersClan = local14
			table3.leaderboardRank = local1.LeaderboardRank
			local local15
			if local1.AdminIdMap[tostring(localPlayer)] == true then
				local15 = true
				local3 = local11
			else
				local15 = false
				local3 = local11
			end
			table3.isAdminOfViewingClan = local15
			table3.isAdminOfCurrentClan = currentClanInfo and currentClanInfo.AdminIdMap[tostring(localPlayer)] == true
			table3.battlesPlayed = local1.BattlesPlayed or 0
			table3.battlesWon = local1.BattlesWon or 0
			table3.attemptLeave = self.props.attemptLeave
			table3.clanOwnerUserId = local1.OwnerUserId
			table3.clanName = local1.ClanName
			table3.clanDisplayRating = local1.DisplayRating or Glicko2Consts.DEFAULT_MU
			table3.flagColor = local1.FlagColor
			table3.membersOnlineMap = self.props.membersOnlineMap
			table3.showRequests = self.state.showRequests
			table3.members = self.props.members
			table3.joinRequests = self.props.joinRequests
			table3.isReadiedUp = self.props.isReadiedUp
			table3.playerHasAcceptedInvite = self.props.battleResponseData ~= nil
			table3.playerDisplayRating = local1.PlayerDisplayRating
			table3.attemptBattleClanId = self.props.attemptBattleClanId
			table3.attemptViewUserIdClan = self.props.attemptViewUserIdClan
			table3.onClickAdmin = self.onClickAdmin
			table3.onClickRenameCrew = self.onClickRenameCrew
			table3.onClickUnAdmin = self.onClickUnAdmin
			table3.onClickKick = self.onClickKick
			table3.onClickJoinRequestAccept = self.onClickJoinRequestAccept
			table3.onClickJoinRequestDeny = self.onClickJoinRequestDeny
			table3.onClickToggleRequests = self.onClickToggleRequests
			table3.attemptRequestJoinUserId = self.props.attemptRequestJoinUserId
			table3.onClickReadyUp = self.props.onClickReadyUp
			table3.onClickUnreadyUp = self.props.onClickUnreadyUp
			table3.networkMutexLocked = self.props.networkMutexLocked
			table3.onClickViewMe = self.onClickViewMe
			table3.onClickClose = self.props.onClickClose
			table2.Crew = createElement(Info, table3)
		else
			local local18 = UDim2.fromScale(1, 0.35)
			local local19 = UDim2.fromScale(0.5, 0.5)
			table2.JoinOrCreate = createElement(JoinOrCreate, {
				aspectRatio = 1.7777777777777777,
				verticalPaddingRatio = 128,
				attemptCreate = self.props.attemptCreate,
				attemptViewUserIdClan = self.props.attemptViewUserIdClan,
				networkMutexLocked = self.props.networkMutexLocked,
				onClickClose = self.props.onClickClose
			})
			local2 = local18
			local3 = local19
		end
		t.Group = createElement("Frame", {
			BackgroundTransparency = 0.8,
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			Size = local2,
			Position = local3,
			AnchorPoint = self.props.anchorPoint
		}, Dictionary.merge({
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1.7777777777777777
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 8)
			})
		}, table2))
	end
	if self.state.welcomeVisible then
		t.Welcome = createElement(Welcome, {
			onClickClose = self.onClickCloseWelcome
		})
	end
	local table2 = {
		size = UDim2.new(0.3333333333333333, 0, 0.3333333333333333, 0)
	}
	table2.position = self.state.isSmallScreen and UDim2.new(0.5, 0, 0.6666666666666666, 0) or UDim2.new(1, 0, 0.5, 0)
	table2.anchorPoint = self.state.isSmallScreen and Vector2.new(0.5, 0.5) or Vector2.new(1, 0.5)
	table2.onAccept = self.props.onAcceptBattleInvite
	table2.onDecline = self.props.onDeclineBattleInvite
	t.BattleInvites = createElement(BattleInvites, table2)
	local local24 = local1 and local1.ClanId
	local table3 = {}
	for local25 in self.props.clanName do
		table.insert(table3, local25)
	end
	local local26 = if table3[1] == local24 then table3[2] else table3[1]
	local attackingClanId = self.props.attackingClanId
	local identityColor = Color3.fromRGB(121, 251, 177)
	local identityColor = Color3.fromRGB(255, 49, 49)
	local penalty = self.props.penalty
	local local29 = penalty ~= nil
	if self.props.isBattleServer then
		local table4 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}
		local table5 = {}
		local table6 = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -48, 1, -48),
			Position = UDim2.fromOffset(24, 24)
		}
		local table7 = {}
		local table8 = {
			Thickness = 2
		}
		table8.Color = if local29 then identityColor else identityColor
		table8.Transparency = 0.75
		table7.UIStroke = createElement("UIStroke", table8)
		table7.UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 32)
		})
		table5.BorderOuter = createElement("Frame", table6, table7)
		table5.BorderInner = createElement("Frame", {
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
		t.Container = createElement("Frame", table4, table5)
		t.Penalty = local29 and createElement("Frame", {
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
		local table9 = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 0, 24),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0, 41),
			ZIndex = 3
		}
		local table10 = {}
		local table11 = {
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
			Size = UDim2.fromScale(0.125, 1.5),
			AnchorPoint = Vector2.new(0.5, 0.25),
			Position = UDim2.fromScale(0.5, 0.5)
		}
		local table12 = {
			UIStroke = createElement("UIStroke", {
				Thickness = 2,
				Color = identityColor,
				Transparency = 0.5
			}),
			UICorners = createElement("UICorner", {
				CornerRadius = UDim.new(0.25, 0)
			})
		}
		local table13 = {
			font = Enum.Font.FredokaOne,
			position = UDim2.fromScale(0.5, 0.5),
			textColor = ColorUtils.saturateBy(identityColor, 0.8),
			createdAt = self.props.startedAt[attackingClanId],
			elapsed = self.props.timeTook[attackingClanId]
		}
		table13.disabled = self.props.startedAt[attackingClanId] == nil
		table12.ElapsedContainer = createElement(Elapsed, table13)
		table10.Timer = createElement("Frame", table11, table12)
		local table14 = {
			clanName = self.props.clanName[local24],
			backgroundColor = identityColor,
			size = UDim2.fromScale(0.4, 1),
			position = UDim2.fromScale(0, 0.5),
			anchorPoint = Vector2.new(0, 0.5),
			createdAt = self.props.startedAt[local24]
		}
		table14.elapsed = if self.props.startedAt[local24] == nil then 0 else self.props.timeTook[local24]
		table14.disabled = self.props.startedAt[local24] == nil
		table14.attacking = local24 == attackingClanId
		table14.robberiesCompleted = self.props.robberiesCompleted
		table10.CrewOurs = createElement(BattleCrewInfo, table14)
		local table15 = {
			clanName = self.props.clanName[local26],
			backgroundColor = identityColor,
			size = UDim2.fromScale(0.4, 1),
			position = UDim2.fromScale(1, 0.5),
			anchorPoint = Vector2.new(1, 0.5),
			createdAt = self.props.startedAt[local26]
		}
		table15.elapsed = if self.props.startedAt[local26] == nil then 0 else self.props.timeTook[local26]
		table15.disabled = self.props.startedAt[local26] == nil
		table15.attacking = local26 == attackingClanId
		table15.robberiesCompleted = self.props.robberiesCompleted
		table10.CrewTheirs = createElement(BattleCrewInfo, table15, {
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
		t.TopBar = createElement("Frame", table9, table10)
		if self.state.countdownVisible then
			t.Countdown = createElement(Elapsed, {
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
			t.ReportDialog = createElement(ReportCrew, {
				size = UDim2.fromScale(1, 0.45),
				onClose = self.onReportDialogClose,
				onSubmit = self.onReportDialogSubmit
			})
		end
	end
	if self.props.battleResponseData then
		local battleResponseData = self.props.battleResponseData
		local TheirClanInfo = battleResponseData.TheirClanInfo
		local table4 = {
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
		table4.clanNameTheirs = if TheirClanInfo then TheirClanInfo.ClanName else nil
		table4.clanOwnerTheirs = if TheirClanInfo then TheirClanInfo.OwnerUserId else nil
		table4.clanColorTheirs = if TheirClanInfo then Color3.fromHex(TheirClanInfo.FlagColorStr) else nil
		table4.clanMembersTheirs = battleResponseData.TheirClanAccepted
		table4.onUnAcceptBattleInvite = self.props.onUnAcceptBattleInvite
		t.Responses = createElement(Responses, table4)
	end
	return Roact.createFragment(t)
end
function local1.didMount(self)
	self:_updateWelcomeVisible()
	local function updateCountdown()
		local local1 = PersistentCrewBattleUtils.getRoundStartsAt()
		if local1 and workspace:GetServerTimeNow() < local1 then
			self:setState({
				countdownVisible = true,
				countdownTil = local1
			})
		end
	end
	self.maid:GiveTask(PersistentCrewBattleUtils.getRoundStartsAtAttributeChangedSignal():Connect(updateCountdown))
	updateCountdown()
end
function local1._updateWelcomeVisible(self)
	if self.props.isBattleServer then
		self:setState({
			welcomeVisible = true
		})
	end
end
function local1.didUpdate(self, self, param3)
	if self.props.isBattleServer ~= self.isBattleServer then
		self:_updateWelcomeVisible()
	end
end
function local1.willUnmount(self)
	self.maid:DoCleaning()
end
return RoactRodux.connect(function(self, self)
	return {
		viewingClanInfo = self.viewingClanInfo,
		currentClanInfo = self.currentClanInfo,
		membersOnlineMap = self.membersOnlineMap,
		members = self.members,
		joinRequests = self.joinRequests,
		isReadiedUp = self.isReadiedUp,
		groupVisible = self.groupVisible,
		timeTook = self.timeTook,
		startedAt = self.startedAt,
		isBattleServer = self.isBattleServer,
		clanName = self.clanName,
		networkMutexLocked = self.networkMutexLocked,
		robberiesCompleted = self.robberiesCompleted,
		attackingClanId = self.attackingClanId,
		battleResponseData = self.battleResponseData,
		penalty = self.penalty
	}
end, function(self)
	return {
		onClickClose = function()
			self({
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
			self({
				type = "setMembers",
				value = {}
			})
			self({
				type = "setViewingClanInfo",
				value = nil
			})
		end
	}
end)(local1)
