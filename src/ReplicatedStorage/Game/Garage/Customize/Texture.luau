-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpecialTextureData = require(ReplicatedStorage.Game.Garage.SpecialTextureData)
local TextureData = require(ReplicatedStorage.Game.Garage.TextureData)
local GarageConsts = require(ReplicatedStorage.Garage.GarageConsts)
local SecondTexture = require(script.Parent.SecondTexture)
local SecondTexture_2 = require(script.Parent.Parent.Category.SecondTexture)
return function(p1, p2, p3)
	local Type = p2.Type
	local Make = p2.Make
	local Model = p2.Model
	if Make == "MCL36FREE" then
		Make = "MCL36"
	end
	local list = {}
	for i, v in ipairs(Model:GetDescendants()) do
		if v.Name == "Body" then
			table.insert(list, v)
		end
	end
	local Model_2 = Model:FindFirstChild("Model")
	local v1 = if Model_2 then Model_2:FindFirstChild("Body") else nil
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
		for i, v in ipairs(Model:FindFirstChild("Wheels"):GetDescendants()) do
			if v.Name == "Arm2" then
				table.insert(list, v)
			end
		end
		for i, v in ipairs(Model:FindFirstChild("Physics"):GetDescendants()) do
			if v.Name == "RearGearDoor" then
				table.insert(list, v:FindFirstChild("Primary", true))
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
	if p1 and not p1.None then
		local v2 = if Make == "TinyToy" then "Camaro" else Make
		local v3 = p1.Name
		local v4 = nil
		if TextureData[v3] == nil then
			if SpecialTextureData[v3] then
				v4 = SpecialTextureData[v3]
			end
		else
			v4 = TextureData[v3][v2]
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
	if p1 and v1 then
		local v5 = v1:FindFirstChild(GarageConsts.PIXEL_PARTICLE_EMITTER_NAME)
		if p1.Name == "Pixel" then
			if not v5 then
				ReplicatedStorage.Resource:FindFirstChild(GarageConsts.PIXEL_PARTICLE_EMITTER_NAME):Clone().Parent = v1
			end
		elseif v5 then
			v5:Destroy()
		end
	end
	if Make == "MCL36" and (p1 and p1.Name) == "MCL36" then
		Model_2:FindFirstChild("FrontWing").TextureID = "rbxassetid://8794555138"
		Model_2:FindFirstChild("Wing").TextureID = "rbxassetid://8794550685"
	elseif Make == "MCL36" then
		Model_2:FindFirstChild("FrontWing").TextureID = ""
		Model_2:FindFirstChild("Wing").TextureID = ""
	end
	if Make == "SWATVan" then
		local v7 = p1 and p1.Name
		for v9, v10 in Model_2.Body:GetChildren() do
			local v8
			if v10:IsA("Decal") then
				v8 = if v7 == "SWATGraffiti" then 1 else 0
				v10.Transparency = v8
			end
		end
	end
	if p3 and (not p3.SecondTexture and SecondTexture_2(p2)) then
		SecondTexture(p1, p2, p3)
	end
end