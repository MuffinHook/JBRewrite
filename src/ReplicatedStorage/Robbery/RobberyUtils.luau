local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
return {
	getStatus = function(robberyObject)
 return robberyObject:GetAttribute(RobberyConsts.STATUS_ATTR_NAME)
	end,
	setStatus = function(robberyObject, statusValue)
 assert(robberyObject ~= nil, "obj must not be nil")
 assert(typeof(statusValue) == "number", "value must be a number")
 robberyObject:SetAttribute(RobberyConsts.STATUS_ATTR_NAME, statusValue)
	end,
	getStatusChangedSignal = function(robberyObject)
 return robberyObject:GetAttributeChangedSignal(RobberyConsts.STATUS_ATTR_NAME)
	end,
	getDisableAutoOpen = function(robberyObject)
 return robberyObject:GetAttribute(RobberyConsts.DISABLE_AUTO_OPEN_ATTR_NAME) == true
	end,
	setDisableAutoOpen = function(robberyObject, isEnabled)
 robberyObject:SetAttribute(RobberyConsts.DISABLE_AUTO_OPEN_ATTR_NAME, isEnabled)
 return true
	end
}
