local Base64 = require(script.Base64)
local _ = ipairs
local band = bit32.band
local bor = bit32.bor
local bxor = bit32.bxor
local lshift = bit32.lshift
local rshift = bit32.rshift
local lrotate = bit32.lrotate
local rrotate = bit32.rrotate
local sha512Constants = {}
local sha256Constants = {}
local sha512StateInitial = {}
local sha256StateInitial = {}
local sha224StateInitial = {}
local keccakState1 = {}
local keccakState2 = {}
local md5RotationTable = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	28,
	25,
	26,
	27,
	0,
	0,
	10,
	9,
	11,
	12,
	0,
	15,
	16,
	17,
	18,
	0,
	20,
	22,
	23,
	21
}
local messageSchedule = {}
local function sha256_feed_64(stateArray, dataBuffer, dataOffset, blockLength)
	local messageSchedule = messageSchedule
	local sha256Constants = sha256Constants
	local stateWord1 = stateArray[1]
	local stateWord2 = stateArray[2]
	local stateWord3 = stateArray[3]
	local stateWord4 = stateArray[4]
	local stateWord5 = stateArray[5]
	local stateWord6 = stateArray[6]
	local stateWord7 = stateArray[7]
	local stateWord8 = stateArray[8]
	for i = dataOffset, dataOffset + blockLength - 1, 64 do
		local sum = i
		for j = 1, 16 do
			sum = sum + 4
			local byte1, byte2, byte3, byte4 = string.byte(dataBuffer, sum - 3, sum)
			messageSchedule[j] = ((byte1 * 256 + byte2) * 256 + byte3) * 256 + byte4
		end
		for k = 17, 64 do
			local messagePrev15 = messageSchedule[k - 15]
			local messagePrev2 = messageSchedule[k - 2]
			messageSchedule[k] = bxor(rrotate(messagePrev15, 7), lrotate(messagePrev15, 14), (rshift(messagePrev15, 3))) + bxor(lrotate(messagePrev2, 15), lrotate(messagePrev2, 13), (rshift(messagePrev2, 10))) + messageSchedule[k - 7] + messageSchedule[k - 16]
		end
		local workingH, workingG, workingF, workingE, workingD, workingC, workingB, workingA = stateWord4, stateWord3, stateWord2, stateWord5, stateWord6, stateWord7, stateWord8, stateWord1
		for n = 1, 64 do
			local temporaryValue = bxor(rrotate(workingE, 6), rrotate(workingE, 11), (lrotate(workingE, 7))) + band(workingE, workingD) + band(-1 - workingE, workingC) + workingB + sha256Constants[n] + messageSchedule[n]
			workingH, workingG, workingF, workingE, workingD, workingC, workingB, workingA = workingG, workingF, workingA, temporaryValue + workingH, workingE, workingD, workingC, temporaryValue + band(workingG, workingF) + band(workingA, (bxor(workingG, workingF))) + bxor(rrotate(workingA, 2), rrotate(workingA, 13), (lrotate(workingA, 10)))
		end
		stateWord4 = (workingH + stateWord4) % 4294967296
		stateWord5 = (workingE + stateWord5) % 4294967296
		stateWord6 = (workingD + stateWord6) % 4294967296
		stateWord7 = (workingC + stateWord7) % 4294967296
		stateWord8 = (workingB + stateWord8) % 4294967296
		stateWord1 = (workingA + stateWord1) % 4294967296
		stateWord2 = (workingF + stateWord2) % 4294967296
		stateWord3 = (workingG + stateWord3) % 4294967296
	end
	stateArray[1] = stateWord1
	stateArray[2] = stateWord2
	stateArray[3] = stateWord3
	stateArray[4] = stateWord4
	stateArray[5] = stateWord5
	stateArray[6] = stateWord6
	stateArray[7] = stateWord7
	stateArray[8] = stateWord8
end
local function sha512_feed_128(stateLo, stateHi, dataBuffer, dataOffset, dataLength)
	local messageSchedule = messageSchedule
	local sha512Constants = sha512Constants
	local sha256Constants = sha256Constants
	local stateLo1 = stateLo[1]
	local stateHi2 = stateHi[2]
	local stateLo3 = stateLo[3]
	local stateHi4 = stateHi[4]
	local stateLo5 = stateLo[5]
	local stateHi6 = stateHi[6]
	local stateLo7 = stateLo[7]
	local stateHi8 = stateHi[8]
	local stateHi1 = stateLo[1]
	local stateLo2 = stateHi[2]
	local stateHi3 = stateLo[3]
	local stateLo4 = stateHi[4]
	local stateHi5 = stateLo[5]
	local stateLo6 = stateHi[6]
	local stateHi7 = stateLo[7]
	local stateLo8 = stateHi[8]
	for i = dataOffset, dataOffset + dataLength - 1, 128 do
		local sum = i
		for j = 1, 32 do
			sum = sum + 4
			local byte1, byte2, byte3, byte4 = string.byte(dataBuffer, sum - 3, sum)
			messageSchedule[j] = ((byte1 * 256 + byte2) * 256 + byte3) * 256 + byte4
		end
		for k = 34, 160, 2 do
			local messagePrev30 = messageSchedule[k - 30]
			local messagePrev31 = messageSchedule[k - 31]
			local messagePrev4 = messageSchedule[k - 4]
			local messagePrev5 = messageSchedule[k - 5]
			local messageExpandedLo = bxor(rshift(messagePrev30, 1) + lshift(messagePrev31, 31), rshift(messagePrev30, 8) + lshift(messagePrev31, 24), rshift(messagePrev30, 7) + lshift(messagePrev31, 25)) % 4294967296 + bxor(rshift(messagePrev4, 19) + lshift(messagePrev5, 13), lshift(messagePrev4, 3) + rshift(messagePrev5, 29), rshift(messagePrev4, 6) + lshift(messagePrev5, 26)) % 4294967296 + messageSchedule[k - 14] + messageSchedule[k - 32]
			local messageExpandedLoMod = messageExpandedLo % 4294967296
			messageSchedule[k - 1] = bxor(rshift(messagePrev31, 1) + lshift(messagePrev30, 31), rshift(messagePrev31, 8) + lshift(messagePrev30, 24), (rshift(messagePrev31, 7))) + bxor(rshift(messagePrev5, 19) + lshift(messagePrev4, 13), lshift(messagePrev5, 3) + rshift(messagePrev4, 29), (rshift(messagePrev5, 6))) + messageSchedule[k - 15] + messageSchedule[k - 33] + (messageExpandedLo - messageExpandedLoMod) / 4294967296
			messageSchedule[k] = messageExpandedLoMod
		end
		local workingA, workingB, workingC, workingD, workingE, workingF, workingG, workingH, workingAHi, workingBHi, workingCHi, workingDHi, workingEHi, workingFHi, workingGHi, workingHHi = stateHi8, stateLo6, stateHi5, stateHi9, stateHi8, stateLo7, stateLo8, stateHi7, stateLo5, stateHi4, stateLo3, stateHi2, stateLo1, stateHi1, stateLo4, stateLo2
		for n = 1, 80 do
			local roundIndex = n * 2
			local temporaryLo = bxor(rshift(workingB, 14) + lshift(workingC, 18), rshift(workingB, 18) + lshift(workingC, 14), lshift(workingB, 23) + rshift(workingC, 9)) % 4294967296 + (band(workingB, workingD) + band(-1 - workingB, workingF)) % 4294967296 + workingG + sha512Constants[n] + messageSchedule[roundIndex]
			local temporaryLoMod = temporaryLo % 4294967296
			local temporaryHi = bxor(rshift(workingC, 14) + lshift(workingB, 18), rshift(workingC, 18) + lshift(workingB, 14), lshift(workingC, 23) + rshift(workingB, 9)) + band(workingC, workingH) + band(-1 - workingC, workingA) + workingE + sha256Constants[n] + messageSchedule[roundIndex - 1] + (temporaryLo - temporaryLoMod) / 4294967296
			local sumWithCarry = temporaryLoMod + workingI
			local sumWithCarryMod = sumWithCarry % 4294967296
			local secondTemporary = temporaryLoMod + band(workingB, workingD) + band(workingG, (bxor(workingB, workingD))) % 4294967296 + bxor(rshift(workingG, 28) + lshift(workingH, 4), lshift(workingG, 30) + rshift(workingH, 2), lshift(workingG, 25) + rshift(workingH, 7)) % 4294967296
			local secondTemporaryMod = secondTemporary % 4294967296
			workingA, workingB, workingC, workingD, workingE, workingF, workingG, workingH, workingAHi, workingBHi, workingCHi, workingDHi, workingEHi, workingFHi, workingGHi, workingHHi = workingH, sumWithCarryMod, temporaryHi + workingJ + (sumWithCarry - sumWithCarryMod) / 4294967296, workingB, workingA, workingD, workingF, workingC, workingF, workingG, workingH, workingI, workingA, workingDHi, workingFHi, secondTemporaryMod + band(workingDHi, workingEHi) + band(workingHHi, (bxor(workingDHi, workingEHi))) + bxor(rshift(workingHHi, 28) + lshift(workingGHi, 4), lshift(workingHHi, 30) + rshift(workingGHi, 2), lshift(workingHHi, 25) + rshift(workingGHi, 7)) + (secondTemporary - secondTemporaryMod) / 4294967296
		end
		local updateA = stateLo1 + workingGHi
		stateLo1 = updateA % 4294967296
		local updateB = stateHi2 + workingEHi
		stateHi2 = updateB % 4294967296
		local updateC = stateLo3 + workingCHi
		stateLo3 = updateC % 4294967296
		local updateD = stateHi4 + workingAHi
		stateHi4 = updateD % 4294967296
		local updateE = stateLo5 + workingB
		stateLo5 = updateE % 4294967296
		local updateF = stateHi6 + workingD
		stateHi6 = updateF % 4294967296
		local updateG = stateLo7 + workingF
		stateLo7 = updateG % 4294967296
		local updateH = stateHi8 + workingG
		stateHi8 = updateH % 4294967296
		stateHi4 = (stateHi4 + workingJ + (updateD - stateHi4) / 4294967296) % 4294967296
		stateHi5 = (stateHi5 + workingC + (updateE - stateLo5) / 4294967296) % 4294967296
		stateHi6 = (stateHi6 + workingH + (updateF - stateHi6) / 4294967296) % 4294967296
		stateLo1 = (stateLo1 + workingHHi + (updateA - stateLo1) / 4294967296) % 4294967296
		stateLo2 = (stateLo2 + workingFHi + (updateB - stateHi2) / 4294967296) % 4294967296
		stateLo3 = (stateLo3 + workingDHi + (updateC - stateLo3) / 4294967296) % 4294967296
		stateHi8 = (stateHi8 + workingA + (updateG - stateLo7) / 4294967296) % 4294967296
		stateHi1 = (stateHi1 + workingE + (updateH - stateHi8) / 4294967296) % 4294967296
	end
	stateLo[1] = stateLo1
	stateHi[1] = stateHi2
	stateLo[2] = stateLo3
	stateHi[2] = stateHi4
	stateLo[3] = stateLo5
	stateHi[3] = stateHi6
	stateLo[4] = stateLo7
	stateHi[4] = stateHi8
	stateLo[5] = stateLo1
	stateHi[5] = stateLo2
	stateLo[6] = stateLo3
	stateHi[6] = stateHi4
	stateLo[7] = stateLo5
	stateHi[7] = stateHi6
	stateLo[8] = stateLo7
	stateHi[8] = stateHi8
end
local function md5_feed_64(stateArray, dataBuffer, dataOffset, blockLength)
	local messageSchedule = messageSchedule
	local md5Constants = md5Constants
	local md5RotationTable = md5RotationTable
	local stateA = stateArray[1]
	local stateB = stateArray[2]
	local stateC = stateArray[3]
	local stateD = stateArray[4]
	for i = dataOffset, dataOffset + blockLength - 1, 64 do
		local sum = i
		for j = 1, 16 do
			sum = sum + 4
			local byte1, byte2, byte3, byte4 = string.byte(dataBuffer, sum - 3, sum)
			messageSchedule[j] = ((byte4 * 256 + byte3) * 256 + byte2) * 256 + byte1
		end
		local workingA, rotationAmount, workingC, workingD, workingB = stateA, 25, stateB, stateC, stateD
		for k = 1, 16 do
			local roundValue = rrotate(band(workingC, workingD) + band(-1 - workingC, workingB) + workingA + md5Constants[k] + messageSchedule[k], rotationAmount) + workingC
			rotationAmount = md5RotationTable[rotationAmount]
			workingA, workingC, workingD, workingB = workingB, roundValue, workingC, workingD
		end
		local rotationAmount2 = 27
		for n = 17, 32 do
			local roundValue2 = rrotate(band(workingB, workingC) + band(-1 - workingB, workingD) + workingA + md5Constants[n] + messageSchedule[(n * 5 - 4) % 16 + 1], rotationAmount2) + workingC
			rotationAmount2 = md5RotationTable[rotationAmount2]
			workingA, workingB, workingC, workingD = workingB, workingD, roundValue2, workingC
		end
		local rotationAmount3 = 28
		for m = 33, 48 do
			local roundValue3 = rrotate(bxor(bxor(workingC, workingD), workingB) + workingA + md5Constants[m] + messageSchedule[(m * 3 + 2) % 16 + 1], rotationAmount3) + workingC
			rotationAmount3 = md5RotationTable[rotationAmount3]
			workingA, workingC, workingD, workingB = workingB, roundValue3, workingC, workingD
		end
		local rotationAmount4 = 26
		for i2 = 49, 64 do
			local roundValue4 = rrotate(bxor(workingD, (bor(workingC, -1 - workingB))) + workingA + md5Constants[i2] + messageSchedule[(i2 * 7 - 7) % 16 + 1], rotationAmount4) + workingC
			rotationAmount4 = md5RotationTable[rotationAmount4]
			workingD, workingA, workingB, workingC = workingC, workingB, workingD, roundValue4
		end
		stateD = (workingB + stateD) % 4294967296
		stateA = (workingA + stateA) % 4294967296
		stateB = (workingC + stateB) % 4294967296
		stateC = (workingD + stateC) % 4294967296
	end
	stateArray[1] = stateA
	stateArray[2] = stateB
	stateArray[3] = stateC
	stateArray[4] = stateD
end
local function sha1_feed_64(stateArray, dataBuffer, dataOffset, blockLength)
	local messageSchedule = messageSchedule
	local stateE = stateArray[1]
	local stateA = stateArray[2]
	local stateB = stateArray[3]
	local stateC = stateArray[4]
	local stateD = stateArray[5]
	for i = dataOffset, dataOffset + blockLength - 1, 64 do
		local sum = i
		for j = 1, 16 do
			sum = sum + 4
			local byte1, byte2, byte3, byte4 = string.byte(dataBuffer, sum - 3, sum)
			messageSchedule[j] = ((byte1 * 256 + byte2) * 256 + byte3) * 256 + byte4
		end
		for k = 17, 80 do
			messageSchedule[k] = lrotate(bxor(messageSchedule[k - 3], messageSchedule[k - 8], messageSchedule[k - 14], messageSchedule[k - 16]), 1)
		end
		local workingD, workingE, stateALocal, stateB, stateC = stateD, stateE, stateA, stateB, stateC
		for n = 1, 20 do
			local roundValue = lrotate(stateE, 5) + band(stateALocal, stateB) + band(-1 - stateALocal, stateC) + 1518500249 + messageSchedule[n] + workingD
			workingD, stateE, stateALocal, stateB, stateC = stateC, roundValue, stateE, rrotate(stateALocal, 2), stateB
		end
		for m = 21, 40 do
			local roundValue2 = lrotate(stateE, 5) + bxor(stateALocal, stateB, stateC) + 1859775393 + messageSchedule[m] + workingD
			workingD, stateE, stateALocal, stateB, stateC = stateC, roundValue2, stateE, rrotate(stateALocal, 2), stateB
		end
		for i2 = 41, 60 do
			local roundValue3 = lrotate(stateE, 5) + band(stateC, stateB) + band(stateALocal, (bxor(stateC, stateB))) + 2400959708 + messageSchedule[i2] + workingD
			workingD, stateE, stateC, stateB, stateALocal = stateC, roundValue3, stateB, rrotate(stateALocal, 2), stateE
		end
		for i2 = 61, 80 do
			local roundValue4 = lrotate(stateE, 5) + bxor(stateALocal, stateB, stateC) + 3395469782 + messageSchedule[i2] + workingD
			workingD, stateE, stateALocal, stateB, stateC = stateC, roundValue4, stateE, rrotate(stateALocal, 2), stateB
		end
		stateC = (stateC + stateC) % 4294967296
		stateD = (workingD + stateD) % 4294967296
		stateA = (stateE + stateA) % 4294967296
		stateB = (stateALocal + stateB) % 4294967296
		stateD = (stateB + stateD) % 4294967296
	end
	stateArray[1] = stateE
	stateArray[2] = stateA
	stateArray[3] = stateB
	stateArray[4] = stateC
	stateArray[5] = stateD
end
local function keccak_feed(stateLo, stateHi, dataBuffer, dataOffset, dataLength, blockLength)
	local keccakState1 = keccakState1
	local keccakState2 = keccakState2
	local stateCount = blockLength / 8
	for i = dataOffset, dataOffset + dataLength - 1, blockLength do
		local sum = i
		for j = 1, stateCount do
			local byte1, byte2, byte3, byte4 = string.byte(dataBuffer, sum + 1, sum + 4)
			stateLo[j] = bxor(stateLo[j], ((byte4 * 256 + byte3) * 256 + byte2) * 256 + byte1)
			sum = sum + 8
			local byte5, byte6, byte7, byte8 = string.byte(dataBuffer, sum - 3, sum)
			stateHi[j] = bxor(stateHi[j], ((byte8 * 256 + byte7) * 256 + byte6) * 256 + byte5)
		end
		local laneA1Lo = stateLo[1]
		local laneA1Hi = stateHi[1]
		local laneA2Lo = stateLo[2]
		local laneA2Hi = stateHi[2]
		local laneA3Lo = stateLo[3]
		local laneA3Hi = stateHi[3]
		local laneA4Lo = stateLo[4]
		local laneA4Hi = stateHi[4]
		local laneA5Lo = stateLo[5]
		local laneA5Hi = stateHi[5]
		local laneA6Lo = stateLo[6]
		local laneA6Hi = stateHi[6]
		local laneA7Lo = stateLo[7]
		local laneA7Hi = stateHi[7]
		local laneA8Lo = stateLo[8]
		local laneA8Hi = stateHi[8]
		local laneA9Lo = stateLo[9]
		local laneA9Hi = stateHi[9]
		local laneA10Lo = stateLo[10]
		local laneA10Hi = stateHi[10]
		local laneA11Lo = stateLo[11]
		local laneA11Hi = stateHi[11]
		local laneA12Lo = stateLo[12]
		local laneA12Hi = stateHi[12]
		local laneA13Lo = stateLo[13]
		local laneA13Hi = stateHi[13]
		local laneA14Lo = stateLo[14]
		local laneA14Hi = stateHi[14]
		local laneA15Lo = stateLo[15]
		local laneA15Hi = stateHi[15]
		local laneA16Lo = stateLo[16]
		local laneA16Hi = stateHi[16]
		local laneA17Lo = stateLo[17]
		local laneA17Hi = stateHi[17]
		local laneA18Lo = stateLo[18]
		local laneA18Hi = stateHi[18]
		local laneA19Lo = stateLo[19]
		local laneA19Hi = stateHi[19]
		local laneA20Lo = stateLo[20]
		local laneA20Hi = stateHi[20]
		local laneA21Lo = stateLo[21]
		local laneA21Hi = stateHi[21]
		local laneA22Lo = stateLo[22]
		local laneA22Hi = stateHi[22]
		local laneA23Lo = stateLo[23]
		local laneA23Hi = stateHi[23]
		local laneA24Lo = stateLo[24]
		local laneA24Hi = stateHi[24]
		local laneA25Lo = stateLo[25]
		local laneA25Hi = stateHi[25]
		for k = 1, 24 do
			local parityX1 = bxor(laneA1Lo, laneA6Lo, laneA11Lo, laneA16Lo, laneA21Lo)
			local parityX1Hi = bxor(laneA1Hi, laneA6Hi, laneA11Hi, laneA16Hi, laneA21Hi)
			local parityX2 = bxor(laneA2Lo, laneA7Lo, laneA12Lo, laneA17Lo, laneA22Lo)
			local parityX2Hi = bxor(laneA2Hi, laneA7Hi, laneA12Hi, laneA17Hi, laneA22Hi)
			local parityX3 = bxor(laneA3Lo, laneA8Lo, laneA13Lo, laneA18Lo, laneA23Lo)
			local parityX3Hi = bxor(laneA3Hi, laneA8Hi, laneA13Hi, laneA18Hi, laneA23Hi)
			local parityX4 = bxor(laneA4Lo, laneA9Lo, laneA14Lo, laneA19Lo, laneA24Lo)
			local parityX4Hi = bxor(laneA4Hi, laneA9Hi, laneA14Hi, laneA19Hi, laneA24Hi)
			local parityX5 = bxor(laneA5Lo, laneA10Lo, laneA15Lo, laneA20Lo, laneA25Lo)
			local parityX5Hi = bxor(laneA5Hi, laneA10Hi, laneA15Hi, laneA20Hi, laneA25Hi)
			local deltaX1 = bxor(parityX1, parityX3 * 2 + (parityX4 % 4294967296 - parityX4 % 2147483648) / 2147483648)
			local deltaX1Hi = bxor(parityX1Hi, parityX4 * 2 + (parityX3 % 4294967296 - parityX3 % 2147483648) / 2147483648)
			local deltaX2 = bxor(deltaX1, laneA2Lo)
			local deltaX2Hi = bxor(deltaX1Hi, laneA2Hi)
			local deltaX3 = bxor(deltaX1, laneA7Lo)
			local deltaX3Hi = bxor(deltaX1Hi, laneA7Hi)
			local deltaX4 = bxor(deltaX1, laneA12Lo)
			local deltaX4Hi = bxor(deltaX1Hi, laneA12Hi)
			local deltaX5 = bxor(deltaX1, laneA17Lo)
			local deltaX5Hi = bxor(deltaX1Hi, laneA17Hi)
			local deltaX6 = bxor(deltaX1, laneA22Lo)
			local deltaX6Hi = bxor(deltaX1Hi, laneA22Hi)
			local rotateA = (deltaX3 % 4294967296 - deltaX3 % 1048576) / 1048576 + deltaX3Hi * 4096
			local rotatAHi = (deltaX3Hi % 4294967296 - deltaX3Hi % 1048576) / 1048576 + deltaX3 * 4096
			local rotateB = (deltaX4 % 4294967296 - deltaX4 % 524288) / 524288 + deltaX4Hi * 8192
			local rotateBHi = (deltaX4Hi % 4294967296 - deltaX4Hi % 524288) / 524288 + deltaX4 * 8192
			local rotateC = deltaX2 * 2 + (deltaX2Hi % 4294967296 - deltaX2Hi % 2147483648) / 2147483648
			local rotateCHi = deltaX2Hi * 2 + (deltaX2 % 4294967296 - deltaX2 % 2147483648) / 2147483648
			local rotateD = deltaX5 * 1024 + (deltaX5Hi % 4294967296 - deltaX5Hi % 4194304) / 4194304
			local rotateDHi = deltaX5Hi * 1024 + (deltaX5 % 4294967296 - deltaX5 % 4194304) / 4194304
			local rotateE = deltaX6 * 4 + (deltaX6Hi % 4294967296 - deltaX6Hi % 1073741824) / 1073741824
			local rotateEHi = deltaX6Hi * 4 + (deltaX6 % 4294967296 - deltaX6 % 1073741824) / 1073741824
			local deltaY1 = bxor(parityX3, parityX5 * 2 + (parityX1 % 4294967296 - parityX1 % 2147483648) / 2147483648)
			local deltaY1Hi = bxor(parityX3Hi, parityX1 * 2 + (parityX5 % 4294967296 - parityX5 % 2147483648) / 2147483648)
			local deltaY2 = bxor(deltaY1, laneA3Lo)
			local deltaY2Hi = bxor(deltaY1Hi, laneA3Hi)
			local deltaY3 = bxor(deltaY1, laneA8Lo)
			local deltaY3Hi = bxor(deltaY1Hi, laneA8Hi)
			local deltaY4 = bxor(deltaY1, laneA13Lo)
			local deltaY4Hi = bxor(deltaY1Hi, laneA13Hi)
			local deltaY5 = bxor(deltaY1, laneA18Lo)
			local deltaY5Hi = bxor(deltaY1Hi, laneA18Hi)
			local deltaY6 = bxor(deltaY1, laneA23Lo)
			local deltaY6Hi = bxor(deltaY1Hi, laneA23Hi)
			local rotateF = (deltaY4 % 4294967296 - deltaY4 % 2097152) / 2097152 + deltaY4Hi * 2048
			local rotatFHi = (deltaY4Hi % 4294967296 - deltaY4Hi % 2097152) / 2097152 + deltaY4 * 2048
			local rotateG = (deltaY6 % 4294967296 - deltaY6 % 8) / 8 + deltaY5Hi * 536870912 % 4294967296
			local rotateGHi = (deltaY5Hi % 4294967296 - deltaY5Hi % 8) / 8 + deltaY6 * 536870912 % 4294967296
			local rotateH = deltaY3 * 64 + (deltaY3Hi % 4294967296 - deltaY3Hi % 67108864) / 67108864
			local rotateHHi = deltaY3Hi * 64 + (deltaY3 % 4294967296 - deltaY3 % 67108864) / 67108864
			local rotateI = deltaY5 * 32768 + (deltaY5Hi % 4294967296 - deltaY5Hi % 131072) / 131072
			local rotateIHi = deltaY5Hi * 32768 + (deltaY5 % 4294967296 - deltaY5 % 131072) / 131072
			local rotateJ = (deltaY2 % 4294967296 - deltaY2 % 4) / 4 + deltaY2Hi * 1073741824 % 4294967296
			local rotateJHi = (deltaY2Hi % 4294967296 - deltaY2Hi % 4) / 4 + deltaY2 * 1073741824 % 4294967296
			local deltaZ1 = bxor(parityX5, parityX2 * 2 + (parityX1 % 4294967296 - parityX1 % 2147483648) / 2147483648)
			local deltaZ1Hi = bxor(parityX5Hi, parityX1 * 2 + (parityX2 % 4294967296 - parityX2 % 2147483648) / 2147483648)
			local deltaZ2 = bxor(deltaZ1, laneA4Lo)
			local deltaZ2Hi = bxor(deltaZ1Hi, laneA4Hi)
			local deltaZ3 = bxor(deltaZ1, laneA9Lo)
			local deltaZ3Hi = bxor(deltaZ1Hi, laneA9Hi)
			local deltaZ4 = bxor(deltaZ1, laneA14Lo)
			local deltaZ4Hi = bxor(deltaZ1Hi, laneA14Hi)
			local deltaZ5 = bxor(deltaZ1, laneA19Lo)
			local deltaZ5Hi = bxor(deltaZ1Hi, laneA19Hi)
			local deltaZ6 = bxor(deltaZ1, laneA24Lo)
			local deltaZ6Hi = bxor(deltaZ1Hi, laneA24Hi)
			local rotateK = deltaZ4 * 2097152 % 4294967296 + (deltaZ5Hi % 4294967296 - deltaZ5Hi % 2048) / 2048
			local rotateKHi = deltaZ5Hi * 2097152 % 4294967296 + (deltaZ4 % 4294967296 - deltaZ4 % 2048) / 2048
			local rotateL = deltaZ2 * 268435456 % 4294967296 + (deltaZ2Hi % 4294967296 - deltaZ2Hi % 16) / 16
			local rotateLHi = deltaZ2Hi * 268435456 % 4294967296 + (deltaZ2 % 4294967296 - deltaZ2 % 16) / 16
			local rotateM = deltaZ4 * 33554432 % 4294967296 + (deltaZ4Hi % 4294967296 - deltaZ4Hi % 128) / 128
			local rotateMHi = deltaZ4Hi * 33554432 % 4294967296 + (deltaZ4 % 4294967296 - deltaZ4 % 128) / 128
			local rotateN = (deltaZ6 % 4294967296 - deltaZ6 % 256) / 256 + deltaZ6Hi * 16777216 % 4294967296
			local rotateNHi = (deltaZ6Hi % 4294967296 - deltaZ6Hi % 256) / 256 + deltaZ6 * 16777216 % 4294967296
			local rotateO = (deltaZ3 % 4294967296 - deltaZ3 % 512) / 512 + deltaZ3Hi * 8388608 % 4294967296
			local rotateOHi = (deltaZ3Hi % 4294967296 - deltaZ3Hi % 512) / 512 + deltaZ3 * 8388608 % 4294967296
			local chiOutput1 = bxor(deltaY3, parityX1 * 2 + (parityX1Hi % 4294967296 - parityX1Hi % 2147483648) / 2147483648)
			local chiOutput1Hi = bxor(deltaY3Hi, parityX1Hi * 2 + (parityX1 % 4294967296 - parityX1 % 2147483648) / 2147483648)
			local chiOutput2 = bxor(deltaY4, parityX2 * 2 + (parityX2Hi % 4294967296 - parityX2Hi % 2147483648) / 2147483648)
			local chiOutput2Hi = bxor(deltaY4Hi, parityX2Hi * 2 + (parityX2 % 4294967296 - parityX2 % 2147483648) / 2147483648)
			local chiResult1 = bxor(chiOutput1, (band(-1 - rotateA, rotateF)))
			local chiResult1Hi = bxor(deltaY2Hi, (band(-1 - rotatAHi, rotatFHi)))
			local chiResult2 = bxor(rotateA, (band(-1 - rotateF, rotateK)))
			local chiResult2Hi = bxor(rotatAHi, (band(-1 - rotatFHi, rotateKHi)))
			local chiResult3 = bxor(rotateF, (band(-1 - rotateK, rotateN)))
			local chiResult3Hi = bxor(rotatFHi, (band(-1 - rotateKHi, rotateNHi)))
			local chiResult4 = bxor(rotateK, (band(-1 - rotateN, chiOutput1)))
			local chiResult4Hi = bxor(rotateKHi, (band(-1 - rotateNHi, chiOutput1Hi)))
			local chiResult5 = bxor(rotateN, (band(-1 - chiOutput1, rotateA)))
			local chiResult5Hi = bxor(rotateNHi, (band(-1 - chiOutput1Hi, rotatAHi)))
			local chiResult6 = bxor(rotateL, (band(-1 - rotatM, rotateO)))
			local chiResult6Hi = bxor(rotateLHi, (band(-1 - rotateMHi, rotateOHi)))
			local chiResult7 = bxor(rotatM, (band(-1 - rotateO, rotateB)))
			local chiResult7Hi = bxor(rotateMHi, (band(-1 - rotateOHi, rotateBHi)))
			local chiResult8 = bxor(rotateO, (band(-1 - rotateB, rotateG)))
			local chiResult8Hi = bxor(rotateOHi, (band(-1 - rotateBHi, rotateGHi)))
			local chiResult9 = bxor(rotateB, (band(-1 - rotateG, rotateL)))
			local chiResult9Hi = bxor(rotateBHi, (band(-1 - rotateGHi, rotateLHi)))
			local chiResult10 = bxor(rotateG, (band(-1 - rotateL, rotatM)))
			local chiResult10Hi = bxor(rotateGHi, (band(-1 - rotateLHi, rotateMHi)))
			local chiResult11 = bxor(rotateJ, (band(-1 - rotateH, rotateM)))
			local chiResult11Hi = bxor(rotateJHi, (band(-1 - rotateHHi, rotateMHi)))
			local chiResult12 = bxor(rotateH, (band(-1 - rotateM, rotateI)))
			local chiResult12Hi = bxor(rotateHHi, (band(-1 - rotateMHi, rotateIHi)))
			local chiResult13 = bxor(rotateM, (band(-1 - rotateI, rotateC)))
			local chiResult13Hi = bxor(rotateMHi, (band(-1 - rotateIHi, rotateCHi)))
			local chiResult14 = bxor(rotateI, (band(-1 - rotateC, rotateJ)))
			local chiResult14Hi = bxor(rotateIHi, (band(-1 - rotateCHi, rotateJHi)))
			local chiResult15 = bxor(rotateC, (band(-1 - rotateJ, rotateH)))
			local chiResult15Hi = bxor(rotateCHi, (band(-1 - rotateJHi, rotateHHi)))
			local chiResult16 = bxor(rotateD, (band(-1 - rotateO, rotateL)))
			local chiResult16Hi = bxor(rotateDHi, (band(-1 - rotateOHi, rotateLHi)))
			local chiResult17 = bxor(rotateO, (band(-1 - rotateL, rotateE)))
			local chiResult17Hi = bxor(rotateOHi, (band(-1 - rotateLHi, rotateEHi)))
			local chiResult18 = bxor(rotateL, (band(-1 - rotateE, rotateD)))
			local chiResult18Hi = bxor(rotateLHi, (band(-1 - rotateEHi, rotateDHi)))
			local chiResult19 = bxor(rotateE, (band(-1 - rotateD, rotateO)))
			local chiResult19Hi = bxor(rotateEHi, (band(-1 - rotateDHi, rotateOHi)))
			local chiResult20 = bxor(rotateD, (band(-1 - rotateO, rotateL)))
			local chiResult20Hi = bxor(rotateDHi, (band(-1 - rotateOHi, rotateLHi)))
			local iota1 = bxor(chiResult2, keccakState1[k])
			laneA1Hi = chiResult6 + keccakState2[k]
			laneA5Hi, laneA13Lo, laneA15Lo, laneA22Lo, laneA14Hi, laneA16Hi, laneA17Hi, laneA18Hi, laneA19Hi, laneA20Hi, laneA7Lo, laneA8Lo, laneA9Lo, laneA10Lo, laneA2Hi, laneA3Hi, laneA4Lo, laneA6Lo, laneA6Hi, laneA11Hi, laneA12Hi, laneA24Hi, laneA2Lo, laneA9Hi, laneA1Lo, laneA8Hi, laneA11Lo, laneA10Hi, laneA5Lo, laneA12Lo, laneA21Lo, laneA25Hi, laneA13Hi, laneA23Hi, laneA21Hi, laneA25Lo, laneA20Hi = chiResult7, chiResult12, chiResult11, chiResult13, chiResult17, chiResult20, chiResult12, chiResult14, chiResult18, chiResult16, chiResult10, chiResult15, chiResult19, chiResult13, chiResult9, chiResult11, chiResult8, chiResult16, chiResult18, chiResult10, chiResult12, chiResult15, chiResult3, chiResult6, iota1, chiResult9, chiResult4, chiResult19, chiResult2, chiResult5, chiResult20, chiResult14, chiResult17, chiResult21, chiResult8, chiResult21, chiResult19
		end
		stateLo[1] = laneA1Lo
		stateHi[1] = laneA1Hi
		stateLo[2] = laneA2Lo
		stateHi[2] = laneA2Hi
		stateLo[3] = laneA3Lo
		stateHi[3] = laneA3Hi
		stateLo[4] = laneA4Lo
		stateHi[4] = laneA4Hi
		stateLo[5] = laneA5Lo
		stateHi[5] = laneA5Hi
		stateLo[6] = laneA6Lo
		stateHi[6] = laneA6Hi
		stateLo[7] = laneA7Lo
		stateHi[7] = laneA7Hi
		stateLo[8] = laneA8Lo
		stateHi[8] = laneA8Hi
		stateLo[9] = laneA9Lo
		stateHi[9] = laneA9Hi
		stateLo[10] = laneA10Lo
		stateHi[10] = laneA10Hi
		stateLo[11] = laneA11Lo
		stateHi[11] = laneA11Hi
		stateLo[12] = laneA12Lo
		stateHi[12] = laneA12Hi
		stateLo[13] = laneA13Lo
		stateHi[13] = laneA13Hi
		stateLo[14] = laneA14Lo
		stateHi[14] = laneA14Hi
		stateLo[15] = laneA15Lo
		stateHi[15] = laneA15Hi
		stateLo[16] = laneA16Lo
		stateHi[16] = laneA16Hi
		stateLo[17] = laneA17Lo
		stateHi[17] = laneA17Hi
		stateLo[18] = laneA18Lo
		stateHi[18] = laneA18Hi
		stateLo[19] = laneA19Lo
		stateHi[19] = laneA19Hi
		stateLo[20] = laneA20Lo
		stateHi[20] = laneA20Hi
		stateLo[21] = laneA21Lo
		stateHi[21] = laneA21Hi
		stateLo[22] = laneA22Lo
		stateHi[22] = laneA22Hi
		stateLo[23] = laneA23Lo
		stateHi[23] = laneA23Hi
		stateLo[24] = laneA24Lo
		stateHi[24] = laneA24Hi
		stateLo[25] = laneA25Lo
		stateHi[25] = laneA25Hi
	end
end
local function mul(multiplicand1, multiplicand2, multiplier, resultSize)
	local carryLo, sum, sum2, resultArray = 1, 0, 0, table.create(resultSize)
	for i = 1, resultSize do
		for j = math.max(1, i + 1 - #multiplicand2), math.min(i, #multiplicand1) do
			sum2 = sum2 + multiplier * multiplicand1[j] * multiplicand2[i + 1 - j]
		end
		local carryMod = sum2 % 16777216
		resultArray[i] = math.floor(carryMod)
		carryLo = carryLo * 16777216
		sum = sum + carryMod * carryLo
		sum2 = (sum2 - carryMod) / 16777216
	end
	return resultArray, sum
end
local sum, primes, sha512StateInitial, sha256StateInitial, sha224StateInitial, md5StateInitial, md5Constants, roundBases, count, sha256Constants = 4, { 4, 1, 2, -2, 2 }, {
	[384] = {},
	[512] = sha256StateInitial
}, {
	[384] = {},
	[512] = sha512StateInitial
}, {
	[224] = {},
	[256] = sha256StateInitial
}, { 1732584193, 4023233417, 2562383102, 271733878, 3285377520 }, sha512StateInitial, { 1 }, 0, sha256StateInitial
sum = sum + primes[sum % 6]
local primeCandidate = 1
repeat
	primeCandidate = primeCandidate + primes[primeCandidate % 6]
	if sum < primeCandidate * primeCandidate then
		local cubeRoot = sum ^ 1/3
		local cubeRootScaled = mul(table.create(1, (math.floor(cubeRoot * 1099511627776))), roundBases, 1, 2)
		local _, cubedValue = mul(cubeRootScaled, mul(cubeRootScaled, cubeRootScaled, 1, 4), -1, 4)
		local sha256InitialLo = cubeRootScaled[2] % 65536 * 65536 + math.floor(cubeRootScaled[1] / 256)
		local sha256InitialHi = cubeRootScaled[1] % 256 * 16777216 + math.floor(cubedValue * 4.625929269271485e-18 * cubeRoot / sum)
		if count < 16 then
			local sqrtVal = math.sqrt(sum)
			local sqrtValScaled = mul(table.create(1, (math.floor(sqrtVal * 1099511627776))), roundBases, 1, 2)
			local _, sqrtCubedValue = mul(sqrtValScaled, sqrtValScaled, -1, 2)
			local sha512InitialLo = sqrtValScaled[2] % 65536 * 65536 + math.floor(sqrtValScaled[1] / 256)
			local sha512InitialHi = sqrtValScaled[1] % 256 * 16777216 + math.floor(sqrtCubedValue * 7.62939453125e-6 / sqrtVal)
			local roundIndex = count % 8 + 1
			sha224StateInitial[224][roundIndex] = sha512InitialHi
			sha256Constants[roundIndex] = sha512InitialLo
			md5Constants[roundIndex] = sha512InitialHi + sha512InitialLo * 0
			if roundIndex > 7 then
				sha256Constants = sha512StateInitial[384]
				md5Constants = sha256StateInitial[384]
			end
		end
		count = count + 1
		sha256Constants[count] = sha256InitialLo
		sha512StateInitial[count] = sha256InitialHi % 4294967296 + sha256InitialLo * 0
	end
until sum % primeCandidate == 0
