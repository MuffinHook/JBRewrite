-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

return {
    addColorToText = function(v0, v1) --[[ Line: 5 ]] --[[ Name: addColorToText ]]
        assert(typeof(v0) == "string", "text must be a string");
        assert(typeof(v1) == "Color3", "textColor3 must be a Color3");
        local v2 = false;
        if v1.R >= 0 then
            v2 = v1.R <= 1;
        end;
        assert(v2, "textColor3.R must be between 0 and 1");
        v2 = false;
        if v1.G >= 0 then
            v2 = v1.G <= 1;
        end;
        assert(v2, "textColor3.G must be between 0 and 1");
        v2 = false;
        if v1.B >= 0 then
            v2 = v1.B <= 1;
        end;
        assert(v2, "textColor3.B must be between 0 and 1");
        return "<font color='#" .. v1:ToHex() .. "'>" .. v0 .. "</font>";
    end, 
    addStrokeToText = function(v3, v4, v5) --[[ Line: 13 ]] --[[ Name: addStrokeToText ]]
        assert(typeof(v3) == "string", "text must be a string");
        assert(typeof(v4) == "Color3", "strokeColor3 must be a Color3");
        v5 = v5 or 1;
        return "<stroke color='#" .. v4:ToHex() .. "' thickness='" .. tostring(v5) .. "' join='meter'>" .. v3 .. "</stroke>";
    end, 
    doesTextHaveColor = function(v6) --[[ Line: 25 ]] --[[ Name: doesTextHaveColor ]]
        assert(typeof(v6) == "string", "text must be a string");
        return string.find(v6, "<font color='#") ~= nil;
    end, 
    extractColorFromText = function(v7) --[[ Line: 29 ]] --[[ Name: extractColorFromText ]]
        assert(typeof(v7) == "string", "text must be a string");
        local v8 = string.find(v7, "<font color='#");
        if v8 then
            v8 = v8 + 14;
            local v9 = string.sub(v7, v8, v8 + 6 - 1);
            return (Color3.fromHex(v9));
        else
            return nil;
        end;
    end
};