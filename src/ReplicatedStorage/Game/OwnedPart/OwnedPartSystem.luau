local ownedPartBinder = nil
return {
	init = function()
		ownedPartBinder = require(script.Parent.OwnedPartBinder)
		ownedPartBinder:Start()
	end
}
