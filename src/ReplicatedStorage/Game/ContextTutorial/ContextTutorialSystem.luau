local module = {}
local Binder_upvr = require(game:GetService("ReplicatedStorage").Std.Binder)
function module.init() -- Line 5
    local tbl = {}
    for _, v in ipairs(script.Parent.Module:GetChildren()) do
        local any_new_result1 = Binder_upvr.new(v.Name, require(v.Class))
        any_new_result1:Start()
        table.insert(tbl, any_new_result1)
    end
end
return module