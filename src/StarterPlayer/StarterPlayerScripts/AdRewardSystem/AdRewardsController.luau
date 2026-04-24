-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AdService = game:GetService("AdService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
repeat
	task.wait()
until Players.LocalPlayer
repeat
	task.wait()
until Players.LocalPlayer.Character
local Notification = require(ReplicatedStorage.Game.Notification)
local Telemetry = require(script.Parent.Telemetry)
local AdRewardSystem = ReplicatedStorage:WaitForChild("AdRewardSystem")
local AdRewardEvents = AdRewardSystem:WaitForChild("AdRewardEvents")
local ABCheck = AdRewardEvents:WaitForChild("ABCheck")
local ShowAd = AdRewardEvents:WaitForChild("ShowAd")
local PromptCashBooster = AdRewardEvents:WaitForChild("PromptCashBooster")
local AdRewardCashToast = AdRewardSystem:WaitForChild("AdRewardCashToast")
for mathFunc, v2 in AdRewardCashToast:QueryDescendants("ObjectValue#MoveOnSignal") do
	v2.Value = PromptCashBooster
end
local CashTimer = AdRewardCashToast:WaitForChild("CashTimer")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local isEnabled = nil
local mathFunc = nil
local isEnabled = false
local isEnabled = false
local isEnabled = false
local isEnabled = false
local v9 = 0
local isEnabled = false
local isEnabled = false
local v12 = nil
local configTable = {}
local v13 = nil
local function getCurrentRegionTag()
	if v13 and v13.GetCurrentRegionTag then
		return v13:GetCurrentRegionTag()
	else
		return nil
	end
end
local configTable = {
	Enum.AdAvailabilityResult.PlayerIneligible,
	Enum.AdAvailabilityResult.DeviceIneligible,
	Enum.AdAvailabilityResult.PublisherIneligible,
	Enum.AdAvailabilityResult.ExperienceIneligible
}
local function isIneligible(p1)
	for i, v in ipairs(configTable) do
		if p1 == v then
			return true
		end
	end
	return false
end
local function getCurrentRegionKey()
	local Team = LocalPlayer.Team
	if Team then
		return Team.Name
	else
		return nil
	end
end
local function checkForAds()
	if isEnabled or isEnabled then
		return
	end
	local mathFunc, v2 = pcall(function()
		return AdService:GetAdAvailabilityNowAsync(Enum.AdFormat.RewardedVideo)
	end)
	if mathFunc and v2 then
		isEnabled = v2.AdAvailabilityResult == Enum.AdAvailabilityResult.IsAvailable
		local AdAvailabilityResult = v2.AdAvailabilityResult
		local isEnabled = false
		for i, v in ipairs(configTable) do
			if AdAvailabilityResult == v then
				isEnabled = true
				break
			end
		end
		isEnabled = not isEnabled
	else
		isEnabled = false
		isEnabled = false
		isEnabled = true
	end
end
local function startGlobalSleep()
	v9 = os.time() + 180
	isEnabled = false
	isEnabled = false
end
local configTable = {
	TriggerPromptInteracted = function()
		v9 = os.time() + 180
		isEnabled = false
		isEnabled = false
	end
}
local function PlayRewardedAd(p1)
	if isEnabled then
		return false
	else
		if p1 then
			p1 = tonumber(p1)
		end
		isEnabled = true
		isEnabled = false
		ShowAd:FireServer(p1 or 1095222383857795, "generic_watch_to_claim")
		return true
	end
end
local function tweenGuiPosition(p1, p2, p3)
	TweenService:Create(p1, TweenInfo.new(p3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		Position = p2
	}):Play()
end
local function setupClickToMoveFrame(p1)
	if p1:GetAttribute("__AdRewardsBound") then
		return
	end
	p1:SetAttribute("__AdRewardsBound", true)
	local mathFunc = p1.Parent
	local v2 = p1.Value
	if mathFunc and v2 then
		if mathFunc:IsA("GuiButton") then
			if v2:IsA("GuiObject") then
				local isEnabled = p1:GetAttribute("Pos")
				local mathFunc = p1:GetAttribute("MoveTime")
				if typeof(isEnabled) == "UDim2" and (typeof(mathFunc) == "number" and not (mathFunc <= 0)) then
					local isEnabled = v2.Name
					mathFunc.MouseButton1Down:Connect(function()
						tweenGuiPosition(v2, isEnabled, mathFunc)
						Telemetry.send("DeclineAd_" .. isEnabled)
						local mathFunc = if v13 and v13.GetCurrentRegionTag then v13:GetCurrentRegionTag() else nil
						if mathFunc then
							Telemetry.send("DeclineAdRegion_" .. mathFunc)
						end
						configTable.TriggerPromptInteracted()
					end)
				else
					warn("[AdRewardsController] ClickToMoveFrame has invalid Pos/MoveTime on", p1:GetFullName())
				end
			else
				warn("[AdRewardsController] ClickToMoveFrame value is not a GuiObject:", v2:GetFullName())
			end
		else
			warn("[AdRewardsController] ClickToMoveFrame parent is not a GuiButton:", mathFunc:GetFullName())
		end
	else
		warn("[AdRewardsController] ClickToMoveFrame missing button or target frame:", p1:GetFullName())
	end
end
local function handleAdRewardsUITaggedInstance(p1)
	if p1:IsA("ObjectValue") and p1.Name == "ClickToMoveFrame" then
		setupClickToMoveFrame(p1)
	end
end
local function initAdRewardsUI()
	for i, v in ipairs(CollectionService:GetTagged("AdRewardsUI")) do
		if v:IsA("ObjectValue") and v.Name == "ClickToMoveFrame" then
			setupClickToMoveFrame(v)
		end
	end
	CollectionService:GetInstanceAddedSignal("AdRewardsUI"):Connect(handleAdRewardsUITaggedInstance)
end
local function InitRewardAdListener()
	ShowAd.OnClientEvent:Connect(function(p1, p2, p3)
		if p3 == "generic_watch_to_claim" then
			isEnabled = false
			isEnabled = false
			if mathFunc and mathFunc.OnAdCompleted then
				mathFunc.OnAdCompleted(p1, p2)
			end
		end
	end)
end
local v14 = nil
local v15 = nil
local isEnabled = false
local function formatTime(p1)
	local mathFunc = math.floor(p1)
	return string.format("%d:%02d", math.floor(mathFunc / 60), mathFunc % 60)
end
local function initCashTimer()
	if not isEnabled then
		isEnabled = true
		local AppUI = PlayerGui:WaitForChild("AppUI")
		local function getContainer()
			if AppUI and AppUI.Parent then
				local Buttons = AppUI:FindFirstChild("Buttons")
				if Buttons and Buttons:IsA("GuiObject") then
					return Buttons
				else
					local TopRight = AppUI:FindFirstChild("TopRight")
					if TopRight and TopRight:IsA("GuiObject") then
						return TopRight
					else
						return nil
					end
				end
			else
				return nil
			end
		end
		local function applyAppearanceForContainer(p1)
			if v14 and p1 then
				local UIAspectRatioConstraint = v14:FindFirstChildOfClass("UIAspectRatioConstraint")
				if not UIAspectRatioConstraint then
					local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
					UIAspectRatioConstraint_2.Parent = v14
					UIAspectRatioConstraint = UIAspectRatioConstraint_2
				end
				if p1.Name == "Buttons" then
					UIAspectRatioConstraint.AspectRatio = 6
				else
					UIAspectRatioConstraint.AspectRatio = 5
				end
				local Minimap = p1:FindFirstChild("Minimap")
				if Minimap and Minimap:IsA("GuiObject") then
					local Frame = v14:FindFirstChild("Frame")
					if Frame and Minimap:FindFirstChild("Time") then
						Frame.BackgroundColor3 = Minimap.Time.ImageColor3
					end
				end
			end
		end
		local function bindTimer()
			if v15 then
				v15:Disconnect()
				v15 = nil
			end
			if v14 then
				v14.Visible = false
				local function updatetimer(p1)
					if v14 and v14.Parent then
						v14.Visible = p1 > 0
						local isEnabled = math.floor(p1)
						v14.Frame.Frame.TextLabel.Text = string.format("%d:%02d", math.floor(isEnabled / 60), isEnabled % 60)
						local isEnabled = getContainer()
						if isEnabled then
							applyAppearanceForContainer(isEnabled)
						end
					end
				end
				v15 = LocalPlayer:GetAttributeChangedSignal("CashMultiplierTimer"):Connect(function()
					local mathFunc = LocalPlayer:GetAttribute("CashMultiplierTimer")
					if v14 and v14.Parent then
						v14.Visible = mathFunc > 0
						local mathFunc = math.floor(mathFunc)
						v14.Frame.Frame.TextLabel.Text = string.format("%d:%02d", math.floor(mathFunc / 60), mathFunc % 60)
						local isEnabled = getContainer()
						if isEnabled then
							applyAppearanceForContainer(isEnabled)
						end
					end
				end)
				local mathFunc = LocalPlayer:GetAttribute("CashMultiplierTimer")
				if typeof(mathFunc) == "number" then
					if v14 and v14.Parent then
						v14.Visible = mathFunc > 0
						local mathFunc = math.floor(mathFunc)
						v14.Frame.Frame.TextLabel.Text = string.format("%d:%02d", math.floor(mathFunc / 60), mathFunc % 60)
						local isEnabled = getContainer()
						if isEnabled then
							applyAppearanceForContainer(isEnabled)
						end
					end
				elseif v14 and v14.Parent then
					v14.Visible = false
					local isEnabled = math.floor(0)
					v14.Frame.Frame.TextLabel.Text = string.format("%d:%02d", math.floor(isEnabled / 60), isEnabled % 60)
					local v9 = getContainer()
					if v9 then
						applyAppearanceForContainer(v9)
					end
				end
			end
		end
		local function ensureTimer()
			if isEnabled and isEnabled.Parent then
				local mathFunc = getContainer()
				if mathFunc and (v14 and (v14.Parent and v14.Parent ~= mathFunc)) then
					v14.Parent = mathFunc
					applyAppearanceForContainer(mathFunc)
				elseif mathFunc and not (v14 and v14.Parent) then
					local CashTimer_2 = mathFunc:FindFirstChild("CashTimer")
					if CashTimer_2 and CashTimer_2 ~= v14 then
						CashTimer_2:Destroy()
					end
					v14 = CashTimer:Clone()
					v14.Name = "CashTimer"
					v14.Parent = mathFunc
					applyAppearanceForContainer(mathFunc)
					bindTimer()
				end
			end
		end
		task.spawn(function()
			while true do
				ensureTimer()
				task.wait(1)
			end
		end)
	end
end
local function connectCustomTelemetry()  end
local function startRegionLoop()
	while true do
		local mathFunc, v2
		repeat
			task.wait(10)
			mathFunc = os.time()
		until not (mathFunc < v9)
		if v13 and v13:IsInAnyTeamMatchedRegion() then
			if not isEnabled then
				checkForAds()
				if isEnabled and isEnabled then
					isEnabled = true
				end
			end
			if isEnabled then
				local Team = LocalPlayer.Team
				v2 = if Team then Team.Name else nil
				if v2 then
					local isEnabled = configTable[v2]
				end
				if PromptCashBooster and isEnabled then
					PromptCashBooster:Fire(nil)
				end
				isEnabled = false
				v12 = nil
			end
		elseif isEnabled then
			local v42 = v12
			if v42 then
				configTable[v42] = mathFunc + 30
			end
			if PromptCashBooster then
				PromptCashBooster:Fire(nil)
			end
			isEnabled = false
			v12 = nil
		end
	end
end
local function initNotifications()
	local Notification_2 = AdRewardEvents:FindFirstChild("Notification")
	if Notification_2 then
		Notification_2.OnClientEvent:Connect(function(p1)
			task.wait(2)
			Notification.new({
				Text = p1,
				Style = "Gift"
			})
		end)
	end
end
local function boot()
	task.wait(1)
	local mathFunc = AdRewardCashToast:Clone()
	mathFunc.Parent = PlayerGui
	isEnabled = mathFunc
	local CashTimer = mathFunc:FindFirstChild("CashTimer")
	if CashTimer then
		CashTimer:Destroy()
	end
	local RobloxAdServicesTeamRegions = AdRewardSystem:WaitForChild("RobloxAdServicesTeamRegions")
	v13 = require(script.Parent:WaitForChild("PlayerRegionTracker")).new(LocalPlayer, RobloxAdServicesTeamRegions)
	v13:Start()
	if mathFunc then
		local v2, v32 = pcall(function()
			mathFunc.Init({
				PlayerGui = PlayerGui,
				PlayAd = PlayRewardedAd,
				GetAdState = function()
					return isEnabled, isEnabled, isEnabled
				end,
				GetCurrentRegionTag = getCurrentRegionTag
			})
		end)
		if not v2 then
			warn("[AdRewardsController] WatchAdButtonController.Init failed:", v32)
		end
	else
		warn("[AdRewardsController] WatchAdButtonControllerModule is nil at boot")
	end
	initAdRewardsUI()
	initCashTimer()
	local Notification_2 = AdRewardEvents:FindFirstChild("Notification")
	if Notification_2 then
		Notification_2.OnClientEvent:Connect(function(p1)
			task.wait(2)
			Notification.new({
				Text = p1,
				Style = "Gift"
			})
		end)
	end
	task.spawn(startRegionLoop)
	ShowAd.OnClientEvent:Connect(function(p1, p2, p3)
		if p3 == "generic_watch_to_claim" then
			isEnabled = false
			isEnabled = false
			if mathFunc and mathFunc.OnAdCompleted then
				mathFunc.OnAdCompleted(p1, p2)
			end
		end
	end)
end
function configTable.Init(p1)
	checkForAds()
	if isEnabled then
		mathFunc = p1 or mathFunc
		local v2, isEnabled = pcall(function()
			return ABCheck:InvokeServer()
		end)
		isEnabled = v2 and isEnabled == true and true or false
		if isEnabled == true then
			boot()
		end
	else
		print("[AdRewardsController] Ineligible for Ad Services")
	end
end
return configTable
