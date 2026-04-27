return function(player)
	local Model = player.Model
	if Model then
		local modelChild = Model:FindFirstChild("Model")
		if modelChild then
			return modelChild:FindFirstChild("plate")
		end
	end
end
