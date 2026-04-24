-- Reviewed by Claude
local ElementKind = require(script.Parent.ElementKind)
local Type = require(script.Parent.Type)
return function(p1)
	return {
 [Type] = Type.Element,
 [ElementKind] = ElementKind.Fragment,
 elements = p1
	}
end