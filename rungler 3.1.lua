--- Rungler for Crow v 3.1 //////// Imminent gloom
--  The rungler is designed by Rob Hordijk and is described here:
--  https://electro-music.com/forum/topic-38081.html

--      Input 1: Clock
--      Input 2: Data to be sampled into the shift-registers.
--               Converts to binary at 0v by default or at 5v if
--               the last 256 values sampled are below zero.
--               This allows both VCOs and function generators
--               to provide data without extra modules.
--  Outputs 1-3: Analog shift register with 3 steps
--     Output 4: 3-bit DAC reading the last steps of the digital shift register
--               (the Rungler!)

a = {}
c = {}
d = {}
s = 'none' -- or fill a {} with pretty numbers to quantize
sum = 0

function rotate(t, l)
  table.insert(t, 1, t[l])
  table.remove(t, l)
end

function check_input()
  sum = 0
  for n = 1, 256 do sum = sum + c[n] end
  return sum
end

function init()
  input[1].mode ('change', 1, 0.1, 'rising')
  for n = 1, 3 do output[n].scale = s end
  for n = 1, 8 do a[n] = 0.0 end
  for n = 1, 256 do c[n] = 0 end
  for n = 1, 8 do d[n] = 0 end
end

input[1].change = function()
  if check_input() == 0 then threshold = 5 else threshold = 0 end -- replace with "threshold = 0" (or 5) to disable auto adjust for bi-/unipolar data
  a[1] = input[2].volts
  c[1] = input[2].volts < 0 and 1 or 0
  d[1] = input[2].volts > threshold and 1 or 0 ~ d[8]
  output[1].volts = a[1]
  output[2].volts = a[2]
  output[3].volts = a[3]
  output[4].volts = d[6] * 4 + d[7] * 2 + d[8] * 1
  -- print(table.concat(d, " ")) -- ooh, shiney!
  rotate(a, 8)
  rotate(c, 256)
  rotate(d, 8)
end