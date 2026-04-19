-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMSCmdldE1vZHVsZXMKY3JlYXRlUGxhbgdydW5QbGFuA3J1bgdyZXF1aXJlBnNjcmlwdAtFeHBlY3RhdGlvbg1UZXN0Qm9vdHN0cmFwCFRlc3RFbnVtCFRlc3RQbGFuC1Rlc3RQbGFubmVyC1Rlc3RSZXN1bHRzClRlc3RSdW5uZXILVGVzdFNlc3Npb24JUmVwb3J0ZXJzDFRleHRSZXBvcnRlchFUZXh0UmVwb3J0ZXJRdWlldBBUZWFtQ2l0eVJlcG9ydGVyAAIHAgMAAAAT+wIAAFIEAAC8AgJrAAAAAJ8CAwL7AwEATQMDEAEAAABSBAIAnwMCAvsEAgBNBAR1AgAAAFIFAwCfBAICUgUBAFIGBACfBQIBggABAAMDAQMCAwMADQQBGAAAAAAAAQAAAAABAAAAAAIAAAEOAAAAAA4AAAECAHWjAAAApAABAAAAAECkAQMAAAAgQE0BAf8EAAAAnwACAqQBAQAAAABApAIDAAAAIEBNAgJ3BQAAAJ8BAgKkAgEAAAAAQKQDAwAAACBATQMDvgYAAACfAgICpAMBAAAAAECkBAMAAAAgQE0EBPsHAAAAnwMCAqQEAQAAAABApAUDAAAAIEBNBQXiCAAAAJ8EAgKkBQEAAAAAQKQGAwAAACBATQYG+QkAAACfBQICpAYBAAAAAECkBwMAAAAgQE0HB78KAAAAnwYCAqQHAQAAAABApAgDAAAAIEBNCAjYCwAAAJ8HAgKkCAEAAAAAQKQJAwAAACBATQkJmgwAAABNCQnYDQAAAJ8IAgKkCQEAAAAAQKQKAwAAACBATQoKmgwAAABNCgodDgAAAJ8JAgKkCgEAAAAAQKQLAwAAACBATQsLmgwAAABNCwtoDwAAAJ8KAgLACxAAEgABABIABAASAAYA4gwSADALDDYRAAAAMAAM/wQAAAAwAQx3BQAAADACDL4GAAAAMAMM+wcAAAAwBAziCAAAADAFDPkJAAAAMAYMvwoAAAAwBwzYCwAAAOINEwAwCA3YDQAAADAJDR0OAAAAMAoNaA8AAAAwDQyaDAAAAIIMAgAUAwUEAAAAQAMGBAAAIEADBwMIAwkDCgMLAwwDDQMOAw8DEAMRAxIGAAMEBQoRBAUGBwgJCgsMBQMNDg8BAAEAARgAAAAAAAAAAAEAAAAAAAABAAAAAAAAAQAAAAAAAAEAAAAAAAABAAAAAAAAAQAAAAAAAAEAAAAAAAABAAAAAAAAAAABAAAAAAAAAAABAAAAAAAAAAACAAAACAEAAgABAAEAAQABAAEAAQABAAIBAAEAAQD9AAcBAAAAAAEh0/JRszHxq76ckhbi8RgYUcvlJRMXmFA=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:31:58
-- Luau version 6, Types version 3
-- Time taken: 0.001875 seconds

local TestBootstrap_upvr = require(script.TestBootstrap)
local TestPlanner_upvr = require(script.TestPlanner)
local TestRunner_upvr = require(script.TestRunner)
return {
    run = function(arg1, arg2) -- Line 13, Named "run"
        --[[ Upvalues[3]:
            [1]: TestBootstrap_upvr (readonly)
            [2]: TestPlanner_upvr (readonly)
            [3]: TestRunner_upvr (readonly)
        ]]
        arg2(TestRunner_upvr.runPlan(TestPlanner_upvr.createPlan(TestBootstrap_upvr:getModules(arg1))))
    end;
    Expectation = require(script.Expectation);
    TestBootstrap = TestBootstrap_upvr;
    TestEnum = require(script.TestEnum);
    TestPlan = require(script.TestPlan);
    TestPlanner = TestPlanner_upvr;
    TestResults = require(script.TestResults);
    TestRunner = TestRunner_upvr;
    TestSession = require(script.TestSession);
    Reporters = {
        TextReporter = require(script.Reporters.TextReporter);
        TextReporterQuiet = require(script.Reporters.TextReporterQuiet);
        TeamCityReporter = require(script.Reporters.TeamCityReporter);
    };
}