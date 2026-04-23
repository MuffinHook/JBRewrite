local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WallColor = require(script.Parent.WallColor)
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local t = {}
local t2 = {
	DefaultReflectance = 0,
	DefaultMaterial = Enum.Material.SmoothPlastic,
	DisableReflectance = true
}
t.getInstance = WallColor.getInstance
t.updateCamera = WallColor.updateCamera
t.getItems = WallColor.getItems
function t.apply(p1, p2) --[[ Line: 15 | Upvalues: t2 (copy), Paint (copy) ]]
	local SecondWallColor = p2:FindFirstChild("SecondWallColor")
	if SecondWallColor then
		local count = 0
		for v1, v2 in SecondWallColor:GetChildren() do
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