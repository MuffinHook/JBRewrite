local Base85 = {}
local base85Alphabet = {
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
function Base85.encode(inputString)
	local outputBuffer = table.create(math.floor((#inputString + 3) / 4) * 5)
	local inputIndex = 1
	local outputIndex = 1
	while inputIndex <= #inputString do
		local byte1, byte2, byte3, byte4 = string.byte(inputString, inputIndex, inputIndex + 3)
		local accumulatedValue = (byte1 or 0) * 16777216 + (byte2 or 0) * 65536 + (byte3 or 0) * 256 + (byte4 or 0)
		for i = 4, 0, -1 do
			outputBuffer[outputIndex + i] = base85Alphabet[math.floor(accumulatedValue % 85) + 1]
			accumulatedValue = math.floor(accumulatedValue / 85)
		end
		inputIndex = inputIndex + 4
		outputIndex = outputIndex + 5
	end
	for j = 1, inputIndex - #inputString - 1 do
		outputBuffer[outputIndex - j] = nil
	end
	return table.concat(outputBuffer)
end
local decodeMap = {
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
function Base85.decode(encodedString)
	local resultBuffer = table.create((math.floor(#encodedString * 4 / 5)))
	local accumulatorValue = 0
	local byteCount = 0
	for i = 1, #encodedString do
		local charValue = decodeMap[string.byte(encodedString, i)]
		if not charValue then
			return "invalid byte at " .. i, ""
		end
		if charValue >= 0 then
			accumulatorValue = accumulatorValue * 85 + charValue
			byteCount = byteCount + 1
			if byteCount == 5 then
				table.insert(resultBuffer, (string.char(math.floor(accumulatorValue / 16777216 % 256), math.floor(accumulatorValue / 65536 % 256), math.floor(accumulatorValue / 256 % 256), (math.floor(accumulatorValue % 256)))))
				accumulatorValue = 0
				byteCount = 0
			end
		end
	end
	if byteCount > 0 then
		if byteCount == 1 then
			return "corrupted base85 data at byte " .. #resultBuffer - 1, ""
		end
		for j = byteCount, 4 do
			accumulatorValue = accumulatorValue * 85 + 84
		end
		for k = 0, byteCount - 2 do
			table.insert(resultBuffer, (string.char((math.floor(accumulatorValue / 16777216 % 256)))))
			accumulatorValue = accumulatorValue * 256
		end
	end
	return nil, table.concat(resultBuffer)
end
return Base85
