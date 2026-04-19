-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:54
-- Luau version 6, Types version 3
-- Time taken: 0.004159 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local StreamingHelperUtils_upvr = require(ReplicatedStorage.App.StreamingHelperUtils)
local TableUtils_upvr = require(ReplicatedStorage.Std.TableUtils)
function module_upvr.new(arg1) -- Line 11
    --[[ Upvalues[4]:
        [1]: BaseObject_upvr (readonly)
        [2]: module_upvr (readonly)
        [3]: StreamingHelperUtils_upvr (readonly)
        [4]: TableUtils_upvr (readonly)
    ]]
    local any_new_result1_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_upvr, module_upvr)
    local var7_upvw = 0
    local var8_upvw
    local function _() -- Line 16, Named "update"
        --[[ Upvalues[6]:
            [1]: var7_upvw (read and write)
            [2]: var8_upvw (read and write)
            [3]: StreamingHelperUtils_upvr (copied, readonly)
            [4]: arg1 (readonly)
            [5]: TableUtils_upvr (copied, readonly)
            [6]: any_new_result1_upvr (readonly)
        ]]
        local var9_upvr = var7_upvw + 1
        var7_upvw = var9_upvr
        if var8_upvw then
            task.cancel(var8_upvw)
            var8_upvw = nil
        end
        var8_upvw = task.delay(0.1, function() -- Line 23
            --[[ Upvalues[6]:
                [1]: var9_upvr (readonly)
                [2]: var7_upvw (copied, read and write)
                [3]: StreamingHelperUtils_upvr (copied, readonly)
                [4]: arg1 (copied, readonly)
                [5]: TableUtils_upvr (copied, readonly)
                [6]: any_new_result1_upvr (copied, readonly)
            ]]
            if var9_upvr ~= var7_upvw then
            else
                StreamingHelperUtils_upvr.yieldForAllValuesPopulated(arg1)
                if var9_upvr ~= var7_upvw then return end
                any_new_result1_upvr.packet = TableUtils_upvr.createTableFromObjectValues(arg1)
            end
        end)
    end
    any_new_result1_upvr.maid:GiveTask(arg1.DescendantAdded:Connect(function(arg1_2) -- Line 35
        --[[ Upvalues[6]:
            [1]: var7_upvw (read and write)
            [2]: var8_upvw (read and write)
            [3]: StreamingHelperUtils_upvr (copied, readonly)
            [4]: arg1 (readonly)
            [5]: TableUtils_upvr (copied, readonly)
            [6]: any_new_result1_upvr (readonly)
        ]]
        if arg1_2:IsA("ValueBase") then
            local var12_upvr = var7_upvw + 1
            var7_upvw = var12_upvr
            if var8_upvw then
                task.cancel(var8_upvw)
                var8_upvw = nil
            end
            var8_upvw = task.delay(0.1, function() -- Line 23
                --[[ Upvalues[6]:
                    [1]: var12_upvr (readonly)
                    [2]: var7_upvw (copied, read and write)
                    [3]: StreamingHelperUtils_upvr (copied, readonly)
                    [4]: arg1 (copied, readonly)
                    [5]: TableUtils_upvr (copied, readonly)
                    [6]: any_new_result1_upvr (copied, readonly)
                ]]
                if var12_upvr ~= var7_upvw then
                else
                    StreamingHelperUtils_upvr.yieldForAllValuesPopulated(arg1)
                    if var12_upvr ~= var7_upvw then return end
                    any_new_result1_upvr.packet = TableUtils_upvr.createTableFromObjectValues(arg1)
                end
            end)
        end
    end))
    local var14_upvr = var7_upvw + 1
    var7_upvw = var14_upvr
    if var8_upvw then
        task.cancel(var8_upvw)
        var8_upvw = nil
    end
    var8_upvw = task.delay(0.1, function() -- Line 23
        --[[ Upvalues[6]:
            [1]: var14_upvr (readonly)
            [2]: var7_upvw (read and write)
            [3]: StreamingHelperUtils_upvr (copied, readonly)
            [4]: arg1 (readonly)
            [5]: TableUtils_upvr (copied, readonly)
            [6]: any_new_result1_upvr (readonly)
        ]]
        if var14_upvr ~= var7_upvw then
        else
            StreamingHelperUtils_upvr.yieldForAllValuesPopulated(arg1)
            if var14_upvr ~= var7_upvw then return end
            any_new_result1_upvr.packet = TableUtils_upvr.createTableFromObjectValues(arg1)
        end
    end)
    return any_new_result1_upvr
end
return require(ReplicatedStorage.Std.Binder).new("VehicleState", module_upvr)