-- Reviewed by Claude
local LocalPlayer = game:GetService("Players").LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
local Audio = require(ReplicatedStorage.Std.Audio)
local Settings = require(ReplicatedStorage.Resource.Settings)
local Maid = require(ReplicatedStorage.Std.Maid)
local Promise = require(ReplicatedStorage.Std.Promise)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local Interval = require(ReplicatedStorage.Std.Interval)
local GameUtil = require(ReplicatedStorage.Game.GameUtil)
local Window = require(ReplicatedStorage.Module.Window.Window)
local ContractBinder = require(script.Parent.ContractBinder)
local ContractUI = require(script.Parent.ContractUI)
local SeasonConsts = require(ReplicatedStorage.Game.Season.SeasonConsts)
local ContractConsts = require(script.Parent.ContractConsts)
local SeasonUIUtils = require(ReplicatedStorage.Game.Season.SeasonUIUtils)
local SeasonUtils = require(ReplicatedStorage.Game.Season.SeasonUtils)
local SeasonSystem = require(ReplicatedStorage.Game.Season.SeasonSystem)
local v1 = nil
local v2 = nil
local function SelectIfGamepad(p1)
	EzUtils.selectIfGamepad(p1)
end
local t = {}
function t.init()
	v1 = require(ReplicatedStorage.Game.Season.SeasonUISystem)
	v2 = require(script.Parent.ContractSystem)
	local ContractsGui = ReplicatedStorage.StarterGui:FindFirstChild("ContractsGui")
	ContractsGui.Parent = LocalPlayer.PlayerGui
	t.gui = ContractsGui
	local ContractPopupGui = ReplicatedStorage.StarterGui:FindFirstChild("ContractPopupGui")
	ContractPopupGui.Parent = LocalPlayer.PlayerGui
	t.popupGui = ContractPopupGui
	t._contractPreset = ContractsGui.Background.Body.Main.Preset
	t._contractPreset.Visible = false
	waitForChild(LocalPlayer, ContractConsts.DEADLINE_VALUE_NAME):andThen(function(p1)
		t._deadlineValue = p1
		Interval.every(1):Connect(t._updateDeadline)
		t._updateDeadline()
		t._deadlineValue:GetPropertyChangedSignal("Value"):Connect(t._updateDeadline)
	end)
	local v12 = Window.new()
	v12:GetOnOpenedSignal():Connect(t._open)
	v12:GetOnClosedSignal():Connect(t._close)
	t._window = v12
	GameUtil.getCenterWindowGroup():Add(v12)
	local function hookContract(p1)
		p1._maid:GiveTask(p1:GetOnStateChangedSignal():Connect(function(p12, p2)
			if p12 == ContractConsts.enumState.COMPLETED or (p12 == ContractConsts.enumState.FAILED or p12 == ContractConsts.enumState.ABORTED) then
				local v1 = nil
				if p12 == ContractConsts.enumState.COMPLETED then
					Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105462848)
					v1 = "COMPLETED"
				elseif p12 == ContractConsts.enumState.FAILED then
					Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105462626)
					v1 = "FAILED"
				elseif p12 == ContractConsts.enumState.ABORTED then
					Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105462626)
					v1 = "ABORTED"
				end
				local v2 = t._contractPreset:Clone()
				v2.Size = UDim2.new(1, 0, 1, 0)
				v2.Visible = true
				v2.Parent = ContractPopupGui.Container
				local v3 = ContractUI.new()
				v3:SetFrame(v2)
				v3:SetContract(p1)
				v3:SetTitle(v1)
				Promise.delay(10):andThen(function()
					v3:Destroy()
					v3 = nil
				end):andThen(function()
					v2:Destroy()
					v2 = nil
				end)
			end
		end))
	end
	for i, v in ipairs(ContractBinder:GetAll()) do
		if v:GetPlayer() == LocalPlayer then
			v._maid:GiveTask(v:GetOnStateChangedSignal():Connect(function(p1, p2)
				if p1 == ContractConsts.enumState.COMPLETED or (p1 == ContractConsts.enumState.FAILED or p1 == ContractConsts.enumState.ABORTED) then
					local v1 = nil
					if p1 == ContractConsts.enumState.COMPLETED then
						Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105462848)
						v1 = "COMPLETED"
					elseif p1 == ContractConsts.enumState.FAILED then
						Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105462626)
						v1 = "FAILED"
					elseif p1 == ContractConsts.enumState.ABORTED then
						Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105462626)
						v1 = "ABORTED"
					end
					local v2 = t._contractPreset:Clone()
					v2.Size = UDim2.new(1, 0, 1, 0)
					v2.Visible = true
					v2.Parent = ContractPopupGui.Container
					local v3 = ContractUI.new()
					v3:SetFrame(v2)
					v3:SetContract(v)
					v3:SetTitle(v1)
					Promise.delay(10):andThen(function()
						v3:Destroy()
						v3 = nil
					end):andThen(function()
						v2:Destroy()
						v2 = nil
					end)
				end
			end))
		end
	end
	ContractBinder:GetClassAddedSignal():Connect(function(p1)
		if p1:GetPlayer() == LocalPlayer then
			p1._maid:GiveTask(p1:GetOnStateChangedSignal():Connect(function(p12, p2)
				if p12 == ContractConsts.enumState.COMPLETED or (p12 == ContractConsts.enumState.FAILED or p12 == ContractConsts.enumState.ABORTED) then
					local v1 = nil
					if p12 == ContractConsts.enumState.COMPLETED then
						Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105462848)
						v1 = "COMPLETED"
					elseif p12 == ContractConsts.enumState.FAILED then
						Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105462626)
						v1 = "FAILED"
					elseif p12 == ContractConsts.enumState.ABORTED then
						Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105462626)
						v1 = "ABORTED"
					end
					local v2 = t._contractPreset:Clone()
					v2.Size = UDim2.new(1, 0, 1, 0)
					v2.Visible = true
					v2.Parent = ContractPopupGui.Container
					local v3 = ContractUI.new()
					v3:SetFrame(v2)
					v3:SetContract(p1)
					v3:SetTitle(v1)
					Promise.delay(10):andThen(function()
						v3:Destroy()
						v3 = nil
					end):andThen(function()
						v2:Destroy()
						v2 = nil
					end)
				end
			end))
		end
	end)
end
function t._updateDeadline()
	t.gui.Background.Timer.Time.Text = SeasonUtils.formatRemaining((math.max(0, t._deadlineValue.Value - DateTime.now().UnixTimestamp)))
end
function t.clearContracts()
	local _contractPreset = t._contractPreset
	for i, v in ipairs(t.gui:GetChildren()) do
		if v.ClassName == _contractPreset.ClassName and v ~= _contractPreset then
			v:Destroy()
		end
	end
	if t._listContractUI then
		for i, v in ipairs(t._listContractUI) do
			v:Destroy()
		end
		t._listContractUI = nil
	end
end
function t.loadContracts(p1)
	t._lastTeamIdLoaded = p1
	local gui = t.gui
	local _contractPreset = t._contractPreset
	assert(not t._listContractUI)
	t._listContractUI = {}
	local v22 = v2.getContracts()
	local v3 = #v22 == 0
	gui.Background.Body.Main.ThankYou.Visible = v3
	if v3 then
		gui.Background.Body.Main.ThankYou.Text = ("Season %d is over! Thanks for playing!"):format(SeasonConsts.SEASON_NUM)
	else
		local count = 0
		for i, v in ipairs(v22) do
			if v:GetTeamId() == p1 then
				count = count + 1
				local v4 = _contractPreset:Clone()
				v4.Visible = true
				v4.Parent = _contractPreset.Parent
				local v5 = ContractUI.new()
				v5:SetFrame(v4)
				v5:SetContract(v)
				v5:SetLayoutOrder(i)
				v5:SetTitle(("CONTRACT %d"):format(count))
				table.insert(t._listContractUI, v5)
			end
		end
	end
end
function t.reloadContracts()
	t.clearContracts()
	t.loadContracts(t._lastTeamIdLoaded)
end
function t._open()
	assert(not t._maid)
	local v2 = Maid.new()
	t._maid = v2
	local gui = t.gui
	gui.Enabled = true
	v2:GiveTask(function()
		gui.Enabled = false
	end)
	local v3 = if GameUtil.Team == Settings.EnumTeam.Police then Settings.EnumTeam.Police else Settings.EnumTeam.Criminal
	t.clearContracts()
	t.loadContracts(v3)
	v2:GiveTask(ContractBinder:GetClassAddedSignal():Connect(function(p1)
		if p1:GetPlayer() == LocalPlayer then
			t.reloadContracts()
		end
	end))
	v2:GiveTask(ContractBinder:GetClassRemovingSignal():Connect(function(p1)
		if p1:GetPlayer() == LocalPlayer then
			Promise.delay(0.1):andThenCall(t.reloadContracts)
		end
	end))
	v2:GiveTask(gui.Background.Body.Side.Criminal.Button.MouseButton1Down:Connect(function()
		t.clearContracts()
		t.loadContracts(Settings.EnumTeam.Criminal)
		Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105461542)
	end))
	v2:GiveTask(gui.Background.Body.Side.Police.Button.MouseButton1Down:Connect(function()
		t.clearContracts()
		t.loadContracts(Settings.EnumTeam.Police)
		Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105461542)
	end))
	v2:GiveTask(gui.Background.Bottom.Container.RewardButton.MouseButton1Down:Connect(function()
		t.close()
		v1.open()
		Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105461542)
	end))
	gui.Background.Bottom.Container.SeasonPass.Title.Text = ("SEASON %d: %s"):format(SeasonConsts.SEASON_NUM, SeasonConsts.SEASON_TITLE)
	v2:GiveTask(gui.Background.Bottom.Container.SeasonPass.MouseButton1Down:Connect(function()
		local v1 = Settings.getFirstProductByType("SeasonPass")
		assert(v1 ~= nil)
		Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105461542)
		if not SeasonSystem.doesPlayerOwnSeasonPass(LocalPlayer) then
			MarketplaceService:PromptProductPurchase(LocalPlayer, v1.Id)
		end
	end))
	EzUtils.selectIfGamepad(gui.Background.Bottom.Container.SeasonPass)
	SeasonUIUtils.hookGiftContainer(gui.Background.GiftContainer, v2)
	local function setOwnsSeasonPass()
		gui.Background.Bottom.Container.SeasonPass.Buy.Visible = false
		gui.Background.Bottom.Container.SeasonPass.Price.Visible = false
		gui.Background.Bottom.Container.SeasonPass.Owned.Visible = true
	end
	if SeasonSystem.doesPlayerOwnSeasonPass(LocalPlayer) then
		gui.Background.Bottom.Container.SeasonPass.Buy.Visible = false
		gui.Background.Bottom.Container.SeasonPass.Price.Visible = false
		gui.Background.Bottom.Container.SeasonPass.Owned.Visible = true
	else
		v2:GiveTask(SeasonSystem.getSeasonPassOwnedSignal():Connect(function(p1)
			if p1 == LocalPlayer then
				gui.Background.Bottom.Container.SeasonPass.Buy.Visible = false
				gui.Background.Bottom.Container.SeasonPass.Price.Visible = false
				gui.Background.Bottom.Container.SeasonPass.Owned.Visible = true
			end
		end))
	end
	v2:GiveTask(gui.Background.Close.MouseButton1Down:Connect(t.close))
	local function updatePrice()
		local v1 = Settings.getFirstProductByType("SeasonPass")
		if v1 and v1.Robux then
			gui.Background.Bottom.Container.SeasonPass.Price.Text = tostring(v1.Robux)
		end
	end
	local v4 = Settings.getFirstProductByType("SeasonPass")
	if v4 and v4.Robux then
		gui.Background.Bottom.Container.SeasonPass.Price.Text = tostring(v4.Robux)
	end
	Settings.OnProductsFetched:Connect(updatePrice)
end
function t._close()
	local _maid = t._maid
	assert(_maid)
	t._maid = nil
	_maid:Destroy()
end
function t.open()
	t._window:Open()
end
function t.close()
	t._window:Close()
end
return t
