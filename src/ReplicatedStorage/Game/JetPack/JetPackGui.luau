local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Animation_upvr = require(ReplicatedStorage_upvr.Module.Animation)
local function _(arg1) -- Line 13, Named "Ease_InOutQuad"
    local var3
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var3 = 2 * arg1 * arg1
        return var3
    end
    if arg1 >= 0.5 or not decompInlinedCondition() then
        var3 = -1 - 2 * (arg1 - 2) * arg1
    end
    return var3
end
local EzUtils_upvr = require(ReplicatedStorage_upvr.EzUi.EzUtils)
local function _(arg1) -- Line 19, Named "SelectIfGamepad"
    EzUtils_upvr.selectIfGamepad(arg1)
end
local module_upvr = {
    OnRefillClicked = require(ReplicatedStorage_upvr.Std.Signal).new();
    MaxFuel = 10;
    Fuel = module_upvr.MaxFuel;
}
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function module_upvr.Init() -- Line 27
    local clone_upvw = ReplicatedStorage_upvr.Resource.JetPack.JetPackGui:Clone()
    clone_upvw.Parent = LocalPlayer_upvr.PlayerGui
    clone_upvw.Refill.Exit.MouseButton1Down:Connect(function() -- Line 32
        clone_upvw.Refill.Visible = false
    end)
    clone_upvw.Refill.Left.Buy.MouseButton1Down:Connect(function() -- Line 35
        module_upvr.OnRefillClicked:Fire("Standard")
        clone_upvw.Refill.Visible = false
    end)
    clone_upvw.Refill.Right.Buy.MouseButton1Down:Connect(function() -- Line 39
        module_upvr.OnRefillClicked:Fire("Rocket")
        clone_upvw.Refill.Visible = false
    end)
    clone_upvw.Fuel.Refill.MouseButton1Down:Connect(function() -- Line 43
        module_upvr.OnRefillClicked:Fire("Standard")
    end)
    module_upvr.Gui = clone_upvw
end
function module_upvr.OpenFuel() -- Line 56
    local Gui_upvr = module_upvr.Gui
    if module_upvr.AnimFuel then
        module_upvr.AnimFuel:Destroy()
        module_upvr.AnimFuel = nil
    end
    Gui_upvr.Fuel.Meter.Visible = true
    Gui_upvr.Fuel.Meter.BackgroundTransparency = 1
    Gui_upvr.Fuel.Meter.Value.BackgroundTransparency = 1
    local tbl_3 = {
        Duration = 0.5;
    }
    local function OnUpdate(arg1, arg2, arg3) -- Line 69
        local var14 = arg3
        local var15
        local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var15 = 2 * var14 * var14
            return var15
        end
        if var14 >= 0.5 or not decompInlinedCondition_2() then
            var15 = -1 - 2 * (var14 - 2) * var14
        end
        Gui_upvr.Fuel.Meter.Value.Size = UDim2.new(var15 * module_upvr.Fuel / module_upvr.MaxFuel, 0, 1, 0)
        Gui_upvr.Fuel.Meter.BackgroundTransparency = 1 - var15
        Gui_upvr.Fuel.Meter.Value.BackgroundTransparency = 1 - var15
    end
    tbl_3.OnUpdate = OnUpdate
    local function OnComplete() -- Line 75
        module_upvr.AnimFuel = nil
    end
    tbl_3.OnComplete = OnComplete
    module_upvr.AnimFuel = Animation_upvr.new(tbl_3)
end
function module_upvr.CloseFuel() -- Line 80
    local Gui_upvr_2 = module_upvr.Gui
    if module_upvr.AnimFuel then
        module_upvr.AnimFuel:Destroy()
        module_upvr.AnimFuel = nil
    end
    local tbl = {
        Duration = 0.5;
    }
    local function OnUpdate(arg1, arg2, arg3) -- Line 89
        local var18 = arg3
        local var19
        local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var19 = 2 * var18 * var18
            return var19
        end
        if var18 >= 0.5 or not decompInlinedCondition_3() then
            var19 = -1 - 2 * (var18 - 2) * var18
        end
        local var20 = 1 - var19
        var19 = Gui_upvr_2
        var19 = var19.Fuel
        var19 = var19.Meter
        var19.BackgroundTransparency = 1 - var20
        var19 = Gui_upvr_2
        var19 = var19.Fuel
        var19 = var19.Meter
        var19 = var19.Value
        var19.BackgroundTransparency = 1 - var20
    end
    tbl.OnUpdate = OnUpdate
    local function OnComplete() -- Line 95
        Gui_upvr_2.Fuel.Meter.Visible = false
        module_upvr.AnimFuel = nil
    end
    tbl.OnComplete = OnComplete
    module_upvr.AnimFuel = Animation_upvr.new(tbl)
end
function module_upvr.IsFuelAnimating() -- Line 101
    local var21
    if module_upvr.AnimFuel == nil then
        var21 = false
    else
        var21 = true
    end
    return var21
end
function module_upvr.IsFuelOpen() -- Line 104
    return module_upvr.Gui.Fuel.Meter.Visible
end
function module_upvr.UpdateFuel(arg1, arg2) -- Line 107
    assert(arg1)
    assert(arg2)
    if module_upvr.AnimFuel then
        module_upvr.Fuel = arg1
        module_upvr.MaxFuel = arg2
    elseif 0.0001 < math.abs(arg1 - module_upvr.Fuel) then
        module_upvr.Fuel = arg1
        module_upvr.MaxFuel = arg2
        module_upvr.Gui.Fuel.Meter.Value.Size = UDim2.new(module_upvr.Fuel / module_upvr.MaxFuel, 0, 1, 0)
    end
end
local JetPackUtil_upvr = require(ReplicatedStorage_upvr.Game.JetPack.JetPackUtil)
function module_upvr.SetFuelType(arg1) -- Line 119
    assert(arg1)
    local var23 = JetPackUtil_upvr.Fuel[arg1]
    assert(var23)
    module_upvr.Gui.Fuel.Meter.Value.BackgroundColor3 = var23.MeterColor
end
function module_upvr.FlashRefill() -- Line 126
    if module_upvr.FlashRefillOpen == true then
    else
        module_upvr.FlashRefillOpen = true
        local Gui_upvr_3 = module_upvr.Gui
        Gui_upvr_3.Fuel.Refill.Visible = true
        Gui_upvr_3.Fuel.Refill.Transparency = 1
        local tbl_2 = {
            Duration = 0.5;
        }
        local function OnUpdate(arg1, arg2, arg3) -- Line 135
            local var26
            local function decompInlinedCondition_4() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var26 = 2 * arg3 * arg3
                return var26
            end
            if arg3 >= 0.5 or not decompInlinedCondition_4() then
                var26 = -1 - 2 * (arg3 - 2) * arg3
            end
            Gui_upvr_3.Fuel.Refill.Transparency = 1 - var26
        end
        tbl_2.OnUpdate = OnUpdate
        Animation_upvr.new(tbl_2)
        task.delay(3, function() -- Line 139
            Animation_upvr.new({
                Duration = 0.5;
                OnUpdate = function(arg1, arg2, arg3) -- Line 141, Named "OnUpdate"
                    local var29
                    local function decompInlinedCondition_5() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                        var29 = 2 * arg3 * arg3
                        return var29
                    end
                    if arg3 >= 0.5 or not decompInlinedCondition_5() then
                        var29 = -1 - 2 * (arg3 - 2) * arg3
                    end
                    Gui_upvr_3.Fuel.Refill.Transparency = var29
                end;
                OnComplete = function() -- Line 144, Named "OnComplete"
                    Gui_upvr_3.Fuel.Refill.Visible = false
                    module_upvr.FlashRefillOpen = false
                end;
            })
        end)
    end
end
return module_upvr