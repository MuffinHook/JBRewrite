-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(false, {
	setInVehicle = function(p1, p2)
		assert(p2.inVehicle ~= nil, "missing inVehicle value")
		return p2.inVehicle
	end
})
