-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMQASMGc2VsZWN0BEZpcmUEZmlyZQZ1bnBhY2sFZXJyb3IMY29ubmVjdChuaWwpBUV2ZW50B2Nvbm5lY3QEd2FpdEpNaXNzaW5nIGFyZyBkYXRhLCBsaWtlbHkgZHVlIHRvIDpUd2VlblNpemUvUG9zaXRpb24gY29ycnVwdGluZyB0aHJlYWRyZWZzLgZhc3NlcnQHRGVzdHJveQhJbnN0YW5jZQNuZXcNQmluZGFibGVFdmVudAAHBAEDAQAAE6MBAAD/AQAAAAAAAN0CAADFAQIAAQAAAN4BAABvAgAAuzkCA6QBAgAAABBA3QMAAJ8BAALeAQEA+wECALwBAd0DAAAAnwECAYIAAQAEAwEDAgQAABBAAwMAJgQBGAABAAAAAAABAAAAAAAAAQAAAAEmAAAAAAUAAwAAAAr7AAAA+wIBAIwDAQD7BAIATDUAAqQBAQAAAABAnwEEAJ8AAAGCAAEAAgMFBAAAAEAAMAABGAAAAAAAAAAAAAExAAAAAAUCAwAAABErAQUApAIBAAAAAEBvAwIAjAQCAJ8CAwH7AgAATQICNgMAAADZBAAAEgABABICAQASAgIAvAIC5wQAAACfAgMAggIAAAUDBgQAAABAAwcDCAMJAQEsCQEYAAEAAAAAAgAAAAAAAAAAAAAtAAAAAAUBAwAAABX7AQAATQEBNgAAAAC8AQGXAQAAAJ8BAgH7AgEAgQECBAIAAABvAwIApAEEAAAAMECfAQMB+wIBAIwDAQD7BAIATDUAAqQBBgAAAFBAnwEEAIIBAAAHAwgDCgMLAwwEAAAwQAMFBAAAUEAANQoBGAAAAAAAAAEAAAAAAAABAAAAAAAAADYAAAAAAwEDAAAAC/sBAAC8AQFQAAAAAJ8BAgHGAQAA3gEBAMYBAADeAQIAxgEAAN4BAACCAAEAAQMNADsNARgAAAAAAQABAAEAATwAAAAABQAAAAAAIv8AAwAAAAAApAECAAAEAIBvAgMAnwECAsYCAADGAwAA2QQAABIBAv8SAQP/EgEB/zAEAL0EAAAA2QQBABIBAf8SAQL/EgED/zAEAOcFAAAA2QQCABIBAf8SAQL/EgED/zAEAJcGAAAA2QQDABIBAf8SAQL/EgED/zAEAFAHAAAAwQEAAIIAAgAIAw4DDwQABACAAxADBAMJAwoDDQQAAgMEHg8BGAAAAgAAAAIBAgAAAAAABgAAAAAACQAAAAAABgAAAAAABwAfAAAAAAIAAAECAAejAAAA/wABAAAAAADAAQAAMAEA7wEAAACCAAIAAgYFAw8BBQEAARgAGwACAAAnAQAAAAAGaTLbyJ8AkrpnlQ1dpekU0xkqzLxb9rHJ

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:41
-- Luau version 6, Types version 3
-- Time taken: 0.002393 seconds

return {
    new = function() -- Line 30, Named "new"
        local module = {}
        local BindableEvent_upvw = Instance.new("BindableEvent")
        local var4_upvw
        local var5_upvw
        function module.fire(arg1, ...) -- Line 38
            --[[ Upvalues[3]:
                [1]: var4_upvw (read and write)
                [2]: var5_upvw (read and write)
                [3]: BindableEvent_upvw (read and write)
            ]]
            var4_upvw = {...}
            var5_upvw = select('#', ...)
            BindableEvent_upvw:Fire()
        end
        function module.connect(arg1, arg2) -- Line 44
            --[[ Upvalues[3]:
                [1]: BindableEvent_upvw (read and write)
                [2]: var4_upvw (read and write)
                [3]: var5_upvw (read and write)
            ]]
            if not arg2 then
                error("connect(nil)", 2)
            end
            return BindableEvent_upvw.Event:connect(function() -- Line 48
                --[[ Upvalues[3]:
                    [1]: arg2 (readonly)
                    [2]: var4_upvw (copied, read and write)
                    [3]: var5_upvw (copied, read and write)
                ]]
                arg2(unpack(var4_upvw, 1, var5_upvw))
            end)
        end
        function module.wait(arg1) -- Line 53
            --[[ Upvalues[3]:
                [1]: BindableEvent_upvw (read and write)
                [2]: var4_upvw (read and write)
                [3]: var5_upvw (read and write)
            ]]
            BindableEvent_upvw.Event:wait()
            assert(var4_upvw, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
            return unpack(var4_upvw, 1, var5_upvw)
        end
        function module.Destroy(arg1) -- Line 59
            --[[ Upvalues[3]:
                [1]: BindableEvent_upvw (read and write)
                [2]: var4_upvw (read and write)
                [3]: var5_upvw (read and write)
            ]]
            BindableEvent_upvw:Destroy()
            var4_upvw = nil
            var5_upvw = nil
            BindableEvent_upvw = nil
        end
        return module
    end;
}