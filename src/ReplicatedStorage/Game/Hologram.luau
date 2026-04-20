local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Logic_upvr = require(ReplicatedStorage_upvr.Module.Logic)
local Players_upvr = game:GetService("Players")
local Localization_upvr = require(ReplicatedStorage_upvr.Module.Localization)
local abs_upvr = math.abs
local function _(arg1) -- Line 14, Named "comma"
    local string_match_result1_4, string_match_result2_3, string_match_result3_2 = string.match(arg1, "^([^%d]*%d)(%d*)(.-)$")
    return string_match_result1_4..string_match_result2_3:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3_2
end
local function _(arg1) -- Line 18, Named "FormatMoney"
    local var9
    if 0 <= arg1 then
        var9 = ""
    else
        var9 = '-'
    end
    local module = {}
    local string_match_result1_2, string_match_result2_4, string_match_result3_4 = string.match(abs_upvr(arg1), "^([^%d]*%d)(%d*)(.-)$")
    module[1] = string_match_result1_2..string_match_result2_4:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3_4
    return var9..Localization_upvr:FormatByKey("General.Cash", module)
end
local function MakeSystem_upvr() -- Line 24, Named "MakeSystem"
    local module_3 = {
        Scale = 0.015625;
        Nodes = {};
        Center = CFrame.new();
        Model = Instance.new("Model");
        LastRender = 0;
        PlayerNodes = {};
    }
    module_3.Model.Name = "Hologram"
    module_3.Model.Parent = workspace
    return module_3
end
local tbl_2_upvr = {}
local function DestroySystem_upvr(arg1) -- Line 38, Named "DestroySystem"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local _ = #tbl_2_upvr
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [15.989856077]
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local function _(arg1, arg2) -- Line 57, Named "SetNodeColor"
    local Part_6 = arg1.Part
    local r = arg2.r
    local g_3 = arg2.g
    local b_3 = arg2.b
    Part_6.Color = Color3.new(r, g_3, b_3)
    Part_6.SelectionBox.Color3 = Color3.new(r + 0.2, g_3 + 0.2, b_3 + 0.2)
end
local function ConstructNode_upvr(arg1, arg2) -- Line 64, Named "ConstructNode"
    local Part_8 = Instance.new("Part")
    Part_8.Transparency = 0
    Part_8.Material = Enum.Material.SmoothPlastic
    Part_8.CanCollide = false
    Part_8.Anchored = true
    Part_8.TopSurface = 0
    Part_8.BottomSurface = 0
    local SelectionBox = Instance.new("SelectionBox")
    SelectionBox.Parent = Part_8
    SelectionBox.Adornee = Part_8
    SelectionBox.LineThickness = 0.0001
    arg1.Part = Part_8
    local Part_5 = arg1.Part
    local r_2 = arg2.r
    local g_2 = arg2.g
    local b = arg2.b
    Part_5.Color = Color3.new(r_2, g_2, b)
    Part_5.SelectionBox.Color3 = Color3.new(r_2 + 0.2, g_2 + 0.2, b + 0.2)
end
local function _(arg1, arg2) -- Line 82, Named "MakeNode"
    local module_2 = {}
    module_2.c = arg1
    module_2.s = arg2
    return module_2
end
local function _(arg1, arg2) -- Line 89, Named "HorizontalDistance"
    return ((arg1 - arg2) * Vector3.new(1, 0, 1)).Magnitude
end
local function _(arg1, arg2) -- Line 92, Named "CloseToAny"
    for _, v in next, arg2 do
        if ((v.Position - arg1.Position) * Vector3.new(1, 0, 1)).Magnitude < 100 then
            return true
        end
    end
    return false
end
local function SimplifyCityParts_upvw(arg1, arg2) -- Line 100, Named "SimplifyCityParts"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [66.3]
    local any_MultiAABB_result1, any_MultiAABB_result2 = Logic_upvr.MultiAABB(nil)
    local var33 = {
        c = any_MultiAABB_result1;
        s = any_MultiAABB_result2;
    }
    local floored_2 = math.floor(math.random() * 30)
    ConstructNode_upvr(var33, Color3.fromRGB(floored_2 + 33, floored_2 + 84, floored_2 + 185))
    var33.Part.Parent = arg1.Model
    table.insert(arg1.Nodes, var33)
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [105.65666]
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local function _(arg1, arg2) -- Line 123, Named "SimplifyTrees"
    for _, v_2 in next, arg2:GetChildren() do
        local any_MultiAABB_result1_2, any_MultiAABB_result2_2 = Logic_upvr.MultiAABB(v_2:GetChildren())
        local var42 = {
            c = any_MultiAABB_result1_2;
            s = any_MultiAABB_result2_2;
        }
        local floored_3 = math.floor(math.random() * 30)
        ConstructNode_upvr(var42, Color3.fromRGB(floored_3 + 30, floored_3 + 30, floored_3 + 30))
        var42.Part.Parent = arg1.Model
        table.insert(arg1.Nodes, var42)
    end
end
local tbl_6_upvr = {{
    Color = Color3.fromRGB(255, 176, 0);
    Loc = {{
        c = CFrame.new(-1306.4353, 27.0160275, -1588.15491, 0, 0, 0.999999821, 0, 1, 0, -0.999999821, 0, 0);
        s = Vector3.new(70.6999, 22.1000, 104.200);
    }, {
        c = CFrame.new(-1418.48523, 35.1660271, -1790.30481, 0, 0, 0.999999821, 0, 1, 0, -0.999999821, 0, 0);
        s = Vector3.new(238.199, 38.4000, 130.300);
    }, {
        c = CFrame.new(-1180.7854, 27.0160275, -1583.95483, 0, 0, 0.999999821, 0, 1, 0, -0.999999821, 0, 0);
        s = Vector3.new(62.2999, 22.1000, 97.7000);
    }, {
        c = CFrame.new(-1159.08545, 36.4160271, -1572.70496, 0, 0, 0.999999821, 0, 1, 0, -0.999999821, 0, 0);
        s = Vector3.new(57.5999, 40.9000, 54.3000);
    }};
}, {
    Color = Color3.fromRGB(33, 84, 185);
    Loc = {{
        c = CFrame.new(-1414.62683, 29.2624836, 240.934875, 0.974374056, 0, -0.224932864, 0, 1, 0, 0.224932864, 0, 0.974374056);
        s = Vector3.new(72.0999, 18.1499, 21.2499);
    }, {
        c = CFrame.new(1626.70471, 23.6678162, 321.181366, -0.0703834072, 3.45619391e-08, 0.997519851, 1.21779853e-09, 1, -3.45619462e-08, -0.99752003, -1.21779953e-09, -0.0703832731);
        s = Vector3.new(98.6999, 20.6000, 32.4999);
    }, {
        c = CFrame.new(1609.9812, 24.7178154, 236.899399, -0.0703834072, 3.45619391e-08, 0.997519851, 1.21779853e-09, 1, -3.45619462e-08, -0.99752003, -1.21779953e-09, -0.0703832731);
        s = Vector3.new(21.7999, 22.7000, 54);
    }};
}, {
    Color = Color3.fromRGB(10, 245, 10);
    Loc = {{
        c = CFrame.new(261.724365, 22.0178318, -1759.17798, -1.78813934e-07, 0, 0.999999464, 0, 1, 0, -0.999999464, 0, -1.78813934e-07);
        s = Vector3.new(43.2999, 14.7000, 70.3999);
    }, {
        c = CFrame.new(-1577.18359, 27.4110489, 703.805176, -0.156434387, 0, 0.987687826, 0, 1, 0, -0.987687826, 0, -0.156434387);
        s = Vector3.new(60.0999, 27.2000, 30.2999);
    }, {
        c = CFrame.new(119.976921, 55.0110474, 1313.11108, -0.156433716, 0, 0.987683594, 0, 1, 0, -0.987683594, 0, -0.156433716);
        s = Vector3.new(82.1999, 82.4000, 51.1999);
    }, {
        c = CFrame.new(1084.36975, 116.81105, 1211.08044, 0.615661383, 0, 0.788010776, 0, 1, 0, -0.788010776, 0, 0.615661442);
        s = Vector3.new(148.699, 40.5000, 85.8999);
    }, {
        c = CFrame.new(49.8085251, 87.265625, 829.535156, 0.0348739922, 0, 0.999391735, 0, 1, 0, -0.999391735, 0, 0.0348739922);
        s = Vector3.new(68.2000, 145.300, 69.3999);
    }};
}, {
    Color = Color3.fromRGB(151, 0, 0);
    Loc = {{
        c = CFrame.new(1030.40198, 170.611053, 1115.61755, 0.615661263, 0, 0.788010716, 0, 1, 0, -0.788010776, 0, 0.615661502);
        s = Vector3.new(22.0999, 148.100, 21.6999);
    }};
}}
local function SimplifyExtra_upvw(arg1) -- Line 353, Named "SimplifyExtra"
    for _, v_3 in next, tbl_6_upvr do
        for _, v_4 in next, v_3.Loc do
            local floored = math.floor(math.random() * 30 / 255)
            local var72 = {
                c = v_4.c;
                s = v_4.s;
            }
            local Color = v_3.Color
            ConstructNode_upvr(var72, Color3.new(Color.r + floored, Color.g + floored, Color.b + floored))
            var72.Part.Parent = arg1.Model
            table.insert(arg1.Nodes, var72)
        end
    end
end
function tbl_6_upvr(arg1) -- Line 367, Named "RenderSystem"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local Scale_2 = arg1.Scale
    for _, v_5 in next, arg1.Nodes do
        local c = v_5.c
        local Part_2 = v_5.Part
        local var157 = c + c.p * (Scale_2 - 1)
        local _lastSize_2 = v_5._lastSize
        local var159 = v_5.s * Scale_2
        if not _lastSize_2 or 0.001 < (_lastSize_2 - var159).Magnitude then
            Part_2.Size = var159
            v_5._lastSize = var159
        end
        Part_2.CFrame = arg1.Center * var157 * CFrame.new(0, math.cos((0.1) * ((var157.p.Magnitude) / (64 * Scale_2)) + 2 * tick()) * 0.2, 0)
    end
    local PlayerNodes_2 = arg1.PlayerNodes
    for _, v_6 in next, Players_upvr:GetPlayers() do
        local Name_2 = v_6.Name
        local Character_2 = v_6.Character
        if Character_2 then
            local PrimaryPart_2 = Character_2.PrimaryPart
            if PrimaryPart_2 then
                ({})[Name_2] = true
                local var166
                if PlayerNodes_2[Name_2] then
                    PlayerNodes_2[Name_2].c = PrimaryPart_2.CFrame
                else
                    local tbl = {}
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    tbl.c = PrimaryPart_2.CFrame
                    tbl.s = PrimaryPart_2.Size
                    tbl.IsPolice = false
                    local var168 = tbl
                    PlayerNodes_2[Name_2] = var168
                    var166 = 20
                    ConstructNode_upvr(var168, Color3.fromRGB(240, 20, var166))
                    var168.Part.Parent = arg1.Model
                end
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                local var169 = tick() % (-math.pi*2)
                local Part_3 = var168.Part
                local c_2 = var168.c
                Part_3.Size = Vector3.new(1, 1, 1) * ((math.cos(8 * var169) * 0.5 + 0.5) * 0.5 + 0.3) * 64 * Scale_2
                Part_3.CFrame = arg1.Center * (c_2 + c_2.p * (Scale_2 - 1)) * CFrame.Angles(0, 4 * var169, 0) * CFrame.Angles(0.7853981633974483, 0, 0.7853981633974483)
                local TeamValue = v_6:FindFirstChild("TeamValue")
                if TeamValue then
                    if TeamValue.Value ~= "Police" then
                        local _ = false
                        -- KONSTANTWARNING: Skipped task `defvar` above
                    else
                    end
                    if not var168.BountyGui then
                        local clone_2 = ReplicatedStorage_upvr.Resource.HologramBounty:Clone()
                        clone_2.Parent = Part_3
                        clone_2.Frame.Player.Text = v_6.DisplayName
                        var168.BountyGui = clone_2
                    end
                    local var175
                    if var168.Bounty and not true then
                        var168.BountyGui.Frame.Bounty.Visible = true
                        local Bounty_2 = var168.Bounty
                        if 0 <= Bounty_2 then
                            var175 = ""
                        else
                            var175 = '-'
                        end
                        local tbl_3 = {}
                        local string_match_result1_3, string_match_result2_2, string_match_result3_3 = string.match(abs_upvr(Bounty_2), "^([^%d]*%d)(%d*)(.-)$")
                        tbl_3[1] = string_match_result1_3..string_match_result2_2:reverse():gsub("(%d%d%d)", "%1,"):reverse()..string_match_result3_3
                        var168.BountyGui.Frame.Bounty.Text = var175..Localization_upvr:FormatByKey("General.Cash", tbl_3)
                    else
                        var168.BountyGui.Frame.Bounty.Visible = false
                    end
                    local var181
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    if var181 ~= true then
                        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                        var168.IsPolice = true
                        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                        local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                            var181 = var181(1, 1, var175)
                            var175 = 1
                            var181 = Color3.new
                            return var181
                        end
                        if not true or not decompInlinedCondition_2() then
                            var181 = Color3.fromRGB
                            var175 = 20
                            var181 = var181(240, 20, var175)
                        end
                        local Part_9 = var168.Part
                        var175 = var181.r
                        local g_4 = var181.g
                        local b_4 = var181.b
                        Part_9.Color = Color3.new(var175, g_4, b_4)
                        Part_9.SelectionBox.Color3 = Color3.new(var175 + 0.2, g_4 + 0.2, b_4 + 0.2)
                        var168.BountyGui.Frame.Player.TextColor3 = var181
                    end
                end
            end
        end
    end
    for i_7, _ in next, PlayerNodes_2 do
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        if not ({})[i_7] then
            local var185 = PlayerNodes_2[i_7]
            if var185.BountyGui then
                var185.BountyGui:Destroy()
            end
            var185.Part:Destroy()
            PlayerNodes_2[i_7] = nil
        end
    end
end
local BountyBoardService_upvr = require(ReplicatedStorage_upvr.Bounty.BountyBoardService)
local CollectionService_upvr = game:GetService("CollectionService")
local CurrentCamera_upvr = workspace.CurrentCamera
local RunService_upvr = game:GetService("RunService")
return {
    Init = function() -- Line 459, Named "Init"
        BountyBoardService_upvr.onBountiesUpdated:Connect(function(arg1) -- Line 460
            for _, v_8 in next, tbl_2_upvr do
                for _, v_9 in arg1 do
                    local var199 = v_8.PlayerNodes[v_9.Name]
                    if var199 then
                        var199.Bounty = v_9.Bounty
                    end
                end
            end
        end)
        local tbl_upvr = {}
        local tbl_upvr_2 = {}
        for _, v_10 in next, CollectionService_upvr:GetTagged("MapHologram") do
            table.insert(tbl_upvr, v_10)
        end
        CollectionService_upvr:GetInstanceAddedSignal("MapHologram"):Connect(function(arg1) -- Line 473, Named "AddedFun"
            table.insert(tbl_upvr, arg1)
        end)
        CollectionService_upvr:GetInstanceRemovedSignal("MapHologram"):Connect(function(arg1) -- Line 476, Named "RemovedFun"
            for i_10 = #tbl_upvr, 1, -1 do
                if tbl_upvr[i_10] == arg1 then
                    table.remove(tbl_upvr, i_10)
                    local var203 = tbl_upvr_2[arg1]
                    if var203 then
                        DestroySystem_upvr(var203)
                    end
                    return
                end
            end
        end)
        local tick_result1_2_upvw = tick()
        RunService_upvr.Heartbeat:Connect(function() -- Line 497, Named "Heartbeat"
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            debug.profilebegin("Hologram")
            local tick_result1 = tick()
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            for _, v_11 in next, tbl_2_upvr do
                local var212 = 1
                local Magnitude = (v_11.Center.p - CurrentCamera_upvr.CFrame.p).Magnitude
                if Magnitude < 100 then
                    var212 = 0
                elseif Magnitude < 300 then
                    var212 = 0.1
                elseif Magnitude < 500 then
                    var212 = 0.2
                end
                if var212 < tick_result1 - v_11.LastRender then
                    v_11.LastRender = tick_result1
                    tbl_6_upvr(v_11)
                end
            end
            debug.profileend()
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end)
    end;
}