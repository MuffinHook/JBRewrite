-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMYBE1ha2UJVHJhbnNmb3JtNU5vIHZhbGlkIHZlaGljbGUgbWFrZXMgd2l0aCB0aGF0IG5hbWUgY291bGQgYmUgZm91bmQuCFZhbGlkYXRlDEF1dG9jb21wbGV0ZQVQYXJzZQt2ZWhpY2xlTWFrZQxSZWdpc3RlclR5cGUMdmVoaWNsZU1ha2VzEE1ha2VMaXN0YWJsZVR5cGUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmULVmVoaWNsZURhdGEER2FtZQZHYXJhZ2UDU3RkClRhYmxlVXRpbHMKQ21kckNsaWVudAZTaGFyZWQEVXRpbANtYXAPTWFrZUZ1enp5RmluZGVyAAcCAQAAAAADTQEArQAAAACCAQIAAQMBAAYAARgAAAAHAAAAAAMBAQAAAAT7AQAAUgIAAJ8BAgCCAQAAAAAMAgEYAAAAAA0AAAAABAEAAAAACBwCAACMAwAAtwMCAAIAAACpAQABqQEBAG8CAACCAQMAAQMDABAEARgAAAAAAAAAABEAAAAAAQEAAAAAAYIAAgAAABQFARgAFQAAAAACAQAAAAACEwEAAIIBAgAAABgGARgAABkAAAAABgECAAAAD28DAAD7BAAAvAEA3QEAAACfAQQBbwMCAPsEAQBNBAQkAwAAAPsFAACfBAIAvAEA3QEAAACfAQABggABAAQDBwMIAwkDCgAdAAEYAAAAAAABAAAAAAAAAAABHgAAAAAIAAABAgA7owAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQMAvQcAAABNAwMoCAAAAE0CA1UGAAAAnwECAqQCBQAAAEBATQMAoQkAAABNAwMYCgAAAJ8CAgKkAwUAAABAQE0EAA4LAAAATQQEEgwAAABNBASeDQAAAJ8DAgJNBAKQDgAAAFIFAQDABg8AnwQDAk0FAz0QAAAAUgYEAJ8FAgLiBhUAwAcWABIABQAwBwYhEQAAAMAHFwAwBwZ2EgAAAMAHGAAwBwarEwAAAMAHGQAwBwabFAAAAMAHGgASAAYAEgADAIIHAgAbAwsEAAAAQAMMAw0DDgQAAEBAAw8DEAMRAxIDEwMUAxUDFgMXBgADGAMCAwQDBQMGBQQREhMUBgEGAgYDBgQGBQYAAQIDBAUBAAEYAAAAAAAAAAEAAAAAAAAAAAEAAAAAAAABAAAAAAAAAAACAAAAAAMAAAACAQAAAAQAAAQAAAQAAAUAAAABAAAAAAZCL5hv95lhKgfTaZsq1eqyMjePG3Dr8m4=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:01
-- Luau version 6, Types version 3
-- Time taken: 0.002254 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Util_upvr = require(ReplicatedStorage.CmdrClient.Shared.Util)
local tbl_upvr = {}
local any_MakeFuzzyFinder_result1_upvr = Util_upvr.MakeFuzzyFinder(require(ReplicatedStorage.Std.TableUtils).map(require(ReplicatedStorage.Game.Garage.VehicleData), function(arg1) -- Line 6
    return arg1.Make
end))
function tbl_upvr.Transform(arg1) -- Line 12
    --[[ Upvalues[1]:
        [1]: any_MakeFuzzyFinder_result1_upvr (readonly)
    ]]
    return any_MakeFuzzyFinder_result1_upvr(arg1)
end
function tbl_upvr.Validate(arg1) -- Line 16
    local var6
    if 0 >= #arg1 then
        var6 = false
    else
        var6 = true
    end
    return var6, "No valid vehicle makes with that name could be found."
end
function tbl_upvr.Autocomplete(arg1) -- Line 20
    return arg1
end
function tbl_upvr.Parse(arg1) -- Line 24
    return arg1[1]
end
return function(arg1) -- Line 29
    --[[ Upvalues[2]:
        [1]: tbl_upvr (readonly)
        [2]: Util_upvr (readonly)
    ]]
    arg1:RegisterType("vehicleMake", tbl_upvr)
    arg1:RegisterType("vehicleMakes", Util_upvr.MakeListableType(tbl_upvr))
end