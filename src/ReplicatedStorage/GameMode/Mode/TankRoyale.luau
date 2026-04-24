-- Reviewed by Claude
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
local var3 = if RunUtils.isStudio() then 20 else 600
return {
	launch = function(p1, p2)
		local instance12 = Binder.new("RoyaleBriefcase", function(p1)
			local color = Maid.new()
			color:GiveTask(CircleAction.Add({
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
				local instance12 = p1:GetAttribute("BriefcaseOrigin")
				local color2 = p1:GetAttribute("BriefcaseTarget")
				local var3 = p1:GetAttribute("BriefcaseLandNormal")
				local var4 = p1:GetAttribute("BriefcaseDuration")
				local var5 = p1:GetAttribute("BriefcaseBornAt")
				local var6 = workspace:GetServerTimeNow() - var5
				if var4 <= var6 then
					color.updatePosition = nil
					var6 = var4
				end
				p1:PivotTo(BriefcaseUtils.getCFrameAt(var6, instance12, color2, var3, var4))
			end
			updatePosition()
			color.updatePosition = RunService.Heartbeat:Connect(updatePosition)
			return color
		end)
		p1:GiveTask(instance12)
		instance12:Start()
		local RoyaleColorCorrection = Instance.new("ColorCorrectionEffect")
		RoyaleColorCorrection.Name = "RoyaleColorCorrection"
		RoyaleColorCorrection.Enabled = true
		RoyaleColorCorrection.TintColor = Color3.new(255/255, 255/255, 255/255)
		RoyaleColorCorrection.Parent = game:GetService("Lighting")
		p1:GiveTask(RoyaleColorCorrection)
		local v22, v32 = Roact.createBinding(Vector3.new(0, 0, 0))
		local var4, var5 = Roact.createBinding(0)
		local var6, v7 = Roact.createBinding(Vector3.new(0, 0, 0))
		local v8, v9 = Roact.createBinding(0)
		local var10 = false
		local var11 = os.clock()
		local function processCharacterInStorm(p12)
			if os.clock() - var11 < 5 then
			elseif var10 ~= p12 then
				var10 = p12
				Audio.ObjectLocal(Players.LocalPlayer, 3217484827)
				local instance12 = os.clock()
				p1.animateStormColor = RunService.Heartbeat:Connect(function()
					local count = (os.clock() - instance12) / 2
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
		local var122 = ReplicatedStorage.GameMode.Res:FindFirstChild("StormRing"):Clone()
		var122.Transparency = 0
		var122.Color = Color3.fromRGB(4, 141, 39)
		local Mesh = var122:FindFirstChild("Mesh")
		Mesh.VertexColor = Vector3.new(color.R, color.G, color.B)
		var122.Parent = workspace
		p1:GiveTask(var122)
		p1:GiveTask(RunService.Heartbeat:Connect(function()
			local color = v22:getValue()
			local color2 = p2:GetAttribute("StormWorldPosition")
			if color2 then
				local var3 = color:Lerp(color2, 0.1)
				v32(var3)
				color = var3
			end
			local sum = var4:getValue()
			local var42 = p2:GetAttribute("StormWorldRadius")
			if var42 then
				sum = sum + (var42 - sum) * 0.1
				var5(sum)
			end
			var122:FindFirstChild("Mesh").Scale = Vector3.new(2 * sum * 0.023809523809523808, 30, 2 * sum * 0.023809523809523808)
			var122.CFrame = CFrame.new(color.X, 500, color.Z)
			local localPlayer = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
			if localPlayer then
				processCharacterInStorm(if sum < ((localPlayer.Position - color) * Vector3.new(1, 0, 1)).Magnitude then localPlayer.Parent:GetAttribute("BattleRoyaleAlive") == true else false)
			end
		end))
		local function updatePositionTarget()
			v7(p2:GetAttribute("StormWorldPositionTarget") or Vector3.new(0, 0, 0))
		end
		p2:GetAttributeChangedSignal("StormWorldPositionTarget"):Connect(updatePositionTarget)
		v7(p2:GetAttribute("StormWorldPositionTarget") or Vector3.new(0, 0, 0))
		local function updateRadiusTarget()
			v9(p2:GetAttribute("StormWorldRadiusTarget") or 0)
		end
		p2:GetAttributeChangedSignal("StormWorldRadiusTarget"):Connect(updateRadiusTarget)
		v9(p2:GetAttribute("StormWorldRadiusTarget") or 0)
		p1:GiveTask(MinimapService.addCircle({
			name = "battleRoyale",
			worldPositionBinding = v22,
			worldRadiusBinding = var4,
			color = color,
			transparency = 0.8
		}))
		p1:GiveTask(MinimapService.addCircle({
			name = "battleRoyaleTarget",
			worldPositionBinding = var6,
			worldRadiusBinding = v8,
			color = color,
			transparency = 0.5
		}))
		LevelUISystem.hideTopbar()
		p1:GiveTask(LevelUISystem.showTopbar)
		local var13 = ReplicatedStorage.GameMode.Res:FindFirstChild("BRGui"):Clone()
		p1:GiveTask(var13)
		var13.Parent = Players.LocalPlayer.PlayerGui
		var13.Enabled = true
		var13.Stats.Players.ImageColor3 = Color3.fromRGB(78, 189, 72)
		var13.Stats.Time.ImageColor3 = Color3.fromRGB(78, 189, 72)
		var13.Stats.Players.TextLabel.TextColor3 = Color3.fromRGB(0, 255, 51)
		var13.Stats.Time.TextLabel.TextColor3 = Color3.fromRGB(0, 255, 51)
		var13.Stats.Visible = true
		local function updatePlayersAlive()
			var13.Stats.Players.TextLabel.Text = tostring(#CollectionService:GetTagged(SpectateConsts.SPECTATE_TAG_NAME))
		end
		var13.Stats.Players.TextLabel.Text = tostring(#CollectionService:GetTagged(SpectateConsts.SPECTATE_TAG_NAME))
		p1:GiveTask(CollectionService:GetInstanceAddedSignal(SpectateConsts.SPECTATE_TAG_NAME):Connect(updatePlayersAlive))
		p1:GiveTask(CollectionService:GetInstanceRemovedSignal(SpectateConsts.SPECTATE_TAG_NAME):Connect(updatePlayersAlive))
		local var15 = var3
		local var16 = p2:GetAttribute("GameModeBornAt")
		p1:GiveTask(Interval.every(1):Connect(function()
			local color = var15 - (workspace:GetServerTimeNow() - var16)
			if color < 0 then
				color = 0
			end
			local color2 = math.floor(color / 60)
			var13.Stats.Time.TextLabel.Text = ("%02d:%02d"):format(color2, (math.floor(color % 60)))
		end))
	end
}
