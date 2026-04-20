local module = {}
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local RunService_upvr = game:GetService("RunService")
function module.Init() -- Line 9
    local BoatScenery = ReplicatedStorage_upvr.Resource.BoatScenery
    BoatScenery.Parent = workspace
    local tbl_upvr = {}
    for _, v in ipairs(BoatScenery:GetChildren()) do
        local var13
        if v.Name:find("Ship") then
            var13 = -20
        elseif v.Name:find("Sailboat") then
            var13 = 45 + math.random() * 20
        end
        assert(var13)
        table.insert(tbl_upvr, {
            Part = v;
            Speed = var13;
            Angle = math.random() * math.pi * 2 * 0.1;
            Radius = 6489.6 + (math.random() * 2 - 1) * 50;
        })
    end
    RunService_upvr.Heartbeat:Connect(function(arg1) -- Line 30
        for _, v_2 in ipairs(tbl_upvr) do
            v_2.Angle += v_2.Speed * arg1 / v_2.Radius
            v_2.Part.CFrame = CFrame.Angles(0, v_2.Angle, 0) * CFrame.new(v_2.Radius, 0, 0) + Vector3.new(169, 0, -1550) + Vector3.new(0, v_2.Part.Size.Y * 0.5, 0)
        end
    end)
end
return module