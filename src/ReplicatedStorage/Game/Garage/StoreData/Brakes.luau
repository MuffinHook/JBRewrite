-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	Items = {
		{
			Name = "Level 1",
			Price = 0,
			Amount = 0
		},
		{
			Name = "Level 2",
			Price = 2000,
			Amount = 2.5
		},
		{
			Name = "Level 3",
			Price = 4500,
			Amount = 5
		}
	},
	GetInstance = function(p1)
		local v1 = ReplicatedStorage.Resource.Brakes:FindFirstChild(p1.Name)
		if not v1 then
			error("No Brakes named: " .. p1.Name)
		end
		local v2 = v1:Clone()
		v2.PrimaryPart = v2.Center
		v2:SetPrimaryPartCFrame(CFrame.new() * CFrame.Angles(1.5707963267948966, 0, 0))
		return v2
	end,
	Update = function(p1, p2)
		local v1 = os.clock() / 2
		p1.CFrame = CFrame.Angles(0, v1 % 6.283185307179586, 0) * CFrame.Angles(math.sin(v1) * 0.5 - 0.2, 0, 0) * CFrame.new(0, 0, 10)
	end
}