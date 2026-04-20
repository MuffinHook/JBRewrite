local module_upvr = {
    _color = nil;
    _targetColor = Color3.new(1, 1, 1);
}
local RunService_upvr = game:GetService("RunService")
function module_upvr.init() -- Line 6
    task.spawn(function() -- Line 7
        local SkyLights_upvr = workspace:WaitForChild("SkyLights", 20)
        if SkyLights_upvr then
            local var6_upvw = 0
            RunService_upvr.Heartbeat:Connect(function() -- Line 11
                local tick_result1 = tick()
                if 5 < tick_result1 - var6_upvw then
                    var6_upvw = tick_result1
                    module_upvr._color = module_upvr._targetColor
                    module_upvr._targetColor = Color3.fromHSV(math.random(), 1, 1.5)
                end
                for _, v in ipairs(SkyLights_upvr:GetChildren()) do
                    v.Decal.Color3 = module_upvr._color:lerp(module_upvr._targetColor, (tick_result1 - var6_upvw) / 5)
                    local _
                end
            end)
        end
    end)
end
return module_upvr