-- Reviewed by Claude
local ProximityCamShakeConsts = require(script.Parent.ProximityCamShakeConsts)
return {
	setEnabled = function(p1, p2)
		assert(p2 ~= nil)
		p1:SetAttribute(ProximityCamShakeConsts.ENABLED_ATTR_NAME, p2)
	end,
	setRadius = function(p1, p2)
		assert(p2 ~= nil)
		p1:SetAttribute(ProximityCamShakeConsts.RADIUS_ATTR_NAME, p2)
	end,
	setMagnitude = function(p1, p2)
		assert(p2 ~= nil)
		p1:SetAttribute(ProximityCamShakeConsts.MAGNITUDE_ATTR_NAME, p2)
	end
}
