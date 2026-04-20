local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local tbl_upvr = {"ACE", "RACER", "HENRY", "HARLEY", "ROMEO", "DAVE", "MAX", "ZEUS", "SCOOTER", "RUFUS", "OREO", "OSCAR", "ATHENA", "DAISY", "COCO", "LILY", "OLIVE", "WILLOW", "SIERRA", "MISTY", "LUCY", "LACEY", "GRACIE", "MOLLY"}
local module_upvr = {}
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Window_upvr = require(ReplicatedStorage_upvr.Module.Window.Window)
local GameUtil_upvr = require(ReplicatedStorage_upvr.Game.GameUtil)
function module_upvr.init() -- Line 40
    local AdoptionStandGui = ReplicatedStorage_upvr.StarterGui:FindFirstChild("AdoptionStandGui")
    AdoptionStandGui.Parent = LocalPlayer_upvr.PlayerGui
    module_upvr.gui = AdoptionStandGui
    local any_new_result1 = Window_upvr.new()
    any_new_result1:GetOnOpenedSignal():Connect(module_upvr._open)
    any_new_result1:GetOnClosedSignal():Connect(module_upvr._close)
    module_upvr._window = any_new_result1
    GameUtil_upvr.getCenterWindowGroup():Add(any_new_result1)
end
function module_upvr.setTitle(arg1) -- Line 51
    if arg1 == nil then
    else
    end
    assert(true)
    module_upvr.gui.Container.Right.Title.TextLabel.Text = arg1
end
function module_upvr.setImageId(arg1) -- Line 57
    if arg1 == nil then
    else
    end
    assert(true)
    module_upvr.gui.Container.Left.Icon.ImageLabel.Image = "rbxassetid://%d":format(arg1)
end
local Format_upvr = require(ReplicatedStorage_upvr.Module.Format)
function module_upvr.setPrice(arg1) -- Line 63
    local var10
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var10 = var10.Currency(arg1)
        var10 = Format_upvr
        return var10
    end
    if arg1 == nil or not decompInlinedCondition() then
        var10 = "FREE"
    end
    module_upvr.gui.Container.Right.Price.TextLabel.Text = var10
end
function module_upvr.setFirstAdopt(arg1) -- Line 68
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1 == nil then
    else
    end
    assert(true)
    if type(arg1) ~= "boolean" then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    assert(true)
    if arg1 then
    else
    end
    module_upvr.gui.Container.Right.Adopt.TextLabel.Text = "RE-ADOPT"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local Settings_upvr = require(ReplicatedStorage_upvr.Resource.Settings)
function module_upvr.setDescriptionTeam(arg1) -- Line 76
    local var12
    if arg1 == Settings_upvr.EnumTeam.Criminal then
        var12 = "criminal"
    elseif arg1 == Settings_upvr.EnumTeam.Police then
        var12 = "police"
    else
        error("Invalid teamId for `setDescriptionTeam`")
    end
    module_upvr.gui.Container.Right.Description.TextLabel.Text = "This breed does more damage when playing on the %s team!":format(var12)
end
function module_upvr.getName() -- Line 89
    local TextBox = module_upvr.gui.Container.Left.DogName.TextBox
    local Text = TextBox.Text
    if #Text == 0 then
        Text = TextBox.PlaceholderText:match("%w+")
    end
    if #Text == 0 then
        Text = nil
    end
    if Text then
        Text = Text:upper()
    end
    return Text
end
function module_upvr.setName(arg1) -- Line 104
    module_upvr.gui.Container.Left.DogName.TextBox.Text = arg1
end
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
function module_upvr._open() -- Line 109
    local var17_upvr
    if module_upvr._maid ~= nil then
        var17_upvr = false
    else
        var17_upvr = true
    end
    assert(var17_upvr)
    local any_new_result1_2 = Maid_upvr.new()
    var17_upvr = module_upvr
    var17_upvr._maid = any_new_result1_2
    var17_upvr = module_upvr
    var17_upvr = var17_upvr.gui
    var17_upvr.Enabled = true
    any_new_result1_2:GiveTask(function() -- Line 116
        var17_upvr.Enabled = false
    end)
    local TextBox_2_upvr = var17_upvr.Container.Left.DogName.TextBox
    any_new_result1_2:GiveTask(TextBox_2_upvr:GetPropertyChangedSignal("Text"):Connect(function() -- Line 121
        local Text_2 = TextBox_2_upvr.Text
        if 10 < #Text_2 then
            Text_2 = Text_2:sub(1, 10)
        end
        TextBox_2_upvr.Text = Text_2
    end))
    local var24_upvw = 0
    local var25_upvr = tbl_upvr[math.random(1, #tbl_upvr)]
    any_new_result1_2:GiveTask(Interval_upvr.every(0.5):Connect(function() -- Line 130
        var24_upvw = var24_upvw % 3 + 1
        TextBox_2_upvr.PlaceholderText = "%s%s":format(var25_upvr, '.':rep(var24_upvw))
    end))
    any_new_result1_2:GiveTask(var17_upvr.Container.Close.MouseButton1Down:Connect(function() -- Line 135
        module_upvr.close()
    end))
end
function module_upvr._close() -- Line 139
    local var27
    if module_upvr._maid == nil then
        var27 = false
    else
        var27 = true
    end
    assert(var27)
    var27 = module_upvr
    var27._maid = nil
    var27 = module_upvr._maid:Destroy
    var27()
end
function module_upvr.open() -- Line 145
    module_upvr._window:Open()
end
function module_upvr.close() -- Line 148
    module_upvr._window:Close()
end
function module_upvr.isOpen() -- Line 151
    return module_upvr._window:IsOpen()
end
function module_upvr.getOnClosedSignal() -- Line 154
    return module_upvr._window:GetOnClosedSignal()
end
function module_upvr.getOnClickAdoptSignal() -- Line 157
    return module_upvr.gui.Container.Right.Adopt.MouseButton1Down
end
return module_upvr