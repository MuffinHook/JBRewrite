return function(engine, playerConfig)
	if engine then
		playerConfig.GarageEngineSpeed = engine.Speed
	else
		playerConfig.GarageEngineSpeed = 0
	end
end
