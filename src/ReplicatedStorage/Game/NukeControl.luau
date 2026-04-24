-- Reviewed by Claude
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
local v1 = nil
local function v2(p1, p2)
	for i, v in ipairs(p1:GetChildren()) do
		local v1
		if v:IsA("BasePart") then
			v1 = if p2 then 0 else 1
			v.Transparency = v1
		end
		v2(v, p2)
	end
end
return {
	Init = function(p1)
		v1 = p1.Event
		local em = p1.em
		function em.qx3dpfz6(p1)
			assert(p1 ~= nil)
			assert(p1.Nuke ~= nil)
			assert(p1.Shockwave ~= nil)
			local v2 = Audio.ObjectLocal(LocalPlayer, 9058580326, {
				Looped = true,
				Volume = 0,
				Pitch = 0.35
			})
			Audio.FadeTo(v2, 0.5, 5)
			local v3 = Silo.new(workspace:WaitForChild("Silo", 1))
			local v5 = v3.Model.Tube.Position + Vector3.new(0, v3.Model.Tube.Size.Y * 0.5, 0)
			local v7 = CamShaker.new(Enum.RenderPriority.Camera.Value + 1, function(p1)
				CurrentCamera.CFrame = CurrentCamera.CFrame * p1
			end)
			v7:Start()
			local v8 = Nuke.new()
			v3:Open()
			local v9 = tick()
			local v10 = nil
			v10 = RunService.Heartbeat:Connect(function()
				local v1 = (tick() - v9) / 5
				if v1 > 1 then
					v10:Disconnect()
					v1 = 1
				end
				v8.Model:SetPrimaryPartCFrame(CFrame.new(v5) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, 0, 48 * (1 - v1) + 12 * v1))
			end)
			v3.OnOpened:Connect(function()
				p1.Nuke.Origin = v8.Model.PrimaryPart.CFrame.p
				v8:Launch(p1.Nuke)
				Audio.ObjectLocal(LocalPlayer, 2205008075)
				local v12 = Audio.ObjectLocal(LocalPlayer, 4828205974, {
					Volume = 0,
					Looped = true
				})
				Audio.FadeTo(v12, 0.8, 0.5)
				local v22 = v7:ShakeSustain(CamShaker.Presets.Vibration)
				v8.OnImpact:Connect(function()
					Audio.FadeTo(v2, 0, 5)
					delay(5, function()
						v2:Destroy()
					end)
					Audio.ObjectLocal(LocalPlayer, 2205008239, {
						Volume = 1
					})
					v7:Shake(CamShaker.Presets.Explosion)
					v22:StartFadeOut(1)
					Audio.FadeTo(v12, 0, 0.5)
					delay(0.5, function()
						v12:Destroy()
						v12 = nil
					end)
					local v13 = ReplicatedStorage.Resource.MushroomCloud:Clone()
					v13.CFrame = CFrame.new(p1.Nuke.Target) + Vector3.new(0, 261.646, 0)
					v13.Transparency = 1
					v13.Parent = workspace
					local function FadeInCloud()
						local v1 = tick()
						local v2 = nil
						v2 = RunService.Heartbeat:Connect(function()
							local v12 = (tick() - v1) / 5
							if v12 > 1 then
								v2:Disconnect()
								v12 = 1
							end
							v13.Transparency = 1 * (1 - v12) + 0 * v12
						end)
					end
					local function FadeOutCloud()
						local v1 = tick()
						local v2 = nil
						v2 = RunService.Heartbeat:Connect(function()
							local v12 = (tick() - v1) / 2
							if v12 > 1 then
								v2:Disconnect()
								v12 = 1
							end
							v13.Transparency = 0 * (1 - v12) + 1 * v12
						end)
					end
					local v23 = tick()
					local v3 = nil
					v3 = RunService.Heartbeat:Connect(function()
						local v1 = (tick() - v23) / 5
						if v1 > 1 then
							v3:Disconnect()
							v1 = 1
						end
						v13.Transparency = 1 * (1 - v1) + 0 * v1
					end)
					local v4 = Shockwave.new(p1.Nuke.Target, p1.Shockwave)
					v4.OnPastLocalPlayer:Connect(function()
						v1:FireServer("j" .. ("x669lyj"):sub(5, 5):reverse():reverse():reverse() .. "" .. "" .. ("no8ta8ph1czx"):sub(5, 9):reverse():reverse():reverse() .. "m")
						local v12 = VehicleUtils.GetLocalVehiclePacket()
						if v12 ~= nil then
							if v12.Make == "AdminNuke" and not v12.Passenger then
								VehicleUtils.Classes.Chassis.runAction(true)
								return
							end
							CharacterUtil.OnJump()
							task.wait(0.1)
						end
						Falling.StartRagdolling(5)
					end)
					v4.OnDestroyed:Connect(function()
						v7:Stop()
						local v1 = tick()
						local v2 = nil
						v2 = RunService.Heartbeat:Connect(function()
							local v12 = (tick() - v1) / 2
							if v12 > 1 then
								v2:Disconnect()
								v12 = 1
							end
							v13.Transparency = 0 * (1 - v12) + 1 * v12
						end)
					end)
				end)
			end)
		end
		function em.mlmt6v4d()
			local v1, v2 = pcall(function()
				return MarketplaceService:GetProductInfo(980194938, Enum.InfoType.Product)
			end)
			local v3 = v1 and v2 and v2.PriceInRobux or 16000
			local v4 = Confirmation.new("Do you want to buy Uranium to launch a Nuke?")
			v4.OnYes:Connect(function()
				v4 = nil
				local v1 = Confirmation.new(string.format("Are you SURE? It costs %s Robux.", Format.Comma(v3)))
				v1.OnYes:Connect(function()
					MarketplaceService:PromptProductPurchase(LocalPlayer, 980194938)
					v1 = nil
				end)
				v1.OnNo:Connect(function()
					v1 = nil
				end)
			end)
			v4.OnNo:Connect(function()
				v4 = nil
			end)
		end
		local function Action(p1, p2)
			if p2 then
				v1:FireServer("z" .. "" .. ("aidmekvo"):sub(2, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("b6wv0"):sub(3, 3):reverse() .. "clj")
				return true
			end
		end
		local v12 = nil
		local function AddedFun(p1)
			v12 = p1
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
			v12 = nil
			CircleAction.Remove(p1)
		end
		for i, v in ipairs(CollectionService:GetTagged("NukeUranium")) do
			AddedFun(v)
		end
		CollectionService:GetInstanceAddedSignal("NukeUranium"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("NukeUranium"):Connect(RemovedFun)
		function em.lw1ioe8o(p1)
			if v12 ~= nil then
				local Visual = v12:FindFirstChild("Visual")
				if Visual ~= nil then
					v2(Visual, p1)
				end
			end
		end
		CollectionService:GetInstanceAddedSignal("C4Nuke"):Connect(function(p1)
			local v2 = CamShaker.new(Enum.RenderPriority.Camera.Value + 1, function(p1)
				CurrentCamera.CFrame = CurrentCamera.CFrame * p1
			end)
			v2:Start()
			Audio.ObjectLocal(LocalPlayer, 2205008075)
			local v3 = Audio.ObjectLocal(LocalPlayer, 4828205974, {
				Volume = 0,
				Looped = true
			})
			Audio.FadeTo(v3, 0.8, 0.5)
			local v4 = v2:ShakeSustain(CamShaker.Presets.Vibration)
			local v5 = ReplicatedStorage.Resource.Nuke:Clone()
			local Base = v5.Base
			v5.PrimaryPart = Base
			local Position = (p1.CFrame * CFrame.new(0, 0, -400)).Position
			local Position_2 = (p1.CFrame * CFrame.new(0, 0, 0)).Position
			v5.Parent = workspace
			Joint.WeldAllTo(v5, Base)
			Base.Anchored = true
			v5:PivotTo(CFrame.new(Position, Position_2))
			TweenService:Create(Base, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				CFrame = Base.CFrame - Base.CFrame.Position + Position_2
			}):Play()
			task.wait(2)
			v5:Destroy()
			Audio.ObjectLocal(LocalPlayer, 2205008239, {
				Volume = 1
			})
			v4:StartFadeOut(1)
			v2:Shake(CamShaker.Presets.Explosion)
			Audio.FadeTo(v3, 0, 0.5)
			task.delay(0.5, function()
				v3:Destroy()
				v3 = nil
			end)
			Shockwave.new(Position_2, {
				Duration = 1,
				MaxRadius = 150,
				EndTransparency = 1,
				StartTransparency = 0,
				FxDisabled = true
			}).OnDestroyed:Connect(function()
				v2:Stop()
			end)
		end)
	end
}
