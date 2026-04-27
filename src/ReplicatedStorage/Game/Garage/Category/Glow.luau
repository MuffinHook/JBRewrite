return function(item)
	local Model = item.Model
	if Model then
		return Model:FindFirstChild("Glow", true) ~= nil
	end
end
