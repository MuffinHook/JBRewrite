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
local seasonUISystem = nil
local contractSystem = nil
local function SelectIfGamepad(button)
	EzUtils.selectIfGamepad(button)
end
local ContractUISystem = {}
function ContractUISystem.init()
	seasonUISystem = require(ReplicatedStorage.Game.Season.SeasonUISystem)
	contractSystem = require(script.Parent.ContractSystem)
	local ContractsGui = ReplicatedStorage.StarterGui:FindFirstChild("ContractsGui")
	ContractsGui.Parent = LocalPlayer.PlayerGui
	ContractUISystem.gui = ContractsGui
	local ContractPopupGui = ReplicatedStorage.StarterGui:FindFirstChild("ContractPopupGui")
	ContractPopupGui.Parent = LocalPlayer.PlayerGui
	ContractUISystem.popupGui = ContractPopupGui
	ContractUISystem._contractPreset = ContractsGui.Background.Body.Main.Preset
	ContractUISystem._contractPreset.Visible = false
	waitForChild(LocalPlayer, ContractConsts.DEADLINE_VALUE_NAME):andThen(function(deadlineValue)
		ContractUISystem._deadlineValue = deadlineValue
		Interval.every(1):Connect(ContractUISystem._updateDeadline)
		ContractUISystem._updateDeadline()
		ContractUISystem._deadlineValue:GetPropertyChangedSignal("Value"):Connect(ContractUISystem._updateDeadline)
	end)
	local windowInstance = Window.new()
	windowInstance:GetOnOpenedSignal():Connect(ContractUISystem._open)
	windowInstance:GetOnClosedSignal():Connect(ContractUISystem._close)
	ContractUISystem._window = windowInstance
	GameUtil.getCenterWindowGroup():Add(windowInstance)
	local function hookContract(contract)
		contract._maid:GiveTask(contract:GetOnStateChangedSignal():Connect(function(newState, previousState)
			if newState == ContractConsts.enumState.COMPLETED or (newState == ContractConsts.enumState.FAILED or newState == ContractConsts.enumState.ABORTED) then
				local statusString = nil
				if newState == ContractConsts.enumState.COMPLETED then
					Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105462848)
					statusString = "COMPLETED"
				elseif newState == ContractConsts.enumState.FAILED then
					Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105462626)
					statusString = "FAILED"
				elseif newState == ContractConsts.enumState.ABORTED then
					Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105462626)
					statusString = "ABORTED"
				end
				local clonedPreset = ContractUISystem._contractPreset:Clone()
				clonedPreset.Size = UDim2.new(1, 0, 1, 0)
				clonedPreset.Visible = true
				clonedPreset.Parent = ContractPopupGui.Container
				local contractUI = ContractUI.new()
				contractUI:SetFrame(clonedPreset)
				contractUI:SetContract(contract)
				contractUI:SetTitle(statusString)
				Promise.delay(10):andThen(function()
					contractUI:Destroy()
					contractUI = nil
				end):andThen(function()
					clonedPreset:Destroy()
					clonedPreset = nil
				end)
			end
		end))
	end
	for i, contract in ipairs(ContractBinder:GetAll()) do
		if contract:GetPlayer() == LocalPlayer then
			contract._maid:GiveTask(contract:GetOnStateChangedSignal():Connect(function(newState, previousState)
				if newState == ContractConsts.enumState.COMPLETED or (newState == ContractConsts.enumState.FAILED or newState == ContractConsts.enumState.ABORTED) then
					local statusString = nil
					if newState == ContractConsts.enumState.COMPLETED then
						Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105462848)
						statusString = "COMPLETED"
					elseif newState == ContractConsts.enumState.FAILED then
						Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105462626)
						statusString = "FAILED"
					elseif newState == ContractConsts.enumState.ABORTED then
						Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105462626)
						statusString = "ABORTED"
					end
					local clonedPreset = ContractUISystem._contractPreset:Clone()
					clonedPreset.Size = UDim2.new(1, 0, 1, 0)
					clonedPreset.Visible = true
					clonedPreset.Parent = ContractPopupGui.Container
					local contractUI = ContractUI.new()
					contractUI:SetFrame(clonedPreset)
					contractUI:SetContract(contract)
					contractUI:SetTitle(statusString)
					Promise.delay(10):andThen(function()
						contractUI:Destroy()
						contractUI = nil
					end):andThen(function()
						clonedPreset:Destroy()
						clonedPreset = nil
					end)
				end
			end))
		end
	end
	ContractBinder:GetClassAddedSignal():Connect(function(contract)
		if contract:GetPlayer() == LocalPlayer then
			contract._maid:GiveTask(contract:GetOnStateChangedSignal():Connect(function(newState, previousState)
				if newState == ContractConsts.enumState.COMPLETED or (newState == ContractConsts.enumState.FAILED or newState == ContractConsts.enumState.ABORTED) then
					local statusString = nil
					if newState == ContractConsts.enumState.COMPLETED then
						Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105462848)
						statusString = "COMPLETED"
					elseif newState == ContractConsts.enumState.FAILED then
						Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105462626)
						statusString = "FAILED"
					elseif newState == ContractConsts.enumState.ABORTED then
						Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105462626)
						statusString = "ABORTED"
					end
					local clonedPreset = ContractUISystem._contractPreset:Clone()
					clonedPreset.Size = UDim2.new(1, 0, 1, 0)
					clonedPreset.Visible = true
					clonedPreset.Parent = ContractPopupGui.Container
					local contractUI = ContractUI.new()
					contractUI:SetFrame(clonedPreset)
					contractUI:SetContract(contract)
					contractUI:SetTitle(statusString)
					Promise.delay(10):andThen(function()
						contractUI:Destroy()
						contractUI = nil
					end):andThen(function()
						clonedPreset:Destroy()
						clonedPreset = nil
					end)
				end
			end))
		end
	end)
end
function ContractUISystem._updateDeadline()
	ContractUISystem.gui.Background.Timer.Time.Text = SeasonUtils.formatRemaining((math.max(0, ContractUISystem._deadlineValue.Value - DateTime.now().UnixTimestamp)))
end
function ContractUISystem.clearContracts()
	local _contractPreset = ContractUISystem._contractPreset
	for i, child in ipairs(ContractUISystem.gui:GetChildren()) do
		if child.ClassName == _contractPreset.ClassName and child ~= _contractPreset then
			child:Destroy()
		end
	end
	if ContractUISystem._listContractUI then
		for i, contractUI in ipairs(ContractUISystem._listContractUI) do
			contractUI:Destroy()
		end
		ContractUISystem._listContractUI = nil
	end
end
function ContractUISystem.loadContracts(teamId)
	ContractUISystem._lastTeamIdLoaded = teamId
	local gui = ContractUISystem.gui
	local _contractPreset = ContractUISystem._contractPreset
	assert(not ContractUISystem._listContractUI)
	ContractUISystem._listContractUI = {}
	local contractsList = contractSystem.getContracts()
	local noContracts = #contractsList == 0
	gui.Background.Body.Main.ThankYou.Visible = noContracts
	if noContracts then
		gui.Background.Body.Main.ThankYou.Text = ("Season %d is over! Thanks for playing!"):format(SeasonConsts.SEASON_NUM)
	else
		local count = 0
		for i, contract in ipairs(contractsList) do
			if contract:GetTeamId() == teamId then
				count = count + 1
				local clonedPresetFrame = _contractPreset:Clone()
				clonedPresetFrame.Visible = true
				clonedPresetFrame.Parent = _contractPreset.Parent
				local contractUI = ContractUI.new()
				contractUI:SetFrame(clonedPresetFrame)
				contractUI:SetContract(contract)
				contractUI:SetLayoutOrder(i)
				contractUI:SetTitle(("CONTRACT %d"):format(count))
				table.insert(ContractUISystem._listContractUI, contractUI)
			end
		end
	end
end
function ContractUISystem.reloadContracts()
	ContractUISystem.clearContracts()
	ContractUISystem.loadContracts(ContractUISystem._lastTeamIdLoaded)
end
function ContractUISystem._open()
	assert(not ContractUISystem._maid)
	local maidInstance = Maid.new()
	ContractUISystem._maid = maidInstance
	local gui = ContractUISystem.gui
	gui.Enabled = true
	maidInstance:GiveTask(function()
		gui.Enabled = false
	end)
	local selectedTeam = if GameUtil.Team == Settings.EnumTeam.Police then Settings.EnumTeam.Police else Settings.EnumTeam.Criminal
	ContractUISystem.clearContracts()
	ContractUISystem.loadContracts(selectedTeam)
	maidInstance:GiveTask(ContractBinder:GetClassAddedSignal():Connect(function(contract)
		if contract:GetPlayer() == LocalPlayer then
			ContractUISystem.reloadContracts()
		end
	end))
	maidInstance:GiveTask(ContractBinder:GetClassRemovingSignal():Connect(function(contract)
		if contract:GetPlayer() == LocalPlayer then
			Promise.delay(0.1):andThenCall(ContractUISystem.reloadContracts)
		end
	end))
	maidInstance:GiveTask(gui.Background.Body.Side.Criminal.Button.MouseButton1Down:Connect(function()
		ContractUISystem.clearContracts()
		ContractUISystem.loadContracts(Settings.EnumTeam.Criminal)
		Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105461542)
	end))
	maidInstance:GiveTask(gui.Background.Body.Side.Police.Button.MouseButton1Down:Connect(function()
		ContractUISystem.clearContracts()
		ContractUISystem.loadContracts(Settings.EnumTeam.Police)
		Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105461542)
	end))
	maidInstance:GiveTask(gui.Background.Bottom.Container.RewardButton.MouseButton1Down:Connect(function()
		ContractUISystem.close()
		seasonUISystem.open()
		Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105461542)
	end))
	gui.Background.Bottom.Container.SeasonPass.Title.Text = ("SEASON %d: %s"):format(SeasonConsts.SEASON_NUM, SeasonConsts.SEASON_TITLE)
	maidInstance:GiveTask(gui.Background.Bottom.Container.SeasonPass.MouseButton1Down:Connect(function()
		local seasonPassProduct = Settings.getFirstProductByType("SeasonPass")
		assert(seasonPassProduct ~= nil)
		Audio.ObjectLocal(LocalPlayer.PlayerGui, 6105461542)
		if not SeasonSystem.doesPlayerOwnSeasonPass(LocalPlayer) then
			MarketplaceService:PromptProductPurchase(LocalPlayer, seasonPassProduct.Id)
		end
	end))
	EzUtils.selectIfGamepad(gui.Background.Bottom.Container.SeasonPass)
	SeasonUIUtils.hookGiftContainer(gui.Background.GiftContainer, maidInstance)
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
		maidInstance:GiveTask(SeasonSystem.getSeasonPassOwnedSignal():Connect(function(player)
			if player == LocalPlayer then
				gui.Background.Bottom.Container.SeasonPass.Buy.Visible = false
				gui.Background.Bottom.Container.SeasonPass.Price.Visible = false
				gui.Background.Bottom.Container.SeasonPass.Owned.Visible = true
			end
		end))
	end
	maidInstance:GiveTask(gui.Background.Close.MouseButton1Down:Connect(ContractUISystem.close))
	local function updatePrice()
		local seasonPassProduct = Settings.getFirstProductByType("SeasonPass")
		if seasonPassProduct and seasonPassProduct.Robux then
			gui.Background.Bottom.Container.SeasonPass.Price.Text = tostring(seasonPassProduct.Robux)
		end
	end
	local seasonPassProduct = Settings.getFirstProductByType("SeasonPass")
	if seasonPassProduct and seasonPassProduct.Robux then
		gui.Background.Bottom.Container.SeasonPass.Price.Text = tostring(seasonPassProduct.Robux)
	end
	Settings.OnProductsFetched:Connect(updatePrice)
end
function ContractUISystem._close()
	local _maid = ContractUISystem._maid
	assert(_maid)
	ContractUISystem._maid = nil
	_maid:Destroy()
end
function ContractUISystem.open()
	ContractUISystem._window:Open()
end
function ContractUISystem.close()
	ContractUISystem._window:Close()
end
return ContractUISystem
