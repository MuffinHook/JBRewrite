-- Reviewed by Claude
local t = {
	isGamepadKeyCode = function(p1)
		local v1 = p1.Name
		return (v1:find("Button") or (v1:find("Thumbstick") or v1:find("DPad"))) and true or false
	end
}
function t.getBestKeyCode(p1, p2)
	if p1 and p2 then
		local _ = p2 == Enum.UserInputType.Touch
	end
end
return t