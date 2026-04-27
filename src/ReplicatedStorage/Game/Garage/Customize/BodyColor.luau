local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local PaintUtils = require(ReplicatedStorage.Game.Garage.PaintUtils)
local HyperChromeConsts = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local HyperChromeUtils = require(ReplicatedStorage.HyperChrome.HyperChromeUtils)
local function getPaintConfig(vehiclePart)
	local defaultPart = PaintUtils.GetDefaultVehiclePart(vehiclePart)
	return {
		DefaultReflectance = defaultPart.Reflectance,
		DefaultMaterial = defaultPart.Material
	}
end
return function(colorName, vehicleData)
	local Model = vehicleData.Model
	local Type = vehicleData.Type
	local Make = vehicleData.Make
	if colorName then
		local colorNameValue = colorName.Name
		local paintColor = Paint.GetColor(colorNameValue)
		if paintColor == nil then
			error("No color value exists for: " .. colorNameValue)
		end
		if Type == "Chassis" or (Type == "Chassis3" or (Type == "Heli" or (Type == "Custom" or (Type == "Motorcycle" or Type == "DuneBuggy")))) then
			local partsToColor = {}
			local reflectanceOverride = nil
			if Make == "Volt" then
				table.insert(partsToColor, Model.Model.Lines)
			elseif Make == "UFO" then
				table.insert(partsToColor, Model.Model.Detail)
				table.insert(partsToColor, Model.Model.Body)
			elseif Make == "Volt4x4" then
				table.insert(partsToColor, Model.Model.Lines)
			elseif Type == "Motorcycle" then
				table.insert(partsToColor, Model.Model.Body)
				if Make == "Dirtbike" then
					table.insert(partsToColor, Model.Model.FrontGuard)
					table.insert(partsToColor, Model.WheelModels.FrontHold)
					table.insert(partsToColor, Model.WheelModels.BackHold)
				elseif Make == "Patrol" then
					table.insert(partsToColor, Model.Model.Bags)
					table.insert(partsToColor, Model.WheelModels.FrontHold)
				end
				reflectanceOverride = 0
				if colorNameValue == "Chrome" then
					reflectanceOverride = 1
				elseif colorNameValue == "FallChrome" then
					reflectanceOverride = 0.4
				end
			elseif Type == "DuneBuggy" then
				table.insert(partsToColor, Model.Model.BodySide)
				table.insert(partsToColor, Model.WheelModels.FrontRightBar)
				table.insert(partsToColor, Model.WheelModels.FrontLeftBar)
				table.insert(partsToColor, Model.WheelModels.BackRightBar)
				table.insert(partsToColor, Model.WheelModels.BackLeftBar)
				table.insert(partsToColor, Model.Model.Body)
				reflectanceOverride = if colorNameValue == "Chrome" then 1 elseif colorNameValue == "FallChrome" then 0.4 else 0
			elseif Make == "Sloop" then
				table.insert(partsToColor, Model.Visual.Body)
				table.insert(partsToColor, Model.Visual.FrontDecoration)
				table.insert(partsToColor, Model.Visual.Roof)
				table.insert(partsToColor, Model.Visual.Mast)
				table.insert(partsToColor, Model.Visual.MastFront)
				table.insert(partsToColor, Model.Visual.MastFrontB)
				table.insert(partsToColor, Model.Physics.SailBack.Top)
				table.insert(partsToColor, Model.Physics.SailBack.Bottom)
			elseif Make == "Wedge" then
				for _, descendant in ipairs(Model:GetDescendants()) do
					if descendant.Name == "Body" then
						table.insert(partsToColor, descendant)
					end
				end
				table.insert(partsToColor, Model.Model.BodyBottom)
				table.insert(partsToColor, Model.Model.BodyWing)
			else
				for _, descendant in ipairs(Model:GetDescendants()) do
					if descendant.Name == "Body" then
						table.insert(partsToColor, descendant)
					end
				end
			end
			if Make == "Jet" then
				local Physics = Model:FindFirstChild("Physics")
				table.insert(partsToColor, Physics:FindFirstChild("Left"))
				local Physics_2 = Model:FindFirstChild("Physics")
				table.insert(partsToColor, Physics_2:FindFirstChild("Right"))
				local Physics_3 = Model:FindFirstChild("Physics")
				table.insert(partsToColor, Physics_3:FindFirstChild("Tail"))
			elseif Make == "Stunt" then
				local Physics = Model:FindFirstChild("Physics")
				table.insert(partsToColor, Physics:FindFirstChild("TailLeft"))
				local Physics_2 = Model:FindFirstChild("Physics")
				table.insert(partsToColor, Physics_2:FindFirstChild("TailRight"))
				local Physics_3 = Model:FindFirstChild("Physics")
				table.insert(partsToColor, Physics_3:FindFirstChild("Tail"))
				local Physics_4 = Model:FindFirstChild("Physics")
				table.insert(partsToColor, Physics_4:FindFirstChild("WingLeft"))
				local Physics_5 = Model:FindFirstChild("Physics")
				table.insert(partsToColor, Physics_5:FindFirstChild("WingRight"))
				for _, descendant in ipairs(Model:FindFirstChild("Wheels"):GetDescendants()) do
					if descendant.Name == "Arm2" then
						table.insert(partsToColor, descendant)
					end
				end
				for _, descendant in ipairs(Model:FindFirstChild("Physics"):GetDescendants()) do
					if descendant.Name == "RearGearDoor" then
						table.insert(partsToColor, descendant:FindFirstChild("Primary", true))
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
						table.insert(partsToColor, Frame)
					elseif Body then
						table.insert(partsToColor, Body)
					end
				end
				local DoorRight = Preset:FindFirstChild("DoorRight")
				if DoorRight then
					local Frame = DoorRight:FindFirstChild("Frame")
					local Body = DoorRight:FindFirstChild("Body")
					if Frame then
						table.insert(partsToColor, Frame)
					elseif Body then
						table.insert(partsToColor, Body)
					end
				end
			end
			if Model:FindFirstChild("Turret") and Model:FindFirstChild("Turret"):FindFirstChild("Back") then
				local Turret = Model:FindFirstChild("Turret")
				table.insert(partsToColor, Turret:FindFirstChild("Back"))
			end
			for index, part in partsToColor do
				local defaultPart = PaintUtils.GetDefaultVehiclePart(part)
				local paintConfig = {}
				if defaultPart then
					paintConfig.DefaultReflectance = defaultPart.Reflectance
					paintConfig.DefaultMaterial = defaultPart.Material
				else
					paintConfig.DefaultReflectance = 0.1
					paintConfig.DefaultMaterial = Enum.Material.Plastic
				end
				if reflectanceOverride then
					paintConfig.DefaultReflectance = reflectanceOverride
				end
				Paint.Part(part, colorNameValue, paintConfig)
				if not CollectionService:HasTag(part, "VehicleColorPart") then
					CollectionService:AddTag(part, "VehicleColorPart")
				end
				if HyperChromeUtils.isHyperChromeName(colorNameValue) then
					part:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, colorNameValue)
					Model:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, colorNameValue)
				else
					part:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, nil)
					Model:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, nil)
				end
			end
			if Make == "Volt" or Make == "Volt4x4" then
				for _, childPart in ipairs(Model.Model:GetChildren()) do
					if childPart.Name == "Trail" then
						local Trail = childPart:FindFirstChildOfClass("Trail")
						if Trail then
							Trail.Color = ColorSequence.new(paintColor)
						end
					end
				end
			elseif Make == "UFO" then
				Model.Model.Beam.Color = paintColor
				Model.Model.Lights.Color = paintColor
			elseif Make == "Ambulance" then
				local DoorRight = Model:FindFirstChild("DoorRight", true)
				if DoorRight then
					DoorRight.Color = paintColor
				end
				local DoorLeft = Model:FindFirstChild("DoorLeft", true)
				if DoorLeft then
					DoorLeft.Color = paintColor
				end
			elseif Make == "Torpedo" then
				Model.Model.Spoiler.Color = paintColor
			elseif Make == "Jeep" then
				Model.Model.Top.Color = paintColor
			elseif Make == "CrewCapsule" then
				local doorPaintConfig = PaintUtils.GetDefaultVehiclePart(Model.Preset.Door)
				Paint.Part(Model.Preset.Door, colorNameValue, {
					DefaultReflectance = doorPaintConfig.Reflectance,
					DefaultMaterial = doorPaintConfig.Material
				})
			elseif Make == "TowTruck" then
				Model.Model.BodyBumpers.Color = paintColor
			end
		end
		if Type == "Heli" and (Make == "Heli" or Make == "BlackHawk") then
			local brightenedColor = Color3.new(math.clamp(paintColor.r + 0.25390625, 0, 1), math.clamp(paintColor.g + 0.25390625, 0, 1), (math.clamp(paintColor.b + 0.25390625, 0, 1)))
			local nextFunction = next
			local bodyChildren, nilValue = Model.Model.Body:GetChildren()
			for decalIndex, decal in nextFunction, bodyChildren, nilValue do
				if decal:IsA("Decal") then
					decal.Color3 = brightenedColor
				end
			end
		elseif Make == "Raptor" then
			Model.Model.Detail.Color = Color3.new(math.clamp(paintColor.r + -0.25390625, 0, 1), math.clamp(paintColor.g + -0.25390625, 0, 1), (math.clamp(paintColor.b + -0.25390625, 0, 1)))
		elseif Type == "DuneBuggy" then
			Model.Model.Body.Color = Color3.new(math.clamp(paintColor.r * 1.4, 0, 1), math.clamp(paintColor.g * 1.4, 0, 1), (math.clamp(paintColor.b * 1.4, 0, 1)))
		end
	end
end
