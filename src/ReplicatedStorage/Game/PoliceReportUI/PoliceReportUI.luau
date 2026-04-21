local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_upvr = {}
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function module_upvr.Init() -- Line 8
    local PoliceReportGui = ReplicatedStorage_upvr.StarterGui:FindFirstChild("PoliceReportGui")
    PoliceReportGui.Parent = LocalPlayer_upvr.PlayerGui
    module_upvr.Gui = PoliceReportGui
end
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local Math_upvr = require(ReplicatedStorage_upvr.Module.Math)
function module_upvr.Display(arg1) -- Line 15
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var15
    if module_upvr.IsOpen() then
        module_upvr.Hide()
    end
    local Gui = module_upvr.Gui
    local any_new_result1_upvr = Maid_upvr.new()
    var15 = module_upvr
    var15.Maid = any_new_result1_upvr
    var15 = 0
    for i, v in ipairs(arg1) do
        local assert_result1 = assert(v.Amount)
        local var23
        if type(assert_result1) ~= "number" then
            var23 = false
        else
            var23 = true
        end
        assert(var23)
        local SubTitle = v.SubTitle
        var23 = Gui.Container.Top.List.Preset:Clone()
        var23.LayoutOrder = i
        var23.Parent = Gui.Container.Top.List
        var23.Title.Text = assert(v.Title)
        var23.Amount.Text = Math_upvr.FormatMoney(assert_result1)
        if SubTitle ~= nil then
            var23.SubTitle.Text = SubTitle
        end
        if SubTitle == nil then
        else
        end
        var23.SubTitle.Visible = true
        var23.Visible = true
        any_new_result1_upvr:GiveTask(var23)
        var15 += assert_result1
    end
    Gui.Container.Bottom.Container.Sum.Text = string.format("+%s", Math_upvr.FormatMoney(var15))
    any_new_result1_upvr:GiveTask(Gui.Container.Close.MouseButton1Down:Connect(function() -- Line 51
        module_upvr.Hide()
    end))
    Gui.Enabled = true
    delay(5, function() -- Line 57
        if any_new_result1_upvr == module_upvr.Maid then
            module_upvr.Hide()
        end
    end)
end
function module_upvr.Hide() -- Line 63
    if module_upvr.IsOpen() then
        module_upvr.Maid:Destroy()
        module_upvr.Maid = nil
        module_upvr.Gui.Enabled = false
    end
end
function module_upvr.IsOpen() -- Line 72
    local var27
    if module_upvr.Maid == nil then
        var27 = false
    else
        var27 = true
    end
    return var27
end
return module_upvr