local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.CCTV), {
        size = UDim2.new(0.5, 0, 0.5, 0);
        position = UDim2.new(0.5, 0, 0.5, 0);
        distance = 96;
        aspectRatio = 1.7777777777777777;
        cameraCFrame = workspace.CurrentCamera.CFrame;
        fieldOfView = 70;
    }), arg1)
    return function() -- Line 17
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end