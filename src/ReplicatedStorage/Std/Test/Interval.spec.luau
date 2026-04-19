-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMbBXByaW50BG1hdGgDYWJzBWVycm9yD2ludmFsaWQgZWxhcHNlZBNkaWQgbm90IGZpcmUgb25jZTogCHRvc3RyaW5nDSAoJS4yZiwgJS4yZikGZm9ybWF0CkRpc2Nvbm5lY3QGcmFuZG9tBWV2ZXJ5B0Nvbm5lY3QEdGFzawVkZWxheQR3YWl0BmdldEVycgZleHBlY3QCdG8FZXF1YWwCaXQlc2hvdWxkIGFsbCBmaXJlIGFuZCBlbGFwc2VkIG1pbmltaXplZAhkZXNjcmliZQhJbnRlcnZhbAdyZXF1aXJlBnNjcmlwdAZQYXJlbnQACAQBBAAACwAEAQ8BDwICAQcRGKQBAQAAAABA+wIAAFIDAACfAQMBqQEBAN4BAQD7AwIAJgIAA7sCAgKkAQQAAAwggJ8BAgJvAgUAYAIFAAEAAACkAgcAAABgQG8DCACfAgIB+wIDAEMCAgHeAgMAggABAAkDAQQAAABAAwIDAwQADCCAAnsUrkfheqQ/AwQEAABgQAMFAAoAARgAAAAAAAEAAQAAAAAAAQAAAQAAAAIAAAELAAAAAAgABAAACwAEAQEPDw8DBBMCGfsAAAArABYA+wABAPsCAgBbAQIAYAESAAAAAACkAAIAAAAQQG8CAwD7BgMAuz8GAqQFBQAAAEBAnwUCAlIDBQBvBAYA+wYBAPsHAgC8BASNBwAAAJ8EBAJzAQIEnwACAYIAAQAIAgAAAAAAAABAAwQEAAAQQAMGAwcEAABAQAMIAwkAFAABGAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAIVAAAAAAIAAQAABAABAA8F+wAAALwAABoAAAAAnwACAYIAAQABAwoAGQABGAAAAAABGgAAAAAMAQEAABwAAQYPDwUFJgEGCCMPBwkiDwgYEw8EASoCAQAzM4wBAACMBAEAUgIAAIwDAQCoAicApAUCAAAEAICfBQECqQYAAMYHAAD7CQAATQgJxAMAAABSCQUAnwgCAtkKAAASAAQAEgEG/xIABQASAQH/vAgIxwQAAACfCAMCUgcIAKQIAgAABACAnwgBAqQJBwAAGFCAjAoCANkLAQASAQb/EgAIABIABQASAAQAnwkDAaQJBwAAGFCAUgoIANkLAgASAQf/nwkDAcEGAACLAtn/pAIJAAAgUICMAwMAnwICAewCAQDBAQAAggICAAoDAgMLBAAEAIADDAMNAw4DDwQAGFCAAxAEACBQgAMAAQIEEQEYAAEAAAABAAABAQEAAAAAAAAAAAAAAAAACQAAAQAAAAAAAAAABQAAAAAAAO0XAAAAAQAABQAAAAAFAAEAAAgAAQEPAQAEExekAAIAAAQAgIwBBQCfAAIB+wEAAIwCZACfAQICbwIDALcBAgACAAAAqQAAAakAAQCkAwUAAABAQFIEAACfAwICTQIDkgYAAABNAQJ7BwAAAKkCAQCfAQIBggABAAgDDgMQBAAEAIACmpmZmZmZuT8DEgQAAEBAAxMDFAAjAAEYAAAAAAEAAAAAAAAAAQAAAAAAAAAAAAEkAAAAAAMAAQAABAABAA8HpAABAAAAAEBvAQIAwAIDABICAACfAAMBggABAAQDFQQAAABAAxYGBAEEIgABGAAAAAAAAAUjAAAAAAMAAQAABAABAA8HpAABAAAAAEBvAQIAwAIDABICAACfAAMBggABAAQDFwQAAABAAxgGBQEFIQABGAAAAAAAAAciAAAAAAUAAAECCwAAAg8AARAPAQwFEaMAAACkAAEAAAAAQKQEAwAAACBATQMEJAQAAABNAgMkBAAAAE0BAqwFAAAAnwACAsABBgASAAAAwAIHABIAAQCCAgIACAMZBAAAAEADGgQAACBAAxsDGAYDBgYCAwYBAAEYAAEAAAAAAAAAAAAAAgAdAAABAAAAAAe38gixbLL4yIU2YiW1ijZG6JuKDo/eSgQAUSeiEVverWvPazUkkRIq

local v0 = require(script.Parent.Parent.Interval);
local function v12(v1) --[[ Line: 4 ]] --[[ Name: getErr ]]
    -- upvalues: v0 (copy)
    local v2 = 0;
    for v3 = 1, v1 do
        local v4 = math.random();
        local v5 = false;
        local v6 = nil;
        do
            local l_v5_0, l_v6_0 = v5, v6;
            l_v6_0 = v0.every(v4):Connect(function(v9) --[[ Line: 10 ]]
                -- upvalues: v3 (copy), l_v5_0 (ref), v4 (copy), v2 (ref)
                print(v3, v9);
                l_v5_0 = true;
                local v10 = math.abs(v9 - v4);
                if v10 > 0.04 then
                    error("invalid elapsed");
                end;
                v2 = v2 + v10;
            end);
            local v11 = math.random();
            task.delay(2, function() --[[ Line: 20 ]]
                -- upvalues: l_v5_0 (ref), v11 (copy), v4 (copy), v3 (copy)
                if not l_v5_0 and v11 > v4 * 2 then
                    error("did not fire once: " .. tostring(v3) .. (" (%.2f, %.2f)"):format(v11, v4));
                end;
            end);
            task.delay(v11, function() --[[ Line: 25 ]]
                -- upvalues: l_v6_0 (ref)
                l_v6_0:Disconnect();
            end);
        end;
    end;
    task.wait(3);
    return v2 / v1;
end;
return function() --[[ Line: 33 ]]
    -- upvalues: v12 (copy)
    describe("Interval", function() --[[ Line: 34 ]]
        -- upvalues: v12 (ref)
        it("should all fire and elapsed minimized", function() --[[ Line: 35 ]]
            -- upvalues: v12 (ref)
            task.wait(5);
            local v13 = v12(100) < 0.1;
            expect(v13).to.equal(true);
        end);
    end);
end;