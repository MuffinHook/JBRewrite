-- Reviewed by Claude
local CurrentCamera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HyperChromeConsts = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local HyperChromeUtils = require(ReplicatedStorage.HyperChrome.HyperChromeUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local RunService = game:GetService("RunService")
local Binder = require(ReplicatedStorage.Std.Binder)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
return {
	init = function()
		local instance = ManifestBinder.new("Vehicle", {
			body = "Model/Body"
		}, function(p1, p2)
			local instance = Maid.new()
			local function clearMaxLevelAura()
				instance.maxLevelAuraAttachment = nil
			end
			local function clearNumberParticleEmitter()
				instance.numberParticleEmitter = nil
			end
			local function clearHyperShiftAuraParticle()
				instance.hyperShiftAuraParticle = nil
				instance.hyperShiftParticleRainbowHeartbeat = nil
			end
			instance:GiveTask(p1:GetAttributeChangedSignal(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME):Connect(function()
				instance.maxLevelAuraAttachment = nil
				instance.numberParticleEmitter = nil
				instance.hyperShiftAuraParticle = nil
				instance.hyperShiftParticleRainbowHeartbeat = nil
				local var12 = p1:GetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME)
				if var12 then
					if var12 == HyperChromeConsts.COLOR_SHIFT_NAME then
						local Attachment = Instance.new("Attachment")
						Attachment.Parent = p2.body
						local instance2 = ReplicatedStorage.Resource:FindFirstChild(HyperChromeConsts.HYPERSHIFT_PARTICLE_RESOURCE_NAME):Clone()
						instance2.Parent = Attachment
						instance.hyperShiftAuraParticle = Attachment
						instance.hyperShiftParticleRainbowHeartbeat = RunService.Heartbeat:Connect(function()
							local color22 = ColorSequence.new(Color3.fromHSV(os.clock() % HyperChromeConsts.RAINBOW_ANIMATION_CYCLE_TIME / HyperChromeConsts.RAINBOW_ANIMATION_CYCLE_TIME, 1, 0.65))
							instance2.Color = color22
							for var3, var4 in p1.Model:GetChildren() do
								if var4.Name == "Trail" then
									local Trail = var4:FindFirstChildOfClass("Trail")
									if Trail then
										Trail.Color = color22
									end
								elseif p1.Name == "UFO" and (var4.Name == "Lights" or (var4.Name == "Beam" or var4.Name == "Windows")) then
									var4.Color = color22.Keypoints[1].Value
								end
							end
						end)
						return
					end
					local var3 = HyperChromeUtils.getLevelFromName(var12)
					local var4 = HyperChromeConsts.COLOR_TO_INFO_MAP[HyperChromeUtils.getColorFromName(var12)].LevelToColor[var3]
					if var3 == HyperChromeConsts.MAX_LEVEL then
						local var5 = ReplicatedStorage.Resource:FindFirstChild(HyperChromeConsts.MAX_LEVEL_HYPERCHROME_PARTICLE_RESOURCE_NAME)
						assert(var5, "No max level hyperchrome emitter resource")
						local var6 = var5:Clone()
						local Attachment = Instance.new("Attachment")
						var6.Color = ColorSequence.new(var4)
						var6.Parent = Attachment
						Attachment.Parent = p2.body
						instance.maxLevelAuraAttachment = Attachment
					else
						local var7 = ReplicatedStorage.Resource:FindFirstChild(HyperChromeConsts.HYPERCHROME_NUMBER_PARTICLE_RESOURCE_NAME)
						assert(var7, "No number hyperchrome emitter resource")
						local var8 = var7:Clone()
						var8.Texture = HyperChromeConsts.LEVEL_TO_INFO_MAP[var3].NumberImageId
						var8.Color = ColorSequence.new(var4)
						var8.Parent = p2.body
						instance.numberParticleEmitter = var8
					end
				end
			end))
			instance:GiveTask(p1.Destroying:Connect(function()
				task.defer(instance.Destroy, instance)
			end))
			return instance
		end)
		local instance2 = Binder.new("VehicleColorPart", function(p1)
			local instance = Maid.new()
			local function updateHyperChrome()
				local var12 = p1:GetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME)
				if var12 == nil then
					instance.angleShifter = nil
					for instance2, var3 in Enum.NormalId:GetEnumItems() do
						local var4 = p1:FindFirstChild("HyperChrome" .. var3.Name)
						if var4 then
							var4:Destroy()
						end
					end
				else
					p1.Color = Color3.new(0/255, 0/255, 0/255)
					local var5 = HyperChromeUtils.getColorFromName(var12)
					local var6 = HyperChromeUtils.getLevelFromName(var12)
					local var7 = HyperChromeConsts.COLOR_TO_INFO_MAP[var5]
					local t = {}
					for var8, v9 in Enum.NormalId:GetEnumItems() do
						if v9 ~= Enum.NormalId.Bottom then
							local var10 = "HyperChrome" .. v9.Name
							local var11 = p1:FindFirstChild(var10)
							if not var11 then
								local Texture = Instance.new("Texture")
								Texture.Name = var10
								Texture.StudsPerTileU = 55
								Texture.StudsPerTileV = 105
								Texture.Face = v9
								Texture.Texture = "rbxassetid://11372133369"
								Texture.Parent = p1
								var11 = Texture
							end
							if var7 then
								var11.Color3 = var7.LevelToColor[var6]
							end
							t[v9] = var11
						end
					end
					local isCOLOR_SHIFT_NAME = var12 == HyperChromeConsts.COLOR_SHIFT_NAME
					instance.angleShifter = RunService.Heartbeat:Connect(function()
						local instance = CurrentCamera.CFrame
						local LookVector = instance.LookVector
						local Position = p1.Position
						if not ((instance.Position - Position).Magnitude > 256) then
							local instance2 = math.rad(CurrentCamera.FieldOfView) * 0.95
							local var3 = LookVector:Angle((Position - instance.Position).Unit)
							if not (instance2 < var3) then
								local var4 = LookVector:Angle(Vector3.new(1, 1, 1)) + var3
								local var5 = Position.X % 8096 / 8096 + Position.Y % 8096 / 8096 + Position.Z % 8096 / 8096
								local var6 = (var4 + var5 * 55) * 10
								local var7 = (var4 + var5 * 105) * 10
								for var8, v9 in t do
									v9.OffsetStudsU = var6
									v9.OffsetStudsV = var7
									if isCOLOR_SHIFT_NAME then
										v9.Color3 = Color3.fromHSV(os.clock() % HyperChromeConsts.RAINBOW_ANIMATION_CYCLE_TIME / HyperChromeConsts.RAINBOW_ANIMATION_CYCLE_TIME, 0.94, 1.35)
									end
								end
								if p1.Color.R ~= 0 or (p1.Color.G ~= 0 or p1.Color.B ~= 0) then
									p1.Color = Color3.new(0/255, 0/255, 0/255)
								end
							end
						end
					end)
				end
			end
			updateHyperChrome()
			instance:GiveTask(p1:GetAttributeChangedSignal(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME):Connect(updateHyperChrome))
			return instance
		end)
		instance:Start()
		instance2:Start()
	end
}
