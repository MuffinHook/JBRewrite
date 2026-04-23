-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	Items = {
		{
			Name = "Level 1",
			Speed = 0,
			Price = 0
		},
		{
			Name = "Level 2",
			Speed = 0.75,
			Price = 8000
		},
		{
			Name = "Level 3",
			Speed = 1.5,
			Price = 18000
		},
		{
			Name = "Level 4",
			Speed = 2.25,
			Price = 32000
		},
		{
			Name = "Level 5",
			Speed = 3,
			Price = 50000
		}
	},
	GetInstance = function(p1)
		local v1 = ReplicatedStorage.Resource.Engine:FindFirstChild(p1.Name)
		if not v1 then
			error("No Engine named: " .. p1.Name)
		end
		local v2 = v1:Clone()
		v2.CFrame = CFrame.new(0, 0, 0)
		return v2
	end,
	Update = function(p1, p2)
		local v1 = os.clock() / 2
		p1.CFrame = CFrame.Angles(0, v1 % 6.283185307179586, 0) * CFrame.Angles(math.sin(v1) * 0.1 - 0.3, 0, 0) * CFrame.new(0, 0, p2.Size.Magnitude)
	end
}