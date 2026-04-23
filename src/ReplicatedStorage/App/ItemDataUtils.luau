local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	getConfig = function(p1) --[[ Name: getConfig | Line: 5 | Upvalues: ReplicatedStorage (copy) ]]
		local v1 = ReplicatedStorage.Game.ItemConfig:FindFirstChild(p1)
		if v1 == nil then
			return nil
		else
			return require(v1)
		end
	end
}