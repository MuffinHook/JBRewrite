return function(itemData)
	local Model = itemData.Model
	if Model then
		return Model:FindFirstChild("Body", true) or itemData.Make == "Sloop"
	end
end
