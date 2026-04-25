-- Reviewed by Claude
-- variables reassigned
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local Interval = require(ReplicatedStorage.Std.Interval)
local String = require(ReplicatedStorage.Std.String)
local Settings = require(ReplicatedStorage.Resource.Settings)
local SeasonSystem = require(ReplicatedStorage.Game.Season.SeasonSystem)
local Confirmation = require(ReplicatedStorage.Module.Confirmation)
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local SeasonUtils = require(ReplicatedStorage.Game.Season.SeasonUtils)
local ContractConsts = require(script.Parent.ContractConsts)
local ContractSystem = require(script.Parent.ContractSystem)
local ContractUtils = require(script.Parent.ContractUtils)
local ContractUI = {}
ContractUI.__index = ContractUI
ContractUI.__ClassName = "ContractUI"
function ContractUI.new()
	local instance = {}
	setmetatable(instance, ContractUI)
	instance._maid = Maid.new()
	return instance
end
function ContractUI.SetFrame(self, frame)
	assert(frame ~= nil)
	assert(not self._frame)
	self._frame = frame
	self._maid:GiveTask(self._frame)
	self._maid:GiveTask(self._frame.Background.Body.Bottom.Action.MouseButton1Down:Connect(function()
		Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105461542)
		if self._contract:GetStateId() == ContractConsts.enumState.ACTIVE then
			local confirmationDialog = Confirmation.new(("Re-roll for a random contract for $%s?"):format(String.comma(ContractConsts.REROLL_PRICE)))
			confirmationDialog.Maid:GiveTask(confirmationDialog.OnYes:Connect(function()
				self._contract._contractActionRemote:FireServer()
			end))
			self._contract._rerollConfirm = confirmationDialog
		else
			self._contract._contractActionRemote:FireServer()
		end
	end))
	self._maid:GiveTask(ContractSystem.getAnyContractActiveTransitionSignal():Connect(function()
		if getmetatable(self) == nil then
			return
		end
		if getmetatable(self._contract) ~= nil then
			self:_updateState(self._contract:GetStateId())
		end
	end))
end
function ContractUI.SetLayoutOrder(self, layoutOrder)
	assert(layoutOrder ~= nil)
	self._frame.LayoutOrder = layoutOrder
end
function ContractUI.SetContract(self, contract)
	assert(not self._contract)
	self._contract = contract
	self._maid:GiveTask(self._contract:GetProgressValue():GetPropertyChangedSignal("Value"):Connect(function()
		self:_updateProgress()
	end))
	self:_updateProgress()
	local function updateState()
		self:_updateState(self._contract:GetStateId())
	end
	self._maid:GiveTask(self._contract:GetRequireSeasonPassValue():GetPropertyChangedSignal("Value"):Connect(updateState))
	self._maid:GiveTask(self._contract:GetStateValue():GetPropertyChangedSignal("Value"):Connect(updateState))
	self._maid:GiveTask(ContractUtils.getNumTimesRerolledObject(self._contract.obj).Changed:Connect(updateState))
	self:_updateState(self._contract:GetStateId())
	self._maid:GiveTask(SeasonSystem.getSeasonPassOwnedSignal():Connect(function(player)
		if player == LocalPlayer then
			self:_updateState(self._contract:GetStateId())
		end
	end))
	self._frame.Name = self._contract:GetName()
	self:_setTeamId(self._contract:GetTeamId())
	self:_setRewardExp(self._contract:GetRewardExp())
	self:_setMessage(self._contract:GetMessage())
end
function ContractUI.SetTitle(self, title)
	self._frame.Background.Title.TextLabel.Text = title
end
function ContractUI._setMessage(self, message)
	self._frame.Background.Body.Top.ContractDesc.Text = message
end
function ContractUI._setRewardExp(self, rewardExp)
	self._frame.Background.Body.Bottom.Reward.Amount.Text = ("REWARD: %d XP"):format(rewardExp)
end
function ContractUI._setTeamId(self, teamId)
	local teamImageId = nil
	if teamId == Settings.EnumTeam.Police then
		teamImageId = 5955472455
	elseif teamId == Settings.EnumTeam.Criminal then
		teamImageId = 5955427564
	else
		error(("Invalid teamId: %d"):format(teamId))
	end
	self._frame.Background.Image = ("rbxassetid://%d"):format(teamImageId)
end
function ContractUI._updateProgress(self)
	local progressValue = if self._contract:GetStateId() == ContractConsts.enumState.ACTIVE then self._contract:GetProgress() else nil
	local Bottom = self._frame.Background.Body.Bottom
	Bottom.Progress.Visible = progressValue ~= nil
	if progressValue ~= nil then
		Bottom.Progress.Text = ("PROGRESS: %d/%d"):format(self._contract:GetProgress(), self._contract:GetGoal())
	end
end
function ContractUI._updateState(self, stateId)
	if getmetatable(self) ~= nil then
		local buttonImageId = nil
		local buttonText = nil
		local hasVip = GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.VIP)
		if stateId == ContractConsts.enumState.ACCEPTABLE then
			buttonImageId = 5955426934
			buttonText = "ACCEPT"
		elseif stateId == ContractConsts.enumState.ACTIVE and ContractUtils.canReroll(self._contract.obj, hasVip) then
			buttonImageId = 5955427217
			buttonText = "RE-ROLL"
		elseif stateId ~= ContractConsts.enumState.FAILED and (stateId ~= ContractConsts.enumState.ABORTED and stateId == ContractConsts.enumState.COMPLETED) then
			buttonImageId = 5955427217
			buttonText = "COMPLETED"
		end
		local _frame = self._frame
		local Top = _frame.Background.Body.Top
		local Bottom = _frame.Background.Body.Bottom
		if buttonImageId and buttonText then
			Bottom.Action.Image = ("rbxassetid://%d"):format(buttonImageId)
			Bottom.Action.TextLabel.Text = buttonText
			if stateId == ContractConsts.enumState.ACTIVE then
				Bottom.Action.TextLabel.TextColor3 = Color3.new(255/255, 0/255, 0/255)
				Bottom.Action.ImageColor3 = Color3.new(255/255, 0/255, 0/255)
			else
				Bottom.Action.TextLabel.TextColor3 = Color3.new(255/255, 255/255, 255/255)
				Bottom.Action.ImageColor3 = Color3.new(255/255, 255/255, 255/255)
			end
		end
		local requiresSeasonPass = self._contract:GetRequireSeasonPass()
		local seasonPassBlocked = requiresSeasonPass and not SeasonSystem.doesPlayerOwnSeasonPass(LocalPlayer)
		local activeContractForTeam = ContractSystem.getActiveContract(self._contract:GetTeamId())
		local oneActiveBlocked = if activeContractForTeam == nil or (activeContractForTeam == self._contract or stateId == ContractConsts.enumState.COMPLETED) then false else not seasonPassBlocked and not ContractConsts.ALLOW_MULTIPLE_ACTIVE
		Bottom.OneActive.Visible = oneActiveBlocked
		local showRetry = if stateId == ContractConsts.enumState.ABORTED or stateId == ContractConsts.enumState.FAILED then not oneActiveBlocked else false
		Bottom.Retry.Visible = showRetry
		if showRetry then
			local function updateRetryTimer()
				Bottom.Retry.Text = ("RETRY AVAILABLE IN: %s"):format((SeasonUtils.formatRemaining((math.max(ContractConsts.COOLDOWN_DURATION - (DateTime.now().UnixTimestamp - self._contract:GetLastStateUpdate()), 0)))))
			end
			self._maid.stateUpdateLoop = Interval.every(1):Connect(updateRetryTimer)
			updateRetryTimer()
		else
			self._maid.stateUpdateLoop = nil
		end
		local showAction
		if stateId == ContractConsts.enumState.ABORTED or stateId == ContractConsts.enumState.FAILED then
			showAction = false
		else
			showAction = not oneActiveBlocked
			if showAction then
				showAction = not seasonPassBlocked
				if showAction then
					showAction = not if stateId == ContractConsts.enumState.ACTIVE then not ContractUtils.canReroll(self._contract.obj, hasVip) else false
				end
			end
		end
		Bottom.Action.Visible = showAction
		Top.ContractDesc.Visible = not seasonPassBlocked
		Top.SeasonPassIcon.Visible = seasonPassBlocked
		Bottom.SeasonPassUnlockText.Visible = seasonPassBlocked
		self:_updateProgress()
	end
end
function ContractUI.Destroy(self)
	assert(self._maid ~= nil)
	self._maid:Destroy()
	self._maid = nil
	setmetatable(self, nil)
end
return ContractUI
