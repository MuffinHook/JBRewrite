-- Reviewed by Claude
local ElementKind = require(script.Parent.ElementKind)
local Type = require(script.Parent.Type)
return function(self)
	return {
 [Type] = Type.Element,
 [ElementKind] = ElementKind.Fragment,
 elements = self
	}
end
