local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemSkinIds = require(ReplicatedStorage.Game.ItemSkin.ItemSkinIds)
return {
	getUpdateCamera = function() --[[ Name: getUpdateCamera | Line: 6 ]]
		local v1 = nil
		local v2 = nil
		return function(p1, p2) --[[ Line: 9 | Upvalues: v1 (ref), v2 (ref) ]]
			if p2 then
				if p2 ~= v1 then
					local v12, v22 = p2:GetBoundingBox()
					_ = v12
					v2 = v22
					v1 = p2
				end
				local v3 = os.clock()
				p1.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, v3 % 6.283185307179586, 0) * CFrame.Angles(math.sin(v3 * 0.5) * 0.3 - 0.4, 0, 0) * CFrame.new(0, 0, v2.Magnitude * 0.8)
			end
		end
	end,
	getModel = function(p1, p2) --[[ Name: getModel | Line: 26 | Upvalues: ReplicatedStorage (copy), ItemSkinIds (copy) ]]
		local v1 = p2 or "RocketLauncher"
		assert(v1)
		local v2 = ReplicatedStorage.Resource.ItemSystem.Models:FindFirstChild(v1):Clone()
		local v3 = v2:GetBoundingBox()
		v2.PrimaryPart = v2:FindFirstChild("Skeleton"):FindFirstChild("BoundingBox")
		v2:SetPrimaryPartCFrame(v2.PrimaryPart.CFrame:ToObjectSpace(v3):Inverse())
		local v4, v5
		if p1 == "None" then
			v4 = v2
			v5 = nil
		else
			local v6 = ItemSkinIds[p1]
			if not v6 then
				error(("No skin by name of %s exists."):format(p1))
			end
			v5 = v6[v1]
			if not v5 then
				error(("Skin %s has no image id for item: %s"):format(p1, v1))
			end
			v4 = v2
		end
		for v8, v9 in v4:GetDescendants() do
			local v7
			if v9:IsA("MeshPart") and v9:GetAttribute("ApplyGunTexture") == true then
				v7 = if v5 then ("rbxassetid://%d"):format(v5) else ""
				v9.TextureID = v7
			end
		end
		return v4
	end
}