-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMRCFJlc291cmNlEkFwcmlsMjAyMExpdmVFdmVudA5GaW5kRmlyc3RDaGlsZAxXYWl0Rm9yQ2hpbGQEd2FpdAdyZXF1aXJlBEluaXQFcHJpbnQcTG9hZGVkIGFwcmlsIDIwMjAgbGl2ZSBldmVudAVDaGVjawVwY2FsbAR3YXJuBkxhdW5jaAVzcGF3bgRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UABAQAAwAAACL7AAAATQAAYgAAAABvAgEAvAAAAwIAAACfAAMCRwAZAAAAAACpAQEA3gEBAG8DAQC8AQDTAwAAAJ8BAwKkAgUAAABAQG8DBgCfAgIBpAIIAAAAcEBSAwEAnwICAk0CAnMJAAAA+wMCAJ8CAgHGAgAA3gICAKQCCwAAAKBAbwMMAJ8CAgGCAAEADQMBAwIDAwMEAwUEAABAQAKamZmZmZm5PwMGBAAAcEADBwMIBAAAoEADCQAGCgEYAAAAAAAAAAEAAQABAAAAAQAAAAEAAAAAAAAAAQABAAAAAggAAAAABAACAAAAEvsAAAAqAA8AAAAAgKQAAQAAAABA+wEBAJ8AAgMrAAQApAIDAAAAIEBSAwEAnwICAaQCBQAAAEBAjAMBAJ8CAgFIAO//ggABAAYDCwQAAABAAwwEAAAgQAMFBAAAQEAAEg0BGAAAAAEAAAABAQAAAAIAAAD7BxMAAAAAAwECAAAABt4AAACkAQEAAAAAQPsCAQCfAQIBggABAAIDDgQAAABAABsHARgAAQAAAAEcAAAAAAcAAAECABijAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCxgEAAKkCAADZAwAAEgAAABIBAv8SAQH/2QQBABIBAv8SAAMA2QUCABIBAf8SAAQA4gYFADAFBnMEAAAAwQEAAIIGAgAGAw8EAAAAQAMQAxEDBwUBBAMAAQIBAAEYAAAAAAAAAAICAQAAAAwAAAkAAAQBAAAAAQAAAAADyvObAIePRuMIluE3LJYmCbrrjHT4N/EB

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:06
-- Luau version 6, Types version 3
-- Time taken: 0.002002 seconds

local var1_upvw
local var2_upvw = false
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local function Check_upvr() -- Line 6, Named "Check"
    --[[ Upvalues[3]:
        [1]: ReplicatedStorage_upvr (readonly)
        [2]: var2_upvw (read and write)
        [3]: var1_upvw (read and write)
    ]]
    local April2020LiveEvent = ReplicatedStorage_upvr.Resource:FindFirstChild("April2020LiveEvent")
    if April2020LiveEvent ~= nil then
        var2_upvw = true
        wait(0.1)
        require(April2020LiveEvent:WaitForChild("April2020LiveEvent")).Init(var1_upvw)
        var1_upvw = nil
        print("Loaded april 2020 live event")
    end
end
local function Launch_upvr() -- Line 18, Named "Launch"
    --[[ Upvalues[2]:
        [1]: var2_upvw (read and write)
        [2]: Check_upvr (readonly)
    ]]
    while var2_upvw == false do
        local pcall_result1, pcall_result2 = pcall(Check_upvr)
        if not pcall_result1 then
            warn(pcall_result2)
        end
        wait(1)
    end
end
return {
    Init = function(arg1) -- Line 27, Named "Init"
        --[[ Upvalues[2]:
            [1]: var1_upvw (read and write)
            [2]: Launch_upvr (readonly)
        ]]
        var1_upvw = arg1
        spawn(Launch_upvr)
    end;
}