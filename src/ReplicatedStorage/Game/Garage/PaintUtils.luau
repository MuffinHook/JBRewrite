-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMbBmlwYWlycwV0YWJsZQZyZW1vdmUORmluZEZpcnN0Q2hpbGQFZHJpbGwETmFtZQtCb3VuZGluZ0JveAZQYXJlbnQEd2FybgZjb25jYXQBLgVlcnJvciJnZXRWZWhpY2xlUGF0aCBmYWlsZWQsIHJlYWNoZWQgbmlsBmluc2VydA5nZXRWZWhpY2xlUGF0aAhJc1NlcnZlcghSZXNvdXJjZQhWZWhpY2xlcwVQbGFuZQRCb2F0BGdhbWUNU2VydmVyU3RvcmFnZQpHZXRTZXJ2aWNlDlNlcnZlclZlaGljbGVzFUdldERlZmF1bHRWZWhpY2xlUGFydBFSZXBsaWNhdGVkU3RvcmFnZQpSdW5TZXJ2aWNlAAQIAgAAAAAZ/wIAAAAAAACkAwEAAAAAQFIEAQCfAwIEUQMBAGoHAgZuA/7/AgAAgA4ADQAcAwIAjAQAAGAECgADAAAApAUEAAAMIIBSBgIAnwUCALwDAAMFAAAAnwMAAlIAAwBIAPL/ggACAAYDAQQAAABAAwIDAwQADCCAAwQABgUBGAAAAQAAAAAB/wADAAAAAAEAAAAAAAAA/wMHAAAAAAcBAAAAACVSAQAA/wIAAAEAAABNAwC6AAAAAMUCAwIBAAAAbwUBALwDAQMCAAAAnwMDAisDGABNAQEkAwAAACsBDACkAwUAAABAQKQECAAAHGCAUgUCAG8GCQCfBAMAnwMAAaQDCwAAAKBAbwQMAJ8DAgFNBQG6AAAAAJ40AgQFAAAAUgQCAKQDDgAANGCAnwMDAUgA4/+CAgIADwMGAwcDBAMIAwkEAABAQAMCAwoEABxggAMLAwwEAACgQAMNAw4EADRggAAQDwEYAAEAAAAAAAEAAAAAAQABAQAAAAAAAAABAAAAAgAAAAAAAAD6CBEAAAAABgEDAAAAavsBAABNAQE1AAAAAFICAACfAQIC+wIBALwCAgsBAAAAnwICAg4COQD7AgAATQICMQIAAAD7AwIATQMDYgMAAABvBQQAvAMDAwUAAACfAwMCUgQBAJ8CAwIrAisA+wIAAE0CAjECAAAA+wMCAE0DA2IDAAAAbwUGALwDAwMFAAAAnwMDAlIEAQCfAgMCKwIeAPsCAABNAgIxAgAAAPsDAgBNAwNiAwAAAG8FBwC8AwMDBQAAAJ8DAwJSBAEAnwIDAisCEQD7AgAATQICMQIAAACkAwkAAACAQG8FCgC8AwMWCwAAAJ8DAwJNAwNiAwAAAG8FDAC8AwMDBQAAAJ8DAwJSBAEAnwIDAoICAgD7AgAATQICMQIAAAD7AwIATQMDYgMAAABvBQQAvAMDAwUAAACfAwMCUgQBAJ8CAwIrAhkA+wIAAE0CAjECAAAA+wMCAE0DA2IDAAAAbwUGALwDAwMFAAAAnwMDAlIEAQCfAgMCKwIMAPsCAABNAgIxAgAAAPsDAgBNAwNiAwAAAG8FBwC8AwMDBQAAAJ8DAwJSBAEAnwIDAoICAgANAw8DEAMFAxEDEgMEAxMDFAMVBAAAgEADFgMXAxgAHRkBGAAAAAAAAQAAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAeAAAAAAQAAAECAByjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMC/wIDAAAAAADAAwUAMAMCMQYAAADAAwcAMAMCNQgAAADAAwkAEgACABIAAQASAAAAMAMCiAoAAACCAgIACwMVBAAAAEADGgMXAxsGAAMFBgEDDwYCAxkDAAECAQABGAAAAAAAAAABAAAAAAABAAMAAAoAAA0AAAAAAA0BAAAAAAMNANPJ8BpuXjW/oBZ6FjGnfRjEvT/Eucg=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:16
-- Luau version 6, Types version 3
-- Time taken: 0.006972 seconds

local module_upvr = {
    drill = function(arg1, arg2) -- Line 6, Named "drill"
        local tbl = {}
        local var10
        for i, v in ipairs(arg2) do
            tbl[i] = v
        end
        while var10 and 0 < #tbl do
            i = tbl
            var10 = var10:FindFirstChild(table.remove(i))
        end
        return var10
    end;
    getVehiclePath = function(arg1) -- Line 16, Named "getVehiclePath"
        local var11 = arg1
        local module = {arg1.Name}
        while not var11:FindFirstChild("BoundingBox") do
            local Parent = var11.Parent
            if not Parent then
                warn(table.concat(module, '.'))
                error("getVehiclePath failed, reached nil")
            end
            table.insert(module, Parent.Name)
        end
        return module
    end;
}
local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function module_upvr.GetDefaultVehiclePart(arg1) -- Line 29
    --[[ Upvalues[3]:
        [1]: module_upvr (readonly)
        [2]: RunService_upvr (readonly)
        [3]: ReplicatedStorage_upvr (readonly)
    ]]
    local any_getVehiclePath_result1 = module_upvr.getVehiclePath(arg1)
    if RunService_upvr:IsServer() then
        local any_drill_result1_2 = module_upvr.drill(ReplicatedStorage_upvr.Resource:FindFirstChild("Vehicles"), any_getVehiclePath_result1)
        if not any_drill_result1_2 then
            any_drill_result1_2 = module_upvr
            any_drill_result1_2 = any_drill_result1_2.drill(ReplicatedStorage_upvr.Resource:FindFirstChild("Plane"), any_getVehiclePath_result1)
            if not any_drill_result1_2 then
                any_drill_result1_2 = module_upvr
                any_drill_result1_2 = any_drill_result1_2.drill(ReplicatedStorage_upvr.Resource:FindFirstChild("Boat"), any_getVehiclePath_result1)
                if not any_drill_result1_2 then
                    any_drill_result1_2 = module_upvr
                    any_drill_result1_2 = any_drill_result1_2.drill(game:GetService("ServerStorage").Resource:FindFirstChild("ServerVehicles"), any_getVehiclePath_result1)
                end
            end
        end
        return any_drill_result1_2
    end
    local any_drill_result1_4 = module_upvr.drill(ReplicatedStorage_upvr.Resource:FindFirstChild("Vehicles"), any_getVehiclePath_result1)
    if not any_drill_result1_4 then
        any_drill_result1_4 = module_upvr
        any_drill_result1_4 = any_drill_result1_4.drill(ReplicatedStorage_upvr.Resource:FindFirstChild("Plane"), any_getVehiclePath_result1)
        if not any_drill_result1_4 then
            any_drill_result1_4 = module_upvr
            any_drill_result1_4 = any_drill_result1_4.drill(ReplicatedStorage_upvr.Resource:FindFirstChild("Boat"), any_getVehiclePath_result1)
        end
    end
    return any_drill_result1_4
end
return module_upvr