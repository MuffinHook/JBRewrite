local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemSkinIds = require(ReplicatedStorage.Game.ItemSkin.ItemSkinIds)
return {
	getUpdateCamera = function()
		local lastModel = nil
		local boundingBoxSize = nil
		return function(camera, targetModel)
			if targetModel then
				if targetModel ~= lastModel then
					local _v12, boxSize = targetModel:GetBoundingBox()
					boundingBoxSize = boxSize
					lastModel = targetModel
				end
				local currentTime = os.clock()
				camera.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, currentTime % 6.283185307179586, 0) * CFrame.Angles(math.sin(currentTime * 0.5) * 0.3 - 0.4, 0, 0) * CFrame.new(0, 0, boundingBoxSize.Magnitude * 0.8)
			end
		end
	end,
	getModel = function(skinName, itemName)
		local resolvedItemName = itemName or "RocketLauncher"
		assert(resolvedItemName)
		local model = ReplicatedStorage.Resource.ItemSystem.Models:FindFirstChild(resolvedItemName):Clone()
		local boundingBox = model:GetBoundingBox()
		model.PrimaryPart = model:FindFirstChild("Skeleton"):FindFirstChild("BoundingBox")
		model:SetPrimaryPartCFrame(model.PrimaryPart.CFrame:ToObjectSpace(boundingBox):Inverse())
		local finalModel, skinImageId
		if skinName == "None" then
			finalModel = model
			skinImageId = nil
		else
			local skinData = ItemSkinIds[skinName]
			if not skinData then
				error(("No skin by name of %s exists."):format(skinName))
			end
			skinImageId = skinData[resolvedItemName]
			if not skinImageId then
				error(("Skin %s has no image id for item: %s"):format(skinName, resolvedItemName))
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
