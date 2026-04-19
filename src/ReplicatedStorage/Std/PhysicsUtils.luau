-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKBnR5cGVvZgZudW1iZXIGYXNzZXJ0BG1hdGgEc3FydCNjYWxjdWxhdGVWZWxvY2l0eUZvckRlc2lyZWREaXN0YW5jZQl3b3Jrc3BhY2UHR3Jhdml0eSFjYWxjdWxhdGVWZWxvY2l0eUZvckRlc2lyZWRIZWlnaHQdY2FsY3VsYXRlVGltZUZvckRlc2lyZWRIZWlnaHQABAsDAAAAEAUAAgUDAgICAgMrDwIELwtEuywAA1IGAACkBQEAAAAAQJ8FAgLwBQIAAgAAAKkEAAGpBAEAuwEEAqQDBAAAADBAnwMCAbssAQNSBgEApAUBAAAAAECfBQIC8AUCAAIAAACpBAABqQQBALsBBAKkAwQAAAAwQJ8DAgG7LAIDUgYCAKQFAQAAAABAnwUCAvAFAgACAAAAqQQAAakEAQC7AQQCpAMEAAAAMECfAwIB7AMBAowEAABgAxAABAAAAAQEAQU5BgIAWwUGBewDBAVDBAMAOQYBADkKAgBbCQoFCQgJBLsZCAKkBwgAABxggJ8HAgJDBQYHggUCADkEAQA5CAIAWwcIBQkGBwC7GQYCpAUIAAAcYICfBQICQwMEBYIDAgAJAwEEAAAAQAMCAwMEAAAwQAIAAAAAAAAAQAMEAwUEABxggAALBgEYAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAQAAAAMAAAABAQAAAAAAAAAAAAYAAAAAAAAAAAAQAAAAAAgCAQAACAQBAAUCAgIPDPsDAABNAgN5AAAAAFIDAABSBAEApAcCAAAAEEBNBgclAwAAADkFBgCfAgQAggIAAAQDBgMHBAAAEEADCAAjCQEYAAAAAAAAAAAAAAAAJAAAAAAGAQAAAAYDAAAFAQILWwMAAKQFAgAAABBATQQFJQMAAADsAgMEuxkCAqQBBgAAFECAnwECAoIBAgAHAgAAAAAAAABAAwcEAAAQQAMIAwQDBQQAFECAACYKARgAAAAAAAAAAAAAACcAAAAAAgAAAQIHAAABDwABDQ6jAAAA/wADAAAAAADAAQAAMAEAeQEAAADAAQIAEgAAADABAJIDAAAAwAEEADABAMQFAAAAggACAAYGAAMGBgEDCQYCAwoDAAECAQABGAABAAkAABgAAAADAAAEAQAAAAADh/VEEoNfFHu1MS6GdOCQeqJ7gBMLj4z2Xu86Wz0wVj2/A3LodNMWcw==

local v4 = {
    calculateVelocityForDesiredDistance = function(v0, v1, v2) --[[ Line: 11 ]] --[[ Name: calculateVelocityForDesiredDistance ]]
        assert(typeof(v0) == "number");
        assert(typeof(v1) == "number");
        assert(typeof(v2) == "number");
        if v1 / v2 < 0 then
            local v3 = v1 ^ 2 / (-v2 * 2) + v0;
            return -v1 + math.sqrt(-v2 * 2 * v3);
        else
            return -v1 + math.sqrt(-v2 * 2 * v0);
        end;
    end
};
v4.calculateVelocityForDesiredHeight = function(v5, v6) --[[ Line: 35 ]] --[[ Name: calculateVelocityForDesiredHeight ]]
    -- upvalues: v4 (copy)
    return v4.calculateVelocityForDesiredDistance(v5, v6, -workspace.Gravity);
end;
v4.calculateTimeForDesiredHeight = function(v7) --[[ Line: 38 ]] --[[ Name: calculateTimeForDesiredHeight ]]
    return (math.sqrt(v7 * 2 / workspace.Gravity));
end;
return v4;