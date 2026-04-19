-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:23
-- Luau version 6, Types version 3
-- Time taken: 0.002613 seconds

local Audio_upvr = require(game:GetService("ReplicatedStorage").Std.Audio)
local Gun_upvr = require(script.Parent.Gun)
local module_upvr = {
    __ClassName = "NerfPistol";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Gun_upvr)
function module_upvr.new(arg1, arg2, arg3) -- Line 11
    --[[ Upvalues[2]:
        [1]: Gun_upvr (readonly)
        [2]: module_upvr (readonly)
    ]]
    local any_new_result1 = Gun_upvr.new(arg1, arg2, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1.ApplySkin = false
    any_new_result1:Setup(arg3)
    return any_new_result1
end
function module_upvr.SetupBulletEmitter(arg1) -- Line 19
    --[[ Upvalues[1]:
        [1]: Gun_upvr (readonly)
    ]]
    Gun_upvr.SetupBulletEmitter(arg1)
    arg1.BulletEmitter.Color = Color3.fromRGB(253, 111, 24)
end
function module_upvr.ShootSound(arg1, arg2) -- Line 23
    --[[ Upvalues[1]:
        [1]: Audio_upvr (readonly)
    ]]
    if not arg2 then
        Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_pistol_shot_04, {
            Pitch = 1;
        })
        delay(0.1, function() -- Line 26
            --[[ Upvalues[2]:
                [1]: Audio_upvr (copied, readonly)
                [2]: arg1 (readonly)
            ]]
            Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_pistol_slide_fast_01, {
                Volume = 0.3;
                Pitch = 1 + math.random() * 0.1 - 0.05;
            })
        end)
    end
end
function module_upvr.ReloadDropAmmoSound(arg1) -- Line 35
    --[[ Upvalues[1]:
        [1]: Audio_upvr (readonly)
    ]]
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_pistol_remove_mag_01)
end
function module_upvr.ReloadRefillAmmoSound(arg1) -- Line 38
    --[[ Upvalues[1]:
        [1]: Audio_upvr (readonly)
    ]]
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_pistol_insert_mag_01, {
        RollOffMaxDistance = 129;
    })
    wait(0.4)
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.gun_pistol_slide_fast_01, {
        RollOffMaxDistance = 129;
    })
    wait(0.1)
end
return module_upvr