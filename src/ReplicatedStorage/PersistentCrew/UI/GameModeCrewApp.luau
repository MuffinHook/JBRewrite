-- Reviewed by Claude
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
local v1 = Roact.PureComponent:extend("PersistentCrewApp")
v1.defaultProps = {
	size = UDim2.fromScale(0.9, 0.9),
	position = UDim2.fromScale(0.5, 0.5),
	anchorPoint = Vector2.new(0.5, 0.5)
}
function v1.init(p1)
	p1.maid = Maid.new()
	p1:setState({
		showRequests = false,
		countdownTil = 0,
		countdownVisible = false,
		isSmallScreen = Utils.isSmallScreen()
	})
	p1.maid:GiveTask(Utils.getViewportSizeChangedSignal():Connect(function()
		p1:setState({
			isSmallScreen = Utils.isSmallScreen()
		})
	end))
	function p1.onClickCloseWelcome()
		p1:setState({
			welcomeVisible = false
		})
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	function p1.onCountdownElapsed(p12)
		if p12 < 0 then
			p1:setState({
				countdownVisible = false
			})
			p1.props.onCountdownFinished()
		end
	end
end
function v1.render(p1)
	local t = {}
	if p1.state.welcomeVisible then
		t.Welcome = createElement(Welcome, {
			onClickClose = p1.onClickCloseWelcome
		})
	end
	local v1 = Players.LocalPlayer:GetAttribute("CrewBattleTeam")
	local t2 = {}
	for v2 in p1.props.clanName do
		table.insert(t2, v2)
	end
	local v3 = if t2[1] == v1 then t2[2] else t2[1]
	local attackingClanId = p1.props.attackingClanId
	local v4 = Color3.fromRGB(121, 251, 177)
	local v5 = Color3.fromRGB(255, 49, 49)
	local penalty = p1.props.penalty
	local v6 = penalty ~= nil
	if p1.props.isBattleServer then
		local t3 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}
		local t4 = {}
		local t5 = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -48, 1, -48),
			Position = UDim2.fromOffset(24, 24)
		}
		local t6 = {}
		local t7 = {
			Thickness = 2
		}
		t7.Color = if v6 then v5 else v4
		t7.Transparency = 0.75
		t6.UIStroke = createElement("UIStroke", t7)
		t6.UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 32)
		})
		t4.BorderOuter = createElement("Frame", t5, t6)
		t4.BorderInner = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -84, 1, -84),
			Position = UDim2.fromOffset(42, 42)
		}, {
			UIStroke = createElement("UIStroke", {
				Thickness = 2,
				Color = v4,
				Transparency = 0.5
			}),
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 32)
			})
		})
		t.Container = createElement("Frame", t3, t4)
		t.Penalty = v6 and createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 0, 16),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0, 23),
			ZIndex = 3
		}, {
			Timer = createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundColor3 = v5,
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
		local t8 = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 0, 24),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0, 41),
			ZIndex = 3
		}
		local t9 = {}
		local t10 = {
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
			Size = UDim2.fromScale(0.125, 1.5),
			AnchorPoint = Vector2.new(0.5, 0.25),
			Position = UDim2.fromScale(0.5, 0.5)
		}
		local t11 = {
			UIStroke = createElement("UIStroke", {
				Thickness = 2,
				Color = v4,
				Transparency = 0.5
			}),
			UICorners = createElement("UICorner", {
				CornerRadius = UDim.new(0.25, 0)
			})
		}
		local t12 = {
			font = Enum.Font.FredokaOne,
			position = UDim2.fromScale(0.5, 0.5),
			textColor = ColorUtils.saturateBy(v4, 0.8),
			createdAt = p1.props.startedAt[attackingClanId],
			elapsed = p1.props.timeTook[attackingClanId]
		}
		t12.disabled = p1.props.startedAt[attackingClanId] == nil
		t11.ElapsedContainer = createElement(Elapsed, t12)
		t9.Timer = createElement("Frame", t10, t11)
		local t13 = {
			clanName = p1.props.clanName[v1],
			backgroundColor = v4,
			size = UDim2.fromScale(0.4, 1),
			position = UDim2.fromScale(0, 0.5),
			anchorPoint = Vector2.new(0, 0.5),
			createdAt = p1.props.startedAt[v1]
		}
		t13.elapsed = if p1.props.startedAt[v1] == nil then 0 else p1.props.timeTook[v1]
		t13.disabled = p1.props.startedAt[v1] == nil
		t13.attacking = v1 == attackingClanId
		t13.robberiesCompleted = p1.props.robberiesCompleted
		t9.CrewOurs = createElement(BattleCrewInfo, t13)
		local t14 = {
			clanName = p1.props.clanName[v3],
			backgroundColor = v4,
			size = UDim2.fromScale(0.4, 1),
			position = UDim2.fromScale(1, 0.5),
			anchorPoint = Vector2.new(1, 0.5),
			createdAt = p1.props.startedAt[v3]
		}
		t14.elapsed = if p1.props.startedAt[v3] == nil then 0 else p1.props.timeTook[v3]
		t14.disabled = p1.props.startedAt[v3] == nil
		t14.attacking = v3 == attackingClanId
		t14.robberiesCompleted = p1.props.robberiesCompleted
		t9.CrewTheirs = createElement(BattleCrewInfo, t14, {
			Report = false
		})
		t.TopBar = createElement("Frame", t8, t9)
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
	end
	return Roact.createFragment(t)
end
function v1.didMount(p1)
	p1:_updateWelcomeVisible()
	local function updateCountdown()
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
function v1._updateWelcomeVisible(p1)
	if p1.props.isBattleServer then
		p1:setState({
			welcomeVisible = true
		})
	end
end
function v1.didUpdate(p1, p2, p3)
	if p1.props.isBattleServer ~= p2.isBattleServer then
		p1:_updateWelcomeVisible()
	end
end
function v1.willUnmount(p1)
	p1.maid:DoCleaning()
end
return RoactRodux.connect(function(p1, p2)
	return {
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
end, function(p1)
	return {
		onClickClose = function()
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
		onClickViewMe = function()
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
