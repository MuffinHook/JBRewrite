-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

return function() --[[ Line: 1 ]]
    local v0 = require(script.Parent.NoYield);
    it("should call functions normally", function() --[[ Line: 4 ]]
        -- upvalues: v0 (copy)
        local v1 = 0;
        local v4, v5 = v0(function(v2, v3) --[[ Line: 7 ]] --[[ Name: test ]]
            -- upvalues: v1 (ref)
            expect(v2).to.equal(5);
            expect(v3).to.equal(6);
            v1 = v1 + 1;
            return 11, "hello";
        end, 5, 6);
        expect(v4).to.equal(11);
        expect(v5).to.equal("hello");
    end);
    it("should throw on yield", function() --[[ Line: 22 ]]
        -- upvalues: v0 (copy)
        local v6 = 0;
        local v7 = 0;
        local l_status_0, l_result_0 = pcall(v0, function() --[[ Line: 26 ]] --[[ Name: testMethod ]]
            -- upvalues: v6 (ref), v7 (ref)
            v6 = v6 + 1;
            wait();
            v7 = v7 + 1;
        end);
        expect(v6).to.equal(1);
        expect(v7).to.equal(0);
        expect(l_status_0).to.equal(false);
        expect(l_result_0:find("Attempted to yield inside changed event!")).to.be.ok();
        expect(l_result_0:find("NoYield.spec")).to.be.ok();
    end);
    it("should propagate error messages", function() --[[ Line: 42 ]]
        -- upvalues: v0 (copy)
        local v10 = 0;
        local l_status_1, l_result_1 = pcall(v0, function() --[[ Line: 45 ]] --[[ Name: test ]]
            -- upvalues: v10 (ref)
            v10 = v10 + 1;
            error("foo");
        end);
        expect(l_status_1).to.equal(false);
        expect(l_result_1:find("foo")).to.be.ok();
        expect(l_result_1:find("NoYield.spec")).to.be.ok();
    end);
end;