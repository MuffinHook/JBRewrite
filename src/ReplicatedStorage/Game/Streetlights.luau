-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:40
-- Luau version 6, Types version 3
-- Time taken: 0.003964 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function tbl_upvr.new(arg1) -- Line 8
    --[[ Upvalues[2]:
        [1]: tbl_upvr (readonly)
        [2]: Maid_upvr (readonly)
    ]]
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
    local function INLINED() -- Internal function, doesn't exist in bytecode
        var6 = Enum.Material.Neon
        return var6
    end
    if not arg2 or not INLINED() then
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
    --[[ Upvalues[3]:
        [1]: Binder_upvr (readonly)
        [2]: tbl_upvr (readonly)
        [3]: module_2_upvr (readonly)
    ]]
    local any_new_result1 = Binder_upvr.new("Streetlight", tbl_upvr)
    module_2_upvr._binder = any_new_result1
    any_new_result1:GetClassAddedSignal():Connect(function(arg1) -- Line 34
        --[[ Upvalues[1]:
            [1]: module_2_upvr (copied, readonly)
        ]]
        arg1:SetValue(module_2_upvr._enabled)
    end)
    any_new_result1:Start()
end
function module_2_upvr.SetEnabled(arg1) -- Line 39
    --[[ Upvalues[1]:
        [1]: module_2_upvr (readonly)
    ]]
    module_2_upvr._enabled = arg1
    for _, v in ipairs(module_2_upvr._binder:GetAll()) do
        if v.SetValue then
            v:SetValue(arg1)
        end
        wait(math.random() * 0.1)
    end
end
function module_2_upvr.Flicker() -- Line 48
    --[[ Upvalues[1]:
        [1]: module_2_upvr (readonly)
    ]]
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