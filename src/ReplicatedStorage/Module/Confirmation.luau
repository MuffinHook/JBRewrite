local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local EzUtils_upvr = require(ReplicatedStorage_upvr.EzUi.EzUtils)
local var3_upvw = false
local tbl_upvr = {}
local function _() -- Line 16, Named "ProcessQueue"
    if 0 < #tbl_upvr then
        var3_upvw = true
        table.remove(tbl_upvr, 1):Hook()
    else
        var3_upvw = false
    end
end
local function _(arg1) -- Line 26, Named "SelectIfGamepad"
    EzUtils_upvr.selectIfGamepad(arg1)
end
local module_upvr = {}
module_upvr.__index = module_upvr
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Localization_upvr = require(ReplicatedStorage_upvr.Module.Localization)
local GameUtil_upvr = require(ReplicatedStorage_upvr.Game.GameUtil)
local Settings_upvr = require(ReplicatedStorage_upvr.Resource.Settings)
function module_upvr.Init(arg1) -- Line 32
    local ConfirmationGui = ReplicatedStorage_upvr.StarterGui:FindFirstChild("ConfirmationGui")
    ConfirmationGui.Parent = LocalPlayer_upvr.PlayerGui
    module_upvr.Gui = ConfirmationGui
    ConfirmationGui.Confirmation.Background.ContainerButtons.ContainerYes.Button.Message.Text = Localization_upvr:FormatByKey("General.Yes")
    ConfirmationGui.Confirmation.Background.ContainerButtons.ContainerNo.Button.Message.Text = Localization_upvr:FormatByKey("General.No")
    arg1.em.pbvjmani = function(arg1_2, arg2) -- Line 43, Named "pbvjmani"
        local any_new_result1_upvw = module_upvr.new(arg1_2, arg2)
        any_new_result1_upvw.OnYes:Connect(function() -- Line 46
            any_new_result1_upvw = nil
        end)
        any_new_result1_upvw.OnNo:Connect(function() -- Line 49
            any_new_result1_upvw = nil
        end)
    end
    GameUtil_upvr.OnTeamChanged:Connect(function(arg1_3) -- Line 54
        module_upvr.SetColor(Settings_upvr.TeamColor[arg1_3])
    end)
    module_upvr.SetColor(Settings_upvr.TeamColor[GameUtil_upvr.Team])
end
function module_upvr.SetColor(arg1) -- Line 61
    local Gui = module_upvr.Gui
    Gui.Confirmation.Background.ImageColor3 = arg1
    Gui.Confirmation.Background.ContainerButtons.ContainerYes.Button.ImageColor3 = arg1
    Gui.Confirmation.Background.ContainerButtons.ContainerNo.Button.ImageColor3 = arg1
end
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local Signal_upvr = require(ReplicatedStorage_upvr.Std.Signal)
function module_upvr.new(arg1, arg2) -- Line 69
    local module = {}
    setmetatable(module, module_upvr)
    local var19 = false
    if arg2 ~= nil then
        var19 = arg2.SingleChoice
    end
    module.OptionSingleChoice = var19
    module.Maid = Maid_upvr.new()
    module.OnYes = Signal_upvr.new()
    module.Maid:GiveTask(module.OnYes)
    if not module.OptionSingleChoice then
        module.OnNo = Signal_upvr.new()
        module.Maid:GiveTask(module.OnNo)
    end
    module.Text = arg1
    table.insert(tbl_upvr, module)
    if var3_upvw == false then
        if 0 < #tbl_upvr then
            var3_upvw = true
            table.remove(tbl_upvr, 1):Hook()
            return module
        end
        var3_upvw = false
    end
    return module
end
function module_upvr.Hook(arg1) -- Line 93
    local Gui_2 = module_upvr.Gui
    Gui_2.Enabled = true
    Gui_2.Confirmation.Background.ContainerMessage.Message.Text = arg1.Text
    local Button = Gui_2.Confirmation.Background.ContainerButtons.ContainerYes.Button
    EzUtils_upvr.selectIfGamepad(Button)
    arg1.Maid:GiveTask(Button.MouseButton1Down:Connect(function() -- Line 100
        arg1.OnYes:Fire()
        arg1:Destroy()
    end))
    local ContainerNo = Gui_2.Confirmation.Background.ContainerButtons.ContainerNo
    ContainerNo.Visible = not arg1.OptionSingleChoice
    if not arg1.OptionSingleChoice then
        arg1.Maid:GiveTask(ContainerNo.Button.MouseButton1Down:Connect(function() -- Line 109
            arg1.OnNo:Fire()
            arg1:Destroy()
        end))
    end
end
function module_upvr.Destroy(arg1) -- Line 115
    if arg1.Maid ~= nil then
        module_upvr.Gui.Enabled = false
        arg1.Maid:Destroy()
        arg1.Maid = nil
        if 0 < #tbl_upvr then
            var3_upvw = true
            table.remove(tbl_upvr, 1):Hook()
            return
        end
        var3_upvw = false
    end
end
return module_upvr