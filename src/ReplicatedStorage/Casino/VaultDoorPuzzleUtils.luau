local module = {}
local Players_upvr = game:GetService("Players")
function module.getHacker(arg1) -- Line 4
    local VaultHackerId = arg1:GetAttribute("VaultHackerId")
    if VaultHackerId then
        return Players_upvr:GetPlayerByUserId(VaultHackerId)
    end
    return nil
end
function module.setHacker(arg1, arg2) -- Line 12
    local var4
    if arg2 then
        var4 = arg2.UserId
    end
    arg1:SetAttribute("VaultHackerId", var4)
end
function module.getHackerChangedSignal(arg1) -- Line 19
    return arg1:GetAttributeChangedSignal("VaultHackerId")
end
function module.getDirection(arg1) -- Line 22
    return arg1:GetAttribute("VaultDirection")
end
function module.setDirection(arg1, arg2) -- Line 25
    arg1:SetAttribute("VaultDirection", arg2)
end
function module.getDirectionChangedSignal(arg1) -- Line 28
    return arg1:GetAttributeChangedSignal("VaultDirection")
end
function module.getDisabled(arg1) -- Line 31
    return arg1:GetAttribute("VaultDisabled")
end
function module.setDisabled(arg1, arg2) -- Line 34
    arg1:SetAttribute("VaultDisabled", arg2)
end
return module