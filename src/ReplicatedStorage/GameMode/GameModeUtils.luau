local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_upvr = {}
local TableUtils_upvr = require(ReplicatedStorage_upvr.Std.TableUtils)
function module_upvr.getGameModeNames() -- Line 6
    local any_map_result1 = TableUtils_upvr.map(ReplicatedStorage_upvr.GameMode.Mode:GetChildren(), function(arg1) -- Line 7
        return arg1.Name
    end)
    table.insert(any_map_result1, "CrewBattle")
    return any_map_result1
end
local CollectionService_upvr = game:GetService("CollectionService")
function module_upvr.getGameModesRunning() -- Line 14
    return CollectionService_upvr:GetTagged("GameMode")
end
function module_upvr.isThisGameModeRunning(arg1) -- Line 17
    for _, v in module_upvr.getGameModesRunning() do
        if v.Name == arg1 then
            return true
        end
    end
    return false
end
return module_upvr