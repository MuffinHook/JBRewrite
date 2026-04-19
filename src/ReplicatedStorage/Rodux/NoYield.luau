-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLBWVycm9yBWRlYnVnCXRyYWNlYmFjawljb3JvdXRpbmUGc3RhdHVzBGRlYWQoQXR0ZW1wdGVkIHRvIHlpZWxkIGluc2lkZSBjaGFuZ2VkIGV2ZW50IQ1yZXN1bHRIYW5kbGVyBmNyZWF0ZQZyZXN1bWUHTm9ZaWVsZAADBwIAAQAHAAABDwICCh2jAgAAKwEKAN0CAgCkAwEAAAAAQKQEBAAADCCAUgUAAFIGAgCfBAMCjAUCAJ8DAwGkAgcAABhQgFIDAACfAgIC8AIKAAgAAACkAgEAAAAAQKQDBAAADCCAUgQAAG8FCQCfAwMCjAQCAJ8CAwHdAgAAggIAAAoDAQQAAABAAwIDAwQADCCAAwQDBQQAGFCAAwYDBwAMCAEYAAEBAQAAAAAAAAAAAwAAAAAAAQAAAAAAAAAAAwAMAAAAAAcBAQEACAABAQ8PAQENDqMBAACkAQIAAAQAgFICAACfAQIC+wIAAFIDAQCkBAQAAAwAgFIFAQDdBgAAnwQAAJ8CAACCAgAABQMEAwkEAAQAgAMKBAAMAIAAGQsBGAABAAAAAgAAAAAAAAAAGQAAAAACAAABAgsAAAIPAAEEDwECAwWjAAAAwAAAAMABAQASAAAAggECAAIGAAYBAgABAQABGAALDQAGAQAAAAAC3uobLNzd5BDsLnG4vYaUIN2kcxijcxSiMAB69PfAFSWcMsx8Nh/krw==

local function v2(v0, v1, ...) --[[ Line: 12 ]] --[[ Name: resultHandler ]]
    if not v1 then
        error(debug.traceback(v0, (...)), 2);
    end;
    if coroutine.status(v0) ~= "dead" then
        error(debug.traceback(v0, "Attempted to yield inside changed event!"), 2);
    end;
    return ...;
end;
return function(v3, ...) --[[ Line: 25 ]] --[[ Name: NoYield ]]
    -- upvalues: v2 (copy)
    local v4 = coroutine.create(v3);
    return v2(v4, coroutine.resume(v4, ...));
end;