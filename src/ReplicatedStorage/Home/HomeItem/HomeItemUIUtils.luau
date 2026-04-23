local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	getUpdateCamera = function() --[[ Name: getUpdateCamera | Line: 4 ]]
		local v1 = nil
		local v2 = nil
		local v3 = CFrame.Angles(0, 0, 0)
		return function(p1, p2) --[[ Line: 8 | Upvalues: v1 (ref), v2 (ref), v3 (ref) ]]
			if p2 then
				if p2 ~= v1 then
					local v12, v22 = p2:GetBoundingBox()
					_ = v12
					v2 = v22
					v1 = p2
					local UpDot = p2:FindFirstChild("UpDot")
					if UpDot and UpDot.Value ~= 1 then
						v3 = if UpDot.Value == 0 then CFrame.Angles(1.5707963267948966, 0, 1.5707963267948966) else CFrame.Angles(0, 0, math.pi)
					end
				end
				local v4 = os.clock()
				p1.CFrame = CFrame.new(0, 0, 0) * v3 * CFrame.Angles(0, v4 % 6.283185307179586, 0) * CFrame.Angles(math.sin(v4 * 0.5) * 0.3 - 0.4, 0, 0) * CFrame.new(0, 0, v2.Magnitude * 0.8)
			end
		end
	end,
	getModel = function(p1) --[[ Name: getModel | Line: 32 | Upvalues: ReplicatedStorage (copy) ]]
		local v1 = ReplicatedStorage.Resource.HomeItem:FindFirstChild(p1)
		if not v1 then
			error("No HomeItem exists by name: " .. p1)
		end
		local v2 = v1:Clone()
		local v3 = v2
		for v4, v5 in v2:GetDescendants() do
			if v5:IsA("LuaSourceContainer") then
				v5:Destroy()
			end
		end
		v3:SetPrimaryPartCFrame(v3.PrimaryPart.CFrame:ToObjectSpace((v3:GetBoundingBox())):Inverse())
		return v3
	end
}