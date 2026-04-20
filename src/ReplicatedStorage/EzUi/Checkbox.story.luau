local Roact_upvr = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 8
        arg1_2:setState({
            checked = false;
        })
    end
    local Checkbox_upvr = require(script.Parent.Checkbox)
    function any_extend_result1.render(arg1_3) -- Line 13
        return Roact_upvr.createElement(Checkbox_upvr, {
            size = UDim2.new(0, 30, 0, 30);
            position = UDim2.new(0.25, 0, 0.5, 0);
            value = arg1_3.state.checked;
            onChecked = function(arg1_4) -- Line 18, Named "onChecked"
                local tbl = {}
                tbl.checked = arg1_4
                arg1_3:setState(tbl)
            end;
        })
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 27
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end