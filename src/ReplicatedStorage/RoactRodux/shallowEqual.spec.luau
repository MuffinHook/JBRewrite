-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPAWEBYgFjAWQFaGVsbG8GZXhwZWN0AnRvBWVxdWFsB3JlcXVpcmUGc2NyaXB0BlBhcmVudAxzaGFsbG93RXF1YWwCaXQbc2hvdWxkIGNvbXBhcmUgZGljdGlvbmFyaWVzJXNob3VsZCBoYW5kbGUgbmlsIGZvciBlaXRoZXIgYXJndW1lbnQABAgAAQAAAIQB4gADAG8BAAAwAQCAAAAAAP8BAAAAAAAAMAEAgwEAAACMAQYAMAEAggIAAADiAQQATQIAgwEAAAAwAgGDAQAAAE0CAIICAAAAMAIBggIAAABNAgCAAAAAADACAYAAAAAA4gIFAP8DAAAAAAAAMAMCgwEAAABNAwCAAAAAADADAoAAAAAATQMAggIAAAAwAwKCAgAAAOIDBwBNBACAAAAAADAEA4AAAAAATQQAgwEAAAAwBAODAQAAAE0EAIICAAAAMAQDggIAAABvBAgAMAQDhQYAAACkBAoAAACQQPsFAABSBgAAUgcAAJ8FAwCfBAACTQQEkgsAAABNBAR7DAAAAKkFAQCfBAIBpAQKAAAAkED7BQAAUgYAAFIHAQCfBQMAnwQAAk0EBJILAAAATQQEewwAAACpBQEAnwQCAaQECgAAAJBA+wUAAFIGAABSBwIAnwUDAJ8EAAJNBASSCwAAAE0EBHsMAAAAqQUAAJ8EAgGkBAoAAACQQPsFAABSBgEAUgcCAJ8FAwCfBAACTQQEkgsAAABNBAR7DAAAAKkFAACfBAIBpAQKAAAAkED7BQAAUgYAAFIHAwCfBQMAnwQAAk0EBJILAAAATQQEewwAAACpBQAAnwQCAaQECgAAAJBA+wUAAFIGAQBSBwMAnwUDAJ8EAAJNBASSCwAAAE0EBHsMAAAAqQUAAJ8EAgGCAAEADQMBAwIDAwUDAAECBQMBAgAFAwEAAgMEBQQAAQIGAwUDBgQAAJBAAwcDCAAEAAEYAAEAAAEAAAABAAADAQAAAAEAAAABAAAAAwEAAAABAAAAAQAAAAMBAAAAAQAAAAEAAAABAAADAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAABBQAAAAAFAAEAAAAq/wAAAAAAAACkAQEAAAAAQPsCAADGAwAAxgQAAJ8CAwCfAQACTQEBkgIAAABNAQF7AwAAAKkCAQCfAQIBpAEBAAAAAED7AgAAUgMAAMYEAACfAgMAnwEAAk0BAZICAAAATQEBewMAAACpAgAAnwECAaQBAQAAAABA+wIAAMYDAABSBAAAnwIDAJ8BAAJNAQGSAgAAAE0BAXsDAAAAqQIAAJ8BAgGCAAEABAMGBAAAAEADBwMIACYAARgAAAIAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAEnAAAAAAQAAAAAABakAAEAAAAAQKQBAwAAACBATQEBJAQAAABNAQE8BQAAAJ8AAgKkAQcAAABgQG8CCADZAwAAEgAAAJ8BAwGkAQcAAABgQG8CCQDZAwEAEgAAAJ8BAwGCAAEACgMJBAAAAEADCgQAACBAAwsDDAMNBAAAYEADDgMPAgABAQABGAAAAAAAAAAAAAIAAAAAACIAAAAAAAcCAAAAAAEAAAECAAOjAAAAwAAAAIIAAgABBgIBAgEAARgAAAABAAAAAAMoBQyXOnPgNKW+ktYM01cRWB0b4xrBZpY=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:31:43
-- Luau version 6, Types version 3
-- Time taken: 0.002104 seconds

return function() -- Line 1
    local shallowEqual_upvr = require(script.Parent.shallowEqual)
    it("should compare dictionaries", function() -- Line 4
        --[[ Upvalues[1]:
            [1]: shallowEqual_upvr (readonly)
        ]]
        local tbl = {
            a = 'a';
            b = {};
            c = 6;
        }
        local tbl_4 = {
            b = tbl.b;
            c = tbl.c;
            a = tbl.a;
        }
        local tbl_2 = {
            b = {};
            a = tbl.a;
            c = tbl.c;
        }
        local tbl_3 = {
            a = tbl.a;
            b = tbl.b;
            c = tbl.c;
            d = "hello";
        }
        expect(shallowEqual_upvr(tbl, tbl)).to.equal(true)
        expect(shallowEqual_upvr(tbl, tbl_4)).to.equal(true)
        expect(shallowEqual_upvr(tbl, tbl_2)).to.equal(false)
        expect(shallowEqual_upvr(tbl_4, tbl_2)).to.equal(false)
        expect(shallowEqual_upvr(tbl, tbl_3)).to.equal(false)
        expect(shallowEqual_upvr(tbl_4, tbl_3)).to.equal(false)
    end)
    it("should handle nil for either argument", function() -- Line 38
        --[[ Upvalues[1]:
            [1]: shallowEqual_upvr (readonly)
        ]]
        local tbl_5 = {}
        expect(shallowEqual_upvr(nil, nil)).to.equal(true)
        expect(shallowEqual_upvr(tbl_5, nil)).to.equal(false)
        expect(shallowEqual_upvr(nil, tbl_5)).to.equal(false)
    end)
end