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
		local v1 = ManifestBinder.new("Vehicle", {
			body = "Model/Body"
		}, function(p1, p2)
			local v1 = Maid.new()
			local function clearMaxLevelAura()
				v1.maxLevelAuraAttachment = nil
			end
			local function clearNumberParticleEmitter()
				v1.numberParticleEmitter = nil
			end
			local function clearHyperShiftAuraParticle()
				v1.hyperShiftAuraParticle = nil
				v1.hyperShiftParticleRainbowHeartbeat = nil
			end
			v1:GiveTask(p1:GetAttributeChangedSignal(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME):Connect(function()
				v1.maxLevelAuraAttachment = nil
				v1.numberParticleEmitter = nil
				v1.hyperShiftAuraParticle = nil
				v1.hyperShiftParticleRainbowHeartbeat = nil
				local v12 = p1:GetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME)
				if v12 then
					if v12 == HyperChromeConsts.COLOR_SHIFT_NAME then
						local Attachment = Instance.new("Attachment")
						Attachment.Parent = p2.body
						local v2 = ReplicatedStorage.Resource:FindFirstChild(HyperChromeConsts.HYPERSHIFT_PARTICLE_RESOURCE_NAME):Clone()
						v2.Parent = Attachment
						v1.hyperShiftAuraParticle = Attachment
						v1.hyperShiftParticleRainbowHeartbeat = RunService.Heartbeat:Connect(function()
							local v22 = ColorSequence.new(Color3.fromHSV(os.clock() % HyperChromeConsts.RAINBOW_ANIMATION_CYCLE_TIME / HyperChromeConsts.RAINBOW_ANIMATION_CYCLE_TIME, 1, 0.65))
							v2.Color = v22
							for v3, v4 in p1.Model:GetChildren() do
								if v4.Name == "Trail" then
									local Trail = v4:FindFirstChildOfClass("Trail")
									if Trail then
										Trail.Color = v22
									end
								elseif p1.Name == "UFO" and (v4.Name == "Lights" or (v4.Name == "Beam" or v4.Name == "Windows")) then
									v4.Color = v22.Keypoints[1].Value
								end
							end
						end)
						return
					end
					local v3 = HyperChromeUtils.getLevelFromName(v12)
					local v4 = HyperChromeConsts.COLOR_TO_INFO_MAP[HyperChromeUtils.getColorFromName(v12)].LevelToColor[v3]
					if v3 == HyperChromeConsts.MAX_LEVEL then
						local v5 = ReplicatedStorage.Resource:FindFirstChild(HyperChromeConsts.MAX_LEVEL_HYPERCHROME_PARTICLE_RESOURCE_NAME)
						assert(v5, "No max level hyperchrome emitter resource")
						local v6 = v5:Clone()
						local Attachment = Instance.new("Attachment")
						v6.Color = ColorSequence.new(v4)
						v6.Parent = Attachment
						Attachment.Parent = p2.body
						v1.maxLevelAuraAttachment = Attachment
					else
						local v7 = ReplicatedStorage.Resource:FindFirstChild(HyperChromeConsts.HYPERCHROME_NUMBER_PARTICLE_RESOURCE_NAME)
						assert(v7, "No number hyperchrome emitter resource")
						local v8 = v7:Clone()
						v8.Texture = HyperChromeConsts.LEVEL_TO_INFO_MAP[v3].NumberImageId
						v8.Color = ColorSequence.new(v4)
						v8.Parent = p2.body
						v1.numberParticleEmitter = v8
					end
				end
			end))
			v1:GiveTask(p1.Destroying:Connect(function()
				task.defer(v1.Destroy, v1)
			end))
			return v1
		end)
		local v2 = Binder.new("VehicleColorPart", function(p1)
			local v1 = Maid.new()
			local function updateHyperChrome()
				local v12 = p1:GetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME)
				if v12 == nil then
					v1.angleShifter = nil
					for v2, v3 in Enum.NormalId:GetEnumItems() do
						local v4 = p1:FindFirstChild("HyperChrome" .. v3.Name)
						if v4 then
							v4:Destroy()
						end
					end
				else
					p1.Color = Color3.new(0/255, 0/255, 0/255)
					local v5 = HyperChromeUtils.getColorFromName(v12)
					local v6 = HyperChromeUtils.getLevelFromName(v12)
					local v7 = HyperChromeConsts.COLOR_TO_INFO_MAP[v5]
					local t = {}
					for v8, v9 in Enum.NormalId:GetEnumItems() do
						if v9 ~= Enum.NormalId.Bottom then
							local v10 = "HyperChrome" .. v9.Name
							local v11 = p1:FindFirstChild(v10)
							if not v11 then
								local Texture = Instance.new("Texture")
								Texture.Name = v10
								Texture.StudsPerTileU = 55
								Texture.StudsPerTileV = 105
								Texture.Face = v9
								Texture.Texture = "rbxassetid://11372133369"
								Texture.Parent = p1
								v11 = Texture
							end
							if v7 then
								v11.Color3 = v7.LevelToColor[v6]
							end
							t[v9] = v11
						end
					end
					local isCOLOR_SHIFT_NAME = v12 == HyperChromeConsts.COLOR_SHIFT_NAME
					v1.angleShifter = RunService.Heartbeat:Connect(function()
						local v1 = CurrentCamera.CFrame
						local LookVector = v1.LookVector
						local Position = p1.Position
						if not ((v1.Position - Position).Magnitude > 256) then
							local v2 = math.rad(CurrentCamera.FieldOfView) * 0.95
							local v3 = LookVector:Angle((Position - v1.Position).Unit)
							if not (v2 < v3) then
								local v4 = LookVector:Angle(Vector3.new(1, 1, 1)) + v3
								local v5 = Position.X % 8096 / 8096 + Position.Y % 8096 / 8096 + Position.Z % 8096 / 8096
								local v6 = (v4 + v5 * 55) * 10
								local v7 = (v4 + v5 * 105) * 10
								for v8, v9 in t do
									v9.OffsetStudsU = v6
									v9.OffsetStudsV = v7
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
			v1:GiveTask(p1:GetAttributeChangedSignal(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME):Connect(updateHyperChrome))
			return v1
		end)
		v1:Start()
		v2:Start()
	end
}
