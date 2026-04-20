local module_upvr = {
    ChatModule = nil;
}
local CurrentCamera_upvr = workspace.CurrentCamera
function module_upvr.IsSmallScreen() -- Line 9
    local X = CurrentCamera_upvr.ViewportSize.X
    if math.min(X, CurrentCamera_upvr.ViewportSize.y) > 500 then
        X = false
    else
        X = true
    end
    return X
end
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function module_upvr.GetChatModule() -- Line 15
    if module_upvr.ChatModule then
        return module_upvr.ChatModule
    end
    local ChatScript = LocalPlayer_upvr.PlayerScripts:FindFirstChild("ChatScript")
    if ChatScript == nil then
        return nil
    end
    local ChatMain_upvr = ChatScript:FindFirstChild("ChatMain")
    if ChatMain_upvr == nil then
        return nil
    end
    local var7_upvw
    local pcall_result1_2, pcall_result2 = pcall(function() -- Line 28
        var7_upvw = require(ChatMain_upvr)
    end)
    if not pcall_result1_2 then
        warn(pcall_result2)
        return nil
    end
    module_upvr.ChatModule = var7_upvw
    return module_upvr.ChatModule
end
function module_upvr.GetChatVisible() -- Line 38
    local any_GetChatModule_result1_upvr = module_upvr.GetChatModule()
    if any_GetChatModule_result1_upvr ~= nil and any_GetChatModule_result1_upvr.GetVisibility ~= nil then
        local var12_upvw
        local pcall_result1_3, pcall_result2_3 = pcall(function() -- Line 43
            var12_upvw = any_GetChatModule_result1_upvr:GetVisibility()
        end)
        if not pcall_result1_3 then
            warn(pcall_result2_3)
        end
        return var12_upvw
    end
    warn("Could not set chat visibility. API changed?")
    return false
end
function module_upvr.SetChatVisible(arg1) -- Line 55
    local any_GetChatModule_result1_upvr_2 = module_upvr.GetChatModule()
    if any_GetChatModule_result1_upvr_2 ~= nil and any_GetChatModule_result1_upvr_2.SetVisible ~= nil then
        local pcall_result1, pcall_result2_2 = pcall(function() -- Line 59
            any_GetChatModule_result1_upvr_2:SetVisible(arg1)
        end)
        if not pcall_result1 then
            warn(pcall_result2_2)
        end
        return true
    end
    warn("Could not set chat visibility. API changed?")
    return false
end
function module_upvr.getJumpButtonPosition() -- Line 71
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local any_IsSmallScreen_result1 = module_upvr.IsSmallScreen()
    local var21
    if any_IsSmallScreen_result1 then
        var21 = 70
    else
        var21 = 120
    end
    if not any_IsSmallScreen_result1 or not UDim2.new(1, -(var21 * 1.5 - 10), 1, -var21 - 20) then
    end
    return UDim2.new(1, -(var21 * 1.5 - 10), 1, -var21 * 1.75)
end
local EzUtils_upvr = require(game:GetService("ReplicatedStorage").EzUi.EzUtils)
function module_upvr.selectIfGamepad(arg1) -- Line 79
    EzUtils_upvr.selectIfGamepad(arg1)
end
return module_upvr