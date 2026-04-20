local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
return function(arg1) -- Line 4
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 7
    end
    local TopbarHolder_upvr = require(script.Parent.TopbarHolder)
    function any_extend_result1.render(arg1_3) -- Line 8
        return Roact_upvr.createElement(TopbarHolder_upvr, {
            buttons = {{
                name = "TeamSwitch";
                imageId = 4912231691;
            }, {
                name = "Contracts";
                imageId = 6132976621;
                count = 3;
                onClick = function(arg1_4) -- Line 18, Named "onClick"
                    print("clicked contracts", arg1_4)
                end;
            }, {
                name = "Garage";
                imageId = 4912231022;
            }, {
                name = "Season";
                imageId = 6132976621;
            }};
        })
    end
    function any_extend_result1.willUnmount(arg1_5) -- Line 35
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 38
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end