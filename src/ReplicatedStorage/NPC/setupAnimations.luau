local Maid_upvr = require(game:GetService("ReplicatedStorage").Std.Maid)
local RunService_upvr = game:GetService("RunService")
return function(arg1) -- Line 5
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local any_new_result1_upvr = Maid_upvr.new()
    local var37_upvw
    if not arg1:FindFirstChild("AnimationsFolder") then
        local Folder = Instance.new("Folder")
        Folder.Name = "AnimationsFolder"
        Folder.Parent = arg1
        for _, v in script.Parent:FindFirstChild("Res"):FindFirstChild("DefaultAnimations"):GetChildren() do
            v:Clone().Parent = Folder
            local var42_upvw
        end
    end
    local Humanoid_upvr = arg1:FindFirstChild("Humanoid")
    local var44_upvw = "Standing"
    local ScaleDampeningPercent_upvw = Humanoid_upvr:FindFirstChild("ScaleDampeningPercent")
    local const_number_upvw = 0
    local var47_upvw = 0
    local tbl_upvw = {
        x = 0;
        y = 0;
    }
    local var49_upvw = 0
    local var50_upvw = ""
    local var51_upvw
    local var52_upvw
    local var53_upvw
    local var54_upvw = 1
    local tbl_2_upvr = {}
    local tbl_upvr_2 = {
        idle = {{
            id = "http://www.roblox.com/asset/?id=507766666";
            weight = 1;
        }, {
            id = "http://www.roblox.com/asset/?id=507766951";
            weight = 1;
        }, {
            id = "http://www.roblox.com/asset/?id=507766388";
            weight = 9;
        }};
        walk = {{
            id = "http://www.roblox.com/asset/?id=507777826";
            weight = 10;
        }};
        run = {{
            id = "http://www.roblox.com/asset/?id=507767714";
            weight = 10;
        }};
        swim = {{
            id = "http://www.roblox.com/asset/?id=507784897";
            weight = 10;
        }};
        swimidle = {{
            id = "http://www.roblox.com/asset/?id=507785072";
            weight = 10;
        }};
        jump = {{
            id = "http://www.roblox.com/asset/?id=507765000";
            weight = 10;
        }};
        fall = {{
            id = "http://www.roblox.com/asset/?id=507767968";
            weight = 10;
        }};
        climb = {{
            id = "http://www.roblox.com/asset/?id=507765644";
            weight = 10;
        }};
        sit = {{
            id = "http://www.roblox.com/asset/?id=2506281703";
            weight = 10;
        }};
        toolnone = {{
            id = "http://www.roblox.com/asset/?id=507768375";
            weight = 10;
        }};
        toolslash = {{
            id = "http://www.roblox.com/asset/?id=522635514";
            weight = 10;
        }};
        toollunge = {{
            id = "http://www.roblox.com/asset/?id=522638767";
            weight = 10;
        }};
        wave = {{
            id = "http://www.roblox.com/asset/?id=507770239";
            weight = 10;
        }};
        point = {{
            id = "http://www.roblox.com/asset/?id=507770453";
            weight = 10;
        }};
        dance = {{
            id = "http://www.roblox.com/asset/?id=507771019";
            weight = 10;
        }, {
            id = "http://www.roblox.com/asset/?id=507771955";
            weight = 10;
        }, {
            id = "http://www.roblox.com/asset/?id=507772104";
            weight = 10;
        }};
        dance2 = {{
            id = "http://www.roblox.com/asset/?id=507776043";
            weight = 10;
        }, {
            id = "http://www.roblox.com/asset/?id=507776720";
            weight = 10;
        }, {
            id = "http://www.roblox.com/asset/?id=507776879";
            weight = 10;
        }};
        dance3 = {{
            id = "http://www.roblox.com/asset/?id=507777268";
            weight = 10;
        }, {
            id = "http://www.roblox.com/asset/?id=507777451";
            weight = 10;
        }, {
            id = "http://www.roblox.com/asset/?id=507777623";
            weight = 10;
        }};
        laugh = {{
            id = "http://www.roblox.com/asset/?id=507770818";
            weight = 10;
        }};
        cheer = {{
            id = "http://www.roblox.com/asset/?id=507770677";
            weight = 10;
        }};
    }
    local tbl_upvr = {}
    local tbl_6_upvr = {}
    local var105_upvw = tbl_upvr
    local tbl_5_upvr = {
        wave = false;
        point = false;
        dance = true;
        dance2 = true;
        dance3 = true;
        laugh = false;
        cheer = false;
    }
    math.randomseed(tick())
    local function destroyWalkAnimations_upvr() -- Line 122, Named "destroyWalkAnimations"
        for _, v_2 in pairs(tbl_upvr) do
            if v_2.track then
                v_2.track:Stop()
                v_2.track:Destroy()
                v_2.track = nil
            end
        end
        for _, v_3 in pairs(tbl_6_upvr) do
            if v_3.track then
                v_3.track:Stop()
                v_3.track:Destroy()
                v_3.track = nil
            end
        end
        var47_upvw = 0
    end
    local var117_upvw
    local var118_upvw
    local var119_upvw
    local var120_upvw
    local function _(arg1_2) -- Line 144, Named "resetVelocityBounds"
        var118_upvw = 0
        var117_upvw = 0
        var120_upvw = 0
        var119_upvw = 0
    end
    local function _(arg1_3) -- Line 151, Named "updateVelocityBounds"
        if arg1_3 then
            if var117_upvw < arg1_3.x then
                var117_upvw = arg1_3.x
            end
            if var119_upvw < arg1_3.y then
                var119_upvw = arg1_3.y
            end
            if arg1_3.x < var118_upvw then
                var118_upvw = arg1_3.x
            end
            if arg1_3.y < var120_upvw then
                var120_upvw = arg1_3.y
            end
        end
    end
    local function checkStrafingEnabled_upvr(arg1_4) -- Line 168, Named "checkStrafingEnabled"
        if var117_upvw == 0 or var118_upvw == 0 or var119_upvw == 0 or var120_upvw == 0 then
            if var105_upvw ~= tbl_upvr then
            end
            var105_upvw = tbl_6_upvr
        else
            if not tbl_upvr.run or not tbl_upvr.walk then
                if var105_upvw == tbl_upvr then
                    warn("Strafe blending disabled.  Run and walk must be strafing-friendly.")
                end
                var105_upvw = tbl_6_upvr
                return
            end
            if var105_upvw ~= tbl_upvr then
                var105_upvw = tbl_upvr
                warn("Strafing reenabled")
            end
        end
    end
    local function setupWalkAnimations_upvr() -- Line 187, Named "setupWalkAnimations"
        var118_upvw = 0
        var117_upvw = 0
        var120_upvw = 0
        var119_upvw = 0
        for _, v_4 in pairs(tbl_upvr) do
            local lv = v_4.lv
            if lv then
                if var117_upvw < lv.x then
                    var117_upvw = lv.x
                end
                if var119_upvw < lv.y then
                    var119_upvw = lv.y
                end
                if lv.x < var118_upvw then
                    var118_upvw = lv.x
                end
                if lv.y < var120_upvw then
                    var120_upvw = lv.y
                end
            end
        end
        checkStrafingEnabled_upvr()
        for i_5, v_5 in pairs(var105_upvw) do
            v_5.track = Humanoid_upvr:LoadAnimation(tbl_2_upvr[i_5][1].anim)
            v_5.track.Priority = Enum.AnimationPriority.Core
        end
    end
    local function replaceLocomotionTrack_upvr(arg1_5, arg2) -- Line 200, Named "replaceLocomotionTrack"
        local var132
        if var50_upvw == "walk" and var105_upvw[arg1_5] then
            destroyWalkAnimations_upvr()
            var132 = true
        end
        if arg2 then
            local tbl_3 = {}
            tbl_3.lv = arg2
            tbl_3.speed = arg2.Magnitude
            tbl_upvr[arg1_5] = tbl_3
        else
            tbl_upvr[arg1_5] = nil
        end
        local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            local var134
            return arg1_5 == "walk"
        end
        if arg1_5 == "run" or decompInlinedCondition() then
            if arg2 then
                var134 = tbl_6_upvr
                var134[arg1_5] = tbl_upvr[arg1_5]
            else
                if arg1_5 == "run" then
                    var134 = 12.8
                else
                    var134 = 6.4
                end
                tbl_6_upvr[arg1_5] = {
                    lv = Vector2.new(0, var134);
                    speed = var134;
                }
                tbl_upvr[arg1_5] = nil
            end
        end
        if var132 then
            setupWalkAnimations_upvr()
            var49_upvw = 0
        end
    end
    local tbl_4_upvr = {}
    local function configureAnimationSet_upvr(arg1_6, arg2) -- Line 228, Named "configureAnimationSet"
        if tbl_2_upvr[arg1_6] ~= nil then
            for _, v_6 in pairs(tbl_2_upvr[arg1_6].connections) do
                v_6:disconnect()
            end
        end
        tbl_2_upvr[arg1_6] = {}
        tbl_2_upvr[arg1_6].count = 0
        tbl_2_upvr[arg1_6].totalWeight = 0
        tbl_2_upvr[arg1_6].connections = {}
        local SOME = var42_upvw:FindFirstChild(arg1_6)
        if SOME ~= nil then
            table.insert(tbl_2_upvr[arg1_6].connections, SOME.ChildAdded:connect(function(arg1_7) -- Line 244
                configureAnimationSet_upvr(arg1_6, arg2)
            end))
            table.insert(tbl_2_upvr[arg1_6].connections, SOME.ChildRemoved:connect(function(arg1_8) -- Line 250
                configureAnimationSet_upvr(arg1_6, arg2)
            end))
            for _, v_7 in pairs(SOME:GetChildren()) do
                if v_7:IsA("Animation") then
                    local var164 = 1
                    local Weight = v_7:FindFirstChild("Weight")
                    if Weight ~= nil then
                        var164 = Weight.Value
                    end
                    tbl_2_upvr[arg1_6].count = tbl_2_upvr[arg1_6].count + 1
                    local count = tbl_2_upvr[arg1_6].count
                    tbl_2_upvr[arg1_6][count] = {}
                    tbl_2_upvr[arg1_6][count].anim = v_7
                    tbl_2_upvr[arg1_6][count].weight = var164
                    tbl_2_upvr[arg1_6].totalWeight = tbl_2_upvr[arg1_6].totalWeight + tbl_2_upvr[arg1_6][count].weight
                    table.insert(tbl_2_upvr[arg1_6].connections, v_7.Changed:connect(function(arg1_9) -- Line 272
                        configureAnimationSet_upvr(arg1_6, arg2)
                    end))
                    table.insert(tbl_2_upvr[arg1_6].connections, v_7.ChildAdded:connect(function(arg1_10) -- Line 278
                        configureAnimationSet_upvr(arg1_6, arg2)
                    end))
                    table.insert(tbl_2_upvr[arg1_6].connections, v_7.ChildRemoved:connect(function(arg1_11) -- Line 284
                        configureAnimationSet_upvr(arg1_6, arg2)
                    end))
                    replaceLocomotionTrack_upvr(arg1_6, v_7:GetAttribute("LinearVelocity"))
                end
            end
        end
        if tbl_2_upvr[arg1_6].count <= 0 then
            for i_8, v_8 in pairs(arg2) do
                v_7 = tbl_2_upvr[arg1_6]
                v_7[i_8] = {}
                v_7 = tbl_2_upvr[arg1_6][i_8]
                v_7.anim = Instance.new("Animation")
                v_7 = tbl_2_upvr[arg1_6][i_8]
                v_7 = v_7.anim
                v_7.Name = arg1_6
                v_7 = tbl_2_upvr[arg1_6][i_8]
                v_7 = v_7.anim
                v_7.AnimationId = v_8.id
                v_7 = tbl_2_upvr[arg1_6][i_8]
                v_7.weight = v_8.weight
                v_7 = tbl_2_upvr[arg1_6]
                v_7.count = tbl_2_upvr[arg1_6].count + 1
                v_7 = tbl_2_upvr[arg1_6]
                v_7.totalWeight = tbl_2_upvr[arg1_6].totalWeight + v_8.weight
            end
        end
        for _, v_9 in pairs(tbl_2_upvr) do
            for i_10 = 1, v_9.count do
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                if tbl_4_upvr[v_9[i_10].anim.AnimationId] == nil then
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    Humanoid_upvr:LoadAnimation(v_9[i_10].anim)
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    tbl_4_upvr[v_9[i_10].anim.AnimationId] = true
                end
            end
        end
    end
    local function scriptChildModified(arg1_12) -- Line 319
        local var176 = tbl_upvr_2[arg1_12.Name]
        if var176 ~= nil then
            configureAnimationSet_upvr(arg1_12.Name, var176)
        elseif arg1_12:isA("StringValue") then
            tbl_upvr_2[arg1_12.Name] = {}
            configureAnimationSet_upvr(arg1_12.Name, tbl_upvr_2[arg1_12.Name])
        end
    end
    var37_upvw = any_new_result1_upvr:GiveTask
    var37_upvw(var42_upvw.ChildAdded:connect(scriptChildModified))
    var37_upvw = any_new_result1_upvr:GiveTask
    var37_upvw(var42_upvw.ChildRemoved:connect(scriptChildModified))
    var37_upvw = any_new_result1_upvr:GiveTask
    var37_upvw(function() -- Line 333
        for _, v_10 in tbl_2_upvr do
            for _, v_11 in v_10.connections do
                v_11:Disconnect()
            end
        end
    end)
    if Humanoid_upvr then
        var37_upvw = Humanoid_upvr:FindFirstChildOfClass("Animator")
    else
        var37_upvw = nil
    end
    if not var37_upvw then
        if RunService_upvr:IsServer() then
            var37_upvw = Instance.new("Animator")
            assert(var37_upvw).Parent = Humanoid_upvr
        else
            var37_upvw = Humanoid_upvr
        end
    end
    if var37_upvw then
        for _, v_12 in ipairs(var37_upvw:GetPlayingAnimationTracks()) do
            v_12:Stop(0)
            v_12:Destroy()
        end
    end
    for i_14, _ in pairs(tbl_upvr_2) do
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [537.40]
        configureAnimationSet_upvr(i_14, nil)
        local var188
    end
    for _, v_14 in var42_upvw:GetChildren() do
        if v_14:isA("StringValue") then
            tbl_upvr_2[v_14.Name] = {}
            var188(v_14.Name, tbl_upvr_2[v_14.Name])
        end
    end
    local var192_upvw = "None"
    local var193_upvw = 0
    local var194_upvw = false
    local function stopAllAnimations_upvr() -- Line 388, Named "stopAllAnimations"
        local var199
        if tbl_5_upvr[var50_upvw] ~= nil and tbl_5_upvr[var199] == false then
            var199 = "idle"
        end
        if var194_upvw then
            var199 = "idle"
            var194_upvw = false
        end
        var50_upvw = ""
        var51_upvw = nil
        if var53_upvw ~= nil then
            var53_upvw:disconnect()
        end
        if var52_upvw ~= nil then
            var52_upvw:Stop()
            var52_upvw:Destroy()
            var52_upvw = nil
        end
        for _, v_15 in pairs(var105_upvw) do
            if v_15.track then
                v_15.track:Stop()
                v_15.track:Destroy()
                v_15.track = nil
            end
        end
        return var199
    end
    local function _() -- Line 424, Named "getHeightScale"
        local var203
        if var203 then
            var203 = Humanoid_upvr
            var203 = var203.AutomaticScalingEnabled
            if not var203 then
                var203 = 1
                return var203
            end
            var203 = Humanoid_upvr.HipHeight / 2
            if ScaleDampeningPercent_upvw == nil then
                ScaleDampeningPercent_upvw = Humanoid_upvr:FindFirstChild("ScaleDampeningPercent")
            end
            if ScaleDampeningPercent_upvw ~= nil then
                var203 = 1 + (Humanoid_upvr.HipHeight - 2) * ScaleDampeningPercent_upvw.Value / 2
            end
            return var203
        end
        return 1
    end
    local function _(arg1_13, arg2) -- Line 445, Named "signedAngle"
        return -math.atan2(arg1_13.x * arg2.y - arg1_13.y * arg2.x, arg1_13.x * arg2.x + arg1_13.y * arg2.y)
    end
    local function get2DWeight_upvr(arg1_14, arg2, arg3, arg4, arg5, arg6) -- Line 450, Named "get2DWeight"
        local var204 = 0.5 * (arg5 + arg6)
        local module = {
            x = (arg4 - arg5) / var204;
            y = 2 * -math.atan2(arg2.x * arg1_14.y - arg2.y * arg1_14.x, arg2.x * arg1_14.x + arg2.y * arg1_14.y);
        }
        local module_2 = {
            x = (arg6 - arg5) / var204;
            y = 2 * -math.atan2(arg2.x * arg3.y - arg2.y * arg3.x, arg2.x * arg3.x + arg2.y * arg3.y);
        }
        return math.clamp(1 - (module.x * module_2.x + module.y * module_2.y) / ((0.0001) + (module_2.x * module_2.x + module_2.y * module_2.y)), 0, 1)
    end
    local function blend2D_upvr(arg1_15, arg2) -- Line 461, Named "blend2D"
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local tbl = {}
        local var235
        for i_17, v_16 in pairs(var105_upvw) do
            if arg1_15.x * v_16.lv.x < 0 or arg1_15.y * v_16.lv.y < 0 then
                tbl[i_17] = 0
            else
                tbl[i_17] = math.huge
                for _, v_17 in pairs(var105_upvw) do
                    if arg1_15.x * v_17.lv.x >= 0 and arg1_15.y * v_17.lv.y >= 0 then
                        tbl[i_17] = math.min(tbl[i_17], get2DWeight_upvr(arg1_15, v_16.lv, v_17.lv, arg2, v_16.speed, v_17.speed))
                    end
                end
                var235 += tbl[i_17]
            end
        end
        local pairs_result1_2, pairs_result2, pairs_result3_2 = pairs(var105_upvw)
        for i_19, v_18 in pairs_result1_2, pairs_result2, pairs_result3_2 do
            if 0.1 < tbl[i_19] / var235 then
                local var242 = 0 + tbl[i_19] * v_18.lv.x
                local var243 = 0 + tbl[i_19] * v_18.lv.y
            else
                tbl[i_19] = 0
            end
        end
        pairs_result1_2 = nil
        local var244 = pairs_result1_2
        local var245 = var242 * var242 + var243 * var243
        if 0.0001 < var245 then
            var244 = math.sqrt(arg2 * arg2 / var245)
        else
            var244 = 0
        end
        if Humanoid_upvr then
            local var246
            if not var246 then
            else
                var246 = Humanoid_upvr.HipHeight / 2
                if ScaleDampeningPercent_upvw == nil then
                    ScaleDampeningPercent_upvw = Humanoid_upvr:FindFirstChild("ScaleDampeningPercent")
                end
                if ScaleDampeningPercent_upvw ~= nil then
                    var246 = 1 + Humanoid_upvr.HipHeight - 2 * ScaleDampeningPercent_upvw.Value / 2
                end
            end
        else
        end
        local pairs_result1_4, pairs_result2_3, pairs_result3 = pairs(var105_upvw)
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        if ScaleDampeningPercent_upvw.Value then
            local _, _, _ = pairs(var105_upvw)
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    local function getWalkDirection_upvr() -- Line 527, Named "getWalkDirection"
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local WalkToPoint = Humanoid_upvr.WalkToPoint
        local WalkToPart = Humanoid_upvr.WalkToPart
        if Humanoid_upvr.MoveDirection ~= Vector3.new(0, 0, 0) then
            do
                return Humanoid_upvr.MoveDirection
            end
            local _
        end
        if WalkToPart or WalkToPoint ~= Vector3.new(0, 0, 0) then
            if WalkToPart then
            else
            end
            if Humanoid_upvr.RootPart then
                local var263 = WalkToPoint - Humanoid_upvr.RootPart.CFrame.Position
                local vector3 = Vector3.new(var263.x, 0, var263.z)
                local Magnitude = vector3.Magnitude
                if 0.01 < Magnitude then
                end
            end
            return vector3 / Magnitude
        end
        return Humanoid_upvr.MoveDirection
    end
    local function updateVelocity_upvr(arg1_16) -- Line 554, Named "updateVelocity"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [130.7]
        tbl_upvw = nil
        var47_upvw = const_number_upvw
        var49_upvw = arg1_16
        blend2D_upvr(tbl_upvw, var47_upvw)
        do
            return
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if 0.01 < math.abs(const_number_upvw - var47_upvw) or 1 < arg1_16 - var49_upvw then
            var47_upvw = const_number_upvw
            var49_upvw = arg1_16
            blend2D_upvr(Vector2.yAxis, var47_upvw)
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    local function _(arg1_17) -- Line 604, Named "setAnimationSpeed"
        if var50_upvw ~= "walk" and arg1_17 ~= var54_upvw then
            var54_upvw = arg1_17
            var52_upvw:AdjustSpeed(var54_upvw)
        end
    end
    local playAnimation_upvw
    local function keyFrameReachedFunc_upvr(arg1_18) -- Line 613, Named "keyFrameReachedFunc"
        if arg1_18 == "End" then
            local var267
            if tbl_5_upvr[var50_upvw] ~= nil and tbl_5_upvr[var267] == false then
                var267 = "idle"
            end
            if var194_upvw then
                if var52_upvw.Looped then return end
                var267 = "idle"
                var194_upvw = false
            end
            local var268 = var54_upvw
            playAnimation_upvw(var267, 0.15, Humanoid_upvr)
            if var50_upvw ~= "walk" and var268 ~= var54_upvw then
                var54_upvw = var268
                var52_upvw:AdjustSpeed(var54_upvw)
            end
        end
    end
    local function rollAnimation_upvr(arg1_19) -- Line 637, Named "rollAnimation"
        local var270
        while tbl_2_upvr[arg1_19][var270].weight < math.random(1, tbl_2_upvr[arg1_19].totalWeight) do
            var270 += 1
        end
        return var270
    end
    local function switchToAnim_upvr(arg1_20, arg2, arg3, arg4) -- Line 648, Named "switchToAnim"
        if arg1_20 ~= var51_upvw then
            if var52_upvw ~= nil then
                var52_upvw:Stop(arg3)
                var52_upvw:Destroy()
            end
            if var53_upvw ~= nil then
                var53_upvw:disconnect()
            end
            var54_upvw = 1
            var50_upvw = arg2
            var51_upvw = arg1_20
            if arg2 == "walk" then
                setupWalkAnimations_upvr()
                return
            end
            destroyWalkAnimations_upvr()
            var52_upvw = arg4:LoadAnimation(arg1_20)
            var52_upvw.Priority = Enum.AnimationPriority.Core
            var52_upvw:Play(arg3)
            var53_upvw = var52_upvw.KeyframeReached:connect(keyFrameReachedFunc_upvr)
        end
    end
    function playAnimation_upvw(arg1_21, arg2, arg3) -- Line 680, Named "playAnimation"
        switchToAnim_upvr(tbl_2_upvr[arg1_21][rollAnimation_upvr(arg1_21)].anim, arg1_21, arg2, arg3)
        var194_upvw = false
    end
    local var271_upvw = playAnimation_upvw
    local var272_upvw = ""
    local var273_upvw
    local var274_upvw
    local var275_upvw
    local playToolAnimation_upvw
    local function toolKeyFrameReachedFunc_upvr(arg1_22) -- Line 698, Named "toolKeyFrameReachedFunc"
        if arg1_22 == "End" then
            playToolAnimation_upvw(var272_upvw, 0, Humanoid_upvr)
        end
    end
    function playToolAnimation_upvw(arg1_23, arg2, arg3, arg4) -- Line 704, Named "playToolAnimation"
        local anim = tbl_2_upvr[arg1_23][rollAnimation_upvr(arg1_23)].anim
        local var278
        if var274_upvw ~= anim then
            if var273_upvw ~= nil then
                var273_upvw:Stop()
                var273_upvw:Destroy()
                var278 = 0
            end
            var273_upvw = arg3:LoadAnimation(anim)
            if arg4 then
                var273_upvw.Priority = arg4
            end
            var273_upvw:Play(var278)
            var272_upvw = arg1_23
            var274_upvw = anim
            var275_upvw = var273_upvw.KeyframeReached:connect(toolKeyFrameReachedFunc_upvr)
        end
    end
    local function _() -- Line 730, Named "stopToolAnimations"
        if var275_upvw ~= nil then
            var275_upvw:disconnect()
        end
        var272_upvw = ""
        var274_upvw = nil
        if var273_upvw ~= nil then
            var273_upvw:Stop()
            var273_upvw:Destroy()
            var273_upvw = nil
        end
        return var272_upvw
    end
    local function animateTool_upvr() -- Line 825, Named "animateTool"
        if var192_upvw == "None" then
            playToolAnimation_upvw("toolnone", 0.1, Humanoid_upvr, Enum.AnimationPriority.Idle)
        else
            if var192_upvw == "Slash" then
                playToolAnimation_upvw("toolslash", 0, Humanoid_upvr, Enum.AnimationPriority.Action)
                return
            end
            if var192_upvw == "Lunge" then
                playToolAnimation_upvw("toollunge", 0, Humanoid_upvr, Enum.AnimationPriority.Action)
                return
            end
        end
    end
    local function getToolAnim_upvr(arg1_27) -- Line 842, Named "getToolAnim"
        for _, v_19 in ipairs(arg1_27:GetChildren()) do
            if v_19.Name == "toolanim" and v_19.className == "StringValue" then
                return v_19
            end
        end
        return nil
    end
    local var286_upvw = 0
    local var287_upvw = 0
    local function stepAnimate_upvr(arg1_28) -- Line 853, Named "stepAnimate"
        var286_upvw = arg1_28
        if 0 < var193_upvw then
            var193_upvw -= arg1_28 - var286_upvw
        end
        if var44_upvw == "FreeFall" and var193_upvw <= 0 then
            var271_upvw("fall", 0.2, Humanoid_upvr)
        else
            if var44_upvw == "Seated" then
                var271_upvw("sit", 0.5, Humanoid_upvr)
                return
            end
            if var44_upvw == "Running" then
                var271_upvw("walk", 0.2, Humanoid_upvr)
                updateVelocity_upvr(arg1_28)
            elseif var44_upvw == "Dead" or var44_upvw == "GettingUp" or var44_upvw == "FallingDown" or var44_upvw == "Seated" or var44_upvw == "PlatformStanding" then
                stopAllAnimations_upvr()
            end
        end
        local class_Tool = arg1:FindFirstChildOfClass("Tool")
        if class_Tool and class_Tool:FindFirstChild("Handle") then
            local getToolAnim_result1 = getToolAnim_upvr(class_Tool)
            if getToolAnim_result1 then
                var192_upvw = getToolAnim_result1.Value
                getToolAnim_result1.Parent = nil
                var287_upvw = arg1_28 + 0.3
            end
            if var287_upvw < arg1_28 then
                var287_upvw = 0
                var192_upvw = "None"
            end
            animateTool_upvr()
        else
            if var275_upvw ~= nil then
                var275_upvw:disconnect()
            end
            var272_upvw = ""
            var274_upvw = nil
            if var273_upvw ~= nil then
                var273_upvw:Stop()
                var273_upvw:Destroy()
                var273_upvw = nil
            end
            var192_upvw = "None"
            var274_upvw = nil
            var287_upvw = 0
        end
    end
    any_new_result1_upvr:GiveTask(Humanoid_upvr.Died:connect(function() -- Line 770, Named "onDied"
        var44_upvw = "Dead"
    end))
    any_new_result1_upvr:GiveTask(Humanoid_upvr.Running:connect(function(arg1_24) -- Line 752, Named "onRunning"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if Humanoid_upvr.MoveDirection ~= Vector3.new(0, 0, 0) then
        else
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end))
    any_new_result1_upvr:GiveTask(Humanoid_upvr.Jumping:connect(function() -- Line 774, Named "onJumping"
        var271_upvw("jump", 0.1, Humanoid_upvr)
        var193_upvw = 0.31
        var44_upvw = "Jumping"
    end))
    any_new_result1_upvr:GiveTask(Humanoid_upvr.Climbing:connect(function(arg1_25) -- Line 780, Named "onClimbing"
        var271_upvw("climb", 0.1, Humanoid_upvr)
        local var279 = arg1_25 / 5
        if var50_upvw ~= "walk" and var279 ~= var54_upvw then
            var54_upvw = var279
            var52_upvw:AdjustSpeed(var54_upvw)
        end
        var44_upvw = "Climbing"
    end))
    any_new_result1_upvr:GiveTask(Humanoid_upvr.GettingUp:connect(function() -- Line 787, Named "onGettingUp"
        var44_upvw = "GettingUp"
    end))
    any_new_result1_upvr:GiveTask(Humanoid_upvr.FreeFalling:connect(function() -- Line 791, Named "onFreeFall"
        if var193_upvw <= 0 then
            var271_upvw("fall", 0.2, Humanoid_upvr)
        end
        var44_upvw = "FreeFall"
    end))
    any_new_result1_upvr:GiveTask(Humanoid_upvr.FallingDown:connect(function() -- Line 798, Named "onFallingDown"
        var44_upvw = "FallingDown"
    end))
    any_new_result1_upvr:GiveTask(Humanoid_upvr.Seated:connect(function() -- Line 802, Named "onSeated"
        var44_upvw = "Seated"
    end))
    any_new_result1_upvr:GiveTask(Humanoid_upvr.PlatformStanding:connect(function() -- Line 806, Named "onPlatformStanding"
        var44_upvw = "PlatformStanding"
    end))
    any_new_result1_upvr:GiveTask(Humanoid_upvr.Swimming:connect(function(arg1_26) -- Line 813, Named "onSwimming"
        if 1 < arg1_26 then
            var271_upvw("swim", 0.4, Humanoid_upvr)
            local var280 = arg1_26 / 10
            if var50_upvw ~= "walk" and var280 ~= var54_upvw then
                var54_upvw = var280
                var52_upvw:AdjustSpeed(var54_upvw)
            end
            var44_upvw = "Swimming"
        else
            var271_upvw("swimidle", 0.4, Humanoid_upvr)
            var44_upvw = "Standing"
        end
    end))
    if arg1.Parent ~= nil then
        var271_upvw("idle", 0.1, Humanoid_upvr)
        var44_upvw = "Standing"
    end
    any_new_result1_upvr:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 932
        if arg1.Parent == nil then
            any_new_result1_upvr:DoCleaning()
        else
            stepAnimate_upvr(os.clock())
        end
    end))
    any_new_result1_upvr:GiveTask(function() -- Line 940
        task.defer(function() -- Line 941
            if var37_upvw then
                for _, v_20 in var37_upvw:GetPlayingAnimationTracks() do
                    v_20:Stop(0)
                    v_20:Destroy()
                end
            end
        end)
    end)
    return {
        Destroy = function(arg1_29) -- Line 952, Named "Destroy"
            any_new_result1_upvr:DoCleaning()
        end;
    }
end