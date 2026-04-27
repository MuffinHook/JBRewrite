local FloorMaterialModule = {
	getInstance = function(materialConfig)
		local Part = Instance.new("Part")
		Part.Shape = Enum.PartType.Ball
		Part.Size = Vector3.new(4, 4, 4)
		Part.TopSurface = 0
		Part.BottomSurface = 0
		Part.Color = Color3.new(255/255, 255/255, 255/255)
		if materialConfig.Material then
			Part.Material = materialConfig.Material
		else
			Part.Material = Enum.Material.SmoothPlastic
		end
		if materialConfig.MaterialVariant then
			Part.MaterialVariant = materialConfig.MaterialVariant
		else
			Part.MaterialVariant = ""
		end
		Part.Anchored = true
		Part.CFrame = CFrame.new()
		return Part
	end,
	updateCamera = function(camera, p2)
		local progress = os.clock() / 2
		camera.CFrame = CFrame.Angles(0, progress % 6.283185307179586, 0) * CFrame.Angles(math.sin(progress) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, 8)
	end
}
local floorMaterials = {
	{
		Name = "Smooth",
		None = true,
		Price = 0
	},
	{
		Name = "Stone",
		Material = Enum.Material.Cobblestone,
		Price = 25000
	},
	{
		Name = "Raw Planks",
		Material = Enum.Material.WoodPlanks,
		Price = 25000
	},
	{
		Name = "Oak Planks",
		Material = Enum.Material.WoodPlanks,
		MaterialVariant = "Interior_OakPlank",
		Price = 50000
	},
	{
		Name = "Modern Carpet",
		Material = Enum.Material.Fabric,
		MaterialVariant = "Interior_ModernCarpet",
		Price = 50000
	},
	{
		Name = "Heavy Tile",
		Material = Enum.Material.SmoothPlastic,
		MaterialVariant = "Interior_IndustrialTile",
		Price = 50000
	},
	{
		Name = "Concrete",
		Material = Enum.Material.Concrete,
		Price = 30000
	}
}
function FloorMaterialModule.getItems()
	return floorMaterials
end
function FloorMaterialModule.apply(materialConfig, model)
	local FlooringMaterial = model:FindFirstChild("FlooringMaterial")
	if FlooringMaterial then
		local count = 0
		for index, part in FlooringMaterial:GetChildren() do
			local materialValue
			if part:IsA("BasePart") then
				count = count + 1
				materialValue = materialConfig and materialConfig.Material
				if materialValue then
					part.Material = materialValue
				else
					part.Material = part:GetAttribute("OriginalMaterial") or Enum.Material.SmoothPlastic
				end
				if materialConfig and materialConfig.MaterialVariant then
					assert(materialValue, "MaterialVariant requires Material")
					part.MaterialVariant = materialConfig.MaterialVariant
				else
					part.MaterialVariant = part:GetAttribute("OriginalMaterialVariant") or ""
				end
			end
		end
		assert(count > 0, "No parts to apply to")
	else
		warn("Missing subModel")
	end
end
return FloorMaterialModule
