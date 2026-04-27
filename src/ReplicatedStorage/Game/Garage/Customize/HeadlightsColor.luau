local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local PaintUtils = require(ReplicatedStorage.Game.Garage.PaintUtils)
local configDefaults = {
	DefaultReflectance = 0,
	DisableMaterial = true
}
return function(colorPart, vehicleData)
	local Make = vehicleData.Make
	local Model = vehicleData.Model
	local colorName = if colorPart == nil then "White" else colorPart.Name
	local colorValue = Paint.GetColor(colorName)
	local list = {}
	for i, descendant in ipairs(Model:GetDescendants()) do
		if descendant.Name == "Headlights" then
			table.insert(list, descendant)
		end
	end
	if Make == "Tank" then
		local Top = Model:FindFirstChild("Top")
		table.insert(list, Top:FindFirstChild("Screens"))
	end
	for i, part in ipairs(list) do
		configDefaults.DefaultReflectance = PaintUtils.GetDefaultVehiclePart(part).Reflectance
		Paint.Part(part, colorName, configDefaults)
	end
	local Model_2 = Model:FindFirstChild("Model")
	if Model_2 then
		local Body = Model_2:FindFirstChild("Body")
		for i, childPart in ipairs(Body:GetChildren()) do
			if childPart.Name == "Headlight" then
				local lightPart = childPart:FindFirstChildWhichIsA("Light")
				if lightPart then
					lightPart.Color = colorValue
				end
			end
		end
		if Make == "WYNDR" then
			Model_2:FindFirstChild("Barrier").Color = colorValue
		end
	end
end
