local CollectionService_upvr = game:GetService("CollectionService")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local function _(arg1) -- Line 7, Named "getRobberyMarkerForName"
    for _, v in CollectionService_upvr:GetTagged("RobberyMarker"), nil do
        if v.Name == arg1 then
            return v
        end
    end
    return nil
end
local MinimapService_upvr = require(script.Parent.MinimapService)
local Dictionary_upvr = require(ReplicatedStorage_upvr.EzUi.Dictionary)
function module.init() -- Line 16
    task.spawn(function() -- Line 17
        local var10_upvw = 0
        ReplicatedStorage_upvr.App:WaitForChild("SetRobberyWaypointRemote").OnClientEvent:Connect(function(arg1) -- Line 20
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            local var11 = var10_upvw + 1
            var10_upvw = var11
            local var12
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            local var13
            if var13 then
                MinimapService_upvr.addWaypoint(Dictionary_upvr.merge(arg1, {
                    part = var13;
                }))
            else
                warn("No part found for marker name", arg1.markerName)
                task.wait(1)
            end
            if nil then
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
            if var10_upvw ~= var11 then
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end)
    end)
end
return module