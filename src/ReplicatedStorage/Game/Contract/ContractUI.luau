-- Reviewed by Claude
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
local t = {}
t.__index = t
t.__ClassName = "ContractUI"
function t.new()
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	return t2
end
function t.SetFrame(p1, p2)
	assert(p2 ~= nil)
	assert(not p1._frame)
	p1._frame = p2
	p1._maid:GiveTask(p1._frame)
	p1._maid:GiveTask(p1._frame.Background.Body.Bottom.Action.MouseButton1Down:Connect(function()
		Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105461542)
		if p1._contract:GetStateId() == ContractConsts.enumState.ACTIVE then
			local v1 = Confirmation.new(("Re-roll for a random contract for $%s?"):format(String.comma(ContractConsts.REROLL_PRICE)))
			v1.Maid:GiveTask(v1.OnYes:Connect(function()
				p1._contract._contractActionRemote:FireServer()
			end))
			p1._contract._rerollConfirm = v1
		else
			p1._contract._contractActionRemote:FireServer()
		end
	end))
	p1._maid:GiveTask(ContractSystem.getAnyContractActiveTransitionSignal():Connect(function()
		if getmetatable(p1) == nil then
			return
		end
		if getmetatable(p1._contract) ~= nil then
			p1:_updateState(p1._contract:GetStateId())
		end
	end))
end
function t.SetLayoutOrder(p1, p2)
	assert(p2 ~= nil)
	p1._frame.LayoutOrder = p2
end
function t.SetContract(p1, p2)
	assert(not p1._contract)
	p1._contract = p2
	p1._maid:GiveTask(p1._contract:GetProgressValue():GetPropertyChangedSignal("Value"):Connect(function()
		p1:_updateProgress()
	end))
	p1:_updateProgress()
	local function updateState()
		p1:_updateState(p1._contract:GetStateId())
	end
	p1._maid:GiveTask(p1._contract:GetRequireSeasonPassValue():GetPropertyChangedSignal("Value"):Connect(updateState))
	p1._maid:GiveTask(p1._contract:GetStateValue():GetPropertyChangedSignal("Value"):Connect(updateState))
	p1._maid:GiveTask(ContractUtils.getNumTimesRerolledObject(p1._contract.obj).Changed:Connect(updateState))
	p1:_updateState(p1._contract:GetStateId())
	p1._maid:GiveTask(SeasonSystem.getSeasonPassOwnedSignal():Connect(function(p12)
		if p12 == LocalPlayer then
			p1:_updateState(p1._contract:GetStateId())
		end
	end))
	p1._frame.Name = p1._contract:GetName()
	p1:_setTeamId(p1._contract:GetTeamId())
	p1:_setRewardExp(p1._contract:GetRewardExp())
	p1:_setMessage(p1._contract:GetMessage())
end
function t.SetTitle(p1, p2)
	p1._frame.Background.Title.TextLabel.Text = p2
end
function t._setMessage(p1, p2)
	p1._frame.Background.Body.Top.ContractDesc.Text = p2
end
function t._setRewardExp(p1, p2)
	p1._frame.Background.Body.Bottom.Reward.Amount.Text = ("REWARD: %d XP"):format(p2)
end
function t._setTeamId(p1, p2)
	local v1 = nil
	if p2 == Settings.EnumTeam.Police then
		v1 = 5955472455
	elseif p2 == Settings.EnumTeam.Criminal then
		v1 = 5955427564
	else
		error(("Invalid teamId: %d"):format(p2))
	end
	p1._frame.Background.Image = ("rbxassetid://%d"):format(v1)
end
function t._updateProgress(p1)
	local v1 = if p1._contract:GetStateId() == ContractConsts.enumState.ACTIVE then p1._contract:GetProgress() else nil
	local Bottom = p1._frame.Background.Body.Bottom
	Bottom.Progress.Visible = v1 ~= nil
	if v1 ~= nil then
		Bottom.Progress.Text = ("PROGRESS: %d/%d"):format(p1._contract:GetProgress(), p1._contract:GetGoal())
	end
end
function t._updateState(p1, p2)
	if getmetatable(p1) ~= nil then
		local v1 = nil
		local v2 = nil
		local v3 = GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.VIP)
		if p2 == ContractConsts.enumState.ACCEPTABLE then
			v1 = 5955426934
			v2 = "ACCEPT"
		elseif p2 == ContractConsts.enumState.ACTIVE and ContractUtils.canReroll(p1._contract.obj, v3) then
			v1 = 5955427217
			v2 = "RE-ROLL"
		elseif p2 ~= ContractConsts.enumState.FAILED and (p2 ~= ContractConsts.enumState.ABORTED and p2 == ContractConsts.enumState.COMPLETED) then
			v1 = 5955427217
			v2 = "COMPLETED"
		end
		local _frame = p1._frame
		local Top = _frame.Background.Body.Top
		local Bottom = _frame.Background.Body.Bottom
		if v1 and v2 then
			Bottom.Action.Image = ("rbxassetid://%d"):format(v1)
			Bottom.Action.TextLabel.Text = v2
			if p2 == ContractConsts.enumState.ACTIVE then
				Bottom.Action.TextLabel.TextColor3 = Color3.new(255/255, 0/255, 0/255)
				Bottom.Action.ImageColor3 = Color3.new(255/255, 0/255, 0/255)
			else
				Bottom.Action.TextLabel.TextColor3 = Color3.new(255/255, 255/255, 255/255)
				Bottom.Action.ImageColor3 = Color3.new(255/255, 255/255, 255/255)
			end
		end
		local v4 = p1._contract:GetRequireSeasonPass()
		local v6 = v4 and not SeasonSystem.doesPlayerOwnSeasonPass(LocalPlayer)
		local v7 = ContractSystem.getActiveContract(p1._contract:GetTeamId())
		local v8 = if v7 == nil or (v7 == p1._contract or p2 == ContractConsts.enumState.COMPLETED) then false else not v6 and not ContractConsts.ALLOW_MULTIPLE_ACTIVE
		Bottom.OneActive.Visible = v8
		local v9 = if p2 == ContractConsts.enumState.ABORTED or p2 == ContractConsts.enumState.FAILED then not v8 else false
		Bottom.Retry.Visible = v9
		if v9 then
			local function updateRetryTimer()
				Bottom.Retry.Text = ("RETRY AVAILABLE IN: %s"):format((SeasonUtils.formatRemaining((math.max(ContractConsts.COOLDOWN_DURATION - (DateTime.now().UnixTimestamp - p1._contract:GetLastStateUpdate()), 0)))))
			end
			p1._maid.stateUpdateLoop = Interval.every(1):Connect(updateRetryTimer)
			updateRetryTimer()
		else
			p1._maid.stateUpdateLoop = nil
		end
		local v10
		if p2 == ContractConsts.enumState.ABORTED or p2 == ContractConsts.enumState.FAILED then
			v10 = false
		else
			v10 = not v8
			if v10 then
				v10 = not v6
				if v10 then
					v10 = not if p2 == ContractConsts.enumState.ACTIVE then not ContractUtils.canReroll(p1._contract.obj, v3) else false
				end
			end
		end
		Bottom.Action.Visible = v10
		Top.ContractDesc.Visible = not v6
		Top.SeasonPassIcon.Visible = v6
		Bottom.SeasonPassUnlockText.Visible = v6
		p1:_updateProgress()
	end
end
function t.Destroy(p1)
	assert(p1._maid ~= nil)
	p1._maid:Destroy()
	p1._maid = nil
	setmetatable(p1, nil)
end
return t
