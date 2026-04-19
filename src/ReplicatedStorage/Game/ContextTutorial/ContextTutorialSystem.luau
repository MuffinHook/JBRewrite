-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMSBmlwYWlycwZzY3JpcHQGUGFyZW50Bk1vZHVsZQtHZXRDaGlsZHJlbgVDbGFzcwNuZXcETmFtZQdyZXF1aXJlBVN0YXJ0BXRhYmxlBmluc2VydARpbml0BGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQNTdGQGQmluZGVyAAILAAEAAAAo/wAAAAAAAACkAQEAAAAAQKQCAwAAACBATQICJAQAAABNAgJABQAAALwCAmgGAAAAnwICAJ8BAARRARYATQYFJQcAAAD7BwAATQcH7wgAAABNCAW6CQAAAKQJCwAAAKBAUgoGAJ8JAgCfBwACvAgHHAwAAACfCAIBnjQABQcAAABSCQAAUgoHAKQIDwAAONCAnwgDAW4B6f8CAACAggABABADAQQAAABAAwIEAAAgQAMDAwQDBQMGAwcDCAMJBAAAoEADCgMLAwwEADjQgAAFDQEYAAABAAAAAAAAAAAAAAAAAQABAAAAAAAAAAAAAQAAAQAAAAAAAPwABgYAAAAABAAAAQIAFaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKEGAAAATQICfwcAAACfAQIC/wIBAAAAAADAAwgAEgABADADAhMJAAAAggICAAoDDgQAAABAAw8DEAMJBAAAQEADEQMSBgADDQEAAQABGAAAAAAAAAABAAAAAAAAAgABAAAACQEAAAAAAR0ncIf9/APMkWd7zXafFqNtP2fzL+Mahg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:16
-- Luau version 6, Types version 3
-- Time taken: 0.001123 seconds

local module = {}
local Binder_upvr = require(game:GetService("ReplicatedStorage").Std.Binder)
function module.init() -- Line 5
    --[[ Upvalues[1]:
        [1]: Binder_upvr (readonly)
    ]]
    local tbl = {}
    for _, v in ipairs(script.Parent.Module:GetChildren()) do
        local any_new_result1 = Binder_upvr.new(v.Name, require(v.Class))
        any_new_result1:Start()
        table.insert(tbl, any_new_result1)
    end
end
return module