-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemSkinIds = require(ReplicatedStorage.Game.ItemSkin.ItemSkinIds)
return {
	getUpdateCamera = function()
		local lastModel = nil
		local boundingBoxSize = nil
		return function(p1, p2)
			if p2 then
				if p2 ~= lastModel then
					local _v12, v22 = p2:GetBoundingBox()
					boundingBoxSize = v22
					lastModel = p2
				end
				local currentTime = os.clock()
				p1.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, currentTime % 6.283185307179586, 0) * CFrame.Angles(math.sin(currentTime * 0.5) * 0.3 - 0.4, 0, 0) * CFrame.new(0, 0, boundingBoxSize.Magnitude * 0.8)
			end
		end
	end,
	getModel = function(p1, p2)
		local itemName = p2 or "RocketLauncher"
		assert(itemName)
		local model = ReplicatedStorage.Resource.ItemSystem.Models:FindFirstChild(itemName):Clone()
		local boundingBox = model:GetBoundingBox()
		model.PrimaryPart = model:FindFirstChild("Skeleton"):FindFirstChild("BoundingBox")
		model:SetPrimaryPartCFrame(model.PrimaryPart.CFrame:ToObjectSpace(boundingBox):Inverse())
		local finalModel, skinImageId
		if p1 == "None" then
			finalModel = model
			skinImageId = nil
		else
			local skinData = ItemSkinIds[p1]
			if not skinData then
				error(("No skin by name of %s exists."):format(p1))
			end
			skinImageId = skinData[itemName]
			if not skinImageId then
				error(("Skin %s has no image id for item: %s"):format(p1, itemName))
			end
			finalModel = model
		end
		for _, descendantPart in finalModel:GetDescendants() do
			local textureIdValue
			if descendantPart:IsA("MeshPart") and descendantPart:GetAttribute("ApplyGunTexture") == true then
				textureIdValue = if skinImageId then ("rbxassetid://%d"):format(skinImageId) else ""
				descendantPart.TextureID = textureIdValue
			end
		end
		return finalModel
	end
}
