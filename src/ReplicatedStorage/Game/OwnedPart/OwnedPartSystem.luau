-- Reviewed by Claude
local v1 = nil
return {
	init = function()
		v1 = require(script.Parent.OwnedPartBinder)
		v1:Start()
	end
}
