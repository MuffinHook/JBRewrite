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

local stormColor = Color3.fromRGB(192, 122, 255)
local whiteColor = Color3.fromRGB(255, 255, 255)

local gameDuration = if RunUtils.isStudio() then 20 else 600

return {
	launch = function(maid, gameModeInstance)
		local briefcaseBinder = Binder.new("RoyaleBriefcase", function(briefcaseModel)
			local briefcaseMaid = Maid.new()

			briefcaseMaid:GiveTask(CircleAction.Add({
				Name = "Open Briefcase",
				Timed = true,
				Duration = 0.5,
				Dist = 16,

				Callback = function(_, didComplete)
					if didComplete then
						briefcaseModel:FindFirstChild("ClaimRemote"):FireServer()
					end

					return true
				end,

				Part = briefcaseModel.PrimaryPart,
				ValidRoot = briefcaseModel,
			}, briefcaseModel))

			local function updatePosition()
				local origin = briefcaseModel:GetAttribute("BriefcaseOrigin")
				local target = briefcaseModel:GetAttribute("BriefcaseTarget")
				local landNormal = briefcaseModel:GetAttribute("BriefcaseLandNormal")
				local duration = briefcaseModel:GetAttribute("BriefcaseDuration")
				local bornAt = briefcaseModel:GetAttribute("BriefcaseBornAt")

				local elapsed = workspace:GetServerTimeNow() - bornAt

				if duration <= elapsed then
					elapsed = duration
					briefcaseMaid.updatePosition = nil
				end

				briefcaseModel:PivotTo(BriefcaseUtils.getCFrameAt(elapsed, origin, target, landNormal, duration))
			end

			updatePosition()
			briefcaseMaid.updatePosition = RunService.Heartbeat:Connect(updatePosition)

			return briefcaseMaid
		end)

		maid:GiveTask(briefcaseBinder)
		briefcaseBinder:Start()

		local royaleColorCorrection = Instance.new("ColorCorrectionEffect")
		royaleColorCorrection.Name = "RoyaleColorCorrection"
		royaleColorCorrection.Enabled = true
		royaleColorCorrection.TintColor = Color3.new(1, 1, 1)
		royaleColorCorrection.Parent = game:GetService("Lighting")

		maid:GiveTask(royaleColorCorrection)

		local stormWorldPositionBinding, setStormWorldPosition = Roact.createBinding(Vector3.new(0, 0, 0))
		local stormWorldRadiusBinding, setStormWorldRadius = Roact.createBinding(0)

		local stormTargetPositionBinding, setStormTargetPosition = Roact.createBinding(Vector3.new(0, 0, 0))
		local stormTargetRadiusBinding, setStormTargetRadius = Roact.createBinding(0)

		local isInStorm = false
		local launchClock = os.clock()

		local function processCharacterInStorm(inStorm)
			if os.clock() - launchClock < 5 then
				return
			end

			if isInStorm == inStorm then
				return
			end

			isInStorm = inStorm
			Audio.ObjectLocal(Players.LocalPlayer, 3217484827)

			local startClock = os.clock()

			maid.animateStormColor = RunService.Heartbeat:Connect(function()
				local alpha = (os.clock() - startClock) / 2

				if alpha >= 1 then
					maid.animateStormColor = nil
				end

				if not inStorm then
					alpha = 1 - alpha
				end

				royaleColorCorrection.TintColor = whiteColor:Lerp(stormColor, alpha)
			end)
		end

		local stormRing = ReplicatedStorage.GameMode.Res:FindFirstChild("StormRing"):Clone()
		stormRing.Transparency = 0

		local mesh = stormRing:FindFirstChild("Mesh")
		mesh.VertexColor = Vector3.new(stormColor.R, stormColor.G, stormColor.B)

		stormRing.Parent = workspace
		maid:GiveTask(stormRing)

		maid:GiveTask(RunService.Heartbeat:Connect(function()
			local stormPosition = stormWorldPositionBinding:getValue()
			local targetStormPosition = gameModeInstance:GetAttribute("StormWorldPosition")

			if targetStormPosition then
				stormPosition = stormPosition:Lerp(targetStormPosition, 0.1)
				setStormWorldPosition(stormPosition)
			end

			local stormRadius = stormWorldRadiusBinding:getValue()
			local targetStormRadius = gameModeInstance:GetAttribute("StormWorldRadius")

			if targetStormRadius then
				stormRadius = stormRadius + (targetStormRadius - stormRadius) * 0.1
				setStormWorldRadius(stormRadius)
			end

			stormRing:FindFirstChild("Mesh").Scale = Vector3.new(
				2 * stormRadius * 0.023809523809523808,
				30,
				2 * stormRadius * 0.023809523809523808
			)

			stormRing.CFrame = CFrame.new(stormPosition.X, 500, stormPosition.Z)

			local rootPart = CharacterUtils.getRootPart(Players.LocalPlayer.Character)

			if rootPart then
				local flatDistance = ((rootPart.Position - stormPosition) * Vector3.new(1, 0, 1)).Magnitude
				local alive = rootPart.Parent:GetAttribute("BattleRoyaleAlive") == true

				processCharacterInStorm(stormRadius < flatDistance and alive or false)
			end
		end))

		local function updatePositionTarget()
			setStormTargetPosition(gameModeInstance:GetAttribute("StormWorldPositionTarget") or Vector3.new(0, 0, 0))
		end

		maid:GiveTask(gameModeInstance:GetAttributeChangedSignal("StormWorldPositionTarget"):Connect(updatePositionTarget))
		updatePositionTarget()

		local function updateRadiusTarget()
			setStormTargetRadius(gameModeInstance:GetAttribute("StormWorldRadiusTarget") or 0)
		end

		maid:GiveTask(gameModeInstance:GetAttributeChangedSignal("StormWorldRadiusTarget"):Connect(updateRadiusTarget))
		updateRadiusTarget()

		maid:GiveTask(MinimapService.addCircle({
			name = "battleRoyale",
			worldPositionBinding = stormWorldPositionBinding,
			worldRadiusBinding = stormWorldRadiusBinding,
			color = stormColor,
			transparency = 0.8,
		}))

		maid:GiveTask(MinimapService.addCircle({
			name = "battleRoyaleTarget",
			worldPositionBinding = stormTargetPositionBinding,
			worldRadiusBinding = stormTargetRadiusBinding,
			color = stormColor,
			transparency = 0.5,
		}))

		LevelUISystem.hideTopbar()
		maid:GiveTask(LevelUISystem.showTopbar)

		local royaleGui = ReplicatedStorage.GameMode.Res:FindFirstChild("BRGui"):Clone()
		maid:GiveTask(royaleGui)

		royaleGui.Parent = Players.LocalPlayer.PlayerGui
		royaleGui.Enabled = true
		royaleGui.Stats.Visible = true

		local function updatePlayersAlive()
			royaleGui.Stats.Players.TextLabel.Text = tostring(#CollectionService:GetTagged(SpectateConsts.SPECTATE_TAG_NAME))
		end

		updatePlayersAlive()

		maid:GiveTask(CollectionService:GetInstanceAddedSignal(SpectateConsts.SPECTATE_TAG_NAME):Connect(updatePlayersAlive))
		maid:GiveTask(CollectionService:GetInstanceRemovedSignal(SpectateConsts.SPECTATE_TAG_NAME):Connect(updatePlayersAlive))

		local bornAt = gameModeInstance:GetAttribute("GameModeBornAt")

		maid:GiveTask(Interval.every(1):Connect(function()
			local timeLeft = gameDuration - (workspace:GetServerTimeNow() - bornAt)

			if timeLeft < 0 then
				timeLeft = 0
			end

			local minutes = math.floor(timeLeft / 60)
			local seconds = math.floor(timeLeft % 60)

			royaleGui.Stats.Time.TextLabel.Text = ("%02d:%02d"):format(minutes, seconds)
		end))
	end,
}