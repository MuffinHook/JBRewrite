-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMaB3JlZHVjZXIDbmV3CGZvb1ZhbHVlCGJhclZhbHVlCGJhelZhbHVlBWhpQmF6Cm1pZGRsZXdhcmUOb3V0cHV0RnVuY3Rpb24EdHlwZQ50ZXN0QWN0aW9uVHlwZQhkaXNwYXRjaAZleHBlY3QCdG8FZXF1YWwEZmluZAJiZQJvawUxMjM0NQVwcmludAdyZXF1aXJlBnNjcmlwdAZQYXJlbnQFU3RvcmUQbG9nZ2VyTWlkZGxld2FyZQJpdC1zaG91bGQgcHJpbnQgd2hlbmV2ZXIgYW4gYWN0aW9uIGlzIGRpc3BhdGNoZWQABQICAAAAAAGCAAIAAAAJAQEYAAoAAAAAAwECAAAFAAIAAg8F+wIAAJUBAgDeAQAA3gABAIIAAQABAgAAAAAAAPA/ABYAARgAAAABARcAAAAACwACAAAZAAIEDw8CAACLAQ8BAYoBDwICiQEPAwOIAYsBjAAAAMYBAADAAgAA+wQAAE0DBO8BAAAAUgQCAOIFBACMBjkwMAYFpQIAAADiBgYAbwcHADAHBt4FAAAAMAYF2QMAAAD/BgAAAQAAAPsIAQBNBwhuCAAAAMUGBwIBAAAAnwMEAvsEAQDZBQEAEgEA/xIBAf8wBQSDCQAAAOIGCwBvBwwAMAcGcQoAAAC8BANMDQAAAJ8EAwGkBg8AAADgQFIHAACfBgICTQUGkhAAAABNBAV7EQAAAIwFAQCfBAIBpAcPAAAA4EBvCgwAvAgBVhIAAACfCAMAnwcAAk0GB5IQAAAATQUGzBMAAABNBAUQFAAAAJ8EAQGkBw8AAADgQG8KAgC8CAFWEgAAAJ8IAwCfBwACTQYHkhAAAABNBQbMEwAAAE0EBRAUAAAAnwQBAaQHDwAAAOBAbwoVALwIAVYSAAAAnwgDAJ8HAAJNBgeSEAAAAE0FBswTAAAATQQFEBQAAACfBAEBpAcPAAAA4EBvCgMAvAgBVhIAAACfCAMAnwcAAk0GB5IQAAAATQUGzBMAAABNBAUQFAAAAJ8EAQGkBw8AAADgQG8KBQC8CAFWEgAAAJ8IAwCfBwACTQYHkhAAAABNBQbMEwAAAE0EBRAUAAAAnwQBAaQHDwAAAOBAbwoHALwIAVYSAAAAnwgDAJ8HAAJNBgeSEAAAAE0FBswTAAAATQQFEBQAAACfBAEB+wQBAKQFFwAAAGBBMAUEgwkAAADBAAAAggABABgGAAMCAwMDBAUCAgMDBQUBBQMGAwcDCAMJBQEKAwoDCwMMBAAA4EADDQMOAw8DEAMRAxIDEwQAAGBBAgABBQABGAABAgQAAAAAAQAAAQEAAP8AAwABAAAAAPoJAAAAAAAFAQAA/wAABAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAIAAAAAAQAGAAAAAAUAAAAACwAAAg8AABoPAQkRGqQAAQAAAABApAMDAAAAIEBNAgMkBAAAAE0BAl4FAAAAnwACAqQBAQAAAABApAQDAAAAIEBNAwQkBAAAAE0CA/oGAAAAnwECAqQCCAAAAHBAbwMJANkEAAASAAAAEgABAJ8CAwGCAAEACgMUBAAAAEADFQQAACBAAxYDFwMYAxkEAABwQAMaAQIBAAEYAAAAAAAAAAAAAQAAAAAAAAAAAgAAAAAAACQCAAAAAAEAAAECAAOjAAAAwAAAAIIAAgABBgMBAwEAARgAAAABAAAAAATikQ762IjyBtBVZG54UJa0ThzM+3UK8lWMP/4Gd2cXIbygvOzYzdZe

return function() --[[ Line: 1 ]]
    local v0 = require(script.Parent.Store);
    local v1 = require(script.Parent.loggerMiddleware);
    it("should print whenever an action is dispatched", function() --[[ Line: 5 ]]
        -- upvalues: v0 (copy), v1 (copy)
        local v2 = 0;
        local v3 = nil;
        local v6 = v0.new(function(v4, _) --[[ Line: 9 ]] --[[ Name: reducer ]]
            return v4;
        end, {
            fooValue = 12345, 
            barValue = {
                bazValue = "hiBaz"
            }
        }, {
            v1.middleware
        });
        v1.outputFunction = function(v7) --[[ Line: 22 ]]
            -- upvalues: v2 (ref), v3 (ref)
            v2 = v2 + 1;
            v3 = v7;
        end;
        v6:dispatch({
            type = "testActionType"
        });
        expect(v2).to.equal(1);
        expect(v3:find("testActionType")).to.be.ok();
        expect(v3:find("fooValue")).to.be.ok();
        expect(v3:find("12345")).to.be.ok();
        expect(v3:find("barValue")).to.be.ok();
        expect(v3:find("bazValue")).to.be.ok();
        expect(v3:find("hiBaz")).to.be.ok();
        v1.outputFunction = print;
    end);
end;