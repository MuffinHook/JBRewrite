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
local v1 = Color3.fromRGB(4, 141, 39)
local v2 = Color3.fromRGB(255, 255, 255)
local v3 = if RunUtils.isStudio() then 20 else 600
return {
	launch = function(p1, p2) --[[ Name: launch | Line: 30 | Upvalues: Binder (copy), Maid (copy), CircleAction (copy), BriefcaseUtils (copy), RunService (copy), Roact (copy), Audio (copy), Players (copy), v2 (copy), v1 (copy), ReplicatedStorage (copy), CharacterUtils (copy), MinimapService (copy), LevelUISystem (copy), CollectionService (copy), SpectateConsts (copy), v3 (ref), Interval (copy) ]]
		local v12 = Binder.new("RoyaleBriefcase", function(p1) --[[ Line: 31 | Upvalues: Maid (ref), CircleAction (ref), BriefcaseUtils (ref), RunService (ref) ]]
			local v1 = Maid.new()
			v1:GiveTask(CircleAction.Add({
				Name = "Open Briefcase",
				Timed = true,
				Duration = 0.5,
				Dist = 16,
				Callback = function(p12, p2) --[[ Name: action | Line: 33 | Upvalues: p1 (copy) ]]
					if p2 then
						p1:FindFirstChild("ClaimRemote"):FireServer()
					end
					return true
				end,
				Part = p1.PrimaryPart,
				ValidRoot = p1
			}, p1))
			local function updatePosition() --[[ Line: 52 | Upvalues: p1 (copy), v1 (copy), BriefcaseUtils (ref) ]]
				local v12 = p1:GetAttribute("BriefcaseOrigin")
				local v2 = p1:GetAttribute("BriefcaseTarget")
				local v3 = p1:GetAttribute("BriefcaseLandNormal")
				local v4 = p1:GetAttribute("BriefcaseDuration")
				local v5 = p1:GetAttribute("BriefcaseBornAt")
				local v6 = workspace:GetServerTimeNow() - v5
				if v4 <= v6 then
					v1.updatePosition = nil
					v6 = v4
				end
				p1:PivotTo(BriefcaseUtils.getCFrameAt(v6, v12, v2, v3, v4))
			end
			updatePosition()
			v1.updatePosition = RunService.Heartbeat:Connect(updatePosition)
			return v1
		end)
		p1:GiveTask(v12)
		v12:Start()
		local RoyaleColorCorrection = Instance.new("ColorCorrectionEffect")
		RoyaleColorCorrection.Name = "RoyaleColorCorrection"
		RoyaleColorCorrection.Enabled = true
		RoyaleColorCorrection.TintColor = Color3.new(255/255, 255/255, 255/255)
		RoyaleColorCorrection.Parent = game:GetService("Lighting")
		p1:GiveTask(RoyaleColorCorrection)
		local v22, v32 = Roact.createBinding(Vector3.new(0, 0, 0))
		local v4, v5 = Roact.createBinding(0)
		local v6, v7 = Roact.createBinding(Vector3.new(0, 0, 0))
		local v8, v9 = Roact.createBinding(0)
		local v10 = false
		local v11 = os.clock()
		local function processCharacterInStorm(p12) --[[ Line: 86 | Upvalues: v11 (copy), v10 (ref), Audio (ref), Players (ref), p1 (copy), RunService (ref), v2 (ref), v1 (ref), RoyaleColorCorrection (copy) ]]
			if os.clock() - v11 < 5 then
			elseif v10 ~= p12 then
				v10 = p12
				Audio.ObjectLocal(Players.LocalPlayer, 3217484827)
				local v12 = os.clock()
				p1.animateStormColor = RunService.Heartbeat:Connect(function() --[[ Line: 100 | Upvalues: v12 (copy), p1 (ref), p12 (copy), v2 (ref), v1 (ref), RoyaleColorCorrection (ref) ]]
					local count = (os.clock() - v12) / 2
					if count >= 1 then
						p1.animateStormColor = nil
					end
					if not p12 then
						count = 1 - count
					end
					RoyaleColorCorrection.TintColor = v2:Lerp(v1, count)
				end)
			end
		end
		local v122 = ReplicatedStorage.GameMode.Res:FindFirstChild("StormRing"):Clone()
		v122.Transparency = 0
		v122.Color = Color3.fromRGB(4, 141, 39)
		local Mesh = v122:FindFirstChild("Mesh")
		Mesh.VertexColor = Vector3.new(v1.R, v1.G, v1.B)
		v122.Parent = workspace
		p1:GiveTask(v122)
		p1:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 122 | Upvalues: v22 (copy), p2 (copy), v32 (copy), v4 (copy), v5 (copy), v122 (copy), CharacterUtils (ref), Players (ref), processCharacterInStorm (copy) ]]
			local v1 = v22:getValue()
			local v2 = p2:GetAttribute("StormWorldPosition")
			if v2 then
				local v3 = v1:Lerp(v2, 0.1)
				v32(v3)
				v1 = v3
			end
			local sum = v4:getValue()
			local v42 = p2:GetAttribute("StormWorldRadius")
			if v42 then
				sum = sum + (v42 - sum) * 0.1
				v5(sum)
			end
			v122:FindFirstChild("Mesh").Scale = Vector3.new(2 * sum * 0.023809523809523808, 30, 2 * sum * 0.023809523809523808)
			v122.CFrame = CFrame.new(v1.X, 500, v1.Z)
			local v52 = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
			if v52 then
				processCharacterInStorm(if sum < ((v52.Position - v1) * Vector3.new(1, 0, 1)).Magnitude then v52.Parent:GetAttribute("BattleRoyaleAlive") == true else false)
			end
		end))
		local function updatePositionTarget() --[[ Line: 147 | Upvalues: v7 (copy), p2 (copy) ]]
			v7(p2:GetAttribute("StormWorldPositionTarget") or Vector3.new(0, 0, 0))
		end
		p2:GetAttributeChangedSignal("StormWorldPositionTarget"):Connect(updatePositionTarget)
		v7(p2:GetAttribute("StormWorldPositionTarget") or Vector3.new(0, 0, 0))
		local function updateRadiusTarget() --[[ Line: 152 | Upvalues: v9 (copy), p2 (copy) ]]
			v9(p2:GetAttribute("StormWorldRadiusTarget") or 0)
		end
		p2:GetAttributeChangedSignal("StormWorldRadiusTarget"):Connect(updateRadiusTarget)
		v9(p2:GetAttribute("StormWorldRadiusTarget") or 0)
		p1:GiveTask(MinimapService.addCircle({
			name = "battleRoyale",
			worldPositionBinding = v22,
			worldRadiusBinding = v4,
			color = v1,
			transparency = 0.8
		}))
		p1:GiveTask(MinimapService.addCircle({
			name = "battleRoyaleTarget",
			worldPositionBinding = v6,
			worldRadiusBinding = v8,
			color = v1,
			transparency = 0.5
		}))
		LevelUISystem.hideTopbar()
		p1:GiveTask(LevelUISystem.showTopbar)
		local v13 = ReplicatedStorage.GameMode.Res:FindFirstChild("BRGui"):Clone()
		p1:GiveTask(v13)
		v13.Parent = Players.LocalPlayer.PlayerGui
		v13.Enabled = true
		v13.Stats.Players.ImageColor3 = Color3.fromRGB(78, 189, 72)
		v13.Stats.Time.ImageColor3 = Color3.fromRGB(78, 189, 72)
		v13.Stats.Players.TextLabel.TextColor3 = Color3.fromRGB(0, 255, 51)
		v13.Stats.Time.TextLabel.TextColor3 = Color3.fromRGB(0, 255, 51)
		v13.Stats.Visible = true
		local function updatePlayersAlive() --[[ Line: 189 | Upvalues: v13 (copy), CollectionService (ref), SpectateConsts (ref) ]]
			v13.Stats.Players.TextLabel.Text = tostring(#CollectionService:GetTagged(SpectateConsts.SPECTATE_TAG_NAME))
		end
		v13.Stats.Players.TextLabel.Text = tostring(#CollectionService:GetTagged(SpectateConsts.SPECTATE_TAG_NAME))
		p1:GiveTask(CollectionService:GetInstanceAddedSignal(SpectateConsts.SPECTATE_TAG_NAME):Connect(updatePlayersAlive))
		p1:GiveTask(CollectionService:GetInstanceRemovedSignal(SpectateConsts.SPECTATE_TAG_NAME):Connect(updatePlayersAlive))
		local v15 = v3
		local v16 = p2:GetAttribute("GameModeBornAt")
		p1:GiveTask(Interval.every(1):Connect(function() --[[ Line: 198 | Upvalues: v16 (copy), v15 (copy), v13 (copy) ]]
			local v1 = v15 - (workspace:GetServerTimeNow() - v16)
			if v1 < 0 then
				v1 = 0
			end
			local v2 = math.floor(v1 / 60)
			v13.Stats.Time.TextLabel.Text = ("%02d:%02d"):format(v2, (math.floor(v1 % 60)))
		end))
	end
}