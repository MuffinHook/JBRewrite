-- Reviewed by Claude
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
for v1, v2 in AdRewardCashToast:QueryDescendants("ObjectValue#MoveOnSignal") do
	v2.Value = PromptCashBooster
end
local CashTimer = AdRewardCashToast:WaitForChild("CashTimer")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local v3 = nil
local v4 = nil
local v5 = false
local v6 = false
local v7 = false
local v8 = false
local v9 = 0
local v10 = false
local v11 = false
local v12 = nil
local t = {}
local v13 = nil
local function getCurrentRegionTag()
	if v13 and v13.GetCurrentRegionTag then
		return v13:GetCurrentRegionTag()
	else
		return nil
	end
end
local t2 = {
	Enum.AdAvailabilityResult.PlayerIneligible,
	Enum.AdAvailabilityResult.DeviceIneligible,
	Enum.AdAvailabilityResult.PublisherIneligible,
	Enum.AdAvailabilityResult.ExperienceIneligible
}
local function isIneligible(p1)
	for i, v in ipairs(t2) do
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
	if v8 or v6 then
		return
	end
	local v1, v2 = pcall(function()
		return AdService:GetAdAvailabilityNowAsync(Enum.AdFormat.RewardedVideo)
	end)
	if v1 and v2 then
		v6 = v2.AdAvailabilityResult == Enum.AdAvailabilityResult.IsAvailable
		local AdAvailabilityResult = v2.AdAvailabilityResult
		local v3 = false
		for i, v in ipairs(t2) do
			if AdAvailabilityResult == v then
				v3 = true
				break
			end
		end
		v7 = not v3
	else
		v6 = false
		v7 = false
		v8 = true
	end
end
local function startGlobalSleep()
	v9 = os.time() + 180
	v10 = false
	v6 = false
end
local t3 = {
	TriggerPromptInteracted = function()
		v9 = os.time() + 180
		v10 = false
		v6 = false
	end
}
local function PlayRewardedAd(p1)
	if v8 then
		return false
	else
		if p1 then
			p1 = tonumber(p1)
		end
		v8 = true
		v6 = false
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
	local v1 = p1.Parent
	local v2 = p1.Value
	if v1 and v2 then
		if v1:IsA("GuiButton") then
			if v2:IsA("GuiObject") then
				local v3 = p1:GetAttribute("Pos")
				local v4 = p1:GetAttribute("MoveTime")
				if typeof(v3) == "UDim2" and (typeof(v4) == "number" and not (v4 <= 0)) then
					local v5 = v2.Name
					v1.MouseButton1Down:Connect(function()
						tweenGuiPosition(v2, v3, v4)
						Telemetry.send("DeclineAd_" .. v5)
						local v1 = if v13 and v13.GetCurrentRegionTag then v13:GetCurrentRegionTag() else nil
						if v1 then
							Telemetry.send("DeclineAdRegion_" .. v1)
						end
						t3.TriggerPromptInteracted()
					end)
				else
					warn("[AdRewardsController] ClickToMoveFrame has invalid Pos/MoveTime on", p1:GetFullName())
				end
			else
				warn("[AdRewardsController] ClickToMoveFrame value is not a GuiObject:", v2:GetFullName())
			end
		else
			warn("[AdRewardsController] ClickToMoveFrame parent is not a GuiButton:", v1:GetFullName())
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
			v8 = false
			v6 = false
			if v4 and v4.OnAdCompleted then
				v4.OnAdCompleted(p1, p2)
			end
		end
	end)
end
local v14 = nil
local v15 = nil
local v16 = false
local function formatTime(p1)
	local v1 = math.floor(p1)
	return string.format("%d:%02d", math.floor(v1 / 60), v1 % 60)
end
local function initCashTimer()
	if not v16 then
		v16 = true
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
						local v3 = math.floor(p1)
						v14.Frame.Frame.TextLabel.Text = string.format("%d:%02d", math.floor(v3 / 60), v3 % 60)
						local v5 = getContainer()
						if v5 then
							applyAppearanceForContainer(v5)
						end
					end
				end
				v15 = LocalPlayer:GetAttributeChangedSignal("CashMultiplierTimer"):Connect(function()
					local v1 = LocalPlayer:GetAttribute("CashMultiplierTimer")
					if v14 and v14.Parent then
						v14.Visible = v1 > 0
						local v4 = math.floor(v1)
						v14.Frame.Frame.TextLabel.Text = string.format("%d:%02d", math.floor(v4 / 60), v4 % 60)
						local v6 = getContainer()
						if v6 then
							applyAppearanceForContainer(v6)
						end
					end
				end)
				local v1 = LocalPlayer:GetAttribute("CashMultiplierTimer")
				if typeof(v1) == "number" then
					if v14 and v14.Parent then
						v14.Visible = v1 > 0
						local v4 = math.floor(v1)
						v14.Frame.Frame.TextLabel.Text = string.format("%d:%02d", math.floor(v4 / 60), v4 % 60)
						local v6 = getContainer()
						if v6 then
							applyAppearanceForContainer(v6)
						end
					end
				elseif v14 and v14.Parent then
					v14.Visible = false
					local v7 = math.floor(0)
					v14.Frame.Frame.TextLabel.Text = string.format("%d:%02d", math.floor(v7 / 60), v7 % 60)
					local v9 = getContainer()
					if v9 then
						applyAppearanceForContainer(v9)
					end
				end
			end
		end
		local function ensureTimer()
			if v3 and v3.Parent then
				local v1 = getContainer()
				if v1 and (v14 and (v14.Parent and v14.Parent ~= v1)) then
					v14.Parent = v1
					applyAppearanceForContainer(v1)
				elseif v1 and not (v14 and v14.Parent) then
					local CashTimer_2 = v1:FindFirstChild("CashTimer")
					if CashTimer_2 and CashTimer_2 ~= v14 then
						CashTimer_2:Destroy()
					end
					v14 = CashTimer:Clone()
					v14.Name = "CashTimer"
					v14.Parent = v1
					applyAppearanceForContainer(v1)
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
		local v1, v2
		repeat
			task.wait(10)
			v1 = os.time()
		until not (v1 < v9)
		if v13 and v13:IsInAnyTeamMatchedRegion() then
			if not v10 then
				checkForAds()
				if v7 and v6 then
					v10 = true
				end
			end
			if v10 then
				local Team = LocalPlayer.Team
				v2 = if Team then Team.Name else nil
				if v2 then
					local v3 = t[v2]
				end
				if PromptCashBooster and v11 then
					PromptCashBooster:Fire(nil)
				end
				v11 = false
				v12 = nil
			end
		elseif v11 then
			local v42 = v12
			if v42 then
				t[v42] = v1 + 30
			end
			if PromptCashBooster then
				PromptCashBooster:Fire(nil)
			end
			v11 = false
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
	local v1 = AdRewardCashToast:Clone()
	v1.Parent = PlayerGui
	v3 = v1
	local CashTimer = v1:FindFirstChild("CashTimer")
	if CashTimer then
		CashTimer:Destroy()
	end
	local RobloxAdServicesTeamRegions = AdRewardSystem:WaitForChild("RobloxAdServicesTeamRegions")
	v13 = require(script.Parent:WaitForChild("PlayerRegionTracker")).new(LocalPlayer, RobloxAdServicesTeamRegions)
	v13:Start()
	if v4 then
		local v2, v32 = pcall(function()
			v4.Init({
				PlayerGui = PlayerGui,
				PlayAd = PlayRewardedAd,
				GetAdState = function()
					return v7, v6, v8
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
			v8 = false
			v6 = false
			if v4 and v4.OnAdCompleted then
				v4.OnAdCompleted(p1, p2)
			end
		end
	end)
end
function t3.Init(p1)
	checkForAds()
	if v7 then
		v4 = p1 or v4
		local v2, v3 = pcall(function()
			return ABCheck:InvokeServer()
		end)
		v5 = v2 and v3 == true and true or false
		if v5 == true then
			boot()
		end
	else
		print("[AdRewardsController] Ineligible for Ad Services")
	end
end
return t3
