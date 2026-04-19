-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMbC0NoYXRWZXJzaW9uBEVudW0RTGVnYWN5Q2hhdFNlcnZpY2UVQ2hhdE1ha2VTeXN0ZW1NZXNzYWdlBFRleHQFQ29sb3IRW0Fubm91bmNlbWVudF0gJXMGZm9ybWF0BkNvbG9yMwdmcm9tUkdCB1NldENvcmUMVGV4dENoYW5uZWxzCVJCWFN5c3RlbTg8Zm9udCBjb2xvcj0icmdiKDI0OSwgMjE3LCA1NikiPltBbm5vdW5jZW1lbnRdICUqPC9mb250PhREaXNwbGF5U3lzdGVtTWVzc2FnZQdBZGRMaW5lB01lc3NhZ2ULSGFuZGxlRXZlbnQEZ2FtZQpTdGFydGVyR3VpCkdldFNlcnZpY2UPVGV4dENoYXRTZXJ2aWNlB3JlcXVpcmUGc2NyaXB0BlBhcmVudA1DbWRySW50ZXJmYWNlBldpbmRvdwAECQECAAAHAAABAwUMAiz7AQAATQEB1wAAAACkAgMAAgAQwJoBFwACAAAA+wEBAG8DBADiBAcAbwUIAFIHAAC8BQWNCQAAAJ8FAwIwBQT1BQAAAKQFDAAALKCAjAb5AIwH2QCMCDgAnwUEAjAFBKQGAAAAvAEBvw0AAACfAQQBggABAPsBAABNAQGHDgAAAE0BAbAPAAAAbwQQAFIGAAC8BASNCQAAAJ8EAwJSAwQAvAEBIREAAACfAQMBggABABIDAQMCAwMEAgAQwAMEAwUDBgUCBQYDBwMIAwkDCgQALKCAAwsDDAMNAw4DDwAGAAEYAAAAAAAAAAEAAAEAAAAAAAABAAAAAAAAAP4AAAAFAAAAAAEAAAAAAP8AAAQHAAAAAAMAAQEAAAejAAAA+wAAAN0CAAC8AABoAAAAAJ8AAAGCAAEAAQMQABMAARgAAQAAAAABEwAAAAAFAQMAAAAObwMAAMAEAQASAgAAEgIBALwBAJQCAAAAnwEEAW8DAwDABAQAEgICALwBAJQCAAAAnwEEAYIAAQAFAxEGAAMSAxAGAQIAAQUAARgAAAAAAAAADQAAAAAAAwYAAAAABAAAAQIAHaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQEAAAAAQG8DBAC8AQEWAwAAAJ8BAwKkAgYAAABQQKQDCAAAAHBATQMDJAkAAABNAwPsCgAAAE0DA2ULAAAAnwICAsADDAASAAEAEgAAABIAAgCCAwIADQMTBAAAAEADFAMVAxYDFwQAAFBAAxgEAABwQAMZAxoDGwYCAQIBAAEYAAAAAAAAAAEAAAAAAAEAAAAAAAAAAAAAAgAAAAABAAAAAANqadk4/a5Xm49i9PmPI59QGnHOTFitszk=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:32:13
-- Luau version 6, Types version 3
-- Time taken: 0.001388 seconds

local TextChatService_upvr = game:GetService("TextChatService")
local StarterGui_upvr = game:GetService("StarterGui")
local Window_upvr = require(script.Parent.CmdrInterface.Window)
return function(arg1) -- Line 5
    --[[ Upvalues[3]:
        [1]: TextChatService_upvr (readonly)
        [2]: StarterGui_upvr (readonly)
        [3]: Window_upvr (readonly)
    ]]
    arg1:HandleEvent("Message", function(arg1_2) -- Line 6
        --[[ Upvalues[2]:
            [1]: TextChatService_upvr (copied, readonly)
            [2]: StarterGui_upvr (copied, readonly)
        ]]
        if TextChatService_upvr.ChatVersion == Enum.ChatVersion.LegacyChatService then
            StarterGui_upvr:SetCore("ChatMakeSystemMessage", {
                Text = "[Announcement] %s":format(arg1_2);
                Color = Color3.fromRGB(249, 217, 56);
            })
        else
            TextChatService_upvr.TextChannels.RBXSystem:DisplaySystemMessage(`<font color="rgb(249, 217, 56)">[Announcement] {arg1_2}</font>`)
        end
    end)
    arg1:HandleEvent("AddLine", function(...) -- Line 19
        --[[ Upvalues[1]:
            [1]: Window_upvr (copied, readonly)
        ]]
        Window_upvr:AddLine(...)
    end)
end