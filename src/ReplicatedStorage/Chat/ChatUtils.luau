-- Reviewed by Claude
game:GetService("TextChatService")
local StarterGui = game:GetService("StarterGui")
local ChatUtils = {}
local isEnabled = true
local previousChatActive = true
function ChatUtils.setEnabled(enabled)
	isEnabled = enabled
	if enabled == false then
		previousChatActive = StarterGui:GetCore("ChatActive")
		StarterGui:SetCore("ChatActive", false)
	elseif not StarterGui:GetCore("ChatActive") then
		StarterGui:SetCore("ChatActive", previousChatActive)
	end
end
function ChatUtils.getEnabled()
	return isEnabled
end
function ChatUtils.hide()
	ChatUtils.setEnabled(false)
	return function()
		ChatUtils.setEnabled(true)
	end
end
return ChatUtils
