local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpecialTextureData = require(ReplicatedStorage.Game.Garage.SpecialTextureData)
local TextureData = require(ReplicatedStorage.Game.Garage.TextureData)
local GarageConsts = require(ReplicatedStorage.Garage.GarageConsts)
local SecondTexture = require(script.Parent.SecondTexture)
local SecondTexture_2 = require(script.Parent.Parent.Category.SecondTexture)
return function(selectedTexture, carData, updateOptions)
	local Type = carData.Type
	local Make = carData.Make
	local Model = carData.Model
	if Make == "MCL36FREE" then
		Make = "MCL36"
	end
	local list = {}
	for i, descendant in ipairs(Model:GetDescendants()) do
		if descendant.Name == "Body" then
			table.insert(list, descendant)
		end
	end
	local Model_2 = Model:FindFirstChild("Model")
	local secondBodyPart = if Model_2 then Model_2:FindFirstChild("Body") else nil
	if Make == "Tank" then
		local Gun = Model:FindFirstChild("Top"):FindFirstChild("Gun")
		table.insert(list, Gun:FindFirstChild("Barrel"))
		local Top = Model:FindFirstChild("Top")
		table.insert(list, Top:FindFirstChild("Hatch"))
		local Top_2 = Model:FindFirstChild("Top")
		table.insert(list, Top_2:FindFirstChild("Turret"))
	elseif Make == "Jet" then
		local Physics = Model:FindFirstChild("Physics")
		table.insert(list, Physics:FindFirstChild("Left"))
		local Physics_2 = Model:FindFirstChild("Physics")
		table.insert(list, Physics_2:FindFirstChild("Right"))
		local Physics_3 = Model:FindFirstChild("Physics")
		table.insert(list, Physics_3:FindFirstChild("Tail"))
	elseif Make == "Stunt" then
		local Physics = Model:FindFirstChild("Physics")
		table.insert(list, Physics:FindFirstChild("TailLeft"))
		local Physics_2 = Model:FindFirstChild("Physics")
		table.insert(list, Physics_2:FindFirstChild("TailRight"))
		local Physics_3 = Model:FindFirstChild("Physics")
		table.insert(list, Physics_3:FindFirstChild("Tail"))
		local Physics_4 = Model:FindFirstChild("Physics")
		table.insert(list, Physics_4:FindFirstChild("WingLeft"))
		local Physics_5 = Model:FindFirstChild("Physics")
		table.insert(list, Physics_5:FindFirstChild("WingRight"))
		for i, descendant in ipairs(Model:FindFirstChild("Wheels"):GetDescendants()) do
			if descendant.Name == "Arm2" then
				table.insert(list, descendant)
			end
		end
		for i, descendant in ipairs(Model:FindFirstChild("Physics"):GetDescendants()) do
			if descendant.Name == "RearGearDoor" then
				table.insert(list, descendant:FindFirstChild("Primary", true))
			end
		end
	end
	if Make == "Wedge" then
		table.insert(list, Model.Model.BodyBottom)
		table.insert(list, Model.Model.BodyWing)
	end
	local Preset = Model:FindFirstChild("Preset")
	if Preset then
		local DoorLeft = Preset:FindFirstChild("DoorLeft")
		if DoorLeft then
			local Frame = DoorLeft:FindFirstChild("Frame")
			if Frame then
				table.insert(list, Frame)
			end
		end
		local DoorRight = Preset:FindFirstChild("DoorRight")
		if DoorRight then
			local Frame = DoorRight:FindFirstChild("Frame")
			if Frame then
				table.insert(list, Frame)
			end
		end
	end
	if selectedTexture and not selectedTexture.None then
		local textureCategory = if Make == "TinyToy" then "Camaro" else Make
		local textureName = selectedTexture.Name
		local textureId = nil
		if TextureData[textureName] == nil then
			if SpecialTextureData[textureName] then
				textureId = SpecialTextureData[textureName]
			end
		else
			textureId = TextureData[textureName][textureCategory]
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
	if selectedTexture and secondBodyPart then
		local pixelEmitter = secondBodyPart:FindFirstChild(GarageConsts.PIXEL_PARTICLE_EMITTER_NAME)
		if selectedTexture.Name == "Pixel" then
			if not pixelEmitter then
				ReplicatedStorage.Resource:FindFirstChild(GarageConsts.PIXEL_PARTICLE_EMITTER_NAME):Clone().Parent = secondBodyPart
			end
		elseif pixelEmitter then
			pixelEmitter:Destroy()
		end
	end
	if Make == "MCL36" and (selectedTexture and selectedTexture.Name) == "MCL36" then
		Model_2:FindFirstChild("FrontWing").TextureID = "rbxassetid://8794555138"
		Model_2:FindFirstChild("Wing").TextureID = "rbxassetid://8794550685"
	elseif Make == "MCL36" then
		Model_2:FindFirstChild("FrontWing").TextureID = ""
		Model_2:FindFirstChild("Wing").TextureID = ""
	end
	if Make == "SWATVan" then
		local graffitiName = selectedTexture and selectedTexture.Name
		for index, decalChild in Model_2.Body:GetChildren() do
			local transparency
			if decalChild:IsA("Decal") then
				transparency = if graffitiName == "SWATGraffiti" then 1 else 0
				decalChild.Transparency = transparency
			end
		end
	end
	if updateOptions and (not updateOptions.SecondTexture and SecondTexture_2(carData)) then
		SecondTexture(selectedTexture, carData, updateOptions)
	end
end
