local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local LikePromptConsts_upvr = require(ReplicatedStorage_upvr.LikePrompt.LikePromptConsts)
local store_upvr = require(ReplicatedStorage_upvr.App.store)
return require(ReplicatedStorage_upvr.RoactRodux).connect(function(arg1, arg2) -- Line 7
    return arg1.likePromptConfig
end, function(arg1) -- Line 9
    return {
        onClickDone = function() -- Line 11, Named "onClickDone"
            ReplicatedStorage_upvr:FindFirstChild(LikePromptConsts_upvr.LIKE_PROMPT_RESPONSE_REMOTE_NAME):FireServer(LikePromptConsts_upvr.RESPONSE_ENUM.Ok)
            store_upvr:dispatch({
                type = "setLikePromptConfig";
                visible = false;
            })
        end;
        onExpired = function() -- Line 19, Named "onExpired"
            ReplicatedStorage_upvr:FindFirstChild(LikePromptConsts_upvr.LIKE_PROMPT_RESPONSE_REMOTE_NAME):FireServer(LikePromptConsts_upvr.RESPONSE_ENUM.RemindMeLater)
            store_upvr:dispatch({
                type = "setLikePromptConfig";
                visible = false;
            })
        end;
    }
end)(require(script.Parent.LikePrompt))