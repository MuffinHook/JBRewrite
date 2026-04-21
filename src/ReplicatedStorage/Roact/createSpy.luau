-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMXCWNhbGxDb3VudAZ2YWx1ZXMBIwZzZWxlY3QMdmFsdWVzTGVuZ3RoBWVycm9yN0V4cGVjdGVkICVkIGFyZ3VtZW50cywgYnV0IHdhcyBjYWxsZWQgd2l0aCAlZCBhcmd1bWVudHMGZm9ybWF0DXZhbHVlIGRpZmZlcnMGYXNzZXJ0NGxlbmd0aCBvZiBleHBlY3RlZCB2YWx1ZXMgZGlmZmVycyBmcm9tIHN0b3JlZCB2YWx1ZXMfJXEgaXMgbm90IGEgdmFsaWQgbWVtYmVyIG9mIHNweQdfX2luZGV4BXZhbHVlEGFzc2VydENhbGxlZFdpdGgZYXNzZXJ0Q2FsbGVkV2l0aERlZXBFcXVhbA1jYXB0dXJlVmFsdWVzDHNldG1ldGF0YWJsZQljcmVhdGVTcHkHcmVxdWlyZQZzY3JpcHQGUGFyZW50D2Fzc2VydERlZXBFcXVhbAAHBAACAQAFAAIADw8iowAAAPsAAAD7AwAATQID5AEAAACVAQIAMAEA5AEAAAD7AAAA/wEAAAAAAADdAgAAxQECAAEAAAAwAQDCAgAAAPsAAABvAgMAuzkCA6QBBQAAAEBA3QMAAJ8BAAIwAQD7BgAAAPsAAQBHAAUAAAAAAPsAAQDdAQAAnwAAAIIAAADGAAAAggACAAcCAAAAAAAA8D8DAQMCAwMDBAQAAEBAAwUAEAABGAABAAAAAAAAAQAAAAAAAAABAAAAAAAAAAACAAABAAAAAgAQAAAAAAsBAQEAFAABBA8DAxMCDwUcFA8EGBgPAQExMqMBAABvAgAAuzkCA6QBAgAAABBA3QMAAJ8BAAL7AwAATQID+wMAAADxAg0AAQAAAKQCBQAAAEBAbwMGAPsGAABNBQb7AwAAAFIGAQC8AwONBwAAAJ8DBAKMBAIAnwIDAYwEAQBSAgEAjAMBAKgCFQC7OQQEpAUCAAAAEEBSBgQA3QcAAJ8FAAL7CgAATQkKwggAAACHCAkE8QgCAAUAAACpBwABqQcBAIEBBwQJAAAAbwgJAKQGCwAAAKBAnwYDAYsC6/+CAAEADAMDAwQEAAAQQAMFAwYEAABAQAMHAwgDAgMJAwoEAACgQAAbAAEYAAEAAAAAAAIAAAAAAQAAAAAAAAAAAAAAAwAAAAEAAAAAAAIAAAAAAAAAAAAAAAAA/QUbAAAAAAoBAgEAFQACBA8PAwMTAg8FHA0PBBgRDwEBKiujAQAAbwIAALs5AgOkAQIAAAAQQN0DAACfAQAC+wMAAE0CA/sDAAAA8QINAAEAAACkAgUAAABAQG8DBgD7BgAATQUG+wMAAABSBgEAvAMDjQcAAACfAwQCjAQCAJ8CAwGMBAEAUgIBAIwDAQCoAg4AuzkEBKQFAgAAABBAUgYEAN0HAACfBQAC+wYBAPsJAABNCAnCCAAAAIcHCARSCAUAnwYDAYsC8v+CAAEACQMDAwQEAAAQQAMFAwYEAABAQAMHAwgDAgApAAEYAAEAAAAAAAIAAAAAAQAAAAAAAAAAAAAAAwAAAAEAAAAAAAIAAAAAAAD9BSkAAAAACgEBAQAUAAEEDw8GGgsPBRYPDwEBJg8CByAnowEAAG8CAAC7OQIDpAECAAAAEEDdAwAAnwEAAv8CAAAAAAAA+wYAAE0FBvsDAAAA8QUCAAEAAACpBAABqQQBAIEBBAQEAAAAbwUEAKQDBgAAAFBAnwMDAYwFAQBSAwEAjAQBAKgDDAC7OQUEpAYCAAAAEEBSBwUA3QgAAJ8GAAL7CQAATQgJwgcAAACHBwgFagcCBosD9P+CAgIACAMDAwQEAAAQQAMFAwsDCgQAAFBAAwIANwABGAABAAAAAAABAAIAAAAAAAAAAAAAAAACAAAAAQAAAAAAAQAAAAD+BTcAAAAABgIAAAAHAAABAwMEAgmkAgEAAAAAQG8DAgBSBQEAvAMDjQMAAACfAwMAnwIAAYIAAQAEAwYEAAAAQAMMAwgARg0BGAAAAAAAAAAAAUcAAAAABgEBAAAIAAEBDw8BACkp/wEEAAAAAACMAgAAMAIB5AAAAAD/AgAAAAAAADACAcIBAAAAjAIAADACAfsCAAAA2QIAABIAAQASAAAAMAIBzAMAAADZAgEAEgABADACAWYEAAAA2QICABIAAQASAgAAMAIBhQUAAADZAgMAEgABADACAaYGAAAA4gQIAMAFCQAwBQRuBwAAAJ49AQQEAAAAUgMBAKQCCwAAAKBAnwIDAYIBAgAMAwEDAgMFAw4DDwMQAxEDDQUBBwYEAxIEAACgQAUAAQIDBAsTARgAAAEAAAEAAAABAAABAAAAAAsAAAAOAAAAAA4AAAAOAQAAAAAA/wAABgwAAAAABAAAAQILAAACDwABDA8BCgMNowAAAKQAAQAAAABApAMDAAAAIEBNAgMkBAAAAE0BAmUFAAAAnwACAsABBgASAAAAggECAAcDFAQAAABAAxUEAAAgQAMWAxcGBQEFAQABGAAIAAAAAAAAAAACAEMBAAAAAAb0KsjMz9t7DMbuolgOh76UtiOz9f+Io8D5KmjhcgjCQlyuT/TFUtUd

local v0 = require(script.Parent.assertDeepEqual);
return function(v1) --[[ Line: 11 ]] --[[ Name: createSpy ]]
    -- upvalues: v0 (copy)
    local v2 = {
        callCount = 0, 
        values = {}, 
        valuesLength = 0
    };
    v2.value = function(...) --[[ Line: 16 ]]
        -- upvalues: v2 (copy), v1 (copy)
        v2.callCount = v2.callCount + 1;
        v2.values = {
            ...
        };
        v2.valuesLength = select("#", ...);
        if v1 ~= nil then
            return v1(...);
        else
            return nil;
        end;
    end;
    v2.assertCalledWith = function(_, ...) --[[ Line: 27 ]]
        -- upvalues: v2 (copy)
        local v4 = select("#", ...);
        if v2.valuesLength ~= v4 then
            error(string.format(("Expected %d arguments, but was called with %d arguments"), v2.valuesLength, v4), 2);
        end;
        for v5 = 1, v4 do
            assert(select(v5, ...) == v2.values[v5], "value differs");
        end;
    end;
    v2.assertCalledWithDeepEqual = function(_, ...) --[[ Line: 41 ]]
        -- upvalues: v2 (copy), v0 (ref)
        local v7 = select("#", ...);
        if v2.valuesLength ~= v7 then
            error(string.format(("Expected %d arguments, but was called with %d arguments"), v2.valuesLength, v7), 2);
        end;
        for v8 = 1, v7 do
            local v9 = select(v8, ...);
            v0(v2.values[v8], v9);
        end;
    end;
    v2.captureValues = function(_, ...) --[[ Line: 55 ]]
        -- upvalues: v2 (copy)
        local v11 = select("#", ...);
        local v12 = {};
        assert(v2.valuesLength == v11, "length of expected values differs from stored values");
        for v13 = 1, v11 do
            v12[select(v13, ...)] = v2.values[v13];
        end;
        return v12;
    end;
    setmetatable(v2, {
        __index = function(_, v15) --[[ Line: 70 ]] --[[ Name: __index ]]
            error(string.format(("%q is not a valid member of spy"), v15));
        end
    });
    return v2;
end;