game:GetService("TextChatService")
local StarterGui = game:GetService("StarterGui")
local t = {}
local v1 = true
local v2 = true
function t.setEnabled(p1) --[[ Line: 8 | Upvalues: v1 (ref), v2 (ref), StarterGui (copy) ]]
	v1 = p1
	if p1 == false then
		v2 = StarterGui:GetCore("ChatActive")
		StarterGui:SetCore("ChatActive", false)
	elseif not StarterGui:GetCore("ChatActive") then
		StarterGui:SetCore("ChatActive", v2)
	end
end
function t.getEnabled() --[[ Line: 19 | Upvalues: v1 (ref) ]]
	return v1
end
function t.hide() --[[ Line: 22 | Upvalues: t (copy) ]]
	t.setEnabled(false)
	return function() --[[ Line: 24 | Upvalues: t (ref) ]]
		t.setEnabled(true)
	end
end
return t