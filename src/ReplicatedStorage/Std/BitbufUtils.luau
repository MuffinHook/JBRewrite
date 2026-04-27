return {
	writeString = function(buffer, bitLength, str)
		assert(#str <= 2 ^ bitLength, "String too long for length to be written in uint size")
		buffer:WriteUint(bitLength, #str)
		buffer:WriteBytes(str)
	end,
	readString = function(buffer, bitLength)
		return buffer:ReadBytes((buffer:ReadUint(bitLength)))
	end
}
