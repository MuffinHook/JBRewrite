local ElementKind = require(script.Parent.ElementKind)
local Type = require(script.Parent.Type)
return function(p1) --[[ Name: createFragment | Line: 4 | Upvalues: Type (copy), ElementKind (copy) ]]
	return {
		[Type] = Type.Element,
		[ElementKind] = ElementKind.Fragment,
		elements = p1
	}
end