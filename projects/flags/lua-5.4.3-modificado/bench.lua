--[[
Esse benchmark é uma fusão de vários programas usados no
 The Computer Language Benchmarks Game

Todo o crédito é de seus devidos autores.

Segue licensa dos códigos:

Revised BSD license
This is a specific instance of the Open Source Initiative
 (OSI) BSD license template.

Copyright © 2004-2008 Brent Fulgham, 2005-2021 Isaac Gouy

All rights reserved.

Redistribution and use in source and binary forms, with or
 without modification, are permitted provided that the
 following conditions are met:

- Redistributions of source code must retain the above
 copyright notice, this list of conditions and the
 following disclaimer.

- Redistributions in binary form must reproduce the above
 copyright notice, this list of conditions and the following
 disclaimer in the documentation and/or other materials
 provided with the distribution.

- Neither the name "The Computer Language Benchmarks Game"
 nor the name "The Benchmarks Game" nor the name
 "The Computer Language Shootout Benchmarks" nor the names
 of its contributors may be used to endorse or promote products
 derived from this software without specific prior written
 permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE. 
]]


print("task 1/4: Fannkuchredux")

-- https://benchmarksgame-team.pages.debian.net/benchmarksgame/program/fannkuchredux-lua-1.html

-- The Computer Language Benchmarks Game
-- https://salsa.debian.org/benchmarksgame-team/benchmarksgame/
-- contributed by Mike Pall

local function fannkuch(n)
  local p, q, s, sign, maxflips, sum = {}, {}, {}, 1, 0, 0
  for i=1,n do p[i] = i; q[i] = i; s[i] = i end
  repeat
    -- Copy and flip.
    local q1 = p[1]				-- Cache 1st element.
    if q1 ~= 1 then
      for i=2,n do q[i] = p[i] end		-- Work on a copy.
      local flips = 1
      repeat
	local qq = q[q1]
	if qq == 1 then				-- ... until 1st element is 1.
	  sum = sum + sign*flips
	  if flips > maxflips then maxflips = flips end -- New maximum?
	  break
	end
	q[q1] = q1
	if q1 >= 4 then
	  local i, j = 2, q1 - 1
	  repeat q[i], q[j] = q[j], q[i]; i = i + 1; j = j - 1; until i >= j
	end
	q1 = qq; flips = flips + 1
      until false
    end
    -- Permute.
    if sign == 1 then
      p[2], p[1] = p[1], p[2]; sign = -1	-- Rotate 1<-2.
    else
      p[2], p[3] = p[3], p[2]; sign = 1		-- Rotate 1<-2 and 1<-2<-3.
      for i=3,n do
	local sx = s[i]
	if sx ~= 1 then s[i] = sx-1; break end
	if i == n then return sum, maxflips end	-- Out of permutations.
	s[i] = i
	-- Rotate 1<-...<-i+1.
	local t = p[1]; for j=1,i do p[j] = p[j+1] end; p[i+1] = t
      end
    end
  until false
end

local n = 10 -- tonumber(arg and arg[1]) or 1
local sum, flips = fannkuch(n)
io.write(sum, "\nPfannkuchen(", n, ") = ", flips, "\n")

-- EOT

print("task 2/4: Spectral Norm")

-- https://benchmarksgame-team.pages.debian.net/benchmarksgame/program/spectralnorm-lua-1.html

-- The Computer Language Benchmarks Game
-- https://salsa.debian.org/benchmarksgame-team/benchmarksgame/
-- contributed by Mike Pall

local function A(i, j)
  local ij = i+j-1
  return 1.0 / (ij * (ij-1) * 0.5 + i)
end

local function Av(x, y, N)
  for i=1,N do
    local a = 0
    for j=1,N do a = a + x[j] * A(i, j) end
    y[i] = a
  end
end

local function Atv(x, y, N)
  for i=1,N do
    local a = 0
    for j=1,N do a = a + x[j] * A(j, i) end
    y[i] = a
  end
end

local function AtAv(x, y, t, N)
  Av(x, t, N)
  Atv(t, y, N)
end

local N = 1000 -- tonumber(arg and arg[1]) or 100
local u, v, t = {}, {}, {}
for i=1,N do u[i] = 1 end

for i=1,10 do AtAv(u, v, t, N) AtAv(v, u, t, N) end

local vBv, vv = 0, 0
for i=1,N do
  local ui, vi = u[i], v[i]
  vBv = vBv + ui*vi
  vv = vv + vi*vi
end
io.write(string.format("%0.9f\n", math.sqrt(vBv / vv)))

-- EOT

print("task 3/4: Mandelbrot")

-- https://benchmarksgame-team.pages.debian.net/benchmarksgame/program/mandelbrot-lua-1.html

-- The Computer Language Benchmarks Game
-- https://salsa.debian.org/benchmarksgame-team/benchmarksgame/
-- contributed by Mike Pall
-- Updated for Lua 5.3 by Robin

local write, char, unpack = io.write, string.char, table.unpack
local N = 2000 -- tonumber(arg and arg[1]) or 100
local M, ba, bb, buf = 2/N, 2^(N%8+1)-1, 2^(8-N%8), {}
--write("P4\n", N, " ", N, "\n")
for y=0,N-1 do
  local Ci, b, p = y*M-1, 1, 0
  for x=0,N-1 do
    local Cr = x*M-1.5
    local Zr, Zi, Zrq, Ziq = Cr, Ci, Cr*Cr, Ci*Ci
    b = b + b
    for i=1,49 do
      Zi = Zr*Zi*2 + Ci
      Zr = Zrq-Ziq + Cr
      Ziq = Zi*Zi
      Zrq = Zr*Zr
      if Zrq+Ziq > 4.0 then b = b + 1; break; end
    end
    if b >= 256 then p = p + 1; buf[p] = 511 - b; b = 1; end
  end
  if b ~= 1 then p = p + 1; buf[p] = (ba-b)*bb; end
  --write(char(unpack(buf, 1, p)))
end

-- EOT

print("task 4/4: N-body")

-- https://benchmarksgame-team.pages.debian.net/benchmarksgame/program/nbody-lua-4.html

-- The Computer Language Benchmarks Game
-- https://salsa.debian.org/benchmarksgame-team/benchmarksgame/
-- contributed by Mike Pall
-- modified by Geoff Leyland
-- modified by Mario Pernici

sun = {}
jupiter = {}
saturn = {}
uranus = {}
neptune = {}

local sqrt = math.sqrt

local PI = 3.141592653589793
local SOLAR_MASS = 4 * PI * PI
local DAYS_PER_YEAR = 365.24
sun.x = 0.0
sun.y = 0.0
sun.z = 0.0
sun.vx = 0.0
sun.vy = 0.0
sun.vz = 0.0
sun.mass = SOLAR_MASS
jupiter.x = 4.84143144246472090e+00
jupiter.y = -1.16032004402742839e+00
jupiter.z = -1.03622044471123109e-01
jupiter.vx = 1.66007664274403694e-03 * DAYS_PER_YEAR
jupiter.vy = 7.69901118419740425e-03 * DAYS_PER_YEAR
jupiter.vz = -6.90460016972063023e-05 * DAYS_PER_YEAR
jupiter.mass = 9.54791938424326609e-04 * SOLAR_MASS
saturn.x = 8.34336671824457987e+00
saturn.y = 4.12479856412430479e+00
saturn.z = -4.03523417114321381e-01
saturn.vx = -2.76742510726862411e-03 * DAYS_PER_YEAR
saturn.vy = 4.99852801234917238e-03 * DAYS_PER_YEAR
saturn.vz = 2.30417297573763929e-05 * DAYS_PER_YEAR
saturn.mass = 2.85885980666130812e-04 * SOLAR_MASS
uranus.x = 1.28943695621391310e+01
uranus.y = -1.51111514016986312e+01
uranus.z = -2.23307578892655734e-01
uranus.vx = 2.96460137564761618e-03 * DAYS_PER_YEAR
uranus.vy = 2.37847173959480950e-03 * DAYS_PER_YEAR
uranus.vz = -2.96589568540237556e-05 * DAYS_PER_YEAR
uranus.mass = 4.36624404335156298e-05 * SOLAR_MASS
neptune.x = 1.53796971148509165e+01
neptune.y = -2.59193146099879641e+01
neptune.z = 1.79258772950371181e-01
neptune.vx = 2.68067772490389322e-03 * DAYS_PER_YEAR
neptune.vy = 1.62824170038242295e-03 * DAYS_PER_YEAR
neptune.vz = -9.51592254519715870e-05 * DAYS_PER_YEAR
neptune.mass = 5.15138902046611451e-05 * SOLAR_MASS

local bodies = {sun,jupiter,saturn,uranus,neptune}

local function advance(bodies, nbody, dt)
  for i=1,nbody do
    local bi = bodies[i]
    local bix, biy, biz, bimass = bi.x, bi.y, bi.z, bi.mass
    local bivx, bivy, bivz = bi.vx, bi.vy, bi.vz
    for j=i+1,nbody do
      local bj = bodies[j]
      local dx, dy, dz = bix-bj.x, biy-bj.y, biz-bj.z
      local dist2 = dx*dx + dy*dy + dz*dz
      local mag = sqrt(dist2)
      mag = dt / (mag * dist2)
      local bm = bj.mass*mag
      bivx = bivx - (dx * bm)
      bivy = bivy - (dy * bm)
      bivz = bivz - (dz * bm)
      bm = bimass*mag
      bj.vx = bj.vx + (dx * bm)
      bj.vy = bj.vy + (dy * bm)
      bj.vz = bj.vz + (dz * bm)
    end
    bi.vx = bivx
    bi.vy = bivy
    bi.vz = bivz
    bi.x = bix + dt * bivx
    bi.y = biy + dt * bivy
    bi.z = biz + dt * bivz
  end
end

local function energy(bodies, nbody)
  local e = 0
  for i=1,nbody do
    local bi = bodies[i]
    local vx, vy, vz, bim = bi.vx, bi.vy, bi.vz, bi.mass
    e = e + (0.5 * bim * (vx*vx + vy*vy + vz*vz))
    for j=i+1,nbody do
      local bj = bodies[j]
      local dx, dy, dz = bi.x-bj.x, bi.y-bj.y, bi.z-bj.z
      local distance = sqrt(dx*dx + dy*dy + dz*dz)
      e = e - ((bim * bj.mass) / distance)
    end
  end
  return e
end

local function offsetMomentum(b, nbody)
  local px, py, pz = 0, 0, 0
  for i=1,nbody do
    local bi = b[i]
    local bim = bi.mass
    px = px + (bi.vx * bim)
    py = py + (bi.vy * bim)
    pz = pz + (bi.vz * bim)
  end
  b[1].vx = -px / SOLAR_MASS
  b[1].vy = -py / SOLAR_MASS
  b[1].vz = -pz / SOLAR_MASS
end

local N = 10000-- tonumber(arg and arg[1]) or 1000
local nbody = #bodies

offsetMomentum(bodies, nbody)
io.write( string.format("%0.9f",energy(bodies, nbody)), "\n")
for i=1,N do advance(bodies, nbody, 0.01) end
io.write( string.format("%0.9f",energy(bodies, nbody)), "\n")
    

-- EOT

print("benchmark complete!")