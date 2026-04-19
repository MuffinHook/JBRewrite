-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMHBWVycm9yM0luaXRpYWwgZ3Vlc3NlcyBoYXZlIHRoZSBzYW1lIHNpZ24sIGludmFsaWQgYSBhbmQgYgRtYXRoA2FicxhyZWd1bGFGYWxzaVdpdGhFbmRwb2ludHMyQ291bGQgbm90IGZpbmQgdmFsaWQgZW5kcG9pbnRzIHdpdGggb3Bwb3NpdGUgc2lnbnMLcmVndWxhRmFsc2kAAxEFAAAAGwAABg8MHzEPBQJQDwYCUAIHBE4PCAVNDwkISlKQAwMAkAQEAcYFAADGBgAAjAcAAFIIAABSCQEAnwgCAlIJAABSCgIAnwkCAg0IAgACAACAggECAA0JAgACAACAggICAFILAABSDAEAnwsCAlIMAABSDQIAnwwCAgkKCwyMCwAAYAsFAAoAAACkCgQAAAAwQG8LBQCfCgIBjAwBAFIKBACMCwEAqAouAAkOCAIJDwkBJg0ODyYOCAnsBg0OJg4CAbsCDgKkDQgAABxggJ8NAgJDEAIBuwIQAqQPCAAAHGCAnw8CAgkOAw+3DR0ADgAAAFINAABSDgYAnw0CAlIFDQAJDQUJjA4AAGAOCAANAAAAUgIGAFIJBQANBwIACQAAgD4ICAqMB///ZQAMAAkNCAWMDgAAYA4KAA0AAABSAQYAUggFAA0HAgALAACAPgkJCowHAQBlAAEAggYCAIsK0v+CBgIADAIWVueerwPSPAIAAAAAAECPQAIAAAAAAAAAAAMBBAAAMEADAgMDAwQEABxggAIAAAAAAADwvwIAAAAAAAAAQAIAAAAAAADwPwAFBQEYAAECAAEBAAABAAABAAECAAECAAAAAAAAAAAAAQAAAAIAAAABAAAAAAEAAAAAAAAAAAAAAAADAAAAAQAAAAEBAQABAgABAAAAAQEBAAECAALrGAYAAAAADAMBAAAQAAEDDw8HAhQCAwAvAgQBLi+MAwAAjAQBAIwHAQCMBRQAjAYBAKgFEQBSCQAAUgoDAJ8JAgJSCgAAUgsEAJ8KAgIJCAkKjAkAANQICAAJAAAADQMDAAAAAICMA///ZQACAFsEBAFbAwMBiwXv/1IGAABSBwMAnwYCAlIHAABSCAQAnwcCAgkFBgeMBgAAYAYFAAUAAACkBQMAAAAgQG8GBACfBQIB+wYAAE0FBtIFAAAAUgYAAFIHAwBSCAQAUgkBAFIKAgCfBQYAggUAAAYCAAAAAAAAAAACAAAAAAAAAEADAQQAACBAAwYDBQAwBwEYAAEBAAAAAQAAAAAAAAAAAAMAAQACAfgLAAAAAAAAAAAAAQAAAAIAAAAAAAAAAAAxAAAAAAIAAAECBwAAAQ8AAQoLowAAAP8AAgAAAAAAwAEAADABANIBAAAAwAECABIAAAAwAQCCAwAAAIIAAgAEBgADBQYBAwcCAAEBAAEYAAEAAwAAKwAAABMBAAAAAALYa0rthBokT+qvIHl34Z0VxCGdcwG1rAqdqYa0jjCIfBWHbSPxA98m

local v11 = {
    regulaFalsiWithEndpoints = function(v0, v1, v2, v3, v4) --[[ Line: 5 ]] --[[ Name: regulaFalsiWithEndpoints ]]
        v3 = v3 or 1.0E-15;
        v4 = v4 or 1000;
        local v5 = nil;
        local v6 = nil;
        local v7 = 0;
        local v8 = v0(v1);
        local v9 = v0(v2);
        if v8 == 0 then
            return v1;
        elseif v9 == 0 then
            return v2;
        else
            if v0(v1) * v0(v2) > 0 then
                error("Initial guesses have the same sign, invalid a and b");
            end;
            for _ = 1, v4 do
                v6 = (v8 * v2 - v9 * v1) / (v8 - v9);
                if math.abs(v2 - v1) >= v3 * math.abs(v2 + v1) then
                    v5 = v0(v6);
                    if v5 * v9 > 0 then
                        v2 = v6;
                        v9 = v5;
                        if v7 == -1 then
                            v8 = v8 / 2;
                        end;
                        v7 = -1;
                    elseif v8 * v5 > 0 then
                        v1 = v6;
                        v8 = v5;
                        if v7 == 1 then
                            v9 = v9 / 2;
                        end;
                        v7 = 1;
                    else
                        break;
                    end;
                else
                    break;
                end;
            end;
            return v6;
        end;
    end
};
v11.regulaFalsi = function(v12, v13, v14) --[[ Line: 48 ]] --[[ Name: regulaFalsi ]]
    -- upvalues: v11 (copy)
    local v15 = 0;
    local v16 = 1;
    for _ = 1, 20 do
        if v12(v15) * v12(v16) > 0 then
            if v15 == 0 then
                v15 = -1;
            else
                v16 = v16 * 2;
                v15 = v15 * 2;
            end;
        else
            break;
        end;
    end;
    if v12(v15) * v12(v16) > 0 then
        error("Could not find valid endpoints with opposite signs");
    end;
    return v11.regulaFalsiWithEndpoints(v12, v15, v16, v13, v14);
end;
return v11;