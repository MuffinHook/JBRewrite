local CurrentCamera = workspace.CurrentCamera
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Teams = game:GetService("Teams")
local VoiceChatService = game:GetService("VoiceChatService")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local localPlayer = RunUtils.isStudio()
local Localization = require(ReplicatedStorage.Module.Localization)
local CinematicCamera = require(ReplicatedStorage.Module.CinematicCamera)
require(ReplicatedStorage.Game.GameUtil)
local InventoryItemSystem = require(ReplicatedStorage.Inventory.InventoryItemSystem)
local TeamShared = require(ReplicatedStorage.App.TeamShared)
local WorldTeleportConsts = require(ReplicatedStorage.WorldTeleport.WorldTeleportConsts)
local RunConsts = require(ReplicatedStorage.App.RunConsts)
local ScreenFade = require(ReplicatedStorage.App.ScreenFade)
local EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
local Notification = require(ReplicatedStorage.Game.Notification)
local WorldMarkerSystem = require(ReplicatedStorage.Game.WorldMarker.WorldMarkerSystem)
local Settings = require(ReplicatedStorage.Resource.Settings)
local Roact = require(ReplicatedStorage.Roact)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local TeamSelectConsts = require(ReplicatedStorage.TeamSelect.TeamSelectConsts)
local TeamSelect = require(ReplicatedStorage.TeamSelect.UI.TeamSelect)
local createElement = Roact.createElement
local cameraPositions = {
	City2_Start = {
		p = Vector3.new(-93.27, 62.17, 431.17),
		LookVector = Vector3.new(0.17, -0.26, 0.95)
	},
	PoliceBase1 = {
		p = Vector3.new(-1173.16, 43.35, -1573.47),
		LookVector = Vector3.new(0.02, -0.02, -1)
	},
	City2_Stop = {
		p = Vector3.new(39.03, 62.17, 1179.24),
		LookVector = Vector3.new(0.17, -0.26, 0.95)
	},
	Prisoner_Cells = {
		p = Vector3.new(-1391.62, 4.1, -1963.13),
		LookVector = Vector3.new(-0.78, -0.3, -0.55)
	},
	Prisoner_Yard = {
		p = Vector3.new(-1145.53, 18.85, -1858.03),
		LookVector = Vector3.new(-0.71, -0, 0.71)
	},
	Prisoner_Foodcourt = {
		p = Vector3.new(-1424.46, 45.49, -1763.45),
		LookVector = Vector3.new(-0.01, -0.49, -0.87)
	},
	City1_Start = {
		p = Vector3.new(-1088.8, 117.12, -2020.93),
		LookVector = Vector3.new(-0.5, -0.02, 0.86)
	},
	City1_Stop = {
		p = Vector3.new(-1301.44, 68.33, -1581.19),
		LookVector = Vector3.new(-0.46, -0.02, 0.89)
	},
	City3_Start = {
		p = Vector3.new(655.74, 71.57, -1052.78),
		LookVector = Vector3.new(-0.57, 0.03, -0.82)
	},
	City3_Stop = {
		p = Vector3.new(230.68, 57.86, -1542.1),
		LookVector = Vector3.new(-0.55, 0.03, -0.83)
	},
	PoliceBase2 = {
		p = Vector3.new(739.13, 38.91, 1125.97),
		LookVector = Vector3.new(-0.81, 0.09, -0.57)
	}
}
local studioCameraPositions = {}
for locationName, cameraData in cameraPositions do
	studioCameraPositions[locationName] = {
		p = Vector3.new(0, 0, 0),
		LookVector = Vector3.new(0, 0, -1)
	}
end
local function SelectIfGamepad(uiElement)
	EzUtils.selectIfGamepad(uiElement)
end
local function Ease_InOutQuad(progress)
	return progress < 0.5 and 2 * progress * progress or -1 - 2 * (progress - 2) * progress
end
local jumpEvent = nil
local eventEmitter = nil
local onJumpCallback = nil
local TeamChooseUI = {
	ColorCorrection = nil,
	Maid = Maid.new()
}
function TeamChooseUI.Init(config)
	jumpEvent = config.Event
	eventEmitter = config.em
	onJumpCallback = config.OnJump
	TeamChooseUI.ColorCorrection = Lighting:FindFirstChild("ColorCorrection")
	function eventEmitter.onHideUI()
		TeamChooseUI.Hide()
	end
	function eventEmitter.onShowUI(shouldShow)
		if TeamShared.isTeamSwitchingEnabled() then
			TeamChooseUI.Show(shouldShow)
		end
	end
	if not localPlayer or Settings.Test.ChooseTeamInitially then
		eventEmitter.onShowUI(true)
	end
end
function TeamChooseUI.Show(shouldSkipFade)
	local Maid = TeamChooseUI.Maid
	local ColorCorrection = TeamChooseUI.ColorCorrection
	assert(ColorCorrection)
	local selectedTeam = nil
	local screenFade = ScreenFade.new()
	local cityIndex = 0
	local frameCount = 0
	local cinematicCam = CinematicCamera.MakeCinematicCamera()
	local function UpdateCamera()
		frameCount = frameCount + 1
		ColorCorrection.TintColor = Color3.new(255/255, 255/255, 255/255)
		local activeCameraPositions = if RunUtils.isStudio() then studioCameraPositions else cameraPositions
		cityIndex = cityIndex % 3 + 1
		local startPosition = activeCameraPositions["City" .. cityIndex .. "_Start"]
		local stopPosition = activeCameraPositions["City" .. cityIndex .. "_Stop"]
		local startCFrame = CFrame.new(Vector3.new(), startPosition.LookVector) + startPosition.p
		local stopCFrame = CFrame.new(Vector3.new(), stopPosition.LookVector) + stopPosition.p
		cinematicCam.StartPosition = startCFrame.p
		cinematicCam.TargetPosition = stopCFrame.p
		cinematicCam.LookVector = startCFrame.LookVector
		cinematicCam.TargetLookVector = nil
	end
	local lastUpdateTime = tick()
	local shouldShowAnimation = shouldSkipFade ~= nil
	local function RenderStepped(deltaTime)
		local currentTime = tick()
		local elapsedTime = currentTime - lastUpdateTime
		if CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
			CurrentCamera.CameraType = Enum.CameraType.Scriptable
		end
		if shouldShowAnimation then
			if elapsedTime >= 24 then
				UpdateCamera()
				lastUpdateTime = currentTime
			end
			local progressRatio = elapsedTime / 24
			if progressRatio <= 0.1 and frameCount ~= 1 then
				local easedValue = progressRatio / 0.1
				local easeOutResult, easeOutFallback
				if easedValue < 0.5 then
					easeOutResult = 2 * easedValue * easedValue
					if not easeOutResult then
						easeOutFallback = easedValue
						easeOutResult = -1 - 2 * (easedValue - 2) * easedValue
					end
				else
					easeOutFallback = easedValue
					easeOutResult = -1 - 2 * (easedValue - 2) * easedValue
				end
				ColorCorrection.TintColor = Color3.new(easeOutResult, easeOutResult, easeOutResult)
			elseif progressRatio >= 0.9 then
				local reverseProgress = 1 - (progressRatio - 0.9) / 0.1
				local fadeOutResult, fadeOutFallback
				if reverseProgress < 0.5 then
					fadeOutResult = 2 * reverseProgress * reverseProgress
					if not fadeOutResult then
						fadeOutFallback = reverseProgress
						fadeOutResult = -1 - 2 * (reverseProgress - 2) * reverseProgress
					end
				else
					fadeOutFallback = reverseProgress
					fadeOutResult = -1 - 2 * (reverseProgress - 2) * reverseProgress
				end
				ColorCorrection.TintColor = Color3.new(fadeOutResult, fadeOutResult, fadeOutResult)
			end
			CinematicCamera.StepCinematicCamera(deltaTime, cinematicCam, 0.1, progressRatio)
		end
	end
	Maid:GiveTask(RunService.RenderStepped:Connect(RenderStepped))
	UpdateCamera()
	local isPlaying = false
	local function play()
		if isPlaying then
		elseif TeamShared.isTeamFull(selectedTeam) then
			selectedTeam = nil
			Notification.new({
				Text = Localization:FormatByKey("Teams.TeamFull")
			})
		else
			isPlaying = true
			screenFade:FadeToLinear(0, 0.3)
			jumpEvent:FireServer("c49ti5bx", selectedTeam)
			Maid:GiveTask(task.delay(2, function()
				screenFade:Set(1)
				isPlaying = false
			end))
		end
	end
	local criminalButtonRef = Roact.createRef()
	local function getComponent()
		EzUtils.isSmallScreen()
		local criminalCount = 0
		local policeCount = 0
		for teamName, teamInstance in Teams:GetChildren() do
			if teamInstance.Name == "Police" then
				policeCount = policeCount + #teamInstance:GetPlayers()
			else
				criminalCount = criminalCount + #teamInstance:GetPlayers()
			end
		end
		local isDefaultServer = RunUtils.getPlaceType() == "Default"
		local _ = RunUtils.getPlaceType() == "VoiceChat"
		local isProServer = RunUtils.getPlaceType() == "Pro"
		local serverButtons = {}
		local defaultServerButton = {
			onClicked = function()
				local targetServerType = if isDefaultServer then "VoiceChat" else "Default"
				local isVoiceEnabled, voiceCheckResult = pcall(function()
					return VoiceChatService:IsVoiceEnabledForUserIdAsync(Players.LocalPlayer.UserId)
				end)
				if isDefaultServer and not (isVoiceEnabled and voiceCheckResult) then
					Notification.new({
						Text = "Enable voice chat to join voice chat servers!"
					})
				else
					ReplicatedStorage.TeamSelect:FindFirstChild(TeamSelectConsts.TELEPORT_PLACE_TYPE_REMOTE_NAME):FireServer(targetServerType)
				end
			end
		}
		defaultServerButton.text = if isDefaultServer then "VOICECHAT SERVERS" else "MAIN SERVERS"
		local proServerButton = {
			onClicked = function()
				local targetServerType = if isProServer then "VoiceChat" else "Pro"
				local isVoiceEnabled, voiceCheckResult = pcall(function()
					return VoiceChatService:IsVoiceEnabledForUserIdAsync(Players.LocalPlayer.UserId)
				end)
				if isProServer and not (isVoiceEnabled and voiceCheckResult) then
					Notification.new({
						Text = "Enable voice chat to join voice chat servers!"
					})
				elseif isProServer or not (Players.LocalPlayer.AccountAge < 60) then
					if isProServer or Players.LocalPlayer:GetAttribute("ProServerAccess") then
						ReplicatedStorage.TeamSelect:FindFirstChild(TeamSelectConsts.TELEPORT_PLACE_TYPE_REMOTE_NAME):FireServer(targetServerType)
					else
						Notification.new({
							Text = "You need $5 million to enter High Roller servers!"
						})
					end
				else
					Notification.new({
						Text = "Your account needs to be 60 days old to enter High Roller servers."
					})
				end
			end
		}
		proServerButton.text = if isProServer then "VOICECHAT SERVERS" else "HIGH ROLLER SERVERS"
		serverButtons[1] = defaultServerButton
		serverButtons[2] = proServerButton
		serverButtons[3] = {
			onClicked = function()
				if GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.TradingVIP) then
					ReplicatedStorage:FindFirstChild(WorldTeleportConsts.TELEPORT_TO_WORLD_FROM_TEAM_SWITCH_NAME):FireServer(RunConsts.TRADE_WORLD_NAME)
				else
					GamepassUtils.PromptGamepass(GamepassUtils.EnumGamepass.TradingVIP)
				end
			end,
			text = "TRADE WORLD"
		}
		if workspace:GetServerTimeNow() < TeamSelectConsts.OG_JB_END_TIME then
			table.insert(serverButtons, 1, {
				onClicked = function()
					ReplicatedStorage.TeamSelect:FindFirstChild(TeamSelectConsts.TELEPORT_PLACE_TYPE_REMOTE_NAME):FireServer("Hang")
				end,
				text = "OG JAILBREAK",
				textColor = Color3.fromHex("e88839")
			})
		end
		local allowCriminalSpawn = Players.LocalPlayer:GetAttribute("AllowCriminalSpawn")
		return createElement("ScreenGui", {
			IgnoreGuiInset = true,
			Enabled = shouldShowAnimation
		}, {
			TeamSelect = createElement(TeamSelect, {
				size = UDim2.fromScale(1, 1),
				numPolice = policeCount,
				numCriminals = criminalCount,
				criminalButtonRef = criminalButtonRef,
				allowCriminal = if allowCriminalSpawn == nil then false else allowCriminalSpawn,
				onTeamSelected = function(teamChoice)
					selectedTeam = teamChoice
					play()
				end,
				serverButtons = serverButtons
			})
		})
	end
	local guiInstance = Roact.mount(getComponent(), Players.LocalPlayer.PlayerGui, "TeamSelectGui")
	if criminalButtonRef:getValue() then
		EzUtils.selectIfGamepad((criminalButtonRef:getValue()))
	end
	Maid:GiveTask(function()
		Roact.unmount(guiInstance)
	end)
	local function update()
		Roact.update(guiInstance, getComponent())
	end
	for teamName, teamInstance in Teams:GetChildren() do
		Maid:GiveTask(teamInstance.PlayerAdded:Connect(update))
		Maid:GiveTask(teamInstance.PlayerRemoved:Connect(update))
	end
	Maid:GiveTask(function()
		CurrentCamera.CameraType = Enum.CameraType.Custom
		local humanoid = CharacterUtils.getHumanoid(Players.LocalPlayer.Character)
		if humanoid then
			CurrentCamera.CameraSubject = humanoid
		end
		screenFade:FadeToLinear(1, 0.3)
		task.delay(0.3, function()
			screenFade:Destroy()
		end)
	end)
	InventoryItemSystem.unequipAll()
	onJumpCallback()
	eventEmitter.onTeamSelected(true)
	Maid:GiveTask(function()
		ColorCorrection.TintColor = Color3.new(255/255, 255/255, 255/255)
	end)
	if not shouldSkipFade then
		screenFade:FadeToLinear(0, 0.3)
		Maid:GiveTask(task.delay(0.4, function()
			shouldShowAnimation = true
			Roact.update(guiInstance, getComponent())
			screenFade:FadeToLinear(1, 0.3)
		end))
	end
	local gui = WorldMarkerSystem.gui
	if gui then
		gui.Enabled = false
		Maid:GiveTask(function()
			gui.Enabled = true
		end)
	end
end
function TeamChooseUI.Hide()
	TeamChooseUI.Maid:DoCleaning()
end
return TeamChooseUI
