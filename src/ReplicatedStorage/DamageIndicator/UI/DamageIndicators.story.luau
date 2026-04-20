local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    local DamageIndicatorService = require(script.Parent.Parent.DamageIndicatorService)
    local any_add_result1_upvr = DamageIndicatorService.add({
        worldPosition = Vector3.new(0, 0, 0);
        lifetime = 30;
    })
    local any_add_result1_upvr_2 = DamageIndicatorService.add({
        worldPosition = Vector3.new(100, 0, 100);
        color = Color3.new(1, 1, 0);
        strength = 0.1;
        lifetime = 30;
    })
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.DamageIndicators), {
        size = UDim2.new(0.95, 0, 0.95, 0);
    }), arg1)
    return function() -- Line 23
        if any_add_result1_upvr then
            any_add_result1_upvr()
        end
        if any_add_result1_upvr_2 then
            any_add_result1_upvr_2()
        end
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end