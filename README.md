```
--- Rungler for Crow v 3.1 //////// Imminent gloom
--  The rungler is designed by Rob Hordijk and is described here:
--  https://electro-music.com/forum/topic-38081.html

--      Input 1: Clock
--      Input 2: Data to be sampled into the shift-registers.
--               Converts to binary at 0v by default or at 5v if
--               the last 256 values sampled are below zero.
--               This allows both VCOs and function generators
--               to provide data without extra modules.
--  Outputs 1-3: Analog shift register with 3 step.
--     Output 4: 3-bit DAC reading the last steps of the digital shift register
--               (the Rungler!)
```
