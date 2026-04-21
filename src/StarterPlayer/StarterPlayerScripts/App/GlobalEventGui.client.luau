local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GlobalEventGui_upvr = ReplicatedStorage.App.Res:FindFirstChild("GlobalEventGui")
GlobalEventGui_upvr.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local DialogueContainer_upvr = GlobalEventGui_upvr:FindFirstChild("DialogueContainer")
local Sound_upvr = Instance.new("Sound")
Sound_upvr.SoundId = "rbxassetid://215658476"
Sound_upvr.Parent = DialogueContainer_upvr
local function _(arg1) -- Line 21, Named "ThumbnailBust"
    return string.format("https://www.roblox.com/bust-thumbnail/image?width=420&height=420&format=png&userId=%d", arg1)
end
local var5_upvw = false
local tbl_upvr = {}
local function _() -- Line 27, Named "ProcessQueue"
    if 0 < #tbl_upvr then
        var5_upvw = true
        GlobalEventGui_upvr.Enabled = true
        Hook(table.remove(tbl_upvr, 1))
    else
        var5_upvw = false
        GlobalEventGui_upvr.Enabled = false
    end
end
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local TypeWriteLabel_upvr = require(ReplicatedStorage.Game.TypeWriteLabel)
local Bio_upvr = GlobalEventGui_upvr:WaitForChild("DialogueContainer"):WaitForChild("Bio")
function Hook(arg1) -- Line 39
    Audio_upvr.ObjectLocal(GlobalEventGui_upvr, 4838933194, {
        Volume = 0.3;
        TimePosition = 0.15;
    })
    DialogueContainer_upvr.Icon.Icon.Image = ("https://www.roblox.com/bust-thumbnail/image?width=420&height=420&format=png&userId=%d"):format(arg1.UserId)
    TypeWriteLabel_upvr(arg1.Text, Bio_upvr, 18, function(arg1_2) -- Line 43
        if arg1_2 % 2 == 0 then
            Sound_upvr:Play()
        end
    end)
    local textLength = utf8.len(arg1.Text) or #arg1.Text
    task.wait(textLength / 18)
    task.wait(arg1.Duration)
    if 0 < #tbl_upvr then
        var5_upvw = true
        GlobalEventGui_upvr.Enabled = true
        Hook(table.remove(tbl_upvr, 1))
    else
        var5_upvw = false
        GlobalEventGui_upvr.Enabled = false
    end
end
require(ReplicatedStorage.Std.RxInstanceUtils).observeOneChildNamed(ReplicatedStorage, "GlobalEventRemote", function(arg1) -- Line 53
    arg1.OnClientEvent:Connect(function(arg1_3, arg2, arg3) -- Line 54
        local tbl = {}
        tbl.UserId = arg1_3
        tbl.Text = arg2
        tbl.Duration = arg3
        table.insert(tbl_upvr, tbl)
        if var5_upvw == false then
            if 0 < #tbl_upvr then
                var5_upvw = true
                GlobalEventGui_upvr.Enabled = true
                Hook(table.remove(tbl_upvr, 1))
                return
            end
            var5_upvw = false
            GlobalEventGui_upvr.Enabled = false
        end
    end)
end)
