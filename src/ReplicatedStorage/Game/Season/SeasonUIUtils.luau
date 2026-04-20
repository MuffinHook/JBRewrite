local Players_upvr = game:GetService("Players")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local SeasonConsts_upvr = require(ReplicatedStorage_upvr.Game.Season.SeasonConsts)
local RunUtils_upvr = require(ReplicatedStorage_upvr.App.RunUtils)
local SeasonUtils_upvr = require(ReplicatedStorage_upvr.Game.Season.SeasonUtils)
local Notification_upvr = require(ReplicatedStorage_upvr.Game.Notification)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local Settings_upvr = require(ReplicatedStorage_upvr.Resource.Settings)
function module.hookGiftContainer(arg1, arg2) -- Line 13
    local function _() -- Line 14, Named "clearInputs"
        arg1.ContainerIcon.Icon.Image = ""
        arg1.ContainerPlayerName.Text = ""
    end
    arg1.ContainerIcon.Icon.Image = ""
    arg1.ContainerPlayerName.Text = ""
    arg2:GiveTask(LocalPlayer_upvr:FindFirstChild(SeasonConsts_upvr.PLAYER_SEASON_PASS_GIFT_VALUES_FOLDER_NAME):FindFirstChild(SeasonConsts_upvr.PLAYER_ALLOWED_TO_ATTEMPT_SEASON_PASS_GIFT_FLAG_NAME).Changed:Connect(function(arg1_2) -- Line 25
        arg1.Visible = arg1_2
        return true
    end))
    arg2:GiveTask(arg1.PurchaseButton.MouseButton1Down:Connect(function() -- Line 30
        if not RunUtils_upvr.isStudio() and SeasonUtils_upvr.getRemainingTime() < 0 then
            Notification_upvr.new({
                Text = "Season is over! Wait until next season.";
            })
        else
            local var14 = 6105461542
            Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, var14)
            if Settings_upvr.getFirstProductByType("SeasonPass") == nil then
                var14 = false
            else
                var14 = true
            end
            assert(var14)
            local Text = arg1.ContainerPlayerName.Text
            if #Text == 0 then return end
            ReplicatedStorage_upvr:FindFirstChild(SeasonConsts_upvr.SEASON_PASS_GIFT_ATTEMPT_REMOTE_NAME):FireServer(Players_upvr:GetUserIdFromNameAsync(Text))
            arg1.ContainerIcon.Icon.Image = ""
            arg1.ContainerPlayerName.Text = ""
        end
    end))
    local var17_upvw = 0
    arg2:GiveTask(arg1.ContainerPlayerName:GetPropertyChangedSignal("Text"):Connect(function() -- Line 50
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        var17_upvw += 1
        local var18_upvw
        local Text_upvr = arg1.ContainerPlayerName.Text
        local function var19() -- Line 55
            var18_upvw = Players_upvr:GetUserIdFromNameAsync(Text_upvr)
        end
        local pcall_result1 = pcall(var19)
        var19 = nil
        local var22 = var19
        if pcall_result1 then
            local any_GetUserThumbnailAsync_result1, any_GetUserThumbnailAsync_result2 = Players_upvr:GetUserThumbnailAsync(var18_upvw, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size180x180)
            var22 = any_GetUserThumbnailAsync_result1
            pcall_result1 = any_GetUserThumbnailAsync_result2
        end
        if var17_upvw ~= var17_upvw then
            return false
        end
        if not pcall_result1 or not var22 then
        end
        arg1.ContainerIcon.Icon.Image = ""
    end))
end
return module