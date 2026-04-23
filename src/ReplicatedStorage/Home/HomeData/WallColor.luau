local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local Color = require(ReplicatedStorage.Game.Garage.StoreData.Color)
local t = {}
local t2 = {
	DefaultReflectance = 0,
	DefaultMaterial = Enum.Material.SmoothPlastic,
	DisableReflectance = true
}
function t.getInstance(p1) --[[ Line: 12 | Upvalues: Paint (copy) ]]
	local Part = Instance.new("Part")
	Part.Shape = Enum.PartType.Ball
	Part.Size = Vector3.new(4, 4, 4)
	Part.TopSurface = 0
	Part.BottomSurface = 0
	if p1.None then
		Part.Color = Color3.new(255/255, 255/255, 255/255)
	else
		Part.Color = Paint.GetColor(p1.Name)
	end
	Part.Anchored = true
	Part.CFrame = CFrame.new()
	return Part
end
function t.updateCamera(p1, p2) --[[ Line: 27 ]]
	local v1 = os.clock() / 2
	p1.CFrame = CFrame.Angles(0, v1 % 6.283185307179586, 0) * CFrame.Angles(math.sin(v1) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, 8)
end
local v1 = table.clone(Color.Items)
table.insert(v1, 1, {
	Name = "Default",
	None = true
})
function t.getItems() --[[ Line: 38 | Upvalues: v1 (copy) ]]
	return v1
end
function t.apply(p1, p2) --[[ Line: 41 | Upvalues: t2 (copy), Paint (copy) ]]
	local WallColor = p2:FindFirstChild("WallColor")
	if WallColor then
		local count = 0
		for v1, v2 in WallColor:GetChildren() do
			if v2:IsA("BasePart") then
				count = count + 1
				if p1 and not p1.None then
					t2.DefaultMaterial = v2.Material
					Paint.Part(v2, p1.Name, t2)
				else
					v2.Color = v2:GetAttribute("OriginalColor")
				end
			end
		end
		assert(count > 0, "No parts to apply to")
	else
		warn("Missing subModel")
	end
end
return t