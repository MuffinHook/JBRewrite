-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPEG1pc3NpbmcgcG9zaXRpb24GYXNzZXJ0CU1hZ25pdHVkZRxkaXJlY3Rpb24gaXMgbm90IHVuaXQgbGVuZ3RoFmxlbmd0aCBpcyBub3Qgbm9uIHplcm8NUmF5Y2FzdFBhcmFtcwNuZXcaRmlsdGVyRGVzY2VuZGFudHNJbnN0YW5jZXMJd29ya3NwYWNlB1JheWNhc3QISW5zdGFuY2UKQ2FuQ29sbGlkZQV0YWJsZQZpbnNlcnQKY29sbGlkYWJsZQACDQUAAAAWBwADBQUICAKHhQ8FJy0CBikrDwcqKlSBAQAFAAAAAFIGAABvBwAApAUCAAAAEECfBQMBTQgBqgQAAAB4BwgDbwgFANQHAgAIAAAAqQYAAakGAQCBAQYEBgAAAG8HBgCkBQIAAAAQQJ8FAwGMBwAAtwcCAAIAAACpBgABqQYBAIEBBgQHAAAAbwcHAKQFAgAAABBAnwUDASsDBACkBQoAACSAgJ8FAQJSAwUAKwMBAIIAAQBNBQN9CwAAAIwGAADGBwAAbwgFAH0IJgACAAAAjAgKAH0GIwAIAAAApAgNAAAAwEBSCgAACQsBAlIMAwC8CAjCDgAAAJ8IBQJSBwgADgcYAA4EBQBSCAQATQkH9A8AAACfCAICKwgSACsEBQBNCQf0DwAAAE0ICdMQAAAAKwgMAE0KB/QPAAAAnjQFBAoAAABSCQUApAgTAABIEIGfCAMBMAUDfQsAAACVBgYDSADY/4IHAgAUAwEDAgQAABBAAgAAAAAAAPA/AwMC/Knx0k1iUD8DBAMFAwYDBwQAJICAAwgDCQQAAMBAAwoDCwMMAw0DDgQASBCBAAQPARgAAAAAAAAAAQAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAIBAAAAAwECAAIBAQAAAAAAAQAAAAAAAAAAAQMBAAAAAAABAAAAAAkAAAAAAAAABAAB6xcLAAAAAAIAAAECBwAAAQ8AAQYHowAAAP8AAQAAAAAAwAEAADABAJoBAAAAggACAAIGAAMPAQABAAEYAAEAAgAALwEAAAAAAQwuSaQiETJyPuojME4xG19HycEgSsAzW6ojkeKn9LxpC62/UCg+9Ys=

return {
    collidable = function(v0, v1, v2, v3, v4) --[[ Line: 4 ]] --[[ Name: collidable ]]
        assert(v0, "missing position");
        assert(v1.Magnitude - 1 <= 0.001, "direction is not unit length");
        assert(v2 > 0, "length is not non zero");
        if not v3 then
            v3 = RaycastParams.new();
        end;
        if not v3 then
            return;
        else
            local l_FilterDescendantsInstances_0 = v3.FilterDescendantsInstances;
            local v6 = 0;
            local v7 = nil;
            while v2 >= 0.001 and v6 <= 10 do
                v7 = workspace:Raycast(v0, v1 * v2, v3);
                if v7 and (not v4 or not v4(v7.Instance)) and (v4 or not v7.Instance.CanCollide) then
                    table.insert(l_FilterDescendantsInstances_0, v7.Instance);
                    v3.FilterDescendantsInstances = l_FilterDescendantsInstances_0;
                    v6 = v6 + 1;
                else
                    break;
                end;
            end;
            return v7;
        end;
    end
};