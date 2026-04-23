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
return function() --[[ Line: 204 | Upvalues: TableUtils (copy), t (copy), t2 (copy), t3 (copy), t15 (copy), t16 (copy), t9 (copy), t11 (copy), t10 (copy), t12 (copy), t13 (copy), t14 (copy), t17 (copy), t18 (copy), t4 (copy), t5 (copy), t6 (copy), t7 (copy), t8 (copy), t20 (copy), t19 (copy) ]]
	describe("CheckTableDeepCompare", function() --[[ Line: 205 | Upvalues: TableUtils (ref), t (ref), t2 (ref), t3 (ref), t15 (ref), t16 (ref), t9 (ref), t11 (ref), t10 (ref), t12 (ref), t13 (ref), t14 (ref), t17 (ref), t18 (ref) ]]
		it("should identify different tables", function() --[[ Line: 206 | Upvalues: TableUtils (ref), t (ref), t2 (ref) ]]
			expect((TableUtils.deepCompareTables(t, t2))).to.equal(false)
		end)
		it("should identify same tables", function() --[[ Line: 210 | Upvalues: TableUtils (ref), t (ref), t3 (ref) ]]
			expect((TableUtils.deepCompareTables(t, t3))).to.equal(true)
		end)
		it("should identify exact same tables", function() --[[ Line: 214 | Upvalues: TableUtils (ref), t15 (ref), t16 (ref) ]]
			expect((TableUtils.deepCompareTables(t15, t16, false, true))).to.equal(true)
		end)
		it("should identify same tables with arrays", function() --[[ Line: 218 | Upvalues: TableUtils (ref), t9 (ref), t11 (ref) ]]
			expect((TableUtils.deepCompareTables(t9, t11, true, false))).to.equal(true)
		end)
		it("should identify same tables with arrays reversed", function() --[[ Line: 222 | Upvalues: TableUtils (ref), t11 (ref), t9 (ref) ]]
			expect((TableUtils.deepCompareTables(t11, t9, true, false))).to.equal(true)
		end)
		it("should identify different tables with arrays on format", function() --[[ Line: 226 | Upvalues: TableUtils (ref), t9 (ref), t10 (ref) ]]
			expect((TableUtils.deepCompareTables(t9, t10, true, false))).to.equal(false)
		end)
		it("should identify different tables with arrays on value", function() --[[ Line: 230 | Upvalues: TableUtils (ref), t12 (ref), t13 (ref) ]]
			expect((TableUtils.deepCompareTables(t12, t13, false, true))).to.equal(false)
		end)
		it("should identify same tables with arrays on format including array length matching", function() --[[ Line: 234 | Upvalues: TableUtils (ref), t12 (ref), t13 (ref) ]]
			expect((TableUtils.deepCompareTables(t12, t13, true, true))).to.equal(true)
		end)
		it("should identify diff tables with arrays on format with wrong array lengths", function() --[[ Line: 238 | Upvalues: TableUtils (ref), t12 (ref), t14 (ref) ]]
			expect((TableUtils.deepCompareTables(t12, t14, true, true))).to.equal(false)
		end)
		it("should identify arrays with inconsistent formatting", function() --[[ Line: 242 | Upvalues: TableUtils (ref), t17 (ref), t18 (ref) ]]
			expect((TableUtils.deepCompareTables(t17, t18, true, true))).to.equal(false)
		end)
		it("should identify arrays with inconsistent formatting when comparing values", function() --[[ Line: 246 | Upvalues: TableUtils (ref), t17 (ref), t18 (ref) ]]
			expect((TableUtils.deepCompareTables(t17, t18, false, true))).to.equal(false)
		end)
	end)
	describe("CheckTableDeepCompareFormat", function() --[[ Line: 251 | Upvalues: TableUtils (ref), t (ref), t2 (ref), t4 (ref), t5 (ref), t9 (ref), t14 (ref) ]]
		it("should identify same table formats", function() --[[ Line: 252 | Upvalues: TableUtils (ref), t (ref), t2 (ref) ]]
			expect((TableUtils.deepCompareTables(t, t2, true))).to.equal(true)
		end)
		it("should identify diff table formats based on keys", function() --[[ Line: 256 | Upvalues: TableUtils (ref), t (ref), t4 (ref) ]]
			expect((TableUtils.deepCompareTables(t, t4, true))).to.equal(false)
		end)
		it("should identify diff table formats based on types", function() --[[ Line: 260 | Upvalues: TableUtils (ref), t (ref), t5 (ref) ]]
			expect((TableUtils.deepCompareTables(t, t5, true))).to.equal(false)
		end)
		it("should identify diff table formats based on missing key", function() --[[ Line: 264 | Upvalues: TableUtils (ref), t9 (ref), t14 (ref) ]]
			expect((TableUtils.deepCompareTables(t9, t14, true))).to.equal(false)
		end)
	end)
	describe("CheckTableDeepCheckSubset", function() --[[ Line: 269 | Upvalues: TableUtils (ref), t (ref), t6 (ref), t7 (ref), t8 (ref), t20 (ref), t19 (ref) ]]
		it("should identify subsets with same value", function() --[[ Line: 270 | Upvalues: TableUtils (ref), t (ref), t6 (ref) ]]
			expect((TableUtils.deepCheckSubset(t, t6, false))).to.equal(true)
		end)
		it("should identify subsets with same formats", function() --[[ Line: 274 | Upvalues: TableUtils (ref), t (ref), t7 (ref) ]]
			expect((TableUtils.deepCheckSubset(t, t7, true))).to.equal(true)
		end)
		it("should identify subsets with diff values", function() --[[ Line: 278 | Upvalues: TableUtils (ref), t (ref), t7 (ref) ]]
			expect((TableUtils.deepCheckSubset(t, t7, false))).to.equal(false)
		end)
		it("should identify non-subsets format only", function() --[[ Line: 282 | Upvalues: TableUtils (ref), t (ref), t8 (ref) ]]
			expect((TableUtils.deepCheckSubset(t, t8, true))).to.equal(false)
		end)
		it("should identify non-subsets", function() --[[ Line: 286 | Upvalues: TableUtils (ref), t (ref), t8 (ref) ]]
			expect((TableUtils.deepCheckSubset(t, t8, false))).to.equal(false)
		end)
		it("should identify subsets with same formats same values", function() --[[ Line: 290 | Upvalues: TableUtils (ref), t20 (ref), t19 (ref) ]]
			expect((TableUtils.deepCheckSubset(t20, t19, false))).to.equal(true)
		end)
	end)
	describe("hasDesiredValuesShallow", function() --[[ Line: 295 | Upvalues: TableUtils (ref) ]]
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
		it("should be true when needle in haystack", function() --[[ Line: 307 | Upvalues: TableUtils (ref), t (copy), t2 (copy) ]]
			expect((TableUtils.hasDesiredValuesShallow(t, t2))).to.equal(true)
		end)
		it("should be false when needle in haystack", function() --[[ Line: 311 | Upvalues: TableUtils (ref), t (copy), t3 (copy) ]]
			expect((TableUtils.hasDesiredValuesShallow(t, t3))).to.equal(false)
		end)
	end)
	describe("canTellSequentialArrays", function() --[[ Line: 316 | Upvalues: TableUtils (ref) ]]
		it("should be right 1", function() --[[ Line: 317 | Upvalues: TableUtils (ref) ]]
			expect(TableUtils.isValidSequentialArray({ "a", "b", "c" })).to.equal(true)
		end)
		it("should be right 2 ", function() --[[ Line: 320 | Upvalues: TableUtils (ref) ]]
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
		it("should be right 3", function() --[[ Line: 339 | Upvalues: TableUtils (ref) ]]
			expect(TableUtils.isValidSequentialArray({
				[1] = true,
				[3] = true,
				[2] = true,
				[4] = true
			})).to.equal(true)
		end)
		it("should be right 4", function() --[[ Line: 342 | Upvalues: TableUtils (ref) ]]
			expect(TableUtils.isValidSequentialArray({
				[1] = true,
				[3] = true,
				[2] = true,
				[5] = true
			})).to.equal(false)
		end)
		it("should be right 5", function() --[[ Line: 347 | Upvalues: TableUtils (ref) ]]
			expect(TableUtils.isValidSequentialArray({
				[1] = true,
				[3] = true,
				[2] = true,
				[6] = true
			})).to.equal(false)
		end)
		it("should be right 6", function() --[[ Line: 352 | Upvalues: TableUtils (ref) ]]
			expect(TableUtils.isValidSequentialArray({
				hello = true,
				world = true,
				[1] = 3
			})).to.equal(false)
		end)
	end)
end