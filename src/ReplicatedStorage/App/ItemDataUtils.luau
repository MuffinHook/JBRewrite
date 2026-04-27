local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	getConfig = function(configId)
		local configModule = ReplicatedStorage.Game.ItemConfig:FindFirstChild(configId)
		if configModule == nil then
			return nil
		else
			return require(configModule)
		end
	end
}
