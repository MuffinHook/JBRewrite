local TextChatService_upvr = game:GetService("TextChatService")
local StarterGui_upvr = game:GetService("StarterGui")
local Window_upvr = require(script.Parent.CmdrInterface.Window)
return function(arg1) -- Line 5
    arg1:HandleEvent("Message", function(arg1_2) -- Line 6
        if TextChatService_upvr.ChatVersion == Enum.ChatVersion.LegacyChatService then
            StarterGui_upvr:SetCore("ChatMakeSystemMessage", {
                Text = string.format("[Announcement] %s", arg1_2);
                Color = Color3.fromRGB(249, 217, 56);
            })
        else
            TextChatService_upvr.TextChannels.RBXSystem:DisplaySystemMessage(`<font color="rgb(249, 217, 56)">[Announcement] {arg1_2}</font>`)
        end
    end)
    arg1:HandleEvent("AddLine", function(...) -- Line 19
        Window_upvr:AddLine(...)
    end)
end
