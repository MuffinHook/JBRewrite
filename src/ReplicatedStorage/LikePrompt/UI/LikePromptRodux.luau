-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMZEGxpa2VQcm9tcHRDb25maWcgTElLRV9QUk9NUFRfUkVTUE9OU0VfUkVNT1RFX05BTUUORmluZEZpcnN0Q2hpbGQNUkVTUE9OU0VfRU5VTQJPawpGaXJlU2VydmVyBHR5cGUHdmlzaWJsZRNzZXRMaWtlUHJvbXB0Q29uZmlnCGRpc3BhdGNoC29uQ2xpY2tEb25lDVJlbWluZE1lTGF0ZXIJb25FeHBpcmVkBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBnNjcmlwdAZQYXJlbnQKTGlrZVByb21wdANBcHAFc3RvcmUQTGlrZVByb21wdENvbnN0cwpSb2FjdFJvZHV4B2Nvbm5lY3QABQMCAAAAAANNAgDSAAAAAIICAgABAwEABwABGAAAAAgAAAAABAADAAAAG/sAAAD7AgEATQICWQAAAAC8AAADAQAAAJ8AAwL7AgEATQICWgIAAABNAgIwAwAAALwAAGsEAAAAnwADAfsAAgDiAgcAbwMIADADAnEFAAAAqQMAADADAqAGAAAAvAAATAkAAACfAAMBggABAAoDAgMDAwQDBQMGAwcDCAUCBQYDCQMKAAsLARgAAAAAAAAAAQAAAAAAAAABAAEAAAEAAP4AAAQMAAAAAAQAAwAAABv7AAAA+wIBAE0CAlkAAAAAvAAAAwEAAACfAAMC+wIBAE0CAloCAAAATQICtgMAAAC8AABrBAAAAJ8AAwH7AAIA4gIHAG8DCAAwAwJxBQAAAKkDAAAwAwKgBgAAALwAAEwJAAAAnwADAYIAAQAKAwIDAwMEAwwDBgMHAwgFAgUGAwkDCgATDQEYAAAAAAAAAAEAAAAAAAAAAQABAAABAAD+AAAEFAAAAAADAQMAAAAO4gECAMACAwASAgAAEgIBABICAgAwAgFTAAAAAMACBAASAgAAEgIBABICAgAwAgFhAQAAAIIBAgAFAwsDDQUCAAEGAQYCAgECCQABGAABAAAAAAAIAAAAAAAACgAAAAAIAAABAgAuowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBApAIHAAAAYEBNAgIkCAAAAE0CAoYJAAAAnwECAqQCBQAAAEBATQMAwQoAAABNAwN+CwAAAJ8CAgKkAwUAAABAQE0EAIYJAAAATQQEhwwAAACfAwICpAQFAAAAQEBNBQAtDQAAAJ8EAgJNBQTnDgAAAMAGDwDABxAAEgAAABIAAwASAAIAnwUDAlIGAQCfBQIAggUAABEDDgQAAABAAw8DEAMRBAAAQEADEgQAAGBAAxMDFAMVAxYDFwMYAxkGAAYDAgADAQABGAAAAAAAAAABAAAAAAAAAAABAAAAAAAAAQAAAAAAAAEAAAAAAgAAAgAAAP4VAAABAAAAAAQLGKDQX/+hUZOgkGFaCYJDewC3pDncytE=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:51
-- Luau version 6, Types version 3
-- Time taken: 0.001604 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local LikePromptConsts_upvr = require(ReplicatedStorage_upvr.LikePrompt.LikePromptConsts)
local store_upvr = require(ReplicatedStorage_upvr.App.store)
return require(ReplicatedStorage_upvr.RoactRodux).connect(function(arg1, arg2) -- Line 7
    return arg1.likePromptConfig
end, function(arg1) -- Line 9
    --[[ Upvalues[3]:
        [1]: ReplicatedStorage_upvr (readonly)
        [2]: LikePromptConsts_upvr (readonly)
        [3]: store_upvr (readonly)
    ]]
    return {
        onClickDone = function() -- Line 11, Named "onClickDone"
            --[[ Upvalues[3]:
                [1]: ReplicatedStorage_upvr (copied, readonly)
                [2]: LikePromptConsts_upvr (copied, readonly)
                [3]: store_upvr (copied, readonly)
            ]]
            ReplicatedStorage_upvr:FindFirstChild(LikePromptConsts_upvr.LIKE_PROMPT_RESPONSE_REMOTE_NAME):FireServer(LikePromptConsts_upvr.RESPONSE_ENUM.Ok)
            store_upvr:dispatch({
                type = "setLikePromptConfig";
                visible = false;
            })
        end;
        onExpired = function() -- Line 19, Named "onExpired"
            --[[ Upvalues[3]:
                [1]: ReplicatedStorage_upvr (copied, readonly)
                [2]: LikePromptConsts_upvr (copied, readonly)
                [3]: store_upvr (copied, readonly)
            ]]
            ReplicatedStorage_upvr:FindFirstChild(LikePromptConsts_upvr.LIKE_PROMPT_RESPONSE_REMOTE_NAME):FireServer(LikePromptConsts_upvr.RESPONSE_ENUM.RemindMeLater)
            store_upvr:dispatch({
                type = "setLikePromptConfig";
                visible = false;
            })
        end;
    }
end)(require(script.Parent.LikePrompt))