-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
return {
	getStatus = function(p1)
 return p1:GetAttribute(RobberyConsts.STATUS_ATTR_NAME)
	end,
	setStatus = function(p1, p2)
 assert(p1 ~= nil, "obj must not be nil")
 assert(typeof(p2) == "number", "value must be a number")
 p1:SetAttribute(RobberyConsts.STATUS_ATTR_NAME, p2)
	end,
	getStatusChangedSignal = function(p1)
 return p1:GetAttributeChangedSignal(RobberyConsts.STATUS_ATTR_NAME)
	end,
	getDisableAutoOpen = function(p1)
 return p1:GetAttribute(RobberyConsts.DISABLE_AUTO_OPEN_ATTR_NAME) == true
	end,
	setDisableAutoOpen = function(p1, p2)
 p1:SetAttribute(RobberyConsts.DISABLE_AUTO_OPEN_ATTR_NAME, p2)
 return true
	end
}