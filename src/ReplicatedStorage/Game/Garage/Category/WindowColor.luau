return function(player)
	local Model = player.Model
	if Model then
		return Model:FindFirstChild("Windows", true)
	end
end
