local Roact_upvr = require(game:GetService("ReplicatedStorage").Roact)
local createElement_upvr = Roact_upvr.createElement
return function(arg1) -- Line 5
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 8
        arg1_2:setState({
            visible = true;
        })
    end
    local LikePrompt_upvr = require(script.Parent.LikePrompt)
    function any_extend_result1.render(arg1_3) -- Line 13
        return createElement_upvr(LikePrompt_upvr, {
            visible = arg1_3.state.visible;
            countdownTil = workspace:GetServerTimeNow() + 20;
            onClickDone = function() -- Line 17, Named "onClickDone"
                print("clicked done..")
                arg1_3:setState({
                    visible = false;
                })
            end;
            onExpired = function() -- Line 23, Named "onExpired"
                print("expired..")
                arg1_3:setState({
                    visible = false;
                })
            end;
        })
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 31
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 34
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end