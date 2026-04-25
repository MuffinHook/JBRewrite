-- Reviewed by Claude
-- variables reassigned
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
	launch = function(p1, p2)
		local instance12 = Binder.new("RoyaleBriefcase", function(p1)
			local maid = Maid.new()
			maid:GiveTask(CircleAction.Add({
				Name = "Open Briefcase",
				Timed = true,
				Duration = 0.5,
				Dist = 16,
				Callback = function(p12, p2)
					if p2 then
						p1:FindFirstChild("ClaimRemote"):FireServer()
					end
					return true
				end,
				Part = p1.PrimaryPart,
				ValidRoot = p1
			}, p1))
			local function updatePosition()
				local briefcaseOrigin = p1:GetAttribute("BriefcaseOrigin")
				local briefcaseTarget = p1:GetAttribute("BriefcaseTarget")
				local briefcaseLandNormal = p1:GetAttribute("BriefcaseLandNormal")
				local briefcaseDuration = p1:GetAttribute("BriefcaseDuration")
				local briefcaseBornAt = p1:GetAttribute("BriefcaseBornAt")
				local elapsedTime = workspace:GetServerTimeNow() - briefcaseBornAt
				if briefcaseDuration <= elapsedTime then
					maid.updatePosition = nil
					elapsedTime = briefcaseDuration
				end
				p1:PivotTo(BriefcaseUtils.getCFrameAt(elapsedTime, briefcaseOrigin, briefcaseTarget, briefcaseLandNormal, briefcaseDuration))
			end
			updatePosition()
			maid.updatePosition = RunService.Heartbeat:Connect(updatePosition)
			return maid
		end)
		p1:GiveTask(instance12)
		instance12:Start()
		local RoyaleColorCorrection = Instance.new("ColorCorrectionEffect")
		RoyaleColorCorrection.Name = "RoyaleColorCorrection"
		RoyaleColorCorrection.Enabled = true
		RoyaleColorCorrection.TintColor = Color3.new(255/255, 255/255, 255/255)
		RoyaleColorCorrection.Parent = game:GetService("Lighting")
		p1:GiveTask(RoyaleColorCorrection)
		local stormPositionBinding, setStormPosition = Roact.createBinding(Vector3.new(0, 0, 0))
		local stormRadiusBinding, setStormRadius = Roact.createBinding(0)
		local stormTargetPositionBinding, setStormTargetPosition = Roact.createBinding(Vector3.new(0, 0, 0))
		local stormTargetRadiusBinding, setStormTargetRadius = Roact.createBinding(0)
		local isInStorm = false
		local lastStormWarningTime = os.clock()
		local function processCharacterInStorm(p12)
			if os.clock() - lastStormWarningTime < 5 then
			elseif isInStorm ~= p12 then
				isInStorm = p12
				Audio.ObjectLocal(Players.LocalPlayer, 3217484827)
				local stormColorAnimationStartTime = os.clock()
				p1.animateStormColor = RunService.Heartbeat:Connect(function()
					local count = (os.clock() - stormColorAnimationStartTime) / 2
					if count >= 1 then
						p1.animateStormColor = nil
					end
					if not p12 then
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
		p1:GiveTask(stormRing)
		p1:GiveTask(RunService.Heartbeat:Connect(function()
			local color = stormPositionBinding:getValue()
			local color2 = p2:GetAttribute("StormWorldPosition")
			if color2 then
				local var3 = color:Lerp(color2, 0.1)
				setStormPosition(var3)
				color = var3
			end
			local sum = stormRadiusBinding:getValue()
			local stormWorldRadius = p2:GetAttribute("StormWorldRadius")
			if stormWorldRadius then
				sum = sum + (stormWorldRadius - sum) * 0.1
				setStormRadius(sum)
			end
			stormRing:FindFirstChild("Mesh").Scale = Vector3.new(2 * sum * 0.023809523809523808, 30, 2 * sum * 0.023809523809523808)
			stormRing.CFrame = CFrame.new(color.X, 500, color.Z)
			local localPlayer = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
			if localPlayer then
				processCharacterInStorm(if sum < ((localPlayer.Position - color) * Vector3.new(1, 0, 1)).Magnitude then localPlayer.Parent:GetAttribute("BattleRoyaleAlive") == true else false)
			end
		end))
		local function updatePositionTarget()
			setStormTargetPosition(p2:GetAttribute("StormWorldPositionTarget") or Vector3.new(0, 0, 0))
		end
		p2:GetAttributeChangedSignal("StormWorldPositionTarget"):Connect(updatePositionTarget)
		setStormTargetPosition(p2:GetAttribute("StormWorldPositionTarget") or Vector3.new(0, 0, 0))
		local function updateRadiusTarget()
			setStormTargetRadius(p2:GetAttribute("StormWorldRadiusTarget") or 0)
		end
		p2:GetAttributeChangedSignal("StormWorldRadiusTarget"):Connect(updateRadiusTarget)
		setStormTargetRadius(p2:GetAttribute("StormWorldRadiusTarget") or 0)
		p1:GiveTask(MinimapService.addCircle({
			name = "battleRoyale",
			worldPositionBinding = stormPositionBinding,
			worldRadiusBinding = stormRadiusBinding,
			color = color,
			transparency = 0.8
		}))
		p1:GiveTask(MinimapService.addCircle({
			name = "battleRoyaleTarget",
			worldPositionBinding = stormTargetPositionBinding,
			worldRadiusBinding = stormTargetRadiusBinding,
			color = color,
			transparency = 0.5
		}))
		LevelUISystem.hideTopbar()
		p1:GiveTask(LevelUISystem.showTopbar)
		local battleRoyaleGui = ReplicatedStorage.GameMode.Res:FindFirstChild("BRGui"):Clone()
		p1:GiveTask(battleRoyaleGui)
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
		p1:GiveTask(CollectionService:GetInstanceAddedSignal(SpectateConsts.SPECTATE_TAG_NAME):Connect(updatePlayersAlive))
		p1:GiveTask(CollectionService:GetInstanceRemovedSignal(SpectateConsts.SPECTATE_TAG_NAME):Connect(updatePlayersAlive))
		local remainingGameModeDuration = stormGameModeDuration
		local gameModeBornAt = p2:GetAttribute("GameModeBornAt")
		p1:GiveTask(Interval.every(1):Connect(function()
			local color = remainingGameModeDuration - (workspace:GetServerTimeNow() - gameModeBornAt)
			if color < 0 then
				color = 0
			end
			local color2 = math.floor(color / 60)
			battleRoyaleGui.Stats.Time.TextLabel.Text = ("%02d:%02d"):format(color2, (math.floor(color % 60)))
		end))
	end
}
