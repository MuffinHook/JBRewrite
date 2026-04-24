-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
return {
	strikePosition = function(p1)
		local Origin = p1.Origin
		local Target = p1.Target
		local Model = Instance.new("Model")
		local v1 = p1.NumSegments or 20
		local v2 = p1.OffsetRadius or 16
		local v3 = p1.Transparency or 0.6
		local v4 = p1.PartWidth or 1
		local v5 = p1.Color or Color3.fromRGB(130, 148, 223)
		local v6 = Origin
		for i = 1, v1 do
			local v7 = i / v1
			local sum = Origin * (1 - v7) + Target * v7
			if i < v1 then
				local v8 = GeomUtils.randomPointInCircle() * v2
				sum = sum + Vector3.new(v8.X, 0, v8.Y)
			end
			local Magnitude = (sum - v6).Magnitude
			local Part = Instance.new("Part")
			Part.Anchored = true
			Part.CanCollide = false
			Part.CanTouch = false
			Part.CanQuery = false
			Part.Material = Enum.Material.Neon
			Part.Transparency = v3
			Part.Color = v5
			Part.TopSurface = 0
			Part.BottomSurface = 0
			Part.Size = Vector3.new(v4, v4, Magnitude)
			Part.CFrame = CFrame.new(v6, sum) * CFrame.new(0, 0, -Magnitude * 0.5)
			Part.Parent = Model
			v6 = sum
		end
		Model.Parent = workspace
		return Model
	end
}
