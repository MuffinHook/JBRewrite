-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local store = require(ReplicatedStorage.App.store)
local LikePromptConsts = require(script.Parent.LikePromptConsts)
return {
	init = function()
		ReplicatedStorage:WaitForChild(LikePromptConsts.SHOW_LIKE_PROMPT_REMOTE_NAME).OnClientEvent:Connect(function()
			store:dispatch({
				type = "setLikePromptConfig",
				visible = true,
				countdownTil = workspace:GetServerTimeNow() + LikePromptConsts.LIKE_PROMPT_VISIBLE_TIME
			})
		end)
	end
}
