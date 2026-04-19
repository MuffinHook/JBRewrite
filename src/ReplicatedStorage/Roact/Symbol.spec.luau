-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMWBW5hbWVkA2ZvbwZleHBlY3QCdG8CYmUBYQh1c2VyZGF0YQh0b3N0cmluZwRmaW5kAm9rA2FiYwVuZXZlcgVlcXVhbAJpdBxzaG91bGQgZ2l2ZSBhbiBvcGFxdWUgb2JqZWN0H3Nob3VsZCBjb2VyY2UgdG8gdGhlIGdpdmVuIG5hbWUhc2hvdWxkIGJlIHVuaXF1ZSB3aGVuIGNvbnN0cnVjdGVkB3JlcXVpcmUGc2NyaXB0BlBhcmVudAZTeW1ib2wIZGVzY3JpYmUABgYAAQAACAABAQ8PAAASEvsBAABNAAFRAAAAAG8BAQCfAAICpAQDAAAAIEBSBQAAnwQCAk0DBJIEAAAATQIDzAUAAABNAQKABgAAAG8CBwCfAQIBggABAAgDAQMCAwMEAAAgQAMEAwUDBgMHAAUAARgAAAAAAAIAAAAAAAAAAAAAAAEGAAAAAAgAAQAADAABAg8DBQ0CDwAAGRn7AQAATQABUQAAAABvAQEAnwACAqQEAwAAACBAuz8AA1IGAACkBQUAAABAQJ8FAgJvBwEAvAUFVgYAAACfBQMAnwQAAk0DBJIHAAAATQIDzAgAAABNAQIQCQAAAJ8BAQGCAAEACgMBAwIDAwQAACBAAwgEAABAQAMJAwQDBQMKAAsAARgAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAABDAAAAAAHAAEAAAwAAQIPDwAAFw8BBRIX+wEAAE0AAVEAAAAAbwEBAJ8AAgL7AgAATQECUQAAAABvAgEAnwECAqQFAwAAACBAUgYAAJ8FAgJNBAU1BAAAAE0DBJIFAAAATQIDewYAAABSAwEAnwICAYIAAQAHAwEDCwMDBAAAIEADDAMEAw0AEQABGAAAAAAAAQAAAAACAAAAAAAAAAAAAAABEgAAAAADAAEAAAQAAQAPE6QAAQAAAABAbwECANkCAAASAgAAnwADAaQAAQAAAABAbwEDANkCAQASAgAAnwADAaQAAQAAAABAbwEEANkCAgASAgAAnwADAYIAAQAFAw4EAAAAQAMPAxADEQMAAQIEAAEYAAAAAAAABgAAAAAABgAAAAAABgUAAAAABAAAAAAHAAABDwAAEBCkAAEAAAAAQKQDAwAAACBATQIDJAQAAABNAQKTBQAAAJ8AAgKkAQcAAABgQG8CCADZAwAAEgAAAJ8BAwGCAAEACQMSBAAAAEADEwQAACBAAxQDFQMWBAAAYEADAQEDAQABGAAAAAAAAAAAAAIAAAAAABQCAAAAAAEAAAECAAOjAAAAwAAAAIIAAgABBgQBBAEAARgAAAABAAAAAAW2IsSyHorVFITmriZTtT/kMrtGAOSJfALOD/h9zhe1kzkE6GsAfuFl

return function() --[[ Line: 1 ]]
    local v0 = require(script.Parent.Symbol);
    describe("named", function() --[[ Line: 4 ]]
        -- upvalues: v0 (copy)
        it("should give an opaque object", function() --[[ Line: 5 ]]
            -- upvalues: v0 (ref)
            local v1 = v0.named("foo");
            expect(v1).to.be.a("userdata");
        end);
        it("should coerce to the given name", function() --[[ Line: 11 ]]
            -- upvalues: v0 (ref)
            local v2 = v0.named("foo");
            expect(tostring(v2):find("foo")).to.be.ok();
        end);
        it("should be unique when constructed", function() --[[ Line: 17 ]]
            -- upvalues: v0 (ref)
            local v3 = v0.named("abc");
            local v4 = v0.named("abc");
            expect(v3).never.to.equal(v4);
        end);
    end);
end;