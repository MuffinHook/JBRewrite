-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMNAWMBYQFiBmV4cGVjdAJ0bwV0aHJvdwdyZXF1aXJlBnNjcmlwdAZQYXJlbnQGc3RyaWN0Aml0K3Nob3VsZCBlcnJvciB3aGVuIGdldHRpbmcgYSBub25leGlzdGVudCBrZXkrc2hvdWxkIGVycm9yIHdoZW4gc2V0dGluZyBhIG5vbmV4aXN0ZW50IGtleQAGAgABAAAEAAEADwT7AQAATQABggAAAACCAAIAAQMBAAoAARgAAAAACwAAAAAFAAEAAAgAAQEPDwAAFBT7AAAA4gECAIwCAQAwAgGAAAAAAIwCAgAwAgGDAQAAAJ8AAgKkAwQAAAAwQNkEAAASAAAAnwMCAk0CA5IFAAAATQEC2wYAAACfAQEBggABAAcDAgMDBQIAAQMEBAAAMEADBQMGAQAEAAEYAAABAAABAAD+BQAAAAACAAAAAAEFAAAAAAIAAQAABAABAA8F+wAAAIwBAwAwAQCCAAAAAIIAAQABAwEAFQABGAAAAAABFgAAAAAFAAEAAAgAAQEPDwAAFBT7AAAA4gECAIwCAQAwAgGAAAAAAIwCAgAwAgGDAQAAAJ8AAgKkAwQAAAAwQNkEAAASAAAAnwMCAk0CA5IFAAAATQEC2wYAAACfAQEBggABAAcDAgMDBQIAAQMEBAAAMEADBQMGAQIPAAEYAAABAAABAAD+BQAAAAACAAAAAAEQAAAAAAQAAAAABwAAAQ8AABYWpAABAAAAAECkAwMAAAAgQE0CAyQEAAAATQECjQUAAACfAAICpAEHAAAAYEBvAggA2QMAABIAAACfAQMBpAEHAAAAYEBvAgkA2QMBABIAAACfAQMBggABAAoDBwQAAABAAwgEAAAgQAMJAwoDCwQAAGBAAwwDDQIBAwEAARgAAAAAAAAAAAACAAAAAAALAAAAAAAKAgAAAAABAAABAgADowAAAMAAAACCAAIAAQYEAQQBAAEYAAAAAQAAAAAFs8X925CVzhSBAZdPMOgbU4QuFH2crQtiY1hEJwejoK/Kz/6MwMkoHg==

return function() --[[ Line: 1 ]]
    local v0 = require(script.Parent.strict);
    it("should error when getting a nonexistent key", function() --[[ Line: 4 ]]
        -- upvalues: v0 (copy)
        local v1 = v0({
            a = 1, 
            b = 2
        });
        expect(function() --[[ Line: 10 ]]
            -- upvalues: v1 (copy)
            return v1.c;
        end).to.throw();
    end);
    it("should error when setting a nonexistent key", function() --[[ Line: 15 ]]
        -- upvalues: v0 (copy)
        local v2 = v0({
            a = 1, 
            b = 2
        });
        expect(function() --[[ Line: 21 ]]
            -- upvalues: v2 (copy)
            v2.c = 3;
        end).to.throw();
    end);
end;