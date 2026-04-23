local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local PaintUtils = require(ReplicatedStorage.Game.Garage.PaintUtils)
local HyperChromeConsts = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local HyperChromeUtils = require(ReplicatedStorage.HyperChrome.HyperChromeUtils)
local function getPaintConfig(p1) --[[ Line: 8 | Upvalues: PaintUtils (copy) ]]
	local v1 = PaintUtils.GetDefaultVehiclePart(p1)
	return {
		DefaultReflectance = v1.Reflectance,
		DefaultMaterial = v1.Material
	}
end
return function(p1, p2) --[[ Line: 16 | Upvalues: Paint (copy), PaintUtils (copy), CollectionService (copy), HyperChromeUtils (copy), HyperChromeConsts (copy) ]]
	local Model = p2.Model
	local Type = p2.Type
	local Make = p2.Make
	if p1 then
		local v1 = p1.Name
		local v2 = Paint.GetColor(v1)
		if v2 == nil then
			error("No color value exists for: " .. v1)
		end
		if Type == "Chassis" or (Type == "Chassis3" or (Type == "Heli" or (Type == "Custom" or (Type == "Motorcycle" or Type == "DuneBuggy")))) then
			local t = {}
			local v3 = nil
			if Make == "Volt" then
				table.insert(t, Model.Model.Lines)
			elseif Make == "UFO" then
				table.insert(t, Model.Model.Detail)
				table.insert(t, Model.Model.Body)
			elseif Make == "Volt4x4" then
				table.insert(t, Model.Model.Lines)
			elseif Type == "Motorcycle" then
				table.insert(t, Model.Model.Body)
				if Make == "Dirtbike" then
					table.insert(t, Model.Model.FrontGuard)
					table.insert(t, Model.WheelModels.FrontHold)
					table.insert(t, Model.WheelModels.BackHold)
				elseif Make == "Patrol" then
					table.insert(t, Model.Model.Bags)
					table.insert(t, Model.WheelModels.FrontHold)
				end
				v3 = 0
				if v1 == "Chrome" then
					v3 = 1
				elseif v1 == "FallChrome" then
					v3 = 0.4
				end
			elseif Type == "DuneBuggy" then
				table.insert(t, Model.Model.BodySide)
				table.insert(t, Model.WheelModels.FrontRightBar)
				table.insert(t, Model.WheelModels.FrontLeftBar)
				table.insert(t, Model.WheelModels.BackRightBar)
				table.insert(t, Model.WheelModels.BackLeftBar)
				table.insert(t, Model.Model.Body)
				v3 = if v1 == "Chrome" then 1 elseif v1 == "FallChrome" then 0.4 else 0
			elseif Make == "Sloop" then
				table.insert(t, Model.Visual.Body)
				table.insert(t, Model.Visual.FrontDecoration)
				table.insert(t, Model.Visual.Roof)
				table.insert(t, Model.Visual.Mast)
				table.insert(t, Model.Visual.MastFront)
				table.insert(t, Model.Visual.MastFrontB)
				table.insert(t, Model.Physics.SailBack.Top)
				table.insert(t, Model.Physics.SailBack.Bottom)
			elseif Make == "Wedge" then
				for i, v in ipairs(Model:GetDescendants()) do
					if v.Name == "Body" then
						table.insert(t, v)
					end
				end
				table.insert(t, Model.Model.BodyBottom)
				table.insert(t, Model.Model.BodyWing)
			else
				for i, v in ipairs(Model:GetDescendants()) do
					if v.Name == "Body" then
						table.insert(t, v)
					end
				end
			end
			if Make == "Jet" then
				local Physics = Model:FindFirstChild("Physics")
				table.insert(t, Physics:FindFirstChild("Left"))
				local Physics_2 = Model:FindFirstChild("Physics")
				table.insert(t, Physics_2:FindFirstChild("Right"))
				local Physics_3 = Model:FindFirstChild("Physics")
				table.insert(t, Physics_3:FindFirstChild("Tail"))
			elseif Make == "Stunt" then
				local Physics = Model:FindFirstChild("Physics")
				table.insert(t, Physics:FindFirstChild("TailLeft"))
				local Physics_2 = Model:FindFirstChild("Physics")
				table.insert(t, Physics_2:FindFirstChild("TailRight"))
				local Physics_3 = Model:FindFirstChild("Physics")
				table.insert(t, Physics_3:FindFirstChild("Tail"))
				local Physics_4 = Model:FindFirstChild("Physics")
				table.insert(t, Physics_4:FindFirstChild("WingLeft"))
				local Physics_5 = Model:FindFirstChild("Physics")
				table.insert(t, Physics_5:FindFirstChild("WingRight"))
				for i, v in ipairs(Model:FindFirstChild("Wheels"):GetDescendants()) do
					if v.Name == "Arm2" then
						table.insert(t, v)
					end
				end
				for i, v in ipairs(Model:FindFirstChild("Physics"):GetDescendants()) do
					if v.Name == "RearGearDoor" then
						table.insert(t, v:FindFirstChild("Primary", true))
					end
				end
			end
			local Preset = Model:FindFirstChild("Preset")
			if Preset then
				local DoorLeft = Preset:FindFirstChild("DoorLeft")
				if DoorLeft then
					local Frame = DoorLeft:FindFirstChild("Frame")
					local Body = DoorLeft:FindFirstChild("Body")
					if Frame then
						table.insert(t, Frame)
					elseif Body then
						table.insert(t, Body)
					end
				end
				local DoorRight = Preset:FindFirstChild("DoorRight")
				if DoorRight then
					local Frame = DoorRight:FindFirstChild("Frame")
					local Body = DoorRight:FindFirstChild("Body")
					if Frame then
						table.insert(t, Frame)
					elseif Body then
						table.insert(t, Body)
					end
				end
			end
			if Model:FindFirstChild("Turret") and Model:FindFirstChild("Turret"):FindFirstChild("Back") then
				local Turret = Model:FindFirstChild("Turret")
				table.insert(t, Turret:FindFirstChild("Back"))
			end
			for v4, v5 in t do
				local v6 = PaintUtils.GetDefaultVehiclePart(v5)
				local t2 = {}
				if v6 then
					t2.DefaultReflectance = v6.Reflectance
					t2.DefaultMaterial = v6.Material
				else
					t2.DefaultReflectance = 0.1
					t2.DefaultMaterial = Enum.Material.Plastic
				end
				if v3 then
					t2.DefaultReflectance = v3
				end
				Paint.Part(v5, v1, t2)
				if not CollectionService:HasTag(v5, "VehicleColorPart") then
					CollectionService:AddTag(v5, "VehicleColorPart")
				end
				if HyperChromeUtils.isHyperChromeName(v1) then
					v5:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, v1)
					Model:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, v1)
				else
					v5:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, nil)
					Model:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, nil)
				end
			end
			if Make == "Volt" or Make == "Volt4x4" then
				for i, v in ipairs(Model.Model:GetChildren()) do
					if v.Name == "Trail" then
						local Trail = v:FindFirstChildOfClass("Trail")
						if Trail then
							Trail.Color = ColorSequence.new(v2)
						end
					end
				end
			elseif Make == "UFO" then
				Model.Model.Beam.Color = v2
				Model.Model.Lights.Color = v2
			elseif Make == "Ambulance" then
				local DoorRight = Model:FindFirstChild("DoorRight", true)
				if DoorRight then
					DoorRight.Color = v2
				end
				local DoorLeft = Model:FindFirstChild("DoorLeft", true)
				if DoorLeft then
					DoorLeft.Color = v2
				end
			elseif Make == "Torpedo" then
				Model.Model.Spoiler.Color = v2
			elseif Make == "Jeep" then
				Model.Model.Top.Color = v2
			elseif Make == "CrewCapsule" then
				local v7 = PaintUtils.GetDefaultVehiclePart(Model.Preset.Door)
				Paint.Part(Model.Preset.Door, v1, {
					DefaultReflectance = v7.Reflectance,
					DefaultMaterial = v7.Material
				})
			elseif Make == "TowTruck" then
				Model.Model.BodyBumpers.Color = v2
			end
		end
		if Type == "Heli" and (Make == "Heli" or Make == "BlackHawk") then
			local v14 = Color3.new(math.clamp(v2.r + 0.25390625, 0, 1), math.clamp(v2.g + 0.25390625, 0, 1), (math.clamp(v2.b + 0.25390625, 0, 1)))
			local v15 = next
			local v16, v17 = Model.Model.Body:GetChildren()
			for v18, v19 in v15, v16, v17 do
				if v19:IsA("Decal") then
					v19.Color3 = v14
				end
			end
		elseif Make == "Raptor" then
			Model.Model.Detail.Color = Color3.new(math.clamp(v2.r + -0.25390625, 0, 1), math.clamp(v2.g + -0.25390625, 0, 1), (math.clamp(v2.b + -0.25390625, 0, 1)))
		elseif Type == "DuneBuggy" then
			Model.Model.Body.Color = Color3.new(math.clamp(v2.r * 1.4, 0, 1), math.clamp(v2.g * 1.4, 0, 1), (math.clamp(v2.b * 1.4, 0, 1)))
		end
	end
end