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
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var13 = Enum.Material.Neon
        return var13
    end
    if not arg1.Enabled or not decompInlinedCondition() then
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