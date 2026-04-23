return {
	writeString = function(p1, p2, p3) --[[ Name: writeString | Line: 4 ]]
		assert(#p3 <= 2 ^ p2, "String too long for length to be written in uint size")
		p1:WriteUint(p2, #p3)
		p1:WriteBytes(p3)
	end,
	readString = function(p1, p2) --[[ Name: readString | Line: 9 ]]
		return p1:ReadBytes((p1:ReadUint(p2)))
	end
}