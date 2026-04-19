-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:41
-- Luau version 6, Types version 3
-- Time taken: 0.002147 seconds

local BaseObject_upvr = require(game:GetService("ReplicatedStorage").Std.BaseObject)
local Part_upvr = Instance.new("Part")
Part_upvr.Name = "TracerRoot"
Part_upvr.Anchored = true
Part_upvr.CFrame = CFrame.new(0, 0, 0)
Part_upvr.CanCollide = false
Part_upvr.Transparency = 1
Part_upvr.Parent = workspace
local Folder_upvr = Instance.new("Folder")
Folder_upvr.Name = "TracerLines"
Folder_upvr.Parent = workspace
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
function module_upvr.new() -- Line 19
    --[[ Upvalues[2]:
        [1]: BaseObject_upvr (readonly)
        [2]: module_upvr (readonly)
    ]]
    local any_new_result1 = BaseObject_upvr.new()
    setmetatable(any_new_result1, module_upvr)
    any_new_result1:_setup()
    any_new_result1:SetColor(Color3.fromRGB(255, 235, 141))
    return any_new_result1
end
function module_upvr.SetColor(arg1, arg2) -- Line 28
    arg1.lineHandle.Color3 = arg2
end
function module_upvr.SetThickness(arg1, arg2) -- Line 31
    arg1.lineHandle.Thickness = arg2
end
function module_upvr._setup(arg1) -- Line 34
    --[[ Upvalues[2]:
        [1]: Part_upvr (readonly)
        [2]: Folder_upvr (readonly)
    ]]
    local LineHandleAdornment = Instance.new("LineHandleAdornment")
    LineHandleAdornment.Adornee = Part_upvr
    LineHandleAdornment.Transparency = 0.1
    LineHandleAdornment.Thickness = 2
    LineHandleAdornment.SizeRelativeOffset = Vector3.new(0, 0, 0)
    LineHandleAdornment.Length = 0
    LineHandleAdornment.CFrame = CFrame.new()
    LineHandleAdornment.Parent = Folder_upvr
    arg1.maid:GiveTask(LineHandleAdornment)
    arg1.lineHandle = LineHandleAdornment
end
function module_upvr.Draw(arg1, arg2, arg3) -- Line 46
    arg1.lineHandle.Length = (arg3 - arg2).Magnitude
    arg1.lineHandle.CFrame = CFrame.lookAt(arg2, arg3)
end
return module_upvr