-- Reviewed by Claude
-- variables reassigned
local Children = require(script.Parent.PropMarkers.Children)
local ElementKind = require(script.Parent.ElementKind)
local Logging = require(script.Parent.Logging)
local Type = require(script.Parent.Type)
local config = require(script.Parent.GlobalConfig).get()
return function(self, callback, self)
	if config.typeChecks then
 assert(self ~= nil, "`component` is required")
 assert(typeof(callback) == "table" or callback == nil, "`props` must be a table or nil")
 assert(typeof(self) == "table" or self == nil, "`children` must be a table or nil")
	end
	if callback == nil then
 callback = {}
	end
	if self ~= nil then
 if callback[Children] ~= nil then
 Logging.warnOnce("The prop `Roact.Children` was defined but was overridden by the third parameter to createElement!\nThis can happen when a component passes props through to a child element but also uses the `children` argument:\n\n\tRoact.createElement(\"Frame\", passedProps, {\n\tbl\tchild = ...\n\tbl})\n\nInstead, consider using a utility function to merge tables of children together:\n\n\tlocal children = mergeTables(passedProps[Roact.Children], {\n\tbl\tchild = ...\n\tbl})\n\n\tlocal fullProps = mergeTables(passedProps, {\n\tbl\tbl[Roact.Children] = children\n\tbl})\n\n\tRoact.createElement(\"Frame\", fullProps)")
 end
 callback[Children] = self
	end
	local tbl = {
 [Type] = Type.Element,
 [ElementKind] = ElementKind.fromComponent(self),
 component = self,
 props = callback
	}
	if config.elementTracing then
 tbl.source = debug.traceback("", 2):sub(2)
	end
	return tbl
end
