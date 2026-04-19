-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:52
-- Luau version 6, Types version 3
-- Time taken: 0.003568 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var2_upvw
local module_upvr = {}
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function module_upvr.init() -- Line 9
    --[[ Upvalues[4]:
        [1]: module_upvr (readonly)
        [2]: var2_upvw (read and write)
        [3]: ReplicatedStorage_upvr (readonly)
        [4]: LocalPlayer_upvr (readonly)
    ]]
    local tbl = {}
    for i, v in pairs(require(script.Parent.DogConsts).ANIM_ID) do
        tbl[i] = {}
        for i_2, v_2 in pairs(v) do
            local Animation = Instance.new("Animation")
            Animation.AnimationId = "rbxassetid://%d":format(v_2)
            tbl[i][i_2] = Animation
        end
    end
    module_upvr._mapAnimInst = tbl
    var2_upvw = require(script.Parent.DogBinder)
    var2_upvw:Start()
    LocalPlayer_upvr.CharacterAdded:Connect(function(arg1) -- Line 28, Named "setupCharacter"
        --[[ Upvalues[2]:
            [1]: module_upvr (copied, readonly)
            [2]: ReplicatedStorage_upvr (copied, readonly)
        ]]
        module_upvr._petTrack = arg1:WaitForChild("Humanoid"):LoadAnimation(ReplicatedStorage_upvr.Resource.Dog.Anim.Pet)
    end)
    if LocalPlayer_upvr.Character then
        module_upvr._petTrack = LocalPlayer_upvr.Character:WaitForChild("Humanoid"):LoadAnimation(ReplicatedStorage_upvr.Resource.Dog.Anim.Pet)
    end
end
function module_upvr.getAnimInsts(arg1) -- Line 37
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    return module_upvr._mapAnimInst[arg1]
end
function module_upvr.getAll() -- Line 40
    --[[ Upvalues[1]:
        [1]: var2_upvw (read and write)
    ]]
    return var2_upvw:GetAll()
end
function module_upvr.getPetTrack() -- Line 43
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    return module_upvr._petTrack
end
return module_upvr