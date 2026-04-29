local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	getUpdateCamera = function()
		local lastPart = nil
		local lastSize = nil
		local rotationCFrame = CFrame.Angles(0, 0, 0)
		return function(camera, part)
			if part then
				if part ~= lastPart then
					local boundingMin, boundingMax = part:GetBoundingBox()
					local _ = boundingMin
					lastSize = boundingMax
					lastPart = part
					local UpDot = part:FindFirstChild("UpDot")
					if UpDot and UpDot.Value ~= 1 then
						rotationCFrame = if UpDot.Value == 0 then CFrame.Angles(math.pi / 2, 0, math.pi / 2) else CFrame.Angles(0, 0, math.pi)
					end
				end
				local currentTime = os.clock()
				camera.CFrame = CFrame.new(0, 0, 0) * rotationCFrame * CFrame.Angles(0, currentTime % math.tau, 0) * CFrame.Angles(math.sin(currentTime * 0.5) * 0.3 - 0.4, 0, 0) * CFrame.new(0, 0, lastSize.Magnitude * 0.8)
			end
		end
	end,
	getModel = function(itemName)
		local sourceModel = ReplicatedStorage.Resource.HomeItem:FindFirstChild(itemName)
		if not sourceModel then
			error("No HomeItem exists by name: " .. itemName)
		end
		local clonedModel = sourceModel:Clone()
		local modelCopy = clonedModel
		for _, descendant in clonedModel:GetDescendants() do
			if descendant:IsA("LuaSourceContainer") then
				descendant:Destroy()
			end
		end
		modelCopy:SetPrimaryPartCFrame(modelCopy.PrimaryPart.CFrame:ToObjectSpace((modelCopy:GetBoundingBox())):Inverse())
		return modelCopy
	end
}
