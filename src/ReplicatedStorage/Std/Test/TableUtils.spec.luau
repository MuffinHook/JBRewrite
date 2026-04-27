local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local testTable1 = {
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
local testTable2 = {
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
local testTable3 = {
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
local testTable4 = {
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
local testTable5 = {
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
local testTable6 = {
	best = 1,
	best2 = 2,
	history = {
		user1 = 1234,
		user2 = "1231",
		user3 = {}
	}
}
local testTable7 = {
	best = 1,
	best2 = 2,
	history = {
		user1 = 1234,
		user2 = "1232",
		user3 = {}
	}
}
local testTable8 = {
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
local testTable9 = {
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
local testTable10 = {
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
local testTable11 = {
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
local testTable12 = {
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
local testTable13 = {
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
local testTable14 = {
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
local testTable15 = {
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
local testTable16 = {
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
local testTable17 = {
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
local testTable18 = {
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
local testTable19 = {
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
local testTable20 = {
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
			expect((TableUtils.deepCompareTables(testTable1, testTable2))).to.equal(false)
		end)
		it("should identify same tables", function()
			expect((TableUtils.deepCompareTables(testTable1, testTable3))).to.equal(true)
		end)
		it("should identify exact same tables", function()
			expect((TableUtils.deepCompareTables(testTable15, testTable16, false, true))).to.equal(true)
		end)
		it("should identify same tables with arrays", function()
			expect((TableUtils.deepCompareTables(testTable9, testTable11, true, false))).to.equal(true)
		end)
		it("should identify same tables with arrays reversed", function()
			expect((TableUtils.deepCompareTables(testTable11, testTable9, true, false))).to.equal(true)
		end)
		it("should identify different tables with arrays on format", function()
			expect((TableUtils.deepCompareTables(testTable9, testTable10, true, false))).to.equal(false)
		end)
		it("should identify different tables with arrays on value", function()
			expect((TableUtils.deepCompareTables(testTable12, testTable13, false, true))).to.equal(false)
		end)
		it("should identify same tables with arrays on format including array length matching", function()
			expect((TableUtils.deepCompareTables(testTable12, testTable13, true, true))).to.equal(true)
		end)
		it("should identify diff tables with arrays on format with wrong array lengths", function()
			expect((TableUtils.deepCompareTables(testTable12, testTable14, true, true))).to.equal(false)
		end)
		it("should identify arrays with inconsistent formatting", function()
			expect((TableUtils.deepCompareTables(testTable17, testTable18, true, true))).to.equal(false)
		end)
		it("should identify arrays with inconsistent formatting when comparing values", function()
			expect((TableUtils.deepCompareTables(testTable17, testTable18, false, true))).to.equal(false)
		end)
	end)
	describe("CheckTableDeepCompareFormat", function()
		it("should identify same table formats", function()
			expect((TableUtils.deepCompareTables(testTable1, testTable2, true))).to.equal(true)
		end)
		it("should identify diff table formats based on keys", function()
			expect((TableUtils.deepCompareTables(testTable1, testTable4, true))).to.equal(false)
		end)
		it("should identify diff table formats based on types", function()
			expect((TableUtils.deepCompareTables(testTable1, testTable5, true))).to.equal(false)
		end)
		it("should identify diff table formats based on missing key", function()
			expect((TableUtils.deepCompareTables(testTable9, testTable14, true))).to.equal(false)
		end)
	end)
	describe("CheckTableDeepCheckSubset", function()
		it("should identify subsets with same value", function()
			expect((TableUtils.deepCheckSubset(testTable1, testTable6, false))).to.equal(true)
		end)
		it("should identify subsets with same formats", function()
			expect((TableUtils.deepCheckSubset(testTable1, testTable7, true))).to.equal(true)
		end)
		it("should identify subsets with diff values", function()
			expect((TableUtils.deepCheckSubset(testTable1, testTable7, false))).to.equal(false)
		end)
		it("should identify non-subsets format only", function()
			expect((TableUtils.deepCheckSubset(testTable1, testTable8, true))).to.equal(false)
		end)
		it("should identify non-subsets", function()
			expect((TableUtils.deepCheckSubset(testTable1, testTable8, false))).to.equal(false)
		end)
		it("should identify subsets with same formats same values", function()
			expect((TableUtils.deepCheckSubset(testTable20, testTable19, false))).to.equal(true)
		end)
	end)
	describe("hasDesiredValuesShallow", function()
		local haystack = {
			a = 1,
			b = 2,
			c = 3
		}
		local needleMatch = {
			a = 1
		}
		local needleMismatch = {
			c = 2
		}
		it("should be true when needle in haystack", function()
			expect((TableUtils.hasDesiredValuesShallow(haystack, needleMatch))).to.equal(true)
		end)
		it("should be false when needle in haystack", function()
			expect((TableUtils.hasDesiredValuesShallow(haystack, needleMismatch))).to.equal(false)
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
