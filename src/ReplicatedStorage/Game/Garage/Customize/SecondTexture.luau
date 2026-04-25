-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpecialTextureData = require(ReplicatedStorage.Game.Garage.SpecialTextureData)
local TextureData = require(ReplicatedStorage.Game.Garage.TextureData)
return function(p1, p2)
	local Make = p2.Make
	local Model = p2.Model
	local list = {}
	for v1, part in Model:GetDescendants() do
		if part:IsA("BasePart") and (part.Name == "SecondBody" and (Make ~= "Expeditioner" or not part:IsDescendantOf(Model.Preset.Doors.Back))) then
			table.insert(list, part)
		end
	end
	if p1 and not p1.None then
		local textureName = p1.Name
		local textureId = nil
		if TextureData[textureName] == nil then
			if SpecialTextureData[textureName] then
				textureId = SpecialTextureData[textureName]
			end
		else
			textureId = TextureData[textureName][Make]
		end
		if textureId == nil then
			for i, v in ipairs(list) do
				if v:IsA("MeshPart") then
					v.TextureID = ""
				end
			end
		else
			for i, v in ipairs(list) do
				if v:IsA("MeshPart") then
					v.TextureID = ("rbxassetid://%d"):format(textureId)
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
