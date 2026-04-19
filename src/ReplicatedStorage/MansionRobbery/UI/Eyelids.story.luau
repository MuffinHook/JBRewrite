-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:01
-- Luau version 6, Types version 3
-- Time taken: 0.003026 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local function _(arg1) -- Line 7, Named "f"
    if arg1 / 2 % 1 < 0.5 then
        return arg1 % 1
    end
    return 1 - arg1 % 1
end
local Roact_upvr = require(ReplicatedStorage.Roact)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local RunService_upvr = game:GetService("RunService")
local TweenService_upvr = game:GetService("TweenService")
return function(arg1) -- Line 14
    --[[ Upvalues[4]:
        [1]: Roact_upvr (readonly)
        [2]: Maid_upvr (readonly)
        [3]: RunService_upvr (readonly)
        [4]: TweenService_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    function any_extend_result1.init(arg1_2) -- Line 17
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: Maid_upvr (copied, readonly)
        ]]
        local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(1)
        arg1_2.pctClosed = any_createBinding_result1
        arg1_2.updatePctClosed = any_createBinding_result2
        arg1_2.maid = Maid_upvr.new()
    end
    function any_extend_result1.didMount(arg1_3) -- Line 21
        --[[ Upvalues[2]:
            [1]: RunService_upvr (copied, readonly)
            [2]: TweenService_upvr (copied, readonly)
        ]]
        arg1_3.maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 22
            --[[ Upvalues[2]:
                [1]: arg1_3 (readonly)
                [2]: TweenService_upvr (copied, readonly)
            ]]
            local os_clock_result1 = os.clock()
            local var12
            if os_clock_result1 / 2 % 1 < 0.5 then
                var12 = os_clock_result1 % 1
            else
                var12 = 1 - os_clock_result1 % 1
            end
            arg1_3.updatePctClosed(TweenService_upvr:GetValue(var12, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))
        end))
    end
    function any_extend_result1.willUnmount(arg1_4) -- Line 28
        arg1_4.maid:DoCleaning()
    end
    local Eyelids_upvr = require(script.Parent.Eyelids)
    function any_extend_result1.render(arg1_5) -- Line 31
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: Eyelids_upvr (readonly)
        ]]
        return Roact_upvr.createElement(Eyelids_upvr, {
            pctClosed = arg1_5.pctClosed;
        })
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 38
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end