-- Reviewed by Claude
local Base64 = require(script.Base64)
local _ = ipairs
local band = bit32.band
local bor = bit32.bor
local bxor = bit32.bxor
local lshift = bit32.lshift
local rshift = bit32.rshift
local lrotate = bit32.lrotate
local rrotate = bit32.rrotate
local t = {}
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}
local t6 = {}
local t7 = {}
local t8 = {
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
local t9 = {}
local function sha256_feed_64(p1, p2, p3, p4)
	local v1 = t9
	local v2 = t2
	local v3 = p1[1]
	local v4 = p1[2]
	local v5 = p1[3]
	local v6 = p1[4]
	local v7 = p1[5]
	local v8 = p1[6]
	local v9 = p1[7]
	local v10 = p1[8]
	for i = p3, p3 + p4 - 1, 64 do
		local sum = i
		for j = 1, 16 do
			sum = sum + 4
			local v11, v12, v13, v14 = string.byte(p2, sum - 3, sum)
			v1[j] = ((v11 * 256 + v12) * 256 + v13) * 256 + v14
		end
		for k = 17, 64 do
			local v15 = v1[k - 15]
			local v16 = v1[k - 2]
			v1[k] = bxor(rrotate(v15, 7), lrotate(v15, 14), (rshift(v15, 3))) + bxor(lrotate(v16, 15), lrotate(v16, 13), (rshift(v16, 10))) + v1[k - 7] + v1[k - 16]
		end
		local v17, v18, v19, v20, v21, v22, v23, v24 = v6, v5, v4, v7, v8, v9, v10, v3
		for n = 1, 64 do
			local v25 = bxor(rrotate(v20, 6), rrotate(v20, 11), (lrotate(v20, 7))) + band(v20, v21) + band(-1 - v20, v22) + v23 + v2[n] + v1[n]
			v17, v18, v19, v20, v21, v22, v23, v24 = v18, v19, v24, v25 + v17, v20, v21, v22, v25 + band(v18, v19) + band(v24, (bxor(v18, v19))) + bxor(rrotate(v24, 2), rrotate(v24, 13), (lrotate(v24, 10)))
		end
		v6 = (v17 + v6) % 4294967296
		v7 = (v20 + v7) % 4294967296
		v8 = (v21 + v8) % 4294967296
		v9 = (v22 + v9) % 4294967296
		v10 = (v23 + v10) % 4294967296
		v3 = (v24 + v3) % 4294967296
		v4 = (v19 + v4) % 4294967296
		v5 = (v18 + v5) % 4294967296
	end
	p1[1] = v3
	p1[2] = v4
	p1[3] = v5
	p1[4] = v6
	p1[5] = v7
	p1[6] = v8
	p1[7] = v9
	p1[8] = v10
end
local function sha512_feed_128(p1, p2, p3, p4, p5)
	local v1 = t9
	local v2 = t
	local v3 = t2
	local v4 = p1[1]
	local v5 = p1[2]
	local v6 = p1[3]
	local v7 = p1[4]
	local v8 = p1[5]
	local v9 = p1[6]
	local v10 = p1[7]
	local v11 = p1[8]
	local v12 = p2[1]
	local v13 = p2[2]
	local v14 = p2[3]
	local v15 = p2[4]
	local v16 = p2[5]
	local v17 = p2[6]
	local v18 = p2[7]
	local v19 = p2[8]
	for i = p4, p4 + p5 - 1, 128 do
		local sum = i
		for j = 1, 32 do
			sum = sum + 4
			local v20, v21, v22, v23 = string.byte(p3, sum - 3, sum)
			v1[j] = ((v20 * 256 + v21) * 256 + v22) * 256 + v23
		end
		for k = 34, 160, 2 do
			local v24 = v1[k - 30]
			local v25 = v1[k - 31]
			local v26 = v1[k - 4]
			local v27 = v1[k - 5]
			local v28 = bxor(rshift(v24, 1) + lshift(v25, 31), rshift(v24, 8) + lshift(v25, 24), rshift(v24, 7) + lshift(v25, 25)) % 4294967296 + bxor(rshift(v26, 19) + lshift(v27, 13), lshift(v26, 3) + rshift(v27, 29), rshift(v26, 6) + lshift(v27, 26)) % 4294967296 + v1[k - 14] + v1[k - 32]
			local v29 = v28 % 4294967296
			v1[k - 1] = bxor(rshift(v25, 1) + lshift(v24, 31), rshift(v25, 8) + lshift(v24, 24), (rshift(v25, 7))) + bxor(rshift(v27, 19) + lshift(v26, 13), lshift(v27, 3) + rshift(v26, 29), (rshift(v27, 6))) + v1[k - 15] + v1[k - 33] + (v28 - v29) / 4294967296
			v1[k] = v29
		end
		local v30, v31, v32, v33, v34, v35, v36, v37, v38, v39, v40, v41, v42, v43, v44, v45 = v18, v8, v16, v9, v19, v10, v11, v17, v7, v15, v6, v14, v5, v13, v4, v12
		for n = 1, 80 do
			local v46 = n * 2
			local v47 = bxor(rshift(v31, 14) + lshift(v32, 18), rshift(v31, 18) + lshift(v32, 14), lshift(v31, 23) + rshift(v32, 9)) % 4294967296 + (band(v31, v33) + band(-1 - v31, v35)) % 4294967296 + v36 + v2[n] + v1[v46]
			local v48 = v47 % 4294967296
			local v49 = bxor(rshift(v32, 14) + lshift(v31, 18), rshift(v32, 18) + lshift(v31, 14), lshift(v32, 23) + rshift(v31, 9)) + band(v32, v37) + band(-1 - v32, v30) + v34 + v3[n] + v1[v46 - 1] + (v47 - v48) / 4294967296
			local v50 = v48 + v38
			local v51 = v50 % 4294967296
			local v52 = v48 + (band(v40, v42) + band(v44, (bxor(v40, v42)))) % 4294967296 + bxor(rshift(v44, 28) + lshift(v45, 4), lshift(v44, 30) + rshift(v45, 2), lshift(v44, 25) + rshift(v45, 7)) % 4294967296
			local v53 = v52 % 4294967296
			v30, v31, v32, v33, v34, v35, v36, v37, v38, v39, v40, v41, v42, v43, v44, v45 = v37, v51, v49 + v39 + (v50 - v51) / 4294967296, v31, v30, v33, v35, v32, v40, v41, v42, v43, v44, v45, v53, v49 + (band(v41, v43) + band(v45, (bxor(v41, v43)))) + bxor(rshift(v45, 28) + lshift(v44, 4), lshift(v45, 30) + rshift(v44, 2), lshift(v45, 25) + rshift(v44, 7)) + (v52 - v53) / 4294967296
		end
		local v55 = v4 + v44
		v4 = v55 % 4294967296
		local v56 = v5 + v42
		v5 = v56 % 4294967296
		local v57 = v6 + v40
		v6 = v57 % 4294967296
		local v58 = v7 + v38
		v7 = v58 % 4294967296
		local v59 = v8 + v31
		v8 = v59 % 4294967296
		local v60 = v9 + v33
		v9 = v60 % 4294967296
		local v61 = v10 + v35
		v10 = v61 % 4294967296
		local v62 = v11 + v36
		v11 = v62 % 4294967296
		v15 = (v15 + v39 + (v58 - v7) / 4294967296) % 4294967296
		v16 = (v16 + v32 + (v59 - v8) / 4294967296) % 4294967296
		v17 = (v17 + v37 + (v60 - v9) / 4294967296) % 4294967296
		v12 = (v12 + v45 + (v55 - v4) / 4294967296) % 4294967296
		v13 = (v13 + v43 + (v56 - v5) / 4294967296) % 4294967296
		v14 = (v14 + v41 + (v57 - v6) / 4294967296) % 4294967296
		v18 = (v18 + v30 + (v61 - v10) / 4294967296) % 4294967296
		v19 = (v19 + v34 + (v62 - v11) / 4294967296) % 4294967296
	end
	p1[1] = v4
	p1[2] = v5
	p1[3] = v6
	p1[4] = v7
	p1[5] = v8
	p1[6] = v9
	p1[7] = v10
	p1[8] = v11
	p2[1] = v12
	p2[2] = v13
	p2[3] = v14
	p2[4] = v15
	p2[5] = v16
	p2[6] = v17
	p2[7] = v18
	p2[8] = v19
end
local function md5_feed_64(p1, p2, p3, p4)
	local v1 = t9
	local v2 = t7
	local v3 = t8
	local v4 = p1[1]
	local v5 = p1[2]
	local v6 = p1[3]
	local v7 = p1[4]
	for i = p3, p3 + p4 - 1, 64 do
		local sum = i
		for j = 1, 16 do
			sum = sum + 4
			local v8, v9, v10, v11 = string.byte(p2, sum - 3, sum)
			v1[j] = ((v11 * 256 + v10) * 256 + v9) * 256 + v8
		end
		local v12, v13, v14, v15, v16 = v4, 25, v5, v6, v7
		for k = 1, 16 do
			local v17 = rrotate(band(v14, v15) + band(-1 - v14, v16) + v12 + v2[k] + v1[k], v13) + v14
			v13 = v3[v13]
			v12, v14, v15, v16 = v16, v17, v14, v15
		end
		local v18 = 27
		for n = 17, 32 do
			local v19 = rrotate(band(v16, v14) + band(-1 - v16, v15) + v12 + v2[n] + v1[(n * 5 - 4) % 16 + 1], v18) + v14
			v18 = v3[v18]
			v12, v16, v14, v15 = v16, v15, v19, v14
		end
		local v20 = 28
		for m = 33, 48 do
			local v21 = rrotate(bxor(bxor(v14, v15), v16) + v12 + v2[m] + v1[(m * 3 + 2) % 16 + 1], v20) + v14
			v20 = v3[v20]
			v12, v14, v15, v16 = v16, v21, v14, v15
		end
		local v22 = 26
		for i2 = 49, 64 do
			local v23 = rrotate(bxor(v15, (bor(v14, -1 - v16))) + v12 + v2[i2] + v1[(i2 * 7 - 7) % 16 + 1], v22) + v14
			v22 = v3[v22]
			v15, v12, v16, v14 = v14, v16, v15, v23
		end
		v7 = (v16 + v7) % 4294967296
		v4 = (v12 + v4) % 4294967296
		v5 = (v14 + v5) % 4294967296
		v6 = (v15 + v6) % 4294967296
	end
	p1[1] = v4
	p1[2] = v5
	p1[3] = v6
	p1[4] = v7
end
local function sha1_feed_64(p1, p2, p3, p4)
	local v1 = t9
	local v2 = p1[1]
	local v3 = p1[2]
	local v4 = p1[3]
	local v5 = p1[4]
	local v6 = p1[5]
	for i = p3, p3 + p4 - 1, 64 do
		local sum = i
		for j = 1, 16 do
			sum = sum + 4
			local v7, v8, v9, v10 = string.byte(p2, sum - 3, sum)
			v1[j] = ((v7 * 256 + v8) * 256 + v9) * 256 + v10
		end
		for k = 17, 80 do
			v1[k] = lrotate(bxor(v1[k - 3], v1[k - 8], v1[k - 14], v1[k - 16]), 1)
		end
		local v11, v12, v13, v14, v15 = v6, v2, v3, v4, v5
		for n = 1, 20 do
			local v16 = lrotate(v12, 5) + band(v13, v14) + band(-1 - v13, v15) + 1518500249 + v1[n] + v11
			v11, v12, v13, v14, v15 = v15, v16, v12, rrotate(v13, 2), v14
		end
		for m = 21, 40 do
			local v18 = lrotate(v12, 5) + bxor(v13, v14, v15) + 1859775393 + v1[m] + v11
			v11, v12, v13, v14, v15 = v15, v18, v12, rrotate(v13, 2), v14
		end
		for i2 = 41, 60 do
			local v20 = lrotate(v12, 5) + band(v15, v14) + band(v13, (bxor(v15, v14))) + 2400959708 + v1[i2] + v11
			v11, v12, v15, v14, v13 = v15, v20, v14, rrotate(v13, 2), v12
		end
		for i2 = 61, 80 do
			local v22 = lrotate(v12, 5) + bxor(v13, v14, v15) + 3395469782 + v1[i2] + v11
			v11, v12, v13, v14, v15 = v15, v22, v12, rrotate(v13, 2), v14
		end
		v5 = (v15 + v5) % 4294967296
		v6 = (v11 + v6) % 4294967296
		v2 = (v12 + v2) % 4294967296
		v3 = (v13 + v3) % 4294967296
		v4 = (v14 + v4) % 4294967296
	end
	p1[1] = v2
	p1[2] = v3
	p1[3] = v4
	p1[4] = v5
	p1[5] = v6
end
local function keccak_feed(p1, p2, p3, p4, p5, p6)
	local v1 = t5
	local v2 = t6
	local v3 = p6 / 8
	for i = p4, p4 + p5 - 1, p6 do
		local sum = i
		for j = 1, v3 do
			local v4, v5, v6, v7 = string.byte(p3, sum + 1, sum + 4)
			p1[j] = bxor(p1[j], ((v7 * 256 + v6) * 256 + v5) * 256 + v4)
			sum = sum + 8
			local v8, v9, v10, v11 = string.byte(p3, sum - 3, sum)
			p2[j] = bxor(p2[j], ((v11 * 256 + v10) * 256 + v9) * 256 + v8)
		end
		local v12 = p1[1]
		local v13 = p2[1]
		local v14 = p1[2]
		local v15 = p2[2]
		local v16 = p1[3]
		local v17 = p2[3]
		local v18 = p1[4]
		local v19 = p2[4]
		local v20 = p1[5]
		local v21 = p2[5]
		local v22 = p1[6]
		local v23 = p2[6]
		local v24 = p1[7]
		local v25 = p2[7]
		local v26 = p1[8]
		local v27 = p2[8]
		local v28 = p1[9]
		local v29 = p2[9]
		local v30 = p1[10]
		local v31 = p2[10]
		local v32 = p1[11]
		local v33 = p2[11]
		local v34 = p1[12]
		local v35 = p2[12]
		local v36 = p1[13]
		local v37 = p2[13]
		local v38 = p1[14]
		local v39 = p2[14]
		local v40 = p1[15]
		local v41 = p2[15]
		local v42 = p1[16]
		local v43 = p2[16]
		local v44 = p1[17]
		local v45 = p2[17]
		local v46 = p1[18]
		local v47 = p2[18]
		local v48 = p1[19]
		local v49 = p2[19]
		local v50 = p1[20]
		local v51 = p2[20]
		local v52 = p1[21]
		local v53 = p2[21]
		local v54 = p1[22]
		local v55 = p2[22]
		local v56 = p1[23]
		local v57 = p2[23]
		local v58 = p1[24]
		local v59 = p2[24]
		local v60 = p1[25]
		local v61 = p2[25]
		for k = 1, 24 do
			local v62 = bxor(v12, v22, v32, v42, v52)
			local v63 = bxor(v13, v23, v33, v43, v53)
			local v64 = bxor(v14, v24, v34, v44, v54)
			local v65 = bxor(v15, v25, v35, v45, v55)
			local v66 = bxor(v16, v26, v36, v46, v56)
			local v67 = bxor(v17, v27, v37, v47, v57)
			local v68 = bxor(v18, v28, v38, v48, v58)
			local v69 = bxor(v19, v29, v39, v49, v59)
			local v70 = bxor(v20, v30, v40, v50, v60)
			local v71 = bxor(v21, v31, v41, v51, v61)
			local v72 = bxor(v62, v66 * 2 + (v67 % 4294967296 - v67 % 2147483648) / 2147483648)
			local v73 = bxor(v63, v67 * 2 + (v66 % 4294967296 - v66 % 2147483648) / 2147483648)
			local v74 = bxor(v72, v14)
			local v75 = bxor(v73, v15)
			local v76 = bxor(v72, v24)
			local v77 = bxor(v73, v25)
			local v78 = bxor(v72, v34)
			local v79 = bxor(v73, v35)
			local v80 = bxor(v72, v44)
			local v81 = bxor(v73, v45)
			local v82 = bxor(v72, v54)
			local v83 = bxor(v73, v55)
			local v84 = (v76 % 4294967296 - v76 % 1048576) / 1048576 + v77 * 4096
			local v85 = (v77 % 4294967296 - v77 % 1048576) / 1048576 + v76 * 4096
			local v86 = (v80 % 4294967296 - v80 % 524288) / 524288 + v81 * 8192
			local v87 = (v81 % 4294967296 - v81 % 524288) / 524288 + v80 * 8192
			local v88 = v74 * 2 + (v75 % 4294967296 - v75 % 2147483648) / 2147483648
			local v89 = v75 * 2 + (v74 % 4294967296 - v74 % 2147483648) / 2147483648
			local v90 = v78 * 1024 + (v79 % 4294967296 - v79 % 4194304) / 4194304
			local v91 = v79 * 1024 + (v78 % 4294967296 - v78 % 4194304) / 4194304
			local v92 = v82 * 4 + (v83 % 4294967296 - v83 % 1073741824) / 1073741824
			local v93 = v83 * 4 + (v82 % 4294967296 - v82 % 1073741824) / 1073741824
			local v94 = bxor(v64, v68 * 2 + (v69 % 4294967296 - v69 % 2147483648) / 2147483648)
			local v95 = bxor(v65, v69 * 2 + (v68 % 4294967296 - v68 % 2147483648) / 2147483648)
			local v96 = bxor(v94, v16)
			local v97 = bxor(v95, v17)
			local v98 = bxor(v94, v26)
			local v99 = bxor(v95, v27)
			local v100 = bxor(v94, v36)
			local v101 = bxor(v95, v37)
			local v102 = bxor(v94, v46)
			local v103 = bxor(v95, v47)
			local v104 = bxor(v94, v56)
			local v105 = bxor(v95, v57)
			local v106 = (v100 % 4294967296 - v100 % 2097152) / 2097152 + v101 * 2048
			local v107 = (v101 % 4294967296 - v101 % 2097152) / 2097152 + v100 * 2048
			local v108 = (v104 % 4294967296 - v104 % 8) / 8 + v105 * 536870912 % 4294967296
			local v109 = (v105 % 4294967296 - v105 % 8) / 8 + v104 * 536870912 % 4294967296
			local v110 = v98 * 64 + (v99 % 4294967296 - v99 % 67108864) / 67108864
			local v111 = v99 * 64 + (v98 % 4294967296 - v98 % 67108864) / 67108864
			local v112 = v102 * 32768 + (v103 % 4294967296 - v103 % 131072) / 131072
			local v113 = v103 * 32768 + (v102 % 4294967296 - v102 % 131072) / 131072
			local v114 = (v96 % 4294967296 - v96 % 4) / 4 + v97 * 1073741824 % 4294967296
			local v115 = (v97 % 4294967296 - v97 % 4) / 4 + v96 * 1073741824 % 4294967296
			local v116 = bxor(v66, v70 * 2 + (v71 % 4294967296 - v71 % 2147483648) / 2147483648)
			local v117 = bxor(v67, v71 * 2 + (v70 % 4294967296 - v70 % 2147483648) / 2147483648)
			local v118 = bxor(v116, v18)
			local v119 = bxor(v117, v19)
			local v120 = bxor(v116, v28)
			local v121 = bxor(v117, v29)
			local v122 = bxor(v116, v38)
			local v123 = bxor(v117, v39)
			local v124 = bxor(v116, v48)
			local v125 = bxor(v117, v49)
			local v126 = bxor(v116, v58)
			local v127 = bxor(v117, v59)
			local v128 = v124 * 2097152 % 4294967296 + (v125 % 4294967296 - v125 % 2048) / 2048
			local v129 = v125 * 2097152 % 4294967296 + (v124 % 4294967296 - v124 % 2048) / 2048
			local v130 = v118 * 268435456 % 4294967296 + (v119 % 4294967296 - v119 % 16) / 16
			local v131 = v119 * 268435456 % 4294967296 + (v118 % 4294967296 - v118 % 16) / 16
			local v132 = v122 * 33554432 % 4294967296 + (v123 % 4294967296 - v123 % 128) / 128
			local v133 = v123 * 33554432 % 4294967296 + (v122 % 4294967296 - v122 % 128) / 128
			local v134 = (v126 % 4294967296 - v126 % 256) / 256 + v127 * 16777216 % 4294967296
			local v135 = (v127 % 4294967296 - v127 % 256) / 256 + v126 * 16777216 % 4294967296
			local v136 = (v120 % 4294967296 - v120 % 512) / 512 + v121 * 8388608 % 4294967296
			local v137 = (v121 % 4294967296 - v121 % 512) / 512 + v120 * 8388608 % 4294967296
			local v138 = bxor(v68, v62 * 2 + (v63 % 4294967296 - v63 % 2147483648) / 2147483648)
			local v139 = bxor(v69, v63 * 2 + (v62 % 4294967296 - v62 % 2147483648) / 2147483648)
			local v140 = bxor(v138, v20)
			local v141 = bxor(v139, v21)
			local v142 = bxor(v138, v30)
			local v143 = bxor(v139, v31)
			local v144 = bxor(v138, v40)
			local v145 = bxor(v139, v41)
			local v146 = bxor(v138, v50)
			local v147 = bxor(v139, v51)
			local v148 = bxor(v138, v60)
			local v149 = bxor(v139, v61)
			local v150 = v148 * 16384 + (v149 % 4294967296 - v149 % 262144) / 262144
			local v151 = v149 * 16384 + (v148 % 4294967296 - v148 % 262144) / 262144
			local v152 = v142 * 1048576 % 4294967296 + (v143 % 4294967296 - v143 % 4096) / 4096
			local v153 = v143 * 1048576 % 4294967296 + (v142 % 4294967296 - v142 % 4096) / 4096
			local v154 = v146 * 256 + (v147 % 4294967296 - v147 % 16777216) / 16777216
			local v155 = v147 * 256 + (v146 % 4294967296 - v146 % 16777216) / 16777216
			local v156 = v140 * 134217728 % 4294967296 + (v141 % 4294967296 - v141 % 32) / 32
			local v157 = v141 * 134217728 % 4294967296 + (v140 % 4294967296 - v140 % 32) / 32
			local v158 = (v144 % 4294967296 - v144 % 33554432) / 33554432 + v145 * 128
			local v159 = (v145 % 4294967296 - v145 % 33554432) / 33554432 + v144 * 128
			local v160 = bxor(v70, v64 * 2 + (v65 % 4294967296 - v65 % 2147483648) / 2147483648)
			local v161 = bxor(v71, v65 * 2 + (v64 % 4294967296 - v64 % 2147483648) / 2147483648)
			local v162 = bxor(v160, v22)
			local v163 = bxor(v161, v23)
			local v164 = bxor(v160, v32)
			local v165 = bxor(v161, v33)
			local v166 = bxor(v160, v42)
			local v167 = bxor(v161, v43)
			local v168 = bxor(v160, v52)
			local v169 = bxor(v161, v53)
			local v170 = v164 * 8 + (v165 % 4294967296 - v165 % 536870912) / 536870912
			local v171 = v165 * 8 + (v164 % 4294967296 - v164 % 536870912) / 536870912
			local v172 = v168 * 262144 + (v169 % 4294967296 - v169 % 16384) / 16384
			local v173 = v169 * 262144 + (v168 % 4294967296 - v168 % 16384) / 16384
			local v174 = (v162 % 4294967296 - v162 % 268435456) / 268435456 + v163 * 16
			local v175 = (v163 % 4294967296 - v163 % 268435456) / 268435456 + v162 * 16
			local v176 = (v166 % 4294967296 - v166 % 8388608) / 8388608 + v167 * 512
			local v177 = (v167 % 4294967296 - v167 % 8388608) / 8388608 + v166 * 512
			local v178 = bxor(v160, v12)
			local v179 = bxor(v161, v13)
			local v180 = bxor(v178, (band(-1 - v84, v106)))
			local v181 = bxor(v84, (band(-1 - v106, v128)))
			local v182 = bxor(v106, (band(-1 - v128, v150)))
			local v183 = bxor(v128, (band(-1 - v150, v178)))
			local v184 = bxor(v150, (band(-1 - v178, v84)))
			local v185 = bxor(v179, (band(-1 - v85, v107)))
			local v186 = bxor(v85, (band(-1 - v107, v129)))
			local v187 = bxor(v107, (band(-1 - v129, v151)))
			local v188 = bxor(v129, (band(-1 - v151, v179)))
			local v189 = bxor(v151, (band(-1 - v179, v85)))
			local v190 = bxor(v130, (band(-1 - v152, v170)))
			local v191 = bxor(v152, (band(-1 - v170, v86)))
			local v192 = bxor(v170, (band(-1 - v86, v108)))
			local v193 = bxor(v86, (band(-1 - v108, v130)))
			local v194 = bxor(v108, (band(-1 - v130, v152)))
			local v195 = bxor(v131, (band(-1 - v153, v171)))
			local v196 = bxor(v153, (band(-1 - v171, v87)))
			local v197 = bxor(v171, (band(-1 - v87, v109)))
			local v198 = bxor(v87, (band(-1 - v109, v131)))
			local v199 = bxor(v109, (band(-1 - v131, v153)))
			local v200 = bxor(v88, (band(-1 - v110, v132)))
			local v201 = bxor(v110, (band(-1 - v132, v154)))
			local v202 = bxor(v132, (band(-1 - v154, v172)))
			local v203 = bxor(v154, (band(-1 - v172, v88)))
			local v204 = bxor(v172, (band(-1 - v88, v110)))
			local v205 = bxor(v89, (band(-1 - v111, v133)))
			local v206 = bxor(v111, (band(-1 - v133, v155)))
			local v207 = bxor(v133, (band(-1 - v155, v173)))
			local v208 = bxor(v155, (band(-1 - v173, v89)))
			local v209 = bxor(v173, (band(-1 - v89, v111)))
			local v210 = bxor(v156, (band(-1 - v174, v90)))
			local v211 = bxor(v174, (band(-1 - v90, v112)))
			local v212 = bxor(v90, (band(-1 - v112, v134)))
			local v213 = bxor(v112, (band(-1 - v134, v156)))
			local v214 = bxor(v134, (band(-1 - v156, v174)))
			local v215 = bxor(v157, (band(-1 - v175, v91)))
			local v216 = bxor(v175, (band(-1 - v91, v113)))
			local v217 = bxor(v91, (band(-1 - v113, v135)))
			local v218 = bxor(v113, (band(-1 - v135, v157)))
			local v219 = bxor(v135, (band(-1 - v157, v175)))
			local v220 = bxor(v114, (band(-1 - v136, v158)))
			local v221 = bxor(v136, (band(-1 - v158, v176)))
			local v222 = bxor(v158, (band(-1 - v176, v92)))
			local v223 = bxor(v176, (band(-1 - v92, v114)))
			local v224 = bxor(v92, (band(-1 - v114, v136)))
			local v225 = bxor(v115, (band(-1 - v137, v159)))
			local v226 = bxor(v137, (band(-1 - v159, v177)))
			local v227 = bxor(v159, (band(-1 - v177, v93)))
			local v228 = bxor(v177, (band(-1 - v93, v115)))
			local v229 = bxor(v93, (band(-1 - v115, v137)))
			local v230 = bxor(v180, v1[k])
			v13 = v185 + v2[k]
			v55, v36, v46, v56, v37, v47, v57, v38, v48, v58, v39, v49, v59, v40, v50, v15, v25, v16, v26, v17, v27, v33, v14, v24, v12, v22, v32, v29, v20, v30, v60, v41, v51, v61, v21, v31, v19, v23, v18, v28, v43, v53, v34, v42, v52, v44, v54, v35, v45 = v226, v202, v212, v222, v207, v217, v227, v203, v213, v223, v208, v218, v228, v204, v214, v186, v196, v182, v192, v187, v197, v205, v181, v191, v230, v190, v200, v198, v184, v194, v224, v209, v219, v229, v189, v199, v188, v195, v183, v193, v215, v225, v201, v210, v220, v211, v221, v206, v216
		end
		p1[1] = v12
		p2[1] = v13
		p1[2] = v14
		p2[2] = v15
		p1[3] = v16
		p2[3] = v17
		p1[4] = v18
		p2[4] = v19
		p1[5] = v20
		p2[5] = v21
		p1[6] = v22
		p2[6] = v23
		p1[7] = v24
		p2[7] = v25
		p1[8] = v26
		p2[8] = v27
		p1[9] = v28
		p2[9] = v29
		p1[10] = v30
		p2[10] = v31
		p1[11] = v32
		p2[11] = v33
		p1[12] = v34
		p2[12] = v35
		p1[13] = v36
		p2[13] = v37
		p1[14] = v38
		p2[14] = v39
		p1[15] = v40
		p2[15] = v41
		p1[16] = v42
		p2[16] = v43
		p1[17] = v44
		p2[17] = v45
		p1[18] = v46
		p2[18] = v47
		p1[19] = v48
		p2[19] = v49
		p1[20] = v50
		p2[20] = v51
		p1[21] = v52
		p2[21] = v53
		p1[22] = v54
		p2[22] = v55
		p1[23] = v56
		p2[23] = v57
		p1[24] = v58
		p2[24] = v59
		p1[25] = v60
		p2[25] = v61
	end
end
local function mul(p1, p2, p3, p4)
	local v2, sum, sum_2, v3 = 1, 0, 0, table.create(p4)
	for i = 1, p4 do
		for j = math.max(1, i + 1 - #p2), math.min(i, #p1) do
			sum_2 = sum_2 + p3 * p1[j] * p2[i + 1 - j]
		end
		local v4 = sum_2 % 16777216
		v3[i] = math.floor(v4)
		v2 = v2 * 16777216
		sum = sum + v4 * v2
		sum_2 = (sum_2 - v4) / 16777216
	end
	return v3, sum
end
local sum, v1, v2, v3, v4, _2, v5, v6, count, v7 = 4, { 4, 1, 2, -2, 2 }, {
	[384] = {},
	[512] = t4
}, {
	[384] = {},
	[512] = t3
}, {
	[224] = {},
	[256] = t4
}, { 1732584193, 4023233417, 2562383102, 271733878, 3285377520 }, t3, { 1 }, 0, t4
sum = sum + v1[sum % 6]
local sum_2 = 1
repeat
	sum_2 = sum_2 + v1[sum_2 % 6]
	if sum < sum_2 * sum_2 then
		local v8 = sum ^ 0.3333333333333333
		local v9 = mul(table.create(1, (math.floor(v8 * 1099511627776))), v6, 1, 2)
		local _3, v10 = mul(v9, mul(v9, v9, 1, 4), -1, 4)
		local v13 = v9[2] % 65536 * 65536 + math.floor(v9[1] / 256)
		local v14 = v9[1] % 256 * 16777216 + math.floor(v10 * 4.625929269271485e-18 * v8 / sum)
		if count < 16 then
			local v15 = math.sqrt(sum)
			local v16 = mul(table.create(1, (math.floor(v15 * 1099511627776))), v6, 1, 2)
			local _4, v17 = mul(v16, v16, -1, 2)
			local v20 = v16[2] % 65536 * 65536 + math.floor(v16[1] / 256)
			local v21 = v16[1] % 256 * 16777216 + math.floor(v17 * 7.62939453125e-6 / v15)
			local v22 = count % 8 + 1
			v4[224][v22] = v21
			v7[v22] = v20
			v5[v22] = v21 + v20 * 0
			if v22 > 7 then
				v7 = v2[384]
				v5 = v3[384]
			end
		end
		count = count + 1
		t2[count] = v13
		t[count] = v14 % 4294967296 + v13 * 0
	end
until sum % sum_2 == 0
