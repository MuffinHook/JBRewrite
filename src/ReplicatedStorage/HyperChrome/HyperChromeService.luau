local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {}
local ManifestBinder_upvr = require(ReplicatedStorage_upvr.ManifestBinder)
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local HyperChromeConsts_upvr = require(ReplicatedStorage_upvr.HyperChrome.HyperChromeConsts)
local RunService_upvr = game:GetService("RunService")
local HyperChromeUtils_upvr = require(ReplicatedStorage_upvr.HyperChrome.HyperChromeUtils)
local Binder_upvr = require(ReplicatedStorage_upvr.Std.Binder)
local CurrentCamera_upvr = workspace.CurrentCamera
function module.init() -- Line 16
    ManifestBinder_upvr.new("Vehicle", {
        body = "Model/Body";
    }, function(arg1, arg2) -- Line 19
        local any_new_result1_upvr_2 = Maid_upvr.new()
        local function _() -- Line 21, Named "clearMaxLevelAura"
            any_new_result1_upvr_2.maxLevelAuraAttachment = nil
        end
        local function _() -- Line 24, Named "clearNumberParticleEmitter"
            any_new_result1_upvr_2.numberParticleEmitter = nil
        end
        local function _() -- Line 27, Named "clearHyperShiftAuraParticle"
            any_new_result1_upvr_2.hyperShiftAuraParticle = nil
            any_new_result1_upvr_2.hyperShiftParticleRainbowHeartbeat = nil
        end
        any_new_result1_upvr_2:GiveTask(arg1:GetAttributeChangedSignal(HyperChromeConsts_upvr.HYPERCHROME_NAME_ATTRIBUTE_NAME):Connect(function() -- Line 37
            any_new_result1_upvr_2.maxLevelAuraAttachment = nil
            any_new_result1_upvr_2.numberParticleEmitter = nil
            any_new_result1_upvr_2.hyperShiftAuraParticle = nil
            any_new_result1_upvr_2.hyperShiftParticleRainbowHeartbeat = nil
            local attribute_2 = arg1:GetAttribute(HyperChromeConsts_upvr.HYPERCHROME_NAME_ATTRIBUTE_NAME)
            if not attribute_2 then
            else
                if attribute_2 == HyperChromeConsts_upvr.COLOR_SHIFT_NAME then
                    local Attachment_2 = Instance.new("Attachment")
                    Attachment_2.Parent = arg2.body
                    local clone_upvr = ReplicatedStorage_upvr.Resource:FindFirstChild(HyperChromeConsts_upvr.HYPERSHIFT_PARTICLE_RESOURCE_NAME):Clone()
                    clone_upvr.Parent = Attachment_2
                    any_new_result1_upvr_2.hyperShiftAuraParticle = Attachment_2
                    any_new_result1_upvr_2.hyperShiftParticleRainbowHeartbeat = RunService_upvr.Heartbeat:Connect(function() -- Line 54
                        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                        clone_upvr.Color = ColorSequence.new(Color3.fromHSV(os.clock() % HyperChromeConsts_upvr.RAINBOW_ANIMATION_CYCLE_TIME / HyperChromeConsts_upvr.RAINBOW_ANIMATION_CYCLE_TIME, 1, 0.65))
                        local children, NONE_2, NONE = arg1.Model:GetChildren()
                        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [66.7]
                        if nil == "Trail" then
                            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                            if nil then
                                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                            end
                        else
                            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                            if nil == "UFO" and (nil == "Lights" or nil == "Beam" or nil == "Windows") then
                            end
                        end
                        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    end)
                    return
                end
                clone_upvr = attribute_2
                local any_getLevelFromName_result1 = HyperChromeUtils_upvr.getLevelFromName(clone_upvr)
                clone_upvr = HyperChromeConsts_upvr.COLOR_TO_INFO_MAP[HyperChromeUtils_upvr.getColorFromName(attribute_2)]
                clone_upvr = clone_upvr.LevelToColor
                local var23 = clone_upvr[any_getLevelFromName_result1]
                if any_getLevelFromName_result1 ~= HyperChromeConsts_upvr.MAX_LEVEL then
                    local SOME_3 = ReplicatedStorage_upvr.Resource:FindFirstChild(HyperChromeConsts_upvr.HYPERCHROME_NUMBER_PARTICLE_RESOURCE_NAME)
                    assert(SOME_3, "No number hyperchrome emitter resource")
                    local clone = SOME_3:Clone()
                    clone.Texture = HyperChromeConsts_upvr.LEVEL_TO_INFO_MAP[any_getLevelFromName_result1].NumberImageId
                    clone.Color = ColorSequence.new(var23)
                    clone.Parent = arg2.body
                    any_new_result1_upvr_2.numberParticleEmitter = clone
                    return
                end
                local SOME_2 = ReplicatedStorage_upvr.Resource:FindFirstChild(HyperChromeConsts_upvr.MAX_LEVEL_HYPERCHROME_PARTICLE_RESOURCE_NAME)
                assert(SOME_2, "No max level hyperchrome emitter resource")
                local clone_2 = SOME_2:Clone()
                local Attachment = Instance.new("Attachment")
                clone_2.Color = ColorSequence.new(var23)
                clone_2.Parent = Attachment
                Attachment.Parent = arg2.body
                any_new_result1_upvr_2.maxLevelAuraAttachment = Attachment
            end
        end))
        any_new_result1_upvr_2:GiveTask(arg1.Destroying:Connect(function() -- Line 109
            task.defer(any_new_result1_upvr_2.Destroy, any_new_result1_upvr_2)
        end))
        return any_new_result1_upvr_2
    end):Start()
    Binder_upvr.new("VehicleColorPart", function(arg1) -- Line 115
        local any_new_result1_upvr = Maid_upvr.new()
        local function updateHyperChrome() -- Line 117
            local attribute = arg1:GetAttribute(HyperChromeConsts_upvr.HYPERCHROME_NAME_ATTRIBUTE_NAME)
            if attribute ~= nil then
                arg1.Color = Color3.new(0, 0, 0)
                local var41 = HyperChromeConsts_upvr.COLOR_TO_INFO_MAP[HyperChromeUtils_upvr.getColorFromName(attribute)]
                local Enum_NormalId_GetEnumItems_result1_upvr, Enum_NormalId_GetEnumItems_result2, Enum_NormalId_GetEnumItems_result3_2 = Enum.NormalId:GetEnumItems()
                for _, v in Enum_NormalId_GetEnumItems_result1_upvr, Enum_NormalId_GetEnumItems_result2, Enum_NormalId_GetEnumItems_result3_2 do
                    if v ~= Enum.NormalId.Bottom then
                        local var45 = "HyperChrome"..v.Name
                        if not arg1:FindFirstChild(var45) then
                            local Texture = Instance.new("Texture")
                            Texture.Name = var45
                            Texture.StudsPerTileU = 55
                            Texture.StudsPerTileV = 105
                            Texture.Face = v
                            Texture.Texture = "rbxassetid://11372133369"
                            Texture.Parent = arg1
                        end
                        if var41 then
                            Texture.Color3 = var41.LevelToColor[HyperChromeUtils_upvr.getLevelFromName(attribute)]
                        end
                        ;({})[v] = Texture
                    end
                end
                if attribute ~= HyperChromeConsts_upvr.COLOR_SHIFT_NAME then
                    Enum_NormalId_GetEnumItems_result1_upvr = false
                else
                    Enum_NormalId_GetEnumItems_result1_upvr = true
                end
                local tbl_upvr = {}
                any_new_result1_upvr.angleShifter = RunService_upvr.Heartbeat:Connect(function() -- Line 150
                    local CFrame = CurrentCamera_upvr.CFrame
                    local LookVector = CFrame.LookVector
                    local Position = arg1.Position
                    if 256 < (CFrame.Position - Position).Magnitude then
                    else
                        local any_Angle_result1 = LookVector:Angle((Position - CFrame.Position).Unit)
                        if math.rad(CurrentCamera_upvr.FieldOfView) * 0.95 < any_Angle_result1 then return end
                        local var55 = LookVector:Angle(Vector3.new(1, 1, 1)) + any_Angle_result1
                        local var56 = Position.X % 8096 / 8096 + Position.Y % 8096 / 8096 + Position.Z % 8096 / 8096
                        for i_2, v_2 in tbl_upvr do
                            v_2.OffsetStudsU = (var55 + var56 * 55) * 10
                            v_2.OffsetStudsV = (var55 + var56 * 105) * 10
                            if Enum_NormalId_GetEnumItems_result1_upvr then
                                v_2.Color3 = Color3.fromHSV(os.clock() % HyperChromeConsts_upvr.RAINBOW_ANIMATION_CYCLE_TIME / HyperChromeConsts_upvr.RAINBOW_ANIMATION_CYCLE_TIME, 0.94, 1.35)
                            end
                        end
                        if arg1.Color.R ~= 0 or arg1.Color.G ~= 0 or arg1.Color.B ~= 0 then
                            i_2 = 0
                            v_2 = 0
                            arg1.Color = Color3.new(0, i_2, v_2)
                        end
                    end
                end)
            else
                any_new_result1_upvr.angleShifter = nil
                for _, v_3 in Enum.NormalId:GetEnumItems() do
                    local SOME = arg1:FindFirstChild("HyperChrome"..v_3.Name)
                    if SOME then
                        SOME:Destroy()
                    end
                end
            end
        end
        updateHyperChrome()
        any_new_result1_upvr:GiveTask(arg1:GetAttributeChangedSignal(HyperChromeConsts_upvr.HYPERCHROME_NAME_ATTRIBUTE_NAME):Connect(updateHyperChrome))
        return any_new_result1_upvr
    end):Start()
end
return module