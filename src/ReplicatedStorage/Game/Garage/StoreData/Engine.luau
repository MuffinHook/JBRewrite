-- Reviewed by Claude
-- variables reassigned
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
	GetInstance = function(engineConfig)
		local engineInstance = ReplicatedStorage.Resource.Engine:FindFirstChild(engineConfig.Name)
		if not engineInstance then
			error("No Engine named: " .. engineConfig.Name)
		end
		local clonedEngine = engineInstance:Clone()
		clonedEngine.CFrame = CFrame.new(0, 0, 0)
		return clonedEngine
	end,
	Update = function(engine, config)
		local elapsedTime = os.clock() / 2
		engine.CFrame = CFrame.Angles(0, elapsedTime % 6.283185307179586, 0) * CFrame.Angles(math.sin(elapsedTime) * 0.1 - 0.3, 0, 0) * CFrame.new(0, 0, config.Size.Magnitude)
	end
}
