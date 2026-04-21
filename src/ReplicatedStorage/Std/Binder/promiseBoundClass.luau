-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMZA0dldA9PYnNlcnZlSW5zdGFuY2UIR2l2ZVRhc2sHRGVzdHJveQlnZXRTdGF0dXMGU3RhdHVzB1N0YXJ0ZWQEd2FybkJbcHJvbWlzZUJvdW5kQ2xhc3NdIC0gSW5maW5pdGUgeWllbGQgcG9zc2libGUgb24gJXEgZm9yIGJpbmRlciAlcQoLR2V0RnVsbE5hbWUGR2V0VGFnBmZvcm1hdAVkZWJ1Zwl0cmFjZWJhY2sHcmVzb2x2ZQNuZXcFZGVmZXIHZmluYWxseQR0YXNrBWRlbGF5B3JlcXVpcmUGc2NyaXB0BlBhcmVudAdQcm9taXNlBE1haWQABgMBAQAABAABAA8E+wEAAFICAACfAQIBggABAAAAEgABGAAAAAETAAAAAAgBAwAACgADAQ8PDw8BABYW+wEAAPsDAQC8AQF/AAAAAJ8BAwIOAQQAUgIAAFIDAQCfAgIBggABAPsCAgD7BAAA+wYBANkHAAASAAAAvAQEzAEAAACfBAQAvAIC/QIAAACfAgABggABAAMDAQMCAwMBAA0AARgAAAAAAAEBAAAAAgAAAAAAAAAAAAAEDgAAAAACAAEAAAQAAQAPBfsAAAC8AABQAAAAAJ8AAgGCAAEAAQMEABcAARgAAAAAARgAAAAABgAFAAAMAAUBDw8PDw8DARYCH/sAAAC8AAD9AAAAAJ8AAgL7AwEATQID7AEAAABNAQKzAgAAAJoAFAABAAAApAAEAAAAMEBvAQUA+wMCALwDA7IGAAAAnwMCAvsEAwC8BAS3BwAAAJ8EAgC8AQGNCAAAAJ8BAACfAAABpAAEAAAAMED7AQQAnwACAYIAAQAJAwUDBgMHAwgEAAAwQAMJAwoDCwMMABoAARgAAAAAAAAAAAAAAAEAAQEAAAABAAAA/gAA/wYAAAACGwAAAAAJAgIAABUAAgQPDw8CACoPAwMnDwQOHA8FEhgqpAICAAAEAICfAgECUgUBALwDAH8DAAAAnwMDAg4DBgD7BQAATQQFHQQAAABSBQMAnwQCAIIEAAD7BQEATQQF7wUAAACfBAEC+wYAAE0FBmgGAAAA2QYAABIAAAASAAEAEgAEAJ8FAgLZCAEAEgAEALwGBUIHAAAAnwYDAaQGCgAAJICAjAcFANkIAgASAAUAEgIAABIAAQASAAAAEgACAJ8GAwGCBQIACwMNAw4EAAQAgAMBAw8DEAMRAxIDEwMUBAAkgIADAQIDBQABGAAAAAIAAAABAQAAAAAAAgAAAAEAAAAAAAAACgAAAAADAAAAAAAAAAAACwYAAAAABgAAAQILAAACDwABGg8BDA8bowAAAKQAAQAAAABApAQDAAAAIEBNAwQkBAAAAE0CAyQEAAAATQECcgUAAACfAAICpAEBAAAAAECkBQMAAAAgQE0EBSQEAAAATQMEJAQAAABNAgN2BgAAAJ8BAgLAAgcAEgAAABIAAQCCAgIACAMVBAAAAEADFgQAACBAAxcDGAMZBgQBBAEAARgAAQAAAAAAAAAAAAABAAAAAAAAAAAAAAIAAAABAAAAAAX+q9SmlFSboMxvvjKOuaDqf7xtmgwPTRAIqtjaKrEOKz8WvVdoucAW

local v0 = require(script.Parent.Parent.Promise);
local v1 = require(script.Parent.Parent.Maid);
return function(v2, v3) --[[ Line: 5 ]]
    -- upvalues: v0 (copy), v1 (copy)
    local v4 = debug.traceback();
    local v5 = v2:Get(v3);
    if v5 then
        return v0.resolve(v5);
    else
        local v6 = v1.new();
        local v10 = v0.defer(function(v7) --[[ Line: 13 ]]
            -- upvalues: v2 (copy), v3 (copy), v6 (copy)
            local v8 = v2:Get(v3);
            if v8 then
                v7(v8);
                return;
            else
                v6:GiveTask(v2:ObserveInstance(v3, function(v9) --[[ Line: 18 ]]
                    -- upvalues: v7 (copy)
                    v7(v9);
                end));
                return;
            end;
        end);
        v10:finally(function() --[[ Line: 23 ]]
            -- upvalues: v6 (copy)
            v6:Destroy();
        end);
        task.delay(5, function() --[[ Line: 26 ]]
            -- upvalues: v10 (copy), v0 (ref), v3 (copy), v2 (copy), v4 (copy)
            if v10:getStatus() == v0.Status.Started then
                warn(string.format(("[promiseBoundClass] - Infinite yield possible on %q for binder %q\n"), v3:GetFullName(), v2:GetTag()));
                warn(v4);
            end;
        end);
        return v10;
    end;
end;