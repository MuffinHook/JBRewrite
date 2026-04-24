-- Reviewed by Claude
-- variables reassigned
return {
	writeString = function(p1, p2, p3)
		assert(#p3 <= 2 ^ p2, "String too long for length to be written in uint size")
		p1:WriteUint(p2, #p3)
		p1:WriteBytes(p3)
	end,
	readString = function(p1, p2)
		return p1:ReadBytes((p1:ReadUint(p2)))
	end
}
