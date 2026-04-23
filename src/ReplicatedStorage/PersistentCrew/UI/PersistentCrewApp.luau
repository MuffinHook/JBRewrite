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
local function playClick() --[[ Line: 26 | Upvalues: Players (copy), Audio (copy) ]]
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
			Volume = 0.2
		})
	end
end
local v1 = Roact.PureComponent:extend("PersistentCrewApp")
v1.defaultProps = {
	size = UDim2.fromScale(0.9, 0.9),
	position = UDim2.fromScale(0.5, 0.5),
	anchorPoint = Vector2.new(0.5, 0.5)
}
function v1.init(p1) --[[ Line: 38 | Upvalues: Maid (copy), Utils (copy), Players (copy), Audio (copy) ]]
	p1.maid = Maid.new()
	function p1.onClickAdmin(p12) --[[ Line: 41 | Upvalues: p1 (copy) ]]
		p1.props.attemptAdmin(p12.userId)
	end
	function p1.onClickRenameCrew(p12) --[[ Line: 44 | Upvalues: p1 (copy) ]]
		p1.props.attemptRenameCrew(p12)
	end
	function p1.onClickUnAdmin(p12) --[[ Line: 47 | Upvalues: p1 (copy) ]]
		p1.props.attemptUnAdmin(p12.userId)
	end
	function p1.onClickKick(p12) --[[ Line: 50 | Upvalues: p1 (copy) ]]
		p1.props.attemptKick(p12.userId)
	end
	function p1.onClickJoinRequestAccept(p12) --[[ Line: 53 | Upvalues: p1 (copy) ]]
		p1.props.onClickJoinRequestAccept(p12.userId)
	end
	function p1.onClickJoinRequestDeny(p12) --[[ Line: 56 | Upvalues: p1 (copy) ]]
		p1.props.onClickJoinRequestDeny(p12.userId)
	end
	p1:setState({
		showRequests = false,
		countdownTil = 0,
		countdownVisible = false,
		isSmallScreen = Utils.isSmallScreen()
	})
	p1.maid:GiveTask(Utils.getViewportSizeChangedSignal():Connect(function() --[[ Line: 65 | Upvalues: p1 (copy), Utils (ref) ]]
		p1:setState({
			isSmallScreen = Utils.isSmallScreen()
		})
	end))
	function p1.onClickToggleRequests() --[[ Line: 70 | Upvalues: p1 (copy), Players (ref), Audio (ref) ]]
		p1:setState({
			showRequests = not p1.state.showRequests
		})
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	function p1.onClickCloseWelcome() --[[ Line: 76 | Upvalues: p1 (copy), Players (ref), Audio (ref) ]]
		p1:setState({
			welcomeVisible = false
		})
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	function p1.onClickViewMe() --[[ Line: 82 | Upvalues: p1 (copy), Players (ref), Audio (ref) ]]
		p1.props.attemptViewUserIdClan(Players.LocalPlayer.UserId)
		p1.props.onClickViewMe()
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	function p1.onCountdownElapsed(p12) --[[ Line: 87 | Upvalues: p1 (copy) ]]
		if p12 < 0 then
			p1:setState({
				countdownVisible = false
			})
			p1.props.onCountdownFinished()
		end
	end
	function p1.onReportDialogClose() --[[ Line: 96 | Upvalues: p1 (copy) ]]
		p1:setState({
			reportDialogVisible = false
		})
	end
	function p1.onReportDialogSubmit(p12, p2) --[[ Line: 101 | Upvalues: p1 (copy) ]]
		p1.props.attemptReportCrew(p12, p2)
	end
end
function v1.render(p1) --[[ Line: 105 | Upvalues: Glicko2Consts (copy), Players (copy), createElement (copy), Info (copy), JoinOrCreate (copy), Dictionary (copy), Welcome (copy), BattleInvites (copy), Elapsed (copy), ColorUtils (copy), BattleCrewInfo (copy), Roact (copy), ReportCrew (copy), Responses (copy) ]]
	local currentClanInfo = p1.props.currentClanInfo
	local v1 = p1.props.viewingClanInfo or currentClanInfo
	local t = {}
	if p1.props.groupVisible then
		local t2 = {}
		local v2, v3
		if v1 then
			local v7 = if Players.LocalPlayer then Players.LocalPlayer.UserId else -1
			local v8 = UDim2.fromScale(1, 0.5)
			local v11 = UDim2.fromScale(0.5, 0.5 - if p1.props.battleResponseData == nil then 0 else 0.1)
			local t3 = {
				aspectRatio = 1.7777777777777777,
				verticalPaddingRatio = 128,
				clanId = v1.ClanId,
				playersClanId = v1.PlayersClanId
			}
			local v14
			if v1.PlayersClanId == v1.ClanId then
				v14 = true
				v2 = v8
			else
				v14 = false
				v2 = v8
			end
			t3.isPlayersClan = v14
			t3.leaderboardRank = v1.LeaderboardRank
			local v15
			if v1.AdminIdMap[tostring(v7)] == true then
				v15 = true
				v3 = v11
			else
				v15 = false
				v3 = v11
			end
			t3.isAdminOfViewingClan = v15
			t3.isAdminOfCurrentClan = currentClanInfo and currentClanInfo.AdminIdMap[tostring(v7)] == true
			t3.battlesPlayed = v1.BattlesPlayed or 0
			t3.battlesWon = v1.BattlesWon or 0
			t3.attemptLeave = p1.props.attemptLeave
			t3.clanOwnerUserId = v1.OwnerUserId
			t3.clanName = v1.ClanName
			t3.clanDisplayRating = v1.DisplayRating or Glicko2Consts.DEFAULT_MU
			t3.flagColor = v1.FlagColor
			t3.membersOnlineMap = p1.props.membersOnlineMap
			t3.showRequests = p1.state.showRequests
			t3.members = p1.props.members
			t3.joinRequests = p1.props.joinRequests
			t3.isReadiedUp = p1.props.isReadiedUp
			t3.playerHasAcceptedInvite = p1.props.battleResponseData ~= nil
			t3.playerDisplayRating = v1.PlayerDisplayRating
			t3.attemptBattleClanId = p1.props.attemptBattleClanId
			t3.attemptViewUserIdClan = p1.props.attemptViewUserIdClan
			t3.onClickAdmin = p1.onClickAdmin
			t3.onClickRenameCrew = p1.onClickRenameCrew
			t3.onClickUnAdmin = p1.onClickUnAdmin
			t3.onClickKick = p1.onClickKick
			t3.onClickJoinRequestAccept = p1.onClickJoinRequestAccept
			t3.onClickJoinRequestDeny = p1.onClickJoinRequestDeny
			t3.onClickToggleRequests = p1.onClickToggleRequests
			t3.attemptRequestJoinUserId = p1.props.attemptRequestJoinUserId
			t3.onClickReadyUp = p1.props.onClickReadyUp
			t3.onClickUnreadyUp = p1.props.onClickUnreadyUp
			t3.networkMutexLocked = p1.props.networkMutexLocked
			t3.onClickViewMe = p1.onClickViewMe
			t3.onClickClose = p1.props.onClickClose
			t2.Crew = createElement(Info, t3)
		else
			local v18 = UDim2.fromScale(1, 0.35)
			local v19 = UDim2.fromScale(0.5, 0.5)
			t2.JoinOrCreate = createElement(JoinOrCreate, {
				aspectRatio = 1.7777777777777777,
				verticalPaddingRatio = 128,
				attemptCreate = p1.props.attemptCreate,
				attemptViewUserIdClan = p1.props.attemptViewUserIdClan,
				networkMutexLocked = p1.props.networkMutexLocked,
				onClickClose = p1.props.onClickClose
			})
			v2 = v18
			v3 = v19
		end
		t.Group = createElement("Frame", {
			BackgroundTransparency = 0.8,
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			Size = v2,
			Position = v3,
			AnchorPoint = p1.props.anchorPoint
		}, Dictionary.merge({
			AspectRatio = createElement("UIAspectRatioConstraint", {
				AspectRatio = 1.7777777777777777
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 8)
			})
		}, t2))
	end
	if p1.state.welcomeVisible then
		t.Welcome = createElement(Welcome, {
			onClickClose = p1.onClickCloseWelcome
		})
	end
	local t2 = {
		size = UDim2.new(0.3333333333333333, 0, 0.3333333333333333, 0)
	}
	t2.position = p1.state.isSmallScreen and UDim2.new(0.5, 0, 0.6666666666666666, 0) or UDim2.new(1, 0, 0.5, 0)
	t2.anchorPoint = p1.state.isSmallScreen and Vector2.new(0.5, 0.5) or Vector2.new(1, 0.5)
	t2.onAccept = p1.props.onAcceptBattleInvite
	t2.onDecline = p1.props.onDeclineBattleInvite
	t.BattleInvites = createElement(BattleInvites, t2)
	local v24 = v1 and v1.ClanId
	local t3 = {}
	for v25 in p1.props.clanName do
		table.insert(t3, v25)
	end
	local v26 = if t3[1] == v24 then t3[2] else t3[1]
	local attackingClanId = p1.props.attackingClanId
	local v27 = Color3.fromRGB(121, 251, 177)
	local v28 = Color3.fromRGB(255, 49, 49)
	local penalty = p1.props.penalty
	local v29 = penalty ~= nil
	if p1.props.isBattleServer then
		local t4 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}
		local t5 = {}
		local t6 = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -48, 1, -48),
			Position = UDim2.fromOffset(24, 24)
		}
		local t7 = {}
		local t8 = {
			Thickness = 2
		}
		t8.Color = if v29 then v28 else v27
		t8.Transparency = 0.75
		t7.UIStroke = createElement("UIStroke", t8)
		t7.UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 32)
		})
		t5.BorderOuter = createElement("Frame", t6, t7)
		t5.BorderInner = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -84, 1, -84),
			Position = UDim2.fromOffset(42, 42)
		}, {
			UIStroke = createElement("UIStroke", {
				Thickness = 2,
				Color = v27,
				Transparency = 0.5
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 32)
			})
		})
		t.Container = createElement("Frame", t4, t5)
		t.Penalty = v29 and createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 0, 16),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0, 23),
			ZIndex = 3
		}, {
			Timer = createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundColor3 = v28,
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
		local t9 = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 0, 24),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0, 41),
			ZIndex = 3
		}
		local t10 = {}
		local t11 = {
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
			Size = UDim2.fromScale(0.125, 1.5),
			AnchorPoint = Vector2.new(0.5, 0.25),
			Position = UDim2.fromScale(0.5, 0.5)
		}
		local t12 = {
			UIStroke = createElement("UIStroke", {
				Thickness = 2,
				Color = v27,
				Transparency = 0.5
			}),
			UICorners = createElement("UICorner", {
				CornerRadius = UDim.new(0.25, 0)
			})
		}
		local t13 = {
			font = Enum.Font.FredokaOne,
			position = UDim2.fromScale(0.5, 0.5),
			textColor = ColorUtils.saturateBy(v27, 0.8),
			createdAt = p1.props.startedAt[attackingClanId],
			elapsed = p1.props.timeTook[attackingClanId]
		}
		t13.disabled = p1.props.startedAt[attackingClanId] == nil
		t12.ElapsedContainer = createElement(Elapsed, t13)
		t10.Timer = createElement("Frame", t11, t12)
		local t14 = {
			clanName = p1.props.clanName[v24],
			backgroundColor = v27,
			size = UDim2.fromScale(0.4, 1),
			position = UDim2.fromScale(0, 0.5),
			anchorPoint = Vector2.new(0, 0.5),
			createdAt = p1.props.startedAt[v24]
		}
		t14.elapsed = if p1.props.startedAt[v24] == nil then 0 else p1.props.timeTook[v24]
		t14.disabled = p1.props.startedAt[v24] == nil
		t14.attacking = v24 == attackingClanId
		t14.robberiesCompleted = p1.props.robberiesCompleted
		t10.CrewOurs = createElement(BattleCrewInfo, t14)
		local t15 = {
			clanName = p1.props.clanName[v26],
			backgroundColor = v27,
			size = UDim2.fromScale(0.4, 1),
			position = UDim2.fromScale(1, 0.5),
			anchorPoint = Vector2.new(1, 0.5),
			createdAt = p1.props.startedAt[v26]
		}
		t15.elapsed = if p1.props.startedAt[v26] == nil then 0 else p1.props.timeTook[v26]
		t15.disabled = p1.props.startedAt[v26] == nil
		t15.attacking = v26 == attackingClanId
		t15.robberiesCompleted = p1.props.robberiesCompleted
		t10.CrewTheirs = createElement(BattleCrewInfo, t15, {
			Report = createElement("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.new(1, 4, 0, 0)
			}, {
				Image = createElement("ImageButton", {
					BackgroundColor3 = Color3.fromRGB(251, 121, 121),
					Size = UDim2.fromScale(1, 1),
					Image = "rbxassetid://14280463776",
					[Roact.Event.Activated] = function() --[[ Line: 388 | Upvalues: p1 (copy) ]]
						p1:setState({
							reportDialogVisible = not p1.state.reportDialogVisible
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
		t.TopBar = createElement("Frame", t9, t10)
		if p1.state.countdownVisible then
			t.Countdown = createElement(Elapsed, {
				createdAt = p1.state.countdownTil,
				countDown = true,
				onElapsed = p1.onCountdownElapsed,
				textColor = Color3.new(51/255, 51/255, 51/255),
				alwaysShowMinutes = false
			}, {
				UIStroke = createElement("UIStroke", {
					Thickness = 2,
					Color = Color3.fromRGB(255, 215, 0)
				})
			})
		end
		if p1.state.reportDialogVisible then
			t.ReportDialog = createElement(ReportCrew, {
				size = UDim2.fromScale(1, 0.45),
				onClose = p1.onReportDialogClose,
				onSubmit = p1.onReportDialogSubmit
			})
		end
	end
	if p1.props.battleResponseData then
		local battleResponseData = p1.props.battleResponseData
		local TheirClanInfo = battleResponseData.TheirClanInfo
		local t4 = {
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
		t4.clanNameTheirs = if TheirClanInfo then TheirClanInfo.ClanName else nil
		t4.clanOwnerTheirs = if TheirClanInfo then TheirClanInfo.OwnerUserId else nil
		t4.clanColorTheirs = if TheirClanInfo then Color3.fromHex(TheirClanInfo.FlagColorStr) else nil
		t4.clanMembersTheirs = battleResponseData.TheirClanAccepted
		t4.onUnAcceptBattleInvite = p1.props.onUnAcceptBattleInvite
		t.Responses = createElement(Responses, t4)
	end
	return Roact.createFragment(t)
end
function v1.didMount(p1) --[[ Line: 479 | Upvalues: PersistentCrewBattleUtils (copy) ]]
	p1:_updateWelcomeVisible()
	local function updateCountdown() --[[ Line: 482 | Upvalues: PersistentCrewBattleUtils (ref), p1 (copy) ]]
		local v1 = PersistentCrewBattleUtils.getRoundStartsAt()
		if v1 and workspace:GetServerTimeNow() < v1 then
			p1:setState({
				countdownVisible = true,
				countdownTil = v1
			})
		end
	end
	p1.maid:GiveTask(PersistentCrewBattleUtils.getRoundStartsAtAttributeChangedSignal():Connect(updateCountdown))
	updateCountdown()
end
function v1._updateWelcomeVisible(p1) --[[ Line: 494 ]]
	if p1.props.isBattleServer then
		p1:setState({
			welcomeVisible = true
		})
	end
end
function v1.didUpdate(p1, p2, p3) --[[ Line: 501 ]]
	if p1.props.isBattleServer ~= p2.isBattleServer then
		p1:_updateWelcomeVisible()
	end
end
function v1.willUnmount(p1) --[[ Line: 506 ]]
	p1.maid:DoCleaning()
end
return RoactRodux.connect(function(p1, p2) --[[ Line: 509 ]]
	return {
		viewingClanInfo = p1.viewingClanInfo,
		currentClanInfo = p1.currentClanInfo,
		membersOnlineMap = p1.membersOnlineMap,
		members = p1.members,
		joinRequests = p1.joinRequests,
		isReadiedUp = p1.isReadiedUp,
		groupVisible = p1.groupVisible,
		timeTook = p1.timeTook,
		startedAt = p1.startedAt,
		isBattleServer = p1.isBattleServer,
		clanName = p1.clanName,
		networkMutexLocked = p1.networkMutexLocked,
		robberiesCompleted = p1.robberiesCompleted,
		attackingClanId = p1.attackingClanId,
		battleResponseData = p1.battleResponseData,
		penalty = p1.penalty
	}
end, function(p1) --[[ Line: 529 | Upvalues: Players (copy), Audio (copy) ]]
	return {
		onClickClose = function() --[[ Name: onClickClose | Line: 531 | Upvalues: p1 (copy), Players (ref), Audio (ref) ]]
			p1({
				type = "setGroupVisible",
				value = false
			})
			if Players.LocalPlayer.PlayerGui then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
					Volume = 0.2
				})
			end
		end,
		onClickViewMe = function() --[[ Name: onClickViewMe | Line: 538 | Upvalues: p1 (copy) ]]
			p1({
				type = "setMembers",
				value = {}
			})
			p1({
				type = "setViewingClanInfo",
				value = nil
			})
		end
	}
end)(v1)