local UserInputService_upvr = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl_upvw_3 = {
    MakeGroup = function() -- Line 14, Named "MakeGroup"
        return {
            Running = nil;
        }
    end;
    MakeSpec = function() -- Line 19, Named "MakeSpec"
        return {
            Duration = nil;
            Start = nil;
            End = nil;
            Cancel = nil;
            Update = nil;
        }
    end;
    Cancel = function(arg1) -- Line 28, Named "Cancel"
        local Running_2 = arg1.Running
        if Running_2 then
            Running_2:Cancel()
            arg1.Running = nil
        end
    end;
}
function tbl_upvw_3.Push(arg1, arg2) -- Line 35
    tbl_upvw_3.Cancel(arg1)
    assert(arg2.Duration)
    assert(arg2.Start)
    assert(arg2.End)
    assert(arg2.Update)
    if not arg2.Cancel then
        arg2.Cancel = arg2.End
    end
    arg1.Running = arg2
end
function tbl_upvw_3.Update(arg1, arg2) -- Line 46
    local Running = arg1.Running
    if not Running then
    else
        local os_clock_result1_3 = os.clock()
        if not Running.Started then
            Running.Started = os_clock_result1_3
            Running:Start()
        end
        local var9 = os_clock_result1_3 - Running.Started
        if Running.Elapsed then
            var9 += Running.Elapsed
        end
        local var10 = var9 / Running.Duration
        if 1 <= var10 then
            var10 = 1
        end
        Running:Update(var10, arg2)
        if 1 <= var10 then
            Running:End()
            arg1.Running = nil
        end
    end
end
local tbl_upvw = {
    onVisibilityChanged = require(ReplicatedStorage.Std.Signal).new();
}
local any_MakeGroup_result1_upvr = tbl_upvw_3.MakeGroup()
local tbl_upvr = {}
tbl_upvw.Specs = tbl_upvr
local zero_vector3_upvr = Vector3.new()
local any_new_result1_upvr = require(ReplicatedStorage.Std.Octree).new(Vector3.new(0, 50, 0), 8192, 8, 8)
tbl_upvw.SpecOctree = any_new_result1_upvr
function tbl_upvw.Add(arg1, arg2) -- Line 89
    assert(arg2, "No key found, second param to Add must be nil")
    arg1.Tag = arg2
    if not arg1.Enabled then
        arg1.Enabled = true
    end
    if not arg1.Priority then
        arg1.Priority = 1
    end
    table.insert(tbl_upvr, arg1)
    local var16
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var16 = var16.WorldPosition
        var16 = arg1.Attachment
        return var16
    end
    if not var16 and (not arg1.Attachment or not decompInlinedCondition()) then
        local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var16 = var16.Position
            var16 = arg1.Part
            return var16
        end
        if not arg1.Part or not decompInlinedCondition_2() then
            var16 = zero_vector3_upvr
        end
    end
    any_new_result1_upvr:Insert(arg1, var16)
    return function() -- Line 104
        return tbl_upvw.Remove(arg2)
    end
end
function tbl_upvw.Remove(arg1) -- Line 108
    for i = #tbl_upvr, 1, -1 do
        local var19 = tbl_upvr[i]
        if var19.Tag == arg1 then
            if tbl_upvw.Spec == var19 then
                if var19.HideFun then
                    var19:HideFun()
                end
                tbl_upvw.Spec = nil
            end
            any_new_result1_upvr:Remove(var19)
            table.remove(tbl_upvr, i)
            return true
        end
    end
    return false
end
local var20_upvw = 1
local function _() -- Line 126, Named "GetCirclePct"
    return var20_upvw
end
local function SetCirclePct_upvr(arg1) -- Line 129, Named "SetCirclePct"
    var20_upvw = arg1
    local Frame_7 = tbl_upvw.Frame
    local Image_6 = Frame_7.OuterFrame.Left.Image
    local Image_2 = Frame_7.OuterFrame.Right.Image
    local clamped_2 = math.clamp(arg1 * 360, 0, 360)
    Image_6.UIGradient.Rotation = math.clamp(clamped_2, 180, 360)
    local clamped = math.clamp(clamped_2, 0, 180)
    Image_2.UIGradient.Rotation = clamped
    if arg1 >= 0.999 then
        clamped = false
    else
        clamped = true
    end
    Image_6.Visible = clamped
    Image_2.Visible = clamped
    Frame_7.OuterFrame.OuterFull.Visible = not clamped
end
local function _(arg1) -- Line 144, Named "SetCircleColor"
    local Frame_3 = tbl_upvw.Frame
    Frame_3.OuterFrame.Left.Image.ImageColor3 = arg1
    Frame_3.OuterFrame.Right.Image.ImageColor3 = arg1
    Frame_3.OuterFrame.OuterFull.ImageColor3 = arg1
end
local function _(arg1) -- Line 152, Named "SetCircleRadius"
    local Frame_8 = tbl_upvw.Frame
    Frame_8.OuterFrame.Size = UDim2.new(1, 2 * arg1, 1, 2 * arg1)
    Frame_8.OuterFrame.Position = UDim2.new(0, -arg1, 0, -arg1)
end
local function afSpin_Start_upvw() -- Line 160, Named "afSpin_Start"
    var20_upvw = 0
    local Frame_15 = tbl_upvw.Frame
    local Image_8 = Frame_15.OuterFrame.Left.Image
    local Image_7 = Frame_15.OuterFrame.Right.Image
    Image_8.UIGradient.Rotation = 180
    Image_7.UIGradient.Rotation = 0
    Image_8.Visible = true
    Image_7.Visible = true
    Frame_15.OuterFrame.OuterFull.Visible = false
    local Frame_6 = tbl_upvw.Frame
    Frame_6.OuterFrame.Size = UDim2.new(1, 8, 1, 8)
    Frame_6.OuterFrame.Position = UDim2.new(0, -4, 0, -4)
    local Color3_fromRGB_result1_2 = Color3.fromRGB(214, 214, 214)
    local Frame_4 = tbl_upvw.Frame
    Frame_4.OuterFrame.Left.Image.ImageColor3 = Color3_fromRGB_result1_2
    Frame_4.OuterFrame.Right.Image.ImageColor3 = Color3_fromRGB_result1_2
    Frame_4.OuterFrame.OuterFull.ImageColor3 = Color3_fromRGB_result1_2
end
local function afSpin_End_upvw() -- Line 165, Named "afSpin_End"
    var20_upvw = 1
    local Frame_5 = tbl_upvw.Frame
    local Image_4 = Frame_5.OuterFrame.Left.Image
    local Image_3 = Frame_5.OuterFrame.Right.Image
    Image_4.UIGradient.Rotation = 360
    Image_3.UIGradient.Rotation = 180
    Image_4.Visible = false
    Image_3.Visible = false
    Frame_5.OuterFrame.OuterFull.Visible = true
    local Frame_14 = tbl_upvw.Frame
    Frame_14.OuterFrame.Size = UDim2.new(1, 16, 1, 16)
    Frame_14.OuterFrame.Position = UDim2.new(0, -8, 0, -8)
    local Color3_fromRGB_result1_6 = Color3.fromRGB(214, 214, 214)
    local Frame_10 = tbl_upvw.Frame
    Frame_10.OuterFrame.Left.Image.ImageColor3 = Color3_fromRGB_result1_6
    Frame_10.OuterFrame.Right.Image.ImageColor3 = Color3_fromRGB_result1_6
    Frame_10.OuterFrame.OuterFull.ImageColor3 = Color3_fromRGB_result1_6
end
local sin_upvr = math.sin
local function afSpin_Update_upvw(arg1, arg2, arg3) -- Line 170, Named "afSpin_Update"
    local var41 = sin_upvr(arg2) / 0.8414709848078965
    SetCirclePct_upvr(var41)
    local var42 = 214 - (1 - var41) * 64
    local Color3_fromRGB_result1 = Color3.fromRGB(var42, var42, var42)
    local Frame_16 = tbl_upvw.Frame
    Frame_16.OuterFrame.Left.Image.ImageColor3 = Color3_fromRGB_result1
    Frame_16.OuterFrame.Right.Image.ImageColor3 = Color3_fromRGB_result1
    Frame_16.OuterFrame.OuterFull.ImageColor3 = Color3_fromRGB_result1
    local var45 = var41 * 4 + 4
    local Frame_13 = tbl_upvw.Frame
    Frame_13.OuterFrame.Size = UDim2.new(1, 2 * var45, 1, 2 * var45)
    Frame_13.OuterFrame.Position = UDim2.new(0, -var45, 0, -var45)
end
sin_upvr = 1
local var47_upvw = sin_upvr
local function _(arg1, arg2, arg3, arg4, arg5) -- Line 184, Named "Ease_outBack"
    if not arg5 then
        local const_number = 1.70158
    end
    local var49 = arg1 / arg4 - 1
    return arg3 * (var49 * var49 * ((const_number + 1) * var49 + const_number) + 1) + arg2
end
local function afPulse_Start_upvw() -- Line 191, Named "afPulse_Start"
    local Color3_fromRGB_result1_5 = Color3.fromRGB(214, 214, 214)
    local Frame_12 = tbl_upvw.Frame
    Frame_12.OuterFrame.Left.Image.ImageColor3 = Color3_fromRGB_result1_5
    Frame_12.OuterFrame.Right.Image.ImageColor3 = Color3_fromRGB_result1_5
    Frame_12.OuterFrame.OuterFull.ImageColor3 = Color3_fromRGB_result1_5
    local Frame_9 = tbl_upvw.Frame
    Frame_9.OuterFrame.Size = UDim2.new(1, 0, 1, 0)
    Frame_9.OuterFrame.Position = UDim2.new(0, -0, 0, -0)
end
local function afPulse_End_upvw() -- Line 196, Named "afPulse_End"
    var20_upvw = 1
    local Frame_2 = tbl_upvw.Frame
    local Image = Frame_2.OuterFrame.Left.Image
    local Image_5 = Frame_2.OuterFrame.Right.Image
    Image.UIGradient.Rotation = 360
    Image_5.UIGradient.Rotation = 180
    Image.Visible = false
    Image_5.Visible = false
    Frame_2.OuterFrame.OuterFull.Visible = true
    var47_upvw = 1
    local Color3_fromRGB_result1_3 = Color3.fromRGB(214, 214, 214)
    local Frame_19 = tbl_upvw.Frame
    Frame_19.OuterFrame.Left.Image.ImageColor3 = Color3_fromRGB_result1_3
    Frame_19.OuterFrame.Right.Image.ImageColor3 = Color3_fromRGB_result1_3
    Frame_19.OuterFrame.OuterFull.ImageColor3 = Color3_fromRGB_result1_3
    local Frame_18 = tbl_upvw.Frame
    Frame_18.OuterFrame.Size = UDim2.new(1, 16, 1, 16)
    Frame_18.OuterFrame.Position = UDim2.new(0, -8, 0, -8)
end
local function afPulse_Update_upvw(arg1, arg2, arg3) -- Line 203, Named "afPulse_Update"
    SetCirclePct_upvr(var47_upvw * (1 - arg2) + arg2)
    local var59 = 6
    if not var59 then
        var59 = 1.70158
    end
    local var60 = arg2 / 1 - 1
    local var61 = 8 * (1 * (var60 * var60 * ((var59 + 1) * var60 + var59) + 1) + 0)
    local Frame_11 = tbl_upvw.Frame
    Frame_11.OuterFrame.Size = UDim2.new(1, 2 * var61, 1, 2 * var61)
    Frame_11.OuterFrame.Position = UDim2.new(0, -var61, 0, -var61)
    if arg1.Red then
        local var63 = 40 - 40 * arg2
        local var64 = 1 - arg2
        local Color3_fromRGB_result1_4 = Color3.fromRGB(214 * var64 + 214 * arg2 + var63, 69 * var64 + 214 * arg2 + var63, 69 * var64 + 214 * arg2 + var63)
        local Frame_17 = tbl_upvw.Frame
        Frame_17.OuterFrame.Left.Image.ImageColor3 = Color3_fromRGB_result1_4
        Frame_17.OuterFrame.Right.Image.ImageColor3 = Color3_fromRGB_result1_4
        Frame_17.OuterFrame.OuterFull.ImageColor3 = Color3_fromRGB_result1_4
    end
end
function tbl_upvw.NotAllowed() -- Line 216
    local any_MakeSpec_result1_4 = tbl_upvw_3.MakeSpec()
    any_MakeSpec_result1_4.Duration = 0.3
    any_MakeSpec_result1_4.Start = afPulse_Start_upvw
    any_MakeSpec_result1_4.End = afPulse_End_upvw
    any_MakeSpec_result1_4.Update = afPulse_Update_upvw
    any_MakeSpec_result1_4.Red = true
    tbl_upvw_3.Push(any_MakeGroup_result1_upvr, any_MakeSpec_result1_4)
end
local function Press_upvr() -- Line 226, Named "Press"
    local Spec_7 = tbl_upvw.Spec
    if not Spec_7 then
    else
        Spec_7:Callback(false)
        if Spec_7.Timed then
            Spec_7.Pressed = true
            Spec_7.PressedAt = os.clock()
            local any_MakeSpec_result1_7 = tbl_upvw_3.MakeSpec()
            any_MakeSpec_result1_7.Duration = Spec_7.Duration
            any_MakeSpec_result1_7.Start = afSpin_Start_upvw
            any_MakeSpec_result1_7.End = afSpin_End_upvw
            any_MakeSpec_result1_7.Update = afSpin_Update_upvw
            if Spec_7.GetAccumulation then
                any_MakeSpec_result1_7.Elapsed = Spec_7.GetAccumulation()
            end
            tbl_upvw_3.Push(any_MakeGroup_result1_upvr, any_MakeSpec_result1_7)
            Spec_7.Animation = any_MakeSpec_result1_7
            return
        end
        if Spec_7:Callback(true) then
            local any_MakeSpec_result1_5 = tbl_upvw_3.MakeSpec()
            any_MakeSpec_result1_5.Duration = 0.3
            any_MakeSpec_result1_5.Start = afPulse_Start_upvw
            any_MakeSpec_result1_5.End = afPulse_End_upvw
            any_MakeSpec_result1_5.Update = afPulse_Update_upvw
            tbl_upvw_3.Push(any_MakeGroup_result1_upvr, any_MakeSpec_result1_5)
            return
        end
        local any_MakeSpec_result1_2 = tbl_upvw_3.MakeSpec()
        any_MakeSpec_result1_2.Duration = 0.3
        any_MakeSpec_result1_2.Start = afPulse_Start_upvw
        any_MakeSpec_result1_2.End = afPulse_End_upvw
        any_MakeSpec_result1_2.Update = afPulse_Update_upvw
        any_MakeSpec_result1_2.Red = true
        tbl_upvw_3.Push(any_MakeGroup_result1_upvr, any_MakeSpec_result1_2)
    end
end
local function Release_upvr() -- Line 261, Named "Release"
    local Spec_2 = tbl_upvw.Spec
    if Spec_2 then
        Spec_2.Pressed = false
        Spec_2.PressedAt = nil
        if any_MakeGroup_result1_upvr.Running ~= nil and any_MakeGroup_result1_upvr.Running == Spec_2.Animation then
            var47_upvw = var20_upvw
            tbl_upvw_3.Cancel(any_MakeGroup_result1_upvr)
            local any_MakeSpec_result1 = tbl_upvw_3.MakeSpec()
            any_MakeSpec_result1.Duration = 0.3
            any_MakeSpec_result1.Start = afPulse_Start_upvw
            any_MakeSpec_result1.End = afPulse_End_upvw
            any_MakeSpec_result1.Update = afPulse_Update_upvw
            any_MakeSpec_result1.Red = true
            tbl_upvw_3.Push(any_MakeGroup_result1_upvr, any_MakeSpec_result1)
        end
        Spec_2.Animation = nil
        Spec_2.ScreenPosition = nil
        tbl_upvw.Spec = nil
        if Spec_2.ReleaseCallback then
            Spec_2:ReleaseCallback(false)
        end
    end
end
tbl_upvw.Press = Press_upvr
tbl_upvw.Release = Release_upvr
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local tbl_upvw_2 = {}
local var76_upvw = 0
local Raycast_upvr = require(ReplicatedStorage.Std.Raycast)
local function UpdateUI_upvr() -- Line 289, Named "UpdateUI"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var166
    for i_2 = #tbl_upvr, 1, -1 do
        var166 = tbl_upvr
        local var167 = var166[i_2]
        var166 = var167.Kill
        if not var166 then
            var166 = var167.Part
            if var166 then
                var166 = var167.Part:IsDescendantOf(workspace)
                if not var166 then
                    var166 = true
                    var167.Kill = var166
                end
            end
        end
        var166 = var167.Kill
        if var166 then
            var166 = tbl_upvw
            var166 = var166.Spec
            if var166 == var167 then
                var166 = var167.HideFun
                if var166 then
                    var166 = var167:HideFun
                    var166()
                end
                var166 = tbl_upvw
                var166.Spec = nil
            end
            var166 = any_new_result1_upvr:Remove
            var166(var167)
            var166 = table.remove
            var166(tbl_upvr, i_2)
        end
    end
    local Character = LocalPlayer_upvr.Character
    if not Character then return end
    local PrimaryPart_3 = Character.PrimaryPart
    if not PrimaryPart_3 then return end
    local Position = PrimaryPart_3.Position
    local os_clock_result1 = os.clock()
    var166 = ipairs(tbl_upvw_2)
    local ipairs_result1_6, ipairs_result2_3, ipairs_result3_5 = ipairs(tbl_upvw_2)
    for i_3, v in ipairs_result1_6, ipairs_result2_3, ipairs_result3_5 do
        if not v.Kill then
            local var175
            if not var175 then
                local function decompInlinedCondition_7() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var175 = var175.WorldPosition
                    var175 = v.Attachment
                    return var175
                end
                if not v.Attachment or not decompInlinedCondition_7() then
                    var175 = v.Part
                    if var175 then
                        var175 = v.Part
                        var175 = var175.Position
                    end
                end
                if var175 then
                    any_new_result1_upvr:Update(v, var175)
                end
            end
        end
    end
    if 0.25 > os_clock_result1 - var76_upvw then
        ipairs_result1_6 = false
    else
        ipairs_result1_6 = true
    end
    if ipairs_result1_6 then
        var76_upvw = os_clock_result1
        i_3 = 1
        v = tbl_upvr
        for i_4 = i_3, #v do
            v = tbl_upvr[i_4]
            if not v.Kill then
                local PreUpdateFun = v.PreUpdateFun
                if PreUpdateFun then
                    PreUpdateFun = not v.Part
                    if PreUpdateFun then
                        PreUpdateFun = not v.Attachment
                        if PreUpdateFun then
                            PreUpdateFun = not v.WorldPosition
                        end
                    end
                end
                if PreUpdateFun then
                    v:PreUpdateFun()
                end
                local var177
                local function decompInlinedCondition_8() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var177 = var177.WorldPosition
                    var177 = v.Attachment
                    return var177
                end
                if not var177 and (not v.Attachment or not decompInlinedCondition_8()) then
                    var177 = v.Part
                    if var177 then
                        var177 = v.Part
                        var177 = var177.Position
                    end
                end
                if var177 then
                    any_new_result1_upvr:Update(v, var177)
                end
            end
        end
    end
    local any_QueryRadius_result1 = any_new_result1_upvr:QueryRadius(Position, 256)
    tbl_upvw_2 = any_QueryRadius_result1
    for _, v_2 in ipairs(any_QueryRadius_result1) do
        local Part_2 = v_2.Part
        local Attachment_2 = v_2.Attachment
        local var185
        local function decompInlinedCondition_9() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var185 = Attachment_2.WorldPosition
            return var185
        end
        local function decompInlinedCondition_10() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var185 = Part_2.Position
            return var185
        end
        if not var185 and (Attachment_2 == nil or not decompInlinedCondition_9()) or Part_2 == nil or not decompInlinedCondition_10() then
            var185 = zero_vector3_upvr
        end
        local var186 = var185 - Position
        local Magnitude = var186.Magnitude
        local Dist = v_2.Dist
        local HorizontalDist = v_2.HorizontalDist
        local VerticalDist = v_2.VerticalDist
        if v_2.PreUpdateFun and (not Part_2 or Magnitude <= Dist) then
            local PreUpdatePeriod = v_2.PreUpdatePeriod
            if not PreUpdatePeriod then
            end
            if not v_2.LastPreUpdate or 0.2 <= os_clock_result1 - v_2.LastPreUpdate then
                v_2.LastPreUpdate = os_clock_result1
                v_2:PreUpdateFun()
            end
        end
        local var192
        if v_2.Enabled and (not tbl_upvw.Spec or v_2 == tbl_upvw.Spec or not tbl_upvw.Spec.Pressed) then
            local var193 = false
            if HorizontalDist ~= nil then
                if Vector3.new(var186.X, 0, var186.Z).Magnitude > HorizontalDist then
                    var193 = false
                else
                    var193 = true
                end
            end
            local var194 = false
            if VerticalDist ~= nil then
                if Vector3.new(0, var186.Y, 0).Magnitude > VerticalDist then
                    var194 = false
                else
                    var194 = true
                    local var195
                end
            end
            if Dist ~= nil then
                if Magnitude > Dist then
                    var192 = false
                else
                    var192 = true
                end
            else
                var192 = var193 and var194
            end
            if var192 then
                var195 = false
                local var196
                if v_2.NoRay then
                    var195 = true
                else
                    local RaycastParams_new_result1 = RaycastParams.new()
                    RaycastParams_new_result1.FilterDescendantsInstances = v_2.IgnoreOverride or {Character}
                    var196 = var186.Unit
                    local any_collidable_result1 = Raycast_upvr.collidable(Position, var196, Magnitude, RaycastParams_new_result1)
                    var196 = nil
                    if any_collidable_result1 then
                        local Instance = any_collidable_result1.Instance
                        var196 = any_collidable_result1.Position
                    else
                        var196 = Position + var186.Unit * Magnitude
                    end
                    if (var196 - var185).Magnitude <= 1 then
                        var195 = true
                    elseif Instance then
                        if Instance == v_2.Part then
                            var195 = true
                        elseif v_2.ValidRoot and Instance:IsDescendantOf(v_2.ValidRoot) then
                            var195 = true
                            local var200
                        end
                    end
                end
                local function decompInlinedCondition_11() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var200 = v_2.Priority
                    return Magnitude <= 999
                end
                if var195 and (decompInlinedCondition_11() or 1 < var200) then
                    local var201 = v_2
                end
            end
        end
    end
    local Spec = tbl_upvw.Spec
    if Spec and var201 ~= Spec and Spec.Pressed then return end
    if Spec and Spec.HideFun and var201 ~= Spec then
        Spec:HideFun()
    end
    tbl_upvw.Spec = var201
    if not var201 then return end
    if var201.ShowFun and var201 ~= Spec then
        var201:ShowFun()
    end
    if var201.Update then
        var201:Update()
    end
    return true
end
local function ProcessSpec_upvr() -- Line 459, Named "ProcessSpec"
    local Spec_3 = tbl_upvw.Spec
    local var204
    if not Spec_3 then
    else
        if not Spec_3.Pressed then return end
        var204 = Spec_3.PressedAt
        local var205 = os.clock() - var204
        var204 = Spec_3.GetAccumulation
        if var204 then
            var204 = Spec_3.GetAccumulation()
            var205 += var204
        end
        var204 = var205 / Spec_3.Duration
        if 1 <= var204 then
            var204 = 1
        end
        if Spec_3.WhilePressedUpdate then
            Spec_3.WhilePressedUpdate(var204)
        end
        if Spec_3.ForceRelease then
            Spec_3.ForceRelease = false
            Release_upvr()
            return
        end
        if var204 == 1 then
            Spec_3.Pressed = false
            Spec_3.PressedAt = nil
            if Spec_3.ReleaseCallback then
                Spec_3:ReleaseCallback(true)
            end
            if Spec_3:Callback(true) then
                local any_MakeSpec_result1_6 = tbl_upvw_3.MakeSpec()
                any_MakeSpec_result1_6.Duration = 0.5
                any_MakeSpec_result1_6.Start = afPulse_Start_upvw
                any_MakeSpec_result1_6.End = afPulse_End_upvw
                any_MakeSpec_result1_6.Update = afPulse_Update_upvw
                tbl_upvw_3.Push(any_MakeGroup_result1_upvr, any_MakeSpec_result1_6)
                return
            end
            local any_MakeSpec_result1_3 = tbl_upvw_3.MakeSpec()
            any_MakeSpec_result1_3.Duration = 0.3
            any_MakeSpec_result1_3.Start = afPulse_Start_upvw
            any_MakeSpec_result1_3.End = afPulse_End_upvw
            any_MakeSpec_result1_3.Update = afPulse_Update_upvw
            any_MakeSpec_result1_3.Red = true
            tbl_upvw_3.Push(any_MakeGroup_result1_upvr, any_MakeSpec_result1_3)
        end
    end
end
local InputUtils_upvr = require(ReplicatedStorage.Std.InputUtils)
local function UpdatePlatform_upvr() -- Line 504, Named "UpdatePlatform"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var209
    if InputUtils_upvr.isTouch() then
        var209 = nil
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if UserInputService_upvr:GetLastInputType() == Enum.UserInputType.Gamepad1 then
        var209 = UserInputService_upvr:GetStringForKeyCode(Enum.KeyCode.ButtonY)
        if var209 == "ButtonTriangle" then
            var209 = "△"
        elseif var209 == "ButtonY" then
            var209 = 'Y'
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
    else
        var209 = 'E'
    end
    if var209 == nil then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local var210_upvw
function tbl_upvw.UpdateLogic(arg1) -- Line 530
    if not UpdateUI_upvr() and tbl_upvw.Spec then
        if tbl_upvw.Spec.HideFun then
            tbl_upvw.Spec:HideFun()
        end
        Release_upvr()
    end
    UpdatePlatform_upvr()
    ProcessSpec_upvr()
    local var211
    if tbl_upvw.Spec ~= var210_upvw then
        if tbl_upvw.Spec == nil then
            var211 = false
        else
            var211 = true
        end
        tbl_upvw.onVisibilityChanged:Fire(var211)
    end
    var210_upvw = tbl_upvw.Spec
end
local CurrentCamera_upvr = workspace.CurrentCamera
function tbl_upvw.UpdateVisual(arg1) -- Line 551
    local Spec_4 = tbl_upvw.Spec
    local Frame = tbl_upvw.Frame
    local var215
    if not Spec_4 then
        Frame.Visible = false
        var215 = arg1
        tbl_upvw_3.Update(any_MakeGroup_result1_upvr, var215)
    else
        local Attachment = Spec_4.Attachment
        local Part = Spec_4.Part
        var215 = Spec_4.WorldPosition
        local function decompInlinedCondition_12() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var215 = Attachment.WorldPosition
            return var215
        end
        local function decompInlinedCondition_13() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var215 = Part.Position
            return var215
        end
        if not var215 and (Attachment == nil or not decompInlinedCondition_12()) or Part == nil or not decompInlinedCondition_13() then
            var215 = zero_vector3_upvr
        end
        local any_WorldToScreenPoint_result1, any_WorldToScreenPoint_result2 = CurrentCamera_upvr:WorldToScreenPoint(var215)
        Frame.Visible = any_WorldToScreenPoint_result2
        if any_WorldToScreenPoint_result2 then
            Spec_4.ScreenPosition = Vector3.new(any_WorldToScreenPoint_result1.X, any_WorldToScreenPoint_result1.Y, 0)
            Frame.Position = UDim2.new(0, any_WorldToScreenPoint_result1.X, 0, any_WorldToScreenPoint_result1.Y) - UDim2.new(0, Frame.AbsoluteSize.X * 0.5, 0, Frame.AbsoluteSize.Y * 0.5)
            Frame.Help.Text = Spec_4.Name or ""
            Frame.Help.Visible = not not Spec_4.Name
        end
        tbl_upvw_3.Update(any_MakeGroup_result1_upvr, arg1)
    end
end
local var220_upvw = false
local var223_upvw
UserInputService_upvr.InputBegan:connect(function(arg1, arg2) -- Line 602, Named "InputBegan"
    if arg2 then
    else
        local UserInputType = arg1.UserInputType
        if UserInputType == Enum.UserInputType.MouseButton1 then
            local Spec_5 = tbl_upvw.Spec
            if not Spec_5 then
                UserInputType = nil
            else
                local ScreenPosition = Spec_5.ScreenPosition
                if not ScreenPosition then
                    UserInputType = false
                elseif (arg1.Position - ScreenPosition).Magnitude < tbl_upvw.Frame.AbsoluteSize.X * 0.5 then
                    var220_upvw = true
                    Press_upvr()
                    UserInputType = true
                else
                    UserInputType = false
                end
            end
            if UserInputType then
                var223_upvw = Enum.UserInputType.MouseButton1
            end
        end
    end
end)
UserInputService_upvr.InputEnded:connect(function(arg1, arg2) -- Line 613, Named "InputEnded"
    if arg2 then
    elseif arg1.UserInputType == Enum.UserInputType.MouseButton1 and var223_upvw == Enum.UserInputType.MouseButton1 then
        if not var220_upvw then return end
        var220_upvw = false
        Release_upvr()
    end
end)
UserInputService_upvr.TouchStarted:connect(function(arg1) -- Line 577, Named "TouchStarted"
    local Spec_6 = tbl_upvw.Spec
    if not Spec_6 then return end
    local ScreenPosition_2 = Spec_6.ScreenPosition
    if not ScreenPosition_2 then
        return false
    end
    if (arg1.Position - ScreenPosition_2).Magnitude < tbl_upvw.Frame.AbsoluteSize.X * 0.5 then
        var220_upvw = true
        Press_upvr()
        return true
    end
    return false
end)
UserInputService_upvr.TouchEnded:connect(function(arg1) -- Line 594, Named "TouchEnded"
    if not var220_upvw then
    else
        var220_upvw = false
        Release_upvr()
    end
end)
any_MakeGroup_result1_upvr = {}
local var227 = any_MakeGroup_result1_upvr
var227.CircleAction = tbl_upvw
var227.Animation = tbl_upvw_3
return var227