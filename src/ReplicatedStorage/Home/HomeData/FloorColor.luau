local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WallColor = require(script.Parent.WallColor)
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local FloorColorModule = {}
local paintConfig = {
	DefaultReflectance = 0,
	DefaultMaterial = Enum.Material.SmoothPlastic,
	DisableReflectance = true
}
FloorColorModule.getInstance = WallColor.getInstance
FloorColorModule.updateCamera = WallColor.updateCamera
FloorColorModule.getItems = WallColor.getItems
function FloorColorModule.apply(colorData, model)
	local FlooringMaterial = model:FindFirstChild("FlooringMaterial")
	if FlooringMaterial then
		local count = 0
		for v1, flooringPart in FlooringMaterial:GetChildren() do
			if flooringPart:IsA("BasePart") then
				count = count + 1
				if colorData and not colorData.None then
					paintConfig.DefaultMaterial = flooringPart.Material
					Paint.Part(flooringPart, colorData.Name, paintConfig)
				else
					flooringPart.Color = flooringPart:GetAttribute("OriginalColor")
				end
			end
		end
		assert(count > 0, "No parts to apply to")
	else
		warn("Missing subModel")
	end
end
return FloorColorModule
