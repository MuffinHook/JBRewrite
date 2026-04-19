-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

return function() --[[ Line: 1 ]]
    local v0 = require(script.Parent.combineReducers);
    it("should invoke each sub-reducer for every action", function() --[[ Line: 4 ]]
        -- upvalues: v0 (copy)
        local v1 = 0;
        local v2 = 0;
        v0({
            a = function(_, _) --[[ Line: 9 ]] --[[ Name: a ]]
                -- upvalues: v1 (ref)
                v1 = v1 + 1;
            end, 
            b = function(_, _) --[[ Line: 12 ]] --[[ Name: b ]]
                -- upvalues: v2 (ref)
                v2 = v2 + 1;
            end
        })({}, {});
        expect(v1).to.equal(1);
        expect(v2).to.equal(1);
    end);
    it("should assign each sub-reducer's value to the new state", function() --[[ Line: 23 ]]
        -- upvalues: v0 (copy)
        local v11 = v0({
            a = function(v7, _) --[[ Line: 25 ]] --[[ Name: a ]]
                return (v7 or 0) + 1;
            end, 
            b = function(v9, _) --[[ Line: 28 ]] --[[ Name: b ]]
                return (v9 or 0) + 3;
            end
        })({}, {});
        expect(v11.a).to.equal(1);
        expect(v11.b).to.equal(3);
    end);
    it("should not throw when state is nil", function() --[[ Line: 38 ]]
        -- upvalues: v0 (copy)
        local v16 = v0({
            a = function(v12, _) --[[ Line: 40 ]] --[[ Name: a ]]
                return (v12 or 0) + 1;
            end, 
            b = function(v14, _) --[[ Line: 43 ]] --[[ Name: b ]]
                return (v14 or 0) + 3;
            end
        });
        expect(function() --[[ Line: 48 ]]
            -- upvalues: v16 (copy)
            v16(nil, {});
        end).to.never.throw();
    end);
end;