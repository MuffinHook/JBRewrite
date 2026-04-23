local t = {
	getInstance = function(p1) --[[ Name: getInstance | Line: 3 ]]
		local Part = Instance.new("Part")
		Part.Shape = Enum.PartType.Ball
		Part.Size = Vector3.new(4, 4, 4)
		Part.TopSurface = 0
		Part.BottomSurface = 0
		Part.Color = Color3.new(255/255, 255/255, 255/255)
		if p1.Material then
			Part.Material = p1.Material
		else
			Part.Material = Enum.Material.SmoothPlastic
		end
		if p1.MaterialVariant then
			Part.MaterialVariant = p1.MaterialVariant
		else
			Part.MaterialVariant = ""
		end
		Part.Anchored = true
		Part.CFrame = CFrame.new()
		return Part
	end,
	updateCamera = function(p1, p2) --[[ Name: updateCamera | Line: 24 ]]
		local v1 = os.clock() / 2
		p1.CFrame = CFrame.Angles(0, v1 % 6.283185307179586, 0) * CFrame.Angles(math.sin(v1) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, 8)
	end
}
local t2 = {
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
function t.getItems() --[[ Line: 70 | Upvalues: t2 (copy) ]]
	return t2
end
function t.apply(p1, p2) --[[ Line: 73 ]]
	local FlooringMaterial = p2:FindFirstChild("FlooringMaterial")
	if FlooringMaterial then
		local count = 0
		for v2, v3 in FlooringMaterial:GetChildren() do
			local v1
			if v3:IsA("BasePart") then
				count = count + 1
				v1 = p1 and p1.Material
				if v1 then
					v3.Material = v1
				else
					v3.Material = v3:GetAttribute("OriginalMaterial") or Enum.Material.SmoothPlastic
				end
				if p1 and p1.MaterialVariant then
					assert(v1, "MaterialVariant requires Material")
					v3.MaterialVariant = p1.MaterialVariant
				else
					v3.MaterialVariant = v3:GetAttribute("OriginalMaterialVariant") or ""
				end
			end
		end
		assert(count > 0, "No parts to apply to")
	else
		warn("Missing subModel")
	end
end
return t