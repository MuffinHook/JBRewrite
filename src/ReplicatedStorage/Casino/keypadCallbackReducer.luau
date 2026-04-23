-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Rodux).createReducer(nil, {
	setCasinoKeypadCallback = function(p1, p2)
		assert(p2.callback ~= nil, "missing callback")
		return p2.callback
	end
})