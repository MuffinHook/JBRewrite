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
					_ = boundingMin
					lastSize = boundingMax
					lastPart = part
					local UpDot = part:FindFirstChild("UpDot")
					if UpDot and UpDot.Value ~= 1 then
						rotationCFrame = if UpDot.Value == 0 then CFrame.Angles(1.5707963267948966, 0, 1.5707963267948966) else CFrame.Angles(0, 0, math.pi)
					end
				end
				local currentTime = os.clock()
				camera.CFrame = CFrame.new(0, 0, 0) * rotationCFrame * CFrame.Angles(0, currentTime % 6.283185307179586, 0) * CFrame.Angles(math.sin(currentTime * 0.5) * 0.3 - 0.4, 0, 0) * CFrame.new(0, 0, lastSize.Magnitude * 0.8)
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
