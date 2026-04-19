-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:15
-- Luau version 6, Types version 3
-- Time taken: 0.003369 seconds

local Basic_upvr = require(script.Parent.Basic)
local tbl_upvr = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(1, 1, -1.5);
                ItemRotation = Vector3.new();
                NeckRotation = Vector3.new();
                WaistRotation = Vector3.new();
            };
        };
        RightWristRotation = CFrame.Angles(0, (math.pi/2), 0);
        LeftWristRotation = CFrame.new();
    };
}
local var6_upvw
local module_upvr = {
    __ClassName = "Glider";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Basic_upvr)
function module_upvr.Init(arg1) -- Line 25
    --[[ Upvalues[1]:
        [1]: var6_upvw (read and write)
    ]]
    var6_upvw = arg1.Event
end
function module_upvr.new(arg1, arg2, arg3) -- Line 28
    --[[ Upvalues[3]:
        [1]: Basic_upvr (readonly)
        [2]: tbl_upvr (readonly)
        [3]: module_upvr (readonly)
    ]]
    local any_new_result1 = Basic_upvr.new(arg1, arg2, tbl_upvr, arg3)
    setmetatable(any_new_result1, module_upvr)
    return any_new_result1
end
function module_upvr.GetLeftArmPosition(arg1) -- Line 34
    return nil
end
function module_upvr.ShootBegin(arg1, arg2) -- Line 37
    --[[ Upvalues[1]:
        [1]: var6_upvw (read and write)
    ]]
    var6_upvw:FireServer('l'.."".."ov5qey3":sub(2, 3):reverse().."".."".."rvu54akg":sub(3, 5):reverse():reverse():reverse().."".."54")
end
function module_upvr.InputBegan(arg1, arg2, arg3) -- Line 40
    --[[ Upvalues[1]:
        [1]: Basic_upvr (readonly)
    ]]
    local var10 = true
    if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
        var10 = false
        if arg2.UserInputType == Enum.UserInputType.Gamepad1 then
            if arg2.KeyCode ~= Enum.KeyCode.ButtonR2 then
                var10 = false
            else
                var10 = true
            end
        end
    end
    if var10 then
        arg1:ShootBegin(arg2)
    end
    Basic_upvr.InputBegan(arg1, arg2, arg3)
end
function module_upvr.InputEnded(arg1) -- Line 50
end
return module_upvr