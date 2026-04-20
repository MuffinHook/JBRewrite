local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(game:GetService("ReplicatedStorage").Std.Maid)
function module_upvr.new() -- Line 6
    local module_upvr_2 = {}
    setmetatable(module_upvr_2, module_upvr)
    module_upvr_2._maid = Maid_upvr.new()
    module_upvr_2._listWindow = {}
    module_upvr_2._maid:GiveTask(function() -- Line 12
        for _, v in ipairs(module_upvr_2._listWindow) do
            v:Destroy()
        end
        module_upvr_2._listWindow = nil
    end)
    return module_upvr_2
end
function module_upvr.Add(arg1, arg2) -- Line 21
    local var14
    if arg2.__ClassName ~= "Window" then
        var14 = false
    else
        var14 = true
    end
    assert(var14)
    var14 = arg1._listWindow
    local ipairs_result1, ipairs_result2_3, ipairs_result3_2 = ipairs(var14)
    for _, v_2 in ipairs_result1, ipairs_result2_3, ipairs_result3_2 do
        if arg2 == v_2 then
            error("Window already exists in group.")
        end
    end
    ipairs_result2_3 = arg1._listWindow
    table.insert(ipairs_result2_3, arg2)
    function arg2._beforeOpenFun() -- Line 31
        for _, v_3 in ipairs(arg1._listWindow) do
            if v_3 ~= arg2 and v_3:IsOpen() then
                v_3:Close()
            end
        end
    end
end
function module_upvr.Destroy(arg1) -- Line 39
    assert(arg1._maid)
    arg1._maid = nil
    arg1._maid:Destroy()
end
return module_upvr