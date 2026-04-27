local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local Color = require(ReplicatedStorage.Game.Garage.StoreData.Color)
local WallColorModule = {}
local PaintConfig = {
	DefaultReflectance = 0,
	DefaultMaterial = Enum.Material.SmoothPlastic,
	DisableReflectance = true
}
function WallColorModule.getInstance(colorItem)
	local Part = Instance.new("Part")
	Part.Shape = Enum.PartType.Ball
	Part.Size = Vector3.new(4, 4, 4)
	Part.TopSurface = 0
	Part.BottomSurface = 0
	if colorItem.None then
		Part.Color = Color3.new(255/255, 255/255, 255/255)
	else
		Part.Color = Paint.GetColor(colorItem.Name)
	end
	Part.Anchored = true
	Part.CFrame = CFrame.new()
	return Part
end
function WallColorModule.updateCamera(camera, parent)
	local elapsedTime = os.clock() / 2
	camera.CFrame = CFrame.Angles(0, elapsedTime % math.tau, 0) * CFrame.Angles(math.sin(elapsedTime) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, 8)
end
local colorItems = table.clone(Color.Items)
table.insert(colorItems, 1, {
	Name = "Default",
	None = true
})
function WallColorModule.getItems()
	return colorItems
end
function WallColorModule.apply(colorItem, parentModel)
	local WallColor = parentModel:FindFirstChild("WallColor")
	if WallColor then
		local count = 0
		for _, part in WallColor:GetChildren() do
			if part:IsA("BasePart") then
				count = count + 1
				if colorItem and not colorItem.None then
					PaintConfig.DefaultMaterial = part.Material
					Paint.Part(part, colorItem.Name, PaintConfig)
				else
					part.Color = part:GetAttribute("OriginalColor")
				end
			end
		end
		assert(count > 0, "No parts to apply to")
	else
		warn("Missing subModel")
	end
end
return WallColorModule
