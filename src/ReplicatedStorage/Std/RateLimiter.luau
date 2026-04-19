-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

local v0 = {};
v0.__index = v0;
v0.__ClassName = "RateLimiter";
v0.new = function(v1, v2) --[[ Line: 12 ]] --[[ Name: new ]]
    -- upvalues: v0 (copy)
    assert(v1 ~= nil, "missing budgetPerWindow limit");
    v2 = v2 or 1;
    local v3 = {};
    setmetatable(v3, v0);
    v3._lastUpdate = os.clock();
    v3._budgetPerWindow = v1;
    v3._budgetWindowDuration = v2;
    v3._data = {};
    return v3;
end;
v0.CanUseBudget = function(v4, v5, v6) --[[ Line: 25 ]] --[[ Name: CanUseBudget ]]
    assert(v5 ~= nil, "missing key");
    v6 = v6 or 1;
    v4:Update();
    local _ = nil;
    return (if v4._data[v5] then v4._data[v5].amount else 0) + v6 <= v4._budgetPerWindow;
end;
v0.UseBudget = function(v8, v9, v10, v11) --[[ Line: 37 ]] --[[ Name: UseBudget ]]
    v10 = v10 or 1;
    assert(v10);
    assert(v9 ~= nil, "missing key");
    if not v11 and not v8:CanUseBudget(v9, v10) then
        return false;
    else
        local v12 = v8._data[v9];
        if not v12 then
            v12 = {
                amount = 0, 
                lastUpdate = os.clock()
            };
            v8._data[v9] = v12;
        end;
        v12.amount = v12.amount + v10;
        return true;
    end;
end;
v0.Increment = v0.UseBudget;
v0.Update = function(v13) --[[ Line: 60 ]] --[[ Name: Update ]]
    local v14 = os.clock();
    for v15, v16 in v13._data do
        if v14 - v16.lastUpdate >= v13._budgetWindowDuration then
            v16.amount = v16.amount - v13._budgetPerWindow;
            if v16.amount <= 0 then
                v13._data[v15] = nil;
            end;
            v16.lastUpdate = v14;
        end;
    end;
end;
v0.Destroy = function(v17) --[[ Line: 74 ]] --[[ Name: Destroy ]]
    table.clear(v17._data);
    setmetatable(v17, nil);
end;
return v0;