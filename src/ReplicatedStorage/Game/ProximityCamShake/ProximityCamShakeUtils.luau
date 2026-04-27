local ProximityCamShakeConsts = require(script.Parent.ProximityCamShakeConsts)
return {
	setEnabled = function(targetInstance, isEnabled)
		assert(isEnabled ~= nil)
		targetInstance:SetAttribute(ProximityCamShakeConsts.ENABLED_ATTR_NAME, isEnabled)
	end,
	setRadius = function(targetInstance, radius)
		assert(radius ~= nil)
		targetInstance:SetAttribute(ProximityCamShakeConsts.RADIUS_ATTR_NAME, radius)
	end,
	setMagnitude = function(targetInstance, magnitude)
		assert(magnitude ~= nil)
		targetInstance:SetAttribute(ProximityCamShakeConsts.MAGNITUDE_ATTR_NAME, magnitude)
	end
}
