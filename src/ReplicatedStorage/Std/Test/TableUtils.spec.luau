-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local t = {
	best = 1,
	best2 = 2,
	history = {
		user1 = 1234,
		user2 = "1231",
		user3 = {
			tradeTime = 1
		}
	}
}
local t2 = {
	best2 = 2,
	best = 1,
	history = {
		user1 = 1234,
		user2 = "1231",
		user3 = {
			tradeTime = 2
		}
	}
}
local t3 = {
	best = 1,
	history = {
		user2 = "1231",
		user1 = 1234,
		user3 = {
			tradeTime = 1
		}
	},
	best2 = 2
}
local t4 = {
	best = 1,
	history = {
		user2 = "1231",
		user1 = 1234,
		user3 = {
			tradeTime = 1
		}
	},
	best4 = 2
}
local t5 = {
	best = "1",
	best2 = 2,
	history = {
		user1 = 1234,
		user2 = "1231",
		user3 = {
			tradeTime = 1
		}
	}
}
local t6 = {
	best = 1,
	best2 = 2,
	history = {
		user1 = 1234,
		user2 = "1231",
		user3 = {}
	}
}
local t7 = {
	best = 1,
	best2 = 2,
	history = {
		user1 = 1234,
		user2 = "1232",
		user3 = {}
	}
}
local t8 = {
	best = 1,
	best2 = 2,
	history = {
		user1 = 1234,
		user2 = "1231",
		user3 = {
			tradeTime1 = 1
		}
	}
}
local t9 = {
	History = {
		{
			TradeTime = 1651798785,
			UserId = 3
		}
	},
	Id = "5b^H<Tqj5gjU",
	ItemType = "VehicleCustomization",
	Name = "Level 1",
	SubItemType = "Brakes"
}
local t10 = {
	History = {
		{
			TradeTime = 1651794488,
			UserId = 1
		},
		{
			TradeTime = "1651794489",
			UserId = 1
		}
	},
	Id = "zYBU0k7^nhHo",
	ItemType = "VehicleCustomization",
	Name = "Level 1",
	SubItemType = "Brakes"
}
local t11 = {
	History = {
		{
			TradeTime = 1651798785,
			UserId = 3
		},
		{
			TradeTime = 1651798785,
			UserId = 3
		}
	},
	Id = "5b^H<Tqj5gjU",
	ItemType = "VehicleCustomization",
	Name = "Level 1",
	SubItemType = "Brakes"
}
local t12 = {
	History = {
		{
			TradeTime = 1651794488,
			UserId = 1
		},
		{
			TradeTime = 1651794489,
			UserId = 1
		}
	},
	Id = "zYBU0k7^nhHo",
	ItemType = "VehicleCustomization",
	Name = "Level 1",
	SubItemType = "Brakes"
}
local t13 = {
	History = {
		{
			TradeTime = 1651794488,
			UserId = 1
		},
		{
			TradeTime = 1651794480,
			UserId = 1
		}
	},
	Id = "zYBU0k7^nhHo",
	ItemType = "VehicleCustomization",
	Name = "Level 1",
	SubItemType = "Brakes"
}
local t14 = {
	CreationTime = 109123,
	History = {
		{
			TradeTime = 1651798785,
			UserId = 3
		}
	},
	Id = "5b^H<Tqj5gjU",
	ItemType = "VehicleCustomization",
	Name = "Level 1",
	SubItemType = "Brakes"
}
local t15 = {
	CreationTime = 1652224741,
	History = {
		{
			TradeTime = 1652224741,
			UserId = 8
		}
	},
	HitHistory = { "badcc", "asimo", "critstyx" },
	Id = "yS)S.?Wx%hFj",
	ItemType = "Vehicle",
	Make = "Roadster",
	Miles = 0
}
local t16 = {
	CreationTime = 1652224741,
	History = {
		{
			TradeTime = 1652224741,
			UserId = 8
		}
	},
	HitHistory = { "badcc", "asimo", "critstyx" },
	Id = "yS)S.?Wx%hFj",
	ItemType = "Vehicle",
	Make = "Roadster",
	Miles = 0
}
local t17 = {
	CreationTime = 1652224741,
	History = {
		{
			TradeTime = 1652224741,
			UserId = 8
		}
	},
	HitHistory = { "badcc", 123, "critstyx" },
	Id = "yS)S.?Wx%hFj",
	ItemType = "Vehicle",
	Make = "Roadster",
	Miles = 0
}
local t18 = {
	CreationTime = 1652224741,
	History = {
		{
			TradeTime = 1652224741,
			UserId = 8
		}
	},
	HitHistory = { "badcc", 123, "critstyx" },
	Id = "yS)S.?Wx%hFj",
	ItemType = "Vehicle",
	Make = "Roadster",
	Miles = 0
}
local t19 = {
	CreationTime = 1652422808,
	History = {
		{
			TradeTime = 1652422808,
			UserId = 1
		}
	},
	Id = "eSf]fE^@PB[2",
	ItemType = "Vehicle",
	Make = "Roadster"
}
local t20 = {
	CreationTime = 1652422808,
	History = {
		{
			TradeTime = 1652422808,
			UserId = 1
		}
	},
	HitHistory = 0,
	Id = "eSf]fE^@PB[2",
	ItemType = "Vehicle",
	Make = "Roadster",
	Miles = 0
}
return function()
	describe("CheckTableDeepCompare", function()
		it("should identify different tables", function()
			expect((TableUtils.deepCompareTables(t, t2))).to.equal(false)
		end)
		it("should identify same tables", function()
			expect((TableUtils.deepCompareTables(t, t3))).to.equal(true)
		end)
		it("should identify exact same tables", function()
			expect((TableUtils.deepCompareTables(t15, t16, false, true))).to.equal(true)
		end)
		it("should identify same tables with arrays", function()
			expect((TableUtils.deepCompareTables(t9, t11, true, false))).to.equal(true)
		end)
		it("should identify same tables with arrays reversed", function()
			expect((TableUtils.deepCompareTables(t11, t9, true, false))).to.equal(true)
		end)
		it("should identify different tables with arrays on format", function()
			expect((TableUtils.deepCompareTables(t9, t10, true, false))).to.equal(false)
		end)
		it("should identify different tables with arrays on value", function()
			expect((TableUtils.deepCompareTables(t12, t13, false, true))).to.equal(false)
		end)
		it("should identify same tables with arrays on format including array length matching", function()
			expect((TableUtils.deepCompareTables(t12, t13, true, true))).to.equal(true)
		end)
		it("should identify diff tables with arrays on format with wrong array lengths", function()
			expect((TableUtils.deepCompareTables(t12, t14, true, true))).to.equal(false)
		end)
		it("should identify arrays with inconsistent formatting", function()
			expect((TableUtils.deepCompareTables(t17, t18, true, true))).to.equal(false)
		end)
		it("should identify arrays with inconsistent formatting when comparing values", function()
			expect((TableUtils.deepCompareTables(t17, t18, false, true))).to.equal(false)
		end)
	end)
	describe("CheckTableDeepCompareFormat", function()
		it("should identify same table formats", function()
			expect((TableUtils.deepCompareTables(t, t2, true))).to.equal(true)
		end)
		it("should identify diff table formats based on keys", function()
			expect((TableUtils.deepCompareTables(t, t4, true))).to.equal(false)
		end)
		it("should identify diff table formats based on types", function()
			expect((TableUtils.deepCompareTables(t, t5, true))).to.equal(false)
		end)
		it("should identify diff table formats based on missing key", function()
			expect((TableUtils.deepCompareTables(t9, t14, true))).to.equal(false)
		end)
	end)
	describe("CheckTableDeepCheckSubset", function()
		it("should identify subsets with same value", function()
			expect((TableUtils.deepCheckSubset(t, t6, false))).to.equal(true)
		end)
		it("should identify subsets with same formats", function()
			expect((TableUtils.deepCheckSubset(t, t7, true))).to.equal(true)
		end)
		it("should identify subsets with diff values", function()
			expect((TableUtils.deepCheckSubset(t, t7, false))).to.equal(false)
		end)
		it("should identify non-subsets format only", function()
			expect((TableUtils.deepCheckSubset(t, t8, true))).to.equal(false)
		end)
		it("should identify non-subsets", function()
			expect((TableUtils.deepCheckSubset(t, t8, false))).to.equal(false)
		end)
		it("should identify subsets with same formats same values", function()
			expect((TableUtils.deepCheckSubset(t20, t19, false))).to.equal(true)
		end)
	end)
	describe("hasDesiredValuesShallow", function()
		local t = {
			a = 1,
			b = 2,
			c = 3
		}
		local t2 = {
			a = 1
		}
		local t3 = {
			c = 2
		}
		it("should be true when needle in haystack", function()
			expect((TableUtils.hasDesiredValuesShallow(t, t2))).to.equal(true)
		end)
		it("should be false when needle in haystack", function()
			expect((TableUtils.hasDesiredValuesShallow(t, t3))).to.equal(false)
		end)
	end)
	describe("canTellSequentialArrays", function()
		it("should be right 1", function()
			expect(TableUtils.isValidSequentialArray({ "a", "b", "c" })).to.equal(true)
		end)
		it("should be right 2 ", function()
			expect(TableUtils.isValidSequentialArray({
				nil,
				nil,
				nil,
				nil,
				nil,
				nil,
				nil,
				nil,
				nil,
				nil,
				nil,
				nil,
				"a",
				"b",
				"c"
			})).to.equal(false)
		end)
		it("should be right 3", function()
			expect(TableUtils.isValidSequentialArray({
				[1] = true,
				[3] = true,
				[2] = true,
				[4] = true
			})).to.equal(true)
		end)
		it("should be right 4", function()
			expect(TableUtils.isValidSequentialArray({
				[1] = true,
				[3] = true,
				[2] = true,
				[5] = true
			})).to.equal(false)
		end)
		it("should be right 5", function()
			expect(TableUtils.isValidSequentialArray({
				[1] = true,
				[3] = true,
				[2] = true,
				[6] = true
			})).to.equal(false)
		end)
		it("should be right 6", function()
			expect(TableUtils.isValidSequentialArray({
				hello = true,
				world = true,
				[1] = 3
			})).to.equal(false)
		end)
	end)
end
