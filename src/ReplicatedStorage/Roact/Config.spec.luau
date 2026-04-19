-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMVA25ldwNnZXQGZXhwZWN0DmVsZW1lbnRUcmFjaW5nAnRvBWVxdWFsA3NldApnYXJibGVnb29wBXBjYWxsBGZpbmQCYmUCb2sMSGVsbG8gdGhlcmUhB3JlcXVpcmUGc2NyaXB0BlBhcmVudAZDb25maWcCaXQhc2hvdWxkIGFjY2VwdCB2YWxpZCBjb25maWd1cmF0aW9uKHNob3VsZCByZWplY3QgaW52YWxpZCBjb25maWd1cmF0aW9uIGtleXMqc2hvdWxkIHJlamVjdCBpbnZhbGlkIGNvbmZpZ3VyYXRpb24gdmFsdWVzAAcGAAEAAAwAAQIPDwAAJQ8BBCEl+wEAAE0AAe8AAAAAnwABAk0BAF8BAAAAnwEBAqQEAwAAACBATQUB+QQAAACfBAICTQMEkgUAAABNAgN7BgAAAKkDAACfAgIBTQIAUwcAAADiAwgAqQQBADAEA/kEAAAAnwICAaQEAwAAACBATQUB+QQAAACfBAICTQMEkgUAAABNAgN7BgAAAKkDAQCfAgIBggABAAkDAQMCAwMEAAAgQAMEAwUDBgMHBQEEAAQAARgAAAAAAQAAAgAAAAAAAAAAAAACAAABAAD/BAAAAAAAAAAAAAABBQAAAAADAAEAAAQAAQAPCvsBAABNAAFTAAAAAP8BAQAAAAAAqQIBADACAbkBAAAAnwACAYIAAQACAwcDCAAWAAEYAAAAAAABAAD/AxcAAAAACgABAAAQAAEDDw8AACIPAQQeDwIEHiL7AQAATQAB7wAAAACfAAECpAECAAAAEEDZAgAAEgAAAJ8BAgOkBQQAAAAwQFIGAQCfBQICTQQFkgUAAABNAwR7BgAAAKkEAACfAwIBpAYEAAAAMEBvCQcAvAcCVggAAACfBwMAnwYAAk0FBpIFAAAATQQFzAkAAABNAwQQCgAAAJ8DAQGCAAEACwMBAwkEAAAQQAMDBAAAMEADBQMGAwgDCgMLAwwBAREAARgAAAAABAAAAAAGAAAAAAAAAAAAAwAAAAAAAAAAAAAAAAABEgAAAAADAAEAAAQAAQAPCvsBAABNAAFTAAAAAP8BAQAAAAAAbwIBADACAfkCAAAAnwACAYIAAQADAwcDDQMEACgAARgAAAAAAAEAAP8DKQAAAAAKAAEAABAAAQMPDwAAMA8BBCwPAgQsMPsBAABNAAHvAAAAAJ8AAQKkAQIAAAAQQNkCAAASAAAAnwECA6QFBAAAADBAUgYBAJ8FAgJNBAWSBQAAAE0DBHsGAAAAqQQAAJ8DAgGkBgQAAAAwQG8JBwC8BwJWCAAAAJ8HAwCfBgACTQUGkgUAAABNBAXMCQAAAE0DBBAKAAAAnwMBAaQGBAAAADBAbwkLALwHAlYIAAAAnwcDAJ8GAAJNBQaSBQAAAE0EBcwJAAAATQMEEAoAAACfAwEBggABAAwDAQMJBAAAEEADAwQAADBAAwUDBgMEAwoDCwMMAw0BAyIAARgAAAAABQAAAAAGAAAAAAAAAAAAAwAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAEjAAAAAAQAAAAABwAAAQ8AABwcpAABAAAAAECkAwMAAAAgQE0CAyQEAAAATQEC2QUAAACfAAICpAEHAAAAYEBvAggA2QMAABIAAACfAQMBpAEHAAAAYEBvAgkA2QMBABIAAACfAQMBpAEHAAAAYEBvAgoA2QMCABIAAACfAQMBggABAAsDDgQAAABAAw8EAAAgQAMQAxEDEgQAAGBAAxMDFAMVAwACBAEAARgAAAAAAAAAAAACAAAAAAANAAAAAAARAAAAAAASAgAAAAABAAABAgADowAAAMAAAACCAAIAAQYFAQUBAAEYAAAAAQAAAAAGq/eUykQDohOZM/5eEg2DVbiIDyPk6IU7BY7p85hdkjAFqd8lvT8c5Q==

return function() --[[ Line: 1 ]]
    local v0 = require(script.Parent.Config);
    it("should accept valid configuration", function() --[[ Line: 4 ]]
        -- upvalues: v0 (copy)
        local v1 = v0.new();
        local v2 = v1.get();
        expect(v2.elementTracing).to.equal(false);
        v1.set({
            elementTracing = true
        });
        expect(v2.elementTracing).to.equal(true);
    end);
    it("should reject invalid configuration keys", function() --[[ Line: 17 ]]
        -- upvalues: v0 (copy)
        local v3 = v0.new();
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 22 ]]
            -- upvalues: v3 (copy)
            v3.set({
                garblegoop = true
            });
        end);
        expect(l_status_0).to.equal(false);
        expect(l_result_0:find("garblegoop")).to.be.ok();
    end);
    it("should reject invalid configuration values", function() --[[ Line: 34 ]]
        -- upvalues: v0 (copy)
        local v6 = v0.new();
        local l_status_1, l_result_1 = pcall(function() --[[ Line: 40 ]]
            -- upvalues: v6 (copy)
            v6.set({
                elementTracing = "Hello there!"
            });
        end);
        expect(l_status_1).to.equal(false);
        expect(l_result_1:find("elementTracing")).to.be.ok();
        expect(l_result_1:find("Hello there!")).to.be.ok();
    end);
end;