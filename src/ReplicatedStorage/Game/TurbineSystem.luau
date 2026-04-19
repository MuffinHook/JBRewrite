-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMcAm9zBWNsb2NrB0ludmVyc2UGQ0ZyYW1lBkFuZ2xlcwJDMQRtYXRoBnJhbmRvbQlIZWFydGJlYXQHQ29ubmVjdAhHaXZlVGFzaxRvYnNlcnZlT25lQ2hpbGROYW1lZAtCbGFkZS0+QmFzZQNuZXcPb2JzZXJ2ZVByb3BlcnR5C1ByaW1hcnlQYXJ0B1R1cmJpbmUFU3RhcnQEaW5pdARnYW1lClJ1blNlcnZpY2UKR2V0U2VydmljZRFSZXBsaWNhdGVkU3RvcmFnZQdyZXF1aXJlA1N0ZAZCaW5kZXIETWFpZA9SeEluc3RhbmNlVXRpbHMABgwABAAAABmkAAIAAAQAgJ8AAQL7AgAAJgEAAvsCAQD7BQIAvAUF2gMAAACfBQICpAYGAAAUQICMBwAAjAgAAG8LBwAJCgsB+wsDAEMJCgufBgQCCQQFBvsFAgAJAwQFMAMCzAgAAACCAAEACQMBAwIEAAQAgAMDAwQDBQQAFECAAjMzMzMzM9O/AwYAFQABGAAAAAEAAQAAAAAAAAAAAAAAAAAAAAAAAAEWAAAAAAkCAgAAABekBAQAAAwggJ8EAQJbAwQBWwIDAKQDBwAAGFCAnwMBAvsGAABNBgb9CAAAANkIAAASAAMAEgAAABICAQASAAIAvAYGxwkAAACfBgMAvAQB/QoAAACfBAABggABAAsCAAAAAAAAAEACGC1EVPshCUADBwMIBAAMIIADAQMCBAAYUIADCQMKAwsBABIAARgAAAAAAAEAAAEAAAAAAAAAAAAAAAAABRMAAAAACAIDAAAADysAAQCCAAEA+wQAAE0EBOoAAAAAUgUAAG8GAQDZBwAAEgIBABICAgCfBAQAvAIB/QIAAACfAgABggABAAMDDAMNAwsBAQ0AARgAAQMAAAAAAAAAAP8AAAsOAAAAAAgBBAAAABL7AQAATQEB7wAAAACfAQEC+wQBAE0EBEgBAAAAUgUAAG8GAgDZBwAAEgIBABICAgASAgMAnwQEALwCAf0DAAAAnwIAAYIBAgAEAw4DDwMQAwsBAgsAARgAAAAAAQAAAAAAAAAAAAAAABEMAAAAAA0ABAAAAB2kAAIAAAQAgG8BAwBvAgQAbwMFAIwEAQCMBQAAjAYAAIwHAACMCAEAjAkAAIwKAACMCwAAjAwBAJ8ADQL7AQAATQEB7wEAAABvAgYA2QMAABICAQASAgIAEgIDABIAAACfAQMCvAIBHAcAAACfAgIBggABAAgDBAMOBAAEAIACUJ8XAEC00j8C+MPPf48XUcACL2UJAMjME0ADEQMSAQMIEwEYAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAABUAAAEJAAAAAAcAAAECACyjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMCpAIGAAAAUEBNAwGhBwAAAE0DA38IAAAAnwICAqQDBgAAAFBATQQBoQcAAABNBAR2CQAAAJ8DAgKkBAYAAABQQE0FAaEHAAAATQUFUgoAAACfBAIC/wUBAAAAAADABgsAEgACABIAAwASAAQAEgAAADAGBRMMAAAAggUCAA0DFAQAAABAAxUDFgMXAxgEAABQQAMZAxoDGwMcBgQDEwEEAQABGAAAAAAAAAABAAAAAAABAAAAAAAAAQAAAAAAAAEAAAAAAAACAAEAAAAAAAAaAQAAAAAFD651MohO/6TsgklpUW0JRX+2YkY9ah8z

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:50
-- Luau version 6, Types version 3
-- Time taken: 0.002357 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local Binder_upvr = require(ReplicatedStorage.Std.Binder)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local RunService_upvr = game:GetService("RunService")
function module.init() -- Line 8
    --[[ Upvalues[4]:
        [1]: Binder_upvr (readonly)
        [2]: Maid_upvr (readonly)
        [3]: RxInstanceUtils_upvr (readonly)
        [4]: RunService_upvr (readonly)
    ]]
    local cframe_upvr = CFrame.new(0.292251587, -68.3681335, 4.94998169, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    Binder_upvr.new("Turbine", function(arg1) -- Line 11
        --[[ Upvalues[4]:
            [1]: Maid_upvr (copied, readonly)
            [2]: RxInstanceUtils_upvr (copied, readonly)
            [3]: RunService_upvr (copied, readonly)
            [4]: cframe_upvr (readonly)
        ]]
        local any_new_result1 = Maid_upvr.new()
        any_new_result1:GiveTask(RxInstanceUtils_upvr.observeProperty(arg1, "PrimaryPart", function(arg1_2, arg2) -- Line 13
            --[[ Upvalues[3]:
                [1]: RxInstanceUtils_upvr (copied, readonly)
                [2]: RunService_upvr (copied, readonly)
                [3]: cframe_upvr (copied, readonly)
            ]]
            if not arg1_2 then
            else
                arg2:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1_2, "Blade->Base", function(arg1_3, arg2_2) -- Line 18
                    --[[ Upvalues[2]:
                        [1]: RunService_upvr (copied, readonly)
                        [2]: cframe_upvr (copied, readonly)
                    ]]
                    local os_clock_result1_upvr = os.clock()
                    local var14_upvr = math.random() * math.pi * 2
                    arg2_2:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 21
                        --[[ Upvalues[4]:
                            [1]: os_clock_result1_upvr (readonly)
                            [2]: arg1_3 (readonly)
                            [3]: cframe_upvr (copied, readonly)
                            [4]: var14_upvr (readonly)
                        ]]
                        arg1_3.C1 = cframe_upvr:Inverse() * CFrame.Angles(0, 0, -0.3 * (os.clock() - os_clock_result1_upvr) + var14_upvr) * cframe_upvr
                    end))
                end))
            end
        end))
        return any_new_result1
    end):Start()
end
return module