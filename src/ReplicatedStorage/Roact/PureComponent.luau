local Component = require(script.Parent.Component)
local v1 = Component:extend("PureComponent")
v1.extend = Component.extend
function v1.shouldUpdate(p1, p2, p3) --[[ Line: 15 ]]
	if p3 == p1.state then
		if p2 ~= p1.props then
			for k, v in pairs(p2) do
				local _ = p1.props[k] ~= v
			end
			for k, v in pairs(p1.props) do
				local _ = p2[k] ~= v
			end
		end
		return false
	end
	return true
end
return v1