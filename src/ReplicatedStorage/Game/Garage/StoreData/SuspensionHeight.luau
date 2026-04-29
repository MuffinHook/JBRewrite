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
	GetInstance = function(suspensionItem)
		local suspensionAsset = ReplicatedStorage.Resource.Suspension:FindFirstChild(suspensionItem.Name)
		if not suspensionAsset then
			error("No Suspension named: " .. suspensionItem.Name)
		end
		local suspensionClone = suspensionAsset:Clone()
		suspensionClone.CFrame = CFrame.new(0, 0, 0)
		return suspensionClone
	end,
	Update = function(suspension, suspensionDimensions)
		local elapsedTime = os.clock() / 2
		suspension.CFrame = CFrame.Angles(0, elapsedTime % math.tau, 0) * CFrame.Angles(math.sin(elapsedTime) * 0.5 - 0.2, 0, 0) * CFrame.new(0, 0, suspensionDimensions.Size.Magnitude)
	end
}
