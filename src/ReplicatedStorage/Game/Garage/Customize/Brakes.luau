return function(brakesData, playerData)
	if brakesData then
		playerData.GarageBrakes = brakesData.Amount
	else
		playerData.GarageBrakes = 0
	end
end
