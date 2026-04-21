-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMJIyVxICglcykgaXMgbm90IGEgdmFsaWQgbWVtYmVyIG9mICVzCHRvc3RyaW5nBnR5cGVvZgZmb3JtYXQFZXJyb3IHX19pbmRleApfX25ld2luZGV4DHNldG1ldGF0YWJsZQZzdHJpY3QABAcCAQAADAABAg8DAgwCDwIAFRVvAgAAuz8BA1IFAQCkBAIAAAAQQJ8EAgK7LAEDUgYBAKQFBAAAADBAnwUCAvsGAAC8AgKNBQAAAJ8CBQKkAwcAAABgQFIEAgCMBQIAnwMDAYIAAQAIAwEDAgQAABBAAwMEAAAwQAMEAwUEAABgQAAGBgEYAAAAAAAAAAAAAAAAAAAAAgAAAAABBwAAAAAIAwEAAAwAAQIPAwMMAg8DABUVbwMAALs/AQNSBgEApAUCAAAAEECfBQICuywBA1IHAQCkBgQAAAAwQJ8GAgL7BwAAvAMDjQUAAACfAwUCpAQHAAAAYEBSBQMAjAYCAJ8EAwGCAAEACAMBAwIEAAAQQAMDBAAAMEADBAMFBAAAYEAADAcBGAAAAAAAAAAAAAAAAAAAAAIAAAAAAQ0AAAAABgIAAAAAGVICAQArAgUAuz8AA1IDAACkAgEAAAAAQJ8CAgJSAQIA4gQEANkFAAASAQH/MAUEbgIAAADZBQEAEgEB/zAFBM4DAAAAnj0ABAQAAABSAwAApAIGAAAAUECfAgMCwQEAAIICAgAHAwIEAAAAQAMGAwcFAgIDAwgEAABQQAIAAQIJARgAAAAAAAAAAAIBAAAABgAAAAAAAPkAAAAAAwAAAAABAAABAgcAAAEPAAECA6MAAADAAAAAggACAAEGAgECAQABGAABEgEAAAAAA4NCotn1KTC4sYbITdRzhHnTGvUWflE9Dgw7su++yjx+XHk7QvOGbFo=

return function(v0, v1) --[[ Line: 2 ]] --[[ Name: strict ]]
    v1 = v1 or tostring(v0);
    return (setmetatable(v0, {
        __index = function(_, v3) --[[ Line: 6 ]] --[[ Name: __index ]]
            -- upvalues: v1 (ref)
            local v4 = string.format(("%q (%s) is not a valid member of %s"), tostring(v3), typeof(v3), v1);
            error(v4, 2);
        end, 
        __newindex = function(_, v6, _) --[[ Line: 12 ]] --[[ Name: __newindex ]]
            -- upvalues: v1 (ref)
            local v8 = string.format(("%q (%s) is not a valid member of %s"), tostring(v6), typeof(v6), v1);
            error(v8, 2);
        end
    }));
end;