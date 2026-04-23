-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Joint = require(ReplicatedStorage.Std.Joint)
local TireSticker = require(ReplicatedStorage.Game.Garage.Customize.TireSticker)
local Rim = require(ReplicatedStorage.Game.Garage.Customize.Rim)
local StoreData = require(ReplicatedStorage.Game.Garage.StoreData)
local t = {
	Trailblazer = true,
	BlackWidow = true,
	Semi = true
}
return function(p1, p2, p3)
	local Model = p2.Model
	if not p1 then
		p1 = {
			Name = "Classic"
		}
	end
	local v1 = ReplicatedStorage.Resource.TireMesh:FindFirstChild(p1.Name)
	if not v1 then
		error("Could not find tire mesh: " .. p1.Name)
	end
	local function updateWheelModel(p12)
		local TireMesh = p12:FindFirstChild("TireMesh")
		if TireMesh then
			TireMesh:Destroy()
		end
		local PrimaryPart = p12.PrimaryPart
		if not PrimaryPart then
			print(p12:GetFullName())
			print(p12:GetChildren())
			error("Vehicle wheel model is missing `Wheel` part as PrimaryPart")
		end
		local v12 = PrimaryPart
		local v2
		repeat
			v12 = v12.Parent
			v2 = v12:FindFirstChild("Engine")
		until v2 ~= nil
		local v3 = nil
		if v3 == nil then
			v3 = v2.CFrame:PointToObjectSpace(PrimaryPart.Position).X < -1
		end
		local TireMesh_2 = v1:Clone()
		TireMesh_2.Size = p12.PrimaryPart.Size
		TireMesh_2.Name = "TireMesh"
		TireMesh_2.Anchored = false
		TireMesh_2.CanCollide = false
		TireMesh_2.CanQuery = false
		TireMesh_2.CanTouch = false
		TireMesh_2.Massless = true
		TireMesh_2.Parent = p12
		local InnerWheelScale = p12:FindFirstChild("InnerWheelScale")
		if not InnerWheelScale then
			local InnerWheelScale_2 = Instance.new("Vector3Value")
			InnerWheelScale_2.Name = "InnerWheelScale"
			InnerWheelScale_2.Parent = p12
			InnerWheelScale = InnerWheelScale_2
		end
		local InnerWheelScale_2 = p1.InnerWheelScale
		if not InnerWheelScale_2 then
			InnerWheelScale_2 = Vector3.new(1, p1.InnerWheelPct or 0.7, p1.InnerWheelPct or 0.7)
		end
		InnerWheelScale.Value = InnerWheelScale_2
		local v6 = CFrame.Angles(0, 0, 0)
		if not v3 then
			v6 = CFrame.Angles(0, math.pi, 0)
		end
		if Model:FindFirstChild("BoundingBox").Anchored then
			TireMesh_2.Anchored = true
			TireMesh_2.CFrame = PrimaryPart.CFrame * v6
		else
			local v8 = Joint.BlankWeld(TireMesh_2, PrimaryPart)
			v8.C1 = v6
			v8.Parent = TireMesh_2
		end
		if t[p2.Make] and p12.Name:find("Back") then
			for i = 1, 2 do
				local v10
				local v11 = Instance.fromExisting(TireMesh_2)
				v11.Name = "Dual" .. i
				v11.Size = v11.Size * Vector3.new(0.5, 1, 1)
				v10 = if i == 1 then -1 else 1
				v11.CFrame = TireMesh_2.CFrame * CFrame.new(v11.Size.X * v10 / 2, 0, 0)
				v11.Parent = TireMesh_2
				Joint.Weld(v11, TireMesh_2)
			end
			TireMesh_2.Transparency = 1
		end
	end
	if Model:FindFirstChild("WheelModels") then
		for v2, v3 in Model.WheelModels:GetChildren() do
			if v3:IsA("Model") then
				updateWheelModel(v3)
			end
		end
	else
		for v4, v5 in Model:GetDescendants() do
			if v5:IsA("Model") and (v5.Name:sub(1, 5) == "Wheel" and (v5.Name ~= "Wheels" and v5.Name ~= "WheelModels")) then
				updateWheelModel(v5)
			end
		end
	end
	if p3 then
		if p3.TireSticker then
			TireSticker(StoreData.GetItemByName("TireSticker", p3.TireSticker), p2)
		end
		if p3.Rim then
			Rim(StoreData.GetItemByName("Rim", p3.Rim), p2, p3)
		end
	end
end