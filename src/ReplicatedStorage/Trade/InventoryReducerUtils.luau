-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMRCml0ZW1zT3duZWQSbWlzc2luZyBpdGVtc093bmVkBmFzc2VydA5idWlsZEl0ZW1Qcm9wcw50aW1lU29ydE1ldHJpYwxwcmltYXJ5SW5kZXgOZ2V0SW5zdENvbXBhcmUGbnVtYmVyBXRhYmxlBmluc2VydA1zZXRJdGVtc093bmVkBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVRyYWRlEVRyYWRlUmVkdWNlclV0aWxzAAINAgEAAABGTQQBpQAAAABHBAIAAAAAgKkDAAGpAwEAgQEDBAEAAABvBAEApAIDAAAAIECfAgMB/wIAAAAAAAD/AwAAAAAAAIwGAQBNBwGlAAAAABwEBwCMBQEAqAQgAE0IAaUAAAAAhwcIBvsIAABNCAhaBAAAAFIJBwCfCAICDggWADkJBgAwCQgmBQAAADAGCCIGAAAATQwI+AkAAACHCwMMkAoLCJUJCgdNCgj4CQAAAGoJAwowCQhgCgAAAJ40AgUIAAAAUgsCAFIMCACkCg0AADCwgJ8KAwGLBOD/jAYBABwEAgCMBQEAqAQLAIcHAgZNCQf4CQAAAIcIAwmMCQEAfQgEAAkAAADGCAAAMAgHYAoAAACLBPX/ggICAA4DAQMCAwMEAAAgQAMEAwUDBgIAAAAAAADwPwIAAAAAAAAAAAMHAwgDCQMKBAAwsIAABQsBGAAAAAAAAAAAAAAAAAEAAgABAAAAAAABAAABAAAAAAEBAAABAAEAAAAAAQAAAQACAAAAAAAA9g0AAAABAQAAAAAAAQAA/QYGAAAAAAQAAAECABWjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgC7BgAAAE0CAsUHAAAAnwECAv8CAQAAAAAAwAMIABIAAQAwAwLkCQAAAIICAgAKAwwEAAAAQAMNAw4DDwQAAEBAAxADEQYAAwsBAAEAARgAAAAAAAAAAQAAAAAAAAIAAQAAABsBAAAAAAGJpbfwhufbFZTNwgxDBC4J+b2ghLth3fE=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:10
-- Luau version 6, Types version 3
-- Time taken: 0.001965 seconds

local module_2 = {}
local TradeReducerUtils_upvr = require(game:GetService("ReplicatedStorage").Trade.TradeReducerUtils)
function module_2.setItemsOwned(arg1, arg2) -- Line 5
    --[[ Upvalues[1]:
        [1]: TradeReducerUtils_upvr (readonly)
    ]]
    local var7
    if arg2.itemsOwned == nil then
        var7 = false
    else
        var7 = true
    end
    assert(var7, "missing itemsOwned")
    local module = {}
    var7 = {}
    for i = 1, #arg2.itemsOwned do
        local any_buildItemProps_result1 = TradeReducerUtils_upvr.buildItemProps(arg2.itemsOwned[i])
        if any_buildItemProps_result1 then
            any_buildItemProps_result1.timeSortMetric = -i
            any_buildItemProps_result1.primaryIndex = i
            local var10 = (var7[any_buildItemProps_result1.getInstCompare] or 0) + 1
            var7[any_buildItemProps_result1.getInstCompare] = var10
            any_buildItemProps_result1.number = var10
            table.insert(module, any_buildItemProps_result1)
        end
    end
    for i_2 = 1, #module do
        local var11 = module[i_2]
        if var7[var11.getInstCompare] <= 1 then
            var11.number = nil
        end
    end
    return module
end
return module_2