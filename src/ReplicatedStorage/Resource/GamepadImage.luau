local module = {}
local tbl_upvr = {}
for _, v in pairs(script.Spritesheets:GetChildren()) do
    tbl_upvr[v.Name] = {}
    for _, v_2 in pairs(v:GetChildren()) do
        tbl_upvr[v.Name][v_2.Name] = require(v_2).new()
    end
end
local function getImageInstance_upvr(arg1, arg2, arg3) -- Line 11, Named "getImageInstance"
    local var17
    if type(arg2) == "userdata" then
        var17 = string.sub(tostring(var17), 14)
    end
    local var18 = tbl_upvr.XboxOne[arg3]
    if not var18 then
        warn("Could not find style: "..arg3)
        return
    end
    return var18:GetSprite(arg1, var17)
end
function module.GetImageLabel(arg1, arg2, arg3, arg4) -- Line 25
    return getImageInstance_upvr("ImageLabel", arg2, arg3, arg4)
end
function module.GetImageButton(arg1, arg2, arg3, arg4) -- Line 29
    return getImageInstance_upvr("ImageButton", arg2, arg3, arg4)
end
return module