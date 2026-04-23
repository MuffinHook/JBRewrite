local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	Items = {
		{
			Name = "Slammed",
			Price = 3000,
			Height = -0.5
		},
		{
			Name = "Low",
			Price = 2500,
			Height = -0.25
		},
		{
			Name = "Normal",
			Height = 0,
			Price = 0
		},
		{
			Name = "Raised",
			Price = 2500,
			Height = 0.2
		},
		{
			Name = "High",
			Price = 3000,
			Height = 0.5
		},
		{
			Name = "Monster",
			Price = 5000,
			Height = 1.5
		}
	},
	GetInstance = function(p1) --[[ Name: GetInstance | Line: 34 | Upvalues: ReplicatedStorage (copy) ]]
		local v1 = ReplicatedStorage.Resource.Suspension:FindFirstChild(p1.Name)
		if not v1 then
			error("No Suspension named: " .. p1.Name)
		end
		local v2 = v1:Clone()
		v2.CFrame = CFrame.new(0, 0, 0)
		return v2
	end,
	Update = function(p1, p2) --[[ Name: Update | Line: 47 ]]
		local v1 = os.clock() / 2
		p1.CFrame = CFrame.Angles(0, v1 % 6.283185307179586, 0) * CFrame.Angles(math.sin(v1) * 0.5 - 0.2, 0, 0) * CFrame.new(0, 0, p2.Size.Magnitude)
	end
}