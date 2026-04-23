local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
return {
	getStatus = function(p1) --[[ Name: getStatus | Line: 5 | Upvalues: RobberyConsts (copy) ]]
		return p1:GetAttribute(RobberyConsts.STATUS_ATTR_NAME)
	end,
	setStatus = function(p1, p2) --[[ Name: setStatus | Line: 8 | Upvalues: RobberyConsts (copy) ]]
		assert(p1 ~= nil, "obj must not be nil")
		assert(typeof(p2) == "number", "value must be a number")
		p1:SetAttribute(RobberyConsts.STATUS_ATTR_NAME, p2)
	end,
	getStatusChangedSignal = function(p1) --[[ Name: getStatusChangedSignal | Line: 13 | Upvalues: RobberyConsts (copy) ]]
		return p1:GetAttributeChangedSignal(RobberyConsts.STATUS_ATTR_NAME)
	end,
	getDisableAutoOpen = function(p1) --[[ Name: getDisableAutoOpen | Line: 16 | Upvalues: RobberyConsts (copy) ]]
		return p1:GetAttribute(RobberyConsts.DISABLE_AUTO_OPEN_ATTR_NAME) == true
	end,
	setDisableAutoOpen = function(p1, p2) --[[ Name: setDisableAutoOpen | Line: 19 | Upvalues: RobberyConsts (copy) ]]
		p1:SetAttribute(RobberyConsts.DISABLE_AUTO_OPEN_ATTR_NAME, p2)
		return true
	end
}