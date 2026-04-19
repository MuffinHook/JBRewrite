-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMSBG5vb3AMVXNlUGFyZW50S2V5Am9mB0VsZW1lbnQGdHlwZW9mB2Jvb2xlYW4FdGFibGUFcGFpcnMFZXJyb3IQSW52YWxpZCBlbGVtZW50cw9pdGVyYXRlRWxlbWVudHMPZ2V0RWxlbWVudEJ5S2V5B3JlcXVpcmUGc2NyaXB0BlBhcmVudARUeXBlBlN5bWJvbAVuYW1lZAAFAQAAAAAAAsYAAACCAAIAAAAEAQEYAAAFAAAAAAIAAwAABgADAAEPDwv7AAAADgACAMYAAACCAAIAqQABAN4AAAD7AQEATQABzQAAAAD7AQIAggADAAEDAgAvAAEYAAABAAIAAQAAAAAwAAAAAAUBAwAAEgADAw8PDwECCggPAQApAwISFyn7AgAATQECvAAAAABSAgAAnwECAvsDAABNAgOXAQAAAJoBCQACAAAAqQIAANkDAAASAQL/EgIBABIAAADBAgAAggMCAMECAAC7LAADUgMAAKQCAwAAACBAnwICAkcAAwAAAAAA8AIDAAQAAID7AwIAggMCAPACBgAFAACApAMHAAAAYEBSBAAAnwMCAIIDAACkAwkAAACAQG8ECgCfAwIBggABAAsDAwMEAwUEAAAgQAMGAwcDCAQAAGBAAwkEAACAQAMKAQEoCwEYAAAAAAADAAAAAAECAAAAAAAACgAAAAACAAAAAQADAAEAAAAAAwAAAAEpAAAAAAUCAgAABQACAA8PK0cACAAAAAAAuywAA1IDAACkAgEAAAAAQJ8CAgLwAgMAAgAAgMYCAACCAgIA+wMAAE0CA7wDAAAAUgMAAJ8CAgL7BAAATQMElwQAAACaAgkAAwAAAPsDAQBNAgPNBQAAAJoBAgACAAAAggACAMYCAACCAgIAuywAA1IDAACkAgEAAAAAQJ8CAgLwAgMABgAAgIcCAAGCAgIApAIIAAAAcEBvAwkAnwICAYIAAQAKAwUEAAAAQAMGAwMDBAMCAwcDCQQAAHBAAwoATwwBGAAAAAAAAAAAAAEAAwAAAAAAAAAAAAEAAAAAAQMAAwAAAAAAAAEAAwAAAAFQAAAAAAYAAAECEwAABA8AAScPAQoeDwITFQ8DFBQoowAAAKQAAQAAAABApAMDAAAAIEBNAgMkBAAAAE0BAhEFAAAAnwACAqQBAQAAAABApAQDAAAAIEBNAwQkBAAAAE0CA5MGAAAAnwECAsACBwD/AwMAAAAAAE0EAVEIAAAAbwUJAJ8EAgIwBAPNCQAAAMAECgASAAAAEgADABIAAgAwBANSCwAAAMAEDAASAAAAEgADADAEA2gNAAAAggMCAA4DDQQAAABAAw4EAAAgQAMPAxADEQYAAxIDAgYCAwsGAwMMAwACAwEAARgAAAAAAAAAAAAAAQAAAAAAAAAAAgQACQAAAAAAFwAAAAAAJwAAAAAUAQAAAAAENWZbP7Z9wCAHojGrCCd0yaotbto8DqBAFXA1x+xM0HY9eQJOE1oXXA==

local v0 = require(script.Parent.Type);
local v1 = require(script.Parent.Symbol);
local function v2() --[[ Line: 4 ]] --[[ Name: noop ]]
    return nil;
end;
local v3 = {
    UseParentKey = v1.named("UseParentKey")
};
v3.iterateElements = function(v4) --[[ Line: 40 ]] --[[ Name: iterateElements ]]
    -- upvalues: v0 (copy), v3 (copy), v2 (copy)
    if v0.of(v4) == v0.Element then
        local v5 = false;
        return function() --[[ Line: 47 ]]
            -- upvalues: v5 (ref), v3 (ref), v4 (copy)
            if v5 then
                return nil;
            else
                v5 = true;
                return v3.UseParentKey, v4;
            end;
        end;
    else
        local v6 = typeof(v4);
        if v4 == nil or v6 == "boolean" then
            return v2;
        elseif v6 == "table" then
            return pairs(v4);
        else
            error("Invalid elements");
            return;
        end;
    end;
end;
v3.getElementByKey = function(v7, v8) --[[ Line: 79 ]] --[[ Name: getElementByKey ]]
    -- upvalues: v0 (copy), v3 (copy)
    if v7 == nil or typeof(v7) == "boolean" then
        return nil;
    elseif v0.of(v7) == v0.Element then
        if v8 == v3.UseParentKey then
            return v7;
        else
            return nil;
        end;
    elseif typeof(v7) == "table" then
        return v7[v8];
    else
        error("Invalid elements");
        return;
    end;
end;
return v3;