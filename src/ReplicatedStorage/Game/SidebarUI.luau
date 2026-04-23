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
local v1, v2 = Roact.createBinding("4:00 PM")
t.time = v1
t.updateTime = v2
function t.Init(p1) --[[ Line: 31 | Upvalues: ReplicatedStorage (copy), Roact (copy), BigButtonService (copy), t (copy), UserInputService (copy), TeamShared (copy), Players (copy), Confirmation (copy), Notification (copy), Audio (copy), store (copy), RunUtils (copy), GamepassSystem (copy), GamepassUtils (copy), WorldTeleportConsts (copy), RunConsts (copy), GuiService (copy), Utils (copy), Settings (copy), createElement (copy), TopbarHolder (copy) ]]
	local em = p1.em
	local v1 = p1.Event
	local CashBuyUI = require(ReplicatedStorage.Game.CashBuyUI)
	local v2 = Roact.createRef()
	BigButtonService.add({
		name = "Garage",
		imageId = 8733342027,
		displayOrder = 10,
		ref = v2,
		onClick = function() --[[ Name: onClick | Line: 43 | Upvalues: t (ref) ]]
			t.onGarageToggle:Fire()
		end
	})
	UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 48 | Upvalues: t (ref) ]]
		if not p2 and p1.KeyCode == Enum.KeyCode.DPadUp then
			t.onGarageToggle:Fire()
		end
	end)
	local v3 = nil
	TeamShared.promiseIsTeamSwitchingEnabled():andThen(function(p1) --[[ Line: 58 | Upvalues: BigButtonService (ref), Players (ref), v3 (ref), Confirmation (ref), v1 (copy) ]]
		if p1 then
			BigButtonService.add({
				name = "TeamSwitch",
				imageId = 4912231691,
				displayOrder = 20,
				onClick = function() --[[ Name: onClick | Line: 64 | Upvalues: Players (ref), v3 (ref), Confirmation (ref), v1 (ref) ]]
					local ChoosingTeam = Players.LocalPlayer:FindFirstChild("ChoosingTeam")
					if ChoosingTeam and ChoosingTeam.Value then
					elseif v3 == nil then
						v3 = Confirmation.new("Are you sure you want to switch teams?")
						v3.OnYes:Connect(function() --[[ Line: 78 | Upvalues: v3 (ref), v1 (ref) ]]
							v3 = nil
							v1:FireServer("l" .. "" .. ("y29g6ufpx"):sub(4, 7):reverse() .. "" .. "" .. ("g1brs4r"):sub(5, 6):reverse() .. "2")
						end)
						v3.OnNo:Connect(function() --[[ Line: 82 | Upvalues: v3 (ref) ]]
							v3 = nil
						end)
					else
						v3:Destroy()
						v3 = nil
					end
				end
			})
		end
	end)
	BigButtonService.add({
		name = "Cash",
		imageId = 4912231216,
		displayOrder = 30,
		onClick = function() --[[ Name: onClick | Line: 95 | Upvalues: t (ref), CashBuyUI (copy), Notification (ref) ]]
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
		onClick = function() --[[ Name: onClick | Line: 118 | Upvalues: Players (ref), Audio (ref), store (ref) ]]
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
		onClick = function() --[[ Name: onClick | Line: 133 | Upvalues: t (ref) ]]
			t.onDevPanelToggle:Fire()
		end
	}
	BigButtonService.add(t.settingsButton)
	if not RunUtils.isMainWorld() and RunUtils.isTradeWorld() then
		BigButtonService.add({
			name = "Trade",
			imageId = 9857392770,
			displayOrder = 60,
			onClick = function() --[[ Name: onClick | Line: 153 | Upvalues: Players (ref), Audio (ref), store (ref) ]]
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
		local function doesHaveVIP() --[[ Line: 170 | Upvalues: GamepassSystem (ref), GamepassUtils (ref) ]]
			return GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.TradingVIP)
		end
		local t2 = {
			name = "GoHome",
			displayOrder = 70,
			onClick = function() --[[ Name: onClick | Line: 176 | Upvalues: Players (ref), Audio (ref), GamepassSystem (ref), GamepassUtils (ref), v3 (ref), Confirmation (ref), ReplicatedStorage (ref), WorldTeleportConsts (ref), RunConsts (ref) ]]
				if Players.LocalPlayer.PlayerGui then
					Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
						Volume = 0.15
					})
				end
				if GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.TradingVIP) then
					if v3 == nil then
						v3 = Confirmation.new("Are you sure you want to return to Jailbreak?")
						v3.OnYes:Connect(function() --[[ Line: 186 | Upvalues: v3 (ref), ReplicatedStorage (ref), WorldTeleportConsts (ref), RunConsts (ref) ]]
							v3 = nil
							ReplicatedStorage:FindFirstChild(WorldTeleportConsts.TELEPORT_TO_WORLD_FROM_TEAM_SWITCH_NAME):FireServer(RunConsts.MAIN_WORLD_NAME)
						end)
						v3.OnNo:Connect(function() --[[ Line: 193 | Upvalues: v3 (ref) ]]
							v3 = nil
						end)
					else
						v3:Destroy()
						v3 = nil
					end
				else
					GamepassUtils.PromptGamepass(GamepassUtils.EnumGamepass.TradingVIP)
				end
			end
		}
		local function updateProps() --[[ Line: 202 | Upvalues: t2 (copy), GamepassSystem (ref), GamepassUtils (ref) ]]
			t2.imageId = if GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.TradingVIP) then 10087230550 else 10087230159
		end
		t2.imageId = if GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.TradingVIP) then 10087230550 else 10087230159
		BigButtonService.add(t2)
		GamepassSystem.GetGamepassOwnedSignal(GamepassUtils.EnumGamepass.TradingVIP):Connect(function() --[[ Line: 207 | Upvalues: t2 (copy), GamepassSystem (ref), GamepassUtils (ref), BigButtonService (ref) ]]
			t2.imageId = if GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.TradingVIP) then 10087230550 else 10087230159
			BigButtonService.triggerUpdate:Fire()
		end)
	end
	local GameUtil = require(ReplicatedStorage.Game.GameUtil)
	function em.zyfagb6d(p1) --[[ Line: 214 | Upvalues: GameUtil (copy) ]]
		if not (p1 == "Criminal") then
			GameUtil.bounty = 0
			GameUtil.onBountyChanged:Fire(GameUtil.bounty)
		end
	end
	function em.rglritaz(p1) --[[ Line: 221 | Upvalues: GameUtil (copy) ]]
		GameUtil.bounty = p1
		GameUtil.onBountyChanged:Fire(GameUtil.bounty)
	end
	t.SetSafeCount(0)
	store.changed:connect(function(p1, p2) --[[ Line: 228 | Upvalues: t (ref) ]]
		if p1.safesInventoryItems ~= p2.safesInventoryItems then
			t.SetSafeCount(#p1.safesInventoryItems)
		end
	end)
	UserInputService.InputBegan:Connect(function(p1) --[[ Line: 238 | Upvalues: GuiService (ref), Utils (ref), v2 (copy) ]]
		if p1.UserInputType == Enum.UserInputType.Gamepad1 and (p1.KeyCode == Enum.KeyCode.ButtonSelect and GuiService.SelectedObject ~= nil) then
			Utils.selectIfGamepad(v2:getValue())
		end
	end)
	local function getComponent() --[[ Line: 289 | Upvalues: Settings (ref), GameUtil (copy), Utils (ref), createElement (ref), TopbarHolder (ref), BigButtonService (ref) ]]
		local v2 = Utils.isSmallScreen()
		local t = {
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets,
			ResetOnSpawn = false
		}
		local t2 = {}
		t2.Buttons = if v2 then createElement(TopbarHolder, {
	color = Settings.TeamColor[GameUtil.Team],
	buttons = BigButtonService.active
}) else nil
		return createElement("ScreenGui", t, t2)
	end
	local v5 = Roact.mount(getComponent(), Players.LocalPlayer.PlayerGui, "SidebarGui")
	local v6 = nil
	Utils.getViewportSizeChangedSignal():Connect(function() --[[ Line: 308 | Upvalues: v6 (ref), Roact (ref), v5 (copy), getComponent (copy) ]]
		if v6 then
			task.cancel(v6)
		end
		v6 = task.delay(0.1, function() --[[ Line: 312 | Upvalues: Roact (ref), v5 (ref), getComponent (ref), v6 (ref) ]]
			Roact.update(v5, getComponent())
			v6 = nil
		end)
	end)
	GameUtil.OnTeamChanged:Connect(function(p1) --[[ Line: 317 | Upvalues: Roact (ref), v5 (copy), getComponent (copy) ]]
		Roact.update(v5, getComponent())
	end)
end
function t.SetTime(p1) --[[ Line: 321 | Upvalues: t (copy) ]]
	t.updateTime(p1)
end
function t.SetSafeCount(p1) --[[ Line: 324 | Upvalues: t (copy), BigButtonService (copy) ]]
	if t.safesButton then
		t.safesButton.count = p1
		BigButtonService.triggerUpdate:Fire()
	end
end
return t