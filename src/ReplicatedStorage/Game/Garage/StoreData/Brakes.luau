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
	GetInstance = function(brakeItem)
		local brakeTemplate = ReplicatedStorage.Resource.Brakes:FindFirstChild(brakeItem.Name)
		if not brakeTemplate then
			error("No Brakes named: " .. brakeItem.Name)
		end
		local clonedBrake = brakeTemplate:Clone()
		clonedBrake.PrimaryPart = clonedBrake.Center
		clonedBrake:SetPrimaryPartCFrame(CFrame.new() * CFrame.Angles(math.pi / 2, 0, 0))
		return clonedBrake
	end,
	Update = function(brakePart, p2)
		local rotationTime = os.clock() / 2
		brakePart.CFrame = CFrame.Angles(0, rotationTime % math.tau, 0) * CFrame.Angles(math.sin(rotationTime) * 0.5 - 0.2, 0, 0) * CFrame.new(0, 0, 10)
	end
}
