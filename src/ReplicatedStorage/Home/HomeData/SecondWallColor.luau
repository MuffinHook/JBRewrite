local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WallColor = require(script.Parent.WallColor)
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local SecondWallColorModule = {}
local DefaultPaintProperties = {
	DefaultReflectance = 0,
	DefaultMaterial = Enum.Material.SmoothPlastic,
	DisableReflectance = true
}
SecondWallColorModule.getInstance = WallColor.getInstance
SecondWallColorModule.updateCamera = WallColor.updateCamera
SecondWallColorModule.getItems = WallColor.getItems
function SecondWallColorModule.apply(colorOption, targetModel)
	local SecondWallColor = targetModel:FindFirstChild("SecondWallColor")
	if SecondWallColor then
		local count = 0
		for _, childPart in SecondWallColor:GetChildren() do
			if childPart:IsA("BasePart") then
				count = count + 1
				if colorOption and not colorOption.None then
					DefaultPaintProperties.DefaultMaterial = childPart.Material
					Paint.Part(childPart, colorOption.Name, DefaultPaintProperties)
				else
					childPart.Color = childPart:GetAttribute("OriginalColor")
				end
			end
		end
		assert(count > 0, "No parts to apply to")
	else
		warn("Missing subModel")
	end
end
return SecondWallColorModule
