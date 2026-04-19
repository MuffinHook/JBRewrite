-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMVBE5hbWUIdG9zdHJpbmc3W3dhaXRGb3JDaGlsZF0gVGltZW91dDogbm8gY2hpbGQgb2YgYCVzYCB3aXRoIG5hbWUgYCVzYAZmb3JtYXQKQ2hpbGRBZGRlZAdDb25uZWN0CEdpdmVUYXNrBWRlbGF5B2FuZFRoZW4LR2l2ZVByb21pc2UHRGVzdHJveQ5GaW5kRmlyc3RDaGlsZAdyZXNvbHZlA25ldwdmaW5hbGx5DHdhaXRGb3JDaGlsZAdyZXF1aXJlBnNjcmlwdAZQYXJlbnQHUHJvbWlzZQRNYWlkAAYEAQIAAAUAAgAPDw1NAQC6AAAAAPsDAAC7PwMCpAICAAAAEECfAgICmgEEAAIAAAD7AQEAUgIAAJ8BAgGCAAEAAwMBAwIEAAAQQAAPAAEYAAAAAAAAAAAAAQAAAhAAAAAABQADAAAKAAMBDw8PAwEGAgv7AAAAbwEAAPsEAQBNAwS6AQAAAPsEAgC8AQGNAgAAAJ8BBACfAAABggABAAMDAwMBAwQAFQABGAAAAAAAAAAAAAABFgAAAAAHAgUAAAgABQAPDw8PDyD7AgAA+wUBAE0EBWsAAAAA2QYAABICAgASAAAAvAQExwEAAACfBAMAvAIC/QIAAACfAgAB+wIDAA4CEAD7AgAA+wUEAE0EBb4DAAAA+wUDAJ8EAgLZBgEAEgABABICAQASAgIAvAQEtQQAAACfBAMAvAIC6QUAAACfAgABggABAAYDBQMGAwcDCAMJAwoCAAEOAAEYAAAAAAAAAAAAAAAAAAUAAQAAAAAAAAAAAAAAAAAAAAQPAAAAAAIAAQAABAABAA8F+wAAALwAAFAAAAAAnwACAYIAAQABAwsAGgABGAAAAAABGwAAAAAIAwIAABEAAgMPDw8DAAsPAwsUDwQPEB9SBQEAvAMAAwAAAACfAwMCDgMGAPsFAABNBAUdAQAAAFIFAwCfBAIAggQAAPsEAQBNAwTvAgAAAJ8DAQL7BQAATQQF7wIAAADZBQAAEgADABIAAAASAAEAEgACABICAACfBAIC2QcBABIAAwC8BQRCAwAAAJ8FAwGCBAIABAMMAw0DDgMPAgIDBRABGAAAAAABAQAAAAAABAAAAAEAAAAAAAAAAAAMAAAAAAMHAAAAAAUAAAECDwAAAw8AARYPAQoNDwITBBejAAAApAABAAAAAECkAwMAAAAgQE0CAyQEAAAATQECcgUAAACfAAICpAEBAAAAAECkBAMAAAAgQE0DBCQEAAAATQIDdgYAAACfAQICwAIHABIAAAASAAEAggICAAgDEQQAAABAAxIEAAAgQAMTAxQDFQYEAQQBAAEYAAEAAAAAAAAAAAEAAAAAAAAAAAIAABoBAAAAAAWh12uab+jgi5MTAQ7G2ARfAMO96SYQateWIoR9hx0dh2j4oAqS86KN

local v0 = require(script.Parent.Promise);
local v1 = require(script.Parent.Maid);
return function(v2, v3, v4) --[[ Line: 5 ]] --[[ Name: waitForChild ]]
    -- upvalues: v0 (copy), v1 (copy)
    local l_v2_FirstChild_0 = v2:FindFirstChild(v3);
    if l_v2_FirstChild_0 then
        return v0.resolve(l_v2_FirstChild_0);
    else
        l_v2_FirstChild_0 = v1.new();
        local v9 = v0.new(function(v6, v7) --[[ Line: 14 ]]
            -- upvalues: l_v2_FirstChild_0 (copy), v2 (copy), v3 (copy), v4 (copy), v0 (ref)
            l_v2_FirstChild_0:GiveTask(v2.ChildAdded:Connect(function(v8) --[[ Line: 15 ]]
                -- upvalues: v3 (ref), v6 (copy)
                if v8.Name == tostring(v3) then
                    v6(v8);
                end;
            end));
            if v4 then
                l_v2_FirstChild_0:GivePromise(v0.delay(v4):andThen(function() --[[ Line: 21 ]]
                    -- upvalues: v7 (copy), v2 (ref), v3 (ref)
                    v7(("[waitForChild] Timeout: no child of `%s` with name `%s`"):format(v2.Name, v3));
                end));
            end;
        end);
        v9:finally(function() --[[ Line: 26 ]]
            -- upvalues: l_v2_FirstChild_0 (copy)
            l_v2_FirstChild_0:Destroy();
        end);
        return v9;
    end;
end;