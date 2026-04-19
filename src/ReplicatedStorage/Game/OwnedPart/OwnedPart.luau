-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:38:19
-- Luau version 6, Types version 3
-- Time taken: 0.003131 seconds

local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local module_upvr_2 = {}
module_upvr_2.__index = module_upvr_2
module_upvr_2.__ClassName = "OwnedPart"
local OwnedPartConsts_upvr = require(script.Parent.OwnedPartConsts)
function module_upvr_2.new(arg1) -- Line 12
    --[[ Upvalues[4]:
        [1]: module_upvr_2 (readonly)
        [2]: Maid_upvr (readonly)
        [3]: OwnedPartConsts_upvr (readonly)
        [4]: Signal_upvr (readonly)
    ]]
    local module_upvr = {}
    setmetatable(module_upvr, module_upvr_2)
    module_upvr._maid = Maid_upvr.new()
    module_upvr._obj = arg1
    module_upvr._networkOwnerIdValue = arg1:WaitForChild(OwnedPartConsts_upvr.NETWORK_OWNER_ID_VALUE_NAME)
    module_upvr._maid:GiveTask(module_upvr._networkOwnerIdValue.Changed:Connect(function() -- Line 19
        --[[ Upvalues[1]:
            [1]: module_upvr (readonly)
        ]]
        module_upvr:_onOwnerChanged()
    end))
    module_upvr._onOwned = Signal_upvr.new()
    return module_upvr
end
function module_upvr_2.GetOnOwnedSignal(arg1) -- Line 26
    --[[ Upvalues[1]:
        [1]: Signal_upvr (readonly)
    ]]
    local _onOwned = arg1._onOwned
    if not _onOwned then
        _onOwned = Signal_upvr.new()
        arg1._onOwned = _onOwned
    end
    return _onOwned
end
local LocalPlayer_upvr = Players_upvr.LocalPlayer
function module_upvr_2._onOwnerChanged(arg1) -- Line 34
    --[[ Upvalues[2]:
        [1]: LocalPlayer_upvr (readonly)
        [2]: Maid_upvr (readonly)
    ]]
    -- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [17] 12. Error Block 3 start (CF ANALYSIS FAILED)
    arg1._onOwned:Fire(arg1._maid.ownerMaid)
    do
        return
    end
    -- KONSTANTERROR: [17] 12. Error Block 3 end (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [27] 18. Error Block 4 start (CF ANALYSIS FAILED)
    arg1._maid.ownerMaid = nil
    -- KONSTANTERROR: [27] 18. Error Block 4 end (CF ANALYSIS FAILED)
end
function module_upvr_2.GetOwner(arg1) -- Line 45
    --[[ Upvalues[1]:
        [1]: Players_upvr (readonly)
    ]]
    return Players_upvr:GetPlayerByUserId(arg1._networkOwnerIdValue.Value)
end
function module_upvr_2.Destroy(arg1) -- Line 50
    arg1._maid = nil
    arg1._maid:Destroy()
end
return module_upvr_2