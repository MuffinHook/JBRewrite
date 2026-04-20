local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local LikePromptConsts_upvr = require(script.Parent.LikePromptConsts)
local store_upvr = require(ReplicatedStorage_upvr.App.store)
function module.init() -- Line 7
    ReplicatedStorage_upvr:WaitForChild(LikePromptConsts_upvr.SHOW_LIKE_PROMPT_REMOTE_NAME).OnClientEvent:Connect(function() -- Line 9
        store_upvr:dispatch({
            type = "setLikePromptConfig";
            visible = true;
            countdownTil = workspace:GetServerTimeNow() + LikePromptConsts_upvr.LIKE_PROMPT_VISIBLE_TIME;
        })
    end)
end
return module