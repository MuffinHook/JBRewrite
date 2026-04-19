-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMdBHR5cGUEdGV4dA9zZXREaWFsb2d1ZVRleHQNaGVsbG8sIHdvcmxkIQhkaXNwYXRjaA1jcmVhdGVCaW5kaW5nCXBjdENsb3NlZA91cGRhdGVQY3RDbG9zZWQEaW5pdA1jcmVhdGVFbGVtZW50DVN0b3JlUHJvdmlkZXIFc3RvcmUGcmVuZGVyB3VubW91bnQJQ29tcG9uZW50A0FwcAZleHRlbmQHcmVxdWlyZRFNYW5zaW9uUm9iYmVyeUFwcAZzY3JpcHQGUGFyZW50Dk1hbnNpb25Sb2JiZXJ5E21hbnNpb25Sb2JiZXJ5U3RvcmUFbW91bnQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlBVJvYWN0ClJvYWN0Um9kdXgABQUBAgAAABX7AQAA4gMCAG8EAwAwBANxAAAAAG8EBAAwBAPVAQAAALwBAUwFAAAAnwEDAfsBAQBNAQExBgAAAG8CBwCfAQIDMAEAtQgAAAAwAgBqCQAAAIIAAQAKAwEDAgUCAAEDAwMEAwUDBgKamZmZmZnZPwMHAwgACQkBGAAAAQAAAQAA/gAABAAAAAAAAAAAAQoAAAAACQEEAAAAGvsBAABNAQHKAAAAAPsCAQBNAgK6AQAAAOIDAwD7BAIAMAQDfgIAAAD/BAAAAQAAAPsFAABNBQXKAAAAAPsGAwDiBwUATQgAtQQAAAAwCAe1BAAAAJ8FAwDFBAUAAQAAAJ8BBACCAQAABgMKAwsDDAUBAgMHBQEEABANARgAAAAAAAAAAQAAAQABAAAAAAEAAAD/AAD9ABEAAAAAAgACAAAABvsAAABNAAASAAAAAPsBAQCfAAIBggABAAEDDgAbAAEYAAAAAAABHAAAAAAHAQMAAAAy+wEAAE0BAYgAAAAAbwMBALwBAZwCAAAAnwEDAqQCBAAAADBApAQHAAAAYEBNBAQkCAAAAE0DBFoFAAAAnwICAqQDBAAAADBA+wQBAE0EBPMJAAAATQQEXgoAAACfAwIC2QQAABIAAwASAgAAMAQBEwsAAADZBAEAEgIAABICAgASAAMAEgACADAEAYAMAAAA+wQAAE0EBOQNAAAA+wUAAE0FBcoOAAAAUgYBAJ8FAgJSBgAAnwQDAtkFAgASAgAAEgAEAIIFAgAPAw8DEAMRAxIEAAAwQAMTAxQEAABgQAMVAxYDFwMJAw0DGAMKAwABAgUAARgAAAAAAAAAAQAAAAAAAAAAAQAAAAAAAAABAAAAAAcAAAAAAAAKAAAAAAAAAAAAAQAAAAYAAAAABAAAAQIAFqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CACEGAAAAnwECAqQCBQAAAEBATQMALQcAAACfAgICwAMIABIAAQASAAAAEgACAIIDAgAJAxkEAAAAQAMaAxsDEgQAAEBAAxwDHQYDAQMBAAEYAAAAAAAAAAEAAAAAAQAAAAACAAAAAAEAAAAABKJKkg3sKfZVFKo5TlLQn8/SUoV5kI74DA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:03
-- Luau version 6, Types version 3
-- Time taken: 0.002003 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
return function(arg1) -- Line 5
    --[[ Upvalues[3]:
        [1]: Roact_upvr (readonly)
        [2]: ReplicatedStorage_upvr (readonly)
        [3]: RoactRodux_upvr (readonly)
    ]]
    local any_extend_result1 = Roact_upvr.Component:extend("App")
    local mansionRobberyStore_upvr = require(ReplicatedStorage_upvr.MansionRobbery.mansionRobberyStore)
    function any_extend_result1.init(arg1_2) -- Line 9
        --[[ Upvalues[2]:
            [1]: mansionRobberyStore_upvr (readonly)
            [2]: Roact_upvr (copied, readonly)
        ]]
        mansionRobberyStore_upvr:dispatch({
            type = "setDialogueText";
            text = "hello, world!";
        })
        local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(0.4)
        arg1_2.pctClosed = any_createBinding_result1
        arg1_2.updatePctClosed = any_createBinding_result2
    end
    local MansionRobberyApp_upvr = require(script.Parent.MansionRobberyApp)
    function any_extend_result1.render(arg1_3) -- Line 16
        --[[ Upvalues[4]:
            [1]: Roact_upvr (copied, readonly)
            [2]: RoactRodux_upvr (copied, readonly)
            [3]: mansionRobberyStore_upvr (readonly)
            [4]: MansionRobberyApp_upvr (readonly)
        ]]
        return Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
            store = mansionRobberyStore_upvr;
        }, {Roact_upvr.createElement(MansionRobberyApp_upvr, {
            pctClosed = arg1_3.pctClosed;
        })})
    end
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(any_extend_result1), arg1)
    return function() -- Line 27
        --[[ Upvalues[2]:
            [1]: Roact_upvr (copied, readonly)
            [2]: any_mount_result1_upvr (readonly)
        ]]
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end