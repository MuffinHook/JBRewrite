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
local local1 = Roact.PureComponent:extend("PersistentCrewApp")
local1.defaultProps = {
	size = UDim2.fromScale(0.9, 0.9),
	position = UDim2.fromScale(0.5, 0.5),
	anchorPoint = Vector2.new(0.5, 0.5)
}
function local1.init(self)
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
	function self.onCountdownElapsed(param12)
		if param12 < 0 then
			self:setState({
				countdownVisible = false
			})
			self.props.onCountdownFinished()
		end
	end
end
function local1.render(self)
	local t = {}
	if self.state.welcomeVisible then
		t.Welcome = createElement(Welcome, {
			onClickClose = self.onClickCloseWelcome
		})
	end
	local local1 = Players.LocalPlayer:GetAttribute("CrewBattleTeam")
	local table2 = {}
	for local2 in self.props.clanName do
		table.insert(table2, local2)
	end
	local local3 = if table2[1] == local1 then table2[2] else table2[1]
	local attackingClanId = self.props.attackingClanId
	local identityColor = Color3.fromRGB(121, 251, 177)
	local identityColor = Color3.fromRGB(255, 49, 49)
	local penalty = self.props.penalty
	local local6 = penalty ~= nil
	if self.props.isBattleServer then
		local table3 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}
		local table4 = {}
		local table5 = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -48, 1, -48),
			Position = UDim2.fromOffset(24, 24)
		}
		local table6 = {}
		local table7 = {
			Thickness = 2
		}
		table7.Color = if local6 then identityColor else identityColor
		table7.Transparency = 0.75
		table6.UIStroke = createElement("UIStroke", table7)
		table6.UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 32)
		})
		table4.BorderOuter = createElement("Frame", table5, table6)
		table4.BorderInner = createElement("Frame", {
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
		t.Container = createElement("Frame", table3, table4)
		t.Penalty = local6 and createElement("Frame", {
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
		local table8 = {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(0.5, 0, 0, 24),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0, 41),
			ZIndex = 3
		}
		local table9 = {}
		local table10 = {
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
			Size = UDim2.fromScale(0.125, 1.5),
			AnchorPoint = Vector2.new(0.5, 0.25),
			Position = UDim2.fromScale(0.5, 0.5)
		}
		local table11 = {
			UIStroke = createElement("UIStroke", {
				Thickness = 2,
				Color = identityColor,
				Transparency = 0.5
			}),
			UICorners = createElement("UICorner", {
				CornerRadius = UDim.new(0.25, 0)
			})
		}
		local table12 = {
			font = Enum.Font.FredokaOne,
			position = UDim2.fromScale(0.5, 0.5),
			textColor = ColorUtils.saturateBy(identityColor, 0.8),
			createdAt = self.props.startedAt[attackingClanId],
			elapsed = self.props.timeTook[attackingClanId]
		}
		table12.disabled = self.props.startedAt[attackingClanId] == nil
		table11.ElapsedContainer = createElement(Elapsed, table12)
		table9.Timer = createElement("Frame", table10, table11)
		local table13 = {
			clanName = self.props.clanName[local1],
			backgroundColor = identityColor,
			size = UDim2.fromScale(0.4, 1),
			position = UDim2.fromScale(0, 0.5),
			anchorPoint = Vector2.new(0, 0.5),
			createdAt = self.props.startedAt[local1]
		}
		table13.elapsed = if self.props.startedAt[local1] == nil then 0 else self.props.timeTook[local1]
		table13.disabled = self.props.startedAt[local1] == nil
		table13.attacking = local1 == attackingClanId
		table13.robberiesCompleted = self.props.robberiesCompleted
		table9.CrewOurs = createElement(BattleCrewInfo, table13)
		local table14 = {
			clanName = self.props.clanName[local3],
			backgroundColor = identityColor,
			size = UDim2.fromScale(0.4, 1),
			position = UDim2.fromScale(1, 0.5),
			anchorPoint = Vector2.new(1, 0.5),
			createdAt = self.props.startedAt[local3]
		}
		table14.elapsed = if self.props.startedAt[local3] == nil then 0 else self.props.timeTook[local3]
		table14.disabled = self.props.startedAt[local3] == nil
		table14.attacking = local3 == attackingClanId
		table14.robberiesCompleted = self.props.robberiesCompleted
		table9.CrewTheirs = createElement(BattleCrewInfo, table14, {
			Report = false
		})
		t.TopBar = createElement("Frame", table8, table9)
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
