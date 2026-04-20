local module_upvr = {
    triggerUpdate = require(game:GetService("ReplicatedStorage").Std.Signal).new();
    active = {};
}
function module_upvr.add(arg1) -- Line 7
    table.insert(module_upvr.active, arg1)
    module_upvr.triggerUpdate:Fire()
    return function() -- Line 10
        table.remove(module_upvr.active, table.find(module_upvr.active, arg1))
        module_upvr.triggerUpdate:Fire()
    end
end
return module_upvr