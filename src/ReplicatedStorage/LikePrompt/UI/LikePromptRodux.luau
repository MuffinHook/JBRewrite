local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LikePrompt = require(script.Parent.LikePrompt)
local store = require(ReplicatedStorage.App.store)
local LikePromptConsts = require(ReplicatedStorage.LikePrompt.LikePromptConsts)
return require(ReplicatedStorage.RoactRodux).connect(function(state, _dispatch)
	return state.likePromptConfig
end, function(dispatch)
	return {
		onClickDone = function()
			ReplicatedStorage:FindFirstChild(LikePromptConsts.LIKE_PROMPT_RESPONSE_REMOTE_NAME):FireServer(LikePromptConsts.RESPONSE_ENUM.Ok)
			store:dispatch({
				type = "setLikePromptConfig",
				visible = false
			})
		end,
		onExpired = function()
			ReplicatedStorage:FindFirstChild(LikePromptConsts.LIKE_PROMPT_RESPONSE_REMOTE_NAME):FireServer(LikePromptConsts.RESPONSE_ENUM.RemindMeLater)
			store:dispatch({
				type = "setLikePromptConfig",
				visible = false
			})
		end
	}
end)(LikePrompt)
