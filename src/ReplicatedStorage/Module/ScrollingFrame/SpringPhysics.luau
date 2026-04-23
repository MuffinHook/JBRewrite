local t = {}
local cos = math.cos
local sin = math.sin
local v1 = tick
local v2 = Vector3.new
t.Spring = {}
t.NumberSpring = {}
t.VectorSpring = {}
local function New(p1) --[[ Line: 12 | Upvalues: v1 (copy), cos (copy), sin (copy) ]]
	local v12 = v1()
	local v2 = p1 or 0
	local v3 = p1 or 0
	local v4 = p1 and 0 * p1 or 0
	local v5 = 1
	local v6 = 1
	local v7 = nil
	local function PositionVelocity(p1) --[[ Line: 22 | Upvalues: v12 (ref), v3 (ref), v2 (ref), v6 (ref), v5 (ref), v4 (ref), cos (ref), sin (ref) ]]
		local v1 = p1 - v12
		local v22 = v3 - v2
		if v6 == 0 then
			return v3, 0
		elseif v5 < 1 then
			local v32 = (1 - v5 * v5) ^ 0.5
			local v42 = (v4 / v6 + v5 * v22) / v32
			local v52 = cos(v32 * v6 * v1)
			local v62 = sin(v32 * v6 * v1)
			local v7 = 2.718281828459045 ^ (v5 * v6 * v1)
			return v2 + (v22 * v52 + v42 * v62) / v7, v6 * ((v32 * v42 - v5 * v22) * v52 - (v32 * v22 + v5 * v42) * v62) / v7
		else
			local v8 = v4 / v6 + v22
			local v9 = 2.718281828459045 ^ (v6 * v1)
			return v2 + (v22 + v8 * v6 * v1) / v9, v6 * (v8 - v22 - v8 * v6 * v1) / v9
		end
	end
	v7 = setmetatable({
		Impulse = function(p1, p2) --[[ Name: Impulse | Line: 42 | Upvalues: v7 (ref) ]]
			v7.Velocity = v7.Velocity + p2
		end,
		TimeSkip = function(p1, p2) --[[ Name: TimeSkip | Line: 45 | Upvalues: v1 (ref), PositionVelocity (copy), v3 (ref), v4 (ref), v12 (ref) ]]
			local v13 = v1()
			local v2, v32 = PositionVelocity(v13 + p2)
			v3 = v2
			v4 = v32
			v12 = v13
		end
	}, {
		__index = function(p1, p2) --[[ Name: __index | Line: 53 | Upvalues: PositionVelocity (copy), v1 (ref), v2 (ref), v5 (ref), v6 (ref) ]]
			if p2 == "Value" or (p2 == "Position" or p2 == "p") then
				local v12, _ = PositionVelocity(v1())
				return v12
			end
			if p2 == "Velocity" or p2 == "v" then
				local _, v22 = PositionVelocity(v1())
				return v22
			end
			if p2 == "Target" or p2 == "t" then
				return v2
			end
			if p2 == "Damper" or p2 == "d" then
				return v5
			end
			if p2 == "Speed" or p2 == "s" then
				return v6
			end
			error(p2 .. " is not a valid member of Spring")
		end,
		__newindex = function(p1, p2, p3) --[[ Name: __newindex | Line: 70 | Upvalues: v1 (ref), PositionVelocity (copy), v3 (ref), v4 (ref), v2 (ref), v5 (ref), v6 (ref), v12 (ref) ]]
			local v13 = v1()
			if p2 == "Value" or (p2 == "Position" or p2 == "p") then
				local _, v22 = PositionVelocity(v13)
				v3 = p3
				v4 = v22
			elseif p2 == "Velocity" or p2 == "v" then
				local v32, _ = PositionVelocity(v13)
				v3 = v32
				v4 = p3
			elseif p2 == "Target" or p2 == "t" then
				local v42, v52 = PositionVelocity(v13)
				v3 = v42
				v4 = v52
				v2 = p3
			elseif p2 == "Damper" or p2 == "d" then
				local v62, v7 = PositionVelocity(v13)
				v3 = v62
				v4 = v7
				v5 = if p3 < 0 then 0 elseif p3 < 1 then p3 else 1
			elseif p2 == "Speed" or p2 == "s" then
				local v9, v10 = PositionVelocity(v13)
				v3 = v9
				v4 = v10
				v6 = if p3 < 0 then 0 else p3
			else
				error(p2 .. " is not a valid member of Spring")
			end
			v12 = v13
		end
	})
	return v7
end
t.Spring.New = New
local function New_2(p1) --[[ Line: 98 | Upvalues: t (copy) ]]
	return t.Spring.New(p1)
end
t.NumberSpring.New = New_2
local function New_3(p1) --[[ Line: 102 | Upvalues: t (copy), v2 (copy) ]]
	return t.Spring.New(p1 or v2())
end
t.VectorSpring.New = New_3
return t