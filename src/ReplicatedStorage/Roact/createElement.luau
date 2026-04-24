-- Reviewed by Claude
local Children = require(script.Parent.PropMarkers.Children)
local ElementKind = require(script.Parent.ElementKind)
local Logging = require(script.Parent.Logging)
local Type = require(script.Parent.Type)
local v1 = require(script.Parent.GlobalConfig).get()
return function(p1, p2, p3)
	if v1.typeChecks then
 assert(p1 ~= nil, "`component` is required")
 assert(typeof(p2) == "table" or p2 == nil, "`props` must be a table or nil")
 assert(typeof(p3) == "table" or p3 == nil, "`children` must be a table or nil")
	end
	if p2 == nil then
 p2 = {}
	end
	if p3 ~= nil then
 if p2[Children] ~= nil then
 Logging.warnOnce("The prop `Roact.Children` was defined but was overridden by the third parameter to createElement!\nThis can happen when a component passes props through to a child element but also uses the `children` argument:\n\n\tRoact.createElement(\"Frame\", passedProps, {\n\t\tchild = ...\n\t})\n\nInstead, consider using a utility function to merge tables of children together:\n\n\tlocal children = mergeTables(passedProps[Roact.Children], {\n\t\tchild = ...\n\t})\n\n\tlocal fullProps = mergeTables(passedProps, {\n\t\t[Roact.Children] = children\n\t})\n\n\tRoact.createElement(\"Frame\", fullProps)")
 end
 p2[Children] = p3
	end
	local t = {
 [Type] = Type.Element,
 [ElementKind] = ElementKind.fromComponent(p1),
 component = p1,
 props = p2
	}
	if v1.elementTracing then
 t.source = debug.traceback("", 2):sub(2)
	end
	return t
end