-- Reviewed by Claude
-- variables reassigned
local LocalPlayer = game:GetService("Players").LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Silo = require(ReplicatedStorage.Game.Silo)
local Nuke = require(ReplicatedStorage.Game.Nuke)
local Shockwave = require(ReplicatedStorage.Game.Shockwave)
local Falling = require(ReplicatedStorage.Game.Falling)
local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local Confirmation = require(ReplicatedStorage.Module.Confirmation)
local Audio = require(ReplicatedStorage.Std.Audio)
local CamShaker = require(ReplicatedStorage.Game.CamShaker.CamShaker)
local Format = require(ReplicatedStorage.Module.Format)
local UI = require(ReplicatedStorage.Module.UI)
local Joint = require(ReplicatedStorage.Std.Joint)
local CircleAction = UI.CircleAction
local NukeEvent = nil
local function SetTransparency(p1, p2)
	for i, v in ipairs(p1:GetChildren()) do
		local transparency
		if v:IsA("BasePart") then
			transparency = if p2 then 0 else 1
			v.Transparency = transparency
		end
		SetTransparency(v, p2)
	end
end
return {
	Init = function(p1)
		NukeEvent = p1.Event
		local em = p1.em
		function em.qx3dpfz6(p1)
			assert(p1 ~= nil)
			assert(p1.Nuke ~= nil)
			assert(p1.Shockwave ~= nil)
			local launchAudio = Audio.ObjectLocal(LocalPlayer, 9058580326, {
				Looped = true,
				Volume = 0,
				Pitch = 0.35
			})
			Audio.FadeTo(launchAudio, 0.5, 5)
			local siloInstance = Silo.new(workspace:WaitForChild("Silo", 1))
			local tubePosition = siloInstance.Model.Tube.Position + Vector3.new(0, siloInstance.Model.Tube.Size.Y * 0.5, 0)
			local camShaker = CamShaker.new(Enum.RenderPriority.Camera.Value + 1, function(p1)
				CurrentCamera.CFrame = CurrentCamera.CFrame * p1
			end)
			camShaker:Start()
			local nukeModel = Nuke.new()
			siloInstance:Open()
			local launchStartTime = tick()
			local launchConnection = nil
			launchConnection = RunService.Heartbeat:Connect(function()
				local launchProgress = (tick() - launchStartTime) / 5
				if launchProgress > 1 then
					launchConnection:Disconnect()
					launchProgress = 1
				end
				nukeModel.Model:SetPrimaryPartCFrame(CFrame.new(tubePosition) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, 0, 48 * (1 - launchProgress) + 12 * launchProgress))
			end)
			siloInstance.OnOpened:Connect(function()
				p1.Nuke.Origin = nukeModel.Model.PrimaryPart.CFrame.p
				nukeModel:Launch(p1.Nuke)
				Audio.ObjectLocal(LocalPlayer, 2205008075)
				local impactAudio = Audio.ObjectLocal(LocalPlayer, 4828205974, {
					Volume = 0,
					Looped = true
				})
				Audio.FadeTo(impactAudio, 0.8, 0.5)
				local vibrationSustain = camShaker:ShakeSustain(CamShaker.Presets.Vibration)
				nukeModel.OnImpact:Connect(function()
					Audio.FadeTo(launchAudio, 0, 5)
					delay(5, function()
						launchAudio:Destroy()
					end)
					Audio.ObjectLocal(LocalPlayer, 2205008239, {
						Volume = 1
					})
					camShaker:Shake(CamShaker.Presets.Explosion)
					vibrationSustain:StartFadeOut(1)
					Audio.FadeTo(impactAudio, 0, 0.5)
					delay(0.5, function()
						impactAudio:Destroy()
						impactAudio = nil
					end)
					local mushroomCloud = ReplicatedStorage.Resource.MushroomCloud:Clone()
					mushroomCloud.CFrame = CFrame.new(p1.Nuke.Target) + Vector3.new(0, 261.646, 0)
					mushroomCloud.Transparency = 1
					mushroomCloud.Parent = workspace
					local function FadeInCloud()
						local fadeStartTime = tick()
						local fadeConnection = nil
						fadeConnection = RunService.Heartbeat:Connect(function()
							local fadeProgress = (tick() - fadeStartTime) / 5
							if fadeProgress > 1 then
								fadeConnection:Disconnect()
								fadeProgress = 1
							end
							mushroomCloud.Transparency = 1 * (1 - fadeProgress) + 0 * fadeProgress
						end)
					end
					local function FadeOutCloud()
						local fadeStartTime = tick()
						local fadeConnection = nil
						fadeConnection = RunService.Heartbeat:Connect(function()
							local fadeProgress = (tick() - fadeStartTime) / 2
							if fadeProgress > 1 then
								fadeConnection:Disconnect()
								fadeProgress = 1
							end
							mushroomCloud.Transparency = 0 * (1 - fadeProgress) + 1 * fadeProgress
						end)
					end
					local cloudFadeStartTime = tick()
					local cloudFadeConnection = nil
					cloudFadeConnection = RunService.Heartbeat:Connect(function()
						local cloudFadeProgress = (tick() - cloudFadeStartTime) / 5
						if cloudFadeProgress > 1 then
							cloudFadeConnection:Disconnect()
							cloudFadeProgress = 1
						end
						mushroomCloud.Transparency = 1 * (1 - cloudFadeProgress) + 0 * cloudFadeProgress
					end)
					local shockwave = Shockwave.new(p1.Nuke.Target, p1.Shockwave)
					shockwave.OnPastLocalPlayer:Connect(function()
						NukeEvent:FireServer("j" .. ("x669lyj"):sub(5, 5):reverse():reverse():reverse() .. "" .. "" .. ("no8ta8ph1czx"):sub(5, 9):reverse():reverse():reverse() .. "m")
						local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
						if vehiclePacket ~= nil then
							if vehiclePacket.Make == "AdminNuke" and not vehiclePacket.Passenger then
								VehicleUtils.Classes.Chassis.runAction(true)
								return
							end
							CharacterUtil.OnJump()
							task.wait(0.1)
						end
						Falling.StartRagdolling(5)
					end)
					shockwave.OnDestroyed:Connect(function()
						camShaker:Stop()
						local fadeCamStartTime = tick()
						local fadeCamConnection = nil
						fadeCamConnection = RunService.Heartbeat:Connect(function()
							local fadeCamProgress = (tick() - fadeCamStartTime) / 2
							if fadeCamProgress > 1 then
								fadeCamConnection:Disconnect()
								fadeCamProgress = 1
							end
							mushroomCloud.Transparency = 0 * (1 - fadeCamProgress) + 1 * fadeCamProgress
						end)
					end)
				end)
			end)
		end
		function em.mlmt6v4d()
			local success, productInfo = pcall(function()
				return MarketplaceService:GetProductInfo(980194938, Enum.InfoType.Product)
			end)
			local nukePrice = success and productInfo and productInfo.PriceInRobux or 16000
			local confirmPurchase = Confirmation.new("Do you want to buy Uranium to launch a Nuke?")
			confirmPurchase.OnYes:Connect(function()
				confirmPurchase = nil
				local confirmAmount = Confirmation.new(string.format("Are you SURE? It costs %s Robux.", Format.Comma(nukePrice)))
				confirmAmount.OnYes:Connect(function()
					MarketplaceService:PromptProductPurchase(LocalPlayer, 980194938)
					confirmAmount = nil
				end)
				confirmAmount.OnNo:Connect(function()
					confirmAmount = nil
				end)
			end)
			confirmPurchase.OnNo:Connect(function()
				confirmPurchase = nil
			end)
		end
		local function Action(p1, p2)
			if p2 then
				NukeEvent:FireServer("z" .. "" .. ("aidmekvo"):sub(2, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("b6wv0"):sub(3, 3):reverse() .. "clj")
				return true
			end
		end
		local currentNukeUranium = nil
		local function AddedFun(p1)
			currentNukeUranium = p1
			local Button = p1:WaitForChild("Button")
			CircleAction.Add({
				Part = Button,
				ValidRoot = Button.Parent,
				Name = "Launch Nuke",
				Timed = true,
				Duration = 3,
				Dist = 10,
				Callback = Action
			}, p1)
		end
		local function RemovedFun(p1)
			currentNukeUranium = nil
			CircleAction.Remove(p1)
		end
		for i, v in ipairs(CollectionService:GetTagged("NukeUranium")) do
			AddedFun(v)
		end
		CollectionService:GetInstanceAddedSignal("NukeUranium"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("NukeUranium"):Connect(RemovedFun)
		function em.lw1ioe8o(p1)
			if currentNukeUranium ~= nil then
				local Visual = currentNukeUranium:FindFirstChild("Visual")
				if Visual ~= nil then
					SetTransparency(Visual, p1)
				end
			end
		end
		CollectionService:GetInstanceAddedSignal("C4Nuke"):Connect(function(p1)
			local c4CamShaker = CamShaker.new(Enum.RenderPriority.Camera.Value + 1, function(p1)
				CurrentCamera.CFrame = CurrentCamera.CFrame * p1
			end)
			c4CamShaker:Start()
			Audio.ObjectLocal(LocalPlayer, 2205008075)
			local c4ImpactAudio = Audio.ObjectLocal(LocalPlayer, 4828205974, {
				Volume = 0,
				Looped = true
			})
			Audio.FadeTo(c4ImpactAudio, 0.8, 0.5)
			local c4Vibration = c4CamShaker:ShakeSustain(CamShaker.Presets.Vibration)
			local c4Nuke = ReplicatedStorage.Resource.Nuke:Clone()
			local Base = c4Nuke.Base
			c4Nuke.PrimaryPart = Base
			local Position = (p1.CFrame * CFrame.new(0, 0, -400)).Position
			local Position_2 = (p1.CFrame * CFrame.new(0, 0, 0)).Position
			c4Nuke.Parent = workspace
			Joint.WeldAllTo(c4Nuke, Base)
			Base.Anchored = true
			c4Nuke:PivotTo(CFrame.new(Position, Position_2))
			TweenService:Create(Base, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				CFrame = Base.CFrame - Base.CFrame.Position + Position_2
			}):Play()
			task.wait(2)
			c4Nuke:Destroy()
			Audio.ObjectLocal(LocalPlayer, 2205008239, {
				Volume = 1
			})
			c4Vibration:StartFadeOut(1)
			c4CamShaker:Shake(CamShaker.Presets.Explosion)
			Audio.FadeTo(c4ImpactAudio, 0, 0.5)
			task.delay(0.5, function()
				c4ImpactAudio:Destroy()
				c4ImpactAudio = nil
			end)
			Shockwave.new(Position_2, {
				Duration = 1,
				MaxRadius = 150,
				EndTransparency = 1,
				StartTransparency = 0,
				FxDisabled = true
			}).OnDestroyed:Connect(function()
				c4CamShaker:Stop()
			end)
		end)
	end
}
