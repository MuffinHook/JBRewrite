local supportedMakes = {
	Trailblazer = true,
	R8 = true,
	MoltenM12 = true,
	Ray9 = true,
	BeamHybrid = true,
	Concept = true,
	Celsior = true,
	JackRabbit = true,
	Sentinel = true,
	BananaCar = true,
	EscapeBot = true,
	Shogun = true,
	Poseidon = true,
	Stunt = true,
	Dirtbike = true,
	Sloop = true,
	Cruiser = true,
	Wedge = true,
	Blackbeard = true,
	OrionM42 = true,
	Polaire = true
}
return function(vehicleData)
	if supportedMakes[vehicleData.Make] then
		return false
	end
	local Model = vehicleData.Model
	if Model then
		return Model:FindFirstChild("SecondBody", true)
	end
end
