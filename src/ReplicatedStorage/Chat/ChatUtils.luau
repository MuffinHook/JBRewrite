local module_upvr = {}
local var2_upvw = true
local var3_upvw = true
local StarterGui_upvr = game:GetService("StarterGui")
function module_upvr.setEnabled(arg1) -- Line 8
    var2_upvw = arg1
    if arg1 == false then
        var3_upvw = StarterGui_upvr:GetCore("ChatActive")
        StarterGui_upvr:SetCore("ChatActive", false)
    elseif not StarterGui_upvr:GetCore("ChatActive") then
        StarterGui_upvr:SetCore("ChatActive", var3_upvw)
    end
end
function module_upvr.getEnabled() -- Line 19
    return var2_upvw
end
function module_upvr.hide() -- Line 22
    module_upvr.setEnabled(false)
    return function() -- Line 24
        module_upvr.setEnabled(true)
    end
end
return module_upvr