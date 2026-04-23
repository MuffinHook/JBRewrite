local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local PaintUtils = require(ReplicatedStorage.Game.Garage.PaintUtils)
local t = {
	DefaultReflectance = 0,
	DisableMaterial = true
}
return function(p1, p2) --[[ Line: 9 | Upvalues: Paint (copy), PaintUtils (copy), t (copy) ]]
	local Make = p2.Make
	local Model = p2.Model
	local v1 = if p1 == nil then "White" else p1.Name
	local v2 = Paint.GetColor(v1)
	local list = {}
	for i, v in ipairs(Model:GetDescendants()) do
		if v.Name == "Headlights" then
			table.insert(list, v)
		end
	end
	if Make == "Tank" then
		local Top = Model:FindFirstChild("Top")
		table.insert(list, Top:FindFirstChild("Screens"))
	end
	for i, v in ipairs(list) do
		t.DefaultReflectance = PaintUtils.GetDefaultVehiclePart(v).Reflectance
		Paint.Part(v, v1, t)
	end
	local Model_2 = Model:FindFirstChild("Model")
	if Model_2 then
		local Body = Model_2:FindFirstChild("Body")
		for i, v in ipairs(Body:GetChildren()) do
			if v.Name == "Headlight" then
				local v3 = v:FindFirstChildWhichIsA("Light")
				if v3 then
					v3.Color = v2
				end
			end
		end
		if Make == "WYNDR" then
			Model_2:FindFirstChild("Barrier").Color = v2
		end
	end
end