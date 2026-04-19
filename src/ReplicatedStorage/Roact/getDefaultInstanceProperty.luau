-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLCEluc3RhbmNlA25ldwVwY2FsbAdEZXN0cm95GmdldERlZmF1bHRJbnN0YW5jZVByb3BlcnR5B3JlcXVpcmUGc2NyaXB0BlBhcmVudAZTeW1ib2wFbmFtZWQDTmlsAAMDAAIAAAUAAgAPDwT7AQAA+wIBAIcAAQKCAAIAAAAlAAEYAAAAACYAAAAACAICAAAZAAIFDw8PAwMMDwIAKQ8DFBUPBBgRDwUYESn7AwAAhwIDAA4CDQCHAwIB+wQBAJoDBAAEAAAAqQQBAMYFAACCBAMARwMJAAAAAACpBAEAUgUDAIIEAwBlAAQA/wIAAAAAAAD7AwAAagIDAKQDAgAABACAUgQAAJ8DAgKkBAQAAAAwQNkFAAASAAMAEgABAJ8EAgO8BgNQBQAAAJ8GAgEOBAYARwUEAAAAAID7BgEAagYCAYIEAwBqBQIBggQDAAYDAQMCBAAEAIADAwQAADBAAwQBABAFARgAAAIBBAAAAQAAAwABAAAAAwABAAMAAAABAAAAAAAEAAACAQABAAACBBEAAAAABAAAAQITAAAEDwABEw8BCgoPAg4GDwMQBBSjAAAApAABAAAAAECkAwMAAAAgQE0CAyQEAAAATQECkwUAAACfAAICTQEAUQYAAABvAgcAnwECAv8CAAAAAAAAwAMIABIAAgASAAEAggMCAAkDBgQAAABAAwcEAAAgQAMIAwkDCgMLBgEBAQEAARgACgAAAAAAAAAAAgAAAAEAAgAAJgEAAAAAAgi9stZJ3jHzOnnYQrMHBQgBVdx9g4MNF2nLD7Sj5MTv7l4XnPcOjAk=

local v0 = require(script.Parent.Symbol).named("Nil");
local v1 = {};
return function(v2, v3) --[[ Line: 16 ]] --[[ Name: getDefaultInstanceProperty ]]
    -- upvalues: v1 (copy), v0 (copy)
    local v4 = v1[v2];
    if v4 then
        local v5 = v4[v3];
        if v5 == v0 then
            return true, nil;
        elseif v5 ~= nil then
            return true, v5;
        end;
    else
        v4 = {};
        v1[v2] = v4;
    end;
    local v6 = Instance.new(v2);
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 37 ]]
        -- upvalues: v6 (copy), v3 (copy)
        return v6[v3];
    end);
    v6:Destroy();
    if l_status_0 then
        if l_result_0 == nil then
            v4[v3] = v0;
            return l_status_0, l_result_0;
        else
            v4[v3] = l_result_0;
        end;
    end;
    return l_status_0, l_result_0;
end;