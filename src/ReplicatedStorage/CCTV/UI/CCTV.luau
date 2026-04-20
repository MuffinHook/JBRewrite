local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Roact_upvr = require(ReplicatedStorage.Roact)
local CollectionService_upvr = game:GetService("CollectionService")
local function wipeTags_upvr(arg1) -- Line 12, Named "wipeTags"
    for _, v in ipairs(CollectionService_upvr:GetTags(arg1)) do
        CollectionService_upvr:RemoveTag(arg1, v)
    end
end
local function _(arg1) -- Line 18, Named "wipeTagsRecursively"
    wipeTags_upvr(arg1)
    for _, v_2 in ipairs(arg1:GetDescendants()) do
        wipeTags_upvr(v_2)
    end
end
local tbl_9_upvr = {}
tbl_9_upvr.__index = tbl_9_upvr
function tbl_9_upvr.new(arg1) -- Line 27
    local module_2 = {}
    setmetatable(module_2, tbl_9_upvr)
    module_2.character = arg1
    module_2._maid = Maid_upvr.new()
    module_2.onScreen = false
    module_2.lastOnScreenChanged = 0
    local Model_upvr = Instance.new("Model")
    local tbl_4_upvr = {}
    local function shouldCopy_upvr(arg1_2) -- Line 41, Named "shouldCopy"
        if arg1_2:IsA("BasePart") or arg1_2:IsA("Shirt") or arg1_2:IsA("Pants") or arg1_2:IsA("CharacterMesh") or arg1_2:IsA("WrapTarget") or arg1_2:IsA("Decal") or arg1_2:IsA("Accessory") or arg1_2:IsA("Humanoid") then
            return true
        end
        return false
    end
    local function copy_upvr(arg1_3, arg2) -- Line 56, Named "copy"
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local clone_3 = arg1_3:Clone()
        if not clone_3 then return end
        if arg1_3:IsA("CharacterAppearance") then
            local SOME_2 = arg2:FindFirstChild(clone_3.Name)
            if SOME_2 then
                tbl_4_upvr[SOME_2] = nil
                SOME_2:Destroy()
            end
        end
        clone_3:ClearAllChildren()
        clone_3.Parent = arg2
        wipeTags_upvr(clone_3)
        if clone_3:IsA("BasePart") then
            clone_3.Anchored = true
            tbl_4_upvr[clone_3] = arg1_3
        elseif clone_3:IsA("Humanoid") then
            clone_3.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        end
        for _, v_3 in ipairs(arg1_3:GetChildren()) do
            copy_upvr(v_3, clone_3)
        end
        return clone_3
    end
    for _, v_4 in ipairs(arg1:GetChildren()) do
        if not shouldCopy_upvr(v_4) then
        else
            copy_upvr(v_4, Model_upvr)
        end
    end
    module_2._maid:GiveTask(arg1.ChildAdded:Connect(function(arg1_4) -- Line 82, Named "handleObj"
        if not shouldCopy_upvr(arg1_4) then
        else
            copy_upvr(arg1_4, Model_upvr)
        end
    end))
    module_2.characterClone = Model_upvr
    module_2.cloneRef = tbl_4_upvr
    module_2._maid:GiveTask(Model_upvr)
    return module_2
end
function tbl_9_upvr.Update(arg1) -- Line 98
    for i_5, v_5 in pairs(arg1.cloneRef) do
        i_5.CFrame = v_5.CFrame
    end
end
function tbl_9_upvr.Destroy(arg1) -- Line 103
    arg1._maid:Destroy()
    setmetatable(arg1, nil)
end
local any_extend_result1 = Roact_upvr.PureComponent:extend("CCTV")
any_extend_result1.defaultProps = {
    active = true;
}
function any_extend_result1.init(arg1) -- Line 112
    arg1.cameraRef = Roact_upvr.createRef()
    arg1.viewportRef = Roact_upvr.createRef()
    arg1.fuzzRef = Roact_upvr.createRef()
    arg1._maid = Maid_upvr.new()
end
local createElement_upvr = Roact_upvr.createElement
function any_extend_result1.render(arg1) -- Line 118
    local module = {}
    local var55 = 0
    module.BorderSizePixel = var55
    local var56
    if not arg1.props.disabled then
        var55 = 1
    else
        var55 = 0
    end
    module.BackgroundTransparency = var55
    module.BackgroundColor3 = Color3.new(0.4, 0, 0)
    module.Size = arg1.props.size
    module.Position = arg1.props.position
    module.LayoutOrder = arg1.props.layoutOrder
    module.AnchorPoint = Vector2.new(0.5, 0.5)
    module.ClipsDescendants = true
    local module_3 = {}
    local tbl_5 = {}
    var56 = UDim.new(0.015625, 0)
    tbl_5.CornerRadius = var56
    module_3.UICorner = createElement_upvr("UICorner", tbl_5)
    local tbl_2 = {}
    var56 = Color3.new(1, 0, 0)
    tbl_2.Color = var56
    var56 = 2
    tbl_2.Thickness = var56
    var56 = arg1.props
    var56 = var56.active
    tbl_2.Enabled = var56
    module_3.UIStroke = createElement_upvr("UIStroke", tbl_2)
    local tbl_8 = {}
    var56 = arg1.props
    var56 = var56.aspectRatio
    tbl_8.AspectRatio = var56
    module_3.AspectRatio = createElement_upvr("UIAspectRatioConstraint", tbl_8)
    local tbl_3 = {}
    var56 = 1
    tbl_3.BackgroundTransparency = var56
    var56 = UDim2.new(1, 0, 1, 0)
    tbl_3.Size = var56
    var56 = arg1.cameraRef
    tbl_3.CurrentCamera = var56
    var56 = 1
    tbl_3.ZIndex = var56
    var56 = not arg1.props.disabled
    tbl_3.Visible = var56
    var56 = Roact_upvr
    var56 = var56.Ref
    tbl_3[var56] = arg1.viewportRef
    var56 = {}
    var56.UICorner = createElement_upvr("UICorner", {
        CornerRadius = UDim.new(0.015625, 0);
    })
    var56.Camera = createElement_upvr("Camera", {
        FieldOfView = arg1.props.fieldOfView;
        CFrame = arg1.props.cameraCFrame;
        [Roact_upvr.Ref] = arg1.cameraRef;
    })
    module_3.ViewportFrame = createElement_upvr("ViewportFrame", tbl_3, var56)
    local tbl = {}
    var56 = 1
    tbl.BackgroundTransparency = var56
    var56 = "rbxassetid://8260530429"
    tbl.Image = var56
    var56 = 0.5
    tbl.ImageTransparency = var56
    var56 = UDim2.new(1.1, 0, 1.1, 0)
    tbl.Size = var56
    var56 = UDim2.new(0.5, 0, 0.5, 0)
    tbl.Position = var56
    var56 = Vector2.new(0.5, 0.5)
    tbl.AnchorPoint = var56
    var56 = 10
    tbl.ZIndex = var56
    var56 = Roact_upvr
    var56 = var56.Ref
    tbl[var56] = arg1.fuzzRef
    var56 = {}
    var56.UICorner = createElement_upvr("UICorner", {
        CornerRadius = UDim.new(0.015625, 0);
    })
    module_3.Fuzz = createElement_upvr("ImageLabel", tbl, var56)
    local tbl_6 = {}
    var56 = arg1.props
    var56 = var56.flash
    tbl_6.BackgroundTransparency = var56
    var56 = Color3.new(1, 1, 1)
    tbl_6.BackgroundColor3 = var56
    var56 = UDim2.new(1, 1, 1)
    tbl_6.Size = var56
    var56 = 20
    tbl_6.ZIndex = var56
    if arg1.props.flash == nil then
        var56 = false
    else
        var56 = true
    end
    tbl_6.Visible = var56
    module_3.Flash = createElement_upvr("Frame", tbl_6)
    return createElement_upvr("Frame", module, module_3)
end
function any_extend_result1._clear(arg1) -- Line 181
    for _, v_6 in ipairs(arg1.viewportRef:getValue():GetChildren()) do
        if not v_6:IsA("UICorner") and not v_6:IsA("Camera") then
            v_6:Destroy()
        end
    end
end
local Players_upvr = game:GetService("Players")
local ManifestBinder_upvr = require(ReplicatedStorage.ManifestBinder)
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
local RunService_upvr = game:GetService("RunService")
function any_extend_result1._redraw(arg1) -- Line 189
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    arg1:_clear()
    local any_new_result1_5 = Maid_upvr.new()
    arg1._maid.canvasMaid = any_new_result1_5
    local any_getValue_result1_upvr = arg1.viewportRef:getValue()
    local distance = arg1.props.distance
    local cameraCFrame_upvr = arg1.props.cameraCFrame
    local var113 = 2 * distance * math.tan(math.rad(arg1.props.fieldOfView / 2))
    local vector3 = Vector3.new(var113 * arg1.props.aspectRatio, var113, distance)
    local tbl_7 = {workspace:FindFirstChild("Items")}
    for _, v_7 in ipairs(Players_upvr:GetPlayers()) do
        if v_7.Character then
            table.insert(tbl_7, v_7.Character)
        end
    end
    local OverlapParams_new_result1 = OverlapParams.new()
    OverlapParams_new_result1.FilterType = Enum.RaycastFilterType.Blacklist
    OverlapParams_new_result1.FilterDescendantsInstances = tbl_7
    for _, v_8 in ipairs(workspace:GetPartBoundsInBox(cameraCFrame_upvr * CFrame.new(0, 0, -vector3.z * 0.5), vector3, OverlapParams_new_result1)) do
        local clone = v_8:Clone()
        if clone then
            wipeTags_upvr(clone)
            for _, v_9 in ipairs(clone:GetDescendants()) do
                wipeTags_upvr(v_9)
            end
            clone.Parent = any_getValue_result1_upvr
        end
    end
    local any_new_result1 = ManifestBinder_upvr.new("Character", {
        HumanoidRootPart = "HumanoidRootPart";
    }, function(arg1_5) -- Line 222
        return BaseObject_upvr.new(arg1_5)
    end)
    any_new_result1:Start()
    local tbl_10_upvr = {}
    local function _(arg1_6) -- Line 234, Named "onCharacterAdded"
        local any_new_result1_3 = tbl_9_upvr.new(arg1_6)
        tbl_10_upvr[arg1_6] = any_new_result1_3
        any_new_result1_3.characterClone.Parent = any_getValue_result1_upvr
    end
    local function _(arg1_7) -- Line 239, Named "onCharacterRemoving"
        local var132 = tbl_10_upvr[arg1_7]
        if var132 then
            var132:Destroy()
        end
        tbl_10_upvr[arg1_7] = nil
    end
    for _, v_10 in any_new_result1:GetAll() do
        local obj_3 = v_10.obj
        local any_new_result1_4 = tbl_9_upvr.new(obj_3)
        tbl_10_upvr[obj_3] = any_new_result1_4
        any_new_result1_4.characterClone.Parent = any_getValue_result1_upvr
        local var138_upvr
    end
    any_new_result1:GetClassAddedSignal():Connect(function(arg1_8) -- Line 249
        local obj = arg1_8.obj
        local any_new_result1_2 = tbl_9_upvr.new(obj)
        var138_upvr[obj] = any_new_result1_2
        any_new_result1_2.characterClone.Parent = any_getValue_result1_upvr
    end)
    any_new_result1:GetClassRemovingSignal():Connect(function(arg1_9) -- Line 252
        local obj_2 = arg1_9.obj
        local var144 = var138_upvr[obj_2]
        if var144 then
            var144:Destroy()
        end
        var138_upvr[obj_2] = nil
    end)
    any_new_result1_5:GiveTask(function() -- Line 255
        for _, v_11 in var138_upvr do
            v_11:Destroy()
        end
        table.clear(var138_upvr)
    end)
    any_new_result1_5:GiveTask(Interval_upvr.every(0.1):Connect(function() -- Line 262
        for _, v_12 in var138_upvr do
            local PrimaryPart_2 = v_12.character.PrimaryPart
            local var161
            if PrimaryPart_2 then
                var161 = cameraCFrame_upvr
                var161 = var161.p
                local var162 = PrimaryPart_2.Position - var161
                var161 = false
                if var162.Magnitude < arg1.props.distance then
                    if math.cos(math.rad(arg1.props.aspectRatio * arg1.props.fieldOfView / 2)) >= var162.Unit:Dot(cameraCFrame_upvr.LookVector) then
                        var161 = false
                    else
                        var161 = true
                    end
                end
                if var161 ~= v_12.onScreen then
                    v_12.onScreen = var161
                    v_12.lastOnScreenChanged = os.clock()
                    if var161 and arg1.props.onCharacterEnter then
                        arg1.props.onCharacterEnter(v_12.character)
                    end
                end
            end
            local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                return os.clock() - v_12.lastOnScreenChanged < 1
            end
            if v_12.onScreen or decompInlinedCondition_2() then
                v_12:Update()
            end
        end
    end))
    local var164_upvr = math.random() * 512
    local any_getValue_result1_upvr_2 = arg1.fuzzRef:getValue()
    any_new_result1_5:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 294
        any_getValue_result1_upvr_2.Position = UDim2.new(0.5, 0, math.cos(os.clock() * 512 + var164_upvr) * 0.05 + 0.5, 0)
    end))
end
function any_extend_result1.didUpdate(arg1, arg2) -- Line 299
    if 0.1 < (arg1.props.cameraCFrame.p - arg2.cameraCFrame.p).Magnitude then
        arg1:_redraw()
    end
end
function any_extend_result1.didMount(arg1) -- Line 304
    arg1:_redraw()
end
function any_extend_result1.willUnmount(arg1) -- Line 307
    arg1._maid:DoCleaning()
end
return any_extend_result1