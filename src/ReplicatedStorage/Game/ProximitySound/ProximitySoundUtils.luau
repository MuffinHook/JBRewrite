local ProximitySoundConsts = require(script.Parent.ProximitySoundConsts)
return {
	setEnabled = function(soundInstance, enabledValue)
		assert(soundInstance ~= nil)
		assert(enabledValue ~= nil)
		soundInstance:SetAttribute(ProximitySoundConsts.ENABLED_ATTR_NAME, enabledValue)
	end,
	setRadius = function(soundInstance, radiusValue)
		assert(soundInstance ~= nil)
		assert(radiusValue ~= nil)
		soundInstance:SetAttribute(ProximitySoundConsts.RADIUS_ATTR_NAME, radiusValue)
	end,
	setId = function(soundInstance, idValue)
		assert(soundInstance ~= nil)
		assert(typeof(idValue) == "number")
		soundInstance:SetAttribute(ProximitySoundConsts.ID_ATTR_NAME, idValue)
	end
}
