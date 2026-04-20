local module = {}
local ScriptContext_upvr = game:GetService("ScriptContext")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local GuiService_upvr = game:GetService("GuiService")
local UserInputService_upvr = game:GetService("UserInputService")
function module.initClient() -- Line 15
    ScriptContext_upvr.Error:Connect(function(arg1, arg2, arg3) -- Line 18
        if not arg3 then
        else
            local var7_upvw
            local pcall_result1, pcall_result2 = pcall(function() -- Line 24
                var7_upvw = arg3:GetFullName()
            end)
            if not pcall_result1 then return end
            ReplicatedStorage_upvr.GameAnalyticsError:FireServer(arg1, arg2, var7_upvw)
        end
    end)
    require(script.Parent.GameAnalytics.Postie).setCallback("getPlatform", function() -- Line 35, Named "getPlatform"
        if GuiService_upvr:IsTenFootInterface() then
            return "Console"
        end
        if UserInputService_upvr.TouchEnabled and not UserInputService_upvr.MouseEnabled then
            return "Mobile"
        end
        return "Desktop"
    end)
end
return module