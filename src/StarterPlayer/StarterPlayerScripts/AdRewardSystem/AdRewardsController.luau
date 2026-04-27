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
for index, signalValue in AdRewardCashToast:QueryDescendants("ObjectValue#MoveOnSignal") do
	signalValue.Value = PromptCashBooster
end
local CashTimer = AdRewardCashToast:WaitForChild("CashTimer")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local isEnabled = nil
local watchAdButtonController = nil
local isAdAvailable = false
local isIneligibleDueToServer = false
local isServerIneligible = false
local isClientIneligible = false
local globalSleepUntilTime = 0
local isSleepActive = false
local currentRegionKey = nil
local ineligibilityCache = {}
local regionTracker = nil
local function getCurrentRegionTag()
	if regionTracker and regionTracker.GetCurrentRegionTag then
		return regionTracker:GetCurrentRegionTag()
	else
		return nil
	end
end
local ineligibilityCache = {
	Enum.AdAvailabilityResult.PlayerIneligible,
	Enum.AdAvailabilityResult.DeviceIneligible,
	Enum.AdAvailabilityResult.PublisherIneligible,
	Enum.AdAvailabilityResult.ExperienceIneligible
}
local function isIneligible(resultToCheck)
	for i, v in ipairs(ineligibilityCache) do
		if resultToCheck == v then
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
	if isAdAvailable or isSleepActive then
		return
	end
	local success, adAvailabilityResponse = pcall(function()
		return AdService:GetAdAvailabilityNowAsync(Enum.AdFormat.RewardedVideo)
	end)
	if success and adAvailabilityResponse then
		isAdAvailable = adAvailabilityResponse.AdAvailabilityResult == Enum.AdAvailabilityResult.IsAvailable
		local AdAvailabilityResult = adAvailabilityResponse.AdAvailabilityResult
		local foundIneligibility = false
		for i, v in ipairs(ineligibilityCache) do
			if AdAvailabilityResult == v then
				foundIneligibility = true
				break
			end
		end
		isServerIneligible = not foundIneligibility
	else
		isAdAvailable = false
		isClientIneligible = false
		isSleepActive = true
	end
end
local function startGlobalSleep()
	globalSleepUntilTime = os.time() + 180
	isAdAvailable = false
	isSleepActive = false
end
local configTable = {
	TriggerPromptInteracted = function()
		globalSleepUntilTime = os.time() + 180
		isAdAvailable = false
		isSleepActive = false
	end
}
local function PlayRewardedAd(itemIdParam)
	if isSleepActive then
		return false
	else
		if itemIdParam then
			itemIdParam = tonumber(itemIdParam)
		end
		isSleepActive = true
		isClientIneligible = false
		ShowAd:FireServer(itemIdParam or 1095222383857795, "generic_watch_to_claim")
		return true
	end
end
local function tweenGuiPosition(targetFrame, targetPosition, duration)
	TweenService:Create(targetFrame, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		Position = targetPosition
	}):Play()
end
local function setupClickToMoveFrame(objectValueInstance)
	if objectValueInstance:GetAttribute("__AdRewardsBound") then
		return
	end
	objectValueInstance:SetAttribute("__AdRewardsBound", true)
	local parentButton = objectValueInstance.Parent
	local targetFrame = objectValueInstance.Value
	if parentButton and targetFrame then
		if parentButton:IsA("GuiButton") then
			if targetFrame:IsA("GuiObject") then
				local positionAttribute = objectValueInstance:GetAttribute("Pos")
				local moveTimeDuration = objectValueInstance:GetAttribute("MoveTime")
				if typeof(positionAttribute) == "UDim2" and (typeof(moveTimeDuration) == "number" and not (moveTimeDuration <= 0)) then
					local targetGuiName = targetFrame.Name
					parentButton.MouseButton1Down:Connect(function()
						tweenGuiPosition(targetFrame, positionAttribute, moveTimeDuration)
						Telemetry.send("DeclineAd_" .. targetGuiName)
						local regionTag = if regionTracker and regionTracker.GetCurrentRegionTag then regionTracker:GetCurrentRegionTag() else nil
						if regionTag then
							Telemetry.send("DeclineAdRegion_" .. regionTag)
						end
						configTable.TriggerPromptInteracted()
					end)
				else
					warn("[AdRewardsController] ClickToMoveFrame has invalid Pos/MoveTime on", objectValueInstance:GetFullName())
				end
			else
				warn("[AdRewardsController] ClickToMoveFrame value is not a GuiObject:", targetFrame:GetFullName())
			end
		else
			warn("[AdRewardsController] ClickToMoveFrame parent is not a GuiButton:", parentButton:GetFullName())
		end
	else
		warn("[AdRewardsController] ClickToMoveFrame missing button or target frame:", objectValueInstance:GetFullName())
	end
end
local function handleAdRewardsUITaggedInstance(instanceObject)
	if instanceObject:IsA("ObjectValue") and instanceObject.Name == "ClickToMoveFrame" then
		setupClickToMoveFrame(instanceObject)
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
	ShowAd.OnClientEvent:Connect(function(itemId, itemName, adType)
		if adType == "generic_watch_to_claim" then
			isAdAvailable = false
			isSleepActive = false
			if watchAdButtonController and watchAdButtonController.OnAdCompleted then
				watchAdButtonController.OnAdCompleted(itemId, itemName)
			end
		end
	end)
end
local timerFrame = nil
local timerSignalConnection = nil
local isTimerInitialized = false
local function formatTime(secondsValue)
	local floorSeconds = math.floor(secondsValue)
	return string.format("%d:%02d", math.floor(floorSeconds / 60), floorSeconds % 60)
end
local function initCashTimer()
	if not isTimerInitialized then
		isTimerInitialized = true
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
		local function applyAppearanceForContainer(containerFrame)
			if timerFrame and containerFrame then
				local UIAspectRatioConstraint = timerFrame:FindFirstChildOfClass("UIAspectRatioConstraint")
				if not UIAspectRatioConstraint then
					local newConstraint = Instance.new("UIAspectRatioConstraint")
					newConstraint.Parent = timerFrame
					UIAspectRatioConstraint = newConstraint
				end
				if containerFrame.Name == "Buttons" then
					UIAspectRatioConstraint.AspectRatio = 6
				else
					UIAspectRatioConstraint.AspectRatio = 5
				end
				local Minimap = containerFrame:FindFirstChild("Minimap")
				if Minimap and Minimap:IsA("GuiObject") then
					local Frame = timerFrame:FindFirstChild("Frame")
					if Frame and Minimap:FindFirstChild("Time") then
						Frame.BackgroundColor3 = Minimap.Time.ImageColor3
					end
				end
			end
		end
		local function bindTimer()
			if timerSignalConnection then
				timerSignalConnection:Disconnect()
				timerSignalConnection = nil
			end
			if timerFrame then
				timerFrame.Visible = false
				local function updatetimer(secondsRemaining)
					if timerFrame and timerFrame.Parent then
						timerFrame.Visible = secondsRemaining > 0
						local flooredSeconds = math.floor(secondsRemaining)
						timerFrame.Frame.Frame.TextLabel.Text = string.format("%d:%02d", math.floor(flooredSeconds / 60), flooredSeconds % 60)
						local currentContainer = getContainer()
						if currentContainer then
							applyAppearanceForContainer(currentContainer)
						end
					end
				end
				timerSignalConnection = LocalPlayer:GetAttributeChangedSignal("CashMultiplierTimer"):Connect(function()
					local currentTimerValue = LocalPlayer:GetAttribute("CashMultiplierTimer")
					if timerFrame and timerFrame.Parent then
						timerFrame.Visible = currentTimerValue > 0
						local flooredTimerValue = math.floor(currentTimerValue)
						timerFrame.Frame.Frame.TextLabel.Text = string.format("%d:%02d", math.floor(flooredTimerValue / 60), flooredTimerValue % 60)
						local currentContainer = getContainer()
						if currentContainer then
							applyAppearanceForContainer(currentContainer)
						end
					end
				end)
				local initialTimerValue = LocalPlayer:GetAttribute("CashMultiplierTimer")
				if typeof(initialTimerValue) == "number" then
					if timerFrame and timerFrame.Parent then
						timerFrame.Visible = initialTimerValue > 0
						local flooredInitialValue = math.floor(initialTimerValue)
						timerFrame.Frame.Frame.TextLabel.Text = string.format("%d:%02d", math.floor(flooredInitialValue / 60), flooredInitialValue % 60)
						local currentContainer = getContainer()
						if currentContainer then
							applyAppearanceForContainer(currentContainer)
						end
					end
				elseif timerFrame and timerFrame.Parent then
					timerFrame.Visible = false
					local zeroFloor = math.floor(0)
					timerFrame.Frame.Frame.TextLabel.Text = string.format("%d:%02d", math.floor(zeroFloor / 60), zeroFloor % 60)
					local fallbackContainer = getContainer()
					if fallbackContainer then
						applyAppearanceForContainer(fallbackContainer)
					end
				end
			end
		end
		local function ensureTimer()
			if isTimerInitialized and AppUI and AppUI.Parent then
				local targetContainer = getContainer()
				if targetContainer and (timerFrame and (timerFrame.Parent and timerFrame.Parent ~= targetContainer)) then
					timerFrame.Parent = targetContainer
					applyAppearanceForContainer(targetContainer)
				elseif targetContainer and not (timerFrame and timerFrame.Parent) then
					local existingTimer = targetContainer:FindFirstChild("CashTimer")
					if existingTimer and existingTimer ~= timerFrame then
						existingTimer:Destroy()
					end
					timerFrame = CashTimer:Clone()
					timerFrame.Name = "CashTimer"
					timerFrame.Parent = targetContainer
					applyAppearanceForContainer(targetContainer)
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
		local currentTime, currentRegionKeyValue
		repeat
			task.wait(10)
			currentTime = os.time()
		until not (currentTime < globalSleepUntilTime)
		if regionTracker and regionTracker:IsInAnyTeamMatchedRegion() then
			if not isAdAvailable then
				checkForAds()
				if isAdAvailable and isServerIneligible then
					isServerIneligible = true
				end
			end
			if isAdAvailable then
				local Team = LocalPlayer.Team
				currentRegionKeyValue = if Team then Team.Name else nil
				if currentRegionKeyValue then
					local cachedRegionValue = ineligibilityCache[currentRegionKeyValue]
				end
				if PromptCashBooster and isServerIneligible then
					PromptCashBooster:Fire(nil)
				end
				isAdAvailable = false
				currentRegionKey = nil
			end
		elseif isSleepActive then
			local previousRegionKey = currentRegionKey
			if previousRegionKey then
				ineligibilityCache[previousRegionKey] = currentTime + 30
			end
			if PromptCashBooster then
				PromptCashBooster:Fire(nil)
			end
			isSleepActive = false
			currentRegionKey = nil
		end
	end
end
local function initNotifications()
	local Notification_2 = AdRewardEvents:FindFirstChild("Notification")
	if Notification_2 then
		Notification_2.OnClientEvent:Connect(function(notificationText)
			task.wait(2)
			Notification.new({
				Text = notificationText,
				Style = "Gift"
			})
		end)
	end
end
local function boot()
	task.wait(1)
	local clonedToastUI = AdRewardCashToast:Clone()
	clonedToastUI.Parent = PlayerGui
	isEnabled = clonedToastUI
	local CashTimer = clonedToastUI:FindFirstChild("CashTimer")
	if CashTimer then
		CashTimer:Destroy()
	end
	local RobloxAdServicesTeamRegions = AdRewardSystem:WaitForChild("RobloxAdServicesTeamRegions")
	regionTracker = require(script.Parent:WaitForChild("PlayerRegionTracker")).new(LocalPlayer, RobloxAdServicesTeamRegions)
	regionTracker:Start()
	if clonedToastUI then
		local initSuccess, initError = pcall(function()
			clonedToastUI.Init({
				PlayerGui = PlayerGui,
				PlayAd = PlayRewardedAd,
				GetAdState = function()
					return isAdAvailable, isClientIneligible, isServerIneligible
				end,
				GetCurrentRegionTag = getCurrentRegionTag
			})
		end)
		if not initSuccess then
			warn("[AdRewardsController] WatchAdButtonController.Init failed:", initError)
		end
	else
		warn("[AdRewardsController] WatchAdButtonControllerModule is nil at boot")
	end
	initAdRewardsUI()
	initCashTimer()
	local Notification_2 = AdRewardEvents:FindFirstChild("Notification")
	if Notification_2 then
		Notification_2.OnClientEvent:Connect(function(notificationText)
			task.wait(2)
			Notification.new({
				Text = notificationText,
				Style = "Gift"
			})
		end)
	end
	task.spawn(startRegionLoop)
	ShowAd.OnClientEvent:Connect(function(itemId, itemName, adType)
		if adType == "generic_watch_to_claim" then
			isAdAvailable = false
			isSleepActive = false
			if clonedToastUI and clonedToastUI.OnAdCompleted then
				clonedToastUI.OnAdCompleted(itemId, itemName)
			end
		end
	end)
end
function configTable.Init(moduleInstance)
	checkForAds()
	if isAdAvailable then
		watchAdButtonController = moduleInstance or watchAdButtonController
		local checkSuccess, abCheckResult = pcall(function()
			return ABCheck:InvokeServer()
		end)
		abCheckResult = checkSuccess and abCheckResult == true and true or false
		if abCheckResult == true then
			boot()
		end
	else
		print("[AdRewardsController] Ineligible for Ad Services")
	end
end
return configTable
