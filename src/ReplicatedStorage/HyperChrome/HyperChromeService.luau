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
		}, function(vehicle, vehicleConfig)
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
			instance:GiveTask(vehicle:GetAttributeChangedSignal(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME):Connect(function()
				instance.maxLevelAuraAttachment = nil
				instance.numberParticleEmitter = nil
				instance.hyperShiftAuraParticle = nil
				instance.hyperShiftParticleRainbowHeartbeat = nil
				local hyperChromeName = vehicle:GetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME)
				if hyperChromeName then
					if hyperChromeName == HyperChromeConsts.COLOR_SHIFT_NAME then
						local Attachment = Instance.new("Attachment")
						Attachment.Parent = vehicleConfig.body
						local instance2 = ReplicatedStorage.Resource:FindFirstChild(HyperChromeConsts.HYPERSHIFT_PARTICLE_RESOURCE_NAME):Clone()
						instance2.Parent = Attachment
						instance.hyperShiftAuraParticle = Attachment
						instance.hyperShiftParticleRainbowHeartbeat = RunService.Heartbeat:Connect(function()
							local rainbowColor = ColorSequence.new(Color3.fromHSV(os.clock() % HyperChromeConsts.RAINBOW_ANIMATION_CYCLE_TIME / HyperChromeConsts.RAINBOW_ANIMATION_CYCLE_TIME, 1, 0.65))
							instance2.Color = rainbowColor
							for childIndex, childInstance in vehicle.Model:GetChildren() do
								if childInstance.Name == "Trail" then
									local Trail = childInstance:FindFirstChildOfClass("Trail")
									if Trail then
										Trail.Color = rainbowColor
									end
								elseif vehicle.Name == "UFO" and (childInstance.Name == "Lights" or (childInstance.Name == "Beam" or childInstance.Name == "Windows")) then
									childInstance.Color = rainbowColor.Keypoints[1].Value
								end
							end
						end)
						return
					end
					local hyperChromeLevel = HyperChromeUtils.getLevelFromName(hyperChromeName)
					local levelColor = HyperChromeConsts.COLOR_TO_INFO_MAP[HyperChromeUtils.getColorFromName(hyperChromeName)].LevelToColor[hyperChromeLevel]
					if hyperChromeLevel == HyperChromeConsts.MAX_LEVEL then
						local particleResource = ReplicatedStorage.Resource:FindFirstChild(HyperChromeConsts.MAX_LEVEL_HYPERCHROME_PARTICLE_RESOURCE_NAME)
						assert(particleResource, "No max level hyperchrome emitter resource")
						local clonedEmitter = particleResource:Clone()
						local Attachment = Instance.new("Attachment")
						clonedEmitter.Color = ColorSequence.new(levelColor)
						clonedEmitter.Parent = Attachment
						Attachment.Parent = vehicleConfig.body
						instance.maxLevelAuraAttachment = Attachment
					else
						local particleResource = ReplicatedStorage.Resource:FindFirstChild(HyperChromeConsts.HYPERCHROME_NUMBER_PARTICLE_RESOURCE_NAME)
						assert(particleResource, "No number hyperchrome emitter resource")
						local clonedEmitter = particleResource:Clone()
						clonedEmitter.Texture = HyperChromeConsts.LEVEL_TO_INFO_MAP[hyperChromeLevel].NumberImageId
						clonedEmitter.Color = ColorSequence.new(levelColor)
						clonedEmitter.Parent = vehicleConfig.body
						instance.numberParticleEmitter = clonedEmitter
					end
				end
			end))
			instance:GiveTask(vehicle.Destroying:Connect(function()
				task.defer(instance.Destroy, instance)
			end))
			return instance
		end)
		local instance2 = Binder.new("VehicleColorPart", function(part)
			local instance = Maid.new()
			local function updateHyperChrome()
				local hyperChromeName = part:GetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME)
				if hyperChromeName == nil then
					instance.angleShifter = nil
					for normalId, enumValue in Enum.NormalId:GetEnumItems() do
						local hyerChromeTexture = part:FindFirstChild("HyperChrome" .. enumValue.Name)
						if hyerChromeTexture then
							hyerChromeTexture:Destroy()
						end
					end
				else
					part.Color = Color3.new(0/255, 0/255, 0/255)
					local hyperChromeColor = HyperChromeUtils.getColorFromName(hyperChromeName)
					local hyperChromeLevel = HyperChromeUtils.getLevelFromName(hyperChromeName)
					local colorInfo = HyperChromeConsts.COLOR_TO_INFO_MAP[hyperChromeColor]
					local texturesByFace = {}
					for normalId, enumValue in Enum.NormalId:GetEnumItems() do
						if enumValue ~= Enum.NormalId.Bottom then
							local textureName = "HyperChrome" .. enumValue.Name
							local textureInstance = part:FindFirstChild(textureName)
							if not textureInstance then
								local Texture = Instance.new("Texture")
								Texture.Name = textureName
								Texture.StudsPerTileU = 55
								Texture.StudsPerTileV = 105
								Texture.Face = enumValue
								Texture.Texture = "rbxassetid://11372133369"
								Texture.Parent = part
								textureInstance = Texture
							end
							if colorInfo then
								textureInstance.Color3 = colorInfo.LevelToColor[hyperChromeLevel]
							end
							texturesByFace[enumValue] = textureInstance
						end
					end
					local isColorShiftActive = hyperChromeName == HyperChromeConsts.COLOR_SHIFT_NAME
					instance.angleShifter = RunService.Heartbeat:Connect(function()
						local cameraFrame = CurrentCamera.CFrame
						local cameraLookVector = cameraFrame.LookVector
						local partPosition = part.Position
						if not ((cameraFrame.Position - partPosition).Magnitude > 256) then
							local cameraFieldOfViewAngle = math.rad(CurrentCamera.FieldOfView) * 0.95
							local cameraToPartAngle = cameraLookVector:Angle((partPosition - cameraFrame.Position).Unit)
							if not (cameraFieldOfViewAngle < cameraToPartAngle) then
								local offsetUCoefficient = cameraLookVector:Angle(Vector3.new(1, 1, 1)) + cameraToPartAngle
								local offsetVCoefficient = partPosition.X % 8096 / 8096 + partPosition.Y % 8096 / 8096 + partPosition.Z % 8096 / 8096
								local offsetU = (offsetUCoefficient + offsetVCoefficient * 55) * 10
								local offsetV = (offsetUCoefficient + offsetVCoefficient * 105) * 10
								for normalId, textureInstance in texturesByFace do
									textureInstance.OffsetStudsU = offsetU
									textureInstance.OffsetStudsV = offsetV
									if isColorShiftActive then
										textureInstance.Color3 = Color3.fromHSV(os.clock() % HyperChromeConsts.RAINBOW_ANIMATION_CYCLE_TIME / HyperChromeConsts.RAINBOW_ANIMATION_CYCLE_TIME, 0.94, 1.35)
									end
								end
								if part.Color.R ~= 0 or (part.Color.G ~= 0 or part.Color.B ~= 0) then
									part.Color = Color3.new(0/255, 0/255, 0/255)
								end
							end
						end
					end)
				end
			end
			updateHyperChrome()
			instance:GiveTask(part:GetAttributeChangedSignal(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME):Connect(updateHyperChrome))
			return instance
		end)
		instance:Start()
		instance2:Start()
	end
}
