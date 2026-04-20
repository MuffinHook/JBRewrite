local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("App")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 11
    arg1.maid = Maid_upvr.new()
end
local createElement_upvr = Roact_upvr.createElement
local Eyelids_upvr = require(script.Parent.Eyelids)
local Subtitle_upvr = require(script.Parent.Subtitle)
function any_extend_result1.render(arg1) -- Line 14
    return Roact_upvr.createFragment({
        Eyelids = createElement_upvr(Eyelids_upvr, {
            pctClosed = arg1.props.pctClosed;
        });
        Subtitle = createElement_upvr(Subtitle_upvr, {
            text = arg1.props.dialogueText;
            charPerSecond = arg1.props.charPerSecond;
        });
    })
end
function any_extend_result1.didMount(arg1) -- Line 25
end
function any_extend_result1.willUnmount(arg1) -- Line 26
    arg1.maid:DoCleaning()
end
return require(ReplicatedStorage.RoactRodux).connect(function(arg1, arg2) -- Line 29
    return {
        dialogueText = arg1.dialogueText;
    }
end)(any_extend_result1)