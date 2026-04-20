local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function tbl_upvr.new(arg1) -- Line 8
    local module = {}
    setmetatable(module, tbl_upvr)
    module._maid = Maid_upvr.new()
    module._obj = arg1
    return module
end
function tbl_upvr.SetValue(arg1, arg2) -- Line 17
    local Light = arg1._obj:FindFirstChild("Light")
    Light:FindFirstChildWhichIsA("Light", true).Enabled = arg2
    local var6
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var6 = Enum.Material.Neon
        return var6
    end
    if not arg2 or not decompInlinedCondition() then
        var6 = Enum.Material.SmoothPlastic
    end
    Light.Material = var6
end
function tbl_upvr.Destroy(arg1) -- Line 22
    arg1._maid = nil
    arg1._maid:Destroy()
    setmetatable(arg1, nil)
end
local module_2_upvr = {
    _enabled = false;
}
local Binder_upvr = require(ReplicatedStorage.Std.Binder)
function module_2_upvr.init() -- Line 31
    local any_new_result1 = Binder_upvr.new("Streetlight", tbl_upvr)
    module_2_upvr._binder = any_new_result1
    any_new_result1:GetClassAddedSignal():Connect(function(arg1) -- Line 34
        arg1:SetValue(module_2_upvr._enabled)
    end)
    any_new_result1:Start()
end
function module_2_upvr.SetEnabled(arg1) -- Line 39
    module_2_upvr._enabled = arg1
    for _, v in ipairs(module_2_upvr._binder:GetAll()) do
        if v.SetValue then
            v:SetValue(arg1)
        end
        wait(math.random() * 0.1)
    end
end
function module_2_upvr.Flicker() -- Line 48
    for _ = 1, 10 do
        local var26 = not true
        for _, v_2 in ipairs(module_2_upvr._binder:GetAll()) do
            v_2:SetValue(var26)
        end
        wait(0.2)
    end
    for _, v_3 in ipairs(module_2_upvr._binder:GetAll()) do
        v_3:SetValue(module_2_upvr._enabled)
    end
end
return module_2_upvr