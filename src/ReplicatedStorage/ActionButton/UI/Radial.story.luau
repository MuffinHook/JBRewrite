local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
return function(arg1) -- Line 6
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 9
        arg1_2:setState({
            countInner = 1;
            countOuter = 1;
        })
        arg1_2._maid = Maid_upvr.new()
        arg1_2._maid:GiveTask(Interval_upvr.every(0.1):Connect(function() -- Line 15
            arg1_2:setState({
                countOuter = arg1_2.state.countOuter % 21 + 1;
            })
        end))
        arg1_2._maid:GiveTask(Interval_upvr.every(1):Connect(function() -- Line 20
            arg1_2:setState({
                countInner = arg1_2.state.countInner % 2 + 1;
            })
        end))
    end
    local Radial_upvr = require(script.Parent.Radial)
    function any_extend_result1.render(arg1_3) -- Line 26
        ({})[1] = {
            image = "rbxassetid://7858404863";
            onClick = function(arg1_4) -- Line 31, Named "onClick"
                print("clicked jump")
            end;
        }
        ;({})[1] = {
            image = "rbxassetid://4939759147";
            title = "Crawl";
        }
        return Roact_upvr.createElement(Radial_upvr, {
            position = UDim2.new(0.25, 0, 0.25, 0);
            size = UDim2.new(0.5, 0, 0.5, 0);
            countInner = arg1_3.state.countInner;
            countOuter = arg1_3.state.countOuter;
        })
    end
    function any_extend_result1.willUnmount(arg1_5) -- Line 49
        arg1_5._maid:Destroy()
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 54
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end