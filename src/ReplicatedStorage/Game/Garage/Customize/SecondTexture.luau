-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpecialTextureData = require(ReplicatedStorage.Game.Garage.SpecialTextureData)
local TextureData = require(ReplicatedStorage.Game.Garage.TextureData)
return function(p1, p2)
	local Make = p2.Make
	local Model = p2.Model
	local list = {}
	for v1, v2 in Model:GetDescendants() do
		if v2:IsA("BasePart") and (v2.Name == "SecondBody" and (Make ~= "Expeditioner" or not v2:IsDescendantOf(Model.Preset.Doors.Back))) then
			table.insert(list, v2)
		end
	end
	if p1 and not p1.None then
		local v3 = p1.Name
		local v4 = nil
		if TextureData[v3] == nil then
			if SpecialTextureData[v3] then
				v4 = SpecialTextureData[v3]
			end
		else
			v4 = TextureData[v3][Make]
		end
		if v4 == nil then
			for i, v in ipairs(list) do
				if v:IsA("MeshPart") then
					v.TextureID = ""
				end
			end
		else
			for i, v in ipairs(list) do
				if v:IsA("MeshPart") then
					v.TextureID = ("rbxassetid://%d"):format(v4)
				end
			end
		end
	else
		for i, v in ipairs(list) do
			if v:IsA("MeshPart") then
				v.TextureID = ""
			end
		end
	end
end