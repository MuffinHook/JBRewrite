-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:12
-- Luau version 6, Types version 3
-- Time taken: 0.003995 seconds

local Basic_upvr = require(script.Parent.Basic)
local tbl_upvr = {
    Motion = {
        Hip = {
            Springs = {
                ItemOffset = Vector3.new(0.69999, -0.5, 0);
                ItemRotation = Vector3.new();
                NeckRotation = Vector3.new();
                WaistRotation = Vector3.new();
            };
        };
        RightWristRotation = CFrame.new();
        LeftWristRotation = CFrame.new();
    };
}
local module_upvr = {
    __ClassName = "Flashlight";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Basic_upvr)
function module_upvr.new(arg1, arg2, arg3) -- Line 23
    --[[ Upvalues[3]:
        [1]: Basic_upvr (readonly)
        [2]: tbl_upvr (readonly)
        [3]: module_upvr (readonly)
    ]]
    local any_new_result1 = Basic_upvr.new(arg1, arg2, tbl_upvr, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1.Enabled = false
    any_new_result1.SpringItemOffset:SetTarget(Vector3.new(1, 0.60000, -1.5))
    return any_new_result1
end
function module_upvr.GetLeftArmPosition(arg1) -- Line 32
    return nil
end
function module_upvr.Toggle(arg1) -- Line 35
    arg1.Enabled = not arg1.Enabled
    local Model = arg1.Model
    local var13
    local function INLINED() -- Internal function, doesn't exist in bytecode
        var13 = Enum.Material.Neon
        return var13
    end
    if not arg1.Enabled or not INLINED() then
        var13 = Enum.Material.Plastic
    end
    Model.Model.Light.Material = var13
    for _, v in Model.Model:GetDescendants() do
        if v:IsA("SpotLight") then
            v.Enabled = arg1.Enabled
        end
    end
end
function module_upvr.InputBegan(arg1, arg2, arg3) -- Line 45
    --[[ Upvalues[1]:
        [1]: Basic_upvr (readonly)
    ]]
    local var18 = true
    if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
        var18 = false
        if arg2.UserInputType == Enum.UserInputType.Gamepad1 then
            if arg2.KeyCode ~= Enum.KeyCode.ButtonR2 then
                var18 = false
            else
                var18 = true
            end
        end
    end
    if var18 then
        arg1:Toggle()
        if arg1.Local then
            arg1:BroadcastInputBegan(arg2)
        end
    end
    Basic_upvr.InputBegan(arg1, arg2, arg3)
end
function module_upvr.InputEnded(arg1) -- Line 58
end
return module_upvr