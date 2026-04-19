-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

local v17 = {
    fromArray = function(v0) --[[ Line: 3 ]] --[[ Name: fromArray ]]
        local v1 = {};
        for _, v3 in ipairs(v0) do
            v1[v3] = true;
        end;
        return v1;
    end, 
    subtract = function(v4, v5) --[[ Line: 11 ]] --[[ Name: subtract ]]
        if #v4 ~= 0 then
            error("`first` has nonzero length, is it a set?");
        end;
        if #v5 ~= 0 then
            error("`second` has nonzero length, is it a set?");
        end;
        local v6 = {};
        for v7 in pairs(v4) do
            if not v5[v7] then
                v6[v7] = true;
            end;
        end;
        return v6;
    end, 
    intersect = function(v8, v9) --[[ Line: 26 ]] --[[ Name: intersect ]]
        if #v8 ~= 0 then
            error("`first` has nonzero length, is it a set?");
        end;
        if #v9 ~= 0 then
            error("`second` has nonzero length, is it a set?");
        end;
        local v10 = {};
        for v11 in pairs(v8) do
            if v9[v11] then
                v10[v11] = true;
            end;
        end;
        return v10;
    end, 
    union = function(v12, v13) --[[ Line: 41 ]] --[[ Name: union ]]
        if #v12 ~= 0 then
            error("`first` has nonzero length, is it a set?");
        end;
        if #v13 ~= 0 then
            error("`second` has nonzero length, is it a set?");
        end;
        local v14 = {};
        for v15 in pairs(v12) do
            v14[v15] = true;
        end;
        for v16 in pairs(v13) do
            v14[v16] = true;
        end;
        return v14;
    end
};
v17.symmetricDiff = function(v18, v19) --[[ Line: 57 ]] --[[ Name: symmetricDiff ]]
    -- upvalues: v17 (copy)
    if #v18 ~= 0 then
        error("`first` has nonzero length, is it a set?");
    end;
    if #v19 ~= 0 then
        error("`second` has nonzero length, is it a set?");
    end;
    return v17.union(v17.subtract(v18, v19), v17.subtract(v19, v18));
end;
v17.toArray = function(v20) --[[ Line: 66 ]] --[[ Name: toArray ]]
    if #v20 ~= 0 then
        error("`set` has nonzero length, is it a set?");
    end;
    local v21 = {};
    for v22 in pairs(v20) do
        v21[#v21 + 1] = v22;
    end;
    return v21;
end;
return v17;