-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMMBHR5cGUFdGFibGU1SW52YWxpZCBhY3Rpb246IEFuIGFjdGlvbiBjcmVhdG9yIG11c3QgcmV0dXJuIGEgdGFibGUGYXNzZXJ0Bl9fY2FsbAZzdHJpbmc+QmFkIGFyZ3VtZW50ICMxOiBFeHBlY3RlZCBhIHN0cmluZyBuYW1lIGZvciB0aGUgYWN0aW9uIGNyZWF0b3IIZnVuY3Rpb25AQmFkIGFyZ3VtZW50ICMyOiBFeHBlY3RlZCBhIGZ1bmN0aW9uIHRoYXQgY3JlYXRlcyBhY3Rpb24gb2JqZWN0cwRuYW1lDHNldG1ldGF0YWJsZRFtYWtlQWN0aW9uQ3JlYXRvcgADBgECAQAJAAIBDw8PAQEWF6MBAAD7AQAA3QIAAJ8BAAK7KAEDUgUBAKQEAQAAAABAnwQCAvAEAgACAAAAqQMAAakDAQCBAQMEAwAAAG8EAwCkAgUAAABAQJ8CAwH7AgEAMAIBcQAAAACCAQIABgMBBAAAAEADAgMDAwQEAABAQAAMBQEYAAEAAAIAAAAAAAAAAAAAAAAAAAIAAAIMAAAAAAYCAAAAAC27KAADUgUAAKQEAQAAAABAnwQCAvAEAgACAAAAqQMAAakDAQCBAQMEAwAAAG8EAwCkAgUAAABAQJ8CAwG7KAEDUgUBAKQEAQAAAABAnwQCAvAEAgAGAAAAqQMAAakDAQCBAQMEBwAAAG8EBwCkAgUAAABAQJ8CAwHiAwkAMAADWggAAADiBAsA2QUAABIAAQASAAAAMAUE7woAAACePQMDBAAAAKQCDQAAAMBAnwIDAoICAgAOAwEEAAAAQAMGAwcDBAQAAEBAAwgDCQMKBQEIAwUFAQoDCwQAAMBAAQAEDAEYAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAgEAAQEAAAAAAAD9AAAABQAAAAABAAABAgcAAAEPAAECA6MAAADAAAAAggACAAEGAQEBAQABGAADFAEAAAAAAovlgEUBv1/auSHq0QDutkT0s0nEHKJh5Y6Vi+tEG8rCZKhzmftm2JQ=

return function(v0, v1) --[[ Line: 4 ]] --[[ Name: makeActionCreator ]]
    assert(type(v0) == "string", "Bad argument #1: Expected a string name for the action creator");
    assert(type(v1) == "function", "Bad argument #2: Expected a function that creates action objects");
    return (setmetatable({
        name = v0
    }, {
        __call = function(_, ...) --[[ Line: 12 ]] --[[ Name: __call ]]
            -- upvalues: v1 (copy), v0 (copy)
            local v3 = v1(...);
            assert(type(v3) == "table", "Invalid action: An action creator must return a table");
            v3.type = v0;
            return v3;
        end
    }));
end;