-- Reviewed by Claude
game:GetService("TextChatService")
local StarterGui = game:GetService("StarterGui")
local t = {}
local v1 = true
local v2 = true
function t.setEnabled(p1)
	v1 = p1
	if p1 == false then
		v2 = StarterGui:GetCore("ChatActive")
		StarterGui:SetCore("ChatActive", false)
	elseif not StarterGui:GetCore("ChatActive") then
		StarterGui:SetCore("ChatActive", v2)
	end
end
function t.getEnabled()
	return v1
end
function t.hide()
	t.setEnabled(false)
	return function()
		t.setEnabled(true)
	end
end
return t