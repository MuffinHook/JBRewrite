local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local BriefcaseUtils = require(ReplicatedStorage.AirDrop.BriefcaseUtils)
local MinimapService = require(ReplicatedStorage.App.MinimapService)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local UI = require(ReplicatedStorage.Module.UI)
local Roact = require(ReplicatedStorage.Roact)
local Audio = require(ReplicatedStorage.Std.Audio)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
require(ReplicatedStorage.Std.ColorUtils)
local Interval = require(ReplicatedStorage.Std.Interval)
local LevelUISystem = require(ReplicatedStorage.Game.Level2.LevelUISystem)
local SpectateConsts = require(ReplicatedStorage.Spectate.SpectateConsts)
local CircleAction = UI.CircleAction
local color = Color3.fromRGB(4, 141, 39)
local color2 = Color3.fromRGB(255, 255, 255)
local stormGameModeDuration = if RunUtils.isStudio() then 20 else 600
return {
	launch = function(maid, gameMode)
		local briefcaseBinder = Binder.new("RoyaleBriefcase", function(briefcase)
			local briefcaseMaid = Maid.new()
			briefcaseMaid:GiveTask(CircleAction.Add({
				Name = "Open Briefcase",
				Timed = true,
				Duration = 0.5,
				Dist = 16,
				Callback = function(player, completed)
					if completed then
						briefcase:FindFirstChild("ClaimRemote"):FireServer()
					end
					return true
				end,
				Part = briefcase.PrimaryPart,
				ValidRoot = briefcase
			}, briefcase))
			local function updatePosition()
				local briefcaseOrigin = briefcase:GetAttribute("BriefcaseOrigin")
				local briefcaseTarget = briefcase:GetAttribute("BriefcaseTarget")
				local briefcaseLandNormal = briefcase:GetAttribute("BriefcaseLandNormal")
				local briefcaseDuration = briefcase:GetAttribute("BriefcaseDuration")
				local briefcaseBornAt = briefcase:GetAttribute("BriefcaseBornAt")
				local elapsedTime = workspace:GetServerTimeNow() - briefcaseBornAt
				if briefcaseDuration <= elapsedTime then
					briefcaseMaid.updatePosition = nil
					elapsedTime = briefcaseDuration
				end
				briefcase:PivotTo(BriefcaseUtils.getCFrameAt(elapsedTime, briefcaseOrigin, briefcaseTarget, briefcaseLandNormal, briefcaseDuration))
			end
			updatePosition()
			briefcaseMaid.updatePosition = RunService.Heartbeat:Connect(updatePosition)
			return briefcaseMaid
		end)
		maid:GiveTask(briefcaseBinder)
		briefcaseBinder:Start()
		local RoyaleColorCorrection = Instance.new("ColorCorrectionEffect")
		RoyaleColorCorrection.Name = "RoyaleColorCorrection"
		RoyaleColorCorrection.Enabled = true
		RoyaleColorCorrection.TintColor = Color3.new(255/255, 255/255, 255/255)
		RoyaleColorCorrection.Parent = game:GetService("Lighting")
		maid:GiveTask(RoyaleColorCorrection)
		local stormPositionBinding, setStormPosition = Roact.createBinding(Vector3.new(0, 0, 0))
		local stormRadiusBinding, setStormRadius = Roact.createBinding(0)
		local stormTargetPositionBinding, setStormTargetPosition = Roact.createBinding(Vector3.new(0, 0, 0))
		local stormTargetRadiusBinding, setStormTargetRadius = Roact.createBinding(0)
		local isInStorm = false
		local lastStormWarningTime = os.clock()
		local function processCharacterInStorm(inStorm)
			if os.clock() - lastStormWarningTime < 5 then
			elseif isInStorm ~= inStorm then
				isInStorm = inStorm
				Audio.ObjectLocal(Players.LocalPlayer, 3217484827)
				local stormColorAnimationStartTime = os.clock()
				maid.animateStormColor = RunService.Heartbeat:Connect(function()
					local count = (os.clock() - stormColorAnimationStartTime) / 2
					if count >= 1 then
						maid.animateStormColor = nil
					end
					if not inStorm then
						count = 1 - count
					end
					RoyaleColorCorrection.TintColor = color2:Lerp(color, count)
				end)
			end
		end
		local stormRing = ReplicatedStorage.GameMode.Res:FindFirstChild("StormRing"):Clone()
		stormRing.Transparency = 0
		stormRing.Color = Color3.fromRGB(4, 141, 39)
		local Mesh = stormRing:FindFirstChild("Mesh")
		Mesh.VertexColor = Vector3.new(color.R, color.G, color.B)
		stormRing.Parent = workspace
		maid:GiveTask(stormRing)
		maid:GiveTask(RunService.Heartbeat:Connect(function()
			local currentStormPosition = stormPositionBinding:getValue()
			local stormWorldPosition = gameMode:GetAttribute("StormWorldPosition")
			if stormWorldPosition then
				local interpolatedPosition = currentStormPosition:Lerp(stormWorldPosition, 0.1)
				setStormPosition(interpolatedPosition)
				currentStormPosition = interpolatedPosition
			end
			local currentRadius = stormRadiusBinding:getValue()
			local stormWorldRadius = gameMode:GetAttribute("StormWorldRadius")
			if stormWorldRadius then
				currentRadius = currentRadius + (stormWorldRadius - currentRadius) * 0.1
				setStormRadius(currentRadius)
			end
			stormRing:FindFirstChild("Mesh").Scale = Vector3.new(2 * currentRadius * 0.023809523809523808, 30, 2 * currentRadius * 0.023809523809523808)
			stormRing.CFrame = CFrame.new(currentStormPosition.X, 500, currentStormPosition.Z)
			local localPlayer = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
			if localPlayer then
				processCharacterInStorm(if currentRadius < ((localPlayer.Position - currentStormPosition) * Vector3.new(1, 0, 1)).Magnitude then localPlayer.Parent:GetAttribute("BattleRoyaleAlive") == true else false)
			end
		end))
		local function updatePositionTarget()
			setStormTargetPosition(gameMode:GetAttribute("StormWorldPositionTarget") or Vector3.new(0, 0, 0))
		end
		gameMode:GetAttributeChangedSignal("StormWorldPositionTarget"):Connect(updatePositionTarget)
		setStormTargetPosition(gameMode:GetAttribute("StormWorldPositionTarget") or Vector3.new(0, 0, 0))
		local function updateRadiusTarget()
			setStormTargetRadius(gameMode:GetAttribute("StormWorldRadiusTarget") or 0)
		end
		gameMode:GetAttributeChangedSignal("StormWorldRadiusTarget"):Connect(updateRadiusTarget)
		setStormTargetRadius(gameMode:GetAttribute("StormWorldRadiusTarget") or 0)
		maid:GiveTask(MinimapService.addCircle({
			name = "battleRoyale",
			worldPositionBinding = stormPositionBinding,
			worldRadiusBinding = stormRadiusBinding,
			color = color,
			transparency = 0.8
		}))
		maid:GiveTask(MinimapService.addCircle({
			name = "battleRoyaleTarget",
			worldPositionBinding = stormTargetPositionBinding,
			worldRadiusBinding = stormTargetRadiusBinding,
			color = color,
			transparency = 0.5
		}))
		LevelUISystem.hideTopbar()
		maid:GiveTask(LevelUISystem.showTopbar)
		local battleRoyaleGui = ReplicatedStorage.GameMode.Res:FindFirstChild("BRGui"):Clone()
		maid:GiveTask(battleRoyaleGui)
		battleRoyaleGui.Parent = Players.LocalPlayer.PlayerGui
		battleRoyaleGui.Enabled = true
		battleRoyaleGui.Stats.Players.ImageColor3 = Color3.fromRGB(78, 189, 72)
		battleRoyaleGui.Stats.Time.ImageColor3 = Color3.fromRGB(78, 189, 72)
		battleRoyaleGui.Stats.Players.TextLabel.TextColor3 = Color3.fromRGB(0, 255, 51)
		battleRoyaleGui.Stats.Time.TextLabel.TextColor3 = Color3.fromRGB(0, 255, 51)
		battleRoyaleGui.Stats.Visible = true
		local function updatePlayersAlive()
			battleRoyaleGui.Stats.Players.TextLabel.Text = tostring(#CollectionService:GetTagged(SpectateConsts.SPECTATE_TAG_NAME))
		end
		battleRoyaleGui.Stats.Players.TextLabel.Text = tostring(#CollectionService:GetTagged(SpectateConsts.SPECTATE_TAG_NAME))
		maid:GiveTask(CollectionService:GetInstanceAddedSignal(SpectateConsts.SPECTATE_TAG_NAME):Connect(updatePlayersAlive))
		maid:GiveTask(CollectionService:GetInstanceRemovedSignal(SpectateConsts.SPECTATE_TAG_NAME):Connect(updatePlayersAlive))
		local remainingGameModeDuration = stormGameModeDuration
		local gameModeBornAt = gameMode:GetAttribute("GameModeBornAt")
		maid:GiveTask(Interval.every(1):Connect(function()
			local secondsRemaining = remainingGameModeDuration - (workspace:GetServerTimeNow() - gameModeBornAt)
			if secondsRemaining < 0 then
				secondsRemaining = 0
			end
			local minutes = math.floor(secondsRemaining / 60)
			battleRoyaleGui.Stats.Time.TextLabel.Text = ("%02d:%02d"):format(minutes, (math.floor(secondsRemaining % 60)))
		end))
	end
}
