local StarterGui = game:GetService("StarterGui")
local TextChatService = game:GetService("TextChatService")
local Window = require(script.Parent.CmdrInterface.Window)
return function(cmdr)
	cmdr:HandleEvent("Message", function(message)
		if TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService then
			StarterGui:SetCore("ChatMakeSystemMessage", {
				Text = ("[Announcement] %s"):format(message),
				Color = Color3.fromRGB(249, 217, 56)
			})
		else
			TextChatService.TextChannels.RBXSystem:DisplaySystemMessage((("<font color=\"rgb(249, 217, 56)\">[Announcement] %*</font>"):format(message)))
		end
	end)
	cmdr:HandleEvent("AddLine", function(...)
		Window:AddLine(...)
	end)
end
