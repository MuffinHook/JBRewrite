-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMZBmlwYWlycwtfbGlzdFdpbmRvdwdEZXN0cm95DHNldG1ldGF0YWJsZQNuZXcFX21haWQIR2l2ZVRhc2sGSXNPcGVuBUNsb3NlDl9iZWZvcmVPcGVuRnVuC19fQ2xhc3NOYW1lBldpbmRvdwZhc3NlcnQFZXJyb3IfV2luZG93IGFscmVhZHkgZXhpc3RzIGluIGdyb3VwLgV0YWJsZQZpbnNlcnQDQWRkBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlA1N0ZARNYWlkB19faW5kZXgABgcAAQAAABGkAAEAAAAAQPsBAABNAQHxAgAAAJ8AAgRRAAMAvAUEUAMAAACfBQIBbgD8/wIAAID7AAAAxgEAADABAPECAAAAggABAAQDAQQAAABAAwIDAwAMAAEYAAAAAAAAAAEAAP8AAwAAAAENAAAAAAQAAgAAABv/AAIAAAAAAPsDAACePQAEAwAAAFICAACkAQEAAAAAQJ8BAwH7AQEATQEB7wIAAACfAQECMAEAwQMAAAD/AQAAAAAAADABAPEEAAAATQEAwQMAAADZAwAAEgAAALwBAf0FAAAAnwEDAYIAAgAGAwQEAAAAQAMFAwYDAgMHAQAGBQEYAAABAAAAAAAAAgAAAAAAAQAAAAEAAAAAAAAHBwAAAAAHAAIAAAAUpAABAAAAAED7AQAATQEB8QIAAACfAAIEUQAKAPsFAQDxBAgABQAAALwFBDEDAAAAnwUCAg4FAwC8BQRjBAAAAJ8FAgFuAPX/AgAAgIIAAQAFAwEEAAAAQAMCAwgDCQAfCgEYAAAAAAAAAAEAAAAAAAABAAD+AAUgAAAAAAkCAAAAACZNBAHlAAAAAPAEAgABAAAAqQMAAakDAQC7AQMCpAIDAAAAIECfAgIBpAIFAAAAQEBNAwDxBgAAAJ8CAgRRAgYAmgEFAAYAAACkBwgAAABwQG8ICQCfBwIBbgL5/wIAAIBNAwDxBgAAAJ40AwQBAAAAUgQBAKQCDAAALKCAnwIDAdkCAAASAAAAEgABADACARcNAAAAggABAA4DCwMMAw0EAAAgQAMBBAAAQEADAgMOBAAAcEADDwMQAxEEACyggAMKAQIVEgEYAAAAAAAAAAAAAAEAAAAAAAEAAQAAAP4ABQAAAAAAAAADAAAAAAcWAAAAAAQBAAAAAA9NAgDBAAAAALsBAgKkAQIAAAAQQJ8BAgFNAQDBAAAAAMYCAAAwAgDBAAAAALwCAVADAAAAnwICAYIAAQAEAwYDDQQAABBAAwMAJwMBGAAAAAAAAAEAAQAAAQAAASgAAAAABAAAAQIAHqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKEGAAAATQICdgcAAACfAQIC/wIDAAAAAAAwAgJuCAAAAMADCQASAAIAEgABADADAu8KAAAAwAMLADADAl8MAAAAwAMNADADAlAOAAAAggICAA8DEwQAAABAAxQDFQMWBAAAQEADFwMYAxkGAQMFBgMDEgYEAwMDAQMEAQABGAAAAAAAAAABAAAAAAAAAgABAAEAAAAADwAAEgAABgEAAAAABW8G89egtlviSwau6j/f1X8fHuSjXcKZ1g==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:54
-- Luau version 6, Types version 3
-- Time taken: 0.002539 seconds

local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(game:GetService("ReplicatedStorage").Std.Maid)
function module_upvr.new() -- Line 6
    --[[ Upvalues[2]:
        [1]: module_upvr (readonly)
        [2]: Maid_upvr (readonly)
    ]]
    local module_upvr_2 = {}
    setmetatable(module_upvr_2, module_upvr)
    module_upvr_2._maid = Maid_upvr.new()
    module_upvr_2._listWindow = {}
    module_upvr_2._maid:GiveTask(function() -- Line 12
        --[[ Upvalues[1]:
            [1]: module_upvr_2 (readonly)
        ]]
        for _, v in ipairs(module_upvr_2._listWindow) do
            v:Destroy()
        end
        module_upvr_2._listWindow = nil
    end)
    return module_upvr_2
end
function module_upvr.Add(arg1, arg2) -- Line 21
    local var14
    if arg2.__ClassName ~= "Window" then
        var14 = false
    else
        var14 = true
    end
    assert(var14)
    var14 = arg1._listWindow
    local ipairs_result1, ipairs_result2_3, ipairs_result3_2 = ipairs(var14)
    for _, v_2 in ipairs_result1, ipairs_result2_3, ipairs_result3_2 do
        if arg2 == v_2 then
            error("Window already exists in group.")
        end
    end
    ipairs_result2_3 = arg1._listWindow
    table.insert(ipairs_result2_3, arg2)
    function arg2._beforeOpenFun() -- Line 31
        --[[ Upvalues[2]:
            [1]: arg1 (readonly)
            [2]: arg2 (readonly)
        ]]
        for _, v_3 in ipairs(arg1._listWindow) do
            if v_3 ~= arg2 and v_3:IsOpen() then
                v_3:Close()
            end
        end
    end
end
function module_upvr.Destroy(arg1) -- Line 39
    assert(arg1._maid)
    arg1._maid = nil
    arg1._maid:Destroy()
end
return module_upvr