local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Joint = require(ReplicatedStorage.Std.Joint)
local TireSticker = require(ReplicatedStorage.Game.Garage.Customize.TireSticker)
local Rim = require(ReplicatedStorage.Game.Garage.Customize.Rim)
local StoreData = require(ReplicatedStorage.Game.Garage.StoreData)
local specialVehicles = {
	Trailblazer = true,
	BlackWidow = true,
	Semi = true
}
return function(tireConfig, vehicleData, customizationOptions)
	local Model = vehicleData.Model
	if not tireConfig then
		tireConfig = {
			Name = "Classic"
		}
	end
	local tireTemplate = ReplicatedStorage.Resource.TireMesh:FindFirstChild(tireConfig.Name)
	if not tireTemplate then
		error("Could not find tire mesh: " .. tireConfig.Name)
	end
	local function updateWheelModel(wheelModel)
		local TireMesh = wheelModel:FindFirstChild("TireMesh")
		if TireMesh then
			TireMesh:Destroy()
		end
		local PrimaryPart = wheelModel.PrimaryPart
		if not PrimaryPart then
			print(wheelModel:GetFullName())
			print(wheelModel:GetChildren())
			error("Vehicle wheel model is missing `Wheel` part as PrimaryPart")
		end
		local currentPart = PrimaryPart
		local enginePart
		repeat
			currentPart = currentPart.Parent
			enginePart = currentPart:FindFirstChild("Engine")
		until enginePart ~= nil
		local isLeftSide = nil
		if isLeftSide == nil then
			isLeftSide = enginePart.CFrame:PointToObjectSpace(PrimaryPart.Position).X < -1
		end
		local TireMesh_2 = tireTemplate:Clone()
		TireMesh_2.Size = wheelModel.PrimaryPart.Size
		TireMesh_2.Name = "TireMesh"
		TireMesh_2.Anchored = false
		TireMesh_2.CanCollide = false
		TireMesh_2.CanQuery = false
		TireMesh_2.CanTouch = false
		TireMesh_2.Massless = true
		TireMesh_2.Parent = wheelModel
		local InnerWheelScale = wheelModel:FindFirstChild("InnerWheelScale")
		if not InnerWheelScale then
			local InnerWheelScale_2 = Instance.new("Vector3Value")
			InnerWheelScale_2.Name = "InnerWheelScale"
			InnerWheelScale_2.Parent = wheelModel
			InnerWheelScale = InnerWheelScale_2
		end
		local InnerWheelScale_2 = tireConfig.InnerWheelScale
		if not InnerWheelScale_2 then
			InnerWheelScale_2 = Vector3.new(1, tireConfig.InnerWheelPct or 0.7, tireConfig.InnerWheelPct or 0.7)
		end
		InnerWheelScale.Value = InnerWheelScale_2
		local rotationCFrame = CFrame.Angles(0, 0, 0)
		if not isLeftSide then
			rotationCFrame = CFrame.Angles(0, math.pi, 0)
		end
		if Model:FindFirstChild("BoundingBox").Anchored then
			TireMesh_2.Anchored = true
			TireMesh_2.CFrame = PrimaryPart.CFrame * rotationCFrame
		else
			local weldJoint = Joint.BlankWeld(TireMesh_2, PrimaryPart)
			weldJoint.C1 = rotationCFrame
			weldJoint.Parent = TireMesh_2
		end
		if specialVehicles[vehicleData.Make] and wheelModel.Name:find("Back") then
			for i = 1, 2 do
				local offsetDirection
				local dualTireMesh = Instance.fromExisting(TireMesh_2)
				dualTireMesh.Name = "Dual" .. i
				dualTireMesh.Size = dualTireMesh.Size * Vector3.new(0.5, 1, 1)
				offsetDirection = if i == 1 then -1 else 1
				dualTireMesh.CFrame = TireMesh_2.CFrame * CFrame.new(dualTireMesh.Size.X * offsetDirection / 2, 0, 0)
				dualTireMesh.Parent = TireMesh_2
				Joint.Weld(dualTireMesh, TireMesh_2)
			end
			TireMesh_2.Transparency = 1
		end
	end
	if Model:FindFirstChild("WheelModels") then
		for _, wheelChild in Model.WheelModels:GetChildren() do
			if wheelChild:IsA("Model") then
				updateWheelModel(wheelChild)
			end
		end
	else
		for _, descendant in Model:GetDescendants() do
			if descendant:IsA("Model") and (descendant.Name:sub(1, 5) == "Wheel" and (descendant.Name ~= "Wheels" and descendant.Name ~= "WheelModels")) then
				updateWheelModel(descendant)
			end
		end
	end
	if customizationOptions then
		if customizationOptions.TireSticker then
			TireSticker(StoreData.GetItemByName("TireSticker", customizationOptions.TireSticker), vehicleData)
		end
		if customizationOptions.Rim then
			Rim(StoreData.GetItemByName("Rim", customizationOptions.Rim), vehicleData, customizationOptions)
		end
	end
end
