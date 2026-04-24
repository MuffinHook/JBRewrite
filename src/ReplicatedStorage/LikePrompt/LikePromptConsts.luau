-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Enumer = require(ReplicatedStorage.Std.Enumer)
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	CASH_EARNED_TRIGGER_AMOUNT = 25000,
	SHOW_LIKE_PROMPT_REMOTE_NAME = "ShowLikePrompt",
	LIKE_PROMPT_RESPONSE_REMOTE_NAME = "LikePromptResponse",
	RESPONSE_ENUM = Enumer({ "Ok", "RemindMeLater" }),
	LIKE_PROMPT_VISIBLE_TIME = 30
})
