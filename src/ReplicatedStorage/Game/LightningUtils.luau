local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
return {
	strikePosition = function(config)
		local Origin = config.Origin
		local Target = config.Target
		local Model = Instance.new("Model")
		local numSegments = config.NumSegments or 20
		local offsetRadius = config.OffsetRadius or 16
		local transparency = config.Transparency or 0.6
		local partWidth = config.PartWidth or 1
		local color = config.Color or Color3.fromRGB(130, 148, 223)
		local currentPos = Origin
		for i = 1, numSegments do
			local t = i / numSegments
			local sum = Origin * (1 - t) + Target * t
			if i < numSegments then
				local randomOffset = GeomUtils.randomPointInCircle() * offsetRadius
				sum = sum + Vector3.new(randomOffset.X, 0, randomOffset.Y)
			end
			local Magnitude = (sum - currentPos).Magnitude
			local Part = Instance.new("Part")
			Part.Anchored = true
			Part.CanCollide = false
			Part.CanTouch = false
			Part.CanQuery = false
			Part.Material = Enum.Material.Neon
			Part.Transparency = transparency
			Part.Color = color
			Part.TopSurface = 0
			Part.BottomSurface = 0
			Part.Size = Vector3.new(partWidth, partWidth, Magnitude)
			Part.CFrame = CFrame.new(currentPos, sum) * CFrame.new(0, 0, -Magnitude * 0.5)
			Part.Parent = Model
			currentPos = sum
		end
		Model.Parent = workspace
		return Model
	end
}
