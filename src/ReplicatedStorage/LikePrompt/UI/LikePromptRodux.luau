local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LikePrompt = require(script.Parent.LikePrompt)
local store = require(ReplicatedStorage.App.store)
local LikePromptConsts = require(ReplicatedStorage.LikePrompt.LikePromptConsts)
return require(ReplicatedStorage.RoactRodux).connect(function(p1, p2) --[[ Line: 7 ]]
	return p1.likePromptConfig
end, function(p1) --[[ Line: 9 | Upvalues: ReplicatedStorage (copy), LikePromptConsts (copy), store (copy) ]]
	return {
		onClickDone = function() --[[ Name: onClickDone | Line: 11 | Upvalues: ReplicatedStorage (ref), LikePromptConsts (ref), store (ref) ]]
			ReplicatedStorage:FindFirstChild(LikePromptConsts.LIKE_PROMPT_RESPONSE_REMOTE_NAME):FireServer(LikePromptConsts.RESPONSE_ENUM.Ok)
			store:dispatch({
				type = "setLikePromptConfig",
				visible = false
			})
		end,
		onExpired = function() --[[ Name: onExpired | Line: 19 | Upvalues: ReplicatedStorage (ref), LikePromptConsts (ref), store (ref) ]]
			ReplicatedStorage:FindFirstChild(LikePromptConsts.LIKE_PROMPT_RESPONSE_REMOTE_NAME):FireServer(LikePromptConsts.RESPONSE_ENUM.RemindMeLater)
			store:dispatch({
				type = "setLikePromptConfig",
				visible = false
			})
		end
	}
end)(LikePrompt)