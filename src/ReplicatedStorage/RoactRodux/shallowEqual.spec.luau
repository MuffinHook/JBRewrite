return function() -- Line 1
    local shallowEqual_upvr = require(script.Parent.shallowEqual)
    it("should compare dictionaries", function() -- Line 4
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
        local tbl_5 = {}
        expect(shallowEqual_upvr(nil, nil)).to.equal(true)
        expect(shallowEqual_upvr(tbl_5, nil)).to.equal(false)
        expect(shallowEqual_upvr(nil, tbl_5)).to.equal(false)
    end)
end