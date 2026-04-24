-- Reviewed by Claude
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
local t = {
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
local t2 = {}
for instance2, var3 in t do
	t2[instance2] = {
		p = Vector3.new(0, 0, 0),
		LookVector = Vector3.new(0, 0, -1)
	}
end
local function SelectIfGamepad(p1)
	EzUtils.selectIfGamepad(p1)
end
local function Ease_InOutQuad(p1)
	return p1 < 0.5 and 2 * p1 * p1 or -1 - 2 * (p1 - 2) * p1
end
local var4 = nil
local var5 = nil
local var6 = nil
local t3 = {
	ColorCorrection = nil,
	Maid = Maid.new()
}
function t3.Init(p1)
	var4 = p1.Event
	var5 = p1.em
	var6 = p1.OnJump
	t3.ColorCorrection = Lighting:FindFirstChild("ColorCorrection")
	function var5.rh1aeent()
		t3.Hide()
	end
	function var5.zijzuhxq(p1)
		if TeamShared.isTeamSwitchingEnabled() then
			t3.Show(p1)
		end
	end
	if not localPlayer or Settings.Test.ChooseTeamInitially then
		var5.zijzuhxq(true)
	end
end
function t3.Show(p1)
	local Maid = t3.Maid
	local ColorCorrection = t3.ColorCorrection
	assert(ColorCorrection)
	local localPlayer = nil
	local instance2 = ScreenFade.new()
	local var3 = 0
	local var42 = 0
	local var52 = CinematicCamera.MakeCinematicCamera()
	local function UpdateCamera()
		var42 = var42 + 1
		ColorCorrection.TintColor = Color3.new(255/255, 255/255, 255/255)
		local localPlayer = if RunUtils.isStudio() then t2 else t
		var3 = var3 % 3 + 1
		local instance2 = localPlayer["City" .. var3 .. "_Start"]
		local var32 = localPlayer["City" .. var3 .. "_Stop"]
		local var4 = CFrame.new(Vector3.new(), instance2.LookVector) + instance2.p
		local var5 = CFrame.new(Vector3.new(), var32.LookVector) + var32.p
		var52.StartPosition = var4.p
		var52.TargetPosition = var5.p
		var52.LookVector = var4.LookVector
		var52.TargetLookVector = nil
	end
	local var62 = tick()
	local var7 = p1 ~= nil
	local function RenderStepped(p1)
		local localPlayer = tick()
		local instance2 = localPlayer - var62
		if CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
			CurrentCamera.CameraType = Enum.CameraType.Scriptable
		end
		if var7 then
			if instance2 >= 24 then
				UpdateCamera()
				var62 = localPlayer
			end
			local var3 = instance2 / 24
			if var3 <= 0.1 and var42 ~= 1 then
				local var4 = var3 / 0.1
				local var5, var6
				if var4 < 0.5 then
					var5 = 2 * var4 * var4
					if not var5 then
						var6 = var4
						var5 = -1 - 2 * (var4 - 2) * var4
					end
				else
					var6 = var4
					var5 = -1 - 2 * (var4 - 2) * var4
				end
				ColorCorrection.TintColor = Color3.new(var5, var5, var5)
			elseif var3 >= 0.9 then
				local var72 = 1 - (var3 - 0.9) / 0.1
				local var8, var9
				if var72 < 0.5 then
					var8 = 2 * var72 * var72
					if not var8 then
						var9 = var72
						var8 = -1 - 2 * (var72 - 2) * var72
					end
				else
					var9 = var72
					var8 = -1 - 2 * (var72 - 2) * var72
				end
				ColorCorrection.TintColor = Color3.new(var8, var8, var8)
			end
			CinematicCamera.StepCinematicCamera(p1, var52, 0.1, var3)
		end
	end
	Maid:GiveTask(RunService.RenderStepped:Connect(RenderStepped))
	UpdateCamera()
	local var8 = false
	local function play()
		if var8 then
		elseif TeamShared.isTeamFull(localPlayer) then
			localPlayer = nil
			Notification.new({
				Text = Localization:FormatByKey("Teams.TeamFull")
			})
		else
			var8 = true
			instance2:FadeToLinear(0, 0.3)
			var4:FireServer("c" .. "" .. ("bds94b"):sub(4, 5):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("wfb5itc"):sub(3, 6):reverse():reverse():reverse():reverse():reverse() .. "x", localPlayer)
			Maid:GiveTask(task.delay(2, function()
				instance2:Set(1)
				var8 = false
			end))
		end
	end
	local var9 = Roact.createRef()
	local function getComponent()
		EzUtils.isSmallScreen()
		local sum = 0
		local sum_2 = 0
		for instance2, var3 in Teams:GetChildren() do
			if var3.Name == "Police" then
				sum_2 = sum_2 + #var3:GetPlayers()
			else
				sum = sum + #var3:GetPlayers()
			end
		end
		local var4 = RunUtils.getPlaceType() == "Default"
		local _ = RunUtils.getPlaceType() == "VoiceChat"
		local var5 = RunUtils.getPlaceType() == "Pro"
		local t = {}
		local t2 = {
			onClicked = function()
				local localPlayer = if var4 then "VoiceChat" else "Default"
				local instance2, var3 = pcall(function()
					return VoiceChatService:IsVoiceEnabledForUserIdAsync(Players.LocalPlayer.UserId)
				end)
				if var4 and not (instance2 and var3) then
					Notification.new({
						Text = "Enable voice chat to join voice chat servers!"
					})
				else
					ReplicatedStorage.TeamSelect:FindFirstChild(TeamSelectConsts.TELEPORT_PLACE_TYPE_REMOTE_NAME):FireServer(localPlayer)
				end
			end
		}
		t2.text = if var4 then "VOICECHAT SERVERS" else "MAIN SERVERS"
		local t3 = {
			onClicked = function()
				local localPlayer = if var5 then "VoiceChat" else "Pro"
				local instance2, var3 = pcall(function()
					return VoiceChatService:IsVoiceEnabledForUserIdAsync(Players.LocalPlayer.UserId)
				end)
				if var5 and not (instance2 and var3) then
					Notification.new({
						Text = "Enable voice chat to join voice chat servers!"
					})
				elseif var5 or not (Players.LocalPlayer.AccountAge < 60) then
					if var5 or Players.LocalPlayer:GetAttribute("ProServerAccess") then
						ReplicatedStorage.TeamSelect:FindFirstChild(TeamSelectConsts.TELEPORT_PLACE_TYPE_REMOTE_NAME):FireServer(localPlayer)
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
		t3.text = if var5 then "VOICECHAT SERVERS" else "HIGH ROLLER SERVERS"
		t[1] = t2
		t[2] = t3
		t[3] = {
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
			table.insert(t, 1, {
				onClicked = function()
					ReplicatedStorage.TeamSelect:FindFirstChild(TeamSelectConsts.TELEPORT_PLACE_TYPE_REMOTE_NAME):FireServer("Hang")
				end,
				text = "OG JAILBREAK",
				textColor = Color3.fromHex("e88839")
			})
		end
		local var8 = Players.LocalPlayer:GetAttribute("AllowCriminalSpawn")
		return createElement("ScreenGui", {
			IgnoreGuiInset = true,
			Enabled = var7
		}, {
			TeamSelect = createElement(TeamSelect, {
				size = UDim2.fromScale(1, 1),
				numPolice = sum_2,
				numCriminals = sum,
				criminalButtonRef = var9,
				allowCriminal = if var8 == nil then false else var8,
				onTeamSelected = function(p1)
					localPlayer = p1
					play()
				end,
				serverButtons = t
			})
		})
	end
	local localPlayer = Roact.mount(getComponent(), Players.LocalPlayer.PlayerGui, "TeamSelectGui")
	if var9:getValue() then
		EzUtils.selectIfGamepad((var9:getValue()))
	end
	Maid:GiveTask(function()
		Roact.unmount(localPlayer)
	end)
	local function update()
		Roact.update(localPlayer, getComponent())
	end
	for v12, v13 in Teams:GetChildren() do
		Maid:GiveTask(v13.PlayerAdded:Connect(update))
		Maid:GiveTask(v13.PlayerRemoved:Connect(update))
	end
	Maid:GiveTask(function()
		CurrentCamera.CameraType = Enum.CameraType.Custom
		local localPlayer = CharacterUtils.getHumanoid(Players.LocalPlayer.Character)
		if localPlayer then
			CurrentCamera.CameraSubject = localPlayer
		end
		instance2:FadeToLinear(1, 0.3)
		task.delay(0.3, function()
			instance2:Destroy()
		end)
	end)
	InventoryItemSystem.unequipAll()
	var6()
	var5.dmg39zpa(true)
	Maid:GiveTask(function()
		ColorCorrection.TintColor = Color3.new(255/255, 255/255, 255/255)
	end)
	if not p1 then
		instance2:FadeToLinear(0, 0.3)
		Maid:GiveTask(task.delay(0.4, function()
			var7 = true
			Roact.update(localPlayer, getComponent())
			instance2:FadeToLinear(1, 0.3)
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
function t3.Hide()
	t3.Maid:DoCleaning()
end
return t3
