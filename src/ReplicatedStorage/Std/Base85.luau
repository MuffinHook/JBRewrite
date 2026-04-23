local t = {}
local t2 = {
	"0",
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L",
	"M",
	"N",
	"O",
	"P",
	"Q",
	"R",
	"S",
	"T",
	"U",
	"V",
	"W",
	"X",
	"Y",
	"Z",
	"a",
	"b",
	"c",
	"d",
	"e",
	"f",
	"g",
	"h",
	"i",
	"j",
	"k",
	"l",
	"m",
	"n",
	"o",
	"p",
	"q",
	"r",
	"s",
	"t",
	"u",
	"v",
	"w",
	"x",
	"y",
	"z",
	"!",
	"#",
	"$",
	"%",
	"&",
	"(",
	")",
	"*",
	"+",
	"-",
	";",
	"<",
	"=",
	">",
	"?",
	"@",
	"^",
	"_",
	"`",
	"{",
	"|",
	"}",
	"~"
}
function t.encode(p1) --[[ Line: 104 | Upvalues: t2 (copy) ]]
	local v1 = table.create(math.floor((#p1 + 3) / 4) * 5)
	local sum = 1
	local sum_2 = 1
	while sum <= #p1 do
		local v2, v3, v4, v5 = string.byte(p1, sum, sum + 3)
		local v6 = (v2 or 0) * 16777216 + (v3 or 0) * 65536 + (v4 or 0) * 256 + (v5 or 0)
		for i = 4, 0, -1 do
			v1[sum_2 + i] = t2[math.floor(v6 % 85) + 1]
			v6 = math.floor(v6 / 85)
		end
		sum = sum + 4
		sum_2 = sum_2 + 5
	end
	for j = 1, sum - #p1 - 1 do
		v1[sum_2 - j] = nil
	end
	return table.concat(v1)
end
local t3 = {
	[48] = 0,
	[49] = 1,
	[50] = 2,
	[51] = 3,
	[52] = 4,
	[53] = 5,
	[54] = 6,
	[55] = 7,
	[56] = 8,
	[57] = 9,
	[65] = 10,
	[66] = 11,
	[67] = 12,
	[68] = 13,
	[69] = 14,
	[70] = 15,
	[71] = 16,
	[72] = 17,
	[73] = 18,
	[74] = 19,
	[75] = 20,
	[76] = 21,
	[77] = 22,
	[78] = 23,
	[79] = 24,
	[80] = 25,
	[81] = 26,
	[82] = 27,
	[83] = 28,
	[84] = 29,
	[85] = 30,
	[86] = 31,
	[87] = 32,
	[88] = 33,
	[89] = 34,
	[90] = 35,
	[97] = 36,
	[98] = 37,
	[99] = 38,
	[100] = 39,
	[101] = 40,
	[102] = 41,
	[103] = 42,
	[104] = 43,
	[105] = 44,
	[106] = 45,
	[107] = 46,
	[108] = 47,
	[109] = 48,
	[110] = 49,
	[111] = 50,
	[112] = 51,
	[113] = 52,
	[114] = 53,
	[115] = 54,
	[116] = 55,
	[117] = 56,
	[118] = 57,
	[119] = 58,
	[120] = 59,
	[121] = 60,
	[122] = 61,
	[33] = 62,
	[35] = 63,
	[36] = 64,
	[37] = 65,
	[38] = 66,
	[40] = 67,
	[41] = 68,
	[42] = 69,
	[43] = 70,
	[45] = 71,
	[59] = 72,
	[60] = 73,
	[61] = 74,
	[62] = 75,
	[63] = 76,
	[64] = 77,
	[94] = 78,
	[95] = 79,
	[96] = 80,
	[123] = 81,
	[124] = 82,
	[125] = 83,
	[126] = 84,
	[9] = -1,
	[10] = -1,
	[11] = -1,
	[12] = -1,
	[13] = -1,
	[32] = -1,
	[133] = -1,
	[160] = -1
}
function t.decode(p1) --[[ Line: 227 | Upvalues: t3 (copy) ]]
	local v1 = table.create((math.floor(#p1 * 4 / 5)))
	local v2 = 0
	local count = 0
	for i = 1, #p1 do
		local v3 = t3[string.byte(p1, i)]
		if not v3 then
			return "invalid byte at " .. i, ""
		end
		if v3 >= 0 then
			v2 = v2 * 85 + v3
			count = count + 1
			if count == 5 then
				table.insert(v1, (string.char(math.floor(v2 / 16777216 % 256), math.floor(v2 / 65536 % 256), math.floor(v2 / 256 % 256), (math.floor(v2 % 256)))))
				v2 = 0
				count = 0
			end
		end
	end
	if count > 0 then
		if count == 1 then
			return "corrupted base85 data at byte " .. #v1 - 1, ""
		end
		for j = count, 4 do
			v2 = v2 * 85 + 84
		end
		for k = 0, count - 2 do
			table.insert(v1, (string.char((math.floor(v2 / 16777216 % 256)))))
			v2 = v2 * 256
		end
	end
	return nil, table.concat(v1)
end
return t