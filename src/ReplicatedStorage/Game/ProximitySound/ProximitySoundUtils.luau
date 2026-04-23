local ProximitySoundConsts = require(script.Parent.ProximitySoundConsts)
return {
	setEnabled = function(p1, p2) --[[ Name: setEnabled | Line: 4 | Upvalues: ProximitySoundConsts (copy) ]]
		assert(p1 ~= nil)
		assert(p2 ~= nil)
		p1:SetAttribute(ProximitySoundConsts.ENABLED_ATTR_NAME, p2)
	end,
	setRadius = function(p1, p2) --[[ Name: setRadius | Line: 9 | Upvalues: ProximitySoundConsts (copy) ]]
		assert(p1 ~= nil)
		assert(p2 ~= nil)
		p1:SetAttribute(ProximitySoundConsts.RADIUS_ATTR_NAME, p2)
	end,
	setId = function(p1, p2) --[[ Name: setId | Line: 14 | Upvalues: ProximitySoundConsts (copy) ]]
		assert(p1 ~= nil)
		assert(typeof(p2) == "number")
		p1:SetAttribute(ProximitySoundConsts.ID_ATTR_NAME, p2)
	end
}