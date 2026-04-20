local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.Keypad), {
        size = UDim2.new(0.9, 0, 0.9, 0);
        position = UDim2.new(0.5, 0, 0.5, 0);
        onSubmit = function(arg1_2) -- Line 10, Named "onSubmit"
            local var4
            if arg1_2 ~= "0000" then
                var4 = false
            else
                var4 = true
            end
            print(arg1_2, var4)
        end;
    }), arg1)
    return function() -- Line 16
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end