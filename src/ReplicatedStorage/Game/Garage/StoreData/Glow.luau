local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Color = require(script.Parent.Color)
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local function GetInstance(p1) --[[ Line: 5 | Upvalues: Paint (copy) ]]
	local Part = Instance.new("Part")
	Part.Shape = Enum.PartType.Ball
	Part.Size = Vector3.new(4, 4, 4)
	Part.TopSurface = 0
	Part.BottomSurface = 0
	Part.Color = Paint.GetColor(p1.Name)
	Part.Anchored = true
	Part.CFrame = CFrame.new()
	return Part
end
local function Update(p1, p2) --[[ Line: 16 ]]
	local v1 = os.clock() / 2
	p1.CFrame = CFrame.Angles(0, v1 % 6.283185307179586, 0) * CFrame.Angles(math.sin(v1) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, 8)
end
return {
	Items = Color.Items,
	GetInstance = GetInstance,
	Update = Update
}