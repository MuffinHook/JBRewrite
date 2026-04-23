local StarterGui = game:GetService("StarterGui")
local TextChatService = game:GetService("TextChatService")
local Window = require(script.Parent.CmdrInterface.Window)
return function(p1) --[[ Line: 5 | Upvalues: TextChatService (copy), StarterGui (copy), Window (copy) ]]
	p1:HandleEvent("Message", function(p1) --[[ Line: 6 | Upvalues: TextChatService (ref), StarterGui (ref) ]]
		if TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService then
			StarterGui:SetCore("ChatMakeSystemMessage", {
				Text = ("[Announcement] %s"):format(p1),
				Color = Color3.fromRGB(249, 217, 56)
			})
		else
			TextChatService.TextChannels.RBXSystem:DisplaySystemMessage((("<font color=\"rgb(249, 217, 56)\">[Announcement] %*</font>"):format(p1)))
		end
	end)
	p1:HandleEvent("AddLine", function(...) --[[ Line: 19 | Upvalues: Window (ref) ]]
		Window:AddLine(...)
	end)
end