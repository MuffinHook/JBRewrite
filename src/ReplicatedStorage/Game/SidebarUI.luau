local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Notification = require(script.Parent.Notification)
local Audio = require(ReplicatedStorage.Std.Audio)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local Signal = require(ReplicatedStorage.Std.Signal)
local Utils = require(ReplicatedStorage.EzUi.Utils)
local Roact = require(ReplicatedStorage.Roact)
require(ReplicatedStorage.Policy.PolicyService)
local Confirmation = require(ReplicatedStorage.Module.Confirmation)
local TeamShared = require(ReplicatedStorage.App.TeamShared)
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local Settings = require(ReplicatedStorage.Resource.Settings)
local RunConsts = require(ReplicatedStorage.App.RunConsts)
local WorldTeleportConsts = require(ReplicatedStorage.WorldTeleport.WorldTeleportConsts)
require(ReplicatedStorage.PrivateServer.PrivateServerUtils)
local createElement = Roact.createElement
local store = require(ReplicatedStorage.App.store)
local BigButtonService = require(ReplicatedStorage.App.BigButtonService)
local TopbarHolder = require(ReplicatedStorage.App.UI.TopbarHolder)
local t = {
	onDevPanelToggle = Signal.new(),
	onGarageToggle = Signal.new()
}
local timeBinding, updateTimeBinding = Roact.createBinding("4:00 PM")
t.time = timeBinding
t.updateTime = updateTimeBinding
function t.Init(initConfig)
	local em = initConfig.em
	local switchTeamEvent = initConfig.Event
	local CashBuyUI = require(ReplicatedStorage.Game.CashBuyUI)
	local garageButtonRef = Roact.createRef()
	BigButtonService.add({
		name = "Garage",
		imageId = 8733342027,
		displayOrder = 10,
		ref = garageButtonRef,
		onClick = function()
			t.onGarageToggle:Fire()
		end
	})
	UserInputService.InputBegan:Connect(function(input, isGamepad)
		if not isGamepad and input.KeyCode == Enum.KeyCode.DPadUp then
			t.onGarageToggle:Fire()
		end
	end)
	local teamSwitchConfirmation = nil
	TeamShared.promiseIsTeamSwitchingEnabled():andThen(function(isTeamSwitchEnabled)
		if isTeamSwitchEnabled then
			BigButtonService.add({
				name = "TeamSwitch",
				imageId = 4912231691,
				displayOrder = 20,
				onClick = function()
					local ChoosingTeam = Players.LocalPlayer:FindFirstChild("ChoosingTeam")
					if ChoosingTeam and ChoosingTeam.Value then
					elseif teamSwitchConfirmation == nil then
						teamSwitchConfirmation = Confirmation.new("Are you sure you want to switch teams?")
						teamSwitchConfirmation.OnYes:Connect(function()
							teamSwitchConfirmation = nil
							switchTeamEvent:FireServer("switchTeams")
						end)
						teamSwitchConfirmation.OnNo:Connect(function()
							teamSwitchConfirmation = nil
						end)
					else
						teamSwitchConfirmation:Destroy()
						teamSwitchConfirmation = nil
					end
				end
			})
		end
	end)
	BigButtonService.add({
		name = "Cash",
		imageId = 4912231216,
		displayOrder = 30,
		onClick = function()
			if t.ShopAlreadyLoading then
			elseif CashBuyUI.IsOpen == false then
				if not CashBuyUI.Loaded then
					t.ShopAlreadyLoading = true
					Notification.new({
						Text = "Loading Store... Please wait!"
					})
					CashBuyUI.OnLoaded:Wait()
					t.ShopAlreadyLoading = false
				end
				CashBuyUI.Open()
			else
				CashBuyUI.Close()
			end
		end
	})
	t.safesButton = {
		name = "Safes",
		imageId = 10313420284,
		imageScale = 0.9,
		displayOrder = 40,
		onClick = function()
			if Players.LocalPlayer.PlayerGui then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
					Volume = 0.15
				})
			end
			store:dispatch({
				type = "toggleSafesOpen"
			})
		end
	}
	BigButtonService.add(t.safesButton)
	t.settingsButton = {
		name = "Settings",
		imageId = 8733343021,
		displayOrder = 50,
		onClick = function()
			t.onDevPanelToggle:Fire()
		end
	}
	BigButtonService.add(t.settingsButton)
	if not RunUtils.isMainWorld() and RunUtils.isTradeWorld() then
		BigButtonService.add({
			name = "Trade",
			imageId = 9857392770,
			displayOrder = 60,
			onClick = function()
				if Players.LocalPlayer.PlayerGui then
					Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
						Volume = 0.15
					})
				end
				store:dispatch({
					type = "setTradeInventoryOpen",
					value = not store:getState().tradeInventoryOpen
				})
			end
		})
	end
	if RunUtils.isTradeWorld() then
		local function doesHaveVIP()
			return GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.TradingVIP)
		end
		local goHomeButtonConfig = {
			name = "GoHome",
			displayOrder = 70,
			onClick = function()
				if Players.LocalPlayer.PlayerGui then
					Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
						Volume = 0.15
					})
				end
				if GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.TradingVIP) then
					if teamSwitchConfirmation == nil then
						teamSwitchConfirmation = Confirmation.new("Are you sure you want to return to Jailbreak?")
						teamSwitchConfirmation.OnYes:Connect(function()
							teamSwitchConfirmation = nil
							ReplicatedStorage:FindFirstChild(WorldTeleportConsts.TELEPORT_TO_WORLD_FROM_TEAM_SWITCH_NAME):FireServer(RunConsts.MAIN_WORLD_NAME)
						end)
						teamSwitchConfirmation.OnNo:Connect(function()
							teamSwitchConfirmation = nil
						end)
					else
						teamSwitchConfirmation:Destroy()
						teamSwitchConfirmation = nil
					end
				else
					GamepassUtils.PromptGamepass(GamepassUtils.EnumGamepass.TradingVIP)
				end
			end
		}
		local function updateProps()
			goHomeButtonConfig.imageId = if GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.TradingVIP) then 10087230550 else 10087230159
		end
		goHomeButtonConfig.imageId = if GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.TradingVIP) then 10087230550 else 10087230159
		BigButtonService.add(goHomeButtonConfig)
		GamepassSystem.GetGamepassOwnedSignal(GamepassUtils.EnumGamepass.TradingVIP):Connect(function()
			goHomeButtonConfig.imageId = if GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.TradingVIP) then 10087230550 else 10087230159
			BigButtonService.triggerUpdate:Fire()
		end)
	end
	local GameUtil = require(ReplicatedStorage.Game.GameUtil)
	function em.zyfagb6d(role)
		if not (role == "Criminal") then
			GameUtil.bounty = 0
			GameUtil.onBountyChanged:Fire(GameUtil.bounty)
		end
	end
	function em.rglritaz(bountyAmount)
		GameUtil.bounty = bountyAmount
		GameUtil.onBountyChanged:Fire(GameUtil.bounty)
	end
	t.SetSafeCount(0)
	store.changed:connect(function(newState, previousState)
		if newState.safesInventoryItems ~= previousState.safesInventoryItems then
			t.SetSafeCount(#newState.safesInventoryItems)
		end
	end)
	UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Gamepad1 and (input.KeyCode == Enum.KeyCode.ButtonSelect and GuiService.SelectedObject ~= nil) then
			Utils.selectIfGamepad(garageButtonRef:getValue())
		end
	end)
	local function getComponent()
		local isSmallScreen = Utils.isSmallScreen()
		local screenGuiProps = {
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets,
			ResetOnSpawn = false
		}
		local screenGuiChildren = {}
		screenGuiChildren.Buttons = if isSmallScreen then createElement(TopbarHolder, {
	color = Settings.TeamColor[GameUtil.Team],
	buttons = BigButtonService.active
}) else nil
		return createElement("ScreenGui", screenGuiProps, screenGuiChildren)
	end
	local mountedGui = Roact.mount(getComponent(), Players.LocalPlayer.PlayerGui, "SidebarGui")
	local resizeDebounceTask = nil
	Utils.getViewportSizeChangedSignal():Connect(function()
		if resizeDebounceTask then
			task.cancel(resizeDebounceTask)
		end
		resizeDebounceTask = task.delay(0.1, function()
			Roact.update(mountedGui, getComponent())
			resizeDebounceTask = nil
		end)
	end)
	GameUtil.OnTeamChanged:Connect(function(newTeam)
		Roact.update(mountedGui, getComponent())
	end)
end
function t.SetTime(timeString)
	t.updateTime(timeString)
end
function t.SetSafeCount(safeCount)
	if t.safesButton then
		t.safesButton.count = safeCount
		BigButtonService.triggerUpdate:Fire()
	end
end
return t
