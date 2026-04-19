-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

local l_exp_0 = math.exp;
local l_cos_0 = math.cos;
local l_sin_0 = math.sin;
local v3 = {};
v3.__index = v3;
v3.new = function(v4, v5, v6, v7) --[[ Line: 8 ]] --[[ Name: new ]]
    -- upvalues: v3 (copy)
    assert(v4);
    assert(v5);
    assert(v6);
    assert(v7);
    local v8 = setmetatable({}, v3);
    v8.p = v4;
    v8.v = v5;
    v8.Target = v8.p;
    v8.Freq = v7;
    v8.Damp = v6;
    v8.t = tick();
    return v8;
end;
v3.Update = function(v9) --[[ Line: 22 ]] --[[ Name: Update ]]
    -- upvalues: l_exp_0 (copy), l_cos_0 (copy), l_sin_0 (copy)
    local v10 = tick() - v9.t;
    local l_Freq_0 = v9.Freq;
    local l_Damp_0 = v9.Damp;
    local l_p_0 = v9.p;
    local l_v_0 = v9.v;
    local l_Target_0 = v9.Target;
    local v16 = l_p_0 - l_Target_0;
    local l_l_v_0_0 = l_v_0;
    if l_Damp_0 > 1 then
        local v18 = -l_Freq_0 * l_Damp_0;
        local v19 = l_Freq_0 * (l_Damp_0 * l_Damp_0 - 1) ^ 0.5;
        local v20 = v18 - v19;
        local v21 = v18 + v19;
        local v22 = l_exp_0(v20 * v10);
        local v23 = l_exp_0(v21 * v10);
        local v24 = (l_l_v_0_0 - v16 * v21) / (-2 * v19);
        local v25 = v16 - v24;
        return l_Target_0 + v24 * v22 + v25 * v23, v24 * v20 * v22 + v25 * v21 * v23;
    elseif l_Damp_0 == 1 then
        local v26 = l_exp_0(-l_Freq_0 * v10);
        local v27 = l_l_v_0_0 + l_Freq_0 * v16;
        local v28 = (v27 * v10 + v16) * v26;
        return l_Target_0 + v28, v27 * v26 - v28 * l_Freq_0;
    else
        local v29 = l_Freq_0 * l_Damp_0;
        local v30 = l_Freq_0 * (1 - l_Damp_0 * l_Damp_0) ^ 0.5;
        local v31 = l_exp_0(-v29 * v10);
        local v32 = l_cos_0(v30 * v10);
        local v33 = l_sin_0(v30 * v10);
        local v34 = (l_l_v_0_0 + v29 * v16) / v30;
        return l_Target_0 + v31 * (v16 * v32 + v34 * v33), -v31 * ((v16 * v29 - v34 * v30) * v32 + (v16 * v30 + v34 * v29) * v33);
    end;
end;
v3.SetTarget = function(v35, v36) --[[ Line: 67 ]] --[[ Name: SetTarget ]]
    local v37, v38 = v35:Update();
    v35.p = v37;
    v35.v = v38;
    v35.Target = v36;
    v35.t = tick();
    return v37, v38;
end;
v3.Accelerate = function(v39, v40) --[[ Line: 74 ]] --[[ Name: Accelerate ]]
    local v41, v42 = v39:Update();
    v39.t = tick();
    local v43 = v42 + v40;
    v39.p = v41;
    v39.v = v43;
end;
v3.ForceTarget = function(v44, v45) --[[ Line: 79 ]] --[[ Name: ForceTarget ]]
    local v46 = v45 * 0;
    v44.p = v45;
    v44.v = v46;
    v44.Target = v44.p;
    v44.t = tick();
end;
v3.SetConsts = function(v47, v48, v49) --[[ Line: 84 ]] --[[ Name: SetConsts ]]
    local v50, v51 = v47:Update();
    v47.p = v50;
    v47.v = v51;
    v47.Damp = v48;
    v47.Freq = v49;
    v47.t = tick();
    return v50, v51;
end;
return v3;