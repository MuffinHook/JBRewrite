local Maid = require(script.Parent.Maid)
local BaseObject = {
	ClassName = "BaseObject"
}
BaseObject.__index = BaseObject
function BaseObject.new(obj)
	local wrapper = setmetatable({}, BaseObject)
	wrapper.maid = Maid.new()
	wrapper.obj = obj
	return wrapper
end
function BaseObject.Destroy(instance)
	instance.maid:DoCleaning()
	setmetatable(instance, nil)
end
return BaseObject
