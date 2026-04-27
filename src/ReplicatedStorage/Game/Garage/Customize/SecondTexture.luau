local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpecialTextureData = require(ReplicatedStorage.Game.Garage.SpecialTextureData)
local TextureData = require(ReplicatedStorage.Game.Garage.TextureData)
return function(selectedTexture, carData)
	local Make = carData.Make
	local Model = carData.Model
	local list = {}
	for index, part in Model:GetDescendants() do
		if part:IsA("BasePart") and (part.Name == "SecondBody" and (Make ~= "Expeditioner" or not part:IsDescendantOf(Model.Preset.Doors.Back))) then
			table.insert(list, part)
		end
	end
	if selectedTexture and not selectedTexture.None then
		local textureName = selectedTexture.Name
		local textureId = nil
		if TextureData[textureName] == nil then
			if SpecialTextureData[textureName] then
				textureId = SpecialTextureData[textureName]
			end
		else
			textureId = TextureData[textureName][Make]
		end
		if textureId == nil then
			for i, part in ipairs(list) do
				if part:IsA("MeshPart") then
					part.TextureID = ""
				end
			end
		else
			for i, part in ipairs(list) do
				if part:IsA("MeshPart") then
					part.TextureID = ("rbxassetid://%d"):format(textureId)
				end
			end
		end
	else
		for i, part in ipairs(list) do
			if part:IsA("MeshPart") then
				part.TextureID = ""
			end
		end
	end
end
