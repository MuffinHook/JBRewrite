-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMgBmlwYWlycwVTcGVlZAZSYWRpdXMFQW5nbGUEUGFydAZDRnJhbWUGQW5nbGVzA25ldwRTaXplAVkHVmVjdG9yMwtCb2F0U2NlbmVyeQhSZXNvdXJjZQl3b3Jrc3BhY2UGUGFyZW50C0dldENoaWxkcmVuBE5hbWUEU2hpcARmaW5kCFNhaWxib2F0BG1hdGgGcmFuZG9tBmFzc2VydAV0YWJsZQZpbnNlcnQJSGVhcnRiZWF0B0Nvbm5lY3QESW5pdARnYW1lClJ1blNlcnZpY2UKR2V0U2VydmljZRFSZXBsaWNhdGVkU3RvcmFnZQADEAEBAAAHAAABCAowATakAQEAAAAAQPsCAACfAQIEUQEuAE0IBSwCAAAACQcIAE0IBXEDAAAA7AYHCE0IBS0EAAAAQwcIBjAHBS0EAAAATQcFRAUAAACkCwgAABxggIwMAABNDQUtBAAAAIwOAACfCwQCpAwKAAAkYIBNDQVxAwAAAIwOAACMDwAAnwwEAgkKCwxvCwsAQwkKC4wLAABNDQVEBQAAAE0NDS8NAAAATQ0NeA4AAABbDA0MjA0AAEw2AAKkChAAACTwgJ8KBAJDCAkKMAgHhQYAAABuAdH/AgAAgIIAAQARAwEEAAAAQAMCAwMDBAMFAwYDBwQAHGCAAwgEACRggAcAAClDAAAAAADAwcQAAAAAAgAAAAAAAOA/AwkDCgMLBAAk8IAAHgABGAAAAAAAAQAAAAAAAQAAAAABAAAAAAAAAAAAAAAAAAAAAAEAAQAAAAAAAAAAAAAAAAD+AP0ABx8AAAAAEQACAAAAVvsBAABNAQFiAQAAAE0AARkAAAAApAEDAAAAIEAwAQAkBAAAAP8BAAAAAAAApAIGAAAAUEC8AwBoBwAAAJ8DAgCfAgAEUQI5AMYHAABNCAa6CAAAAG8KCQC8CAhWCgAAAJ8IAwIOCAIAjAfs/2UADQBNCAa6CAAAAG8KCwC8CAhWCgAAAJ8IAwIOCAYAjAgtAKQKDwAAONCAnwoBAlsJCgxDBwgJuwEHA1IJBwCkCBEAAAAAQZ8IAgHiChYAMAYKRBIAAAAwBwosEwAAAKQODwAAONCAnw4BAlsNDhlbDA0YWwsMFzALCi0UAAAAbwwaAKQQDwAAONCAnxABAlsPEBh4Dg8cWw0OG0MLDA0wCwpxFQAAAJ40AQQKAAAAUgkBAKQIHwAAeNCBnwgDAW4Cxv8CAACA+wIBAE0CAv0gAAAA2QQAABIAAQC8AgLHIQAAAJ8CAwGCAAEAIgMMAw0DDgQAACBAAw8DAQQAAFBAAxADEQMSAxMDFAIAAAAAAAA0QAMVAxYEADjQgAMXBAAAAEEDBQMCAwQDAwUEEhMUFQKamZmZmZm5PwIAAAAAAAAAQAIYLURU+yEJQAKamZmZmVm5QAIAAAAAAABJQAIAAAAAAADwPwMYAxkEAHjQgQMaAxsBAAkcARgAAAAAAAEAAAACAAEAAAAAAAABAQAAAAAAAAEAAQAAAAAAAAEAAAAAAAIAAAAAAQEAAQABAAAAAAAAAAEAAAAAAAAAAAAAAAD8AAD4ABAAAAAAAAAACQoAAAAABAAAAQIAFaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQEAAAAAQG8DBAC8AQEWAwAAAJ8BAwL/AgEAAAAAAMADBQASAAEAEgAAADADAnMGAAAAggICAAcDHQQAAABAAx4DHwMgBgEDHAEBAQABGAAAAAAAAAABAAAAAAAGAAEAAAAAHwEAAAAAAguCcRB4HZPmYC9U9Q3j2/h7mmZkOUYbEQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:08
-- Luau version 6, Types version 3
-- Time taken: 0.004336 seconds

local module = {}
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local RunService_upvr = game:GetService("RunService")
function module.Init() -- Line 9
    --[[ Upvalues[2]:
        [1]: ReplicatedStorage_upvr (readonly)
        [2]: RunService_upvr (readonly)
    ]]
    local BoatScenery = ReplicatedStorage_upvr.Resource.BoatScenery
    BoatScenery.Parent = workspace
    local tbl_upvr = {}
    for _, v in ipairs(BoatScenery:GetChildren()) do
        local var13
        if v.Name:find("Ship") then
            var13 = -20
        elseif v.Name:find("Sailboat") then
            var13 = 45 + math.random() * 20
        end
        assert(var13)
        table.insert(tbl_upvr, {
            Part = v;
            Speed = var13;
            Angle = math.random() * math.pi * 2 * 0.1;
            Radius = 6489.6 + (math.random() * 2 - 1) * 50;
        })
    end
    RunService_upvr.Heartbeat:Connect(function(arg1) -- Line 30
        --[[ Upvalues[1]:
            [1]: tbl_upvr (readonly)
        ]]
        for _, v_2 in ipairs(tbl_upvr) do
            v_2.Angle += v_2.Speed * arg1 / v_2.Radius
            v_2.Part.CFrame = CFrame.Angles(0, v_2.Angle, 0) * CFrame.new(v_2.Radius, 0, 0) + Vector3.new(169, 0, -1550) + Vector3.new(0, v_2.Part.Size.Y * 0.5, 0)
        end
    end)
end
return module