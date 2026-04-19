-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUC1N0cmluZ1ZhbHVlBE5hbWUGZXhwZWN0AnRvBWVxdWFsBVZhbHVlAAhJbnRWYWx1ZQtPYmplY3RWYWx1ZQlCb29sVmFsdWUHcmVxdWlyZQZzY3JpcHQGUGFyZW50GmdldERlZmF1bHRJbnN0YW5jZVByb3BlcnR5Aml0JXNob3VsZCBnZXQgZGVmYXVsdCBuYW1lIHN0cmluZyB2YWx1ZXMmc2hvdWxkIGdldCBkZWZhdWx0IGVtcHR5IHN0cmluZyB2YWx1ZXMgc2hvdWxkIGdldCBkZWZhdWx0IG51bWJlciB2YWx1ZXMdc2hvdWxkIGdldCBuaWwgZGVmYXVsdCB2YWx1ZXMec2hvdWxkIGdldCBib29sIGRlZmF1bHQgdmFsdWVzAAcGAAEAAAwAAQIPDwAADw8BAA8P+wAAAG8BAABvAgEAnwADA6QEAwAAACBAUgUBAJ8EAgJNAwSSBAAAAE0CA3sFAAAAbwMGAJ8CAgGCAAEABwMBAwIDAwQAACBAAwQDBQMGAAQAARgAAAAAAgAAAAAAAAAAAAEFAAAAAAYAAQAADAABAg8PAAAPDwEADw/7AAAAbwEAAG8CAQCfAAMDpAQDAAAAIEBSBQEAnwQCAk0DBJIEAAAATQIDewUAAABvAwYAnwICAYIAAQAHAwEDBgMDBAAAIEADBAMFAwcACgABGAAAAAACAAAAAAAAAAAAAQsAAAAABgABAAAMAAECDw8AAA8PAQAPD/sAAABvAQAAbwIBAJ8AAwOkBAMAAAAgQFIFAQCfBAICTQMEkgQAAABNAgN7BQAAAIwDAACfAgIBggABAAYDCAMGAwMEAAAgQAMEAwUAEAABGAAAAAACAAAAAAAAAAAAAREAAAAABgABAAAMAAECDw8AAA8PAQAPD/sAAABvAQAAbwIBAJ8AAwOkBAMAAAAgQFIFAQCfBAICTQMEkgQAAABNAgN7BQAAAMYDAACfAgIBggABAAYDCQMGAwMEAAAgQAMEAwUAFgABGAAAAAACAAAAAAAAAAAAARcAAAAABgABAAAMAAECDw8AAA8PAQAPD/sAAABvAQAAbwIBAJ8AAwOkBAMAAAAgQFIFAQCfBAICTQMEkgQAAABNAgN7BQAAAKkDAACfAgIBggABAAYDCgMGAwMEAAAgQAMEAwUAHAABGAAAAAACAAAAAAAAAAAAAR0AAAAABAAAAAAHAAABDwAAKCikAAEAAAAAQKQDAwAAACBATQIDJAQAAABNAQKmBQAAAJ8AAgKkAQcAAABgQG8CCADZAwAAEgAAAJ8BAwGkAQcAAABgQG8CCQDZAwEAEgAAAJ8BAwGkAQcAAABgQG8CCgDZAwIAEgAAAJ8BAwGkAQcAAABgQG8CCwDZAwMAEgAAAJ8BAwGkAQcAAABgQG8CDADZAwQAEgAAAJ8BAwGCAAEADQMLBAAAAEADDAQAACBAAw0DDgMPBAAAYEADEAMRAxIDEwMUBQABAgMEAQABGAAAAAAAAAAAAAIAAAAAAAYAAAAAAAYAAAAAAAYAAAAAAAYAAAAAAAUCAAAAAAEAAAECAAOjAAAAwAAAAIIAAgABBgUBBQEAARgAAAABAAAAAAa+I+RYEaMmwoznjsyRXVV5QP4Q4VTqEleH2g8czszCFIF408uFPFMT

return function() --[[ Line: 1 ]]
    local v0 = require(script.Parent.getDefaultInstanceProperty);
    it("should get default name string values", function() --[[ Line: 4 ]]
        -- upvalues: v0 (copy)
        local _, v2 = v0("StringValue", "Name");
        expect(v2).to.equal("Value");
    end);
    it("should get default empty string values", function() --[[ Line: 10 ]]
        -- upvalues: v0 (copy)
        local _, v4 = v0("StringValue", "Value");
        expect(v4).to.equal("");
    end);
    it("should get default number values", function() --[[ Line: 16 ]]
        -- upvalues: v0 (copy)
        local _, v6 = v0("IntValue", "Value");
        expect(v6).to.equal(0);
    end);
    it("should get nil default values", function() --[[ Line: 22 ]]
        -- upvalues: v0 (copy)
        local _, v8 = v0("ObjectValue", "Value");
        expect(v8).to.equal(nil);
    end);
    it("should get bool default values", function() --[[ Line: 28 ]]
        -- upvalues: v0 (copy)
        local _, v10 = v0("BoolValue", "Value");
        expect(v10).to.equal(false);
    end);
end;