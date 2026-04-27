local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WallColor = require(script.Parent.WallColor)
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local windowColorModule = {}
local materialConfig = {
	DefaultReflectance = 0,
	DefaultMaterial = Enum.Material.SmoothPlastic,
	DisableReflectance = true
}
windowColorModule.getInstance = WallColor.getInstance
windowColorModule.updateCamera = WallColor.updateCamera
windowColorModule.getItems = WallColor.getItems
function windowColorModule.apply(colorData, targetModel)
	local Windows = targetModel:FindFirstChild("Windows")
	if Windows then
		local count = 0
		for _, windowPart in Windows:GetChildren() do
			if windowPart:IsA("BasePart") then
				count = count + 1
				if colorData and not colorData.None then
					materialConfig.DefaultMaterial = windowPart.Material
					Paint.Part(windowPart, colorData.Name, materialConfig)
				else
					windowPart.Color = windowPart:GetAttribute("OriginalColor")
				end
			end
		end
		assert(count > 0, "No parts to apply to")
	else
		warn("Missing subModel")
	end
end
return windowColorModule
