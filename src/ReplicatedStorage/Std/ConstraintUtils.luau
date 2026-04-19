-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

local v5 = {
    customWeld = function(v0, v1, v2, v3) --[[ Line: 4 ]] --[[ Name: customWeld ]]
        local l_Weld_0 = Instance.new("Weld");
        l_Weld_0.Name = ("%s->%s"):format(v0.Name, v1.Name);
        l_Weld_0.Part0 = v0;
        l_Weld_0.Part1 = v1;
        if v2 then
            l_Weld_0.C0 = v2;
        end;
        if v3 then
            l_Weld_0.C1 = v3;
        end;
        l_Weld_0.Parent = v0;
        return l_Weld_0;
    end
};
v5.blankWeld = function(v6, v7) --[[ Line: 19 ]] --[[ Name: blankWeld ]]
    -- upvalues: v5 (copy)
    return v5.customWeld(v6, v7, nil, nil);
end;
v5.weld = function(v8, v9) --[[ Line: 23 ]] --[[ Name: weld ]]
    -- upvalues: v5 (copy)
    return v5.customWeld(v8, v9, v8.CFrame:ToObjectSpace(v9.CFrame), nil);
end;
v5.weldModel = function(v10, v11) --[[ Line: 27 ]] --[[ Name: weldModel ]]
    -- upvalues: v5 (copy)
    local l_PrimaryPart_0 = v10.PrimaryPart;
    if l_PrimaryPart_0 == nil then
        error("Missing `PrimaryPart` of root model.");
    end;
    for _, v14 in ipairs(v10:GetChildren()) do
        if v14:IsA("BasePart") then
            if v14 ~= l_PrimaryPart_0 then
                v5.weld(v14, l_PrimaryPart_0);
                v14.Anchored = false;
            end;
        elseif v14:IsA("Model") and not v11 then
            if v14.PrimaryPart then
                v5.weldModel(v14);
                v5.weld(v14.PrimaryPart, l_PrimaryPart_0);
            else
                warn(("Skipping %s, no primary part"):format(v14.Name));
            end;
        end;
    end;
    l_PrimaryPart_0.Anchored = false;
end;
v5.customMotor = function(v15, v16, v17, v18) --[[ Line: 50 ]] --[[ Name: customMotor ]]
    local l_Motor_0 = Instance.new("Motor");
    l_Motor_0.Name = ("%s->%s"):format(v15.Name, v16.Name);
    l_Motor_0.Part0 = v15;
    l_Motor_0.Part1 = v16;
    if v17 then
        l_Motor_0.C0 = v17;
    end;
    if v18 then
        l_Motor_0.C1 = v18;
    end;
    l_Motor_0.Parent = v15;
    return l_Motor_0;
end;
v5.blankMotor = function(v20, v21) --[[ Line: 65 ]] --[[ Name: blankMotor ]]
    -- upvalues: v5 (copy)
    return v5.customMotor(v20, v21, nil, nil);
end;
v5.motor = function(v22, v23) --[[ Line: 69 ]] --[[ Name: motor ]]
    -- upvalues: v5 (copy)
    return v5.customMotor(v22, v23, v22.CFrame:ToObjectSpace(v23.CFrame), nil);
end;
return v5;